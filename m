Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFAA3919C8
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhEZOTR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 May 2021 10:19:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59256 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhEZOTQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 May 2021 10:19:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QEFR0c124466;
        Wed, 26 May 2021 14:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vJESDhGm0kMDoK9Xy/jvx131T4LChtQr+9ZaR2jDQJA=;
 b=HTLyFqNL49HARlb6MmuWdTd/3jpaPobhTVDkQpURfCf3YWB//awYkSWWhdkIUJJ3lyQu
 tuNPHS393yYt3lg17yOP01HlSRk2r1ARklmBo3invYXMJ/E7ZGGcXJQGW2JjPbhxmJ9a
 mQD5QfwAXOKJO470FNec6iBoUvLaouYkr+8Qudop57Zebwsz0K7dT8kOI7ie/J1T+9yB
 sEvavyn0724GX0Q26wrTu7uUAUAFekDB0PWlChG0aUyAiq9eaz9NQkCbdOwwKXQzeK5E
 M5BhXCLzzd7k+sPeOCI8Fuw063okXs8GJ6bklmCtO5qXRS7ZKFkGIHIQNbKwOXKBNFlK 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38q3q90kt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 14:17:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QEF3BI193788;
        Wed, 26 May 2021 14:17:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3020.oracle.com with ESMTP id 38rehd6cgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 14:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc8kVZVy30P34e+AiBnjPldwPWPvDGXyOKeVyWT+cqj5Bc1HxLw5wtRFWrk3HLWmtyJFmMGmr3Qzyboo9v2eBiyfrl1wB01miQm1hlaZNMc4fMgqK3lj8iZRByXUQ5SpNRlGUQdJDAfzqrI7LoSXrmEZf6D5fpIwTXt8WUtwztomyLMbC5qpWfIvpTBd5tQLENV0f0HzoWdECJ47GkKTjS3gj36USgjoU3hKZB8Vwspee8fuBaXW72NbgBJDAuP60RslimbWqZ79Wu7LIwHI9PSH6yrWrQhcyfhjFIY9jXua43yfsbAZB81GMD+Ph5LLTxfUnL0OgEL9mmVrzZFqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJESDhGm0kMDoK9Xy/jvx131T4LChtQr+9ZaR2jDQJA=;
 b=ghghr4uejRHmcxBz0MXtJeH60BqmfT0eqNxMPRxx7XRkxVOmo3h2gMJyU4dsiGubT25+Uu636XB4eyfIEiFUZ+zU++qh5Lwmk5h3iVUsp16Ttayh53Q+LId2k2jK21x3NsuMyQz0YKPrkqIbFB0nZAndPgxVwa7Jl9dPEyGvuI3tqG0vZVF0e1gij4BKR8NF8RrTGZGSlwroHL+vo88t1Hzi59yFAw0E/PN9GpkYqh54C/SXJw4OKiqgGb+BNijpOFbvG1WYGn9TTGBwRle0OAOoSYKCJshTJkwLYrRCbsKGJ3FX+gO8ONhq1Rp2cyJnWAxlPlP8RoqCMt4xPAUvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJESDhGm0kMDoK9Xy/jvx131T4LChtQr+9ZaR2jDQJA=;
 b=Ntm/fWGYNZQYPtSG3NulffzKa9M21M6hfB+rrWOYvX+exoMjXmY8dwOv48c9vO84dZpynb2W9QRxFFWjErCp8osrMSeatIZNIzFB1wJK0wZ07IKAUtZfR1Xd3G1Exn9kQvkTkYYYiLSgRNN7Hzl2pvZBcLWxwv7qns76UMm4Oc8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 14:17:39 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 14:17:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] SUNRPC: More fixes for backlog congestion
