Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7E3141FB5
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jan 2020 20:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgASTLP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Jan 2020 14:11:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40824 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgASTLO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Jan 2020 14:11:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so14371757pgt.7
        for <linux-nfs@vger.kernel.org>; Sun, 19 Jan 2020 11:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4P3hGirTB2owYm/w+1/cGwpAo3wz4jLRC9Qqa39uRfM=;
        b=JoA7b+enG/sN6juVyBlzPrPxBXun+RWC46OG+mcmH6GlOp99Ej4Ri39qSLosmnUvCL
         pypmj0rAv+X0D0R5Um2ko4VtFDjtVc+KsmGwQzMHPUCdBwo40KFSGvA7k4psB7B+yI9o
         8qr8BxkHU5qQ1CQ02HOi7nu+uyd3H/qdRHrLR59b/SMd1YEyPeZL02wGdxgGqkTK4X4R
         u1+W7EqQ0H2uwSzSYnk6XWQed2L3wlG9ZGUrWHQzi9Lv5RNSXWP0J7kcfBTTqqI8b9nW
         cdybaEHydFip9fs18QFjGJy4meEqkGHuatewERqxXYOrNPSozG7sbYScxr09pYHcBLkv
         QHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4P3hGirTB2owYm/w+1/cGwpAo3wz4jLRC9Qqa39uRfM=;
        b=meoymvsjw9RBjyFSkCFNa5q9ZFXF+1PzfLKhijMlKS90DQE9hmEhl8ovXj4Z7W1kve
         xqX3ko6w1L2ZZzDxx2gqRrnjsD2mOToVZ4Xrq8fmFnmKGumYbnyyEnXKRintsKmI+cd/
         rlFP80V1cW9ta4Kk7ahSzZrVG7a2OJelTQOi0ufwK6Zc2kTA/yef8SWaFpDhBxeA/2N1
         s+NFDtU3rE3P8FyszMCFun/fSPaXvCd1jYGUBZ4TjFWrvf11tA33E3aLAECBIYwlqoSD
         xg3GQmuNx4wIPhL+XwDF0OwNSs+hQRV1aQtk4ErvIMQSFHomG933GfkSTUlpoqtyfA1K
         VyRw==
X-Gm-Message-State: APjAAAVVUIUPP1jQioe+7A5FuYjrgm3FacB+rKSMh+HAn91xkeZwYU9G
        a1JjODcjkg677ERXli96WpfKKzvm
X-Google-Smtp-Source: APXvYqz1XYXLzWpa9oD68pVf3q1uA3WNb9akyHAzmNuzFwAOyOu8SiM7j+1ObtDeSd+PLxPD98GXoA==
X-Received: by 2002:a63:63c3:: with SMTP id x186mr56434308pgb.294.1579461074232;
        Sun, 19 Jan 2020 11:11:14 -0800 (PST)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id g22sm34214403pgk.85.2020.01.19.11.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 11:11:13 -0800 (PST)
Date:   Sun, 19 Jan 2020 20:10:47 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     linux-nfs@vger.kernel.org, Steve Dickson <SteveD@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>
Subject: Re: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler
 costraint
Message-ID: <20200119191047.GB11432@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> Currently locktest can be built only for host because CC_FOR_BUILD is
> specified as CC, but this leads to build failure when passing CFLAGS not
> available on host gcc(i.e. -mlongcalls) and most of all locktest would
> be available on target systems the same way as rpcgen etc. So remove CC
> and LIBTOOL assignments.

> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Tested-by: Petr Vorel <petr.vorel@gmail.com>
NOTE: as I understand it's a compilation issue of a tool, so I didn't run
rpcgen, I just test various compilation variants for buildroot.

Kind regards,
Petr

> ---
>  tools/locktest/Makefile.am | 3 ---
>  1 file changed, 3 deletions(-)

> diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
> index 3156815d..e8914655 100644
> --- a/tools/locktest/Makefile.am
> +++ b/tools/locktest/Makefile.am
> @@ -1,8 +1,5 @@
>  ## Process this file with automake to produce Makefile.in

> -CC=$(CC_FOR_BUILD)
> -LIBTOOL = @LIBTOOL@ --tag=CC
> -
>  noinst_PROGRAMS = testlk
>  testlk_SOURCES = testlk.c
>  testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
