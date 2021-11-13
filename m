Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B58544F55A
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Nov 2021 22:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhKMVJG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Nov 2021 16:09:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48370 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230189AbhKMVJF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Nov 2021 16:09:05 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ADKqKqt014045;
        Sat, 13 Nov 2021 21:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iRVq+iJn8SlxI5Sjg9KFlxUfDJR9eSZFsEiuqYaJUkY=;
 b=DrjLs+XeAZXB+WSMwnup/6D1USIq5uELmaijfNDu16SczE+0lfj8qkqpmOlArjg6Yt65
 mIYkJTaAP9sq1yuEzYIaT6KVMdR09JK5LfNYIzdhbFogn6lk369ET14GSn3DoFwO5ADX
 oeOuVDQlNfQUd9AIx6xNno4v9bbmrtx8qDty8zrfc7naIKJjUDsPNBj1kO7nHevfrhHN
 K/k5W/Du3u5K4fWL+gJfXh/VXBvA0RYiK3jDUeW+/h3WcSkngMKvGC/arPsYfSggHIqi
 NNJ0TMjSMIEVGebjt2JvupGrRLY1EAYoncVe9SsbA9e8KDYebLlV7EAaeTCIwM37Chlu 8w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ca3sd9r0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Nov 2021 21:06:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ADL64mv147361;
        Sat, 13 Nov 2021 21:06:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 3ca2fsyka9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Nov 2021 21:06:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1UPN6MGUFe1fCt3eJ8uLyURzJbpuwEth5b4t70fzELQOvSK6mh8KziiMcNvMrPpezJRpJwtB9LsUT+BGTymLw/PwbmHZCQq7gF+pSv9KZmDgVPbQBfobDLg1JvkPnASfFm3UWIKXH/VPIAakTO5VbxwmOBVYW9tA25oBRZITxZpxtShlaDD+Z2HwqQLW8abZVdxBvlLWpEUzErjhGmJWKGWV6Sovxbpm5xswDXkcWjypti4LjeyWpX9Jk9Mgo5NjtBu2QvuTAkbk725VbwNixW1xtYkuMqG6STL7goK468u/Hw47OMrVyaFyy39w20zIY/l9SNN4xPi8f5mWvctKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRVq+iJn8SlxI5Sjg9KFlxUfDJR9eSZFsEiuqYaJUkY=;
 b=Hdix0qCXPkTnc+2EHiafEaWb7lfq3K4NmqT1k8SQQoDRsNSVZfkn7GAMDXoNKtvnB24qfErXs2yMPFsce2qocz6Ze0z7cbiTjarSMgzxxemDZM3N3+gKdG7x37gFuXxsKyRX5LJZHwyrlqAsCtNCssyAqhAvU0ffl4yo0LgaN3IdOpMFq3Vpe6NQZGlVyJy2JQZiZYF55eDoVI1KSbnko8823nk9MPPJx378OyY87c8l9zGR6rJJummbcHGVnZQb5LoHLUfy19qPi+bz+IodCVyGw7/0W/RVQkxrPMW+uAPGiECaMWpSCuEeRYREmqxxGdGauSD3/ccWBu9HpQ86Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRVq+iJn8SlxI5Sjg9KFlxUfDJR9eSZFsEiuqYaJUkY=;
 b=pAQiavMBJ8YifMFVs9DN8qEnvAjXL4SDcFUak/1utEjaGXGszgJUr+IVQgRmogsRpjT2M+TPAeYz/88sAArHOmvdstJNxKDON3KR6gR5oOZQrwtcX42VQn5x7zh4k/1aEQLbKRln1VDcxCLw8TdamoXOIHPuBzXdxmy5tPazMi4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3221.namprd10.prod.outlook.com (2603:10b6:a03:14f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Sat, 13 Nov
 2021 21:06:03 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%6]) with mapi id 15.20.4690.019; Sat, 13 Nov 2021
 21:06:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "rtm@csail.mit.edu" <rtm@csail.mit.edu>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Thread-Topic: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Thread-Index: AQHX2NFEStLOh5EPHEGsmzKRU+63DKwB8uQA
