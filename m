Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506B91102DE
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2019 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfLCQuY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Dec 2019 11:50:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56044 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfLCQuY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Dec 2019 11:50:24 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3GiA7j026421;
        Tue, 3 Dec 2019 16:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=HJS959zgmPYJyxTarDK0UTqD7NIvOQe4pOWpkFPCo6E=;
 b=f0y0KbyqiYVleSwkag0m4d3+2cuCmLrHkKCO4pkchOr4ZBYgGzPqQqduIKiRBtl/tUlH
 93vVzHZ5OzASrJmqAImUGnH+ILhrrbuIx5BNAtKOsT1ikLgDI53Kz1qLKG+9ULhYx6IF
 DeO9+XwfFeCm58mCxvADaDeWU0gSX9G1S91ROqsvyiWBY2Cqd7vv+D4oGvHseMKl5tYM
 wCLbRmaYvPJIKfl6Lwl6duOk27oevJm6vlC8kAC/ZFo4WduKATgrsOLmBY30nmcrjWq5
 PA6ABgS5vxAabZQEqY72bH8U5PE9pL7xXLDlVmsZRVS40bSGkQnBEgwKyTFgS11Wa8Ce IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wkfuu9579-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 16:50:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3Gi4ek083026;
        Tue, 3 Dec 2019 16:50:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wn7pqbwqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 16:50:18 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB3GoGqn011627;
        Tue, 3 Dec 2019 16:50:16 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 08:50:15 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: depend on CRYPTO_MD5 for legacy client tracking
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <d411d31bcde3e0221d54ee8bb5af80772a277cad.1575355896.git.ps@pks.im>
Date:   Tue, 3 Dec 2019 11:50:14 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Content-Transfer-Encoding: 7bit
Message-Id: <6B0AEF69-ED97-4031-9511-7DC9A16802B7@oracle.com>
References: <d411d31bcde3e0221d54ee8bb5af80772a277cad.1575355896.git.ps@pks.im>
To:     Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030125
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Patrick-

> On Dec 3, 2019, at 1:52 AM, Patrick Steinhardt <ps@pks.im> wrote:
> 
> The legacy client tracking infrastructure of nfsd makes use of MD5 to
> derive a client's recovery directory name. As the nfsd module doesn't
> declare any dependency on CRYPTO_MD5, though, it may fail to allocate
> the hash if the kernel was compiled without it. As a result, generation
> of client recovery directories will fail with the following error:
> 
>    NFSD: unable to generate recoverydir name
> 
> The dependency was removed as a seemingly redundant dependency back in
> 6aaa67b5f3b9 (NFSD: Remove redundant "select" clauses in fs/Kconfig
> 2008-02-11). But in fact, even then the MD5 module was pulled in only
> when RPCSEC_GSS_KRB5 or RPCSEC_GSS_KRB5 was selected.
> 
> Fix the issue by adding back an explicit dependency on CRYPTO_MD5.
> 
> Fixes: 6aaa67b5f3b9 (NFSD: Remove redundant "select" clauses in fs/Kconfig)

Just a quibble with your Fixes: tag.

At that time, selecting NFSv4 support did bring in CRYPTO, because
NFSv4 support always selected RPCSEC_GSS_KRB5.

It was a later commit that removed RPCSEC_GSS_KRB5:

df486a25900f ("NFS: Fix the selection of security flavours in Kconfig")


> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> fs/nfsd/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index c4b1a89b8845..f2f81561ebb6 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -73,6 +73,7 @@ config NFSD_V4
> 	select NFSD_V3
> 	select FS_POSIX_ACL
> 	select SUNRPC_GSS
> +	select CRYPTO_MD5
> 	select CRYPTO_SHA256
> 	select GRACE_PERIOD
> 	help
> -- 
> 2.24.0
> 

--
Chuck Lever



