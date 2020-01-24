Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53902148C8A
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2020 17:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbgAXQxZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jan 2020 11:53:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59426 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387674AbgAXQxZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jan 2020 11:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579884804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnM3DR70HEe5d+BcsuQTdnTbwstgySy3XrZ9VG+dNDo=;
        b=YyhVzQhhPgu0UN7aOl2wt7Vz7vdiYLSrvYhXgFnevSCNUaMLqmhEqH59AwDdwwoiOieBXE
        IpbKxnKmLaWbX53U7rUkMshsjJ0/D2gk3hcG35wpIHW61opA7/7NouX8uB64cQk+pA5f3x
        sm/9rFjUveoC2YzC6nf/2brjDxlI0Wo=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-3Yw1d6r2P8CWgpwi1HqmJw-1; Fri, 24 Jan 2020 11:53:22 -0500
X-MC-Unique: 3Yw1d6r2P8CWgpwi1HqmJw-1
Received: by mail-yw1-f70.google.com with SMTP id h7so1777611ywe.9
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2020 08:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dnM3DR70HEe5d+BcsuQTdnTbwstgySy3XrZ9VG+dNDo=;
        b=J3sxafmphJLvO1kzZU1kNhImwaFW4xeETMzCpHeuDRHQAUeNrECB2eQL/UA/Yfud+Q
         dV1+QvKbe8R4HB+xxZPhpfsYcq0KTOoEqYYvVv9EAzJFEbruZnPB5LsL6xaaBjAO26NS
         /MYHJ5pIDOVlJcmQ08o+VJMdBVFNupDmeDiXjuoIY06FX5BQGpqFIAjJlLZhVsuWTPyz
         x/g2xelt6svo+kblZEp8M+bpcNoY/3c3XUfYosa1V/rF+iwfMtkdhbGSUhS1gMwOi6/V
         0sx0imC7swTsrmavYI3sVFcn7cNSbJ8+RoBJdv38Ne8T455NV5mgo1ztmet0zTe3cOrx
         dTGw==
X-Gm-Message-State: APjAAAX7CSa0sjPuRfzR6bMN3v2JDVowMc6zy7NP4kzNiYHSJlzJQT7C
        Icjqc1SJCblhEy8ZAtfQGJkFqAqB25SWbP2ltyoEeH92YKTkBBXaQigmCLmioIAmaOgvLojFlYk
        ncXdEQ8m4DFgLtPpPm7+k
X-Received: by 2002:a25:58c2:: with SMTP id m185mr3256088ybb.105.1579884801707;
        Fri, 24 Jan 2020 08:53:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYuYUPdjZa21Z/qlrNUrIbKrML5x4dxd+SICHYHC9k/k/Sy2s+AJ3kyEAoTRQNwoyG7zAkWA==
X-Received: by 2002:a25:58c2:: with SMTP id m185mr3256070ybb.105.1579884801389;
        Fri, 24 Jan 2020 08:53:21 -0800 (PST)
Received: from hut.sorensonfamily.com (198-0-247-150-static.hfc.comcastbusiness.net. [198.0.247.150])
        by smtp.gmail.com with ESMTPSA id y17sm2484469ywd.23.2020.01.24.08.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:53:20 -0800 (PST)
Subject: Re: [PATCH] sunrpc: expiry_time should be seconds not timeval
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>,
        bfields@fieldses.org
Cc:     chuck.lever@oracle.com, trond.myklebust@hammerspace.com,
        linux-nfs@vger.kernel.org
References: <20200124101154.22760-1-rbergant@redhat.com>
From:   Frank Sorenson <sorenson@redhat.com>
Message-ID: <438af54f-e1a8-467a-4ef1-821b67b7bb6c@redhat.com>
Date:   Fri, 24 Jan 2020 10:53:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200124101154.22760-1-rbergant@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/24/20 4:11 AM, Roberto Bergantinos Corpas wrote:
> When upcalling gssproxy, cache_head.expiry_time is set as a
> timeval, not seconds since boot. As such, RPC cache expiry
> logic will not clean expired objects created under
> auth.rpcsec.context cache.
> 
> This has proven to cause kernel memory leaks on field.
> 
> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> ---
>  net/sunrpc/auth_gss/svcauth_gss.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
> index 8be2f209982b..725cf5b5ae40 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -1211,6 +1211,7 @@ static int gss_proxy_save_rsc(struct cache_detail *cd,
>  		dprintk("RPC:       No creds found!\n");
>  		goto out;
>  	} else {
> +		struct timespec boot;
>  
>  		/* steal creds */
>  		rsci.cred = ud->creds;
> @@ -1231,6 +1232,9 @@ static int gss_proxy_save_rsc(struct cache_detail *cd,
>  						&expiry, GFP_KERNEL);
>  		if (status)
>  			goto out;
> +
> +		getboottime(&boot);
> +		expiry -= boot.tv_sec;
>  	}
>  
>  	rsci.h.expiry_time = expiry;
> 

The accumulating  become apparent when the client uses kerberos tickets
with very short (10 seconds or fewer) lifetimes and renewable lifetimes:

mount server:/exports /mnt/tmp -overs=4,sec=krb5p
life="2s"
rlife="3s"
while true ; do
	while true ; do
		kinit -l $life -R >/dev/null 2>&1 && break
		echo 'PASSWORD' | kinit -l $life -r $rlife \
			>/dev/null 2>&1 && break
	done
	timeout -k 1 2 touch /mnt/tmp/foo
	echo -n .
done

Due to the entry expiration occurring 50 years in the future, the
customer had accumulated in excess of 400,000 entries in the cache over
about a month with just 6 nfs clients.  The entries, with all the
accompanying structs which had been allocated consumed over 2 GiB from
various slab caches.

A flush of the cache cleans everything out, however they will again
accumulate afterward.

This patch fixes the expiration issue.

Tested-By: Frank Sorenson <sorenson@redhat.com>


Frank
--
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer
Global Support Services - filesystems
Red Hat








