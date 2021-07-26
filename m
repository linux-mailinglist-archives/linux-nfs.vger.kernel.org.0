Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D107D3D5B77
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 16:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhGZNgw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 09:36:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8670 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233792AbhGZNgw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 09:36:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QEBPU5031429;
        Mon, 26 Jul 2021 14:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kN/uc4ACeVsWHpf6txDTWoK/iq0xGxkr40OfLt6WC3s=;
 b=S81tPLU3LMNNlfEhZvUwXIZ+i0yUepwlBF5EreVg0bTxVEuS5o0pTx9G0Q/nUns5HewN
 qFOoEc66ItdBWUs9MIs/kYXtAv50SqJoEwXrZn9rGotIn0018V9Uu2scoaDZjLZi5cLc
 hGpMqeSD1Oh7ijPdu8KcJpbfL9/gkX7L8iwrOsyByzVGhYTCA6i0FY3xWq9bxOGgyvNT
 Pv1nGv5WkwQT1J3ZQyUYXWGJDPHTWK6LnS/CoAWDI28I/BHKVVDhQjgT3RxSM1KNJdYl
 7ddyBZPNRzWNamI1SnW94vVEhsDlSKaa4j1xpvRBMliqevbVEeAUIRG5rAB9i/7vq71g DQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kN/uc4ACeVsWHpf6txDTWoK/iq0xGxkr40OfLt6WC3s=;
 b=NVF6rh3iCkcbvULSXaGHXSh/HTW4PnmGtd0F2S4I6HXkj/kR/vR/MmYUvjIkqsmI710j
 A4+0JhYontyVu4fvisPD+Wtlih21EfZavN9f0IRmXgwJ7eWFZiEVNmohCKzItRjTS9pa
 pUeMgx0qLAG53kz6Zs9y3J3LxARoSleHqoiNz28I7O/IXoQ6BzSEuNDymzlbanaOK1d+
 GkicXt1fMKgh3CFPAfnrnV/MXEUCiL/a3r2r8A1Y/zy7pjDrdRlTG7j4ueV7fstPjcCN
 a870tmmYTKltPaZfjvq+1TYZyt/GHrJJ0Yp7ZhFZPX7QCupWpniVzYE2n0ZZg3NsqooT yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1vmc0c3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 14:17:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QEApxs173721;
        Mon, 26 Jul 2021 14:17:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 3a07yvjpe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 14:17:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1rlvDHw2cYnRU9vtaUWRvlv0GwZ+Xr6RkmyVA0j6+tBDjxLU8GxpjKxydPH13wroO9c5sMXIrZNS+pGXYPw0CVqEoL+Pf8Wgy2xU2Ll5Prvp5D9qF+YMjMOOkDVW/YkwYMhXMhgtu7kvA3ftHJHe29fQVZR2bibUYayND0SPRGIUT438W5unuQd8ycOn0/lkZ74Kjh+ZOQb1lT0PYApi6mdzIai77jw9HBE9NT4MmbznxEkrkMQ9HUxlN/5INlZrd2Pb/8oHrmbV10qkmdIu3rnjfAk9da6pczsiarglUjpXAiK2sBIzde8pqj6nN049/MdGqlSjCqfk4UnRvvw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN/uc4ACeVsWHpf6txDTWoK/iq0xGxkr40OfLt6WC3s=;
 b=Eg4APHgY4W5cdMjhggH4iaRh0CjInsrfxdr5TVJfRk59gQBNdx1N3XAbI7XVnBRh38E9lkhj6gm8q/YQpWe86eo/nLe14XN1GmiC2gE+9Ze1P7Dr8ng5GLAE9zem7ooVOs8pnIeqDw0etLCjESt65j5DyD6T+ENRaeniWlGdoUGNFhK+OL0te0oWnLek78g6VXMGjFYLma4Lt5TCBTrRcEDcCrBWp9ZBW941Les6JenfjHEAvfOP8xnHyHdiHZVG6Lk0+UvG09lZ9eJq9LpgvcZHLQNLZwMXTNEz78B5tHh4FvAfFP/q7L1ozujMmYF+NBZiRM/lrJMXXMfX4zBavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN/uc4ACeVsWHpf6txDTWoK/iq0xGxkr40OfLt6WC3s=;
 b=Cwkj2chYBp3WISYlWLFPP7z5Rn3L09+CA0C+5qrlHmaC7NJqpyfVWl2JFjygq0SvVK9mBgGnAKfKWpz/07Xy4UMxFVnvYIe/6aOWidk8U0Uy1bX6qhwcZ8dybN9bpRLMpScxE0TzwJHlpS0lqCfkXErhDTNKRTjJ1cYLmZahpEY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3221.namprd10.prod.outlook.com (2603:10b6:a03:14f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 14:17:14 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 14:17:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC/xprtrdma: Fix reconnection locking
Thread-Topic: [PATCH] SUNRPC/xprtrdma: Fix reconnection locking
Thread-Index: AQHXghY54y0I0AjDkU2IFWZmCYAtk6tVTa+A
Date:   Mon, 26 Jul 2021 14:17:14 +0000
Message-ID: <412EF4F6-6CD6-4188-B3BD-F8BD5CDCF859@oracle.com>
References: <20210726120312.8856-1-trondmy@kernel.org>
In-Reply-To: <20210726120312.8856-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af842fe6-26d5-4146-2004-08d9504010ec
x-ms-traffictypediagnostic: BYAPR10MB3221:
x-microsoft-antispam-prvs: <BYAPR10MB322199D67A46C0634424A66893E89@BYAPR10MB3221.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCzH9vwp8POXengIi6AHuCRNeXc+Q40nf262IkF363j68cUczi7LWRVvJydf2j3o6Ry56vCGiXAWr0UBtwx9oapGzaEl0XlY9tkTs0+zo+jG5ijdNKyO5/nCJCg+VAOjUYNUfKOFvfztL9QvmN6WDAoGQ1tgn3MMotKyYFiqvicMIFi6nVnsyBPBfqh5FKwNNSTdTIMmnCPa3UFKbxo7dkE2IhBZnX+4+9mo+B6ZxtY960JdK4c/JxD8qOuURrUsQuU6HFzMhJPQD16TlaSf9drt25ZOPdRK6YalTbchMeRogsa4j05lPtN5zsmf+d1iZ7PQgbS3rD7AVtWnRXkU3iP2ckphyElssAHWWQ6tl0lfPYdD6pvZ9TTn5geMAUz6TcPUs8BpbKy/BQ3g2K6okTD6oRmLSAv9q9OL57WspZZJHOgr4TkEQJ1Q2gUb6swsK8fK5E2/DPqS2UFDFGumv250nF0MsKfEAlyoqZxJG5uZWXGv/jK3h9poxhVly8xOiqYlP8GFapZIOyrwpOygQ3JuGBklYGL6FDB1O8qflEQcXy+FK2agzZU70393UZXzFKz2P5gpc2Q1Ar0kqRsewGnkrsOQm8NcJKz7V8gfMoA0qPVwez2IzCBk15fmyisZhk0bohWa5R9kSm6wfmSkWHZ94Qp3KikSwGc5RaQsj6IqZMbU7Lv/ddjPTz/URh475tRYlpKUBG5raLo9uDuygL9sfxYF+IUZaqQ0BXe8301IxhWPitGdwO0vQ+6p+OTF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(366004)(346002)(4326008)(8936002)(316002)(6916009)(6486002)(86362001)(26005)(186003)(53546011)(6506007)(33656002)(122000001)(38100700002)(91956017)(2616005)(5660300002)(83380400001)(2906002)(71200400001)(64756008)(66556008)(66476007)(66946007)(36756003)(66446008)(6512007)(478600001)(8676002)(76116006)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ITrAFImudGc1y3ATegeLcwIrAYXkAEU7viSgXEkBxKPZb60W0PzQKXxCsCNB?=
 =?us-ascii?Q?VVMU2taEpgYG0thvxP9cTqi0FyAFrsMRyn81wskqhmf533OFkvjDTd76I1qO?=
 =?us-ascii?Q?53g1obd6PiMk3E9UVwvtlPqD3cbqzy//C9j2WJmItgs38/ket1iJa1S/QD2R?=
 =?us-ascii?Q?B9zOiRl5HzEuigjR6Pl5ZmaF1SHtRP1LW5x8lpjyLIs+/S92AK82WpXYmPlu?=
 =?us-ascii?Q?m6kve4B5jWkk9e8HHISDmJSnYq46wBm+beIFUvnru3Ee8oNaz2I9H4ehH/2D?=
 =?us-ascii?Q?vFt5MgjJB+I1JSL15rAuQm6E6p9cfW/WBtKF1/BzPB+7yQOruCboWuAe7bZi?=
 =?us-ascii?Q?MS+DUaq2gFCrnaGiyuywrR4kktxOmlhrgVsUir76csDgUAWDQM8D2KvOm/wb?=
 =?us-ascii?Q?PsEYb0OOLhWAKRFpuyjefB12AuNl8rHuP5mjFvg6B8hTHs+kdiJbaXSzsids?=
 =?us-ascii?Q?tfNfsoQOV2/rNVYRUzhY1mPx0/zcu96OJnwTnXRIpz3pQz6mPcdLRcRLwuNs?=
 =?us-ascii?Q?u3x+wQiI/yUNJ+AkcNgKnBrLHFeQaOl3NrpiKkQhbcf08kp3R/2kia+e4+/W?=
 =?us-ascii?Q?VJ+yXx8NLxEa1J2aBCUZqS2c38DASqdq1lWCvo62Nivt0NzKcoKYy6W+tAD6?=
 =?us-ascii?Q?d+hwGWX8GRI+j+DG+VBa1hos5A5vcuNyT/JqBxWuKeY13y5B01rTnyrfriDe?=
 =?us-ascii?Q?KiOYCz2WszHUSzzBo/jbdy6urYbwIjNwRMTd/WNLrvoziK4KZw6n1RNbk0ob?=
 =?us-ascii?Q?bMcJR+XPjuQp117pzOfI9cowf0Lmi0S4P1leCeXh9OTfB2TKZtMH3ZrO5S+r?=
 =?us-ascii?Q?716q295VuGpy9Kco/JFGk5k65CF4zxhlR/WAdjYgiG8/+gMEIGAzYzMPHm6x?=
 =?us-ascii?Q?3OrG2CwVHsRJUtl5cr3ixMCGVzEyU59dtldAvZwyc9GiS6MfrxwlpRds0WHJ?=
 =?us-ascii?Q?5P2JpnR2hYq1PejDLK8i7lfdY+8et9tOq1mQiai0AVi8AuxTqj9SOVPPinp/?=
 =?us-ascii?Q?mHvKu/qt0oUHdrBa+qBjQZbyXvik19ZqNYCD7Ywu0uE1r6riIWl7617q8u8+?=
 =?us-ascii?Q?INxhsi/DbhwT87nUCskvVu0UOjUxTzAraFSyXvWs2VfmgI/V+wguIU8cOQXl?=
 =?us-ascii?Q?jOF2f378SLGPRl+eKPE5QQ4oDsiAM78iMeMdXuBimuEDGyWAPtpNTF/mpW8u?=
 =?us-ascii?Q?RJZrELyxnSj/OgHE4FE7fMVwonjMxuKVVnjBG/oDfmvjVQG1Ockk5fe6iCYv?=
 =?us-ascii?Q?o3i550csN7yK8fw0zHeBZpvknw2rQujzLGi0QT5/vy/HvVcwRKsoRN1MsSWF?=
 =?us-ascii?Q?Xwa5F0phnAd6AketyHM5fTr/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB06256EC6F3A14CB05B6505010F26A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af842fe6-26d5-4146-2004-08d9504010ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 14:17:14.1057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3wPOTkOsqiOZG/CQGN110WA4odf3xNQpix0jeY0I5ZLis+5Jla98PIvFbr7GLSVgGYBTo7+SeJFBApHuXarig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3221
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10056 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260081
X-Proofpoint-GUID: eV5yE_cXv2j78OpeqrMSLJXekJy4u7gu
X-Proofpoint-ORIG-GUID: eV5yE_cXv2j78OpeqrMSLJXekJy4u7gu
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 26, 2021, at 8:03 AM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> The xprtrdma client code currently relies on the task that initiated the
> connect to hold the XPRT_LOCK for the duration of the connection
> attempt. If the task is woken early, due to some other event, then that
> lock could get released early.
> Avoid races by using the same mechanism that the socket code uses of
> transferring lock ownership to the RDMA connect worker itself. That
> frees us to call rpcrdma_xprt_disconnect() directly since we're now
> guaranteed exclusion w.r.t. other callers.
>=20
> Fixes: 4cf44be6f1e8 ("xprtrdma: Fix recursion into rpcrdma_xprt_disconnec=
t()")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

I would like to test this change with disconnect injection
before it is merged.


> ---
> net/sunrpc/xprt.c               |  2 ++
> net/sunrpc/xprtrdma/transport.c | 11 +++++------
> 2 files changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index aae5a328b15b..b88ac8132054 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -877,6 +877,7 @@ bool xprt_lock_connect(struct rpc_xprt *xprt,
> 	spin_unlock(&xprt->transport_lock);
> 	return ret;
> }
> +EXPORT_SYMBOL_GPL(xprt_lock_connect);
>=20
> void xprt_unlock_connect(struct rpc_xprt *xprt, void *cookie)
> {
> @@ -893,6 +894,7 @@ void xprt_unlock_connect(struct rpc_xprt *xprt, void =
*cookie)
> 	spin_unlock(&xprt->transport_lock);
> 	wake_up_bit(&xprt->state, XPRT_LOCKED);
> }
> +EXPORT_SYMBOL_GPL(xprt_unlock_connect);
>=20
> /**
>  * xprt_connect - schedule a transport connect operation
> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transp=
ort.c
> index 9c2ffc67c0fd..975aef16ad34 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -250,12 +250,9 @@ xprt_rdma_connect_worker(struct work_struct *work)
> 					   xprt->stat.connect_start;
> 		xprt_set_connected(xprt);
> 		rc =3D -EAGAIN;
> -	} else {
> -		/* Force a call to xprt_rdma_close to clean up */
> -		spin_lock(&xprt->transport_lock);
> -		set_bit(XPRT_CLOSE_WAIT, &xprt->state);
> -		spin_unlock(&xprt->transport_lock);
> -	}
> +	} else
> +		rpcrdma_xprt_disconnect(r_xprt);
> +	xprt_unlock_connect(xprt, r_xprt);
> 	xprt_wake_pending_tasks(xprt, rc);
> }
>=20
> @@ -489,6 +486,8 @@ xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_t=
ask *task)
> 	struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
> 	unsigned long delay;
>=20
> +	WARN_ON_ONCE(!xprt_lock_connect(xprt, task, r_xprt));
> +
> 	delay =3D 0;
> 	if (ep && ep->re_connect_status !=3D 0) {
> 		delay =3D xprt_reconnect_delay(xprt);
> --=20
> 2.31.1
>=20

--
Chuck Lever



