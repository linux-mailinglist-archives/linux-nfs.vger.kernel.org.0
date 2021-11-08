Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79359449A9F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Nov 2021 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhKHRSX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Nov 2021 12:18:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240293AbhKHRSU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Nov 2021 12:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636391735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4RG/RMzRSvPgFnatMEV1p56MCjtp090t1Y+5Ys0H/c=;
        b=M2KrM0Zz5zNYuIrGLmgp6mssMqah8XzR5NQJhUiJSNZOwQgG/rFX4vRp72hPsaRKi9IB/c
        Z2xrs0W1h+4+gcBE7OsBN//w8UMb092+v4+krgFZt0zoi9Q/xsSnw27KppwNUMJjauYwmp
        GhL2XKe82gxjHyDgUfGm21hdfVEaG0o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-_FYfAkC1OTODemasuy4osQ-1; Mon, 08 Nov 2021 12:15:32 -0500
X-MC-Unique: _FYfAkC1OTODemasuy4osQ-1
Received: by mail-qt1-f200.google.com with SMTP id 12-20020ac8570c000000b002acb9d54e79so6785697qtw.6
        for <linux-nfs@vger.kernel.org>; Mon, 08 Nov 2021 09:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G4RG/RMzRSvPgFnatMEV1p56MCjtp090t1Y+5Ys0H/c=;
        b=GPv2+LExc9GQXDFX1/iw96HBhO9qox38/z1C9gunF9NQW+U8t4JWsHMbrLok+GF2/f
         whjDufAZH2RrTWMfI/Xnq/OVeRkTy8DVdW4Vg+irVJQRqqjcsBMhkkK19E3KxRBi9NBv
         xKArA8PUZnhy/3mOCcmkX+akDAU6S8JNqJ7MtCajpn01KsDP520FnyEg1Rl9DjNFIblm
         51Bgb3QNzFw702emWR/O85KWCBhrwcT8FAAhVrXDaYfv5LWhLNTFPGu1dVTPNz4x9Je0
         PV2+ifiWysCAqvGumZo2LPZSPo7citnvT3WiFe0Wjxj6KvPnCyWJk9BNrt0HjnJLT1dY
         p0Ow==
X-Gm-Message-State: AOAM53279uClOTu0FBlkKsy+x9ax1ZJc+kIu1j1+x6I5lwNChgxV/kUU
        wiHVCwTuf2SpOPyHlcZgrRyjJGnJA+ZRDM/blEeS4KOWiR0KMECrgio9XYeTjVbsA3AhGKco+6v
        0TZAyOPqXacxiKA6fkBZU
X-Received: by 2002:ac8:488b:: with SMTP id i11mr1164359qtq.208.1636391732117;
        Mon, 08 Nov 2021 09:15:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNmN2KcZisQ6Z1zE7uYIwRd37Yjqg9MYYxV5u7oIdiTnBDHbHfhWtOwBaQZtupyIdx2mYE1Q==
X-Received: by 2002:ac8:488b:: with SMTP id i11mr1164325qtq.208.1636391731902;
        Mon, 08 Nov 2021 09:15:31 -0800 (PST)
Received: from [172.31.1.6] ([71.161.195.179])
        by smtp.gmail.com with ESMTPSA id z10sm1806862qtj.64.2021.11.08.09.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 09:15:31 -0800 (PST)
Message-ID: <f9e404ec-4e7f-3673-73a5-0df1bd8cf52d@redhat.com>
Date:   Mon, 8 Nov 2021 12:15:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 9/9] rpcctl: Add installation to the Makefile
Content-Language: en-US
To:     schumaker.anna@gmail.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
 <20211028183519.160772-10-Anna.Schumaker@Netapp.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20211028183519.160772-10-Anna.Schumaker@Netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 10/28/21 14:35, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> And create a shell script that launches the python program from the
