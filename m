Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D318E3263DE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 15:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBZOPB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 09:15:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52926 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZOOp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Feb 2021 09:14:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QEDOaw183487;
        Fri, 26 Feb 2021 14:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RpSfZ+Ir0CpGKACcFiDQxAV2BtARpu6BM1QMmGqCdhg=;
 b=qlQDBxOBNu0Ovh2b2HoBAD/WP4ZgZ2CwcsJjDA0NShq9JYOYuLCCnBOvPknlTrbg0MIz
 1S0UulEhaKtPYyZpL0ve2EKnfZsAt/sX7e4GnkRnT6XAFey0QtQkI4Hcyt23C4r4cSMm
 XAbeS0iMG4nDc7ZvpV42lpOvutecBlMVkZsIcO/Okin35ZVpNTHoNbJdj27xqfDXnohW
 TyyJs92QszhAqeKnKzfSekcrvwGFjt3KbYU8oqCejqQkh7WmItmxsh5CWiOYswGAkKAg
 geu0RuaTHmOh0ivBCVBuuADFt6ikelKUC6XgNhSZTaVSo7AXHXguaHHFCrFBrSIyWpVe tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36tsura2tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 14:13:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QEAj6l157314;
        Fri, 26 Feb 2021 14:13:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 36v9m8nrvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 14:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRvBZrfnTKCeqO45R/0sXA2kOMqMESzCGM0Y7I1pr4BK4lEoiIXQag7xqU+6gzhSg/h1ErQntuhlsRLk5+3oScodmhyxpx79icaQJPS5Z0RFQlep0fi7c8/Tfh1e4TJsbqCIgCchA+qiIrUDL9RLyBMDSdbqEcH+tZsmxh8kQ4lkiNOaZ7/tbga7ZIqWrssjiyVH7QUOJOdKJUZcvlAyCtP4v2Ik1r/lLimzQOFkVrHtQNIlwz/eaB2W8ZKoJ28jZo1rgFgPUbqVVg/9d7cv3LgLTBTHeixZ5axnWZe1/JRosqnEMhvXpZrYMmLrOgmoCcFOYXpyBeodFP3nfRvfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpSfZ+Ir0CpGKACcFiDQxAV2BtARpu6BM1QMmGqCdhg=;
 b=dnPRSWe5Y5Z3B8h9GZFWxW/vlKwe47HYpRErtKDmBuYLg2ZnpkCqailymzB8eEOiFwC2qw2FKQ0yUnFlf5MejvCKNreJFi/jYKydJnif82sETFEtr4dsBZcQ/tBDwRJr/vCezxsa17EZDpZ7ojPB8h2njRRMiMl1G4Ev8OXSFGqX/cWWQeCYRcFNt35hQxksS80UrUNunFY/zPmh3pCqv7JnRQNP7rlayZRw/Z2oDVdVzVzV2BeQs9sz17T0Lj04J2sIOjFD4qc4Yx/yMXRlSrVkaIBgyvng8ZyK4RctqyHxtKMfCrKaZ/r0xWKcG/rd9NykClVVyQlj3mLWu2/9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpSfZ+Ir0CpGKACcFiDQxAV2BtARpu6BM1QMmGqCdhg=;
 b=zD9GPMvSpq9sFSqkoLOLsBPoSmEJ9FYpFTRuMIxNiFYkEZkkLpt5ZfZgfBQRwmBptKFBcAYpU+JR5FEGWqmJ42/eIrMyCl79kj2npFYR0v8zCjQlOaDfAeEm6HvJe8Y3hFOCR3nMdG7FerkN+maWUpRKMn1jHFSaEjj9DwEySoU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2568.namprd10.prod.outlook.com (2603:10b6:a02:b1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 26 Feb
 2021 14:13:49 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 14:13:49 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Neil Brown <neil@brown.name>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v2 4/4] SUNRPC: Cache pages that were replaced during a
 read splice
Thread-Topic: [PATCH v2 4/4] SUNRPC: Cache pages that were replaced during a
 read splice
Thread-Index: AQHXCS9m88O7Je1z8UCixcmIHApXT6pqDTIAgABzogA=
Date:   Fri, 26 Feb 2021 14:13:49 +0000
Message-ID: <3B2A403F-A64D-4148-B8B2-529F86E0309E@oracle.com>
References: <161400722731.195066.9584156841718557193.stgit@klimt.1015granger.net>
 <161400740732.195066.3792261943053910900.stgit@klimt.1015granger.net>
 <87k0qvi9cz.fsf@notabene.neil.brown.name>
