Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387EB438429
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Oct 2021 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhJWPxO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 23 Oct 2021 11:53:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62478 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229901AbhJWPxN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 23 Oct 2021 11:53:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19NBoCwv018736;
        Sat, 23 Oct 2021 15:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Wpk90zwLD0Y8BGyL3rASCAWmdbvSdhoJSvYIlTias7k=;
 b=oeeK9DquZPhgaFKorYxNWewGPEyEdVTkzenJ4Fwlp1wUcRQn5cRiw+8j6xkLCJY6k70/
 JPE6kdbcgpjWYLSXo5iEYs66Q0S7IvD0tEZoKjpKQZH1g67H6t7kNFkp0WJhr2ZnCtBb
 BJrOjj23nhWOXZE3XMkyQ8TtFtGOZSCah0L6OqT8A7HrE5MYxDRpZVdCVsvqkuwAGDWD
 BIvAfOVALoHKJ7iINHqx06k0f8peEu3OmBiNA3GO4Mg8/W9O1KjCQlfbw4pZsehJcykR
 s76D8dUsOEkCVH9JoKRT/1CbDT7yg90OuYKtbgNalZRvBM6SKwjnJVjzpdKClXoMIBJ3 DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bv9019r55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Oct 2021 15:50:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19NFfkMr101816;
        Sat, 23 Oct 2021 15:50:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by userp3020.oracle.com with ESMTP id 3bv9qkannp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Oct 2021 15:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayIsZkJ1C6SEhXK/GWmGr7PVBcie37XRGjPoHS2vLBinzMWxrZ/V6Nx+dYzqCvHaMOtnOeBn7SndP+9erkDak5K3cOX8uXpmJVqMuc89TpGZIzF/EqElUjOkO62zz7GquqLldrjfK6V2AWMnaMmImY9iIOhGojo2b+W7gDcZzQH7fxWDv5/iVIEJN3ckqRISn7lGR+qv1PczWBryL4wOeMe8bHMRclaFNNvfd8WlUQpyBQ7lPsBYB7Bj5x/H5ffKiXbSgnoN7oCwkMB+8sE9WMOnMEZv8pQenXVWQ2RcvUfFtHM4XlhvDBQob+CYGzn9/MMcGvlFUH229xEVKIBXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wpk90zwLD0Y8BGyL3rASCAWmdbvSdhoJSvYIlTias7k=;
 b=hCi3KeB2l8aC36aJ5GgPGzEhGZ7VEgHGSeCODWMK9XQq+/Sdqul1QbIgmK7DNb9lzlRyBrw6xE1zLDK/bTzXd/0H48qp9ysbQRAOF/q2j4lZO4FdGVRAFHjN3pG5WkLN8BjI6b0NVznESbmf5nalAjDGKnVddvai+V78F+rHudOqbFqBj+4iUdJBcTkq509Apn9mA5aerjAGG8fDuZIil8V0mmZNOf40pJ7es7eK77cXqcVJNh4Bd9qngrYlM4yxnL+0uu9U056xtZpGltrLFuQ0e+bQwApnilf0OiW4nZQ5vvtXATjuLi4//OQjTMXIdo8zL+W1su07NZTgvp8jxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wpk90zwLD0Y8BGyL3rASCAWmdbvSdhoJSvYIlTias7k=;
 b=AFAgboKCmKyn3Sh64IcnaycOyjJUVjHQivklZDLU25zHyORRFlh/cU2vKulcTiMhbJgpA+DgTNhhYXzffZmWQ10OWx1J6SvHlAAEGq8Yb5FZ9zpv/MHwdxUJ7W5OJsauDqdUHVpmRjEKGhmng6USNzF5aZVwkYXx23iVyCg/huI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3143.namprd10.prod.outlook.com (2603:10b6:a03:158::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Sat, 23 Oct
 2021 15:50:41 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4628.020; Sat, 23 Oct 2021
 15:50:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH v4 0/9] Add a tool for using the new sysfs files
