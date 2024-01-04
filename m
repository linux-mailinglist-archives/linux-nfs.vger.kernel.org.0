Return-Path: <linux-nfs+bounces-936-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A628244AB
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 16:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7091F2191E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C176E23755;
	Thu,  4 Jan 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgSv0ll7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MkctnApj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6397224CC
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404F66KZ026348;
	Thu, 4 Jan 2024 15:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=AQDzmifRJcqXsH+zWV5BmjmpCynW9WdnntZWgPsELoU=;
 b=mgSv0ll7FOzyQNx/FMTS40jB+X1zKBFldQF4YhTNM5WQfBmbFdFMR1XTVsDrMj5+kD/O
 wACYZCxi5a6RxOcfJbCrTaow6kSI70goeJ8u1Cni/lBQkN5KdOeAKlV164ds1HOiTyL4
 y1n78WeS+AeibvMyJJJZ3Gbgein7nVnICwtmxYM53PyrBYoxa4AIuteOiVNr2f7I0dQs
 3x5TD6sM0PVCJVKY5J0qj5POwzDFWRsHDhe7NiTQ/cqx2YbBKH7CWqj8nxUHtuD4jhim
 WOlgkaduOe5UlOSbdIm2rpf52cKsqbFjVLWoWXv4KAfHO/1D5Giw944ewHrc6X91GIDj Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vdy0k80ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 15:10:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404EFA3P015831;
	Thu, 4 Jan 2024 15:10:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdx1jd5xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 15:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgKD6GGsm22Ao7VpaxMCLrbRu2q70ejKkb5b+NdqAo+Q/49i724aL7xkkfH0HfzPKzG0Skf8dlHDsTWwY1qcU7JGUeLxwi9LvHmMJ8hNMjXZYlW5cYfDATL/vH7G9kmApIgttkKUnMt7o0dhpe7XS+cRZ1fuc1basS658SBulkdG9U/6rAHb6dduePu4zCCzrxqRRwRDISW31SHh3mdqfio6f2puZzKkwTWU5jhysLss/c9mxS/JXaUi4uL1m7glrMvI4w9ZzOTRj63DyXgp4IxpTUqMU9gY0Gs6Aahcx/OF81V5hTqnwFiTu1um3iOdqFI33B3n72pO5LUpT1OUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQDzmifRJcqXsH+zWV5BmjmpCynW9WdnntZWgPsELoU=;
 b=XSurqxLS7gHmFZVpxnsIimU7vfc/rVuNutb3K9rcaJvNkvSRaKoV4SlHODbVC2rL6o0CGioTGRALEAuYWifPhvPtgh8G/p0IRUxTOVYrxNPQV5Qcxyq0fi7WnzB6uWZ4gWCK4jJM4itPjFsZf1SJb/Asut5x7ZJyUtSe70XHupMeSJkI6tBw1D0otxIKwpvKpAg5nzN8I7I6+VpOHLIfEV0Rk/ztm+OvxoiI6Xl7XeTUiCWJ7RFaqRpM/8T+He+9bYrBgQtjro2Jc5WNN1Q062g4KlePXpvHPWL/EK8GiSntJX94hN/w0gHA/43/wJLigps7BPy9l7EhyGvlTMJPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQDzmifRJcqXsH+zWV5BmjmpCynW9WdnntZWgPsELoU=;
 b=MkctnApjKvUO8VTGbbwbojrWHFVJOKUztxzx/L36/YGmzvdz2wbG0NmZ2/Ah9H8/cl+humEwtcS2Ja2AyElpR559UMpRq4s2zMy0RAFC9oqm4ciepC0nyJqeCFQI9us6aVJzY0gX2qc0ihuo0plPbY77P9/m30khyZ+1ETs7kRA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6429.namprd10.prod.outlook.com (2603:10b6:a03:486::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 15:10:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 15:10:00 +0000
Date: Thu, 4 Jan 2024 10:09:58 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/2] SUNRPC: Fixup v4.1 backchannel request timeouts
Message-ID: <ZZbKRp3oe1lptDvf@tissot.1015granger.net>
References: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1704379780.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1704379780.git.bcodding@redhat.com>
X-ClientProxiedBy: CH2PR14CA0032.namprd14.prod.outlook.com
 (2603:10b6:610:56::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bb1f48-c916-4219-3408-08dc0d373892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yKNsXDXM5c4uCr3Qhm4xiXnhFrxuHIaFYu+R/rqoGgIPEVUeuBNG1gRmTPeucwaqQIwEd0swjx7WHnFZxAXNv81C+Ut8eYwUGXTxQkOjeVSr9s4jacJJkLobtlGbucDTkqjUOpKcLRsLFwaWFS7lQOlsnhfhkiou4m441cHQZIDgDCvaTYqNJWHq+O/jmI0qb6fSuUMhouymiyDiSD+kLF7EOAPYcd1Km/7JaCyyx7I/MlCBkLjkEUA1bYvndqQ3yAMF+rTtoMwDkOysOL/rxNxhV1rL9yRtNFRKsJltS9Bbr+VI8yuwiG1T3ju6/2jBdTLWFeYJKdxOzOngmKX4MiYCZWB9Qr2N59qkZxuX2LPq5we/YUtQY89lgYMsGoCuwsTB5iZ1en4F6Wp6OGgzxIW7Ja2XaOM1GYyz7Aifb2b2pNWTEcogbXS8iq6biWe/i0gOYKwrpxacDi/uf0MH4D+FmCn580muCvnhtK2IO4D2DZE2lYSXKptUSffZQ1gzQcQKA5SrKHgHhTHah4ybufRFbyTsMciVUQwG1k4eu+nls1xKUndJOLgB6xxbpWf3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66556008)(66476007)(6916009)(66946007)(9686003)(26005)(6512007)(86362001)(38100700002)(83380400001)(6486002)(41300700001)(6506007)(478600001)(4326008)(5660300002)(44832011)(316002)(54906003)(2906002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9x+d6JhMjHWI8V1lU8h5O9qDfTF/8SEA81L2wkNpe0sVhpCg7qpoqiYNaTQ7?=
 =?us-ascii?Q?BQj0/OSzqLf5n7ZXo9xbyjd8qgkhovb9bLgVm8WxtaoHWs8O2asrSiqPyYpe?=
 =?us-ascii?Q?VKgM0iGsf7TcZbGxZWUAP+UdQfN7CN47LjgdCg8H3NmyNxdztRoS0M0GoYyX?=
 =?us-ascii?Q?hU1W7t/DpLLf7zvRrH+IlJJVym7mjRZO0xX8bFwutoScgvNPNdxUQtAPMvV+?=
 =?us-ascii?Q?Co1mYLqe0egUkVuuYWmBeiQBEQNxng4udzIpgQRrNFOx4KyT/sYY7TaEsfSJ?=
 =?us-ascii?Q?XHdtFvkta8RAPTQORbfr05fyQmMNy4QoYg6rNPVzYVMiY/OLGjbhc7Owy1xD?=
 =?us-ascii?Q?ES6d75Tu0IGWQkM5DnHm8v2hmINBLjYbKUxqLLTb43tqYIwIy312HScZryHB?=
 =?us-ascii?Q?L9/uRELvGox34GINq3UCnVB1YQzwLyW78lPva24aMRYjYuLuzVQnqDj8irkX?=
 =?us-ascii?Q?C3VuKxd3qEJD9QuTtOwUyw+LVYSrALAgF6ecSbDYq+1gZyrfRmgFhBJrFfQT?=
 =?us-ascii?Q?Y/ZseQU3zkiyEjmw1MrC3De7LQXsx6HTmPH67E82/C6wzsqmkZuDbzrZVVuJ?=
 =?us-ascii?Q?7ZLt0+07k13rz03GFMQNUK+oh/h2lYHr/689946Ikf/Mqb0lXD9CfxAjGSqb?=
 =?us-ascii?Q?FzycWp3vq6wEYelhnk9hh6zIaxfW+6PyAuxVif9N0xX+rtOH7TrE8WiiZ8oe?=
 =?us-ascii?Q?eOeSgPfrhw9PgkR3UtF6CbShTNpJNIOpCDXFYnNNlD/5p42Dx3M1euWZPYTQ?=
 =?us-ascii?Q?MB+bydcizJpZcVlP7kvEIzM7OL5qTgLTOTG4GzeLNf2pMNvoNMWgOkKf4edI?=
 =?us-ascii?Q?pxBs9Hw/wD72um2UNpX//a9nAJ9bJ9SvmM9Vf9ufwIaIw2x1F4uPUbQrPDvR?=
 =?us-ascii?Q?TymoKb4KqgS0n772LkRmQg5iy8p94fZaBUlGTyHG+EefKucpYcLjGljjayxQ?=
 =?us-ascii?Q?o+EW/U9ngIX8Yl8gehKH7dugT3MKf6wwSFnyGVxh4kIjDUcFH4TiuUwSi/Co?=
 =?us-ascii?Q?0htMoiOvAcNig1vH/OmpMIm5N6vYfYoAoORSxYIK3Tlt19PI2mywY/hirFYn?=
 =?us-ascii?Q?nYZYpfy0p6NkvbQPCS61w5wCFgE+zkXS6J6IjHOlcQJ+UvP6A3ZDtbO/a8Zz?=
 =?us-ascii?Q?TWPPsoT552GK9G50oqomnzUlvHrmkBrtZS0+/GzDo+ib1CpB78u4lIyWudAh?=
 =?us-ascii?Q?a113pzZoUEpJA66ZlHvJFO1sc1L9zWwHXUNKC+PoslffLdJx2qcergytoxyE?=
 =?us-ascii?Q?P63Xo/v/sDVcbZhzi4bZ93++ez72iwPMyLDhVTqy3ak9ywq0u5HhrynlKvzb?=
 =?us-ascii?Q?NYlRcOI92FSiwBSRgAIfgWZidf4tfno3fuRte0yHHQRgg6I9Dm3yvAyQP5ZV?=
 =?us-ascii?Q?vN18qB3s5FaBw7IGDtBmnVRrX95CMLCHxXJquu+AObtvgvNtGEb5h3CcPnd1?=
 =?us-ascii?Q?EdY87AF9zoAyNSSYbNGsQDXL0LPR+Uml7tUKfC6wRkfUZ1faOydeHXK4QpEO?=
 =?us-ascii?Q?/tyOom8WPVaRWK9OAdLu1M9U8Gy/hDWN/13Jw+XBKqwxgO0+jdYZ5warhVmX?=
 =?us-ascii?Q?n3FLo3x9Cn52sTtMrK2QkYboGPnEyCSScq+4xolaCDhsdmgkRYwKghgrv19a?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PFz7o/4tXZSQaLQIf9wG9omxtb4ly7rqZ1BRILddxXnEDbRKGTD9O1ETAqf9ATHVy/QyfBuf327NUF1XUYveNz8QiTavKUPjXrylfKz3vUxwDJS4FEH9/SEJXVQzM1jHxt9EMTrVa8SU9eWo5aLPtEMSUHBEuEiBCNMKF/k5M1nLEGj4jZ9PtvsCNBt2r/dkgtNAQ334DWtso4Qf7qedWsMQvexHqx1gxGqZ+xzbDwbgbszTogPkU9ElAAiaTGKj3LDm6ZvWByxtoLfEh5eOsP73+pp5pBleaJvgAjSxR2NtHC3WLC0KgPZwVoRjL21wuGWpkNQJthax2GVB+0e3W/kAtD+Qo80dkHfwzRF6UE0wakEVqXkRF8dybn4GD2tuacfNOSm5fm0Un92w1BMi2gdgTS0hnL2a+KkckyAvsn+Tf/hJ/eojEA9vawqRGeIXE97BFSpW19HMjXsWzC/vKGO2VOnDzWArRhUKmbZDDbh9fMnNWRqWfEWOQ5GVrhDqbKrf7gm3bb2U8oEXsi/96hWxCUGvBCpo1U893wZc/bvez9pld+P7bn+JVeYjRkkbrdqxqGPmIjox37e6VBQfraXcfnMCO+iunKB503Z17eI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bb1f48-c916-4219-3408-08dc0d373892
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:10:00.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr1/jTsRZCI38g2we2VA2sYnKYRDJuVTVSq9dMm+6taG2CWBMqShODs2C5+HojuwHTgIDX+t3bVFOTAOkuzWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_09,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040119
X-Proofpoint-GUID: _9ngiag1usdZsJh6CVAwjX3xH5jF29Mu
X-Proofpoint-ORIG-GUID: _9ngiag1usdZsJh6CVAwjX3xH5jF29Mu

On Thu, Jan 04, 2024 at 09:58:45AM -0500, Benjamin Coddington wrote:
> After commit 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on
> the sending list"), any 4.1 backchannel tasks placed on the sending queue
                      ^^^

"any" ? I found that this problem occurs only when the transport
write lock is held (ie, when the forechannel is sending a Call).
If the transport is idle, things work as expected. But OK, maybe
your reproducer is different than mine.

One more comment below.


> would immediately return with -ETIMEDOUT since their req timers are zero.
> 
> Initialize the backchannel's rpc_rqst timeout parameters from the xprt's
> default timeout settings.
> 
> Fixes: 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on the sending list")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  net/sunrpc/xprt.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 2364c485540c..6cc9ffac962d 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -651,9 +651,9 @@ static unsigned long xprt_abs_ktime_to_jiffies(ktime_t abstime)
>  		jiffies + nsecs_to_jiffies(-delta);
>  }
>  
> -static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
> +static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req,
> +		const struct rpc_timeout *to)
>  {
> -	const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;
>  	unsigned long majortimeo = req->rq_timeout;
>  
>  	if (to->to_exponential)
> @@ -665,9 +665,10 @@ static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
>  	return majortimeo;
>  }
>  
> -static void xprt_reset_majortimeo(struct rpc_rqst *req)
> +static void xprt_reset_majortimeo(struct rpc_rqst *req,
> +		const struct rpc_timeout *to)
>  {
> -	req->rq_majortimeo += xprt_calc_majortimeo(req);
> +	req->rq_majortimeo += xprt_calc_majortimeo(req, to);
>  }
>  
>  static void xprt_reset_minortimeo(struct rpc_rqst *req)
> @@ -675,7 +676,8 @@ static void xprt_reset_minortimeo(struct rpc_rqst *req)
>  	req->rq_minortimeo += req->rq_timeout;
>  }
>  
> -static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
> +static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req,
> +		const struct rpc_timeout *to)
>  {
>  	unsigned long time_init;
>  	struct rpc_xprt *xprt = req->rq_xprt;
> @@ -684,8 +686,9 @@ static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
>  		time_init = jiffies;
>  	else
>  		time_init = xprt_abs_ktime_to_jiffies(task->tk_start);
> -	req->rq_timeout = task->tk_client->cl_timeout->to_initval;
> -	req->rq_majortimeo = time_init + xprt_calc_majortimeo(req);
> +
> +	req->rq_timeout = to->to_initval;
> +	req->rq_majortimeo = time_init + xprt_calc_majortimeo(req, to);
>  	req->rq_minortimeo = time_init + req->rq_timeout;
>  }
>  
> @@ -713,7 +716,7 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
>  	} else {
>  		req->rq_timeout = to->to_initval;
>  		req->rq_retries = 0;
> -		xprt_reset_majortimeo(req);
> +		xprt_reset_majortimeo(req, to);
>  		/* Reset the RTT counters == "slow start" */
>  		spin_lock(&xprt->transport_lock);
>  		rpc_init_rtt(req->rq_task->tk_client->cl_rtt, to->to_initval);
> @@ -1886,7 +1889,7 @@ xprt_request_init(struct rpc_task *task)
>  	req->rq_snd_buf.bvec = NULL;
>  	req->rq_rcv_buf.bvec = NULL;
>  	req->rq_release_snd_buf = NULL;
> -	xprt_init_majortimeo(task, req);
> +	xprt_init_majortimeo(task, req, task->tk_client->cl_timeout);
>  
>  	trace_xprt_reserve(req);
>  }
> @@ -1996,6 +1999,8 @@ xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
>  	 */
>  	xbufp->len = xbufp->head[0].iov_len + xbufp->page_len +
>  		xbufp->tail[0].iov_len;
> +

+	/*
+	 * Backchannel Replies are sent with !RPC_TASK_SOFT and
+	 * RPC_TASK_NO_RETRANS_TIMEOUT. The major timeout setting
+	 * affects only how long each Reply waits to be sent when
+	 * a transport connection cannot be established.
+	 */

> +	xprt_init_majortimeo(task, req, req->rq_xprt->timeout);
>  }
>  #endif
>  
> -- 
> 2.43.0
> 
> 

-- 
Chuck Lever