In-Reply-To: <87k0qvi9cz.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: brown.name; dkim=none (message not signed)
 header.d=none;brown.name; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 597c0b7a-20ff-4432-f21a-08d8da60bced
x-ms-traffictypediagnostic: BYAPR10MB2568:
x-microsoft-antispam-prvs: <BYAPR10MB256883245E257BA9772900C5939D9@BYAPR10MB2568.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pDAxmz7XbE52V8DLZ6xY0qx0sp8WigncQK4PY/1jnInDivPZ2SYnqiot4H+IprBpW0ZTJXZfPFLQ+wXo+OlQxwfl3UfaUlI1D4S5/c0aPICHRdQPPm/vdwO/Nr2IRSrh0S2ADGMkXlAQVa+A6Rwk7dM22KxHgF3s+U895A22P+lSQ5nxk9l9lZMht9i/mlRv9PEC7Owh6ip+Y7hU7Y39D6FjXF8xfj3BwTh1zH9U1DA7CDtGErY27M72S+cbHEoLs6ii4IZCayShLD+m6g3qmlaNZAVOg1ktrSFI+ErOyOSPkHgZ6/sXtlld1OECkn5Vo51XdC/PlShUxf6VolX5J2To7BDo5r5R5UGq/XJFPCxGsHaLfGRvITHilRJ+x/zCWEQwQT7LOB7o4+W/ImDZKJJJ8koK+CuhxIxrHTvyTkCQJm5Ast+LsN9Pf5dt/a7VyFyCO0orpvYM2/A8UfvABGydbrleEVK+7/uVspSRrJJC0h6QZCdYaxQBpJjaDUlS4uZt+HzO1zV2BWL9kPVE8L8oqBCr2mk2ZtMLk3csvHXqzX4V91TP7feck2PtpH/iVaXCpew+EINzVPypViJr3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39860400002)(396003)(376002)(64756008)(76116006)(66476007)(66556008)(2906002)(91956017)(66446008)(6916009)(66946007)(71200400001)(44832011)(6506007)(8936002)(54906003)(53546011)(8676002)(316002)(33656002)(478600001)(83380400001)(186003)(5660300002)(26005)(6512007)(2616005)(86362001)(6486002)(4326008)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jutaw2lBICBTB61YC/dt3rQ7BAgJVJ4nK94dsWv0rHz9zYeiPSi0TI/Ijzc4?=
 =?us-ascii?Q?WqXVJLFTAoukLViojNirNIO7L3w/q2BPv1reYc6Z2gx3D2qVrF8f0ia3np8X?=
 =?us-ascii?Q?lM4BqDgCPRCOt8P3xXdKZcsTg1YC+QNGUMV/Nmsyb3e/u23xu0fcH92UfDtk?=
 =?us-ascii?Q?1+Eu92PCac5pXQ75uVa4JXivUqq3IqDstNBjVpKIuI5ElwbiO+L+sjclWDSo?=
 =?us-ascii?Q?SvtdydKM7C2tmpbwZrL3bdzSP9yiuUNWb0J+mO/r4r/d1CkeXtHDYkxe7rTL?=
 =?us-ascii?Q?eBiiYQCaUxfuFNqR+xBmby6k4jDBdiMSfnOYDiat0TT13PCVmE8gcVD3nvuD?=
 =?us-ascii?Q?mysRz+zuIY3hjQX3EFaWXJHrjDLJ7A10B9DmNXYseZzY4lApO5L+Zb5DOmlf?=
 =?us-ascii?Q?a3PMvWRocjnLKLv/x4X6sVQQprhK+xZvmqthy+dX2I9rDSEBTUkduQ2lh5vs?=
 =?us-ascii?Q?7f2OqE/oKtwKQqfAuUG9Vc8DzlqZ9VKQy5lFKGyIys04sOrO9f1TUtks8KP3?=
 =?us-ascii?Q?7cYyO+y2ZDBbmt17LmCvm6ZDCrr7qfVMRm4QZuhIPRlle/+9ipqxfjdNQ+Fn?=
 =?us-ascii?Q?37h+be7t0l39iKyFFcI3nQZvq1caVBnaWZU6En8ECaeDjgqfpWTXoz38d3TF?=
 =?us-ascii?Q?mfn0z7SJnKoiJEBLQHETe1lHDvoNxdPopJW7Gp/cHzhQGuDmecNh80JqZN71?=
 =?us-ascii?Q?Wam9+1Ymsti9lz0ZgCX7bqi1X2PGYBHstoKx+PdZIxpnHMaDvtbyqoCFcFqw?=
 =?us-ascii?Q?IlAOyfzWy3Aumhc7wYkQwG4NAjb5Qz8jeuZD1HnmGExZuvSg1qRXNi3eEOqn?=
 =?us-ascii?Q?LOHbumyYNlYBbJB1T5irhrlnXNig/ExN6JKZETY10uPiOP22ARFI/WTjqGd2?=
 =?us-ascii?Q?0D9VvbHxXeoheD98nZ9tt/Mc1Dlk67YANdYhppB+o/19xQFnYDdRvYivnlx1?=
 =?us-ascii?Q?J7tstSRNWiKFeMvJfzcSX8GTiqS8KBL0N+FcEsyOXvM48axeBVTZzy8/Z/WY?=
 =?us-ascii?Q?qv+t/x8wnBEPD0D463oF8LjmIGpbCElODO1z15tUZMM87zCyEeionedjOpfO?=
 =?us-ascii?Q?1MdJpOxRfE+p8ErMmsova0caRcljeq4xaoEFocinzNgHr56/erwDBE2VTC09?=
 =?us-ascii?Q?MlVnQ89muYdzc6YCueLbBsl78JRmVmpSWNzFgR8Zd7yj5DG8vKvjYUso10yR?=
 =?us-ascii?Q?ykaoGCx39RPpq1QeGaD53NJ1cEEJnYsZgSkHqnCKRkNQdkgqaZp2fBjiB4vS?=
 =?us-ascii?Q?gt39pT2v1NfiFzRqW6uRVBuBgnBX4tM++SHvGFi14EGm690zCjtaMmNwq9JJ?=
 =?us-ascii?Q?5W2EY90djTFauGN5BVYvlh8W?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30D05A887CE3C949A929BE88A8156FAF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597c0b7a-20ff-4432-f21a-08d8da60bced
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 14:13:49.3186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v94uRUdZR//C3t6PFOZ2FCLRO2FDWeJr5xYWqoTodypJ2CckSFJTk8xxPcQ1eil9Z57YtJbGF7Sj0jqJGbA3og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2568
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260110
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260111
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 26, 2021, at 2:19 AM, NeilBrown <neil@brown.name> wrote:
>=20
> On Mon, Feb 22 2021, Chuck Lever wrote:
>=20
>> To avoid extra trips to the page allocator, don't free unused pages
>> in nfsd_splice_actor(), but instead place them in a local cache.
>> That cache is then used first when refilling rq_pages.
>>=20
>> On workloads that perform large NFS READs on splice-capable file
>> systems, this saves a considerable amount of work.
>>=20
>> Suggested-by: NeilBrown <neilb@suse.de>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/vfs.c                   |    4 ++--
>> include/linux/sunrpc/svc.h      |    1 +
>> include/linux/sunrpc/svc_xprt.h |   28 ++++++++++++++++++++++++++++
>> net/sunrpc/svc.c                |    7 +++++++
>> net/sunrpc/svc_xprt.c           |   12 ++++++++++++
>> 5 files changed, 50 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index d316e11923c5..25cf41eaf3c4 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -852,14 +852,14 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, st=
ruct pipe_buffer *buf,
>>=20
>> 	if (rqstp->rq_res.page_len =3D=3D 0) {
>> 		get_page(page);
>> -		put_page(*rqstp->rq_next_page);
>> +		svc_rqst_put_unused_page(rqstp, *rqstp->rq_next_page);
>> 		*(rqstp->rq_next_page++) =3D page;
>> 		rqstp->rq_res.page_base =3D buf->offset;
>> 		rqstp->rq_res.page_len =3D size;
>> 	} else if (page !=3D pp[-1]) {
>> 		get_page(page);
>> 		if (*rqstp->rq_next_page)
>> -			put_page(*rqstp->rq_next_page);
>> +			svc_rqst_put_unused_page(rqstp, *rqstp->rq_next_page);
>> 		*(rqstp->rq_next_page++) =3D page;
>> 		rqstp->rq_res.page_len +=3D size;
>> 	} else
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index 31ee3b6047c3..340f4f3989c0 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -250,6 +250,7 @@ struct svc_rqst {
>> 	struct xdr_stream	rq_arg_stream;
>> 	struct page		*rq_scratch_page;
>> 	struct xdr_buf		rq_res;
>> +	struct list_head	rq_unused_pages;
>> 	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
>> 	struct page *		*rq_respages;	/* points into rq_pages */
>> 	struct page *		*rq_next_page; /* next reply page to use */
>> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_=
xprt.h
>> index 571f605bc91e..49ef86499876 100644
>> --- a/include/linux/sunrpc/svc_xprt.h
>> +++ b/include/linux/sunrpc/svc_xprt.h
>> @@ -150,6 +150,34 @@ static inline void svc_xprt_get(struct svc_xprt *xp=
rt)
>> {
>> 	kref_get(&xprt->xpt_ref);
>> }
>> +
>> +/**
>> + * svc_rqst_get_unused_page - Tap a page from the local cache
>> + * @rqstp: svc_rqst with cached unused pages
>> + *
>> + * To save an allocator round trip, pages can be added to a
>> + * local cache and re-used later by svc_alloc_arg().
>> + *
>> + * Returns an unused page, or NULL if the cache is empty.
>> + */
>> +static inline struct page *svc_rqst_get_unused_page(struct svc_rqst *rq=
stp)
>> +{
>> +	return list_first_entry_or_null(&rqstp->rq_unused_pages,
>> +					struct page, lru);
>> +}
>> +
>> +/**
>> + * svc_rqst_put_unused_page - Stash a page in the local cache
>> + * @rqstp: svc_rqst with cached unused pages
>> + * @page: page to cache
>> + *
>> + */
>> +static inline void svc_rqst_put_unused_page(struct svc_rqst *rqstp,
>> +					    struct page *page)
>> +{
>> +	list_add(&page->lru, &rqstp->rq_unused_pages);
>> +}
>> +
>> static inline void svc_xprt_set_local(struct svc_xprt *xprt,
>> 				      const struct sockaddr *sa,
>> 				      const size_t salen)
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index 61fb8a18552c..3920fa8f1146 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -570,6 +570,8 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int=
 size, int node)
