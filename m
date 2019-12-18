Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA61249C0
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLROd2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 09:33:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53945 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726856AbfLROd2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 09:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576679607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBs7P6wjwVnP2AOYMkRrSgc31xigV8cxGOiShYOJ2qI=;
        b=MX5HeX2F/j41yNUW1E7fdCXawj7fcJCvntyTVn1xRywwoXH6ogqWxti6eo/V0WSoPOM+/j
        WdtYfZmqsSU4GDU7gBAmgEM9TImxmSkTiM7RjCcq1hjO6Ho8iLdrPWodZpR2ViLs0tDvzK
        RXCZE7mhMTyKcgRuVgaWbr+I6yliS6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-DSsRKWZUP9ir5Zda2C6IyA-1; Wed, 18 Dec 2019 09:33:25 -0500
X-MC-Unique: DSsRKWZUP9ir5Zda2C6IyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD9CF13084C;
        Wed, 18 Dec 2019 14:33:24 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-81.phx2.redhat.com [10.3.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65E1C2B943;
        Wed, 18 Dec 2019 14:33:24 +0000 (UTC)
Subject: Re: [nfs-utils PATCH] gssd: force getting tgt if ticket cache was
 removed
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     linux-nfs@vger.kernel.org
References: <20191212160000.22320-1-olga.kornievskaia@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c3de459c-e7a1-094a-f026-f3198588dd13@RedHat.com>
Date:   Wed, 18 Dec 2019 09:33:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212160000.22320-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/12/19 11:00 AM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> If ticket cache was removed manually, but gssd thinks it has a valid
> credentials it will fail mount creation as it can't get a service
> ticket (due to lack of the tgt).
> 
> Check if file-based ticket cache is not there and set the "nocache"
> to 1 forcing the client to get a new tgt.
> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Committed... (tag: nfs-utils-2-4-3-rc3)

steved.

> ---
>  utils/gssd/krb5_util.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 0474783..bff759f 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -121,6 +121,9 @@
>  #include <krb5.h>
>  #include <rpc/auth_gss.h>
>  
> +#include <sys/types.h>
> +#include <fcntl.h>
> +
>  #include "nfslib.h"
>  #include "gssd.h"
>  #include "err_util.h"
> @@ -314,6 +317,25 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
>  	return err;
>  }
>  
> +/* check if the ticket cache exists, if not set nocache=1 so that new
> + * tgt is gotten
> + */
> +static int
> +gssd_check_if_cc_exists(struct gssd_k5_kt_princ *ple)
> +{
> +	int fd;
> +	char cc_name[BUFSIZ];
> +
> +	snprintf(cc_name, sizeof(cc_name), "%s/%s%s_%s",
> +		ccachesearch[0], GSSD_DEFAULT_CRED_PREFIX,
> +		GSSD_DEFAULT_MACHINE_CRED_SUFFIX, ple->realm);
> +	fd = open(cc_name, O_RDONLY);
> +	if (fd < 0)
> +		return 1;
> +	close(fd);
> +	return 0;
> +}
> +
>  /*
>   * Obtain credentials via a key in the keytab given
>   * a keytab handle and a gssd_k5_kt_princ structure.
> @@ -348,6 +370,8 @@ gssd_get_single_krb5_cred(krb5_context context,
>  
>  	memset(&my_creds, 0, sizeof(my_creds));
>  
> +	if (!nocache && !use_memcache)
> +		nocache = gssd_check_if_cc_exists(ple);
>  	/*
>  	 * Workaround for clock skew among NFS server, NFS client and KDC
>  	 * 300 because clock skew must be within 300sec for kerberos
> 

