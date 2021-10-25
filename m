Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DC943A4D0
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Oct 2021 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhJYUkT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Oct 2021 16:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231748AbhJYUkS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Oct 2021 16:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635194275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KodySVmWnOOj795DhjWH8IHZ57WSFruX5qBbXpOVbPs=;
        b=GuF5TUk+8H++2xrWejWUGJoCbWVwZA8TcBXm1IDrzF1GwFiBTBgjJAL3C+xStlbvlSYYIe
        fI5k3WuqxmKgRHnNHp7+hiSAxwjmkRezv78WnaqkBpDZlTEd65LGteT/R6k0m22r5HAEBV
        7qhhHidi7sg+pCbid5IoBlxCBKi2+ok=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-7DcCDIE6PJ-kuKUeC0sO2Q-1; Mon, 25 Oct 2021 16:37:50 -0400
X-MC-Unique: 7DcCDIE6PJ-kuKUeC0sO2Q-1
Received: by mail-qv1-f72.google.com with SMTP id dl14-20020ad44e0e000000b00385391cf8baso2121077qvb.14
        for <linux-nfs@vger.kernel.org>; Mon, 25 Oct 2021 13:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KodySVmWnOOj795DhjWH8IHZ57WSFruX5qBbXpOVbPs=;
        b=19KjoRnXCXaUOhajNKLTx3EQ+BNleWK4q8cPUzUBetCm7CxYoJgq9FY7cQco0RYPQh
         ROK+IxMUa15mGUsyl/LCT2aHFsjVWwodU770RN3vVGpPbeblH3TXPCVFEteS20xL+Dpa
         Iv/1TpVgugGsbmpVs336s/7DKYMdZnl2XyhLk1QkgxHAxXZB+yJwIET9Pix8h+w7snJn
         SbyfW/mr9Bdwy10PmTCjfor31j1utdg5JLm6WjEz4eS8lEtgh11f+wXHSMfUyzSkrrsM
         oUeY92EXv+SWwe44Z+GIbJ5VoRYy5a+FXHqgqSMJ0//H58gyCtW5yPQCK0QV9KqgOVne
         hH3w==
X-Gm-Message-State: AOAM533eLR7HHEikC+QiDkmWRvrqJEsqacFob6T3V/DcJJDhp/1IYJF5
        csylt95PW3KzVxv1NYys3M8pBCcjNbp7lYQQ9k0BLtCQJ1hUHrV3nEdCeibLIZY20vnsLCy7OMh
        MgO16iHK534gaG/44jPD1
X-Received: by 2002:ac8:5c16:: with SMTP id i22mr20361368qti.172.1635194270244;
        Mon, 25 Oct 2021 13:37:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrv+VQ7WYxRA0V/BKF42+Pabyf3rKnw1gVaSdqog5A+VMAXtPKX1fwRTTRh7LTRGbjvBJHFA==
X-Received: by 2002:ac8:5c16:: with SMTP id i22mr20361351qti.172.1635194270001;
        Mon, 25 Oct 2021 13:37:50 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.245.20])
        by smtp.gmail.com with ESMTPSA id h19sm9493919qtb.18.2021.10.25.13.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 13:37:49 -0700 (PDT)
Message-ID: <04c88684-3fb9-1685-da7b-c1bc9a20170b@redhat.com>
Date:   Mon, 25 Oct 2021 16:37:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH nfs-utils] Add --disable-sbin-override for when /sbin is a
 symlink
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <163348839674.31063.11636602028086354852@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <163348839674.31063.11636602028086354852@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/5/21 22:46, NeilBrown wrote:
> 
> mount.nfs* umount.nfs* and nfsdcltrack are currently always installed in
> /sbin.
> 
> Many distros are moving to a "merged /usr" where /sbin and others are
> symlinks into /usr/sbin or similar.  In these cases it is inelegant to
> install in /sbin (i.e. install through a symlink).
> 
> So we add "--disable-sbin-override" as a configure option.  This causes
> the same sbindir to be used for *mount.nfs* and nfsdcltrack as for other
> system binaries.
> 
> Note that autotools notices if we simply define "sbindir=/sbin"
> inside an "if CONFIG_foo" clause, gives a warning, and defeats our
> intent.
> 
> So instead, we use the @CONFIG_SBIN_OVERRIDE_TRUE@ prefix to find
> the new declaration when we don't want it.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: TBD)

steved.
> ---
>   configure.ac                  | 6 ++++++
>   utils/mount/Makefile.am       | 8 +++++---
>   utils/nfsdcltrack/Makefile.am | 9 ++++++---
>   3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index bc2d0f02979c..93626d62be40 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -187,6 +187,12 @@ else
>   	enable_libmount=no
>   fi
>   
> +AC_ARG_ENABLE(sbin-override,
> +	[AC_HELP_STRING([--disable-sbin-override],
> +		[Don't force nfsdcltrack and mount helpers into /sbin: always honour --sbindir])],
> +	enable_sbin_override=$enableval,
> +	enable_sbin_override=yes)
> +	AM_CONDITIONAL(CONFIG_SBIN_OVERRIDE, [test "$enable_sbin_override" = "yes"])
>   AC_ARG_ENABLE(junction,
>   	[AC_HELP_STRING([--enable-junction],
>   			[enable support for NFS junctions @<:@default=no@:>@])],
> diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
> index ad0be93b1def..3101f7abd7f4 100644
> --- a/utils/mount/Makefile.am
> +++ b/utils/mount/Makefile.am
> @@ -1,8 +1,10 @@
>   ## Process this file with automake to produce Makefile.in
>   
> -# These binaries go in /sbin (not /usr/sbin), and that cannot be
> -# overridden at config time.
> -sbindir = /sbin
> +# These binaries go in /sbin (not /usr/sbin), unless CONFIG_SBIN_OVERRIDE
> +# is disabled as may be appropriate when /sbin is a symlink.
> +# Note that we don't use "if CONFIG_SBIN_OVERRIDE" as that
> +# causes autotools to notice the override and disable it.
> +@CONFIG_SBIN_OVERRIDE_TRUE@sbindir = /sbin
>   
>   man8_MANS	= mount.nfs.man umount.nfs.man
>   man5_MANS	= nfs.man
> diff --git a/utils/nfsdcltrack/Makefile.am b/utils/nfsdcltrack/Makefile.am
> index 2f7fe3de6922..769e4a455fcf 100644
> --- a/utils/nfsdcltrack/Makefile.am
> +++ b/utils/nfsdcltrack/Makefile.am
> @@ -1,8 +1,11 @@
>   ## Process this file with automake to produce Makefile.in
>   
> -# These binaries go in /sbin (not /usr/sbin), and that cannot be
> -# overridden at config time. The kernel "knows" the /sbin name.
> -sbindir = /sbin
> +# These binaries go in /sbin (not /usr/sbin) as the kernel "knows" the
> +# /sbin name.  If /sbin is a symlink, CONFIG_SBIN_OVERRIDE can be
> +# disabled to install in /usr/sbin anyway.
> +# Note that we don't use "if CONFIG_SBIN_OVERRIDE" as that
> +# causes autotools to notice the override and disable it.
> +@CONFIG_SBIN_OVERRIDE_TRUE@sbindir = /sbin
>   
>   man8_MANS	= nfsdcltrack.man
>   EXTRA_DIST	= $(man8_MANS)
> 

