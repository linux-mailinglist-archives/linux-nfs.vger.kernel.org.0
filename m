Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFCBF105D1B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2019 00:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfKUXRK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Nov 2019 18:17:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37698 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXRK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Nov 2019 18:17:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALNGF0O005369;
        Thu, 21 Nov 2019 23:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=wfr7ItcBNgtwNJToIckvHIPorNbplzfnWMpLbpPdOZA=;
 b=KNziCNPg8KW7ihA2+bNMOehNQh8j98ZuAcv1VPujNOjqBoHCKPZ7HCg3N0ux95h8iBA8
 qqBv9DBBkkXl3+ruEPAWytWG9aO6P0sSFjL2Mb7PaVO0LQ1OykCqya84cqOp0rrqIoxX
 hajjMfe6sE378rr/TB6VrlbIg/cvM3yL9FHE/Fi9H2K2/dtBMGU93lR/K+aJY2gr57Ep
 5HDkV76jj+2tLNpERu+IL0JRvuLuBOpzoJi5msXptTgnClHzASsm4bFvrRPlhbvUv0pD
 hcv8Z9wA3YaFyRrXJ7FkR+TMJjKFuc8OoeNN0W2LtsZ5SOeqfvMd9wjLWAQf4vp2Zy5K Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wa9rqycmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 23:17:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALNAvgk116424;
        Thu, 21 Nov 2019 23:17:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wd47xu1gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 23:17:02 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xALNGudH021375;
        Thu, 21 Nov 2019 23:16:56 GMT
Received: from mbp2018.cdmnet.org (/82.27.120.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 15:16:56 -0800
Cc:     Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFS: allow deprecation of NFS UDP protocol
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
References: <20191121160651.5317-1-olga.kornievskaia@gmail.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Message-ID: <ce430173-8fc0-564a-eb51-f79698920436@oracle.com>
Date:   Thu, 21 Nov 2019 23:16:52 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:72.0)
 Gecko/20100101 Thunderbird/72.0a1
MIME-Version: 1.0
In-Reply-To: <20191121160651.5317-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210195
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210196
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

hi Olga,

On 21/11/2019 4:06 pm, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Add a kernel config CONFIG_NFS_DISABLE_UDP_SUPPORT to disallow NFS
> UDP mounts and enable it by default.
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>   fs/nfs/Kconfig  | 10 ++++++++++
>   fs/nfs/client.c |  4 ++++
>   fs/nfs/super.c  |  4 ++++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index 295a7a2..ba5a681 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -196,3 +196,13 @@ config NFS_DEBUG
>   	depends on NFS_FS && SUNRPC_DEBUG
>   	select CRC32
>   	default y
> +
> +config NFS_DISABLE_UDP_SUPPORT
> +	bool "NFS: Disable NFS UDP protocol support"
> +	depends on NFS_FS
> +	default y
> +	help
> +	  Choose Y here to disable the use of NFS over UDP. NFS over UDP
> +	  on modern networks (1Gb+) can lead to data corruption caused by
> +	  fragmentation during high loads.
> +	  The default is N because many deployments still use UDP.

You've changed the default to 'y' for v2, but you've left in the 'N' 
comment.


> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 02110a3..24ca314 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -474,6 +474,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
>   			to->to_maxval = to->to_initval;
>   		to->to_exponential = 0;
>   		break;
> +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
>   	case XPRT_TRANSPORT_UDP:
>   		if (retrans == NFS_UNSPEC_RETRANS)
>   			to->to_retries = NFS_DEF_UDP_RETRANS;
> @@ -484,6 +485,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
>   		to->to_maxval = NFS_MAX_UDP_TIMEOUT;
>   		to->to_exponential = 1;
>   		break;
> +#endif

Should the first two of your added ifdefs be ifndefs?

cheers,
calum.

>   	default:
>   		BUG();
>   	}
> @@ -580,8 +582,10 @@ static int nfs_start_lockd(struct nfs_server *server)
>   		default:
>   			nlm_init.protocol = IPPROTO_TCP;
>   			break;
> +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
>   		case XPRT_TRANSPORT_UDP:
>   			nlm_init.protocol = IPPROTO_UDP;
> +#endif
>   	}
>   
>   	host = nlmclnt_init(&nlm_init);
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index a84df7d6..f68346d 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -2204,6 +2204,10 @@ static int nfs_validate_text_mount_data(void *options,
>   #endif /* CONFIG_NFS_V4 */
>   	} else {
>   		nfs_set_mount_transport_protocol(args);
> +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> +		if (args->nfs_server.protocol == XPRT_TRANSPORT_UDP)
> +			goto out_invalid_transport_udp;
> +#endif
>   		if (args->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
>   			port = NFS_RDMA_PORT;
>   	}
> 
