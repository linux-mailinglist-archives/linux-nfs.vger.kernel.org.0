Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE423467FAF
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 23:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383307AbhLCWKt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 17:10:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56052 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383332AbhLCWKt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 17:10:49 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3LAnHh006532;
        Fri, 3 Dec 2021 22:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qwVUlwWmMx+ChYVYaYrnPozkswz41RZy3MsjaR6hmfg=;
 b=jMNmag/JVXJZ6OimHKRtIa+th/x0oHhZAjZ9UpQ+IHQ5iNHfhpBULQEWGaW3mDwoWu7p
 LSZDFU0+rUsOSCu/iVnhWRmG4g2Tfk7wsZuAoS9Waoy3WWclD5FRyGVg8a1jB7JTy3zp
 lsMoVIWtgJX1c8qrH9BWHDNrJeGb0zLzUGVie6NJHRvHDsQy4EnlD+Xd3eBe+iBNUPxK
 ShPHmjpWl+G1cwOAj9WQGTQJBNfaBsn+QMilCIvmh8TVIjHa5jTx+9lE6jhy8k1JhibF
 RCD+8uyzUn1Cd2iZCdeh4lMVq/yYF4exlUEmOSUQ725GYg5evD+I8eBB/cYXAiarMiJI Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqn0m2qh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 22:07:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3M5spg180854;
        Fri, 3 Dec 2021 22:07:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3cnhvk3ryq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 22:07:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkfdKmRJtCkok/vAsy40K1SJJf1KirTrIbu11z0HIegVrGwDZPKYwzwGYNaLa40eXniHtC5sQDhG+17sXEbnYANEinojtw2EvCBx8SjI9vFR7SBXnfBtTUZyUminL/K9kE1epqdj76oQZ1n804H9MAjzn2iwalWMJeRrjWTfXY8eELXOxQScjja9P+L0GI0xV1GDeClUCNEnonc4Lw4DZFqYMrOioIxB5TS+AeTF2QV+KeZCeNea1LPDufUXgQypRPjMGBhHcZMKzqm28+vSw5fr5ETmV8oE6uTIiDqXOIApSuzbet+neD4ZpM96bI1CQalqemjL2oo++r0Fd2mq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwVUlwWmMx+ChYVYaYrnPozkswz41RZy3MsjaR6hmfg=;
 b=itSJKD2FxdTs7ENYKSbLGu5OQS7rZpkvgW9JIXpCpdBoT9C4dcC+KF7tONslkGpQtux93D5u66tnq+mY8jxMsTODIVelVmRj6CT2w2n48xpm+eWXeJyfjWpx3lSHoP7UWW+Kj1CB1r1U5+rt6qg6el+EcVqjoBLWELbPKLbMV0ElpK2huNWv1KrMV1Ya60Ak1YYiSLynxxJH8V4BnXf9YpDF+cSnpchomABwq6eFE44+ID0ZMHCpR622bZUTnD3D0qKk56zrhXsKdA++tF0Dgreks4E5XUyyZSbfR88D2J1o9WYnvv6hQ6oshgIQOGNhe6RmtIwuGnyLnhN47ECTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwVUlwWmMx+ChYVYaYrnPozkswz41RZy3MsjaR6hmfg=;
 b=Drjo1ip9koltBtdFbaB/XCWYFLNuZMOLkpSUtRn44pj9SclmPzNnzrmSD9MZjjKgqBN1mYMLQXwCyv4Tp4PD7BoPwu9XNTRz4PFzAvOJZtrNr+SfejOSZjqvsdwVj/EmkWaOilCfjdEXX8hbj8ChB6lwdS6mXBs8DcXcIaiXUcc=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4280.namprd10.prod.outlook.com (2603:10b6:610:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 22:07:19 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%7]) with mapi id 15.20.4734.022; Fri, 3 Dec 2021
 22:07:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Steve Dickson <steved@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsdcld: use WAL journal for faster commits
Thread-Topic: [PATCH] nfsdcld: use WAL journal for faster commits
Thread-Index: AQHX6JCDa1WFhrhup0+3fBDNUtx+YKwhUyaA
Date:   Fri, 3 Dec 2021 22:07:19 +0000
Message-ID: <469DF1ED-C2AB-43CE-AB70-BFD2AFC2A68D@oracle.com>
References: <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org> <20211201174205.GB26415@fieldses.org>
 <20211201180339.GC26415@fieldses.org> <20211201195050.GE26415@fieldses.org>
 <20211203212200.GB3930@fieldses.org> <20211203215531.GC3930@fieldses.org>
