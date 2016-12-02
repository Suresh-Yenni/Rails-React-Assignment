var Table = React.createClass({
    render(){
      return(
        <table>
            <caption>{this.props.group_id}</caption>
            <tbody>
                <tr>
                  {this.props.display.map((subject) => <th> {subject} </th>)}
                </tr>
                {this.props.student[this.props.group_id].map((object, key) => <SubjectRow
                        stu = {object}
                        display= {this.props.display}/>)}
                {console.log("look")}

                {!jQuery.isEmptyObject(this.props.total_marks)? <TotalRow
                        display= {this.props.display}
                        count = {this.props.index}
                        total_marks = {this.props.total_marks[this.props.group_id]}/> :null}
                {(this.props.group_on == "regid" && !jQuery.isEmptyObject(this.props.marks_change))? <ChangeRow
                        display= {this.props.display}
                        count = {this.props.index}
                        marks_change = {this.props.marks_change[this.props.group_id]}/> :null}
            </tbody>
        </table>);}
});
var SubjectRow = React.createClass({
    render(){
       return(
        <tr>
          {this.props.display.map((subject) => <td> {this.props.stu[subject]} </td>)}
        </tr>);}
});

var TotalRow = React.createClass({
    render(){
       return(
        <tr>
          {this.props.display.map((subject) => <td>Total = {this.props.total_marks[subject]}</td>)}
        </tr>);}
});

var ChangeRow = React.createClass({
    render(){
       return(
        <tr>
          {this.props.display.map((subject) => <td>Change = {this.props.marks_change[subject]}</td>)}
        </tr>);}
});
