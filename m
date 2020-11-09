Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A07D2AC7A3
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 22:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgKIVuE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 16:50:04 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33442 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIVuE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 16:50:04 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9LE6Sg082669;
        Mon, 9 Nov 2020 21:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=DwElKyTdjVDg9GSJXCaM0mH0AU6+x3ehlAyItPE5z/s=;
 b=vk9Xp0WeO2CDTUXN0zUnf2ID5WQYJgMxZ7QmvTECR2nrh4pLZFo5Kz98QZ5GHvuZ7BG0
 fpAL/v8m9VusbOfdh0D5gJszWx9l1oXP1NSMJRhf3KoOIY8V3zviOIrx6WHrDx72VjRo
 6ZID84ABoN8BqknKex4ZbzcWou1o71L5ZVZrJrAWx3KmDMRZ2Xe//Y12tjEXUNmto3mX
 WJqJNFGSViGN70g8EF+Q+9svASij9qSLXnZeW0ggYW1ZmYWB1vKQzsOGJUSArN+cYFF4
 XwZLtYLg6LXyR5rkVmu2ef2LXq/x6JdBgPbh586LoWjZKIWqnzIaH0qSaDlu8qi45/OB Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34nh3arpjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 21:50:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9LF1HA125013;
        Mon, 9 Nov 2020 21:50:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34p5fy9g26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 21:50:01 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9Lo1kJ027020;
        Mon, 9 Nov 2020 21:50:01 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 13:50:01 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 1/5] SUNRPC: xprt_load_transport() needs to support the
 netid "rdma6"
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201109211029.540993-2-trond.myklebust@hammerspace.com>
Date:   Mon, 9 Nov 2020 16:50:00 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BBDFE45-EFF6-4997-A6C1-E4BB07863ACB@oracle.com>
References: <20201109211029.540993-1-trond.myklebust@hammerspace.com>
 <20201109211029.540993-2-trond.myklebust@hammerspace.com>
To:     Trond Myklebust <trondmy@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090139
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 9, 2020, at 4:10 PM, trondmy@gmail.com wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> According to RFC5666, the correct netid for an IPv6 addressed RDMA
> transport is "rdma6", which we've supported as a mount option since
> Linux-4.7. The problem is when we try to load the module "xprtrdma6",
> that will fail, since there is no modulealias of that name.

Trying to wrap my head around this. Who is forming the legacy names
"xprtrdma6" and "svcrdma6" ?

The module name these days is "rpcrdma". Seems like you should fix
the code that is trying to load these by the wrong name rather than
adding more legacy names.


> Fixes: 181342c5ebe8 ("xprtrdma: Add rdma6 option to support NFS/RDMA =
IPv6")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> net/sunrpc/xprtrdma/module.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/net/sunrpc/xprtrdma/module.c =
b/net/sunrpc/xprtrdma/module.c
> index 620327c01302..fb55983628b4 100644
> --- a/net/sunrpc/xprtrdma/module.c
> +++ b/net/sunrpc/xprtrdma/module.c
> @@ -23,7 +23,9 @@ MODULE_AUTHOR("Open Grid Computing and Network =
Appliance, Inc.");
> MODULE_DESCRIPTION("RPC/RDMA Transport");
> MODULE_LICENSE("Dual BSD/GPL");
> MODULE_ALIAS("svcrdma");
> +MODULE_ALIAS("svcrdma6");
> MODULE_ALIAS("xprtrdma");
> +MODULE_ALIAS("xprtrdma6");
>=20
> static void __exit rpc_rdma_cleanup(void)
> {
> --=20
> 2.28.0
>=20

--
Chuck Lever