Thread-Topic: [PATCH v4 0/9] Add a tool for using the new sysfs files
Thread-Index: AQHXx4dClQuyrAy5BEC5REXZwQj816vgvGYA
Date:   Sat, 23 Oct 2021 15:50:41 +0000
Message-ID: <D9989B3E-1B6B-40CE-A7B4-B65DE249CFCB@oracle.com>
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
In-Reply-To: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5b81bfe-8f8c-4161-893b-08d9963cddff
x-ms-traffictypediagnostic: BYAPR10MB3143:
x-microsoft-antispam-prvs: <BYAPR10MB314311BE845056C30272CBE393819@BYAPR10MB3143.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N6GuLV5XUHMyd8rsRZPm75L+Y2fkn+ERbz38+PW9bEMH/lf4JUf72+julfvXceFPz+GA/NAM1vRmzszFf5pxqdlKoWRDlOZNT/nOHk/bA77TlatviZ/RIJuXwpVq4eXqk9YAYnGreH0mWluF4+il8oZsnWMwPUtTO7oBquzY3W3mfNhIXOEAUtEpKfvTajdRWX5j6jzK/yDGd5uInm2P5l0wHShANUd8i9E32/jE/E7avVeQN5P0GEDdYUfh7e0Rw1p2FxS5Wpx5wwTgUYeAboLr30c3MtmhqrBczlK6JH4aNAgVfVUE+5LQoXX52Jid5Lc+KybsFEYGcWljN4xWRcyrzCq1XVi3gjd50F1Mw4aSmgMG2l6puoa2Ukv+FmEIMRumETD4OSDgVVug6kDdK0DrDs5gJyoCoLjL5xzz0sMCIlTdzgPt1ThL0hauMz12ZxdARCzCrbN0HyKO1Cz6pD+jIVIqa6q3d2TdCex5VkBuJiYj3tlWfNdbsB0hxCI0dWdeYDANk4XcE0QNQ6qle3n0wg78KG0Qin3g9hjf/2EqWqKuFWcBNIPnm/EEx/va1MUWtkdj2xtWAUPAJShI6Q0ipxrkPRo62GLeKe1/JtadeCbnH2XyYHqp+NP8d8WswvyR6LpJ9kQZgN0fUdCMkTenbE3rDO5+XqF/QtP163ZxeoW+1ooN+t3NHY97VQgft+AvIGECwAVKRGs744Q948zrTMEgByz0Or+mrbUO7OxfC5FZCPGDQzgn8irgMgnV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(33656002)(83380400001)(91956017)(76116006)(53546011)(66446008)(86362001)(8936002)(54906003)(66946007)(2616005)(6512007)(6486002)(38070700005)(5660300002)(6506007)(122000001)(66556008)(66476007)(4326008)(38100700002)(186003)(26005)(508600001)(6916009)(71200400001)(2906002)(8676002)(64756008)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5jt7RQOyBIlKlGwKNk9p5n/DHTi/h5Guxwepei/dkfFjL3xX6eeF0t4o1c8s?=
 =?us-ascii?Q?6E9qBcAfJuHtk6P8OhORJizpbJc1WZW0COQKZz86fYpPzMlSfQWzx/fUgMEm?=
 =?us-ascii?Q?dwiQVJlrA2taJq1kyS7iqiIbZtVu1iWI1zsJjZZcZ2sK2em+YS0hl3xwdBNN?=
 =?us-ascii?Q?/3B+UeXPsR14lR96/jkTIvfWLszoFDhz5a7Cfjf6izZXdALQSoP5swl5iV1u?=
 =?us-ascii?Q?GBDKpt76NVhkEufwz2ldIKiIwRs4QF6Nv9FUnaekKA2L69XpDHdPe4tpwVqj?=
 =?us-ascii?Q?uP2t8bN14izdbwOUK7bSXRVyhrimWWCxFGtdmJfTVc2olRZeYJhAY+h4xFAJ?=
 =?us-ascii?Q?5roY1lGlvJBfOe+t2coMKDpfA+LMLENePzBo8wlnWP6DfCuDQsaCu/ArDkTW?=
 =?us-ascii?Q?O7n/On1k5WQI8CnVQPYsExNIForVogvt/dyiPFk4/TJ/NdIyafhA8Kldkgxj?=
 =?us-ascii?Q?j+gBtLfAdOaAkUfvCDOBU/fhvfrtr8Iqn1cAMGjPKZ+VWzdy67CdJvCvSt+U?=
 =?us-ascii?Q?d7QWODVgxzycW5uevpLP14BOjr2r8yHKeF4qeVIy7FVIrKC4Ojsne3mkzrju?=
 =?us-ascii?Q?/1c7Vym/+188YS7T8Uaui4apWc51oxHUo4Os/GQyOwhOj67ImsMiPAeD2XUt?=
 =?us-ascii?Q?tGwn4SGqbTuwReMtk7U8ciY8mj6TN+SsJQESH+wBoW5ZmwM0pI2I9l9EsdLk?=
 =?us-ascii?Q?nATAjqP4eig4IVnc//GUrQbamZgbo4Vx9YnSFHTqfBNuebPxnHWyIqS32ZxJ?=
 =?us-ascii?Q?phX6fKgejxPjiyfONHQlN0QaAxpwIcMReU7gUVe0j02mSlzrWg/fFCMkmT4c?=
 =?us-ascii?Q?rSVZ3Sn1OMf6JX3cXibWzKwfiWE1f+rHjb/RxCLsyxh8js4AGqo3l3HW/WAY?=
 =?us-ascii?Q?0MFr9+Twlj+tBuM7mo0lbgUDkCnLR0V9hQsCcO9qsruSyDVmeE4aPAUXfncX?=
 =?us-ascii?Q?TTaywshyvNjZeae/9VSSweEzVmrq1OtS4sSW2d1FM9XqfuajQsTqQ8c4k8Ka?=
 =?us-ascii?Q?tFZZLcb4hzCOX9sgzIp+zt4ae0sUI/wxZr43D/XLaY15ZG7Uymk+oyr2hRmb?=
 =?us-ascii?Q?t08cffmMuGi+WDg0oG94YKntFqsAfJueq15tfJFHDZgupBBB7pxXY2I2DjWv?=
 =?us-ascii?Q?a5txfgZImYkkcW7OJK9Zxivv9DnorWPt1nLxMoYR6j4nU0FIa+sZa3l7e8EQ?=
 =?us-ascii?Q?ePsYk1CdGvITzr4JNEuFcalwSco9uIFYF4lHE5NjBeONGPAZSf67QqCtBakN?=
 =?us-ascii?Q?s5gF896qRVsgaKo2Q06ryvJktsX1tPVeLx6nD/7ZyANPqpKRBMs0TPDFXnf0?=
 =?us-ascii?Q?QkjVqk35Qmcpal61iDGLSDuffBfRZUlIyYWPQt+jrt/iN2JgmBgOxLawdueH?=
 =?us-ascii?Q?wCfLi5LloEP9Lr8H+gH+na7Z33PjABjxobbD8Wx5JLFOs23Tv12apkqIL/qY?=
 =?us-ascii?Q?umiWflddufej3wtRsHpXDRYu0hlnB0ZkQv/33mKeSgM9q45eZieAkeJDW3hj?=
 =?us-ascii?Q?8x0Ycckgarz5/SoKPC4kL4uOsX0CZeW9pX5OdR+ugBMR1TxaEUT+mg03IDex?=
 =?us-ascii?Q?N1/X9ememSxWsbJOfjHzwxA8vpwIIcFz3YcLLz3wY5gfAvK8b3M0goEfKm68?=
 =?us-ascii?Q?7l1I1EBHmLg7Lv8jTVWt6zQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <125DC7B833E53B4F87676215FF6EF6DB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b81bfe-8f8c-4161-893b-08d9963cddff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2021 15:50:41.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZoz7RRFNNRo1WaQ3EwL+3Znlj9HHAPI/21WlNrDGOweV2H7LnwsnAxdwo3xIUgfINa1cTWwU4G7cUpwLjFR5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3143
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10146 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110230099
X-Proofpoint-GUID: E30mJNWnD2QD9HHQP5MznzoAaCODVpQJ
X-Proofpoint-ORIG-GUID: E30mJNWnD2QD9HHQP5MznzoAaCODVpQJ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 22, 2021, at 4:55 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> These patches implement a tool that can be used to read and write the
> sysfs files, with subcommands!
>=20
> The following subcommands are implemented:
> 	rpcsys rpc-client
> 	rpcsys xprt
> 	rpcsys xprt set
> 	rpcsys xprt-switch
> 	rpcsys xprt-switch set
>=20
> So you can print out information about every xprt-switch with:
> 	anna@client ~ % rpcsys xprt-switch
> 	switch 0: num_xprts 1, num_active 1, queue_len 0
> 		xprt 0: local, /var/run/gssproxy.sock [main]
> 	switch 1: num_xprts 1, num_active 1, queue_len 0
> 		xprt 1: local, /var/run/rpcbind.sock [main]
> 	switch 2: num_xprts 1, num_active 1, queue_len 0
> 		xprt 2: tcp, 192.168.111.1 [main]
> 	switch 3: num_xprts 4, num_active 4, queue_len 0
> 		xprt 3: tcp, 192.168.111.188 [main]
> 		xprt 4: tcp, 192.168.111.188
> 		xprt 5: tcp, 192.168.111.188
> 		xprt 6: tcp, 192.168.111.188
>=20
> And information about each xprt:
> 	anna@client ~ % rpcsys xprt
> 	xprt 0: local, /var/run/gssproxy.sock, port 0, state <MAIN,CONNECTED,BOU=
ND>
> 		Source: (einval), port 0, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 1: local, /var/run/rpcbind.sock, port 0, state <MAIN,CONNECTED,BOUN=
D>
> 		Source: (einval), port 0, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 2: tcp, 192.168.111.1, port 2049, state <MAIN,CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 959, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 3: tcp, 192.168.111.188, port 2049, state <MAIN,CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 921, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 5: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 671, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	xprt 6: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 934, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
>=20
> You can use the `set` subcommand to change the dstaddr of individual xprt=
s:
> 	anna@client ~ % sudo rpcsys xprt --id 4=20
> 	xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> 	anna@client ~ % sudo rpcsys xprt set --id 4 --dstaddr server2.nowheycrea=
mery.com
> 	xprt 4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
> 		Source: 192.168.111.222, port 726, Requests: 2
> 		Congestion: cur 0, win 256, Slots: min 2, max 65536
> 		Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
>=20
> Or for changing the dstaddr of all xprts attached to a switch:
> 	anna@client % rpcsys xprt-switch --id 3
> 	switch 3: num_xprts 4, num_active 4, queue_len 0
> 		xprt 3: tcp, 192.168.111.188 [main]
> 		xprt 4: tcp, 192.168.111.188
> 		xprt 5: tcp, 192.168.111.188
> 		xprt 6: tcp, 192.168.111.188
> 	anna@client % sudo rpcsys xprt-switch set --id 4 --dstaddr server2.nowhe=
ycreamery.vm
> 	switch 3: num_xprts 4, num_active 4, queue_len 0
> 		xprt 2: tcp, 192.168.111.186 [main]
> 		xprt 3: tcp, 192.168.111.186
> 		xprt 5: tcp, 192.168.111.186
> 		xprt 6: tcp, 192.168.111.186
>=20
>=20
> I renamed the tool to "rpcsys" after the discussion at the bakeathon. I
> think this is at least a better name, but if anybody has other ideas
> please let me know!
>=20
> Thoughts?

