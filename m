Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949AC32C6AB
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbhCDA3t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33028 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388034AbhCCUbf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 15:31:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123IALuS149810;
        Wed, 3 Mar 2021 18:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tdwrE7SmHlkiZO7dbofEeeRHD1CzuQRX2OSkxUX76Gc=;
 b=vXcwsYCNhKdHuh22I7Yk0CqgwT4LMyCJGpXjLs2QgtnQILjOcjAiApM9UvNXEeyF2rL5
 AXEyrJMfPJyCpIwzPrAd4qrYOVbbi3SdvHpAgyRW85CHV/VRKpQU3rTN1GUCNYHr1uyd
 jagYmnRPLf7LraW9Qdy3ojrgEgo/Bry16f5MgRyyOgVRCL6mMTaFPnGo/M09xjIaUoYV
 nXja0RNgJc3HhUTvBtt3t20aYk+oWmcWx7Pfz5LoMMIOatFzxWdz+uCEx7LFtBfYCZUk
 ZYX3qte+7TSgPyrf8OHmypmp3w7UzouEgIXpNcEzU+CHGQzvjE6XWwwLuebqj6226XQ7 Nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3726v79xyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 18:10:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123I0ebt006859;
        Wed, 3 Mar 2021 18:10:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 36yyutsu4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 18:10:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghANVeKFBBw8Id9f2oXtvxPJYwUKkCsUDtK6RwUq44wgD9SpFDrHChk8yV0R3orbBO0NBmsMY/U72ymfcOXBxfJNFN8v1E7/zBcnS4rFL23LJCb66Y6Vdn5umrB5+eyFgnhOsCorJ7Wsqmdep9IZHOlYDsJDF68u+LzdX7rN5s118NB9Gyf57uFweM/qYQKN6Krxg5wheDQTHct2vBlxwr2r06K1WTrfxVLrdJXFR3IGHww+dcW9ART4SQGC5p6zISjKSNH4BxeY+xGFhgXOTO6geJNt1yYDe/EVKb0M2RnjBc6jowUgUkwEu5roFesTQ8pU59NwpxQUUCB26cgctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdwrE7SmHlkiZO7dbofEeeRHD1CzuQRX2OSkxUX76Gc=;
 b=RSjPnPs9bZzb9xfe0Hvj/7WGpjSRDloPWfaj6BvQ8KXV9UZB0tZOhQdrL/mPrb1vnYTuhQBz9t2zwuZdXlb3OpHidy8aYoemJWmUu0Ji8vQJhr3bkhJmv9u/4353S2dKF4gFaKaDpE21+IEjM7L73asTX5CMLGzk96Ejr6SzhoDdftMVYESufS3sTBQDqSukG5MTFCpLGZHap2VnyKDtnH2XQzV81nwFZmuifQ1cVw6B4OksxSvFJteHPXJas6RzPKBz5ZyskhhJeqvlx5I8WgSn+DP2mVGo5I9B2UlamgIlkdcSzuIO5Q1CeuhRoXwZrJa5tG8HoM/3VbQ02Iw+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdwrE7SmHlkiZO7dbofEeeRHD1CzuQRX2OSkxUX76Gc=;
 b=R7ocZtWdMaWHNdb3Xs9/0a7juIMJYoJt30Fa2Krb/oSE9WEn/SwMK87g36KYaYRtJC5XK0Eq3eAveDbeTFj6tqZj4taMOlb91a2IWcYY5BNkqoz9wG4Va+wprHeLmCRXphAb2CbYkXw3op54rGAe60iR7YZNInbuxoeXbRmmcAs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Wed, 3 Mar
 2021 18:10:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 18:10:21 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Steve Dickson <SteveD@RedHat.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
Thread-Topic: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
Thread-Index: AQHXEEhZkdBHYefJxka6Z8w4OsszKqpykGAA
Date:   Wed, 3 Mar 2021 18:10:21 +0000
Message-ID: <06F2DFB7-8EA1-4ACE-BEA9-A68ACB99B361@oracle.com>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224204944.GG11591@fieldses.org>
 <0dcefec0-1fbf-d43a-b508-cb06edfea866@RedHat.com>
In-Reply-To: <0dcefec0-1fbf-d43a-b508-cb06edfea866@RedHat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: RedHat.com; dkim=none (message not signed)
 header.d=none;RedHat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc916c72-63f2-4e7d-0426-08d8de6f9c0b
