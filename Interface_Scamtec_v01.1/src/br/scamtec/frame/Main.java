/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.scamtec.frame;

import java.awt.Dimension;
import java.awt.Toolkit;
import java.beans.PropertyVetoException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import javax.swing.JLabel;

/**
 *
 * @author paulo.henrique
 */
public class Main extends javax.swing.JFrame {

    private JLabel jLabelLogo;
    static int totalPrev, passoPrev;
    static String endSaida;

    /**
     * Creates new form Main
     */
    public Main() {
        
        initComponents();
        logo();

    }

    private void logo() {
        Dimension dimensao = Toolkit.getDefaultToolkit().getScreenSize();
        
        jLabelLogo = new javax.swing.JLabel();
        jLabelLogo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/br/scamtec/imagens/scamtec.png")));
        int tamLogo = 746;
        //System.out.println(dimensao.width+" "+this.getWidth());
        //System.out.println(dimensao.height+" "+this.getHeight());
        
        jLabelLogo.setBounds(dimensao.width / 2 - (tamLogo / 2), 0, dimensao.width, dimensao.height);       
        telaPrincipal.add(jLabelLogo, javax.swing.JLayeredPane.DEFAULT_LAYER);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        telaPrincipal = new javax.swing.JDesktopPane();
        jMenuBar1 = new javax.swing.JMenuBar();
        jMenu1 = new javax.swing.JMenu();
        jMenuItem1 = new javax.swing.JMenuItem();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("SISTEMA COMUNITÁRIO DE AVALIAÇÕES DE MODELOS TEMPO E CLIMA (SCAMTEC)");

        telaPrincipal.setBackground(new java.awt.Color(0, 0, 204));

        jMenu1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/br/scamtec/imagens/preferences.png"))); // NOI18N
        jMenu1.setText("Arquivos");

        jMenuItem1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/br/scamtec/imagens/wrench.png"))); // NOI18N
        jMenuItem1.setText("Configurações");
        jMenuItem1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem1ActionPerformed(evt);
            }
        });
        jMenu1.add(jMenuItem1);

        jMenuBar1.add(jMenu1);

        setJMenuBar(jMenuBar1);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(telaPrincipal, javax.swing.GroupLayout.DEFAULT_SIZE, 1016, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(telaPrincipal, javax.swing.GroupLayout.DEFAULT_SIZE, 452, Short.MAX_VALUE)
        );

        java.awt.Dimension screenSize = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
        setBounds((screenSize.width-1026)/2, (screenSize.height-511)/2, 1026, 511);
    }// </editor-fold>//GEN-END:initComponents

    private void jMenuItem1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem1ActionPerformed
        ScamtecConfiguracao scamConf = new ScamtecConfiguracao();
        scamConf.setVisible(true);
        telaPrincipal.removeAll();
        logo();

        telaPrincipal.add(scamConf);
        try {
            scamConf.setMaximum(true);
        } catch (PropertyVetoException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_jMenuItem1ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Main.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Main.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Main.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Main.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                Main menu = new Main();
                try {
                    //     UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
                    menu.setExtendedState(JFrame.MAXIMIZED_BOTH);
                    menu.setVisible(true);
                } catch (Exception e) {
                    System.out.println("Não foi possível alterar a L&F: " + e.toString());
                }
            }
        });
    }
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JMenu jMenu1;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JMenuItem jMenuItem1;
    public static javax.swing.JDesktopPane telaPrincipal;
    // End of variables declaration//GEN-END:variables
}
