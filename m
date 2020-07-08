Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11820218A6D
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgGHOuN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 10:50:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31961 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729206AbgGHOuM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 10:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594219811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=47zG5omVzgKomzLQDhiyB0uXTW9JWgLP19IjH1Zmztg=;
        b=MQTnTpUFGnT3egRLbYJQAO/e4QIcRcBwHRlUkVAWuBS1EEJu8CqTQqAjBMfOxShKu+9sOM
        SUmefzjp29+SZDQAEo/7jZB4LYM4xS1yxK+V9MDAdS636EbxodP6XOL8EYZQS3/KI3Wtsw
        rxisUx7FqbtBpshwL6B51PUzwIRf1So=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-0cej2CeaNVm__aveDLc2sw-1; Wed, 08 Jul 2020 10:50:09 -0400
X-MC-Unique: 0cej2CeaNVm__aveDLc2sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D9891B2C980;
        Wed,  8 Jul 2020 14:50:08 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-95.phx2.redhat.com [10.3.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E53F45FC3B;
        Wed,  8 Jul 2020 14:50:07 +0000 (UTC)
Subject: Re: [PATCH 04/10] gssd: gssd_k5_err_msg() returns a ". Use free() to
 release.
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20200701182803.14947-1-nazard@nazar.ca>
 <20200701182803.14947-5-nazard@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <3a758b78-e477-4a75-63ca-65333a413599@RedHat.com>
Date:   Wed, 8 Jul 2020 10:50:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701182803.14947-5-nazard@nazar.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 7/1/20 2:27 PM, Doug Nazar wrote:
> Signed-off-by: Doug Nazar <nazard@nazar.ca>
> ---
>  utils/gssd/krb5_util.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index c49c6672..b1e48241 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -484,7 +484,7 @@ gssd_get_single_krb5_cred(krb5_context context,
>  	if (ccache)
>  		krb5_cc_close(context, ccache);
>  	krb5_free_cred_contents(context, &my_creds);
> -	krb5_free_string(context, k5err);
> +	free(k5err);
>  	return (code);
>  }
>  
> @@ -723,7 +723,7 @@ gssd_search_krb5_keytab(krb5_context context, krb5_keytab kt,
>  				 "we failed to unparse principal name: %s\n",
>  				 k5err);
>  			k5_free_kt_entry(context, kte);
> -			krb5_free_string(context, k5err);
> +			free(k5err);
>  			k5err = NULL;
>  			continue;
>  		}
> @@ -770,7 +770,7 @@ gssd_search_krb5_keytab(krb5_context context, krb5_keytab kt,
>  	if (retval < 0)
>  		retval = 0;
>    out:
> -	krb5_free_string(context, k5err);
> +	free(k5err);
>  	return retval;
>  }
>  
> @@ -927,7 +927,7 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
>  				k5err = gssd_k5_err_msg(context, code);
>  				printerr(1, "%s while building principal for '%s'\n",
>  					 k5err, spn);
> -				krb5_free_string(context, k5err);
> +				free(k5err);
>  				k5err = NULL;
>  				continue;
>  			}
> @@ -937,7 +937,7 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
>  				k5err = gssd_k5_err_msg(context, code);
>  				printerr(3, "%s while getting keytab entry for '%s'\n",
>  					 k5err, spn);
> -				krb5_free_string(context, k5err);
> +				free(k5err);
>  				k5err = NULL;
>  				/*
>  				 * We tried the active directory machine account
> @@ -986,7 +986,7 @@ out:
>  		k5_free_default_realm(context, default_realm);
>  	if (realmnames)
>  		krb5_free_host_realm(context, realmnames);
> -	krb5_free_string(context, k5err);
> +	free(k5err);
>  	return retval;
>  }
>  
> @@ -1355,7 +1355,7 @@ out_free_kt:
>  out_free_context:
>  	krb5_free_context(context);
>  out:
> -	krb5_free_string(context, k5err);
> +	free(k5err);
>  	return retval;
>  }
>  
> 
I'm curious about these changes... since all krb5_free_string()
does is call free()... where is the "strdup'd msg" coming from?

steved.