> $(libdir)
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>   configure.ac             |  1 +
>   tools/Makefile.am        |  2 +-
>   tools/rpcctl/Makefile.am | 20 ++++++++++++++++++++
>   tools/rpcctl/rpcctl      |  5 +++++
>   4 files changed, 27 insertions(+), 1 deletion(-)
>   create mode 100644 tools/rpcctl/Makefile.am
>   create mode 100644 tools/rpcctl/rpcctl
> 
> diff --git a/configure.ac b/configure.ac
> index 93626d62be40..dcd3be0c8a8b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -737,6 +737,7 @@ AC_CONFIG_FILES([
>   	tools/rpcgen/Makefile
>   	tools/mountstats/Makefile
>   	tools/nfs-iostat/Makefile
> +	tools/rpcctl/Makefile
>   	tools/nfsdclnts/Makefile
>   	tools/nfsconf/Makefile
>   	tools/nfsdclddb/Makefile
> diff --git a/tools/Makefile.am b/tools/Makefile.am
> index 9b4b0803db39..c3feabbec681 100644
> --- a/tools/Makefile.am
> +++ b/tools/Makefile.am
> @@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
>   OPTDIRS += nfsdclddb
>   endif
>   
> -SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat nfsdclnts $(OPTDIRS)
> +SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts $(OPTDIRS)
>   
>   MAINTAINERCLEANFILES = Makefile.in
> diff --git a/tools/rpcctl/Makefile.am b/tools/rpcctl/Makefile.am
> new file mode 100644
> index 000000000000..f4237dbc89e5
> --- /dev/null
> +++ b/tools/rpcctl/Makefile.am
> @@ -0,0 +1,20 @@
> +## Process this file with automake to produce Makefile.in
> +PYTHON_FILES =  rpcctl.py client.py switch.py sysfs.py xprt.py
> +tooldir = $(DESTDIR)$(libdir)/rpcctl
> +
> +man8_MANS = rpcctl.man
> +
> +all-local: $(PYTHON_FILES)
> +
> +install-data-hook:
> +	mkdir -p $(tooldir)
> +	for f in $(PYTHON_FILES) ; do \
> +		$(INSTALL) -m 644 $$f $(tooldir)/$$f ; \
> +	done
> +	chmod +x $(tooldir)/rpcctl.py
> +	$(INSTALL) -m 755 rpcctl $(DESTDIR)$(sbindir)/rpcctl
> +	sed -i "s|LIBDIR=.|LIBDIR=$(tooldir)|" $(DESTDIR)$(sbindir)/rpcctl
A couple issues here....

* Changing a file after installed breaks rpm process since it
   changes the checksum of the file so the process thinks it is
   an undeclared file.

* Why is the $(sbindir)/rpcctl wrapper even needed?
   Why not simply put the code that is in $(tooldir)/rpcctl.py
   in the /usr/sbin/rpcctl?

* It appears the proper place to put .py modules is
   under /usr/lib/python-<ver>/rpcctl not /usr/lib64/rpcctl

Finally when I manually set  LIBDIR=/usr/lib64/rpcctl in
the /usr/sbin/rpcctl wrapper all I got was
# rpcctl --help
ERROR: sysfs is not mounted

So I know it was seeing sys.py module but not seeing
/sys/kernel/sunrpc/ which does exist.

# ls /sys/kernel/sunrpc/
./  ../  rpc-clients/  xprt-switches/

So my suggestion is get rid of that wrapper
and look under /usr/lib/python-<ver>/rpcctl
for the .py modules.

steved.

> +
> +
> +
> +MAINTAINERCLEANFILES=Makefile.in
> diff --git a/tools/rpcctl/rpcctl b/tools/rpcctl/rpcctl
> new file mode 100644
> index 000000000000..4cc35e1ea3f9
> --- /dev/null
> +++ b/tools/rpcctl/rpcctl
> @@ -0,0 +1,5 @@
> +#!/bin/bash
> +LIBDIR=.
> +PYTHON3=/usr/bin/python
> +
> +exec $PYTHON3 $LIBDIR/rpcctl.py $*
> 

