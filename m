Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69026286AA0
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Oct 2020 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgJGWC2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 18:02:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44110 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgJGWC2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 18:02:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097LmDc5137678;
        Wed, 7 Oct 2020 22:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=c3UheH0Aw544hY3kfOXp/QPS60nP1kiQ8muVo+PYrIc=;
 b=nKTL3AR54O1ogqeMHtL3GKWtYw20rgnlGbWlgUel1Mk2wZI8mQZG3UHIvcihYcF4H0pE
 zRPx34sXYgqsrXAtvKmn0RZDmOWEberey31M6qQxl6ZJ4Q4VaC3WRtgtqkQh3iPjtUMb
 +GdDtuLU3XntwHd0hQGNKULs6L/aPME8pYY9Jya6og1F/MuADrraYPKFw+KKYijCIidw
 h6U9HoxTbyf/SLmBRi5F4Ht46IbQPs1ZqyrU8go95QofbsaGIdEuMqvmRAyQm+GXiB9J
 iHLu586IVZR2rPY1P1EL7k78gFcPQIdgd5Cdoazh/GeYqVfxoZ6WwbDHzducryoqYmPy QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33xetb4rv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 22:02:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097LoCIe132114;
        Wed, 7 Oct 2020 22:02:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33y3804gt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 22:02:24 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 097M2NSb006357;
        Wed, 7 Oct 2020 22:02:23 GMT
Received: from dhcp-10-154-101-34.vpn.oracle.com (/10.154.101.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 15:02:23 -0700
Subject: Re: [PATCH 2/2] NFSv4: Use the net namespace uniquifier if it is set
To:     trondmy@kernel.org, Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
References: <20201007210720.537880-1-trondmy@kernel.org>
 <20201007210720.537880-2-trondmy@kernel.org>
 <20201007210720.537880-3-trondmy@kernel.org>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <7eea5363-6f0c-0897-98e4-5a745130a1eb@oracle.com>
Date:   Wed, 7 Oct 2020 15:02:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201007210720.537880-3-trondmy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=3 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=3 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070139
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 10/7/20 2:07 PM, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If a container sets a net namespace specific uniquifier, then use that
> in the setclientid/exchangeid process.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/nfs4proc.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 3a39887e0e6e..a1dd46e7440b 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -63,6 +63,7 @@
>   #include "callback.h"
>   #include "pnfs.h"
>   #include "netns.h"
> +#include "sysfs.h"
>   #include "nfs4idmap.h"
>   #include "nfs4session.h"
>   #include "fscache.h"
> @@ -6007,9 +6008,25 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
>   }
>   
>   static size_t
> -nfs4_get_uniquifier(char *buf, size_t buflen)
> +nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
>   {
> +	struct nfs_net *nn = net_generic(clp->cl_net, nfs_net_id);
> +	struct nfs_netns_client *nn_clp = nn->nfs_client;
> +	const char *id;
> +	size_t len;
> +
>   	buf[0] = '\0';
> +
> +	if (nn_clp) {
> +		rcu_read_lock();
> +		id = rcu_dereference(nn_clp->identifier);
> +		if (id && *id != '\0')
> +			len = strlcpy(buf, id, buflen);
> +		rcu_read_unlock();
> +		if (len)

I think 'len' can be uninitialized here.

-Dai

> +			return len;
> +	}
> +
>   	if (nfs4_client_id_uniquifier[0] != '\0')
>   		return strlcpy(buf, nfs4_client_id_uniquifier, buflen);
>   	return 0;
> @@ -6034,7 +6051,7 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
>   		1;
>   	rcu_read_unlock();
>   
> -	buflen = nfs4_get_uniquifier(buf, sizeof(buf));
> +	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
>   	if (buflen)
>   		len += buflen + 1;
>   
> @@ -6081,7 +6098,7 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
>   	len = 10 + 10 + 1 + 10 + 1 +
>   		strlen(clp->cl_rpcclient->cl_nodename) + 1;
>   
> -	buflen = nfs4_get_uniquifier(buf, sizeof(buf));
> +	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
>   	if (buflen)
>   		len += buflen + 1;
>   