Anna, very nice!

How about naming it "rpcctl" to follow the pattern of:

 systemctl
 resolvectl
 hostnamectl


> Anna
>=20
> Anna Schumaker (9):
>  rpcsys: Add a rpcsys.py tool
>  rpcsys: Add a command for printing xprt switch information
>  rpcsys: Add a command for printing individual xprts
>  rpcsys: Add a command for printing rpc-client information
>  rpcsys: Add a command for changing xprt dstaddr
>  rpcsys: Add a command for changing xprt-switch dstaddrs
>  rpcsys: Add a command for changing xprt state
>  rpcsys: Add a man page
>  rpcsys: Add installation to the Makefile
>=20
> .gitignore               |   2 +
> configure.ac             |   1 +
> tools/Makefile.am        |   2 +-
> tools/rpcsys/Makefile.am |  20 ++++++++
> tools/rpcsys/client.py   |  27 +++++++++++
> tools/rpcsys/rpcsys      |   5 ++
> tools/rpcsys/rpcsys.man  |  88 ++++++++++++++++++++++++++++++++++
> tools/rpcsys/rpcsys.py   |  23 +++++++++
> tools/rpcsys/switch.py   |  51 ++++++++++++++++++++
> tools/rpcsys/sysfs.py    |  29 +++++++++++
> tools/rpcsys/xprt.py     | 101 +++++++++++++++++++++++++++++++++++++++
> 11 files changed, 348 insertions(+), 1 deletion(-)
> create mode 100644 tools/rpcsys/Makefile.am
> create mode 100644 tools/rpcsys/client.py
> create mode 100644 tools/rpcsys/rpcsys
> create mode 100644 tools/rpcsys/rpcsys.man
> create mode 100755 tools/rpcsys/rpcsys.py
> create mode 100644 tools/rpcsys/switch.py
> create mode 100644 tools/rpcsys/sysfs.py
> create mode 100644 tools/rpcsys/xprt.py
>=20
> --=20
> 2.33.1
>=20

--
Chuck Lever



