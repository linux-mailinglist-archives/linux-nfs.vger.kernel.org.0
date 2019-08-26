Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA709D539
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 19:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbfHZRxC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 13:53:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36065 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbfHZRxC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 13:53:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE8B68342DA
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 17:53:01 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A5B55C1D8
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 17:53:01 +0000 (UTC)
Subject: Re: [PATCH 1/2] nfs-utils: Removed a number of Coverity Scan
 RESOURCE_LEAK errors
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20190826143421.13712-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <08a5ee99-7c7b-9a2d-3c23-dd07ad4a60ca@RedHat.com>
Date:   Mon, 26 Aug 2019 13:53:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826143421.13712-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Mon, 26 Aug 2019 17:53:01 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/26/19 10:34 AM, Steve Dickson wrote:
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>  support/nfsidmap/libnfsidmap.c | 3 +++
>  utils/gssd/krb5_util.c         | 4 ++++
>  2 files changed, 7 insertions(+)
Committed...

steved.

> 
> diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
> index 7b8a871..9299e65 100644
> --- a/support/nfsidmap/libnfsidmap.c
> +++ b/support/nfsidmap/libnfsidmap.c
> @@ -486,6 +486,9 @@ out:
>  	if (gss_methods)
>  		conf_free_list(gss_methods);
>  
> +	if (nfs4_methods)
> +		conf_free_list(nfs4_methods);
> +
>  	return ret ? -ENOENT: 0;
>  }
>  
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 454a6eb..f68be85 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -912,6 +912,8 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
>  				k5err = gssd_k5_err_msg(context, code);
>  				printerr(3, "%s while getting keytab entry for '%s'\n",
>  					 k5err, spn);
> +				free(k5err);
> +				k5err = NULL;
>  				/*
>  				 * We tried the active directory machine account
>  				 * with the hostname part as-is and failed...
> @@ -1231,6 +1233,8 @@ gssd_destroy_krb5_machine_creds(void)
>  			k5err = gssd_k5_err_msg(context, code);
>  			printerr(0, "WARNING: %s while destroying credential "
>  				    "cache '%s'\n", k5err, ple->ccname);
> +			free(k5err);
> +			k5err = NULL;
>  		}
>  	}
>  	krb5_free_context(context);
> 
