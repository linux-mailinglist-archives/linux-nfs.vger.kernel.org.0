Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0216EF995F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 20:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKLTIq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 14:08:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54610 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLTIq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Nov 2019 14:08:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACIo8CL088828;
        Tue, 12 Nov 2019 19:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=2s84UTL2eyDXoQXzwM1QURuN+N+bA+YIGe9mHHV4mHo=;
 b=KbgNS7P3GFb0qkVB+J/g12/2Edk5HOzYLwCjD17vkOD74SxyXsJwRtjVXIM2TEW4lD2y
 q0lZFy14NXVDQKthgNlUFVQvDg5BJ+z6Wvs5NV/7kdNTN2QsFVQ0WWMVVYDo3eLy0GdZ
 RmwQ1SIHbohsxkY8+K4TJ9j0Y8xzo68T343HI7kUvkTrpTgwqduBIpxYdKn+Bl0+VXIS
 hhXRb/w4yPT52bZb5G5ShsRWa2RytLBNyaJHwO8rKZUrCyhOi534SuaZU9JCZpri278j
 SS2re6mOfrzezwq6Bz81mKdjM4nRDZxx6jPq92G3CpJKVYOiHivjnbdgzmMEdbGsCo+G mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w5ndq70fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 19:08:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACJ8LD1156660;
        Tue, 12 Nov 2019 19:08:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w7vpmsmc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 19:08:26 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xACJ7oDU018230;
        Tue, 12 Nov 2019 19:07:50 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 11:07:50 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: v4 support requires CRYPTO_SHA256
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191112190155.12872-1-smayhew@redhat.com>
Date:   Tue, 12 Nov 2019 14:07:49 -0500
Cc:     Bruce Fields <bfields@fieldses.org>, jamie@audible.transient.net,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <81E4B70E-CD38-4B89-AE0C-3AFFCACB0A42@oracle.com>
References: <20191112190155.12872-1-smayhew@redhat.com>
To:     Scott Mayhew <smayhew@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120160
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 12, 2019, at 2:01 PM, Scott Mayhew <smayhew@redhat.com> wrote:
> 
> The new nfsdcld client tracking operations use sha256 to compute hashes
> of the kerberos principals, so make sure CRYPTO_SHA256 is enabled.
> 
> Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
> Reported-by: Jamie Heilman <jamie@audible.transient.net>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>

I recently noticed this too in passing. I didn't have a chance to
give a thought about exactly how to address it, but this looks OK
to me.


> ---
> fs/nfsd/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 10cefb0c07c7..c4b1a89b8845 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -73,7 +73,7 @@ config NFSD_V4
> 	select NFSD_V3
> 	select FS_POSIX_ACL
> 	select SUNRPC_GSS
> -	select CRYPTO
> +	select CRYPTO_SHA256
> 	select GRACE_PERIOD
> 	help
> 	  This option enables support in your system's NFS server for
> -- 
> 2.17.2
> 

--
Chuck Lever



