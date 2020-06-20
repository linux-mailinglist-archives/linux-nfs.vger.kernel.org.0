Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27409202604
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2020 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgFTSrC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Jun 2020 14:47:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34640 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgFTSrB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Jun 2020 14:47:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05KIhK70087983;
        Sat, 20 Jun 2020 18:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=61QHmuzvRGfWOd8s5jF/RkioZ95ddhrBSNbVDmSKbfc=;
 b=qgb7zNjRCE1z7yU0IDxWwwcPLngrvULrbN3pYqhuwPaoXw++b2WuK5v7oxOjbub0mHLD
 4nBv7vxFx7ARVnZPNzH5qBrWFqgjrWjjm5ozb0YshAoMoOYSGI6MClfa+WtbCPNnXQWA
 ervXIHofME/j5z+dtWibLFH+6ut8B9fgkglyy+wCcDrruSvV71gK3HyPSRafTnfk/3QL
 haPE2IUM/hrKP+LPTopXi3XXS9AitS2GpwzcAvqiExCinxCMve+0InHtoCggHYKqXIbM
 wtncLEqAITO4q4wQyMQXpHO17HqQ/+8gLW/o5LOe4eV/fypS0YzEfVwREXL7PyIpvEdY Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31sebb1d42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Jun 2020 18:46:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05KIhaW0142908;
        Sat, 20 Jun 2020 18:46:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31seb7wvsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Jun 2020 18:46:59 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05KIkv5V020253;
        Sat, 20 Jun 2020 18:46:57 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 20 Jun 2020 18:46:57 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] xprtrdma: Wake up re_connect_wait on disconnect
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200620171805.1748399-1-dan@kernelim.com>
Date:   Sat, 20 Jun 2020 14:46:55 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC3CC4DE-C508-4F95-9F0D-B2977CD7301F@oracle.com>
References: <20200620171805.1748399-1-dan@kernelim.com>
To:     Dan Aloni <dan@kernelim.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9658 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006200137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9658 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 cotscore=-2147483648
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006200137
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan-

> On Jun 20, 2020, at 1:18 PM, Dan Aloni <dan@kernelim.com> wrote:
>=20
> Given that rpcrdma_xprt_connect() happens from workqueue context, on =
cases where
> connections don't succeeds, something needs to wake it up. In my case, =
this has
> been observed when the CM callback received `RDMA_CM_EVENT_REJECTED`, =
and
> `rpcrdma_xprt_connect()` slept forever.

Interesting. My development and testing generates plenty of REJECTED =
connection
requests, but I never saw this particular failure mode.


> This continues the fix in commit 58bd6656f808 ('xprtrdma: Restore =
wake-up-all to
> rpcrdma_cm_event_handler()').

The patch looks sensible. I'll pull it into my test harness.


> Signed-off-by: Dan Aloni <dan@kernelim.com>
> CC: Chuck Lever <chuck.lever@oracle.com>
> ---
>=20
> Notes:
>    Hi Chuck,
>=20
>    Maybe I missd something, as it is not clear to me how otherwise =
(without this
>    patch), re_connect_wait can be woken up in this situation. Please =
explain?
>=20
> net/sunrpc/xprtrdma/verbs.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 2ae348377806..8bd76a47a91f 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -289,6 +289,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, =
struct rdma_cm_event *event)
> 		ep->re_connect_status =3D -ECONNABORTED;
> disconnected:
> 		xprt_force_disconnect(xprt);
> +		wake_up_all(&ep->re_connect_wait);
> 		return rpcrdma_ep_destroy(ep);
> 	default:
> 		break;
> --=20
> 2.25.4
>=20

--
Chuck Lever



