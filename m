Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C280454BBA
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 18:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhKQRQB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 12:16:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13200 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231313AbhKQRQA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 12:16:00 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHGiw8V022032;
        Wed, 17 Nov 2021 17:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RZWPBKDgf0MiV3ho9CHulHa/9et17dUf8WFYlJ++FKc=;
 b=i9F0wcKy1g/QrdMRdrGcKEvgYfnTZOEOJJS1i8xLQ9BHopeSi/Vcdd++n+p2ZFr0UH9v
 LA8kCd7RQflCKKK80xEsPszyrkdjmKu0lYneVLxumYBc4q6yy7J5legbcEK95ACDUb5m
 Fn72uN/FUvniSKHU/iJeGnaq1+l3CP+OHieV7EZmTbrYe8KhO1lGp+eztHAMQqVOcuFC
 cj0L1veoBEX733+RqwRqs7bR1ZwXax/DA1O9i3/i+UDIgXDfi0jlM1pBXe3OoPVOUrj6
 yjKnli/9bLwWazghEMg0ltWyf1vVgzXpvnzstX98jd12Dmeoc0lNfC6S3vaPywRRE9Oz zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd205a1m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 17:12:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AHH6Vxw036233;
        Wed, 17 Nov 2021 17:12:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 3ccccqe55s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 17:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L45bgzbjVNodsYR6jp0Xq7KCpmWK3WCn26s9QFsapUPwbcDjmAQOkJJxxiyAE//SfUW2K/RQYOpB8oYkZ/xymgty7AXcXiZC5qFeJ0HYVj11r/uE25hQLUofGAjq5O6JULZh5dYOUaM2gu4X5b/neHZjeT2t8iVcvJyoxXta1suTn6AxRgrenNIksYHAh61biCmB73L460jH2WRXtu987PEY+fjcIGc9UdUWGfRVlaX/LC+Y+D+ls5c/zjQlZy6BfYNSrgXxfSoOLSO8dcNM+AsI7/wAsi7jnverCjKekIPsAvBsV4H96RHZCs8qw1HKGOOO79/q0uZiN7bDRMt+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZWPBKDgf0MiV3ho9CHulHa/9et17dUf8WFYlJ++FKc=;
 b=I9PwMNj6bzOF4WB9kntWooPgZ92ycRY6dDFc/L2dge9+sCB3IfaeqCAjMZtT0GePfs4hnAKVf4ywedFn9ab0WY3Qs1gsvRh5VJ6Tu/xFJsXaBTH+G1Heq6NWAL5XdPxWRYYRv05Q2EzTBkzdrJx4Z85sIs4yBZ9acDM93Z3YKlokQjzB/UffRPBBRjfxLeCff1/T1Ad8VMmubPTx6WQah8DSUDynD2EdJ0s0cFkx14b8yZuka4PDdwS5odpNdKkBbIr3eadK7P9QDI9VVV2x1yIn6lC5pY/8vi9e6tITBd4in/1PT8wpgDsJfmP7aVN1MCdYRSqJPzW3UdS+ewTs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZWPBKDgf0MiV3ho9CHulHa/9et17dUf8WFYlJ++FKc=;
 b=sZKGoQXmZBXc/XfhcQ0APd8f8/U07kjgmU9I+tsrZzvNgieiL9+1zNT756jC+VGjL+dTCysChUpY9ZCrQkwAvbFEOJTd8haWfpFAR6Dlcf1lhIOwWQ6N32M6IR0B+ltC80T+jn+MfkwkZJn/ZfymdukZIeXwHd4YEdy6oFJumEE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3224.namprd10.prod.outlook.com (2603:10b6:a03:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 17:12:53 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%6]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 17:12:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/14] SUNRPC: clean up server thread management.