>> 	if (svc_is_backchannel(rqstp))
>> 		return 1;
>>=20
>> +	INIT_LIST_HEAD(&rqstp->rq_unused_pages);
>> +
>> 	pages =3D size / PAGE_SIZE + 1; /* extra page as we hold both request a=
nd reply.
>> 				       * We assume one is at most one page
>> 				       */
>> @@ -593,8 +595,13 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned in=
t size, int node)
>> static void
>> svc_release_buffer(struct svc_rqst *rqstp)
>> {
>> +	struct page *page;
>> 	unsigned int i;
>>=20
>> +	while ((page =3D svc_rqst_get_unused_page(rqstp))) {
>> +		list_del(&page->lru);
>> +		put_page(page);
>> +	}
>> 	for (i =3D 0; i < ARRAY_SIZE(rqstp->rq_pages); i++)
>> 		if (rqstp->rq_pages[i])
>> 			put_page(rqstp->rq_pages[i]);
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index 15aacfa5ca21..84210e546a66 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -678,6 +678,18 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>> 	for (needed =3D 0, i =3D 0; i < pages ; i++)
>> 		if (!rqstp->rq_pages[i])
>> 			needed++;
>> +	if (needed) {
>> +		for (i =3D 0; i < pages; i++) {
>> +			if (!rqstp->rq_pages[i]) {
>> +				page =3D svc_rqst_get_unused_page(rqstp);
>> +				if (!page)
>> +					break;
>> +				list_del(&page->lru);
>> +				rqstp->rq_pages[i] =3D page;
>> +				needed--;
>> +			}
>> +		}
>> +	}
>> 	if (needed) {
>> 		LIST_HEAD(list);
>>=20
> This looks good!  Probably simpler than the way I imagined it :-)
> I would do that last bit of code differently though...
>=20
>  for (needed =3D 0, i =3D 0; i < pages ; i++)
>          if (!rqstp->rq_pages[i]) {
>                  page =3D svc_rqst_get_unused_pages(rqstp);
>                  if (page) {
>                          list_del(&page->lru);
>                          rqstp->rq_pages[i] =3D page;
>                  } else
>                          needed++;
>          }
>=20
> but it is really a minor style difference - I don't object to your
> version.

One trip through the array is better than two. I'll use yours.


> Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> Thanks,
> NeilBrown

--
Chuck Lever



