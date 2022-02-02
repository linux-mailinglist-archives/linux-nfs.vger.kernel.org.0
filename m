Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB3D4A790D
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Feb 2022 20:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiBBTz4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Feb 2022 14:55:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1266 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbiBBTz4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Feb 2022 14:55:56 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212JECHq025699;
        Wed, 2 Feb 2022 19:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=q6tGgnv1c2sYLc+qJL4wJVnuaPkQ//XVe+TDiKoKdTg=;
 b=Oxw9PUwQhsNF8c3LjS5YrY3ZjOEhkm2zbetd6JN6GL9MhDcsEP6b2vUxrxgE1ib0sD9M
 GFh187HHtszJcjq0slzXnAZMk7+rehOh1w9fFPZj2dSYysIpUHL7o1CvmmDOA9tbX+4N
 P+mkJeLXj1rQhRFrZ4jSCWqxuXRqCHCGcbuHqmow+/pczMASFGdDsVQehwtQuoKJSORT
 2W912OCdbV6H2NSxF2pPdrx5fP5ZW3YdzDBhl5XI6q/MDf6gawVMgyQ19dIa6xom5yGz
 YyEpqZZ8277Xvn5D53lcrwJiNeQo8gJbImLRWOqD4HEw1EEAxN9Z4/IkCPFEMPNW6UNj bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wf1me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 19:55:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212JZj5C159296;
        Wed, 2 Feb 2022 19:55:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3dvumj3vj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 19:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEU9hiLzeYAjjG7rvftlHMGMNBHsBuoflngXArup51kxBkD+gSx4MsNEd2C5X+B1HoJvrH0k7a46rDbKFAQSoUZupVnmMmfkE/EEp8xeEiKxiSGEPpTPykAQuxy8sYQ5dY2vwmrjShe4ANE6XobqznLHnzuLF34XsSFFzkwjrWDLt54JjvNUcWRzUGVAs/ONk+FryAwmtoIuHtM1rxdBR77/0L2Pmky9qR/NnPSP43pE3af0E0H1JE9tcdtZ6Cb3/vWrwpwcztsVkPJCweUdCka24PaIp1y6nz7G9Ku0jejGpEaBUNa5AW5Go2HuwISA1ouZXGBsvDFSS++J+y1zYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6tGgnv1c2sYLc+qJL4wJVnuaPkQ//XVe+TDiKoKdTg=;
 b=KeRH1Ow+drezdYUZ1CgpwEiJ7G8HjxCGcvN0xwlqo49Jx+1G8tvSPQrPC+h7R7PDtZG60eknRVVBkWRoflFI0rrprs5gZ79I5GpnrjwPI1PLpEqPYG1W3d55Iay3CGgbkvl5C72YLUY/1WLMLAKRx7wOc+D/g7asFITdLUHhR3oFOZxiLRvDOD03xWSwN3Se9p4pRmGunXVf9cgwq0Ut++BRqNETAFjxNGyvn9mufxoFsgKv/3uCyBSIVvLHlqIJX1q1uiV5s7iCupArQevBxVJkvC69ThN+dcqmXDg8IsBYv/6mxyGimG1PQzXmVYo/ZPLhssWnzl4UPJijAg8VBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6tGgnv1c2sYLc+qJL4wJVnuaPkQ//XVe+TDiKoKdTg=;
 b=R6xon/tFGKZDbsOjvTxFM5HS5sL8YP3qar1ndqPeY0YhocVxW7G5PbWAvUHZQUzWAfaCgE+NBs27S46V7A9ms6ARAxF9bxwQCLivRB5SknSoOf6cbtw2TJfHCuQeEFYMARPmgBvjBUxIjh3F0DQemhCD72zZI98eheABPEcWEzs=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CO6PR10MB5459.namprd10.prod.outlook.com (2603:10b6:5:359::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 19:55:48 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 19:55:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Simon Kirby <sim@hostway.ca>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Cache flush on file lock
Thread-Topic: Cache flush on file lock
Thread-Index: AQHYF9ij5r5wZxOe10G+VO/hoTSM1KyArgyA
Date:   Wed, 2 Feb 2022 19:55:47 +0000
Message-ID: <4691F0AB-FCDB-49EF-B62B-51F135F692A5@oracle.com>
References: <20220202014111.GA7467@hostway.ca>
In-Reply-To: <20220202014111.GA7467@hostway.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fed091ed-19b3-4b0f-c9cd-08d9e68601d3
x-ms-traffictypediagnostic: CO6PR10MB5459:EE_
x-microsoft-antispam-prvs: <CO6PR10MB5459C27466B422C2B6DE9C9493279@CO6PR10MB5459.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUxsy2+re14owIFy99F6gW16fKDmoVKlMJv6+NO9vqPACDSX1Q3O0QNdt7XzzMwRlxwke2D7KdNU3Ojl0O175m6x9Dsq9titIsf/YDt61FQW4znGywiQ+GXr5ABqhhYwijzfyhD9akhvLRAxbZ42s/IrOfswZ2y56XQTG099mg1xEXs2vcp5e6gNY7lGj1lDqFhmugMqPDKCRUzVDLrPKBYy9NBhMPD121I+DonG8m084znOGEuG/8XdR4p//eNBv4vvRO2GgMXPxCVcIZDX8+MvVqdFInleTSydQM92CmQTHs2lOD2VOTafLZ5nhxCYagxHpSdmd6bHHWlvnohGHSgs+Qz7SgV10xgDQTmx2zMnM7lHH1SxithDqCo/dEGrGMqQTD4BjLwICqJdALkuAvdN4jQDU2xDPMzfFLaiSPSolPXAMdutD4k5wkRYM1YkeqA8v4ovASb6wXorJ5p+fSZHUWJwDwND+4q2/cC3BGffXDxWVoW1dC69HtftpUpyiu7/W3fUwCtBLe0lS7sgl6y8YtfZa5mACdTGGb4MKSVLkay6I2vK9APy0knQj2b3ydpHfqUTEwB3o6TyVhyulMGTMkSsiZ1r52tk2m35txD33j4KCT32JuWXqvRBBi60opHIlyWCxhk6VZnQ+mb5H+E1+JiNa/zxZPLhENNzXMRKi/Hawm7laPjcSIao+n0sjjVSUvplbYdq+uhhhU9oqkwpwpWWgqFVHCMK9+uwwMJMkLWhx7CMcjij3nfgHaLQu6x6SV79LkPSPFqj9rpFKFuClwR+X2yZ+JScbOg3PuiBnsGaTXZ5FVH5M5QOUD+qa/6c1HTiCBlRndQrQpI0yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(2906002)(8936002)(4326008)(66946007)(2616005)(66556008)(8676002)(53546011)(71200400001)(76116006)(66476007)(33656002)(66446008)(6512007)(6506007)(5660300002)(86362001)(64756008)(508600001)(6486002)(966005)(6916009)(83380400001)(38100700002)(122000001)(316002)(26005)(38070700005)(186003)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k2Rd3QzP3o8ToX2WjZSc3LnT1CWQaZPSBcRzIL3DJe4gC23n6XNqDapN/mZ6?=
 =?us-ascii?Q?WfgZCm4F0e8C/yPRKC9llvK+rrGdnGC6cVYLYNgdnZfjSAYxthiJeqnEapK7?=
 =?us-ascii?Q?60wtll/HwDKlZsT4Z+owx0+R4Hhl7mKJHWMDMm9vtaH2OdGlDTANkzdzoeb6?=
 =?us-ascii?Q?IBDTuwjGd6VlMewaderddZ+s24VPsefzN8jAWGT8QRoyktEa9rYWgjQF7tGI?=
 =?us-ascii?Q?9YZQSxAqvBQl7F2EnRmdUXaoLBx+EwRxdtCOJvyTVElJ3RZQwyojw+Y5u4cN?=
 =?us-ascii?Q?9ZjXptB5fLXsa919PtUc2PtLBgALFa+oU69RvqxEd2wtXitHPiEtQH8WbX6e?=
 =?us-ascii?Q?j+BvxT5hnSPeeE5PAuRxdc/B80YCs+2jV8p5zuL89iSyKTRLaIhZHuUeAa74?=
 =?us-ascii?Q?WCVWtBBIv3NnetVCoeCwQqS1eVa2LHEHMWZjUf287YFUdcqf4RgTgwrSn/xG?=
 =?us-ascii?Q?9X4z6IxFWMFqiDIGIP0RaMKfirxiCD9smp88PhGOoGwtLeJW7ezyQRfsNL9g?=
 =?us-ascii?Q?WJGUN9cBIl9BXJagKvmWmQFOibjAhida/QA6NvUNaCmHbJ1ozRqHpthBiu0N?=
 =?us-ascii?Q?EtkKGK820FIuLXNwVdD6RMTU2YtG+P8h1DJJM2x3iepCO74P+5n2TqADGlpq?=
 =?us-ascii?Q?Y6yAgeJ+cfgzZLuIlHy7CciMVeSOw/zleQSh3wju4RzPl5XynEGXDcolXswa?=
 =?us-ascii?Q?q9zDupP0XiwAwWIjULaoHRxpfW7/i61BIvasquhTBN/vTwu+rAK2ArwRlnpg?=
 =?us-ascii?Q?ovzwbhLPIQ7ML/geZpyXwM/p4c0tWupLobjZeU2H1giHp6PrTQroNsFR/Qku?=
 =?us-ascii?Q?5kyLw3YarGbD8Egy7Csx28WB6yhpzwS7WZ2lMkbBMFKmrMljS1aPB1S8oHSF?=
 =?us-ascii?Q?ZPLb2+nvNa5eQ27gO0FxgxluKmJR7ozXxLTf94yacTqm8NlYduyiK2YbSLmI?=
 =?us-ascii?Q?j3TonOjqcx3CWzglQaFCYtcEgUENxSBWV6rFLBa7G7X9o8/osPkQpFoJe9Cv?=
 =?us-ascii?Q?S84q1RKITeeNz7Gr4KE0/JWt4hSQmZeug4Zfn8gn6zWiXLjOPBWsRrR+5UOj?=
 =?us-ascii?Q?kMgEaQsWCC4bnM3qLhmKYazGPJOHnclP/hz7nc3Ve/MaACvhnKGzjJQU/p0X?=
 =?us-ascii?Q?/vzcPElNgv9kgDuFI6rk/Pz6ulRJtZNIVGshs4lKvbrPBvuPbZ+Zcv052IhH?=
 =?us-ascii?Q?KqapC0IHPrekljSAsjlfd7CWYGw0XHsm9KOdSNxpiJnMmoBjgACBEtanxvrt?=
 =?us-ascii?Q?yAxo3qYhe1fABTe/VWYscsJs5jACNelDZaWiMKay8pIg0PKnp08J4bh0vHpj?=
 =?us-ascii?Q?MCpk2uYaVpMMbs16zyeQlULh+a3QWB/q+t9n1LjUcWh5W9yyfpYZGa0uejBd?=
 =?us-ascii?Q?kvoX1bdMxGSjRzn9tKb5DnUUW4E8cUTFGgqxZEyWaTCWJX1Yhea4nekUUQ1g?=
 =?us-ascii?Q?PZrVU/MQKt/eswXSTkvboueGXvxFB3HR48uZPqbt5RCu/rox6Hkj0JfYdxVx?=
 =?us-ascii?Q?6EP5UKPi8zUzwAknNlGLJpzsNCtueRp03pTrsA0WO3JMvgeEAu7VIWE95weU?=
 =?us-ascii?Q?ZeJoU/m2QO4KH5E8wTtbAH6Q+yp7buc4IyesOS7dDvbSKH9/smT/3YLi8BB0?=
 =?us-ascii?Q?vRAihcOfKq9Wx6bg6nlCwDc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F24AD631B3D3CB43AE01E89482AEE999@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed091ed-19b3-4b0f-c9cd-08d9e68601d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 19:55:47.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWfTDsvNIf+Z9eDQhoj1aJl/+tXeF3Ps7fNwlmJREqh2lfD3wTEMkekByveY8VilTqJEqOxF9vJIyaX8Ali11w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5459
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=997 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020108
X-Proofpoint-ORIG-GUID: Qo4acbd3Jpl0Z2jLpAjRvNkWOMsEVEAU
X-Proofpoint-GUID: Qo4acbd3Jpl0Z2jLpAjRvNkWOMsEVEAU
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 1, 2022, at 8:41 PM, Simon Kirby <sim@hostway.ca> wrote:
>=20
> How far off would we be from write delegations happening here?

We are tracking a "feature request" for write delegation support
in the Linux NFS server:

https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D348

At this point the effort is not resourced. It's not clear how
much benefit it would be.

That said, it seems to me that your use case might benefit if
the Linux NFS server offered a READ delegation for the SQLite
database file even when it is open R/W. It might be appropriate
if the server offered such a delegation when there are no other
clients that have the file open for write or that hold write
delegations.

Patches and performance data are, as always, welcome.


--
Chuck Lever



