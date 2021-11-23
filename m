Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C745A91E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 17:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhKWQra (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 11:47:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26824 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236314AbhKWQqt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Nov 2021 11:46:49 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANGIk1T008367;
        Tue, 23 Nov 2021 16:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IdyNW7Wtbh5WTwSIQgCXWkzg2cLHs6FhCtuqVGyvgEs=;
 b=ZAkiSmQOGWs8btdhspzNRyWpH0KTBb/0cHqb2I79fe2jFy4MZTeKuI33KaylaxokW79o
 HsOLnHZ9riqu2AgocdNZn3o3QaDwDDVLDsfv+EFwZXIrsv3f5WWQ+ll9j+R81vPACR7X
 xyMVsNgqxreihSXNVZI5Z/XEEZ+1HKI2bqCpREHdBAzvrzduAXeqkt7JJmz57rkatJ5Q
 Y9GlxOsW4UiFNgf6AzSv4dgaac7tGVx3wdYhnEeNyAplgMfWEK3QiOrWAHfybVclh88k
 5Davd5uw2KtMyfTHG5lsQOMQFSMS7BfZFCXG+wbIvH88LvLLZIllRVuJ/0oDKPPfFH1U tQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg461jdbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 16:43:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANGUpOT084816;
        Tue, 23 Nov 2021 16:43:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by aserp3030.oracle.com with ESMTP id 3ceq2egv7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 16:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6Dm2A97YMwYGNx178+TbVB9vZWlRtXjfX6xxePu65LJ1g1yryoR6F9g5SvbRsAjZiJT16RsypZUbLaW1ACddbdKpVgEEo8kxqO9GBkHjTlbmKdOINLRYWm8B9phheRvSFwVgXZkHa4GQkuobwpQ+T7jkViXujg7Vr/3KlaYOro1ehX9YZ87VElYsy6CuB0YyaBLCz8YtNqUMRozoTfSUrpaV55INtpszOlM+HJjr40LBW6Ejetq9TpRrfgbP7rZ2X9O3yzR1bpdZLYYPoAERWvZoy6Nhgw2AhdbwGEV6VNg8h4bdm2sz8JpS4RbWJRcWuTLh0xyLXr4fvAJXSROww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdyNW7Wtbh5WTwSIQgCXWkzg2cLHs6FhCtuqVGyvgEs=;
 b=ju1lOVUmz9sfJFAzSGHi4mOA2r5BvM1aFjltSJzJ1pe0CqAO/tFMyIwU5UQv1OGWoXwQ5TdUnFgjU+gxEVTHG6wWNuN5IIuoB/330iwLd6Zq/5JufUrKjZhzSDhQFaZYnfaYO8z9fPRQjIv5DGO7Ob7NQ5ivZg2j3SuC8DT2mei8rgDevIzMjbaQVDvpD77PFRC1twIpGkjo/CSxnbKX3LALykRog5E/bUe0Czaq4wJsw9GZdeanUVtWbMMnKhx2w8G0zH3Oxc1E3uqwcU2Wb8PaVXCYc+DJZr1czwGwp+6PUCgpLv2W9RSZ0xy6hqDJHcS3GR/a7xIsEg8YOepJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdyNW7Wtbh5WTwSIQgCXWkzg2cLHs6FhCtuqVGyvgEs=;
 b=dt1w+3vpkbSiexyBOikDT5i0rIxorVCN61DrfbYyaL5ccEdZtGdqNJ5nDYkqMZWuKs3CL5vv6WtWRQi3Se+vY5y0QDJ/KbiNgF4QoTEzDLz4mmvdqm2ST9uMvBENAEP7viXF/fUSyvPVTmq5XgvRVcm2v5xTQEFWr8dpU2EnRPI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3720.namprd10.prod.outlook.com (2603:10b6:a03:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 23 Nov
 2021 16:43:24 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%7]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 16:43:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 05/19] SUNRPC: use sv_lock to protect updates to
 sv_nrthreads.
Thread-Topic: [PATCH 05/19] SUNRPC: use sv_lock to protect updates to
 sv_nrthreads.
Thread-Index: AQHX4AnWWLhNYiXw30KvzT4KsHcZZawRUmIA
Date:   Tue, 23 Nov 2021 16:43:24 +0000
Message-ID: <3877F926-545B-41AF-8C0C-80582E83F1FE@oracle.com>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
 <163763097544.7284.15751243743215653521.stgit@noble.brown>
