Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B1661FD32
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiKGSSb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 13:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiKGSSJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 13:18:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC074632B
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 10:16:53 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7HNd6l028802;
        Mon, 7 Nov 2022 18:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ozKkNjT5cl5TiO6u/P0AruXwFOwqYXwD7PMJYBhwo1Q=;
 b=xnKeXD/TysYtFaqyvdG4q6XtTtxWsFiywQFq6wDtL1CJ1jLyx8x3CVPXRnEOPuY6KnEa
 7ACk2EANmlXvlPcSQzYnK+mJUeFeepZ6sckYFQKTCATrvhoFbrKFo9L3wvKZSTpMLoOq
 LYwQUyNJwRVbHTnU8IOLcUq9AWh8horkO8r3J0+CAARmQZIkcY6NzIw+rnCbY3lwonUN
 2e7LZpMzIukyhn4JfzogOSwgsLi1DAA7Nvcr71xzbKkDQ9yI2oDoxuspu9V1nj3C3/aS
 yK002+4gxnatW1eOUUYzG3xelGKZhKceI2/hzkmanIx0IA4iS87wmqzf578diQfYnLvM eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngnuvst5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 18:16:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7IF9fM010818;
        Mon, 7 Nov 2022 18:16:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcymue43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 18:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQxNRxX76HFp4cnfr6QhrMgb4lG2W5B0jDfIIfpHd/ENNqNuwCJyUE2cKdfd6a6WdC3rWbtz7+Iz6A9y2bfc1/Q5AAsEV0EHQhGM+YvpILaqy/MmgKXcfWukuCRYF13Z1kGYcnrObkIUHMngApNWX634hPdRL4/LH4JhGPnojzAKQL3v1qFB11EcY8Uk8Kc3/y6YHhFrgfr5yid/DvgFde9+hXVukEG9wrT2oxsgxSIg4zMzaoxpbc2tp+eOHnwVIttKw4e3xmt8aSVlNB/lWwwAnWQPuJ/ccq8+A0P5QP8uTMmDqykoYxHtNzHpoDW8HayswrTvdRj9KVolDfS0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozKkNjT5cl5TiO6u/P0AruXwFOwqYXwD7PMJYBhwo1Q=;
 b=I6Egm/7HfR+RIfuJdGzok+7s1ufNJpR3zcJ6hbMcSb6WshpBhNVJ0dRhm/nMBdSRAwpdtjHjQsOgLnlJ9/N60HEL1LZyVAP8ECZgdYUvomAXp7mhss9Yktb2POX7cN5bYF6YbMBJMHfzrL/YsFua51edQux8uryehc65sOS5RblyoQycSThu1S83Cw96xw7VgoZWQcUrFqScONf58HzhlBpcyNRuSMmSJamJaV1e3g2QbC6IhaiaOq77iJ9+ScZQ3BHgvK3r5lwU1zzqDdGDVf/zuU58fu8UH0h4X7j3Hj43NE79vzoEizweEwGueT4zEFAMi5OazBlvThNC/effYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozKkNjT5cl5TiO6u/P0AruXwFOwqYXwD7PMJYBhwo1Q=;
 b=dMHb63x73+A/yVwmQciL4a1Ua9xEXxPkGUSXUlWKi5tVcCVmo52JMEc/Q7MvL2YRnBiPHhjRw9eN4ossTZy3MRoO1dA984jBdf3tJ7TrUkEEcIvoydyDWJva5LycV65cRib5VG/LcmOTJ/Cry0bFqmj/z+u4LwsM+m75ckehgIY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5247.namprd10.prod.outlook.com (2603:10b6:5:297::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 18:16:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:16:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: remove dedicated nfsd_filecache_wq
Thread-Topic: [PATCH] nfsd: remove dedicated nfsd_filecache_wq
Thread-Index: AQHY8svsfDGR9gO670+nD/CKFPOHBq4ztxuAgAANfgA=
Date:   Mon, 7 Nov 2022 18:16:47 +0000
Message-ID: <CDEA2A36-B0EC-426B-8489-2BB524C6266A@oracle.com>
References: <20221107171056.64564-1-jlayton@kernel.org>
 <61876142ab0115a7bf39556e5caebfd1a635f945.camel@kernel.org>
In-Reply-To: <61876142ab0115a7bf39556e5caebfd1a635f945.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5247:EE_
x-ms-office365-filtering-correlation-id: 0e6d96f7-1da7-461a-ef82-08dac0ec3b95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5sF2r+YvN0qsGdCwg0fuRZB2zfkdslLTvGBGlrs3ThYyCc5t5cge0wEaCGLjSSOQ9X8bJQZm7rIO1A7qj/dPcxpQ9PxFEDwCXdm89QhJ6h4D/Tj4jGoh45Rr4lXcehzE58W6N/IQKkmUg5rJbo/dU6OKBx+nbCEuq6e7ZOyZ9yZB+2Rkd7YxN73NYn2MV36SLb3GzRHCt9ba9Kbm9gpWvEumE/ZanDKxA5Fdcfg7bprRsgbar1JAM2nbpAJn0C1G92uAuaCJFTTSGLWDwgTxCBXFbmCY2J1xuPZ1YeTrfFAcDauk7SQsemVTz1LeiYfdhSng3RqKb6f6/IfDET4jJW280aD9jHxagWi7O1R1xfQcy9KkTmoZ6T/wVCw7waQHkZ4JH7HZcCJh/ldq4+rdqzU48PRz7gRFhI9Zqf0fv61+bUzgKvfklpmuUGz1MFmAvsKV3yDFr8D3e0uVlLKroU97ejJR3CB0+g82dbvlQ7o3UqmdLxXlKM//pk5ebwGh3SomJ7pZO6iM/Ekdj++I1cMTEDWQPNAJ8J3G3ED7c3i8pUYMo35jYEOGpSsQKhYANclCMnE6U+xwgkl75QE5GA/yED5EaRujXJrvJPCS7bPpHR+JVwDFeMXwvIGv9anbeFdmLxhU+NrF7qRQH49GR+YTcXLEoEFCMPm3LEnFM0Bd9KR1r08DpFWioI9Ozcao+AiOy4GPpFJhAlLQ1yW/JL7prgDJwBIEmZtq9L0FJ0EpP9S6zblIKOhyxpHDQ0f7rySuYLmrVT0fIb9wsMmhnBc9uq159CpJrho394pgyw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199015)(2616005)(83380400001)(33656002)(186003)(122000001)(38100700002)(38070700005)(2906002)(8936002)(86362001)(5660300002)(478600001)(6486002)(26005)(53546011)(6512007)(6506007)(66476007)(66446008)(66556008)(8676002)(64756008)(91956017)(316002)(76116006)(4326008)(41300700001)(71200400001)(6916009)(66946007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x2WaqJeVgdianeqcFQaZ+qpArHJLWsMT56RFMmXel3tt4uSyUy6h5XwdITce?=
 =?us-ascii?Q?gsTSX9duBwB26SjgeF5mVS7YvH/oacZB/l02vVLi0jtJl8s6mGbRJ84Zhvm7?=
 =?us-ascii?Q?6crI6LzkZqGZYDriIAAey3JkfauRU7pswwvfAia4beduwwXa6+Jozfc6MRT9?=
 =?us-ascii?Q?HYudkbYi0Z+1j+H/cAR9AGySr+2yFgp5gaI78w6urtepTZmNtyitWrguOz9M?=
 =?us-ascii?Q?mgv0zfyTfk7MN5LKCLmr8YbCWyPf2esV+TKU3Byxy/HCad3OTzLav6tG7Ldn?=
 =?us-ascii?Q?U2kvtUKQkBp1tEb+z80YSjZUvTNsq08IwGIeBARWIrBGrePvpkcLTDGtYg6b?=
 =?us-ascii?Q?Qd+Krsk/g2D2JT1WjxENWCuM4uACTVpGy3uCnO1Q4IcqaROwXawba27eK2tI?=
 =?us-ascii?Q?0tgqIHi7KCHC//bAWO3f/JpFMACabuFqd7ZSaRJvjQu3cVd6hC2iSFGgW949?=
 =?us-ascii?Q?hlbN5OQWSe4TSH1IxcKKq5WY4zVvlPmmpk0Di6SZWRhcW7fBkI7LnZ0u4u6X?=
 =?us-ascii?Q?bferIIFFlwConisNlYdyhWqkGTQXwiCVPKfaWaAg9ABOvbSC0f/MrZkCQBHc?=
 =?us-ascii?Q?CMXuq6cUCbQv8ejoXLtvV1vdn3nGPrQ4HLOBybXcGazFUepMeBcjjfX9LLXq?=
 =?us-ascii?Q?v6MLjD/vtp6q8Syy6y48HUdHKl/JxZJ9nEGrYcU6kwkyF0ZHRDkbgSzb28LD?=
 =?us-ascii?Q?PXJr5A84v8NvGDu7f2P2bns4sH/3FtDPw48ocjxvKczt2yOpSCNSlV2GsOPS?=
 =?us-ascii?Q?XpMy8VkmJQCHhJEVN3UOpHFqAn4GlEo9EhjRuJSmT9Ja8n7/FShlMA3TroE1?=
 =?us-ascii?Q?wKsJlfYRixvP7LlJXKTb1z562u1z7My4PA5m+y/ZtaigAnXmS5f5fT5wQM8b?=
 =?us-ascii?Q?SXMmOAjWmLmIISXMhvjT0eAnrpR/sHxi3YiIIO0xT6l0IOOeuCOwlWH/fYiP?=
 =?us-ascii?Q?fr+5mx1X47bsB8lbNUcaGgbDFbdep/SjzMurjW6rwHwGqjUQZ16s1oJ2KZsN?=
 =?us-ascii?Q?jaCuKH0FkegOzshhec+57H57VH2GFJj9SZ2kfEVGVfVbqkY+99YcMfiT0igZ?=
 =?us-ascii?Q?Bw3MFdih2h2G3hEBfokVyPy5eLc6+fx4D34eJfWy6WDkGV+1RCzd1Q4cIVI3?=
 =?us-ascii?Q?+mqZhdecRzuD8kgDfqQ4pMUeyOhlA90ZpdJ4VgPSCP0/d4HPmVmVhXnxtsQa?=
 =?us-ascii?Q?XyNF6TNVcxwEHm73c83nSWnAyJhMEzCk9i9xKx5iW6hbm3TpxOVv7XXmaCqw?=
 =?us-ascii?Q?y30QWsflkIjUB2Lv3rRj3H8KDBkCwsml1bHIEVxjxqR/JGKj2UZAM+4cKIOI?=
 =?us-ascii?Q?zm/ScQR+Uqaj/W8PavzAZmbP2NvdS5Tf93easwRHZVL4zs7vjXz9MNsIXuLR?=
 =?us-ascii?Q?k7/Pn7Coj7OYjduUs+jb7Sn0mACVtegjPQUNevwoW3bf0PYP8zvjBP9yLAYb?=
 =?us-ascii?Q?YLV5pXnEYgTntmtpv3ZNp1vIu8AnBl1n56FePp7+FEgqIRQwpukVA5ZOM5qx?=
 =?us-ascii?Q?87e89lW3k46DUva0LLEU6IdYos3lH1nfRvwFmbkOdqLZHN9gQIgrpqEWUmtN?=
 =?us-ascii?Q?PUNWHYn6BpxwbYva9eTmjSGb1DcVdIV+gWhZKa3v+v66bzPvBPFB9u9uuaZd?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17634EEC2C80F745BB2ECAA8B6ED7B65@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6d96f7-1da7-461a-ef82-08dac0ec3b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 18:16:47.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZnOce+ibAyZ8pwdAgzBCghlPbR712r7Gt/rlRiE+PzEKtUN4fuGQZxIuFGnkJE4etywCRYbO2NBI6U5gptwuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_09,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070146
X-Proofpoint-GUID: 9RMpziMlhg0-Z1NpT-kUbkUO4L19DuDn
X-Proofpoint-ORIG-GUID: 9RMpziMlhg0-Z1NpT-kUbkUO4L19DuDn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 7, 2022, at 12:28 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-11-07 at 12:10 -0500, Jeff Layton wrote:
>> There's no clear benefit to allocating our own over just using the
>> system_wq. This also fixes a minor bug in nfsd_file_cache_init(). In the
>> current code, if allocating the wq fails, then the nfsd_file_rhash_tbl
>> is leaked.
>>=20
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> fs/nfsd/filecache.c | 13 +------------
>> 1 file changed, 1 insertion(+), 12 deletions(-)
>>=20
>=20
> I'm playing with this and it seems to be ok, but reading further into
> the workqueue doc, it says this:
>=20
> * A wq serves as a domain for forward progress guarantee
>  (``WQ_MEM_RECLAIM``, flush and work item attributes.  Work items
>  which are not involved in memory reclaim and don't need to be
>  flushed as a part of a group of work items, and don't require any
>  special attribute, can use one of the system wq.  There is no
>  difference in execution characteristics between using a dedicated wq
>  and a system wq.
>=20
> These jobs are involved in mem reclaim however, due to the shrinker.
> OTOH, the existing nfsd_filecache_wq doesn't set WQ_MEM_RECLAIM.
>=20
> In any case, we aren't flushing the work or anything as part of mem
> reclaim, so maybe the above bullet point doesn't apply here?

In the steady state, deferring writeback seems like the right
thing to do, and I don't see the need for a special WQ for that
case -- hence nfsd_file_schedule_laundrette() can use the
system_wq.

That might explain the dual WQ arrangement in the current code.

But I'd feel better if the shrinker skipped files that require
writeback to avoid a potential deadlock scenario for some
filesystems.


>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 1e76b0d3b83a..59e06d68d20c 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -66,8 +66,6 @@ struct nfsd_fcache_disposal {
>> 	struct list_head freeme;
>> };
>>=20
>> -static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
>> -
>> static struct kmem_cache		*nfsd_file_slab;
>> static struct kmem_cache		*nfsd_file_mark_slab;
>> static struct list_lru			nfsd_file_lru;
>> @@ -564,7 +562,7 @@ nfsd_file_list_add_disposal(struct list_head *files,=
 struct net *net)
>> 	spin_lock(&l->lock);
>> 	list_splice_tail_init(files, &l->freeme);
>> 	spin_unlock(&l->lock);
>> -	queue_work(nfsd_filecache_wq, &l->work);
>> +	queue_work(system_wq, &l->work);
>> }
>>=20
>> static void
>> @@ -855,11 +853,6 @@ nfsd_file_cache_init(void)
>> 	if (ret)
>> 		return ret;
>>=20
>> -	ret =3D -ENOMEM;
>> -	nfsd_filecache_wq =3D alloc_workqueue("nfsd_filecache", 0, 0);
>> -	if (!nfsd_filecache_wq)
>> -		goto out;
>> -
>> 	nfsd_file_slab =3D kmem_cache_create("nfsd_file",
>> 				sizeof(struct nfsd_file), 0, 0, NULL);
>> 	if (!nfsd_file_slab) {
>> @@ -917,8 +910,6 @@ nfsd_file_cache_init(void)
>> 	nfsd_file_slab =3D NULL;
>> 	kmem_cache_destroy(nfsd_file_mark_slab);
>> 	nfsd_file_mark_slab =3D NULL;
>> -	destroy_workqueue(nfsd_filecache_wq);
>> -	nfsd_filecache_wq =3D NULL;
>> 	rhashtable_destroy(&nfsd_file_rhash_tbl);
>> 	goto out;
>> }
>> @@ -1034,8 +1025,6 @@ nfsd_file_cache_shutdown(void)
>> 	fsnotify_wait_marks_destroyed();
>> 	kmem_cache_destroy(nfsd_file_mark_slab);
>> 	nfsd_file_mark_slab =3D NULL;
>> -	destroy_workqueue(nfsd_filecache_wq);
>> -	nfsd_filecache_wq =3D NULL;
>> 	rhashtable_destroy(&nfsd_file_rhash_tbl);
>>=20
>> 	for_each_possible_cpu(i) {
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