Thread-Topic: [PATCH 00/14] SUNRPC: clean up server thread management.
Thread-Index: AQHX20ysqm05G22d8kuJvQ18VodIaawH9hsA
Date:   Wed, 17 Nov 2021 17:12:53 +0000
Message-ID: <9E7E7AC8-FE88-4C07-9DE7-DA5F0CB2B9E2@oracle.com>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>
In-Reply-To: <163710954700.5485.5622638225352156964.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bedc4a76-87ce-407f-2525-08d9a9ed7dc1
x-ms-traffictypediagnostic: BYAPR10MB3224:
x-microsoft-antispam-prvs: <BYAPR10MB32245A953110B787B5710A97939A9@BYAPR10MB3224.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYLoeer8i0bLyxkAdVYz7BKcGRWdA5IhH47r4diI+H9YoXCWdvQRZ5AdyQ4zNFBHgQbul5RFcPSeF4IjLrGCZeKBDnqgIWkIgBVqTYT3hKtckY521cNqJm6FOuKXFIN/0c+yy2nH6Ea/fQ1rtI7fo51QbTbTEcvDFaloj/T8ZpDDtXpjv/l1A/3VcQoqRvadzc+tO5cQRNOqwCDhztir6BEJ/2Mp6WJd8nj/MIiiFhOIyalhqSt6pPj7HZoVwS1nI5XZRb3SNN4c9D6PvUmP//vSLkGwGFS6y4ZDSG/upYJU5Tzp6MATygm4otPTgWJyPL+UTzRO55Trv98pl9h44IhndzCLVvfXmvHw2K4aulGQXjUAXttGCjDHotIi8lVH34fRI1VsGlyZsgT2795r/ci8DTdLIUfbIBayDF61l2atMnam6qZae1xlpIyeFIMlJ05RyAWgA+G+zsVFcquH2upsQjmQLamU4+CWKwmqRPdxuNE9N92TKq/tBA65+2tM0EWhwGj4AdQZ8FC3RDzwKXYKpgHoFKE0xnuCqy1ba5h+Fc87u2L1znfFkO9ys05CMJsHlRpLMz2jP7903dIXldeEmw8HVgJUVbyK6xGdCUVi7KLx02eB0mFc/OJcjinoNCvenKpsXmgfXcVZhz7gye/qBRimE+I1H8MDqlPQ1OlQ0fRw47JqpsKLSzRqy1yx1zXHxtmdzfPLcAYzjYpUU6bl/6+iEDnQOWP0jVizFqjAwCYP4vi+MVhkThWI22Tb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(71200400001)(66556008)(76116006)(6916009)(33656002)(66476007)(91956017)(38100700002)(66446008)(508600001)(83380400001)(122000001)(66946007)(6486002)(64756008)(8936002)(5660300002)(54906003)(38070700005)(316002)(8676002)(4326008)(2906002)(2616005)(6512007)(186003)(6506007)(53546011)(26005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mPjtgaNCfNh8HNg8wqPiHRBak1DXQf4g4WGWDqd18Hu+WxyYXDUJhU+Mz1fw?=
 =?us-ascii?Q?4zoas296S2jKfWH35HO0vDuQfRbqMnVxkowGBiEAB9ocV1+ONiEJZoqsTNdY?=
 =?us-ascii?Q?it6kaHXgj/p9HJTPiMRyWG/ZdX1UPfZBMkGb/5jR/YbeUHkVBAZRh++B1R/D?=
 =?us-ascii?Q?2mCxiNC7BFMxPy9gPdtVuncOC/cuwQG58ada+uEnd8w+VCYc5t9rzSgyDmUq?=
 =?us-ascii?Q?yStPNnU1o8Qj3+aiWUaEoj0XaMX7ltJN12nsEVqWNsAoGFnbL9pa/FpgzEmI?=
 =?us-ascii?Q?aoNSLHv2X8UxkHn6fd5Zdfbn9PwDCKEC3ZkmlSFRB7cAjuxxc9s8FTz43Txm?=
 =?us-ascii?Q?dtNsk7AobAuTbbechJknuxo/J26pvNXgKmiKyWGyWv1tBUPyEMhyTKzHeCMf?=
 =?us-ascii?Q?driiXgDJ3tJ5t9N+NNqy+zE8AZcAFa/kI+cEFOX8Bh8wrlAW2H+z+oiENouL?=
 =?us-ascii?Q?BfvuiFucpSu/rxGVM8CygTpdu/RLVEAwtsOgajyFnfdASjj/VnVuM+I7qFo4?=
 =?us-ascii?Q?qG6Baxmx2LmDebWjjhKQEXnIe8pv4XnELsvPw9UL5+I/UGmF9gkTcO85F2Fk?=
 =?us-ascii?Q?OSWPBjALQNwVzFPPxYWcyX/6MmldBOMgyLHBgQamWaUy9xfXQgBLhEzov3kX?=
 =?us-ascii?Q?gTM5g2yRikkd3lkzTby2OpN8MD2onetiwQ/GJVSyz9F0KyoI1nL5GFh8OOnC?=
 =?us-ascii?Q?b79yBONHzV3PNv7sYUtXKJD9HUvr46N8xVzH0emYQN169Eql78jdYKKgAkh+?=
 =?us-ascii?Q?2qgAHL0R2bqhraPaQWIaNTWMyrdsDnpnck7stbC1FJa+Jb0IxvHGBvXULgFK?=
 =?us-ascii?Q?9Osx7FCMcRnescsEmSYfkFEtuKESDN4uHjXwQEP/1Yz+vxyVLXtyD2Wo9gAT?=
 =?us-ascii?Q?/aPa2Png66cZEIYdlycap6P0bVRrA8vix1Oh1+H0eCyJPbxENESxYZ3pntuB?=
 =?us-ascii?Q?bCBfErTGsgmQwbImPInR7ljCcMK0TFjadI5RG175Eq1Vt8aY67u5u9pTr3tE?=
 =?us-ascii?Q?KSPzlCd0mZh4FYuhnCdjdEBOMA2d3ypbAjJKM7X9qzkz4c/1QiotqE1sHTar?=
 =?us-ascii?Q?Sqk54ojG0INGFzS6D+BFJ/l+SF34Fa31agbVNDsGJwzrJAOMZ6gtgcZzJy3P?=
 =?us-ascii?Q?KJOgL/RdH5tIznIXP2Fi8JRvGXF91SfQEUdKlxk5HDvaSe9kpCDhLUBDx2vi?=
 =?us-ascii?Q?zv2Sy+DEI69MjXcGrVlVuIsJfDClY9vJFUDE8WMzN61dfEPY+htTI83VDRsI?=
 =?us-ascii?Q?bUwaoBmIJcQtxrdWdiv/PWhc7nLvttzQA4n8GQ+B6vJSPYenxiF41vO09fmH?=
 =?us-ascii?Q?N5jOdj6DiwCKARxOwCPwHgy7NcHHMzIH7rOX/srFD1Nnr/JmoxiQNi39Z6I8?=
 =?us-ascii?Q?kkPGwfkiuy8RNz8jSCK3ORocensrtKX5HYeUJ06Vd6/RumBjrWqk6F1zjS/b?=
 =?us-ascii?Q?GI1tTtHGPp4XyPy3WoUf60sm2y9tAmxOsa0JW4/+Xqfmic5OCDcsbKpBls5w?=
 =?us-ascii?Q?XrdOETR4rCf9oTOFai4VbYWShgvTA6FND0e0F56AqPC4OkH7hWefwK0zm3Fp?=
 =?us-ascii?Q?PETGJhqRsCraDsBtWVOAxRrL+SvUhxH2+dHh7qL8d1ztBiZHFQ3KgZ9djgK6?=
 =?us-ascii?Q?Vd+Qy5SnClVfh5luFjqB5N0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18ABF1E4E811A14F93EFA72252C23898@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedc4a76-87ce-407f-2525-08d9a9ed7dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 17:12:53.1321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzK1Q1u63yObQxCl1QVdtwJbUuu6nDQnXoNdfL+gJjPYaRTzy0st8CpzsiKg55jHIID/khd0qRSP41EhvIocnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3224
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170079
X-Proofpoint-ORIG-GUID: lfQH13yjfhJsc1oSFDKBeav4UQLD3tUP
X-Proofpoint-GUID: lfQH13yjfhJsc1oSFDKBeav4UQLD3tUP
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 16, 2021, at 7:46 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> I have a dream of making nfsd threads start and stop dynamically.
> This would free the admin of having to choose a number of threads to
> start.
> I'm not there yet, and I may never get there, but the current state of
> the thread management code makes it harder to experiment than it needs
> to be.  There is a lot of technical debt that needs to be repaid first.
>=20
> This series addresses much of this debt.  There are three users of
> service threads: nfsd, lockd, and nfs-callback.
> nfs-callback, the newest, is quite clean.  This patch brings nfsd and
> lockd up to a similar standard, and takes advantage of this increased
> uniformity to simplify some shared interfaces.