x-ms-traffictypediagnostic: SJ0PR10MB4446:
x-microsoft-antispam-prvs: <SJ0PR10MB4446EAFCFB4988AD0B1BCF1493989@SJ0PR10MB4446.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZhVKaUlusbk8RZ64yvN6GjxXouKG8LZREXUlRpW9dUkJB1GAYCQCSVHF3PEAKi/0hWFbDr56sR+zR5zMxR90nqvhQtoOQN+Y9PZaaBeBuTAAyXueUajbhoRbTmP/xZz9BTWtS/wrIUz2Jra6dtYwf2lUYidlVTSgD8QUKQwJjimPDGkbRyBl914d+QOocTVJO9lY73oga0PYydpzPcGPohtqxWsfpJD1YnijftOUlj/Cfqp98LZQbr5AbxDIpubBtFHLot6pCEEsPfp+BmUQHBcI7m0ocAXMm3eLIXBDlcehYzcQ9hv8RmLyu/CEniftPAGPe/m3XJApvhUW3xtiLYRyp25B89QgIZAeRBru29ulc4cB5qLYgB52fLmJulkkOhMhOcRGV+D9y5Gf30DzrUwKWQUrvup07i9l7oOcrXnBuaWO3tIzEjBE3Y8F8tcAC5bq75DxgjEKAGKu+IipsxwLwWyyZ0w8/nZ1+b6z3ptnXiTWnKf7/ORFzMZhqxaG5g+Dhp/zAcFRyi+/lyo2VxcdlpC7clCJrIty5iqJnBhjSXUdI0D7u+rO//JARqrNaPDC/1xeI2f+vu/QbDZlBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(39860400002)(396003)(71200400001)(6506007)(54906003)(316002)(66476007)(53546011)(66446008)(66946007)(5660300002)(86362001)(64756008)(8676002)(76116006)(478600001)(6916009)(36756003)(4326008)(83380400001)(91956017)(2616005)(8936002)(33656002)(186003)(6512007)(44832011)(2906002)(66556008)(6486002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ByooaPITpNmC7x1yoTpNq6BkqJYiRQWuksimc/vbe0Imgiw711zB+jok/bUT?=
 =?us-ascii?Q?W9a7mkhaGkd12kEJa8UqVFqhAXMTsyijIh6kI1weNfWTOirNeah8bgGll1s5?=
 =?us-ascii?Q?pvdUCLq9J1HGftbk3VsN3pTQ6qn+2Te88k/M9VQt3hL9qsDw2zsiNl4mcj5S?=
 =?us-ascii?Q?Vvuzy3WWZzxGgSXiGLtK+k7/hLckBWlOVWPnlg5CU/B+mcvdjJsuGjxz4eEj?=
 =?us-ascii?Q?yVljHkAEFqT8D7PSpNL+wtU3eaJpsVidJo2jiNfpAqymBzsxAx/L4EizfH/o?=
 =?us-ascii?Q?eDGATnfx/3pWr1JgX5cjUJQmA56gggmdQlWaD1gWYzCuaoCmKR2kFy5UAYQ3?=
 =?us-ascii?Q?RvuA6YxoHxml3ImilD7ggPLgTlzQ4DgWP6ETdBct2cWmiPFqEBYBw0gEWUNf?=
 =?us-ascii?Q?NzNXzJCmSYNETV5aNeoARQ/tCm8smkk6vHb4j6bj8gwXz0Z/RzRpmh3UqZcF?=
 =?us-ascii?Q?S8mPGy7HGvMZ4R9WVTB6prKOzI0wq9aU2IO49mtXI7qy6Dcl82VGVxYhKzr1?=
 =?us-ascii?Q?KX/3KqYQiyx/t9uQTe6jAioe7NHAsNjW2+37I6xVHM8UJFEuqdqe1JUtHsV0?=
 =?us-ascii?Q?J0BHNcKKtay8RbWHl9VaZOqKFG2DyUdh7/sBLk+/zthKYZ3cKVM11+icA7aU?=
 =?us-ascii?Q?zxJO5/r8OJ7yTqaJSj6tBLodmExhwrCJxQEGo8RRiDQ6VE0oy8b/zRJ2U1iC?=
 =?us-ascii?Q?/YrFM32RYi2szLaO6C839xoOWA6N77IrGuT+g6cwzWrx1OaHYVSoD1kYvufY?=
 =?us-ascii?Q?AtJxPhK+auz0Q2AoWvoelcT2bxgluNeW1Ijd24F3H36p8Nx1Fcsuc5z3ua9+?=
 =?us-ascii?Q?jV3XCmU5f/Nt/F7EhU1LIwDwjntfbuJzhTx130y64Wdnpr/2Kzgt1caz99ff?=
 =?us-ascii?Q?7kYqtQlaOpsUXET5J4W1MrHVeRHqGp6iYHufsR23rgImIigIqu4Cd6a7EFyf?=
 =?us-ascii?Q?qHQqMo+Ur7USU5kzpivPeDddOmQVY0OvKF2LSSPz9+MUM2RQLOf7S5tDWhl2?=
 =?us-ascii?Q?Ti2FoDbA6dJ9F5hxc15N9JRAXbwRJHahV2S6ym8VP8YxUFsmVwzvJU97yDMh?=
 =?us-ascii?Q?9v0ZREaJYK99cpIU1y2H8YbytMX2q5cHwkYMaXNvX4LMnFalQMkc3uFGSEDZ?=
 =?us-ascii?Q?0pILpnZezB48YEX8Jmo4X41eLfpGdznced06lPe96GvjNAmB2b7aki6aEMxZ?=
 =?us-ascii?Q?u8O8XSf6mYknrOr90vn/5IflgweKp2008ClW+4qMlLMAXC5Vfib0l31jKUO/?=
 =?us-ascii?Q?sX+ElDTIornQDaCn7Lci8sR6rbw6CjupanoKwTeXrswHOkh18WwAfuKp3222?=
 =?us-ascii?Q?ZCB0Bkyo9F1NYxf1b4xQeS2v?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <955B5FA4DB7E864C9C119DCDF0402B6E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc916c72-63f2-4e7d-0426-08d8de6f9c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 18:10:21.2932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aF3Fs0fKX0xePZlxM8R5Qk6QuBhZH1nuTKXQ6wvzgmd5pWrHOm5VLGsBU73K5lTUmSJwi7z8AlrVYsLoN0DLFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030128
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 2, 2021, at 5:39 PM, Steve Dickson <SteveD@RedHat.com> wrote:
>=20
>=20
>=20
> On 2/24/21 3:49 PM, J. Bruce Fields wrote:
>> On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
>>> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
>>> The idea is to allow distros to build a v4 only package
>>> which will have a much smaller footprint than the
>>> entire nfs-utils package.
>>>=20
>>> exportd uses no RPC code, which means none of the=20
>>> code or arguments that deal with v3 was ported,=20
>>> this again, makes the footprint much smaller.=20
>>>=20
>>> The following options were ported:
>>>    * multiple threads
>>>    * state-directory-path option
>>>    * junction support (not tested)
>>>=20
>>> The rest of the mountd options were v3 only options.
>>>=20
>>> V2:
>>>  * Added two systemd services: nfsv4-exportd and nfsv4-server
>>>  * nfsv4-server starts rpc.nfsd -N 3, so nfs.conf mod not needed.
>>=20
>> We really shouldn't make users change how they do things.
> If they only want v4 support...  I'm thinking is a lot easier to
> simple do a nfsv4.server start verse edit config files.
>=20
>>=20
>> Whatever we do, "systemctl start nfs-server" should still be how they
>> start the NFS server.
> Again.. if they install the nfsv4-utils verse the nfs-utils package
> they should expect change... IMHO..

