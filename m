Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB40C277849
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Sep 2020 20:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgIXSMS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Sep 2020 14:12:18 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:39004 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgIXSMS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Sep 2020 14:12:18 -0400
Received: by mail-ej1-f66.google.com with SMTP id p9so56532ejf.6;
        Thu, 24 Sep 2020 11:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYnG1iB/+VP+FnkQe6ynNkYbfPZIYv55Z7D7cKAuirY=;
        b=nYyExDxIBdfBWPZBrYFvktXWcP8Gums6YulqAl8cmVVK5Qp27WhXZXJSKPW3z3FK1m
         cl4jMPl3JqJdaCySfS7KMvKljFovIa/9qwVGKEWR+gwJHjbU+XWNAni4BaxJPz+DFV8a
         fbXIVsqEykelHuNiWn/Lj/YP/bSCeIUkPwAElRyn2aBC9DJiev2n5y8IfbQD2/9pi0JW
         evWt7PhW3oA/9cJ8KUzAZw2gpcJmZalYwolJKp5h0N9TwCOSk71gfSl/JN3Hd6wKJuri
         USUlDwhtwkPqqBm+5TO0cOuRBE8t5xO0Mf8jngs9bk/LJ2S0pW2i1wdKQtWSZfkCSDdS
         MzyQ==
X-Gm-Message-State: AOAM5312LUtUj9eyDm+Ia5eR2377VJjNsDUofRwPGZGM51UbjT7SW088
        P4tl36yT237KjrYpXbrLytumEsUBl5w/FoBvyfs=
X-Google-Smtp-Source: ABdhPJw67mpl4dPMlAO1h8sE0XUiFW3whFNOiXv35kQ7e9FvFvRFzpydTz05AWmonaMCaNWULt2WFCCx3wSUH4FraZk=
X-Received: by 2002:a17:906:2dc1:: with SMTP id h1mr1214182eji.436.1600971135945;
 Thu, 24 Sep 2020 11:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com>
 <20200917214545.199463-1-ndesaulniers@google.com> <CAKwvOdnziDJbRAP77K+V885SCuORfV4SmHDnSLUxhUGSSLMq_Q@mail.gmail.com>
 <ca629208707903da56823dd57540d677df2da283.camel@perches.com> <734165bbee434a920f074940624bcef01fcd9d60.camel@perches.com>
In-Reply-To: <734165bbee434a920f074940624bcef01fcd9d60.camel@perches.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Thu, 24 Sep 2020 14:11:59 -0400
Message-ID: <CAFX2Jf=JjVOjDKj_rpst35a+fqbiq4OpVFjztaeKcbTSNapnCg@mail.gmail.com>
Subject: Re: [PATCH v3] nfs: remove incorrect fallthrough label
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 24, 2020 at 2:08 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-09-24 at 10:40 -0700, Joe Perches wrote:
> > On Thu, 2020-09-24 at 10:19 -0700, Nick Desaulniers wrote:
> > > Hello maintainers,
> > > Would you mind please picking up this patch?  KernelCI has been
> > > erroring for over a week without it.
> >
> > As it's trivial and necessary, why not go through Linus directly?
> []
> > Fixes: 2a1390c95a69 ("nfs: Convert to use the preferred fallthrough macro")
>
> Real reason why not:
>

I'm planning to take this patch through the NFS tree for 5.10 (along
with the patch that apparently causes the problem). I didn't think it
was urgent so I haven't gotten around to pushing it out yet, but I'll
do so in the next few hours.

Anna

> the commit to be fixed is not in Linus' tree.
>
> > https://lore.kernel.org/patchwork/patch/1307549/
>
>
