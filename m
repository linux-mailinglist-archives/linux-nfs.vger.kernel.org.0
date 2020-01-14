Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7413B234
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2020 19:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgANSgJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jan 2020 13:36:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38142 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANSgJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jan 2020 13:36:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so14916186wmc.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2020 10:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vO1mfJeLMpUR7wMMjrPDibk7SQXoZ4csxvnqq9q7owE=;
        b=ufr+SsFi98LoeMJ/IggzurV0knRG/d4LjgwcpfWCWDoxAZxEUI0pPqW4Xqhu/FkFhZ
         vXAT3OyI4BPQeRSV468trGF1r+Wyh23sx7RkiVyzJ+qqnaHl6XK7VcqqQ+WbARrYC7/k
         tEo5Q8DEYIhry9ZfkCcK/haLk4mEOAaGPFcZqJuxakdMRK1f581gEmxuauadQXMs+hyt
         W7n72UPNh4c/KT/OH1UTgziDY5KWPVYNsO9TamQq3YY8MRk3o5sCoAB1t9z/KWry9Fi9
         2u9QhwKxCr4+aQYmFqEOTPgeW4AB7fm3XJFQbsEvZJaLsgO9FpTLHzg1/S1BRrGy4vyw
         Jn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vO1mfJeLMpUR7wMMjrPDibk7SQXoZ4csxvnqq9q7owE=;
        b=rUSn5UVZOlEN+J3wbYshvVbdai7m8KeYU/lYq5Nnv2eBnyXIitTtmQhyS0lYcD4mz/
         6tl7QUffDeUS3vnJ458Wa7JZ+13JiTx5hr9Fp8t9HD69VAfHogSvGap/pw4O9+zXytHQ
         p6dy+Gn8VkSHdvH0YXqIwulo6cybQ3FBS0bAt8yxm3FvTRhDjJ2xT+GmpwBt0cLNWUYt
         F2R+ZT3yW0/Vzvs/0MCJ9eZeYm98fLHiM+M0P/QOrR99HCI71a6wumfSsP4pOs4zNHS/
         BxJj3I13xcS9OKr+XvkmzpvSAHqxU1Ity+dhVh6jfftorHczHCo006gxnVhq0GwFRaDg
         waLA==
X-Gm-Message-State: APjAAAUtm89I+dKm685Y5wSGojU7SPGyCZpPddjDA/xB6aQijs1fEiZh
        BP0qdGpU8sOJZaqRfIyD6a0=
X-Google-Smtp-Source: APXvYqx33ebTgV8Yl1IP2GWXAPNELfOZStiaKRolluG9sujb+bUmxQgi787BmdtwmbNXhu4A7GrcGQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr27061162wmb.155.1579026966482;
        Tue, 14 Jan 2020 10:36:06 -0800 (PST)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id d10sm21481778wrw.64.2020.01.14.10.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:36:05 -0800 (PST)
Date:   Tue, 14 Jan 2020 19:36:03 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>
Subject: Re: [nfs-utils RESENT PATCH 1/1] locktes/rpcgen: tweak how we
 override compiler settings
Message-ID: <20200114183603.GA24556@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20200105120502.765426-1-petr.vorel@gmail.com>
 <fb4dd073-856a-7807-eb71-f594e58732cb@RedHat.com>
 <bda9e61c-1a06-5ab3-339f-c38e9a68fb73@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda9e61c-1a06-5ab3-339f-c38e9a68fb73@RedHat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

> Actually try this one... the one that works! ;-) 

> diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
> index 3156815..d5cf8da 100644
> --- a/tools/locktest/Makefile.am
> +++ b/tools/locktest/Makefile.am
> @@ -1,12 +1,11 @@
>  ## Process this file with automake to produce Makefile.in

>  CC=$(CC_FOR_BUILD)
> -LIBTOOL = @LIBTOOL@ --tag=CC
> +AM_CFLAGS=$(CFLAGS_FOR_BUILD)
> +AM_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
> +AM_LDFLAGS=$(LDFLAGS_FOR_BUILD)

>  noinst_PROGRAMS = testlk
>  testlk_SOURCES = testlk.c
> -testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
> -testlk_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
> -testlk_LDFLAGS=$(LDFLAGS_FOR_BUILD)

