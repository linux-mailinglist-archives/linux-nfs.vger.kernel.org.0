Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98BF3E82D0
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 20:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhHJSSc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 14:18:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56300 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233353AbhHJSRA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 14:17:00 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AIClxn016502;
        Tue, 10 Aug 2021 18:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Mj4w4xn/LGbWyLHuGkjlojq0IUxuIENC/NmPcQc99rA=;
 b=zokHPHF2QzU/qq7uQS2+AQTSkZ5KQMsmvQ8bfSaPBBe/HxK6B8t9cTtqiSJijKYasM3S
 yETzEz9GLS6Sv1ruhdsnHUF41425rJNoATHkI5CUCs79pk2oLgA6FSgMYxNME31rFk4K
 CunWQwt+h4KiastFMT5G5aHr7PEvbcox3KyzL7O5vMnyA8NOhCmDwK3N0ff0lndLPipF
 ZFa3wXsI/gek+jp5CO2mRDIJ91OqbAfiSPYr9aJSniUe9IjyCmdKDVQIv7inNDmbyuHd
 zEsilWDGiZZzqMrlIBwdpnm4GhxbQblOWnz3EuEhKE9mWPo3pxAntFqAzOga+nBclleY 2Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Mj4w4xn/LGbWyLHuGkjlojq0IUxuIENC/NmPcQc99rA=;
 b=xgn6G9St/nXzAuz9To+WGGH1RRxEhBznz8+vvmOy3CgqTSCkTE7CnqQ5pvoW3MnAyJPT
 VsudJWRmEuRgLjo6UzYhH71jQTnfTlu0i8YW2nfPBA9QCQnP2LY8iLFi7LEiqTpVwGfR
 DgHcucHPqpqV5E0CkG1LQZMz41nYqZ7QPmVnpVH6mZAWDpgeIy4qFTUeo2fn6Rh+hCL1
 MuhmgbqVe0kt+gAvu13S0cHk7CBFfyEDwo9Dg/oIs6Zak6v44WecrYhAcRKFAU7RD9Ia
 feLXeJ1nNs6IG0RBMeoI1gAA4p78/8/bBZ3oxWKNspcLLLemuGWTlgPgws/yELEL9ylN Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab01rcbum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 18:16:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17AIASXC039863;
        Tue, 10 Aug 2021 18:16:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3abx3u9e7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 18:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz0eddvjweCFq6uGiCGx92qemCwhob2y9s7wWdGG4C3MaEFSTlr8LIXxn8wCCecub6kN6YFkfRH9EymXp0t2QxGJTwx+XuWB0f55xtwR8xkBj8METu6cNjt0/Ye1nC5OI4VllWDr2yoAJ4Ae61Y4xGSCfFEdZJqTHSLO7f8fW44nAun0+3tb5xLVOuRPo19xa+qZ5kYmIvmPzdSofD+RB+t51MUGWjDWwHKUr7Fw6LsYsKWspsVFcNl2K0N+Z6r2NAJvhlkuRnb01vOyojyVQnSWyYUbuNgAUD0Cg1dIy0CcLm+7yowW41jHJCY/sVrjQUB3/NWmjU4EPJdt3bUa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj4w4xn/LGbWyLHuGkjlojq0IUxuIENC/NmPcQc99rA=;
 b=WGpLKd2JnYxg5hp4OSpo1BTHk9zAoSkZqkJRl3KJln9Nn8QSYfmllyhvFM+uCtIEQo+zW43jbyU1Ma9oNVQLSo1WrthbZcmfu8IvUGXjcajjYGlJVlPIKST2xA5yna8o8PpmRJCiQW6rpSA2Ao9IdVETodj2NiiTJbmdClCbw0tDfIFiflDjZ1AxuX+1EFIBCBTXT7igV9tolZyEldI4Qgv+nE8sSyT2+HLTL4Ng27QQU1L+D+roHDxZATem967Gg9ZEoNXfuH5ncEC8jQ5jUKGACskr4o31Ymex8ihCWKMyVT1l1u07KRoMi054z8YrCGRmFWTec9to1kZQEbRvHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj4w4xn/LGbWyLHuGkjlojq0IUxuIENC/NmPcQc99rA=;
 b=C/9HwybL+29P/tTnaVqGEJI89iPhStS3dcesgNd7qXyVoYBAz2pAH388KC+cqa70p1kWz2tt2A350e/l0fX5cgVAk7Kdw055Emj/ik3GvZAqdFPphfZ7MhMQuu2uaGkXtCPyPXCKbggUZ0FrfjpFT7QZUOrQRKRkRVFKAqibcRQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4212.namprd10.prod.outlook.com (2603:10b6:a03:200::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 10 Aug
 2021 18:16:26 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 18:16:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] XDR overhaul of NFS callback service