Date:   Sat, 13 Nov 2021 21:06:03 +0000
Message-ID: <11B4530A-C0A0-4779-A9BA-F0E19B62C5A6@oracle.com>
References: <97860.1636837122@crash.local>
In-Reply-To: <97860.1636837122@crash.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a878512d-28fa-40fb-eed8-08d9a6e966d1
x-ms-traffictypediagnostic: BYAPR10MB3221:
x-microsoft-antispam-prvs: <BYAPR10MB32214AA48F8990BD2B183CAD93969@BYAPR10MB3221.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EPztxzzE7r35RL3mMIbpgyjCb8LGQAcKakTO9PsdPGkgVlBKWK6SWhaj88cw+9yORAeIkyM3xMDwY61fMiXXh+j6P1BSA+WkgeQc/SsyDhvqx84vVPAf8V2meHuqymxY0Qfu8/nb/u1jpQjVrUXabXUe9fct7HGUq1gZaj0z44/HPcFtsB0XsU777VmWQE201DJd4fKLkhvdFrty4l9ciCb5bx7ooEPzeHUlE7QwCw2Vc5GdY+Ou5bMXrzEorT4NJE0mxmn5Z/Vl2ZN2UxpMg6GkDfMIWDaMQZ3BtTeVPO+GvjCx/0TUwDilNWSlwnxqQrvsZQL2ghOvAJc5ETIw5+cMIfoocQd6LLeT5qnnskrFR/X1n86LpDCZ1lkOSg3HAFbLFM+gGiaIZIOULR51X1vvWPITuGjjxfkXB6e5C5sEH7DqrqqjBbctydGmJRe9s4UgmA9J3vfnZgMoYKGrnA04xAN6KsrVfZYOzCyaKFYk4zwdd882ySrJRbHgwdF2lwd1zvnsKSqY8sbaECEeQ8W2JomwVugV44eyTqj/010OR0EU99V45aW/bY1LeSk8PfXjpJYNae68aWstnrJcbnFhr44Aj7In6Uu/IxmPSLXbXKqeRNJQzUvu6jUa5ktYebwMpG5P8Onaa8FeW24OVMM9J97UaphWbnmKUZM9f6MRF6XgPImDDPYseMUWIvYGejmS/TAAPOxsnfsgIR6oh0cbvsu8vD8ZFCMVADCBnsWjwJC0DQ1qtwW3avI79tqO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(316002)(6512007)(6506007)(8676002)(71200400001)(33656002)(5660300002)(2616005)(2906002)(186003)(8936002)(38100700002)(6486002)(122000001)(66476007)(66446008)(64756008)(66556008)(38070700005)(508600001)(36756003)(86362001)(54906003)(4326008)(66946007)(91956017)(6916009)(53546011)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SD3hhIpKHMbmCEMIk5nvp5M68vFDvw1bRIGXWZzmBPWk8ZTj62KWa6qhOuXM?=
 =?us-ascii?Q?wowBjGKTv4pILutXCYQBQugO6BKa2sYyQs6UXmlhkahjIjYTzYpvI9BlW7mj?=
 =?us-ascii?Q?sadCygYNWbAu/PqwAG4yjithftzDL02uBkebK/Qpninlhhvj0a/FGAOH9eSC?=
 =?us-ascii?Q?WmpskKDk8YFKwPM5IGdzDp/XfeCeK0wfgvy4Z/2/vrFDfdTWVbuMYuh/8jSu?=
 =?us-ascii?Q?hihUosWl8s/RAsPQZLG7l/eE8+Pr/1VJ9E9oC/ba92msBaiebCBlCxX5GJp5?=
 =?us-ascii?Q?Sl2+e0sjb9x78burSKt0RxYIjciAVLji9npPjSC7hQRifXGn8RnsLPg0gUuo?=
 =?us-ascii?Q?ZGbu+sDVY/EKpPDj0Smefi13dykPQBulsbwdcT+vUF8vRVnwTsiqbDMZniS9?=
 =?us-ascii?Q?JOBJ646/f8M5G9/yC/JRb3pafVGWoXRNqvKX1wGSeXE5aCP9ykdu1M03EUbG?=
 =?us-ascii?Q?DxPPzuAUD7xB7iajx9wSjrK8fCdQeprOyW1X7oyGpK/e2m33F9lg0c5ujgpq?=
 =?us-ascii?Q?YlvHSfFECBeQBCw81Q4IMUigN0tVMV8Ttd16QWfBG3bPDDPAwiV5phcSuSJH?=
 =?us-ascii?Q?uqs1UCp90hwFI4y0UqRVL9adWLXYJa8WeEuMXc0p969P3Nk4F+iAcydBxIXm?=
 =?us-ascii?Q?0gL2i7DML/KM4Ovys0T0PT+/cRFQi7T+CuKyqpHYIedBnfE0aWdo28ue+pBp?=
 =?us-ascii?Q?r7egM1QENDb6Du61sdQUyfGN1MY7vv6dXIpj/bV1h3r5KUFY8PkO2+8EStuf?=
 =?us-ascii?Q?BQn7MnlgLFsrAMbdxdjmyPnde/croEMq0Cqs/lLYJ2+uGbktJt40zvJW7Q7T?=
 =?us-ascii?Q?6FUd66IjN+gyjDkAdtBR/j3QZQLsCJat/EO7we2046xIE1Lke8KctnJGY77v?=
 =?us-ascii?Q?0j8YPObGNR00178/Ttqpj8aDBu7ZF9K/BIcfmut6NnpA7nI0cU8SEuOzj3k2?=
 =?us-ascii?Q?Qccbk4ssN/6cO/Ux8Hz7+KibTyOvP0JfDJsBIN/SIoemd6seakZ99h8i/gZm?=
 =?us-ascii?Q?xa030aaze2lihdJNwNc+q7V4DWr6kVRFv5kezh4RshCTyp8GEWNbl5Dv9rhW?=
 =?us-ascii?Q?aRPyndH3rJ/5mWK1o7TxJfrJ77mSWkE/i1MfQJeEKKkh5CIFysonzZHetrmv?=
 =?us-ascii?Q?u1dHIY4rmFKwt89tLRJPDWDnuaDmNlQmDhsHwNlwo5BgEXWOZ0oa5eA6PVud?=
 =?us-ascii?Q?MU63kt/qXojD9yPO5jfIZ+Jd7yrPreMabkNhfAKCXjUE1oGDvb5qPm1s+v1c?=
 =?us-ascii?Q?DEfuX/J9xo3hqfChI+xR93zBp13lBoSbvMr/Pvx9MDTXtyOMwJ5XkYkkXYJB?=
 =?us-ascii?Q?WidFpVOazPPfObIShIoj/gYjowVHSzIe8E9RV29Al65qc7+V39R98LiHs3PN?=
 =?us-ascii?Q?86Qqbyoygw3McRRlKmGNmPp0pz7xSgQi7TBmGgbJpCgReKykfsR72sYRTlsi?=
 =?us-ascii?Q?BSBMo7+23TRHwXnSe8q62FP7w+7gIGbMNGWzIg8BEqbSUJpJnNEjlxD9fjfq?=
 =?us-ascii?Q?23VICqVHvsiTgMcwqEMagf1jMrxBoei1hBkVJa+2ZDi+EnJ3btndMU5YTy8A?=
 =?us-ascii?Q?CGoRZPLNsQxjmrPJ2XUL2oUqp3E3FB9UP7XrIArEKEuAMiY7QLAoum2Atk2z?=
 =?us-ascii?Q?ocHhD2LGZbL4gSdpjHYdJno=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB11231FA95A8446BA0069A8F7615E38@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a878512d-28fa-40fb-eed8-08d9a6e966d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2021 21:06:03.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3SFiQsL738AN6dKQPbOYg80X5FOsA4skBKtxNSyc5ho6JZFqSplQcze2hO7YRVVvWJk7agd2/8WJDnSjMpYRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3221
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=767 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111130128
X-Proofpoint-GUID: Pr6wRd0JOpjcD6R2b2N5SjqsQTXG6fYo
X-Proofpoint-ORIG-GUID: Pr6wRd0JOpjcD6R2b2N5SjqsQTXG6fYo
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Nov 13, 2021, at 3:58 PM, rtm@csail.mit.edu wrote:
>=20
> nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if the RPC
> directs it to do so. This can cause nfsd4_decode_state_protect4_a() to
> write client-supplied data beyond the end of
> nfsd4_exchange_id.spo_must_allow[] when called by
> nfsd4_decode_exchange_id().