In-Reply-To: <163763097544.7284.15751243743215653521.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c3b841d-6ac4-4e96-480e-08d9aea05e36
x-ms-traffictypediagnostic: BYAPR10MB3720:
x-microsoft-antispam-prvs: <BYAPR10MB37208D67F3591456C72C951B93609@BYAPR10MB3720.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/fJbJ0TvM3lezvqQv1pnoREVrFMdiqXl0kSnmMjuCnvVa2Jj8koA1NeqWP0VMM3bq8oN3twueVEKHa3KZ2W3eM0Z80htSqi+Wyj1H9P0kT4RvGtjVzw/Cie3lmToGp0aPyIRLHBHGVY9wEYOGUBkpO5G8uMcdkwEZ6PgoZri0T9Lsyfs6dt3VbmacXWb1zFSh7b9QVcLO3DDNSwS8exJB3OFJr+VYnu0GTqlhtg8f8KswZ23vrDlxFgEBmDgZagB/z4f5p8TcRtjmQkHu2/+fVdyG8lFWOS5qxUwpl5R+hQFlXmrOczrZwhNV861oaR0AR9YsTklWmuaTgHU4SpMR7/NmhuZP6YUizWyok0/uHE2uatn86PvfdrUOf95OVh7obR/UX0KXNZj/Z2J09Nq90gahgNMll/dX/7JHuKUxlruusUVBGCaRq1aRv+RK4/DK04bxloM//xVK2QXC7K1CxjPjh2iFj1pKLL6+L6jyD+ct8U7dh2zvYYU+fsk4cAug6DuHrzrD15/a12txRGxYW+MNzTsijWT8K4on+YTMAYxwMpoWgfYv8SHkRIkfHo4LtL5Ccd2T4kAeRx2hus9JZ9Z1hd9Fj7ADTJPv8xJjIBXzmC5Dr7x4mxgnWu79CF2RlpVRlxvYT+FawDY0ps2R8BJeMtKAUa7D3tuFhMW7kHigBGFScBWtNFqlY45x3uLpt1SAJljKZshgUVX9k4f4xneMd92A1XeewAIDoiap2ZHOVCjh2aKrCPAS5KxiuV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(66476007)(122000001)(64756008)(66556008)(38100700002)(66446008)(6512007)(5660300002)(508600001)(316002)(15650500001)(8676002)(71200400001)(53546011)(6916009)(36756003)(86362001)(38070700005)(83380400001)(6506007)(33656002)(26005)(91956017)(2616005)(76116006)(6486002)(186003)(54906003)(66946007)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d7HgDSbAM4VlBVC1yt1apPbVn4tbHmarD3l0wJz6aaoDKoHhjcnHP27+WGtB?=
 =?us-ascii?Q?FtUig1kJMKgxNJATr0FPPuDhvGBUNKfUlsvN4ZXwmcJVLw+cljCEct9wUr69?=
 =?us-ascii?Q?s6s34JT0PImvNUR6KG3nqN2FMs/yOStT7L1c0QAjdI98qcWogo/QK1ti81hF?=
 =?us-ascii?Q?yyjFTuXCYkKuGJCl0cIqiJVUVA+jbmX2Fu1Bp44mcj/gEb3sRJraYCzU+5Vv?=
 =?us-ascii?Q?09qqCM+HuHr3y9ody3sdAYdtaWqHgkrgq1dvVdDkfqF0BOl3d6NLoVgTU142?=
 =?us-ascii?Q?M35IBkPevLkUHt1pGRJ74f/ebNxg4cNov/91aV2VgBnT4rpVVpzVYfHCzaUW?=
 =?us-ascii?Q?jdcahY/VYl58bYQkZVyEkiqzEQaBYCwwwE3UoW0zPtndm43IO3dU6MNQKZSu?=
 =?us-ascii?Q?7lStyHqOo3HRpFCFNljjNSOroqAiLrZVVoGsOGZG+JkQYV2QT1KIG5m6ar1y?=
 =?us-ascii?Q?FxMxuMYqWy0mkOAiBZGXxXGqNqoHJikAXOiTDXQWSjyYbE3LOd9App3QnwnH?=
 =?us-ascii?Q?KCr9NMuVBXySAQ7n3YmSVO3QekDOsQq9P/1And5SDahN0o2xgr+zDEZfivPR?=
 =?us-ascii?Q?5qyhIZs0TW7S9fgo6LAVtEgGh6pTdtBiJSkjaWAL4J4Ya5LsPd/DfEEIQHB6?=
 =?us-ascii?Q?sqSN9kn8gadq/UA7LdLHSm0zfIOGisx5QZO1xNvClFpn85pu5Gph8UY2egth?=
 =?us-ascii?Q?FNuxd4fA/zLiRc10+q5YAq/0YeEyZjhp51Cm9dQa1QWFvCPWjOWSfnVlHxIz?=
 =?us-ascii?Q?WetFG0D5RzfqNmJLnU0NFyQf7epAdxnc7Q8cDxCU4cgESuuAw/0vDBUlKw2M?=
 =?us-ascii?Q?Wzau4BGq1jDHfHp2Lkvz1QVcpohHHuPlLOPdBcmFKYkOlyMNs6xhyPOwro4x?=
 =?us-ascii?Q?S0pH807juc14SDhxMATeqcSJ3B+jd4LA5PQaIcrcSWyNh83WygZN7vXCknQC?=
 =?us-ascii?Q?yE08OClKLsAUa2LP2TEKPC2BPO37cyFxmKTRQoGhxCN3e9pBp3RHaPqaxL+5?=
 =?us-ascii?Q?7NJsg5qgTE3R3w6I+equ29OA0pPXNK4giDM/HoGn96QzExsxermbxVNq4NJG?=
 =?us-ascii?Q?wQS40TxQYhe4gOJp7AcUKWF8BdlIjMIsxDls5CUw6rxh1flwYwRKhWMegV8R?=
 =?us-ascii?Q?dWtNUGhKewji6lZ3JZLOFwFL8DYjz5DYbD0ubS9eIs6WIkJ2DeyDzXh0rXYc?=
 =?us-ascii?Q?Xc3ED/zQ28pz6gvqg7R7eug5Ow8tZEOIblCu4dPjbotdSHWF28D81t4xFKhh?=
 =?us-ascii?Q?wEiHBd/oXVw1eJTvH4Fr/mBeuiNv5jTNJTp2cT1MuFFHPUzRFTinrQdSwuHq?=
 =?us-ascii?Q?++bZV6M7RCplLYVuDoMf8qKz6lr91swKZKr8brNYduAr0hw0el7Az2o68VsX?=
 =?us-ascii?Q?BM1EsrEOIwj4koKTDXHfrlFAve3m5N0HdsI2kBzzqYSwT0jnwFvXZEB5SgWM?=
 =?us-ascii?Q?xn88xfx54YtbgXbp8sQFjMJu43zoe2rnBMGBP35pZQOjGpmERo7XakZ+V3MP?=
 =?us-ascii?Q?DbIiioU/HuuXIBo0lb6SOzqyEnfPs5ZJmhUquYsfkczy9GQTXlCzq04KqYfi?=
 =?us-ascii?Q?dF4m3JZVAM5KFvMk7+zByKAEcM/thHlVIyfz3t+kkUQI0PMDxX9mNugafYeF?=
 =?us-ascii?Q?tNsbqZjlunjh2unz9QmmebA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <123FF15F833A5940999B4580EDFC4BAA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3b841d-6ac4-4e96-480e-08d9aea05e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 16:43:24.7495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0DBWkLIfbhGmwlDupKU/WfA+1jRpTtUdXo0ZJ8++i0/4qUhqXaas8KTwjkIYVOLLcMbeMW55sPXmGBWJrR+NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3720
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230084
X-Proofpoint-GUID: IWrGAuu8DrsPwZMBPUm4M7SdQeMkY3j5
X-Proofpoint-ORIG-GUID: IWrGAuu8DrsPwZMBPUm4M7SdQeMkY3j5
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 22, 2021, at 8:29 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> Using sv_lock means we don't need to hold the service mutex over these
> updates.
>=20
> In particular,  svc_exit_thread() no longer requires synchronisation, so
> threads can exit asynchronously.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfssvc.c |    5 ++---
> net/sunrpc/svc.c |    9 +++++++--
> 2 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index fc5899502a83..e9c9fa820b17 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -55,9 +55,8 @@ static __be32			nfsd_init_request(struct svc_rqst *,
> 						struct svc_process_info *);
>=20
> /*
> - * nfsd_mutex protects nn->nfsd_serv -- both the pointer itself and the =
members
> - * of the svc_serv struct. In particular, ->sv_nrthreads but also to som=
e
> - * extent ->sv_temp_socks and ->sv_permsocks.
> + * nfsd_mutex protects nn->nfsd_serv -- both the pointer itself and some=
 members
> + * of the svc_serv struct such as ->sv_temp_socks and ->sv_permsocks.
>  *
>  * If (out side the lock) nn->nfsd_serv is non-NULL, then it must point t=
o a
>  * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0 (unless
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index acddc6e12e9e..2b2042234e4b 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -523,7 +523,7 @@ EXPORT_SYMBOL_GPL(svc_shutdown_net);
>=20
> /*
>  * Destroy an RPC service. Should be called with appropriate locking to
> - * protect the sv_nrthreads, sv_permsocks and sv_tempsocks.
> + * protect sv_permsocks and sv_tempsocks.
>  */
> void
> svc_destroy(struct kref *ref)
> @@ -639,7 +639,10 @@ svc_prepare_thread(struct svc_serv *serv, struct svc=
_pool *pool, int node)
> 		return ERR_PTR(-ENOMEM);
>=20
> 	svc_get(serv);
> -	serv->sv_nrthreads++;
> +	spin_lock_bh(&serv->sv_lock);
> +	serv->sv_nrthreads +=3D 1;
> +	spin_unlock_bh(&serv->sv_lock);

atomic_t would be somewhat lighter weight. Can it be used here
instead?


> +
> 	spin_lock_bh(&pool->sp_lock);
> 	pool->sp_nrthreads++;
> 	list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
> @@ -880,7 +883,9 @@ svc_exit_thread(struct svc_rqst *rqstp)
> 		list_del_rcu(&rqstp->rq_all);
> 	spin_unlock_bh(&pool->sp_lock);
>=20
> +	spin_lock_bh(&serv->sv_lock);
> 	serv->sv_nrthreads -=3D 1;
> +	spin_unlock_bh(&serv->sv_lock);
> 	svc_sock_update_bufs(serv);
>=20
> 	svc_rqst_free(rqstp);
>=20
>=20

--
Chuck Lever