NFSD is venerable and ancient code. I'm a fan of careful and
tasteful clean up efforts!

I've started to familiarize myself with these changes. A couple
of thoughts for v2:

1. 1/14 is doing some heavy lifting and might be split into a
   lockd/nfs_cb patch and an nfsd-only patch. Or maybe there's
   another cleavage that makes more sense.

2. When introducing "static inline" functions I like to see full
   kerneldoc comments for those.

I'd also like to have some idea how we should be exercising this
series to ensure it is as bug-free as is reasonable. Do you have
any thoughts about that?


> It doesn't introduce any functionality improvements,

I might quibble with that assessment: replacing heavyweight
synchronization with spinlocks and atomics will have some
functional impact. That's probably where we need to be most
careful.


> and (as far as I
> know) only fixes one minor bug (can you spot it?  If not, look at
> c20106944eb6 and if you can see a second place that it could have
> fixed).
>=20
> Thanks for your review,
> NeilBrown
>=20
>=20
> ---
>=20
> NeilBrown (14):
>      SUNRPC: stop using ->sv_nrthreads as a refcount
>      nfsd: make nfsd_stats.th_cnt atomic_t
>      NFSD: narrow nfsd_mutex protection in nfsd thread
>      SUNRPC: use sv_lock to protect updates to sv_nrthreads.
>      NFSD: Make it possible to use svc_set_num_threads_sync
>      SUNRPC: discard svo_setup and rename svc_set_num_threads_sync()
>      NFSD: simplify locking for network notifier.
>      lockd: introduce nlmsvc_serv
>      lockd: simplify management of network status notifiers
>      lockd: move lockd_start_svc() call into lockd_create_svc()
>      lockd: move svc_exit_thread() into the thread
>      lockd: introduce lockd_put()
>      lockd: rename lockd_create_svc() to lockd_get()
>      lockd: use svc_set_num_threads() for thread start and stop
>=20
>=20
> fs/lockd/svc.c             | 190 ++++++++++++-------------------------
> fs/nfs/callback.c          |   8 +-
> fs/nfsd/netns.h            |   6 --
> fs/nfsd/nfsctl.c           |   2 -
> fs/nfsd/nfssvc.c           |  99 +++++++++----------
> fs/nfsd/stats.c            |   2 +-
> fs/nfsd/stats.h            |   4 +-
> include/linux/sunrpc/svc.h |  11 +--
> net/sunrpc/svc.c           |  61 ++----------
> 9 files changed, 128 insertions(+), 255 deletions(-)
>=20
> --
> Signature
>=20

--
Chuck Lever



