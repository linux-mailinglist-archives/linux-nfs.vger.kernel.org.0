Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3512E38DC66
	for <lists+linux-nfs@lfdr.de>; Sun, 23 May 2021 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhEWS11 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 May 2021 14:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231929AbhEWS11 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 May 2021 14:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621794360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOWSDlV6FTualYeo0g++aFI3U5MLIeHCtCdLS8KDy9E=;
        b=e6zg1AVS2NGaewDW/3wbioah82G75lo5gTW4mnHy4zph5RqPKITMYg15oJvDVdvEDUpala
        olSXzgBI9/GpVPuXEvWjqvVf7S5cQEjnmo98IrjO7krzAZqISeqqRr3cYMYaJolouklfso
        QMRJEvgNFScJOm/+YGoCgTFEd+cqlIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-CAVenLFbMpeMe1BxbDZ4aQ-1; Sun, 23 May 2021 14:25:58 -0400
X-MC-Unique: CAVenLFbMpeMe1BxbDZ4aQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4F408015C6;
        Sun, 23 May 2021 18:25:57 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-73.phx2.redhat.com [10.3.112.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 627A750C0B;
        Sun, 23 May 2021 18:25:57 +0000 (UTC)
Subject: Re: [PATCH nfs-utils] gssd: use mutex to protect decrement of
 refcount
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <162157284381.19062.14252943620142216829@noble.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <19f91c57-8f48-fce2-672d-4b21a6e38a1b@RedHat.com>
Date:   Sun, 23 May 2021 14:28:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <162157284381.19062.14252943620142216829@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/21/21 12:54 AM, NeilBrown wrote:
> 
> The decrement of the "ple" refcount is not protected so it can race with
> increments or decrements from other threads.  An increment could be lost
> and then the ple would be freed early, leading to memory corruption.
> 
> So use the mutex to protect decrements (increments are already
> protected).
> 
> As gssd_destroy_krb5_principals() calls release_ple() while holding the
> mutex, we need a "release_pte_locked()" which doesn't take the mutex.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-5-4-rc4)

steved.
> ---
>  utils/gssd/krb5_util.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 28b60ba307d0..51e0c6a2484b 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -169,18 +169,28 @@ static int gssd_get_single_krb5_cred(krb5_context context,
>  static int query_krb5_ccache(const char* cred_cache, char **ret_princname,
>  		char **ret_realm);
>  
> -static void release_ple(krb5_context context, struct gssd_k5_kt_princ *ple)
> +static void release_ple_locked(krb5_context context,
> +			       struct gssd_k5_kt_princ *ple)
>  {
>  	if (--ple->refcount)
>  		return;
>  
> -	printerr(3, "freeing cached principal (ccname=%s, realm=%s)\n", ple->ccname, ple->realm);
> +	printerr(3, "freeing cached principal (ccname=%s, realm=%s)\n",
> +		 ple->ccname, ple->realm);
>  	krb5_free_principal(context, ple->princ);
>  	free(ple->ccname);
>  	free(ple->realm);
>  	free(ple);
>  }
>  
> +static void release_ple(krb5_context context, struct gssd_k5_kt_princ *ple)
> +{
> +	pthread_mutex_lock(&ple_lock);
> +	release_ple_locked(context, ple);
> +	pthread_mutex_unlock(&ple_lock);
> +}
> +
> +
>  /*
>   * Called from the scandir function to weed out potential krb5
>   * credentials cache files
> @@ -1420,7 +1430,7 @@ gssd_destroy_krb5_principals(int destroy_machine_creds)
>  			}
>  		}
>  
> -		release_ple(context, ple);
> +		release_ple_locked(context, ple);
>  	}
>  	pthread_mutex_unlock(&ple_lock);
>  	krb5_free_context(context);
> 

