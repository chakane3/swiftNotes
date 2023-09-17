# Tableviews
This is the most used component in UIKit. They are used to present an ordered list of items. The ```UITableView``` class is responsible for presenting data as a list of rows. The data being displayed is called the table view's ```data source``` object which is accessed through the dataSource property. The data source can be any object that conforms to the ```UITableViewDatasource``` protocol. The table view's data source is typically the view controller which manages the view, the table view is a subview of. <br></br>

The table view is only responsible for detecting touches in the table view. Its not responsible for responding to the touches. The table view has a ```delegate``` property. This is how we will respond to the touches. By having a data source object managing its data and a delegate object handling user interaction, the table view focuses on data presentation. A data source object is similar to a delegate object:
<ul>
    <li>Delegate Object: Is delegated control of the user interface by the delegating object.</li>
    <li>Data Source Object: Is delegated control of data</li>
</ul>

## Introduction
###### Vocabulary
<ol>
    <li>cellForRow: This is a UITableViewDataSource method to describe the cell at a specific row/section in a UITableView</li>
    <li>reuseIdentifier: String value used to specify a prototype cell in a table</li>
    <li>Protocol: This defined a blueprint of methods, properties, and other requirements that suit a particular task or functionality.</li>
    <li>Adoption/Confirming: Conforming a class to a protocol. </li>
    <li></li>
</ol>