>  MAINTAINERCLEANFILES = Makefile.in
> diff --git a/tools/rpcgen/Makefile.am b/tools/rpcgen/Makefile.am
> index 8a9ec89..84cafb2 100644
> --- a/tools/rpcgen/Makefile.am
> +++ b/tools/rpcgen/Makefile.am
> @@ -1,7 +1,9 @@
>  ## Process this file with automake to produce Makefile.in

>  CC=$(CC_FOR_BUILD)
> -LIBTOOL = @LIBTOOL@ --tag=CC
> +AM_CFLAGS=$(CFLAGS_FOR_BUILD) ${TIRPC_CFLAGS}
> +AM_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
> +AM_LDFLAGS=$(LDFLAGS_FOR_BUILD)

>  noinst_PROGRAMS = rpcgen
>  rpcgen_SOURCES = rpc_clntout.c rpc_cout.c rpc_hout.c rpc_main.c \
> @@ -9,11 +11,6 @@ rpcgen_SOURCES = rpc_clntout.c rpc_cout.c rpc_hout.c rpc_main.c \
>                  rpc_util.c rpc_sample.c rpc_output.h rpc_parse.h \
>                  rpc_scan.h rpc_util.h

> -rpcgen_CFLAGS=$(CFLAGS_FOR_BUILD)
> -rpcgen_CPPLAGS=$(CPPFLAGS_FOR_BUILD)
> -rpcgen_LDFLAGS=$(LDFLAGS_FOR_BUILD)
> -rpcgen_LDADD=$(LIBTIRPC)
> -
>  MAINTAINERCLEANFILES = Makefile.in

>  EXTRA_DIST = rpcgen.new.1

IMHO this one don't work for cross-compilation, tested on buildroot:

PATH="/br-test-pkg/br-arm-full-static/host/bin:/br-test-pkg/br-arm-full-static/host/sbin:/.common/bin/suse:/.local/bin:/.gem/ruby/2.2.0/bin:/bin/:~/.local/bin/:/.common/bin/:~/.vim/bin/:/usr/sbin/:/sbin/:/home/pevik/.common/bin/suse:/home/pevik/bin/:~/.local/bin/:/home/pevik/.common/bin/:~/.vim/bin/:/usr/sbin/:/sbin/:/bin:/usr/local/bin:/usr/bin:/bin:/usr/lib/mit/bin:/usr/lib/mit/sbin:/usr/X11R6/bin"  /usr/bin/make -j9  -C /br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/
make[1]: Entering directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4'
Making all in tools
make[2]: Entering directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools'
Making all in locktest
make[3]: Entering directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools/locktest'
/usr/bin/gcc -DHAVE_CONFIG_H -I. -I../../support/include  -I/br-test-pkg/br-arm-full-static/host/include -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -O2 -I/br-test-pkg/br-arm-full-static/host/include -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os   -static -c -o testlk.o testlk.c
/bin/sh ../../libtool --tag=CC  --tag=CC   --mode=link /usr/bin/gcc -O2 -I/br-test-pkg/br-arm-full-static/host/include -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os   -static -L/br-test-pkg/br-arm-full-static/host/lib -Wl,-rpath,/br-test-pkg/br-arm-full-static/host/lib -static -o testlk testlk.o  
libtool: link: /usr/bin/gcc -O2 -I/br-test-pkg/br-arm-full-static/host/include -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os -static -Wl,-rpath -Wl,/br-test-pkg/br-arm-full-static/host/lib -static -o testlk testlk.o  -L/br-test-pkg/br-arm-full-static/host/lib
/usr/lib64/gcc/x86_64-suse-linux/9/../../../../x86_64-suse-linux/bin/ld: cannot find -lc
collect2: error: ld returned 1 exit status
make[3]: *** [Makefile:417: testlk] Error 1
make[3]: Leaving directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools/locktest'
make[2]: *** [Makefile:429: all-recursive] Error 1
make[2]: Leaving directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/tools'
make[1]: *** [Makefile:469: all-recursive] Error 1
make[1]: Leaving directory '/br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4'
make: *** [package/pkg-generic.mk:260: /br-test-pkg/br-arm-full-static/build/nfs-utils-1.3.4/.stamp_built] Error 2

I can send you more debug info, but IMHO Mike's patch is really needed.

Kind regards,
Petr
