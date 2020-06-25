Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0020A5A2
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 21:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405924AbgFYTTq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 15:19:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37070 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406068AbgFYTTq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 15:19:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PJHxJi072486;
        Thu, 25 Jun 2020 19:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=5TZTNYjgptrC+k0dSj4JgnxfE/delMSPMsMeSXROSxM=;
 b=hKU/qhTv7+9uisksq9nz3cyLr7afXyJ5p5rNXIZuxBK5lMRGqIVKrSFzRZwJYURJ5lYq
 TtfnMAWxeeKC/Ahr5/PMatHhBcfa/8d71K+lU2otqecO+hcAiDUxVjV5vt/uMYCr2UcF
 Rs/mdkNvYD0D7M+YJxvVYPxKBXd3Mig60ALqZjGh31gS1qbQ9jZev0ss1K9PCJEws8Bv
 xFCY8tC8B6ptWDEhF85yFmwpE/zThEW2ItnTp0S6ts7yiORFJ8RDx3eSE0wYy2/G7wg6
 LjIA916cpfdeGJF7Gr5dOcxPagKmOyp12aEC706C5tzIHRpWxrVACFWpCw3ogKl2l80q RQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31uusu2ct3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jun 2020 19:19:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PJJSjI131800;
        Thu, 25 Jun 2020 19:19:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31uurt0v57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 19:19:41 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05PJJec4025591;
        Thu, 25 Jun 2020 19:19:40 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jun 2020 19:19:40 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] xprtrdma: Ensure connect worker is awoken after connect
 error
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200621145934.4069.31886.stgit@manet.1015granger.net>
Date:   Thu, 25 Jun 2020 15:19:39 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E2AA9D9-2503-462C-952D-FC0DD5111BD1@oracle.com>
References: <20200621145934.4069.31886.stgit@manet.1015granger.net>
To:     Dan Aloni <dan@kernelim.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=2 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250114
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Anna, please drop this one. It appears to trigger a particularly nasty
use-after-free. I'll follow up with a more complete fix soon.

(Yes, a wake-up on connect errors is indeed necessary... but the connect
worker needs to be re-organized to deal properly with it).


> On Jun 21, 2020, at 10:59 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> From: Dan Aloni <dan@kernelim.com>
>=20
> The connect worker sleeps waiting for either successful connection
> establishment or an error. Commit e28ce90083f0 ("xprtrdma: kmalloc
> rpcrdma_ep separate from rpcrdma_xprt") mistakenly removed the
> wake-up in cases when connection establishment fails.
>=20
> Fixes: e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from =
rpcrdma_xprt")
> Signed-off-by: Dan Aloni <dan@kernelim.com>
> [ cel: rebased on recent fixes to 5.8-rc; patch description rewritten =
]
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/xprtrdma/verbs.c |    1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 2198c8ec8dff..54c6809bf06e 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -296,6 +296,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, =
struct rdma_cm_event *event)
> 		ep->re_connect_status =3D -ECONNABORTED;
> disconnected:
> 		rpcrdma_force_disconnect(ep);
> +		wake_up_all(&ep->re_connect_wait);
> 		return rpcrdma_ep_put(ep);
> 	default:
> 		break;
>=20

--
Chuck Lever



