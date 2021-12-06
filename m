Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BE6469FE3
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Dec 2021 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387983AbhLFPyt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Dec 2021 10:54:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9058 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376264AbhLFPtx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Dec 2021 10:49:53 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Ewv0v011593;
        Mon, 6 Dec 2021 15:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AFD1OTqsTcW/AV+68eFku1Hy7DWqUv0BKCNYB/IRoCQ=;
 b=iM54QHdKy49ey8HbubHZsEc1DCDVaPweX95lSSSgDVY9DqdQNGPWWVOX0WPcGSq/Awow
 b2xGLG5teByUcpgECQ0eU01cqMm72/MqCrt8Pl0t9y9Ys72+3VWAfmyCs7kHLzFnLprY
 r4pxvk8l+MGstPPcNOWdyghUj8FHFUnGdJqgUvVHhRBBwjt/scTeRdS9M24qVzi6Isvi
 QAbHKbfwOoU2mCO4hsYZqU3HEgitD6sMpON0VF1VCucapEkuydI0j1EWg+aq7o4QTNEH
 F8BAaITm8ZMMnnO5JA+OvKYCdYiTr+nDCxQnTzhxHldor+jJ5ILjMjIwfwcmoWemA/rF YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwjjbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:46:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6FapJl062684;
        Mon, 6 Dec 2021 15:46:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3cr1sm949j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5Pvn7yA0keNVSH/y6i5YOmR916a8/8sUcpQek+4diEpe0HUkM3AABJeAKCuwoiq48yilZZmBnkYJ7iO5dyZLrQ13lhiKDjViOQ0vkA4BwlePxOWub/FqSLUNz5EG/GSL42h7e7OOLoQEHtPNE9eKwTD9/vNrbun1zSVjBvHieKvXr68l+qUuNGgCeM6lr7S5/gfjI4MywYfh2+smNWBQjOh++ThV7JpFDB87iOcWebmkD4vt/+iBeX0rdDAeRSbrge2XqvEQBgEbGrSiMV0jcT4OeDVUcQNSwuu2CxnQDDsAhIpXAzRsQhKGLTBE0rcG80P0dJBItColG2PF6vfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFD1OTqsTcW/AV+68eFku1Hy7DWqUv0BKCNYB/IRoCQ=;
 b=kkugIYKfrZ0E6pwK0x6ljYz7ZUfVFR/ydYjYwZGgLn+FMj7oqRV8RnZXUCWVm63cWhXhx4E1oXOvnXChrtPtlrxzQLcRRYZ8UHJtVkhNmEjxwsyPAksnLj7jvh4+2jnA4JqDoVb9FD7GEdyaANB9uxsjYbeMCthFEIJkVZYpe252kGBQ+HbsvfCZrv+PFIS4mcb0fKVzpj/03H8O1SarBVap0Xzv9Bhvbd08HngnufwK1LHovxVakoLr58vDECOy2wskIyHDPfDj1deL4FMBGTmSuNz/gfqUbqkdagXhDK2eYljqiIC/mkundw/ydmBAP9O74vv3z7HF1WWZt5vASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFD1OTqsTcW/AV+68eFku1Hy7DWqUv0BKCNYB/IRoCQ=;
 b=fLuQrUDERrn1J+vlnHQGUA5WleivPH6zjq8RoEItA4oR9UBRMCJiWCcFg/tglJKhx7wtOMIwDYV0uloi+E2AWzgdIIBikCEgarlH7JJFmOkLDimCfA5o2waqO2p7ZmnTzcb//d110s3DMszsX8TYFPg+0ElMKJMR+BVM0SQN/aM=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 15:46:03 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%9]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 15:46:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Steve Dickson <SteveD@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsdcld: use WAL journal for faster commits
