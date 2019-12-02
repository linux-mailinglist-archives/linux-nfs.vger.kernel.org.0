Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB110ED58
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2019 17:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfLBQlD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Dec 2019 11:41:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56080 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBQlC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Dec 2019 11:41:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2GdNoZ187935;
        Mon, 2 Dec 2019 16:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=D5yZrNJ2lm91CuKzidzYnf/nIzH0R2h1tAZaPjporno=;
 b=dZswlBlb04YTVfZjcjTLslw9RvOdPRaNTyf0RQGtI1S7IWqf1awDqAiIGvr0zJRsm5xT
 XyiWB77VHcx1Clv9Ttn6z08fwltMpDa3Jc1KMNKIxpvP7SK4BK+kszWIoP0ASMUQMF6q
 gRxMLNqvXKoJ7hwYrcRffvZjwdzuXUe1GRBDo0ayZlJwE5NjQjoFdcizvoz0pNnDwY0m
 oXk+RPXerMVeRUYy53+4gZplwcbLxKx71G2gIGWPQRGIGdIyZL0jBbftCk/kTcZ+Nr9i
 aYYMoitzHNXcJ94SZiMJ69wqu2CuGEZLn8MGaNB75V1KsJt0pFNX5NWd0as0OKfPsyVB aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wkgcq18yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 16:41:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2GdfF6022184;
        Mon, 2 Dec 2019 16:40:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wm1xny214-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 16:40:59 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB2GewEZ008591;
        Mon, 2 Dec 2019 16:40:58 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 08:40:58 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] xprtrdma: Fix completion wait during device removal
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191202162844.4115.30993.stgit@manet.1015granger.net>
Date:   Mon, 2 Dec 2019 11:40:56 -0500
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <151A3628-C7E2-4307-ACB6-6EC2C3593105@oracle.com>
References: <20191202162242.4115.94732.stgit@manet.1015granger.net>
 <20191202162844.4115.30993.stgit@manet.1015granger.net>
To:     Anna Schumaker <anna.schumaker@netapp.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020143
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 2, 2019, at 11:28 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> I've found that on occasion, "rmmod <dev>" will hang while if an NFS
> is under load.

ETOOMUCHTURKEY. How about:

I've found that on occasion, "rmmod <dev>" hangs while an NFS mount
is under load.


> Ensure that ri_remove_done is initialized only just before the
> transport is woken up to force a close. This avoids the completion
> possibly getting initialized again while the CM event handler is
> waiting for a wake-up.
>=20
> Fixes: bebd031866ca ("xprtrdma: Support unplugging an HCA from under =
an NFS mount")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/xprtrdma/verbs.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 3a56458e8c05..2c40465a19e1 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -244,6 +244,7 @@ static void rpcrdma_update_cm_private(struct =
rpcrdma_xprt *r_xprt,
> 			ia->ri_id->device->name,
> 			rpcrdma_addrstr(r_xprt), =
rpcrdma_portstr(r_xprt));
> #endif
> +		init_completion(&ia->ri_remove_done);
> 		set_bit(RPCRDMA_IAF_REMOVING, &ia->ri_flags);
> 		ep->rep_connected =3D -ENODEV;
> 		xprt_force_disconnect(xprt);
> @@ -297,7 +298,6 @@ static void rpcrdma_update_cm_private(struct =
rpcrdma_xprt *r_xprt,
> 	int rc;
>=20
> 	init_completion(&ia->ri_done);
> -	init_completion(&ia->ri_remove_done);
>=20
> 	id =3D rdma_create_id(xprt->rx_xprt.xprt_net, =
rpcrdma_cm_event_handler,
> 			    xprt, RDMA_PS_TCP, IB_QPT_RC);
>=20

--
Chuck Lever