I would prefer having a single nfs-utils package. I don't see
a need for a proliferation of these extra little programs --
let's just make the usual suspects behave better.


> steved.
>>=20
>> --b.
>>=20
>>>=20
>>> V3: Changed the name from exportd to nfsv4.exportd
>>>=20
>>> V4: Added compile flag that will compile in the NFSv4 only server
>>>=20
>>> Steve Dickson (7):
>>>  exportd: the initial shell of the v4 export support
>>>  exportd: Moved cache upcalls routines into libexport.a
>>>  exportd: multiple threads
>>>  exportd/exportfs: Add the state-directory-path option
>>>  exportd: Enabled junction support
>>>  exportd: systemd unit files
>>>  exportd: Added config variable to compile in the NFSv4 only server.
>>>=20
>>> .gitignore                                |   1 +
>>> configure.ac                              |  14 ++
>>> nfs.conf                                  |   4 +
>>> support/export/Makefile.am                |   3 +-
>>> {utils/mountd =3D> support/export}/auth.c   |   4 +-
>>> {utils/mountd =3D> support/export}/cache.c  |  46 +++-
>>> support/export/export.h                   |  34 +++
>>> {utils/mountd =3D> support/export}/fsloc.c  |   0
>>> {utils/mountd =3D> support/export}/v4root.c |   0
>>> {utils/mountd =3D> support/include}/fsloc.h |   0
>>> systemd/Makefile.am                       |   6 +
>>> systemd/nfs.conf.man                      |  10 +
>>> systemd/nfsv4-exportd.service             |  12 +
>>> systemd/nfsv4-server.service              |  31 +++
>>> utils/Makefile.am                         |   4 +
>>> utils/exportd/Makefile.am                 |  65 +++++
>>> utils/exportd/exportd.c                   | 276 ++++++++++++++++++++++
>>> utils/exportd/exportd.man                 |  81 +++++++
>>> utils/exportfs/exportfs.c                 |  21 +-
>>> utils/exportfs/exportfs.man               |   7 +-
>>> utils/mountd/Makefile.am                  |   5 +-
>>> 21 files changed, 606 insertions(+), 18 deletions(-)
>>> rename {utils/mountd =3D> support/export}/auth.c (99%)
>>> rename {utils/mountd =3D> support/export}/cache.c (98%)
>>> create mode 100644 support/export/export.h
>>> rename {utils/mountd =3D> support/export}/fsloc.c (100%)
>>> rename {utils/mountd =3D> support/export}/v4root.c (100%)
>>> rename {utils/mountd =3D> support/include}/fsloc.h (100%)
>>> create mode 100644 systemd/nfsv4-exportd.service
>>> create mode 100644 systemd/nfsv4-server.service
>>> create mode 100644 utils/exportd/Makefile.am
>>> create mode 100644 utils/exportd/exportd.c
>>> create mode 100644 utils/exportd/exportd.man
>>>=20
>>> --=20
>>> 2.29.2

--
Chuck Lever



