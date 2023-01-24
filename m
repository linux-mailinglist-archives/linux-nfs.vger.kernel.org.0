Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A3679F42
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 17:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjAXQzd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 11:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjAXQzc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 11:55:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3256318AA8
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 08:55:26 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OGNrbh009113;
        Tue, 24 Jan 2023 16:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IdNqFTpfSNRR33ZR7fdl9hg/O5r+7L8vvHdm4HEg0gQ=;
 b=QiL+3nY6NeSMHVnc2G9lkDFHGZ/I7/zfBq1tn5z1Hme/ZVJ+XzZlRtmtotiBcRePDJ2p
 MLGUGSH8H2nJHk8ydNUh/erCqmZG67n2cAqhPMvPoXsyYVDyaJIHgNe2QweLyeI2ye07
 ojN+Gzn1Ds1+oqM2C+1I+4oHqVB4fadOoUZk0hejA9ETifIJ7+8EYj7mAO9+t8AIYvRX
 sJxvNU2nlT1fM/24epfT507yZoYkj7u/BXb5rU6Sh/IQTckjwRbJ4QTQWf6TRDMjiVHi
 1xNGHJCYvnKd4nv+cvEpQFjz74Q7uaZNrTOkbtTiu+/OraqMxd9VYK6JmsPnr/5NW+be 3A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fce036-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:55:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OFSi8m029365;
        Tue, 24 Jan 2023 16:55:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gbgabx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV93d0KJbN574zUyohC+gz2/qZqHvlQBvhVsfYvD7iwuH6yHiRFZIGDXu2iZxGJH+Sg4VHeOg7r9JoPCSPRBjVkhWL7PU8xfqHq1Onsa1s6oltKYYdOKijrxeERgsto4p0U4wVd09HbhYEqGMpKG1KA5n7hI/aqdXJp1krV1FZXeF495N9Blnd8Q0KYHA+YKGJrdUJuoMYKIJl+rpMy6NcMpSOVdAql2NgqVQiIDsg1mN9Hf2vr0qSxoU6ZbQcxPnpaY+YyeIAWgjhj8/RMQw5sBknp9qGdYX4Rs0fJh3AttXtx5fG9DRDXc/IzBjXNVXWamYf40pT2xA83I8Sjvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdNqFTpfSNRR33ZR7fdl9hg/O5r+7L8vvHdm4HEg0gQ=;
 b=k1CXKU08HRQosBzKkYLS1Zfm/7betAg+Rk9hTcnwvGMlZPnlJ8b4CYlTgbi2ZrJB7PW9odjG/XVdpB2/zslXo0tq6sKBbQClWwn6mInxnflGy0X3lR4vf4CuhwPwaNTIv92M0U5/D0ah5IUTtps4qUblPHXzRVCKPyZ89uESr8CEHm0oP1LByCQaY6CbGW1BDk6N3A/WyPY00dI7jsgeaSJXEBbosD/OPxYzKUkcFmJojd5CtGtYl0oalA2jvjD/LPef1Zsjs/cZRGwiuRbs5/x0OzThaf/ui8pKCYEXwnP1AxAyvnCaJ7584PBEj83OSif3laAUJrERFLNgIsjphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdNqFTpfSNRR33ZR7fdl9hg/O5r+7L8vvHdm4HEg0gQ=;
 b=BVj53BPPhKRKOUpDLrqGCQpY2fStPQMty4xkPFbwyQR99Zlswt26ZmyKSnHnu1pk/UAaen9okIgYuju4Af/xP87SYdjeUJuQAPAg4sX5mLokoce3OORVCMZGaGui+WsuSFrAuL2J6Y39kMsHSE9x4jBABKghN3uoGi+cnQAG/lk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6516.namprd10.prod.outlook.com (2603:10b6:930:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Tue, 24 Jan
 2023 16:55:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 16:55:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: remove fs/nfsd/fault_inject.c
Thread-Topic: [PATCH] nfsd: remove fs/nfsd/fault_inject.c
Thread-Index: AQHZMBNOe8a9+v/O+0Czd0n7eeVayq6tySGA
Date:   Tue, 24 Jan 2023 16:55:20 +0000
Message-ID: <67F0A0D1-9715-49E7-8F3D-0E0950972C83@oracle.com>
References: <20230124164538.163641-1-jlayton@kernel.org>
In-Reply-To: <20230124164538.163641-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6516:EE_
x-ms-office365-filtering-correlation-id: a65caff0-0834-4ff0-26fc-08dafe2bc718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7qmJaWFB2gzeyqvE2LNio9UeW7w4aY8EC2BpFdIXeTLv1apcsNeDmnPp3PHIZU3uBm3EhwN5v5iKYY+Zct865kNjat9E3Oe/5ZiVmTpGLRINxPgzh9j2ScRzhqCDnirKtbm0RRuWoqeS3i2hnaW6zwpO/OwIpwXVBgXM6QYnz/S9xorfRjwKrVeijKKQlyInvhDjHkgTbuCVw5qvPl6HbQGuxWJgP5bRcFhf4qHpU05hXCpVoksAhW6T9Q3zuYBXTDdkgnHgodxmTCZm2SACwlnk0giR/LXFgBLFLpFKQiwD1i0s4M5n3wKnReEGS9pVEI2U8IVMlZpgrZpo14B5VxrM259mYtOh15OPvJQ7sERbxTE6I61TRAqaWuLXc9kJsn4VwQ81v4FwcKQCVA1KqyOou5n5cV3yNb3qaqEOFz4taekk42qgu5GcJsX1ywbUBoUvOPP2PSlHtc42EdQV1VhO2q/p7C4KHpmvjcYVaEtArtDZp1N+fi6TvixGKQXSRYe0DgdXSmf7XgwPscp8EdCxt0X3I6Sh2l40xPPJ5fWTKfd4uh7rEadt5tFZneAAOVlm1SXDxljjr7Q0WZ3mGkmR8rwD4xvXi5SIPD9D4kWbb2r35a+/3tjZ62d4QyOA244SmJmw92lsiIN8RJNXto7OHhLUWdQW/hAeDmlMtz0cMkx3gj0/PeVK7rDbSpwE+T96KXgXTZ/fDm/0aenuUJh5tzgvuR/kSamZO1I3+oY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(36756003)(33656002)(86362001)(38070700005)(4326008)(91956017)(76116006)(8676002)(66946007)(6916009)(66556008)(64756008)(66446008)(66476007)(41300700001)(8936002)(316002)(71200400001)(5660300002)(2906002)(38100700002)(122000001)(6506007)(26005)(6512007)(186003)(53546011)(478600001)(6486002)(83380400001)(2616005)(66899015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BoJoFIFinMd7JXoA0+Rv1a0Ta1IKPKn4QnXC9F0wVqEhLDsBGQVEPaKHVRVI?=
 =?us-ascii?Q?ZZsRdbLllP6BvUadzwTHwmk//CrW7mNOyZNyFofeJytiZSjzPciiHhJ6G3nl?=
 =?us-ascii?Q?h3WT1TUgsgdMKl75Kb4RmS/beYlAoKgKCqbyhTj24My3GsAXCMh/SIlYsskR?=
 =?us-ascii?Q?99yzRW5JbMzIJuvPvgoMi8jKA9383rl+uvnlTyGcOevCWw4Q4ejJmRGU56fM?=
 =?us-ascii?Q?S2HReZxjQrNHbaWtZRbMLCat1ktAjV+KJC2I5m/9HYe47QJ1/zIvWVYolUOc?=
 =?us-ascii?Q?bHWOnM3jFSgk4XmD7UvwXVvlNrscSICQjqOM/HLAYc6PGzXPOqSB4Dk/kv2q?=
 =?us-ascii?Q?kIBjzbKMdLFcG459yo7jZltBy0pPPaZwWLYfGbWppnc6d3a8fDGAAEjwtTPj?=
 =?us-ascii?Q?0a/wzvRS+Wk009F8SQwdvsNhsS50HCTDTkm1i53J+eJbAXtz+Qry8qf9VqyM?=
 =?us-ascii?Q?c7yq4ZlWrMtyej4oX3zW5NiM9w/NvyLA9iLEXBhB5xyuNPL6v3gwmWC7+dDb?=
 =?us-ascii?Q?0NDjIvr+9xY2QKeOIA9BNYbPeKGWjFcVGaqbFT6g7haXDaKH9xQyBNmgBchV?=
 =?us-ascii?Q?NzzmPCThsfhDCdif8nxZpnAS/5K6RpakpHqw5D3VhUmOVFh/hx5cFwgi7Gji?=
 =?us-ascii?Q?Zhu5MiyStHCl6CjVdeQLNJoN/O2gOofl9pdoKRmG6xBHYZSR4RHpW4x80Rq7?=
 =?us-ascii?Q?Dw+CmwksnBsea2xOqaOSKeFM079719blgINZAlCsoQylYJtaCLTVkAjDUBzC?=
 =?us-ascii?Q?a1/tPXNx5U6Z79XE+SYLJhFC6lNxvLvnBDbR7tD5QmB7wwIyokmbInHFyvQ+?=
 =?us-ascii?Q?q9uPSYIj8Yvh5EiLM1PjF1PvgolDOGQUiPYZh50eHvDOO2q7DgsdkDrC6QAw?=
 =?us-ascii?Q?TOnav00jt9xmT0iqDIgSHvXxhqbQYBHmW3yK08HG5ZHEtgoMi1iA0nBmdP9i?=
 =?us-ascii?Q?zhCqM/bz9tl0sKQUoc8EMfHLpNknb6wag02EtD8wefOfFrt24Pbm48VCqA0h?=
 =?us-ascii?Q?0dHtNCY/g3/sK/QROJHp5Y9oScSVlCE7kCHLDQwAuhNCtPod3lP3l6ZNkCUR?=
 =?us-ascii?Q?SKrLX6sjrZ8uTiYtEC9o367S0nHbUX9oL0W4i7Ag0lPars1zZsFL/vXlUpKV?=
 =?us-ascii?Q?J5ZYTI3w7cdf/kU3hB8DatoMGgYeqMfqk2wyqLIhw7sArGOH3H7qKPIHcpBV?=
 =?us-ascii?Q?vmD0ANEpeObCgm5Pk6+XDsz58r3nzJHjuoy196dU1E9enosNUUbneJTcFEMa?=
 =?us-ascii?Q?KDf87/qfsic2GGzhwrWRsKu/GUx6FsA7b7Km5QIJR4EFv6BlUHOaler7ZPem?=
 =?us-ascii?Q?8CA/xTsfDZtEuyoj/QBaLn8/uMfX5tiigSee7P9hrkTkUzWMo67Zb8gKqScM?=
 =?us-ascii?Q?1g8VLdPbRJY01vJ4P2qVy4X2sOIR5CR753GhlGSBsdqdEPzVa60NEm/0SRU1?=
 =?us-ascii?Q?4GagyWvublaaKx+Z17UEWIqm/pF96Q4StQppi0Nf+yxrdtGclUcTiurbGpmM?=
 =?us-ascii?Q?tTA4llQcnN/jSaaem/qMrms/fCyQXZ9829mY6CEiWhkIZWjzvpuGVlBEvekn?=
 =?us-ascii?Q?ALaYh8RvijIh6J4WmPoOodE5vKoD43zVcNKp9B7EGOgpyR0XN1PmFCPIakh7?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EACE8A470DA98846BDE8D1C9699DF372@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fmgTWhOplqR0PpEehZa+0U5z7Ta3H0wRlXP5/OuzWym61yYdHM18fTJs1aANA5u0FFNUvVHnqUnWa5PpZfUIFRX+wCh6JkD2fkIxphr1TXuWXHvxRZ7+4P2b3Yq+0AZjgwvT9CIjmrHSYsmvUBgx02A/8fVRUG2Tuldg/aE2+BmUqbMOd+5yJJKyFo+AJkYzmzOWMKC89FOtdxRZUbgCR3hfRKDDo/4eg3wIjXzvDG2WKGsSG6nKAQ0PGKgrydFP3b6G8RHoI0mMtqZ4/xopbWtGiMdpAH/w/nI5lv9hJ0SjY1jz1/VK5d/Q3Z1/twwelffdKFEIzoZYvye6WtBtlIvcsSpa9ryZhzTq4bvuXamJkng0SoYE5cmuFGtVXe3kz4wTCYG9tTTyby1XMoU/f5KCdhc0yR/Q3G1Si2E4KDrJjhjG9RxHd0ZLALY9FBU1YoiuysBxj3K/MwLH0MBkIRtov1V25k09xgFKr4eVBSb+idf4Gw1n6gk1S5wc//hmC1pRGBiANGxmdZiVEUydrHnS/bOcv2EqcEHK8vAi6aEYB1hXaHKgUzW9SGEIL30qLDSyp6MyztqLksv7m9CNwP8KxjY+KFCn8iThvDonwO4C2voqM7xde5NG+tCOyDbWdRNLGLl4nvweSgmM9dvXbzkGhiSJKr8f+ECUqcbUB1cmUCfaoas6iXarUQKjtXZVcwqnE4X5JhPbCRQCq7VIazQvYPnPyl4HylUaXCAA1QByOsgyO/Rl6cLHgP8zzE+1/TayJm4ofAZgeh1ysp6uZS2CAw8NYPtm/4tlxWPa5iQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65caff0-0834-4ff0-26fc-08dafe2bc718
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 16:55:20.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIIfIHXLXKw6NjUFIKAGaviXsrRiX0ckhpWy2OIhyyYEJ9GQRMpx42lDyhotDCJNA09ZMVFn4vp1oMHXUAfWQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240154
X-Proofpoint-GUID: VgJANfFGbodRgn9JriY0PYvDLhclaiwI
X-Proofpoint-ORIG-GUID: VgJANfFGbodRgn9JriY0PYvDLhclaiwI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 24, 2023, at 11:45 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> This file is no longer built at all.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Applied to nfsd-next, thanks!


> ---
> fs/nfsd/fault_inject.c | 142 -----------------------------------------
> 1 file changed, 142 deletions(-)
> delete mode 100644 fs/nfsd/fault_inject.c
>=20
> diff --git a/fs/nfsd/fault_inject.c b/fs/nfsd/fault_inject.c
> deleted file mode 100644
> index 76bee0a0d308..000000000000
> --- a/fs/nfsd/fault_inject.c
> +++ /dev/null
> @@ -1,142 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2011 Bryan Schumaker <bjschuma@netapp.com>
> - *
> - * Uses debugfs to create fault injection points for client testing
> - */
> -
> -#include <linux/types.h>
> -#include <linux/fs.h>
> -#include <linux/debugfs.h>
> -#include <linux/module.h>
> -#include <linux/nsproxy.h>
> -#include <linux/sunrpc/addr.h>
> -#include <linux/uaccess.h>
> -#include <linux/kernel.h>
> -
> -#include "state.h"
> -#include "netns.h"
> -
> -struct nfsd_fault_inject_op {
> -	char *file;
> -	u64 (*get)(void);
> -	u64 (*set_val)(u64);
> -	u64 (*set_clnt)(struct sockaddr_storage *, size_t);
> -};
> -
> -static struct dentry *debug_dir;
> -
> -static ssize_t fault_inject_read(struct file *file, char __user *buf,
> -				 size_t len, loff_t *ppos)
> -{
> -	static u64 val;
> -	char read_buf[25];
> -	size_t size;
> -	loff_t pos =3D *ppos;
> -	struct nfsd_fault_inject_op *op =3D file_inode(file)->i_private;
> -
> -	if (!pos)
> -		val =3D op->get();
> -	size =3D scnprintf(read_buf, sizeof(read_buf), "%llu\n", val);
> -
> -	return simple_read_from_buffer(buf, len, ppos, read_buf, size);
> -}
> -
> -static ssize_t fault_inject_write(struct file *file, const char __user *=
buf,
> -				  size_t len, loff_t *ppos)
> -{
> -	char write_buf[INET6_ADDRSTRLEN];
> -	size_t size =3D min(sizeof(write_buf) - 1, len);
> -	struct net *net =3D current->nsproxy->net_ns;
> -	struct sockaddr_storage sa;
> -	struct nfsd_fault_inject_op *op =3D file_inode(file)->i_private;
> -	u64 val;
> -	char *nl;
> -
> -	if (copy_from_user(write_buf, buf, size))
> -		return -EFAULT;
> -	write_buf[size] =3D '\0';
> -
> -	/* Deal with any embedded newlines in the string */
> -	nl =3D strchr(write_buf, '\n');
> -	if (nl) {
> -		size =3D nl - write_buf;
> -		*nl =3D '\0';
> -	}
> -
> -	size =3D rpc_pton(net, write_buf, size, (struct sockaddr *)&sa, sizeof(=
sa));
> -	if (size > 0) {
> -		val =3D op->set_clnt(&sa, size);
> -		if (val)
> -			pr_info("NFSD [%s]: Client %s had %llu state object(s)\n",
> -				op->file, write_buf, val);
> -	} else {
> -		val =3D simple_strtoll(write_buf, NULL, 0);
> -		if (val =3D=3D 0)
> -			pr_info("NFSD Fault Injection: %s (all)", op->file);
> -		else
> -			pr_info("NFSD Fault Injection: %s (n =3D %llu)",
> -				op->file, val);
> -		val =3D op->set_val(val);
> -		pr_info("NFSD: %s: found %llu", op->file, val);
> -	}
> -	return len; /* on success, claim we got the whole input */
> -}
> -
> -static const struct file_operations fops_nfsd =3D {
> -	.owner   =3D THIS_MODULE,
> -	.read    =3D fault_inject_read,
> -	.write   =3D fault_inject_write,
> -};
> -
> -void nfsd_fault_inject_cleanup(void)
> -{
> -	debugfs_remove_recursive(debug_dir);
> -}
> -
> -static struct nfsd_fault_inject_op inject_ops[] =3D {
> -	{
> -		.file     =3D "forget_clients",
> -		.get	  =3D nfsd_inject_print_clients,
> -		.set_val  =3D nfsd_inject_forget_clients,
> -		.set_clnt =3D nfsd_inject_forget_client,
> -	},
> -	{
> -		.file     =3D "forget_locks",
> -		.get	  =3D nfsd_inject_print_locks,
> -		.set_val  =3D nfsd_inject_forget_locks,
> -		.set_clnt =3D nfsd_inject_forget_client_locks,
> -	},
> -	{
> -		.file     =3D "forget_openowners",
> -		.get	  =3D nfsd_inject_print_openowners,
> -		.set_val  =3D nfsd_inject_forget_openowners,
> -		.set_clnt =3D nfsd_inject_forget_client_openowners,
> -	},
> -	{
> -		.file     =3D "forget_delegations",
> -		.get	  =3D nfsd_inject_print_delegations,
> -		.set_val  =3D nfsd_inject_forget_delegations,
> -		.set_clnt =3D nfsd_inject_forget_client_delegations,
> -	},
> -	{
> -		.file     =3D "recall_delegations",
> -		.get	  =3D nfsd_inject_print_delegations,
> -		.set_val  =3D nfsd_inject_recall_delegations,
> -		.set_clnt =3D nfsd_inject_recall_client_delegations,
> -	},
> -};
> -
> -void nfsd_fault_inject_init(void)
> -{
> -	unsigned int i;
> -	struct nfsd_fault_inject_op *op;
> -	umode_t mode =3D S_IFREG | S_IRUSR | S_IWUSR;
> -
> -	debug_dir =3D debugfs_create_dir("nfsd", NULL);
> -
> -	for (i =3D 0; i < ARRAY_SIZE(inject_ops); i++) {
> -		op =3D &inject_ops[i];
> -		debugfs_create_file(op->file, mode, debug_dir, op, &fops_nfsd);
> -	}
> -}
> --=20
> 2.39.1
>=20

--
Chuck Lever



