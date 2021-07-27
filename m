Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED8F3D7A4A
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jul 2021 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhG0P5Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Jul 2021 11:57:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55620 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhG0P5X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Jul 2021 11:57:23 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RFvHW7010821;
        Tue, 27 Jul 2021 15:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ahrYyUdkE4e74orQ49n2zSg4/kkg6YDBmFR5p6mYY5I=;
 b=U6IISZ9WouuG5E+5Fefy2gKZ+GHIkVx4K+l8BJf+GxF+7D/KUw8OYARifb5hxptZ6jpE
 meX3I6oVzksRaRcc80ze1B6O8qNDVjLRv0hs9wtHVRto5iygqXBnfij8twt7oG5Lm+oH
 PorpQBGAkdWPG+pwjNliNGB3488m+qhA5iJs//M/BQnX2XkTokDM5OvG39iYk2l0iCUx
 hW0beL/+Fbzn1Ivhqv2nSweBcsqteK3mbujTK2ysKWBj0DDlLrqPi5LCjxZ3XjPxAJsb
 uTebI9XohQRBTXV0+ELP5h1rFE4aNWHMFGG9YUQ1JDXDazsbatmcVj0Kz1zPiW8YvmBk BA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ahrYyUdkE4e74orQ49n2zSg4/kkg6YDBmFR5p6mYY5I=;
 b=Vx6tCo4yYGil4/hleXYEQV2RPuHbXBKhFmXaXL6vTXppUjWIppy0mIVvfjmBbBfE0swn
 A8lFMddz9mR3UcIkKSfdGHuFm1JJ7O1t5RmmNAgot/kwgKca48THqNKaZ3K5SlAOjWuT
 0/+WqNmsGjUJmeBIPJfnXUz2o3brY1DSO427+4tMCpjji/8WhovmttDoCwUaIv2wZW6F
 l3FIuSqrgOfLatNYAvfg/sRg5hhy3hEMzpKRjPZAilIGVhEFS9IZdlkik5z0m448i+QX
 Nl4xi5fwGw/hTg/To09GCdwWjwl7ONctHRVj7aMqEbReCl3sEVyusAPLgmGal9nsMYQr Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234w28vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 15:57:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16RFulqD079094;
        Tue, 27 Jul 2021 15:57:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 3a234vrfwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 15:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be97R97btagQ0JVXq5wdIKMzfDvC4TrcWVVJBy42eSyqD1yt5ySENn5su6I3qBVON8xYhaWgUMGf9eNssjF6dwQLLeLbhdHOEXRMpfYQZycaOEUWYyLfaEdBm1fXQPtCJphXjSnR3RAVTP5KcVMYhk/SSl/R0DewT/f/QTtg1rrO61HQ1oCJ2xXkwDlM7QoO9FZAICohV0wPvNyWyRhzEDcIgtWxITGbt21qfl1BAyKd1oQyyH4rCqKk1qB2udGp37Hj5i0yHCt9m7Mx8x2h30NVRcGqhN4HSqfEuNORW/TdXwqUYSNUzhtoFbliTY3PbOflGzmXOQzOAYOWfX0p+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahrYyUdkE4e74orQ49n2zSg4/kkg6YDBmFR5p6mYY5I=;
 b=WAVTXicQLiQZKKwi3xTMDXM62d7YD7EXGtSfrlFPvjOzXH8VV8CuFoee2Qhg/7VvEjAH1VKGmNn9a3orlb54u0k3MNfpPtxEDj17gQCNbCZYt8NrWOhhkRbHPzsZHPANLIbSPyZRYrNoGNPX2b51sojCCoU1d4qSoIF0J2d6ZSGs3GGnhoN82EQzrry0MWpC8nKIezVkGYhipEoEJ7Z+kaIO8+WivHchw+G3uMuCD2ozxu6fOom9Qq8wlvWuKXjqeUCnlRkOAVmswgw8W3YWRpfvETeDcLV4gHZaiBOFjP2TtY7qVWd1QsmwgO3ySAmhIhhXsHKCUxaeKxpZsMU2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahrYyUdkE4e74orQ49n2zSg4/kkg6YDBmFR5p6mYY5I=;
 b=crcidGWSe8DEiqlTuK63Ts5UnKROpEMji4J3Qp6a8/Jap4A6gDMQBEzjrXcqmbuL+n0FbACdzox/sRthJJzoW2WpUKmyv9Hn5FKmYQ4ed0I6Ixod5GbqBCTLJu3otf4cxYU8Nid3Z6VfQgEHY6IlZOy3LndxuTBLHnJo7MbFRp0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4162.namprd10.prod.outlook.com (2603:10b6:a03:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 15:57:19 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 15:57:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC/xprtrdma: Fix reconnection locking
Thread-Topic: [PATCH] SUNRPC/xprtrdma: Fix reconnection locking
Thread-Index: AQHXghY54y0I0AjDkU2IFWZmCYAtk6tW+/oA
Date:   Tue, 27 Jul 2021 15:57:18 +0000
Message-ID: <7DF7706B-CFA1-4AF1-8329-B60ED92B6C6C@oracle.com>
References: <20210726120312.8856-1-trondmy@kernel.org>
In-Reply-To: <20210726120312.8856-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e32e5200-96df-46dd-f553-08d951173698
x-ms-traffictypediagnostic: BY5PR10MB4162:
x-microsoft-antispam-prvs: <BY5PR10MB41623232F164FF9178F92E8293E99@BY5PR10MB4162.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nNG8U1rCpLbfKYEtO99N5TRfuHiFRHzoLPMU63Ogm57W+BeNX80/kf9IDX5grdDwdpCqCkSKFkO4Vo6ezpB59AKpzNUENF6HO+bGZjOeoIt/gXQnrW8Eezn7+cQcKdrtG2SyFSQB2qGfSEAUdGAimg3f97ZkWXrKXxyvnUGOMWwRExJpSqfPInSmzALjD/92R0/0w6lqSYsKut0c6E1LAGVNqj6mBsIqAX2MlqHb3h+kt9tNxxqbuUt1sVJD+b9+kGrWZioIO53oPummrsClsSWS8ucs3N/entn0KqCXeBfSq2rF7DHZVGX3F46dNoclpRZ4iJJNnOqNtwJsr6vMyCcqamVGf4/qAKhqrG8HMwv/YQSPnnG3WBCYjW2AJAS7G2RYgsFm86sj/NTZMVTAgIfM/cvjlEmWdD00Al5Cjd10AOVHcbmGXSLGF3ktMDzoB1dieXBcT+zeTkaNmUiLdwYS9fb9dyBrNTavRRM+5HakoeaynZoQISexs9hJZQVAVAj/tqjS45JBofRtwNLOWK4ojlv1izUp/44CMTotgwUw+WqLoIKG/mNNwV3mxr3ldxQclq6kX+b7M7H3ixbuyrP7AR8AyBHk47w3VgXaDJe2/XDYlyJnvhg49suY9gnbDwSqRWgZfXBBgM3vTc3Pe1KATef66mQ5ZqQjmpBbHH8Gaz80KsYTMeEQh52xnQozmA/aqjVuQ2F7UTpVrt2NhexFvZKpI773r4AXKVjRqYnJjoRk3CyM4ZkpLX+WqGb2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(376002)(366004)(5660300002)(53546011)(6506007)(6916009)(36756003)(83380400001)(2616005)(64756008)(66446008)(4326008)(76116006)(86362001)(8676002)(33656002)(66556008)(66946007)(316002)(38100700002)(66476007)(91956017)(2906002)(6486002)(122000001)(478600001)(26005)(186003)(6512007)(71200400001)(8936002)(38070700004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fcc0J3nr8iK5C+lGckCRVAIaRHsmlvZU5OPN9PlKJAmkUgg5x7f6IoykHLIe?=
 =?us-ascii?Q?iQwYZWwlpnoA04W5XgDO/SIbdMpCanmq6qoTKQshpOkEFYOnBAS817cL1BHE?=
 =?us-ascii?Q?pvD04gRGCawNduFj+CXXu+Rf/gRkiuVfopbWodtDdaQDLKcf02pt8itVXq3j?=
 =?us-ascii?Q?a4Aqa8pzQykNxU84SiIUfgaE9VJTZx1+HemEIlbq250GQRNNM1ZjkgiXE/6B?=
 =?us-ascii?Q?3fEWWhKZYfktnTaFEkmAiuBQLtNXYBRNypKv3c97efPshg9DxPyzdpDUVoDU?=
 =?us-ascii?Q?5YEH+sJSQVJfoovOkiX+IkaCvdJHbV+b88W2y3P2eHOqhUoPvz+LBBOXI+Ud?=
 =?us-ascii?Q?k9/K+TgcDbE+1s9A6MCsrF01E7yVUyelIZpr8WDHlooDkrKcDsCKuicn8E/9?=
 =?us-ascii?Q?ExkYaIxrg+H9AvpnIeSN0e0Hk83Tk20F/skggfKQmERbiGY2jB8r6xtrFLMZ?=
 =?us-ascii?Q?frQZhmzfJKeHZrpzufOR8pErR0jvcr3RTeqjtqvalYZDZjw4MKSDuhjgRZXB?=
 =?us-ascii?Q?2Nk3aupV7Ojn3WiNUx2pdOSCJ7Zl6eVt/g570vRjWljmTxSAu/UguJIrb4lN?=
 =?us-ascii?Q?5qlVi5BuSELzpWbMXd13Fcw+K0KhmzCGj0M3BGCmd8GjcW0E3DzV7KgsMt4z?=
 =?us-ascii?Q?Z/Q/cUdimni1AZFtdI167CT82INYQCgkHVHkNRDq3/b4af/38UTDe8/LsebV?=
 =?us-ascii?Q?3xLzb0D4dGwd+aCVQC/XHPurfw8RF2Jk7+96zNPqBgztM/shpongQaR1uuaV?=
 =?us-ascii?Q?djdI7JTzmMSDw77VreIITwZuPNKnVRhrueUN6cnE7s1l2DsoS1/jaNcC+NW+?=
 =?us-ascii?Q?7MkVpwHzcuaALnAPiYEEFbpeILuFBANOIJ3Uxcn2H/MzR5UOIh2iPhXZ4sqg?=
 =?us-ascii?Q?a39KGGe3DyUV5fyDZLYirt+2D4wa+8jCguEVW8x+ArVx5+1LHCh6nxqgxY28?=
 =?us-ascii?Q?/Vcbg7tWnMxxSNRZ8eC5lc+q4atAXbcLM5Gg1djLJCT1FrjoFcxCOboPi61D?=
 =?us-ascii?Q?M3/DmhS1qsTcNPgbFRoI4e1gi/D3jygUpxJeLoXVnPU9uiWiYv6HEZa3Ms0O?=
 =?us-ascii?Q?E2VDpYe8rzFzobESszGEpzSgDGYReP+DBbtHFKDDjcwm4XWQPqqPb0Kv/RXW?=
 =?us-ascii?Q?N86o49OlopuP9cCDhDCTfcjUsc039x0CAMzVAXE7p9KatNe5sgX7l/f3WMyq?=
 =?us-ascii?Q?Wvpu1lVksd2UW3+LcPtLrEdvOlQYVSY97LsAw/P8gfayhMKhM3Ow+7Hdp1ug?=
 =?us-ascii?Q?cgyaiJUsne/zOxV5VSlanPEtCEMW7idcePrtlEQO4DfRggSz/TBlq1Ex22NN?=
 =?us-ascii?Q?5pqefaiu2nU8nafcpE/FOAoGtqyuO5sloCoaeUT65xQa0w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21F267B795E1274B8030FFA98A12AFD5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32e5200-96df-46dd-f553-08d951173698
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 15:57:18.9995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juS3u94F6wI5W39qdynXk6JN3otixCO5duVVIn1pmDSqa3b9Psj0rHqK1XfKfgFEyUX4NZruQUeysYA0lERvqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4162
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270096
X-Proofpoint-ORIG-GUID: TIDhuLx1xWaRv2DtsxXVJQfxX91CdrFx
X-Proofpoint-GUID: TIDhuLx1xWaRv2DtsxXVJQfxX91CdrFx
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

First, thanks for the clean up. I had been wondering about that,
but I haven't encountered any problems so far with the code as
it was.

Second, after applying this patch and enabling KASAN, I ran
several disconnect injection passes with an intensive software
development workload. About 500 disconnects were injected over
the test runs. I did not encounter any issues.

I inspected a trace capture of a couple injected disconnects
and did not see anything unexpected.

I don't have a server-side disconnect injection rig. I probably
should build one.

Tested-by: Chuck Lever <chuck.lever@oracle.com>

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