Thread-Topic: [PATCH] nfsdcld: use WAL journal for faster commits
Thread-Index: AQHX6JCDa1WFhrhup0+3fBDNUtx+YKwhUyaAgAAI84CAACBd6oAADaYAgAQVgQA=
Date:   Mon, 6 Dec 2021 15:46:03 +0000
Message-ID: <57EA2D75-823E-4164-9000-E7C7C970C60B@oracle.com>
References: <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org> <20211201174205.GB26415@fieldses.org>
 <20211201180339.GC26415@fieldses.org> <20211201195050.GE26415@fieldses.org>
 <20211203212200.GB3930@fieldses.org> <20211203215531.GC3930@fieldses.org>
 <469DF1ED-C2AB-43CE-AB70-BFD2AFC2A68D@oracle.com>
 <20211203223921.GA6151@fieldses.org>
 <915221EC-387C-4F50-83C6-8DCF02DD2A5D@oracle.com>
 <20211204012402.GA7805@fieldses.org>
In-Reply-To: <20211204012402.GA7805@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02e11fab-fa64-4ec5-5b6a-08d9b8cf8267
x-ms-traffictypediagnostic: CH0PR10MB5004:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5004F2957D59B383E774EF9F936D9@CH0PR10MB5004.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6KCoPm0Ho8oVMUEombaXof8bC0fd+tdX1E8ZbMx4lVzteLoDVozm5IqBLsfYVdHJ9GEh/K10eFIwniyz0G2TKRKlGK6rv91uWznW7MX1iW+pEJqzI8j3D6dzZKB0+TFcDYPt2UqXoKBg8OBKWAYuXhZPbxEHrzaiMAZn1tyKzIRFFCXo2w3bACMrk1QDMbGbzlzf+kbWM473i8uVQILlDmHBYTeOw5/k/qjf2f/uNyoptslkvO4Bmm+OtdicUjUF+zcuV0CiqkoIS1MRAHZFS5oUZy5AaKeiSQSmzGt9yXtcFLJAtV0FvNJlLB8TyCoJ+dnkXJUyKWtaTfWX6+PDxlz11ExAUVT0dUwE1FhAIRUQRbPI/DgzsyhV9mQUNsR3ldVWQBcWr2ypTuSlahr+I6RksJsO2QarkYN88KOdO5FnOlC9QigCPryKZtdf8PvL6A6Xn7mZLJy2yPbF2a6OStp4cLlGyDx12HfX43OrFTtgr6w+neTBkSEP7DZUwYj3HJJ1i3zEnsofHcT5nub+uTmIAgqs6jldXrA2LXAZAnjJEgSwUusRpy+0kSrdC5cvieLFTWx2lEUhI3gsznac4ksvsiMkAEIdxijVlYx/U3ef5+igBYhKwWCoZciRFwHTX8mieijJX90KnvC9YBtN6rBRlC84Zc34WtH7CVG553gDoL8Kp6N+2RVuogCk4jq1O53djOHGegzHoaWYI8KklFZ2WmKmZGDtBbAcVgiI2rNGIq6ENjCGFJiQ8+JP/3+3SJUUNnuQMmbCv+CqRgDVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(6486002)(4326008)(66476007)(76116006)(6512007)(64756008)(66556008)(38070700005)(316002)(71200400001)(86362001)(66446008)(66946007)(33656002)(6916009)(2616005)(83380400001)(8676002)(36756003)(2906002)(122000001)(26005)(8936002)(186003)(5660300002)(38100700002)(53546011)(508600001)(6506007)(133343001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1cyY2JiNzhscG45ZTY1aU1YVWxsVjZaQmEySVd4WUROZFcrOEJHYlNvYXd2?=
 =?utf-8?B?N1FxR2ljN1ZxSGNRK0xCSnkvN1VVa2VoaE4xM3FZOEZKSDczKy8vSlRRUUky?=
 =?utf-8?B?NEN3UjRrUGNYWlV1SGJ2RXk1UFVMdHV6U01ZVDlBOGNRRnl2cmNRcmdrVHI4?=
 =?utf-8?B?czlmR1BnbXpEQnBqYkg1cjZLb0xQUzdxSnpRY3ZSV3RBYjU5eGRNUTkxL3h5?=
 =?utf-8?B?Wk56alp2YVIwMkpjWElVSWFhek9RRld3YXI4bW11RjYxMXEvYjIxYnQzNDdJ?=
 =?utf-8?B?NVRvVlFTMkF4ODE2REJjTHRZNEJ5Ym02cEk1azlad1VCSWpSVThacEsvWWFa?=
 =?utf-8?B?TnJwbzNTN1hJQ3d1WHBqOGJTaDNCVGswNHJkaXMxUjdqOFRPZEthd0lOdGYr?=
 =?utf-8?B?c2kwaW93ZnRadUtOSy9pYXVsOWdsdWI0TnN6QkJVbFpwKzBDUjh0cWFLaHIr?=
 =?utf-8?B?Rmt3a016ZDBaS3hJRDBHa3VHYXFQMWh4MHhjOEE1YnRKMDIwVU5jZmp0Q055?=
 =?utf-8?B?TWNJc1dqL3RqbVlTNGtoTHowK21KVGsreGRsaWdZMFRNdGxYYU1JanNYZko0?=
 =?utf-8?B?dzdLaFBmQjdxd0IwQjhNYXFnUk5tRFpISGIvR2RkMG5FVWdXUXBlcG9FeGZ2?=
 =?utf-8?B?VFI1M2hWNkprcG42cGpSM1oybUY2Ty96aVRid0UvZ0JYS0FvaXFOc0Z4LzNQ?=
 =?utf-8?B?eDdPdWlYVkxCYXNUWU1IcURRSFN6RThGT0ttZTJnYTdnc1U3bFZoallFVHRv?=
 =?utf-8?B?L29tNWl1RFhWRTk3TEdTTzg5eXZWTVpQLzJ5KzUzOXdUOUVGQmxCY0Q0ZUdu?=
 =?utf-8?B?K0dxWGd1R0ZlUUMyeG5NanZYMWVIa0NWOE5sRUw5K201Nm5od1JPMlVrWXpO?=
 =?utf-8?B?bVBxWGQ2UThxemIwSUZOUEFRL1ZmaTRmWWRMWHdhQ2xEcnZHQStpYTFNeUQx?=
 =?utf-8?B?ZVhMeWlYYUp1cy8rc1F2dHFqNXpmbUNsd0FzaUhLNFZPdFE5SGF5ekNXSWRs?=
 =?utf-8?B?MlJTdG5rWXRWNlhTNjZQeEtiWEcwTjVzeHBmTU1vQ3JiMDhycEh6Y210Skg2?=
 =?utf-8?B?LzVIUmN6RzNaOW93VGpnRE1DMlFSOWhRUGZKN0R3M0l3cDRiSXhDRk1EaUFU?=
 =?utf-8?B?T1orNERQMWFSbHZyYTlBS1I0Q2QwY3dRQktQeTFrMnoreEdSMW5iNENVaGUy?=
 =?utf-8?B?TFd3MHh4dXJiWGFQbk12NVlzREVoQWorZXR0K1d4Z3lqdnN3dDRzUTQ2SDlY?=
 =?utf-8?B?Vm10TU8xV0xNOXRuNGNYbFdaVHlUaXlTVG5TQW9uOU83amtrVnplTzNQbFFp?=
 =?utf-8?B?dm9hZ3hIalhRaHJFcUxIenRlVEd0Q2VPWVdMV0xCY25ZNXI5OWlha3RGTjh4?=
 =?utf-8?B?WGpRZjZ6RzZvZ0VzTHdLRUwwbS9LWXhNMnJDZUtrRndtS2xWQkxhVnRNMFIx?=
 =?utf-8?B?b1E0OHBtWW1SLzBLL1FEcDhEcmI0eUNRY0xwbVA2V053czlzaUNNZXRTNUNp?=
 =?utf-8?B?WGloWEFDUXJLQlgxYVhFYlR2ODU4ZGVuTVdHMDZpQzcwbUltSFBwZlJVeDdh?=
 =?utf-8?B?TUM5SFFUMEV4RXduMXh2UWp0QVQzcjJmMThTb1BGZHlnb2lyZDFwY3d2RlFD?=
 =?utf-8?B?NWY3MzVIZUlFU0s2bHdGamtkbVpsbFFCL3VwOXdJaEw0MXFLOFpGVThPUDJF?=
 =?utf-8?B?MWc1bDlzREx1UkFWZmxKKzVGWkJuL2RQY05PTGpqOFVpaTVGT0VEMUhKT0V3?=
 =?utf-8?B?YXFYRmVCNngzWkpPbWhVdEpMWnpZYWNkaW1YUGY1L3kzSnZrUVpFL2JnNUs1?=
 =?utf-8?B?Q3pmRG9LMEtHbGRnMno1dVdXRVl3ZUFZVm8xVVlXVTlSclhCZkUyWlJDaHhP?=
 =?utf-8?B?MjZBSFptcUh1ZCtORDRHbGY1dGhxTXF2MXQwS2w0RVNKT0VEdDRlNk5UenFj?=
 =?utf-8?B?clJ2bGI3SlFzTnRCTjgyTlhFOHBMd0k4QTRla1h6L0RPTXlIb1doSTlmL2w1?=
 =?utf-8?B?d21KUDhqdUg1TTB4KzFzYzEzaHhBck14TXJ2RWJpVnd6cmRZS2FDeHYxZmtS?=
 =?utf-8?B?ang5OVpTYzVBUklNVjQzZTNINzZEbVBNVCtpckQrVGpiL1ZPOWMrZm1tUElQ?=
 =?utf-8?B?cnpKdUVDdEROUUNZbkVWMTJLbW9HbERJM3JtTTh4RUpYWDdNajlHMVhaaWRl?=
 =?utf-8?Q?E7IuN8KBX+iC+FzM7RHJwVI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD9EE171E41E974983559B72FA57F5C8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e11fab-fa64-4ec5-5b6a-08d9b8cf8267
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 15:46:03.3874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8aGOMOP9PY4zdiZI6l6ufszV8Oe1octG+QEbG5ERwNejgISQCwRUQE8duVQS6otvhaeIbH7rgkDitxzz+zRcyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060097
X-Proofpoint-ORIG-GUID: s0HQjBgEpBA8lw7nQImjLoEmuefhKzXL
X-Proofpoint-GUID: s0HQjBgEpBA8lw7nQImjLoEmuefhKzXL
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIERlYyAzLCAyMDIxLCBhdCA4OjI0IFBNLCBCcnVjZSBGaWVsZHMgPGJmaWVsZHNAZmll
bGRzZXMub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgRGVjIDA0LCAyMDIxIGF0IDEyOjM1OjEx
QU0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4+IE9uIERlYyAzLCAyMDIx
LCBhdCA1OjM5IFBNLCBCcnVjZSBGaWVsZHMgPGJmaWVsZHNAZmllbGRzZXMub3JnPiB3cm90ZToN
Cj4+PiANCj4+PiDvu79PbiBGcmksIERlYyAwMywgMjAyMSBhdCAxMDowNzoxOVBNICswMDAwLCBD
aHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4+IA0KPj4+PiANCj4+Pj4+PiBPbiBEZWMgMywgMjAy
MSwgYXQgNDo1NSBQTSwgQnJ1Y2UgRmllbGRzIDxiZmllbGRzQGZpZWxkc2VzLm9yZz4gd3JvdGU6
DQo+Pj4+PiANCj4+Pj4+IEZyb206ICJKLiBCcnVjZSBGaWVsZHMiIDxiZmllbGRzQHJlZGhhdC5j
b20+DQo+Pj4+PiANCj4+Pj4+IEN1cnJlbnRseSBuZnNkY2xkIGlzIGRvaW5nIHRocmVlIGZkYXRh
c3luY3MgZm9yIGVhY2ggdXBjYWxsLiAgQmFzZWQgb24NCj4+Pj4+IFNRTGl0ZSBkb2N1bWVudGF0
aW9uLCBXQUwgbW9kZSBzaG91bGQgYWxzbyBiZSBzYWZlLCBhbmQgSSBjYW4gY29uZmlybQ0KPj4+
Pj4gZnJvbSBhbiBzdHJhY2UgdGhhdCBpdCByZXN1bHRzIGluIG9ubHkgb25lIGZkYXRhc3luYyBl
YWNoLg0KPj4+Pj4gDQo+Pj4+PiBUaGlzIG1heSBiZSBhIGJvdHRsZW5lY2sgZS5nLiB3aGVuIGxv
dHMgb2YgY2xpZW50cyBhcmUgYmVpbmcgY3JlYXRlZCBvcg0KPj4+Pj4gZXhwaXJlZCBhdCBvbmNl
IChlLmcuIG9uIHJlYm9vdCkuDQo+Pj4+PiANCj4+Pj4+IE5vdCBib3RoZXJpbmcgd2l0aCBlcnJv
ciBjaGVja2luZywgYXMgdGhpcyBpcyBqdXN0IGFuIG9wdGltaXphdGlvbiBhbmQNCj4+Pj4+IG5m
c2RjbGQgd2lsbCBzdGlsbCBmdW5jdGlvbiB3aXRob3V0LiAgKE1pZ2h0IGJlIGJldHRlciB0byBs
b2cgc29tZXRoaW5nDQo+Pj4+PiBvbiBmYWlsdXJlLCB0aG91Z2guKQ0KPj4+PiANCj4+Pj4gSSdt
IGluIGZ1bGwgcGhpbG9zb3BoaWNhbCBhZ3JlZW1lbnQgZm9yIHBlcmZvcm1hbmNlIGltcHJvdmVt
ZW50cw0KPj4+PiBpbiB0aGlzIGFyZWEuIFRoZXJlIGFyZSBzb21lIGNhdmVhdHMgZm9yIFdBTDoN
Cj4+Pj4gDQo+Pj4+IC0gSXQgcmVxdWlyZXMgU1FMaXRlIHYzLjcuMCAoMjAxMCkuIGNvbmZpZ3Vy
ZS5hYyBtYXkgbmVlZCB0byBiZQ0KPj4+PiAgdXBkYXRlZC4NCj4+PiANCj4+PiBNYWtlcyBzZW5z
ZS4gIEJ1dCBJIGR1ZyBhcm91bmQgYSBiaXQsIGFuZCBob3cgdG8gZG8gdGhpcyBpcyBhIHRvdGFs
DQo+Pj4gbXlzdGVyeSB0byBtZS4uLi4NCj4+IA0KPj4gYWNsb2NhbC9saWJzcWxpdGUzLm00IGhh
cyBhbiBTUUxJVEVfVkVSU0lPTl9OVU1CRVIgY2hlY2suDQo+IA0KPiBJIGxvb2tlZCBnb3Qgc3R1
Y2sgdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgd2h5IHRoZSAjJV4gaXQncyBjb21wYXJpbmcgdG8NCj4g
U1FMSVRFX1ZFUlNJT05fTlVNQkVSLiAgT0ssIEkgc2VlIG5vdywgaXQncyBqdXN0IHNvbWUgc2Fu
aXR5IGNoZWNrLg0KPiBIZXJlJ3MgdGFrZSAyLg0KPiANCj4gLS1iLg0KPiANCj4gRnJvbSBjMjJk
M2EyZDg1NzYyNzM5MzQ3NzNmZWZhYzkzM2Q0ZjhlMDQ3NzZiIE1vbiBTZXAgMTcgMDA6MDA6MDAg
MjAwMQ0KPiBGcm9tOiAiSi4gQnJ1Y2UgRmllbGRzIiA8YmZpZWxkc0ByZWRoYXQuY29tPg0KPiBE
YXRlOiBGcmksIDMgRGVjIDIwMjEgMTA6Mjc6NTMgLTA1MDANCj4gU3ViamVjdDogW1BBVENIXSBu
ZnNkY2xkOiB1c2UgV0FMIGpvdXJuYWwgZm9yIGZhc3RlciBjb21taXRzDQo+IA0KPiBDdXJyZW50
bHkgbmZzZGNsZCBpcyBkb2luZyB0aHJlZSBmZGF0YXN5bmNzIGZvciBlYWNoIHVwY2FsbC4gIEJh
c2VkIG9uDQo+IFNRTGl0ZSBkb2N1bWVudGF0aW9uLCBXQUwgbW9kZSBzaG91bGQgYWxzbyBiZSBz
YWZlLCBhbmQgSSBjYW4gY29uZmlybQ0KPiBmcm9tIGFuIHN0cmFjZSB0aGF0IGl0IHJlc3VsdHMg
aW4gb25seSBvbmUgZmRhdGFzeW5jIGVhY2guDQo+IA0KPiBUaGlzIG1heSBiZSBhIGJvdHRsZW5l
Y2sgZS5nLiB3aGVuIGxvdHMgb2YgY2xpZW50cyBhcmUgYmVpbmcgY3JlYXRlZCBvcg0KPiBleHBp
cmVkIGF0IG9uY2UgKGUuZy4gb24gcmVib290KS4NCj4gDQo+IE5vdCBib3RoZXJpbmcgd2l0aCBl
cnJvciBjaGVja2luZywgYXMgdGhpcyBpcyBqdXN0IGFuIG9wdGltaXphdGlvbiBhbmQNCj4gbmZz
ZGNsZCB3aWxsIHN0aWxsIGZ1bmN0aW9uIHdpdGhvdXQuICAoTWlnaHQgYmUgYmV0dGVyIHRvIGxv
ZyBzb21ldGhpbmcNCj4gb24gZmFpbHVyZSwgdGhvdWdoLikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEouIEJydWNlIEZpZWxkcyA8YmZpZWxkc0ByZWRoYXQuY29tPg0KDQpOaWNlLg0KDQpSZXZpZXdl
ZC1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQoNCg0KPiAtLS0NCj4g
YWNsb2NhbC9saWJzcWxpdGUzLm00ICB8IDIgKy0NCj4gdXRpbHMvbmZzZGNsZC9zcWxpdGUuYyB8
IDIgKysNCj4gMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hY2xvY2FsL2xpYnNxbGl0ZTMubTQgYi9hY2xvY2FsL2xpYnNx
bGl0ZTMubTQNCj4gaW5kZXggOGMzODk5M2NiYmE4Li5jM2JlYjRkNTZmMGMgMTAwNjQ0DQo+IC0t
LSBhL2FjbG9jYWwvbGlic3FsaXRlMy5tNA0KPiArKysgYi9hY2xvY2FsL2xpYnNxbGl0ZTMubTQN
Cj4gQEAgLTIyLDcgKzIyLDcgQEAgQUNfREVGVU4oW0FDX1NRTElURTNfVkVSU10sIFsNCj4gCQlp
bnQgdmVycyA9IHNxbGl0ZTNfbGlidmVyc2lvbl9udW1iZXIoKTsNCj4gDQo+IAkJcmV0dXJuIHZl
cnMgIT0gU1FMSVRFX1ZFUlNJT05fTlVNQkVSIHx8DQo+IC0JCQl2ZXJzIDwgMzAwMzAwMDsNCj4g
KwkJCXZlcnMgPCAzMDA3MDAwOw0KPiAJfQ0KPiAgICAgICAgXSwgW2xpYnNxbGl0ZTNfY3ZfaXNf
cmVjZW50PXllc10sIFtsaWJzcWxpdGUzX2N2X2lzX3JlY2VudD1ub10sDQo+ICAgICAgICBbbGli
c3FsaXRlM19jdl9pc19yZWNlbnQ9dW5rbm93bl0pDQo+IGRpZmYgLS1naXQgYS91dGlscy9uZnNk
Y2xkL3NxbGl0ZS5jIGIvdXRpbHMvbmZzZGNsZC9zcWxpdGUuYw0KPiBpbmRleCAwMzAxNmZiOTU4
MjMuLmVhYmIwZGFhOTVmNSAxMDA2NDQNCj4gLS0tIGEvdXRpbHMvbmZzZGNsZC9zcWxpdGUuYw0K
PiArKysgYi91dGlscy9uZnNkY2xkL3NxbGl0ZS5jDQo+IEBAIC04MjYsNiArODI2LDggQEAgc3Fs
aXRlX3ByZXBhcmVfZGJoKGNvbnN0IGNoYXIgKnRvcGRpcikNCj4gCQlnb3RvIG91dF9jbG9zZTsN
Cj4gCX0NCj4gDQo+ICsJc3FsaXRlM19leGVjKGRiaCwgIlBSQUdNQSBqb3VybmFsX21vZGUgPSBX
QUw7IiwgTlVMTCwgTlVMTCwgTlVMTCk7DQo+ICsNCj4gCXJldCA9IHNxbGl0ZV9xdWVyeV9zY2hl
bWFfdmVyc2lvbigpOw0KPiAJc3dpdGNoIChyZXQpIHsNCj4gCWNhc2UgQ0xEX1NRTElURV9MQVRF
U1RfU0NIRU1BX1ZFUlNJT046DQo+IC0tIA0KPiAyLjMzLjENCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0KDQo=
