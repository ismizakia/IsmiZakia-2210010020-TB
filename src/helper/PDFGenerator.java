package helper;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.JTable;
import java.awt.Desktop;

public class PDFGenerator {
    
    public static void generatePDF(String title, String[] headers, JTable table, String filename) throws Exception {
        // Create PDF directory if it doesn't exist
        File directory = new File("pdf");
        if (!directory.exists()) {
            directory.mkdirs();
        }
        
        // Create full file path
        String fullPath = "pdf/" + filename;
        
        // Create document
        Document document = new Document(PageSize.A4.rotate());
        PdfWriter.getInstance(document, new FileOutputStream(fullPath));
        document.open();
        
        // Add title
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
        Paragraph titlePara = new Paragraph(title, titleFont);
        titlePara.setAlignment(Element.ALIGN_CENTER);
        titlePara.setSpacingAfter(20);
        document.add(titlePara);
        
        // Add date
        Font dateFont = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL);
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Paragraph datePara = new Paragraph("Tanggal: " + sdf.format(new Date()), dateFont);
        datePara.setSpacingAfter(20);
        document.add(datePara);
        
        // Create table
        PdfPTable pdfTable = new PdfPTable(headers.length);
        pdfTable.setWidthPercentage(100);
        
        // Add headers
        Font headerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header, headerFont));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            cell.setPadding(5);
            pdfTable.addCell(cell);
        }
        
        // Add data
        Font dataFont = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL);
        for (int row = 0; row < table.getRowCount(); row++) {
            for (int col = 0; col < headers.length; col++) {
                Object value = table.getValueAt(row, col);
                PdfPCell cell = new PdfPCell(new Phrase(value != null ? value.toString() : "", dataFont));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPadding(5);
                pdfTable.addCell(cell);
            }
        }
        
        document.add(pdfTable);
        document.close();
        
        // Open the generated PDF file
        try {
            File pdfFile = new File(fullPath);
            if (pdfFile.exists()) {
                if (Desktop.isDesktopSupported()) {
                    Desktop.getDesktop().open(pdfFile);
                } else {
                    // For systems where Desktop is not supported
                    String os = System.getProperty("os.name").toLowerCase();
                    if (os.contains("linux")) {
                        Runtime.getRuntime().exec(new String[]{"xdg-open", fullPath});
                    } else if (os.contains("mac")) {
                        Runtime.getRuntime().exec(new String[]{"open", fullPath});
                    } else {
                        Runtime.getRuntime().exec(new String[]{"cmd", "/c", fullPath});
                    }
                }
            }
        } catch (Exception e) {
            throw new Exception("Error opening PDF: " + e.getMessage());
        }
    }
}