Thread-Topic: [PATCH v2] SUNRPC: More fixes for backlog congestion
Thread-Index: AQHXUh6fW/1jodFH5kq6aV1RuDdf36r1z4UA
Date:   Wed, 26 May 2021 14:17:39 +0000
Message-ID: <DCFAF511-B2F0-458F-9F3F-CE870F40EE9D@oracle.com>
References: <20210526110221.338870-1-trondmy@kernel.org>
In-Reply-To: <20210526110221.338870-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a7f9a06-4b16-4efc-ab3a-08d9205104d5
x-ms-traffictypediagnostic: BY5PR10MB4194:
x-microsoft-antispam-prvs: <BY5PR10MB419447A0AF98DDD813A20D0893249@BY5PR10MB4194.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:213;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: piSzd3HZi8Z1kp26bBTPb2US0lpFs0dJTmuJR6dM4l+kcgdgjKSSwD8OMmL7FwjGlPZTi8iOBzTkX7uJBsIlAyTFf7mB6Fcihu8hYSPZK7ih5WetW66A47gpEOX8qtqPc91EwSc6aK3Cyp1XEiCWVTOJuK3ELAHoZ+vYrhD1noqjbtKYpXGqC2kti1n5A3xHSCS47mcIuhF6Aa9X1GBVBUcOghXJo0QvS5FdUbWDIupCZQhgCZZsBuNMEaay4yEOtUut5WZHKpYvnvo0jJOt6J5dk9muFC8oZB9O7D9Fpo1BHv88jQS8OrU3EV8bVd8kFWK5eT3vuszJxMpXBEjE+xZmwiiz2Y/PpeCglNhrJS9wj22LLl7bKG4B9KNWz9/kOdX3cZ+Asbs4UdgqJXZhcJEpv11xFS+C0ASXe+9CeYQ0e8uTObx3edeXXEtZvpZdcw4rdk87mrmuY9rBVuTUgKuc7z6BPtEnb6qV3VNqfPfyvt892NMD2OLkxQ4v/eSS4bgxixZwDqOQQCvCKX+v6gl4Ciu2igaV3T6DPOllf2sm8bhIv2D11Zec6xbmIrz8kqiorxQkN0z6S9hXrsZhCMwaOTIWWdHlFS/X2ESskoYjk9JEiB7r+tRMUtKaUplR9vL7n99/4eAWEcPz+CXcSNLE7Jkb85AbilXZZj0ULWQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(33656002)(478600001)(122000001)(2616005)(316002)(26005)(6512007)(36756003)(5660300002)(83380400001)(2906002)(38100700002)(64756008)(8936002)(86362001)(71200400001)(4326008)(6916009)(66476007)(76116006)(91956017)(6486002)(8676002)(66556008)(66946007)(66446008)(186003)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gZaY+Y/ybBB0znEDU9oRpyyCvpAbhnBDZ0QY4EU6wifi46iQCQwW/n0Ha+YE?=
 =?us-ascii?Q?mLnJCq2vXKskFQrtaIRB+KJslMxuMz8IAUJDz95ZmsqI+gnpTJdZyYnvgJ1M?=
 =?us-ascii?Q?CYHzagWAUsgjyOcrDl6IcxDBmwfW+PSJgF4LxyAdTP8t/swiG0XOKoRl047w?=
 =?us-ascii?Q?1NyLnHY6aeicMZF7EUCVCTpUB2DYgGNdQIHFVc5qf+0xgx9TFOtrvZowzmn7?=
 =?us-ascii?Q?dW102ZLvgBcFih6NEMULxNUQzUEx/FzMLsQXzC1NSJc9DWh8cQJxn8xaRMGJ?=
 =?us-ascii?Q?AbHFFvSGeu7yqJOKrsj8n2kiGMuPIHLuL/tIP3bgtksFxnvtgJh/ViHmNXg8?=
 =?us-ascii?Q?KUPMIHaczUahknbhAPtnZnMWkklkl7mM97NykQCWWObo8CYKOErEZElvwkRl?=
 =?us-ascii?Q?hC5bQ53BY6ggYY37gb8xlALG3Hnu/EPjUIP8UNygxtjLQUFJ0trD9SHiEeGt?=
 =?us-ascii?Q?INXLDskzDmXJsaTLE/bfPZ1kGeVwD5z+CON4PNlHn0lSfcd+5AQW7mpNbC9u?=
 =?us-ascii?Q?a6OoXua8mxXpMODTztB//+a68ciDihR1xOv3t3BLG+uax362gzOmTwmS7P4V?=
 =?us-ascii?Q?Tsnc43dyQBvYvftceYFLoIb6khN8IXvokflLSSZ9nF2Xp9GD5fRMMZin3F9F?=
 =?us-ascii?Q?BD8waEUDYQfP/0oUIzCuImrtlgvhnRsxc2PtIm1bJH8YloRPj8932Afkkqqj?=
 =?us-ascii?Q?U7OqxwbsgG3x1E3fYbAqWMBgPMEhoahJ5cnvNkXgB1wXtOlOuIKKJejziWD0?=
 =?us-ascii?Q?BNh0Mf6drppEa/ib583AVB4gsFiRaBAClEttr7Donfh7pBUtbg/A1yvdpXng?=
 =?us-ascii?Q?gGrRuUt06VL5X+jAljRvlhKuAHm7FQLOawCroeNkdiT+PXbwTgb5SBhII9Ax?=
 =?us-ascii?Q?HCJrnTvedVxFxDOkOuIcMZLKnO3F5EFJ++GTiEMMifhLUIFzbobFje77HTGR?=
 =?us-ascii?Q?ZalE3zm5Is7C2NqdzkhUvOSabVkY1ds7SxAcR6ztppldn0TKLoB3WtgH03bL?=
 =?us-ascii?Q?yQ2UzhkrMjyb1Yfyt+0kiMe9uY6Yw0koAzeJe/SBW+6AcFwY0APxezk4VVrI?=
 =?us-ascii?Q?pMP7z5beT8GZbHjbwMydhWVpdrJ0RcIxoqpaMlBvZHQ9KQRBo7yZS0AbRbdZ?=
 =?us-ascii?Q?jX4siuWIUD2+pIDqPc56A9c4/h/aFHkGtb6VDz3ZHbhYrOZVcJ5fo/xMuzFq?=
 =?us-ascii?Q?pDne1n4AwPvK+Rs/ng5tjK/HKFWuOTnw0fEgLqiYE+98xI3BQGbgeIRD2cBA?=
 =?us-ascii?Q?Fu7Qk1OnRM+B09X8JQfW/7XuecmkbOGcUfnAVbx8GG2l0fnW8uFCZZBRSPiw?=
 =?us-ascii?Q?e6oldglqIZuDU/nOdfaKHqj4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BCB4084B11A3E64BB5E32FC5919CBD84@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7f9a06-4b16-4efc-ab3a-08d9205104d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 14:17:39.3823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ooL1FstulJ8Xgwg4iUABBeidUr2sCvrur9+TMaEBYTkxVY6q/gr9rIfyUNW5pg1eeYYWXRLTYJQIr8m+oCzpHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260097
