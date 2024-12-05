package Eternel_restaurants.View.Form.Staff_Form.WarehouseStaff;

import javax.swing.table.TableCellRenderer;

import javax.swing.*;
import javax.swing.table.DefaultTableCellRenderer;
import java.awt.*;

public class CustomTableCellRenderer extends DefaultTableCellRenderer {
    @Override
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
        Component cellComponent = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);

        if (isSelected) {
            cellComponent.setBackground(new Color(184, 207, 229));
        } else {
            if (row % 2 == 0) {
                cellComponent.setBackground(new Color(240, 240, 240));
            } else {
                cellComponent.setBackground(Color.WHITE);
            }
        }

        if (column == 2) { // Giả sử cột 2 là cột đơn giá
            setHorizontalAlignment(SwingConstants.RIGHT);
        } else {
            setHorizontalAlignment(SwingConstants.LEFT);
        }

        return cellComponent;
    }
}





