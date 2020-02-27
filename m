Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996C4172277
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2020 16:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgB0Ppl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 10:45:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729110AbgB0Ppk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 10:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582818339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQRewOOpk5gRN85dGQBl7ENRTNaeuSa+c+TXEzzggqk=;
        b=Rw/n+GRw0eaQQnTZkwB9wEGPfbYjRLuuED4Mru4jyBRCdmCCVT8kwXGfF5qNcPf2Og4OyS
        HXefNIv+ajCDGB+S7lMUgPq2AUxGzJ0a4WIJi4TcOXUAU907xR2RL86F5FUrkZi9cndYKX
        unhUsrqXxqAiEyTBwWqWd/NB+a5XcwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-rsd_FpV7NwylNRIkZWvlZA-1; Thu, 27 Feb 2020 10:45:37 -0500
X-MC-Unique: rsd_FpV7NwylNRIkZWvlZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F1B018C35A0
        for <linux-nfs@vger.kernel.org>; Thu, 27 Feb 2020 15:45:36 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9B3101E811
        for <linux-nfs@vger.kernel.org>; Thu, 27 Feb 2020 15:45:36 +0000 (UTC)
Subject: Re: [PATCH] gssd: Use krb5_free_string() instead of free()
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200226190221.24885-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <82ff2690-3b7c-85be-3182-d35024936d48@RedHat.com>
Date:   Thu, 27 Feb 2020 10:45:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226190221.24885-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/26/20 2:02 PM, Steve Dickson wrote:
> Commit ae9e9760 plugged up some memory leaks
> by freeing memory via free(2). The proper
> way to free memory that has been allocated by
> krb5 functions is with krb5_free_string()
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-4-4-rc1)

steved.
> ---
>  utils/gssd/krb5_util.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 85f60ae..8c73748 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -484,7 +484,7 @@ gssd_get_single_krb5_cred(krb5_context context,
>  	if (ccache)
>  		krb5_cc_close(context, ccache);
>  	krb5_free_cred_contents(context, &my_creds);
> -	free(k5err);
> +	krb5_free_string(context, k5err);
>  	return (code);
>  }
>  
> @@ -723,7 +723,7 @@ gssd_search_krb5_keytab(krb5_context context, krb5_keytab kt,
>  				 "we failed to unparse principal name: %s\n",
>  				 k5err);
>  			k5_free_kt_entry(context, kte);
> -			free(k5err);
> +			krb5_free_string(context, k5err);
>  			k5err = NULL;
>  			continue;
>  		}
> @@ -770,7 +770,7 @@ gssd_search_krb5_keytab(krb5_context context, krb5_keytab kt,
>  	if (retval < 0)
>  		retval = 0;
>    out:
> -	free(k5err);
> +	krb5_free_string(context, k5err);
>  	return retval;
>  }
>  
> @@ -927,7 +927,7 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
>  				k5err = gssd_k5_err_msg(context, code);
>  				printerr(1, "%s while building principal for '%s'\n",
>  					 k5err, spn);
> -				free(k5err);
> +				krb5_free_string(context, k5err);
>  				k5err = NULL;
>  				continue;
>  			}
> @@ -937,7 +937,7 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
>  				k5err = gssd_k5_err_msg(context, code);
>  				printerr(3, "%s while getting keytab entry for '%s'\n",
>  					 k5err, spn);
> -				free(k5err);
> +				krb5_free_string(context, k5err);
>  				k5err = NULL;
>  				/*
>  				 * We tried the active directory machine account
> @@ -986,7 +986,7 @@ out:
>  		k5_free_default_realm(context, default_realm);
>  	if (realmnames)
>  		krb5_free_host_realm(context, realmnames);
> -	free(k5err);
> +	krb5_free_string(context, k5err);
>  	return retval;
>  }
>  
> @@ -1249,7 +1249,7 @@ gssd_destroy_krb5_machine_creds(void)
>  			printerr(0, "WARNING: %s while resolving credential "
>  				    "cache '%s' for destruction\n", k5err,
>  				    ple->ccname);
> -			free(k5err);
> +			krb5_free_string(context, k5err);
>  			k5err = NULL;
>  			continue;
>  		}
> @@ -1258,13 +1258,13 @@ gssd_destroy_krb5_machine_creds(void)
>  			k5err = gssd_k5_err_msg(context, code);
>  			printerr(0, "WARNING: %s while destroying credential "
>  				    "cache '%s'\n", k5err, ple->ccname);
> -			free(k5err);
> +			krb5_free_string(context, k5err);
>  			k5err = NULL;
>  		}
>  	}
>  	krb5_free_context(context);
>    out:
> -	free(k5err);
> +	krb5_free_string(context, k5err);
>  }
>  
>  /*
> @@ -1347,7 +1347,7 @@ out_free_kt:
>  out_free_context:
>  	krb5_free_context(context);
>  out:
> -	free(k5err);
> +	krb5_free_string(context, k5err);
>  	return retval;
>  }
>  
> 