X-Proofpoint-GUID: VaDqoigI8I47ieF9UqdwTkZI6PIpVc31
X-Proofpoint-ORIG-GUID: VaDqoigI8I47ieF9UqdwTkZI6PIpVc31
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260097
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 26, 2021, at 7:02 AM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Ensure that we fix the XPRT_CONGESTED starvation issue for RDMA as well
> as socket based transports.
> Ensure we always initialise the request after waking up from the backlog
> list.

Out of interest, what prompted this commit? Code audit,
or misbehavior?


> Fixes: e877a88d1f06 ("SUNRPC in case of backlog, hand free slots directly=
 to waiting task")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> v2: Ensure we release the RDMA reply buffer
>=20
> include/linux/sunrpc/xprt.h     |  2 ++
> net/sunrpc/xprt.c               | 58 ++++++++++++++++-----------------
> net/sunrpc/xprtrdma/transport.c | 12 +++----
> net/sunrpc/xprtrdma/verbs.c     | 18 ++++++++--
> net/sunrpc/xprtrdma/xprt_rdma.h |  1 +
> 5 files changed, 52 insertions(+), 39 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index d81fe8b364d0..61b622e334ee 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -368,6 +368,8 @@ struct rpc_xprt *	xprt_alloc(struct net *net, size_t =
size,
> 				unsigned int num_prealloc,
> 				unsigned int max_req);
> void			xprt_free(struct rpc_xprt *);
> +void			xprt_add_backlog(struct rpc_xprt *xprt, struct rpc_task *task);
> +bool			xprt_wake_up_backlog(struct rpc_xprt *xprt, struct rpc_rqst *req)=
;
>=20
> static inline int
> xprt_enable_swap(struct rpc_xprt *xprt)
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 5b3981fd3783..3509a7f139b9 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -1607,11 +1607,18 @@ xprt_transmit(struct rpc_task *task)
> 	spin_unlock(&xprt->queue_lock);
> }
>=20
> -static void xprt_add_backlog(struct rpc_xprt *xprt, struct rpc_task *tas=
k)
> +static void xprt_complete_request_init(struct rpc_task *task)
> +{
> +	if (task->tk_rqstp)
> +		xprt_request_init(task);
> +}
> +
> +void xprt_add_backlog(struct rpc_xprt *xprt, struct rpc_task *task)
> {
> 	set_bit(XPRT_CONGESTED, &xprt->state);
> -	rpc_sleep_on(&xprt->backlog, task, NULL);
> +	rpc_sleep_on(&xprt->backlog, task, xprt_complete_request_init);
> }
> +EXPORT_SYMBOL_GPL(xprt_add_backlog);
>=20
> static bool __xprt_set_rq(struct rpc_task *task, void *data)
> {
> @@ -1619,14 +1626,13 @@ static bool __xprt_set_rq(struct rpc_task *task, =
void *data)
>=20
> 	if (task->tk_rqstp =3D=3D NULL) {
> 		memset(req, 0, sizeof(*req));	/* mark unused */
> -		task->tk_status =3D -EAGAIN;
> 		task->tk_rqstp =3D req;
> 		return true;
> 	}
> 	return false;
> }
>=20
> -static bool xprt_wake_up_backlog(struct rpc_xprt *xprt, struct rpc_rqst =
*req)
> +bool xprt_wake_up_backlog(struct rpc_xprt *xprt, struct rpc_rqst *req)
> {
> 	if (rpc_wake_up_first(&xprt->backlog, __xprt_set_rq, req) =3D=3D NULL) {
> 		clear_bit(XPRT_CONGESTED, &xprt->state);
> @@ -1634,6 +1640,7 @@ static bool xprt_wake_up_backlog(struct rpc_xprt *x=
prt, struct rpc_rqst *req)
> 	}
> 	return true;
> }
> +EXPORT_SYMBOL_GPL(xprt_wake_up_backlog);
>=20
> static bool xprt_throttle_congested(struct rpc_xprt *xprt, struct rpc_tas=
k *task)
> {
> @@ -1643,7 +1650,7 @@ static bool xprt_throttle_congested(struct rpc_xprt=
 *xprt, struct rpc_task *task
> 		goto out;
> 	spin_lock(&xprt->reserve_lock);
> 	if (test_bit(XPRT_CONGESTED, &xprt->state)) {
> -		rpc_sleep_on(&xprt->backlog, task, NULL);
> +		xprt_add_backlog(xprt, task);
> 		ret =3D true;
> 	}
> 	spin_unlock(&xprt->reserve_lock);
> @@ -1812,10 +1819,6 @@ xprt_request_init(struct rpc_task *task)
> 	struct rpc_xprt *xprt =3D task->tk_xprt;
> 	struct rpc_rqst	*req =3D task->tk_rqstp;
>=20
> -	if (req->rq_task)
> -		/* Already initialized */
> -		return;
> -
> 	req->rq_task	=3D task;
> 	req->rq_xprt    =3D xprt;
> 	req->rq_buffer  =3D NULL;
> @@ -1876,10 +1879,8 @@ void xprt_retry_reserve(struct rpc_task *task)
> 	struct rpc_xprt *xprt =3D task->tk_xprt;
>=20
> 	task->tk_status =3D 0;
> -	if (task->tk_rqstp !=3D NULL) {
> -		xprt_request_init(task);
> +	if (task->tk_rqstp !=3D NULL)
> 		return;
> -	}
>=20
> 	task->tk_status =3D -EAGAIN;
> 	xprt_do_reserve(xprt, task);
> @@ -1904,24 +1905,21 @@ void xprt_release(struct rpc_task *task)
> 	}
>=20
> 	xprt =3D req->rq_xprt;
> -	if (xprt) {
> -		xprt_request_dequeue_xprt(task);
> -		spin_lock(&xprt->transport_lock);
> -		xprt->ops->release_xprt(xprt, task);
> -		if (xprt->ops->release_request)
> -			xprt->ops->release_request(task);
> -		xprt_schedule_autodisconnect(xprt);
> -		spin_unlock(&xprt->transport_lock);
> -		if (req->rq_buffer)
> -			xprt->ops->buf_free(task);
> -		xdr_free_bvec(&req->rq_rcv_buf);
> -		xdr_free_bvec(&req->rq_snd_buf);
> -		if (req->rq_cred !=3D NULL)
> -			put_rpccred(req->rq_cred);
> -		if (req->rq_release_snd_buf)
> -			req->rq_release_snd_buf(req);
> -	} else
> -		xprt =3D task->tk_xprt;
> +	xprt_request_dequeue_xprt(task);
> +	spin_lock(&xprt->transport_lock);
> +	xprt->ops->release_xprt(xprt, task);
> +	if (xprt->ops->release_request)
> +		xprt->ops->release_request(task);
> +	xprt_schedule_autodisconnect(xprt);
> +	spin_unlock(&xprt->transport_lock);
> +	if (req->rq_buffer)
> +		xprt->ops->buf_free(task);
> +	xdr_free_bvec(&req->rq_rcv_buf);
> +	xdr_free_bvec(&req->rq_snd_buf);
> +	if (req->rq_cred !=3D NULL)
> +		put_rpccred(req->rq_cred);
> +	if (req->rq_release_snd_buf)
> +		req->rq_release_snd_buf(req);
>=20
> 	task->tk_rqstp =3D NULL;
> 	if (likely(!bc_prealloc(req)))
> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transp=
ort.c
> index 09953597d055..19a49d26b1e4 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -520,9 +520,8 @@ xprt_rdma_alloc_slot(struct rpc_xprt *xprt, struct rp=
c_task *task)
> 	return;
>=20
> out_sleep:
> -	set_bit(XPRT_CONGESTED, &xprt->state);
> -	rpc_sleep_on(&xprt->backlog, task, NULL);
> 	task->tk_status =3D -EAGAIN;
> +	xprt_add_backlog(xprt, task);
> }
>=20
> /**
> @@ -537,10 +536,11 @@ xprt_rdma_free_slot(struct rpc_xprt *xprt, struct r=
pc_rqst *rqst)
> 	struct rpcrdma_xprt *r_xprt =3D
> 		container_of(xprt, struct rpcrdma_xprt, rx_xprt);
>=20
> -	memset(rqst, 0, sizeof(*rqst));
> -	rpcrdma_buffer_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
> -	if (unlikely(!rpc_wake_up_next(&xprt->backlog)))
> -		clear_bit(XPRT_CONGESTED, &xprt->state);
> +	rpcrdma_reply_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
> +	if (!xprt_wake_up_backlog(xprt, rqst)) {
> +		memset(rqst, 0, sizeof(*rqst));
> +		rpcrdma_buffer_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
> +	}
> }
>=20
> static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 1e965a380896..649c23518ec0 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -1200,6 +1200,20 @@ rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt)
> 	return mr;
> }
>=20
> +/**
> + * rpcrdma_reply_put - Put reply buffers back into pool
> + * @buffers: buffer pool
> + * @req: object to return
> + *
> + */
> +void rpcrdma_reply_put(struct rpcrdma_buffer *buffers, struct rpcrdma_re=
q *req)
> +{
> +	if (req->rl_reply) {
> +		rpcrdma_rep_put(buffers, req->rl_reply);
> +		req->rl_reply =3D NULL;
> +	}
> +}
> +
> /**
>  * rpcrdma_buffer_get - Get a request buffer
>  * @buffers: Buffer pool from which to obtain a buffer
> @@ -1228,9 +1242,7 @@ rpcrdma_buffer_get(struct rpcrdma_buffer *buffers)
>  */
> void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers, struct rpcrdma_re=
q *req)
> {
> -	if (req->rl_reply)
> -		rpcrdma_rep_put(buffers, req->rl_reply);
> -	req->rl_reply =3D NULL;
> +	rpcrdma_reply_put(buffers, req);
>=20
> 	spin_lock(&buffers->rb_lock);
> 	list_add(&req->rl_list, &buffers->rb_send_bufs);
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_r=
dma.h
> index 436ad7312614..5d231d94e944 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -479,6 +479,7 @@ struct rpcrdma_req *rpcrdma_buffer_get(struct rpcrdma=
_buffer *);
> void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers,
> 			struct rpcrdma_req *req);
> void rpcrdma_rep_put(struct rpcrdma_buffer *buf, struct rpcrdma_rep *rep)=
;
> +void rpcrdma_reply_put(struct rpcrdma_buffer *buffers, struct rpcrdma_re=
q *req);
>=20
> bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size,
> 			    gfp_t flags);
> --=20
> 2.31.1
>=20

--
Chuck Lever