Thanks, I'll look into addressing this for v5.16-rc.

By the way, can you tell if this exposure was in the code
before 2548aa784d76 ("NFSD: Add a separate decoder to handle
state_protect_ops") ? (ie, do we need a separate fix for
this for pre-5.11 NFSD -- I'm guessing no).

Is the current implementation of nfsd4_decode_bitmap() a
problem for its other consumers?


> I've attached a demo in which the client's EXCHANGE_ID RPC supplies an
> address (0x400) that nfsd4_decode_bitmap4() writes into
> nii_domain.data due to overflowing bmval[]. The EXCHANGE_ID RPC also
> supplies a zero-length eia_client_impl_id<>. The result is that
> copy_impl_id() (called by nfsd4_exchange_id()) tries to read from
> address 0x400.
>=20
> # cc nfsd_1.c
> # uname -a
> Linux (none) 5.15.0-rc7-dirty #64 SMP Sat Nov 13 20:10:21 UTC 2021 riscv6=
4 riscv64 riscv64 GNU/Linux
> # ./nfsd_1
> ...
> [   16.600786] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000400
> [   16.643621] epc : __memcpy+0x3c/0xf8
> [   16.650154]  ra : kmemdup+0x2c/0x3c
> [   16.657733] epc : ffffffff803667bc ra : ffffffff800e80fe sp : ffffffd0=
00553c20
> [   16.777502] status: 0000000200000121 badaddr: 0000000000000400 cause: =
000000000000000d
> [   16.788193] [<ffffffff803667bc>] __memcpy+0x3c/0xf8
> [   16.796504] [<ffffffff8028cf0e>] nfsd4_exchange_id+0xe6/0x406
> [   16.806159] [<ffffffff8027c352>] nfsd4_proc_compound+0x2b4/0x4e8
> [   16.815721] [<ffffffff80266782>] nfsd_dispatch+0x118/0x172
> [   16.823405] [<ffffffff807633fa>] svc_process_common+0x2de/0x62c
> [   16.832935] [<ffffffff8076380c>] svc_process+0xc4/0x102
> [   16.840421] [<ffffffff802661de>] nfsd+0x102/0x16a
> [   16.848520] [<ffffffff80025b60>] kthread+0xfe/0x110
> [   16.856648] [<ffffffff80003054>] ret_from_exception+0x0/0xc
>=20
> <nfsd_1.c>

--
Chuck Lever