In-Reply-To: <20211203215531.GC3930@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ac5b1a9-a24a-439e-83f2-08d9b6a94686
x-ms-traffictypediagnostic: CH2PR10MB4280:
x-microsoft-antispam-prvs: <CH2PR10MB4280DB45E013201EF90602E7936A9@CH2PR10MB4280.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dXuX6EIH8znFHx5+dydb1urIZ3OblbWB2YufyuEC1EClDiKZnbLpmqHzhfUZypoAd7hqPxZRczWK3feX/Nc21o8RRAqj9rCv1qDRdf93p0Bs13L40tzFiUwX7bY+Hhsmk6oVLfd2cI1sYZ91neSbyDsDWYQUzhsaTb91+WHwICIMOggkemUTmLLOSHd482TV8BKgUkH/ee8do+9rnxjLCC1El0PqzK7UlumFJPvj6kSGam3iBpq06aKmgRe/MR8I2qHMUuObvrOVY7d3qUYZ+UqXKkfP46aHA5yjlMMqnheCxGmTP3/duZbOrhb0qoNogNdbbnk+xhdIjBUoblr4Podxx63eeeMP+5WouTcUYRVzZiMjf7vGqzi0XxS3F8qemJ6sc/MDRH8WbnyKgS/BbtFzE2YH+0j0orFzx8zFVXjUknFKyZtd5v4gmPiL+Zb6L4jdaelp6MPWPhtq1n90foRyCJpEK95HolVPLsthKG4ZJhDeD+lbXSUQ8OQ543TqjgfbgWT9ObqP9s/I2UC0kdRj2SxCt1E2YxxogD4z8bECQNqXdRdtiR/D/cKvnjnIYsxRvuVKQU0w8NGtSfc9uOLvz+LumopU7iR2/F6c7dqjLUmh3tgPfEa6VWedUVvEdYLWUafNefIte0RKBoIyx70UeRSVG19ff2rg6cf2pBU7F48Wk9xmqlE4ZulMbJF868W1qraH2Ywc0J391z6GK8mnR3nj6CvDnPSCgeegSAywfyk5itYI4koKodwLSKdDjgvD52DdbHhaRwpcqxRCLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6916009)(6512007)(4326008)(8676002)(122000001)(64756008)(2616005)(5660300002)(86362001)(71200400001)(53546011)(66476007)(83380400001)(6486002)(33656002)(508600001)(6506007)(66446008)(8936002)(38100700002)(66556008)(36756003)(2906002)(76116006)(38070700005)(316002)(54906003)(66946007)(26005)(133343001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OTueyU45r4bPa1YaeFwUwOaqV445FMLqz5XBu5ULCrWWrH06P/vHyvo7nHZi?=
 =?us-ascii?Q?1agHo+nIvLO30EluLYg5G32kQAnqx4KecFY7wVzJF3TX+HwaA3ap6UdYzBDf?=
 =?us-ascii?Q?3q5FSaAWwW2H61L21GS4f25x/ghkODvyuiseVhEdKHvkHN1J+P04nYVGiKWE?=
 =?us-ascii?Q?xi5AF5uTZesCi48ZS2dwyD63HiO8ckCUwfopZUcBlyl+fUxTiBtnO6Y48ysw?=
 =?us-ascii?Q?5TEuuncKkcpVZpn2jChWIP2WC9vEN6vxfyfc8YNK2Ve/D8y1cFteap7TY3C6?=
 =?us-ascii?Q?61Bx/E2V9KJHgq+31FYruAJRvW3IMMIHTfyFEZ/PEm4Xz0WmWuNYDYJwHlry?=
 =?us-ascii?Q?y8lEFVWxjU278+QWV0vzb/hejwdM6fNUfAZhP9Cg1EceGFGW5GLP/qdTa6ni?=
 =?us-ascii?Q?pJ9vPGoM+q9BV+iZTOd6EdTwIccBL9mvqmz/T5Yo3YWi4yaw042zeT4ujIuO?=
 =?us-ascii?Q?t2+b7RQGqxkJDgXD7nY7SECSOkHcFX5O9zAwwlsz59u1pGu+rYdjtgQl2dL+?=
 =?us-ascii?Q?bxPyN8zApj/lekXuIA9vKO3m0Vq1EaRwHSPLEqtj23+Uxc8YT5JKaDFi4YGs?=
 =?us-ascii?Q?CB4BpiFQg4F/nHZz7yLbr3j83ai9apiTinGh35PdiM5/gbZD1Ojhh8bNG9ZU?=
 =?us-ascii?Q?yV8NmsQEd/Fx9Wa0orEAqAW5tNuyHfLlGD3CDIPgq9dEGtqcuukL3rcjql3i?=
 =?us-ascii?Q?vZzH56TUp4+I1Mk7DMzf0FF3eNs/CQ9Y93tuyVnY+YeWtz7vSEPT5uLQX8ny?=
 =?us-ascii?Q?JtCv+pfQRyK0466cH7chevdblCMcuqZCC3epn9/k2njUL1Cpql7KK1JGllI6?=
 =?us-ascii?Q?5UEU3LIgpFAS2TmmuA9B/9YxyBClPeuaIq3wAa7fT55w+eSM2NYAHCwjlTjv?=
 =?us-ascii?Q?/5lzPbYjFyLd/fu+bOKPda6/z3sVkt/mRWyRlPLFm/OjpxVTtpZOvJ53NHvg?=
 =?us-ascii?Q?GV4DMaQPgQ6hBsOSK9VzAQSfW9bB/6B8fRIMgXk+xPaYnA3DjsvGzz9KoPOp?=
 =?us-ascii?Q?UZUJ63I3mSYJyY2VuisZZoiOqEj0ECee0G/XS0WMThXoUd8FZgdTV9VosSe/?=
 =?us-ascii?Q?Spaw+eEHsmhpJuwgz8b5462MDKDpwpM0Uaj1Zrnn9nzSoTVHmneVl1SVMuDf?=
 =?us-ascii?Q?q2onyR+qHI8I54ajhGRXIjE+I3qxRDC9Z1jzB8uPRvZktyeeWI5fUg+f/Dyw?=
 =?us-ascii?Q?Qq6heM4H3RieT7rQYIqxdiJe57HfhNJGw3Nbs+mN2n2XNmCIk991JxEBKfMA?=
 =?us-ascii?Q?G2Mq49UWv317w3c0LjCfo3XyY0ydOk8y4dhH4AVSGcEm11yKBejz15jZqxDg?=
 =?us-ascii?Q?gmoCiFrVb0TFNQ3209vYKlsDkLltg4/eMK5M1RIWaMb8w/ehZkzwXDyAWOps?=
 =?us-ascii?Q?zYypN2oV1JkkSbsPvtr2BEHCnowvwUSS1JHDThJDqG8eImmiutdXsFEhAl4z?=
 =?us-ascii?Q?xjq50qHkAoYLSfBHQ52Mgq96igaDT2CGGXlVKiF8ToQa7kfEtwaZK0vHDdWz?=
 =?us-ascii?Q?bud0Wh8kmnb/AT4hc0/O01p4CCRGk9v3hoCr2YOfuSi285m6vUzfzKgwmwRx?=
 =?us-ascii?Q?yl3uiuCqUoOpPvM6Xs6mkf/kaGu/5eca92Q9EOC4cDFiWfxPU9ErBn/dIels?=
 =?us-ascii?Q?0J4NwA4h90VwidUQl1IjcAw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0D3EF12E5268F4BAFC4CCB58B154F5A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac5b1a9-a24a-439e-83f2-08d9b6a94686
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 22:07:19.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +s3TNyyT3IjC8eJvyRrNpvQ6vEVG3t9QMSI3O7+l5GiyTaGEdsE/+lmxFvob/c92RRaaO/w75++bejTdXii/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4280
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10187 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030142
X-Proofpoint-GUID: Eudx5_7AxsRImRiw6z9X86wQf5guE6Km
X-Proofpoint-ORIG-GUID: Eudx5_7AxsRImRiw6z9X86wQf5guE6Km
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 3, 2021, at 4:55 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> Currently nfsdcld is doing three fdatasyncs for each upcall.  Based on
> SQLite documentation, WAL mode should also be safe, and I can confirm
> from an strace that it results in only one fdatasync each.
>=20
> This may be a bottleneck e.g. when lots of clients are being created or
> expired at once (e.g. on reboot).
>=20
> Not bothering with error checking, as this is just an optimization and
> nfsdcld will still function without.  (Might be better to log something
> on failure, though.)

I'm in full philosophical agreement for performance improvements
in this area. There are some caveats for WAL:

 - It requires SQLite v3.7.0 (2010). configure.ac may need to be
   updated.

 - All processes using the DB file have to be on the same system.
   Not sure if this matters for some DR scenarios that nfs-utils
   is supposed to support.

 - WAL mode is persistent; you could set this at database creation
   time and it should be sticky.

 - Documentation says "synchronous =3D FULL is the most commonly
   used synchronous setting when not in WAL mode." Why are both
   PRAGMAs necessary here?

I agree that nfsdcld functionality is not affected if the first
PRAGMA fails.


> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> utils/nfsdcld/sqlite.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
> index 03016fb95823..b248eeffa204 100644
> --- a/utils/nfsdcld/sqlite.c
> +++ b/utils/nfsdcld/sqlite.c
> @@ -826,6 +826,9 @@ sqlite_prepare_dbh(const char *topdir)
> 		goto out_close;
> 	}
>=20
> +	sqlite3_exec(dbh, "PRAGMA journal_mode =3D WAL;", NULL, NULL, NULL);
> +	sqlite3_exec(dbh, "PRAGMA synchronous =3D FULL;", NULL, NULL, NULL);
> +
> 	ret =3D sqlite_query_schema_version();
> 	switch (ret) {
> 	case CLD_SQLITE_LATEST_SCHEMA_VERSION:
> --=20
> 2.33.1
>=20

--
Chuck Lever



