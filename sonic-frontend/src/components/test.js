// import React, { Component } from 'react'
// import * as d3 from "d3"
//
// const maxHeight = 400;
// const maxWidth = 600;
// const colorArray = ['#38CCCB', '#0074D9', '#2FCC40', '#FEDC00', '#FF4036'];
// function renderLines(data, legends, svg) {
//     const getX = (d) => d.date;
//     const getY = (d) => d.close;
//
//     const lineMin = (data) => d3.min(data, getY);
//     const lineMax = (data) => d3.max(data, getY);
//
//     const xScale = d3.scaleTime()
//         .domain(d3.extent(data[0], getX))
//         .range([0, maxWidth]);
//
//     const minY = d3.min(data, lineMin);
//     const maxY = d3.max(data, lineMax);
//
//     const yScale = d3.scaleLinear()
//         .domain([minY, maxY])
//         .range([maxHeight, 0]);
//
//     const line = d3.line().x((d) => xScale(getX(d))).y((d) => yScale(getY(d)))
//
//     svg.selectAll('path')
//         .data(data)
//         .enter()
//         .append('path')
//         .attr('d', (d) => {
//             const lineData = line(d);
//             return lineData;
//         })
//         .attr('stroke', (d, i) => colorArray[i % colorArray.length])
//         .attr('fill', 'none');
//
//     const axisRight = d3.axisRight(yScale);
//     svg.append('g')
//         .attr('transform', `translate(${maxWidth}, 0)`)
//         .call(axisRight);
//
//     const axisBottom = d3.axisBottom(xScale);
//     svg.append('g')
//         .attr('transform', `translate(0, ${maxHeight})`)
//         .call(axisBottom);
//
//     svg.append('g')
//         .attr('width', 500)
//         .attr('height', 30)
//         .selectAll('.legend')
//         .data(legends)
//         .enter()
//         .append('text')
//         .attr('class', 'legend')
//         .text((d) => d)
//         .attr('y', maxHeight + 50)
//         .attr('x', (d, i) => 50 + i * 100)
//         .attr('stroke', (d, i) => colorArray[i % colorArray.length])
//
// }
//
// async function getData(fileLocation) {
//     const data = await d3.csv(fileLocation, (row) => {
//         return {
//             date: new Date(row.Date),
//             close: parseFloat(row.Close),
//         };
//     });
//     return data;
// }
//
// async function render(svg) {
//     const files = ['data/AAPL.csv', 'data/INTC.csv', 'data/FB.csv', 'data/AMZN.csv', 'data/GOOG.csv']; // stock price in the recent 10 years
//     const legends = files.map((file) => {
//         const organization = /[a-zA-Z0-9]+(?=\.csv)/;
//         const searchRes = organization.exec(file);
//         return searchRes ? searchRes[0] : '';
//     });
//
//     const fetchQueue = files.map(getData);
//
//     Promise.all(fetchQueue).then((data) => renderLines(data, legends,svg));
// }
//
// class D3jsDemo extends Component {
//     constructor(props) {
//         super(props);
//         this.state = {}
//     }
//
//     componentDidMount() {
//         this.oneMethod()
//     }
//
//     oneMethod() {
//
//         const svg = d3.select('#d3js')
//             .append('svg')
//             .attr('width', maxWidth + 50)
//             .attr('height', maxHeight + 80);
//         render(svg);
//     }
//
//     render() {
//         return (
//             <div id="d3js" >
//
//             </div>
//         );
//     }
// }
//
// export default D3jsDemo;