Thread-Topic: [PATCH v2 0/7] XDR overhaul of NFS callback service
Thread-Index: AQHXebMTaSxcscBFIk+X10jNgh8JrKtcBXKAgBEqtgCAAAQagA==
Date:   Tue, 10 Aug 2021 18:16:26 +0000
Message-ID: <BA8CF63B-5328-42C3-AE69-92766C0EF556@oracle.com>
References: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
 <02B12E59-E014-4CF6-9A5B-58E5F426F964@oracle.com>
 <CAFX2JfkSG5Qe4_svtunwRhMvwdN=bNP0VtuSFtU6siDihjWpZA@mail.gmail.com>
In-Reply-To: <CAFX2JfkSG5Qe4_svtunwRhMvwdN=bNP0VtuSFtU6siDihjWpZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31a9c4ec-d9bf-4971-04c6-08d95c2af7a3
x-ms-traffictypediagnostic: BY5PR10MB4212:
x-microsoft-antispam-prvs: <BY5PR10MB421213BDE58C560E6792FEB893F79@BY5PR10MB4212.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YByDicyIYsLOmx4htTm4phT3FVj8sa20U/5/AThK+DlhBa82Zi1Pj8b64jbUq2WJrwRJMN1dCCgwAB/jgJxoyCgFEip59ID3mIOO3QFjLwRw8B44CFJUy98UWicmXcyg1565NPu8+QS+f/5k2mlXSlxohSIsG74ju3lUhW0Bqo+MdrcpvyZuqmfP8De+z+2ShpqcHjB7nPvd0cx8LD24PygL2B9vtLWwerTIZ8ru9YSDSCU4Zzc99OvlFRoGo24jSjr7VcVS0T7DRWDpqnF14m/Bcoq/wt8I0JDJSVNykDgTeod0+PkqLkjdDSscwL5VPRT3Ww1sgUGbia3p30nl8XewzN95R8jfc8Bv9dRTfpHM9YascaOVvPeuWH9wOmxrDQiiVmxb+mmRgT40qR9KL9S4jbSf+5RGzODgyHyMooP6qZWVxnU81v4orqRMoMu51SoiBREgiF8uC3fpzuIm3Wp51Ibyal9KqFmCyvAP2HFT6NcD4imaK2zQJ83eSIYjViTMVlLjaCr3nWEja27b5rarPOzquzYEU/5mi6BRHk78vuDn4eonm9T/kMnr9PaNrQ3otfJ89XpCcnG0d7rT2SxRW/1TSa/0JWLgtK7nrkyQPxGIQu5WBFegAZ2K/Z4+wcNhJV2lvmDE1AllP8/n+uCUxhgdMzbVV/pQhrzpSgVWMZzadp4HH0ZrpxUHuq09uDE39oZ5syQS4KVTW1oxfLW5Va0mjB9oQWx0yJSn7oCXxDWEiC/3JndhYgvTKFa6lalyTtmvjXijAApzctc86IWweLr67gsn7Vlp2hqkytXfenb9cCgd6v5a82H+I6/D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(478600001)(966005)(316002)(54906003)(8936002)(4326008)(53546011)(6512007)(6486002)(71200400001)(33656002)(5660300002)(8676002)(6916009)(6506007)(26005)(2906002)(83380400001)(66446008)(186003)(64756008)(66556008)(66476007)(66946007)(91956017)(76116006)(2616005)(38100700002)(122000001)(36756003)(86362001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G8l16s9lqU/lGEEcTxKgCUatxj3tovEv1rtGPPW+0UnomFh+aj/Lk8LqliK2?=
 =?us-ascii?Q?sX7vyxJ4U2PtGbo3LLWF7X2Zsmawj0SffGGdD3jq9b+dttQ+hICC25L/QdUE?=
 =?us-ascii?Q?M+6ZBJkufnAPWagVM5Z/xsyTcIPjo/fnmd7vbF+qrOR4dUCE1ARz41X1aUVe?=
 =?us-ascii?Q?zMFFEEAalQTu1nJUfrggQUwRL7MvVwJ1t+AixtXNscH5ORKeG4PdIhwHBMXn?=
 =?us-ascii?Q?eA3lVNhs4stB9b0Y6iHFDfIUffP7q+oZLG3otqhzu16T/3UIILYlVIK5hcU4?=
 =?us-ascii?Q?lgGqO/UH3eHFYlaMFtg4XnE/dO7CLjLBPC3+59teuXSX/SlfOlgHi1BnhipQ?=
 =?us-ascii?Q?dK55zIB5jiFFn5O/Q1OIoEx0LvZVbtno8iiENC+PyCS4mo/Xe90xZ83osK7u?=
 =?us-ascii?Q?n2tMUc3M4uT1ZGRJ/FeQyzqK4QTE2upt3FoP0N51KmU9dPikbXVHRDjjHOjW?=
 =?us-ascii?Q?K2vZ0TUIZ5fX70FkrS90hWjaCwniSDfly5xM65qJhm8ohYyi/I6Bf9XH/DTe?=
 =?us-ascii?Q?sqjseMYtoeDNgy3tJzNI2ydFR1g3zsJCwiHZH6+ROHj9NUt8mfSli7ASVIHe?=
 =?us-ascii?Q?vg3rGOF2/1W0WvzE/W7UVR5Y7fmiymUBUKnFVcEpPCHoAVvSWg5HHENvRQjq?=
 =?us-ascii?Q?3L+gRipxdi75RNeOkFL6ggTeXoc8jGxCL/+PCPH+0WVNJ+eeI1YHY+hFYeup?=
 =?us-ascii?Q?PkelzPeq3yN10/t6cNN05VDdez8GTIZJhF0aT0FN/+A/+MIM7xcMBaMvRQtg?=
 =?us-ascii?Q?FxoV96mrzspsP/dtchOIOCWvu3ROzq3eZeOuLcUy5G5T9uyknQTw/jsO8Gq7?=
 =?us-ascii?Q?Lw+Z7IUnHt6lJ4n3fswb7jIs9x/y/JXBpznmOalDnavndVDbyiG73uLkcULy?=
 =?us-ascii?Q?Mg73UxaRrdoKjgoDNpKWQctBUgTQVRWnPemub9LXz77gXvnx/5NJHTKvd907?=
 =?us-ascii?Q?qFqBdYPgSHmJfcSMyFjeEu3fW2Bcj0LtoTE8STFlgpN6NgJNtV6+omFRX7Up?=
 =?us-ascii?Q?BPGshX8me4a5j1ZPQj4P/uSFkfu5hyZ5ZJI5O/mxKLlLW3L/96thWz5Aw21f?=
 =?us-ascii?Q?LQ2DxdU9IPm9iMDGhU7kX7mzhs8LSHjXTlYIBQrZUvTIGN+87aWKGLtL40ox?=
 =?us-ascii?Q?WYjr/Wq3vbglCD5yS3OJ0Yhc27GbrDvLzULqNYYbCF6710taze9/0cpWZJNb?=
 =?us-ascii?Q?gPtwOre9JG7aStQXzHP3hBsSgxqV9gY2P3bdCAJcB5wU3ulp7wh+KK72FMYm?=
 =?us-ascii?Q?2X/OSFZPM48dprM7r+Y8QnVO821VSmXy5H/RunAbHeTPNqGZAEO53AlDbt4A?=
 =?us-ascii?Q?EfklXFvqAzmKbQ1YDcKAOPheNe9yoXtsVcgD++33vbcd3A=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF82650C934DA94199D5A93526DF484D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a9c4ec-d9bf-4971-04c6-08d95c2af7a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 18:16:26.1448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBctC+KMsPJ37q1BKLmTjlKEFfCLZ2b648JtcO5tMxQUgsdR99yQGx565ecLjF6wE8+5ZnkNTxLmyGniPqgogQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4212
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100120
X-Proofpoint-ORIG-GUID: 0FkjCjFC9jZPC8Y_TKkXKVUhNHaFLfoX
X-Proofpoint-GUID: 0FkjCjFC9jZPC8Y_TKkXKVUhNHaFLfoX
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 10, 2021, at 2:01 PM, Anna Schumaker <schumaker.anna@gmail.com> wr=
ote:
>=20
> Hi Chuck,
>=20
> On Fri, Jul 30, 2021 at 3:53 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>> Hi Trond-
>>=20
>>> On Jul 15, 2021, at 3:52 PM, Chuck Lever <chuck.lever@oracle.com> wrote=
:
>>>=20
>>> Trond, please let me know if you want to take these or if I may
>>> handle them through the NFSD tree for v5.15. Thanks.
>>=20
>> I've included these in the NFSD for-next topic branch:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=
=3Dfor-next
>>=20
>> They can be removed if you would like to take them through
>> your tree instead.
>=20
> These look to be mostly client-side changes, so it would make sense to
> take them through the NFS tree. Would that cause problems now that
> they've been in your for-next branch for a while?

I've dropped them.


> Anna
>=20
>>=20
>> If I am to take these, Bruce and I would like an Acked-by:
>> from you.
>>=20
>>=20
>>> The purpose of this series is to prepare for the optimization of
>>> svc_process_common() to handle NFSD workloads more efficiently. In
>>> other words, NFSD should be the lubricated common case, and callback
>>> is the use case that takes exceptional paths.
>>>=20
>>> Changes since RFC:
>>> - Removed RQ_DROPME test from nfs_callback_dispatch()
>>> - Restored .pc_encode call-outs to prevent dropped replies
>>> - Fixed whitespace damage
>>>=20
>>> ---
>>>=20
>>> Chuck Lever (7):
>>>     SUNRPC: Add svc_rqst::rq_auth_stat
>>>     SUNRPC: Set rq_auth_stat in the pg_authenticate() callout
>>>     SUNRPC: Eliminate the RQ_AUTHERR flag
>>>     NFS: Add a private local dispatcher for NFSv4 callback operations
>>>     NFS: Remove unused callback void decoder
>>>     NFS: Extract the xdr_init_encode/decode() calls from decode_compoun=
d
>>>     NFS: Clean up the synopsis of callback process_op()
>>>=20
>>>=20
>>> fs/lockd/svc.c                    |  2 +
>>> fs/nfs/callback.c                 |  4 ++
>>> fs/nfs/callback_xdr.c             | 61 ++++++++++++++++---------------
>>> include/linux/sunrpc/svc.h        |  3 +-
>>> include/linux/sunrpc/svcauth.h    |  4 +-
>>> include/trace/events/sunrpc.h     |  9 ++---
>>> net/sunrpc/auth_gss/svcauth_gss.c | 47 +++++++++++++-----------
>>> net/sunrpc/svc.c                  | 39 ++++++--------------
>>> net/sunrpc/svcauth.c              |  8 ++--
>>> net/sunrpc/svcauth_unix.c         | 18 +++++----
>>> 10 files changed, 96 insertions(+), 99 deletions(-)
>>>=20
>>> --
>>> Chuck Lever
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



