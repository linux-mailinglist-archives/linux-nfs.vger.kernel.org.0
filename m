Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2E206F80
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 10:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbgFXIyk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Jun 2020 04:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388531AbgFXIyk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Jun 2020 04:54:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ABAC061573
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2020 01:54:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i3so1716024ljg.3
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2020 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D64RGpvoJv3wbuiqbX7bmIFpkogt9xrNt+h7ZCKkSLI=;
        b=bQcp2wsJ9IFpC2+vgBdPPIaEdlpHk9U8IjDYAkdpUwa+Zmghr2G0gptRu/vN2HtZ9o
         QEN2gWwpdl9MXRq4mPoqAkDYMmyW9wW1easstvUrSQT5hWL9xWEAeb+6INtbysAgNQpF
         EprA7gK+aLoWKcc/dfvVAOmjlvE1xZIhBJCHK6amYr8k9nzzWos2LlcPYyMoIle/OPil
         XDXwSw1FmMqIkJkrGDDoKg78aXIh1dV+s3lBrEWdtlE0fYh4+TWraRRepNmFBjz2Ff6v
         2okU4klR5k2oTKZOmrGmWiOr3jryzNKBrCrcHKQ7w62FzvnIoKFI6/HpG2SdEdNvgL7j
         lD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D64RGpvoJv3wbuiqbX7bmIFpkogt9xrNt+h7ZCKkSLI=;
        b=E4LC0kBgKwYk0w9LxZ8zcejP31nQ4UTHmv7BM3m9VPpiCRdkNigCKdrnnT0xM6eXUf
         BiIk++YaGvn7QL70tjdZ+Dja8TK0TKmY04ZWcOJE6vYEEPsmweniFNb0hsL4Ugvb28iv
         BfcrGYww7KNnElubFao1am0Ty121CKv8rT2BebjMvDaZc/OlhrhmoPpBVy1PCySiCQih
         l6dVV5AfU+i1+O9R/EiztpvBwyXiiEq+gYMcYIdGdJzLgGg5vwqRT6t6sfAMHZg74JvT
         fw665wT8d/zQ5D6UlliYS+OtEoVSBEoF+OLRINDIPttAQefLRzgXFi22N1ME1ayP0U72
         RNpg==
X-Gm-Message-State: AOAM531ojwf/3qjuaxUrEnJEFzMkC+lrLeVdaCh6fnasPe6qBOqOBO3x
        IulUl59wmGL3Lduzr0JprcYNmsrfFcmlRz8b/8Ilm+ZC
X-Google-Smtp-Source: ABdhPJxrsrfGUoCJyMrY8gMMKn9UYaYHjfk0TRG3wJF9PvUcBIqYdMGLnkZu2neNwqzy2PHuvU48XfvxGqsTY/PafUQ=
X-Received: by 2002:a2e:b003:: with SMTP id y3mr13586053ljk.78.1592988877266;
 Wed, 24 Jun 2020 01:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <0aee01d63d91$1f104300$5d30c900$@gmail.com> <7E441550-FCCF-492E-BACB-271A42D4A6C4@oracle.com>
 <119601d63f43$9d55e860$d801b920$@gmail.com>
In-Reply-To: <119601d63f43$9d55e860$d801b920$@gmail.com>
From:   James Pearson <jcpearson@gmail.com>
Date:   Wed, 24 Jun 2020 09:54:26 +0100
Message-ID: <CAK3fRr-cV_0c-sHhA2rMswrHEcLrkNfHs-=ejHRS8-j8zzObhA@mail.gmail.com>
Subject: Re: NFSv4.0: client stuck looping on RENEW + NFSERR_STALE_CLIENTID
To:     Robert Milkowski <rmilkowski@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 10 Jun 2020 at 17:24, Robert Milkowski <rmilkowski@gmail.com> wrote:
>
> >
> > The usual course of action for bugs in distributor kernels is to work
> > directly with the distributor. Upstream developers don't generally have
> > access to or expertise with those code bases. 7.3 is an older kernel,
> > and it's possible that upstream has addressed this issue and CentOS has
> > pulled that fix into a newer release.
> >
>
>
> I was hoping someone here might get back with "hey, this has been fixed by
> commit...".
> We also did see it on centos 7.6
>
> I will try to get it re-produce it and once I can then I'll try to reproduce
> it against upstream.

I haven't been monitoring this list recently - but we are still having
the same problem with CentOS 7.7 clients and Isilon filers

I've just 'fixed' one client with the issue in the way you described
earlier in this thread by looking for a process in nfs4_state_manager
via a stack trace - killing that pid with -9 and all the stuck mount
pops back to life

Have you reported this issue via the Redhat Bugzilla?

Thanks

James Pearson
