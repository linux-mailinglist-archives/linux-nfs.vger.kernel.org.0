Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47409781443
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 22:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379938AbjHRUWA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 16:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379989AbjHRUVq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 16:21:46 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360143C0A;
        Fri, 18 Aug 2023 13:21:42 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso1297711276.2;
        Fri, 18 Aug 2023 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692390101; x=1692994901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckMx0GzHv6afUT17KDGKJnIyPhWh0zj4xXItwrivPBw=;
        b=FSkiCPOCp4/5CbAgbmbVTexVsPrCIIaCutZukIcdN1O/LkXMp5P3hYwduwLv46yw2T
         Lo+Z81taycnFhg7bk48pHDyN6rmrQgkMxyOgsh0uIkt8xfEhUXrGLFvIKKg45CvvaEDx
         c35a3EH8vmisRRmkGkykOMvqQCvSH9sJ0EeAiTbXIhtLCECDu3eoKoY3MC3gEZEKxf0w
         23siUUNq74GumjM4FQ9f/LvlhuLt0+aWgyYleQrXGQa1Q8WMo+bD0mlO4evxmB8TdGzV
         N+RP/bl1FGrP6k6OOE7G/OQu86d4Us0sqyo70hLWhp4z20qJBYv7r8tu+T2L2Hdlu6cL
         NQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692390101; x=1692994901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckMx0GzHv6afUT17KDGKJnIyPhWh0zj4xXItwrivPBw=;
        b=Z6JE/eLiA4SyRHd//KpEC+Yg1SN9Gp2I9K24TXAGQlCIVnYfyPbfBXQvmYzKbYiSya
         5jUemaHnFziP15FLkKVwvVUoK7S4tjEnpqFPgN/AaKgql3GPdF7q8VtBl/a1c1DY526c
         NXaVXk11piwSZ0Uu5f3IEq+4hUas4mkw75jVU0JuxAecLwkq199QGLpwtPFNawArPPl9
         rw+p1j/TB5aE/W2DORwyyEg78dWvkObP2lcU7OdA1/g/EO8dC3fkvWmc9zKeaxli1C7A
         yNyzUf1ffvXVQf0sc6hDgdrYpb+7qSo6q0XbEhxu+avgn60/miYiq9uk5VMxZaLFNl9F
         kqjQ==
X-Gm-Message-State: AOJu0YzHyxtnZvTSv2Pl6qUw8MVsuy2cVLdKaz81C/SWwm9ZcbdFhM9A
        gOe+7Cu1I2vALQWbROA8JWMIDiygI66DCKziqh8=
X-Google-Smtp-Source: AGHT+IGARNiDZtNa9WVHJDluHs687VwqxIfDuAkZaOVeAUB+WS1qjmTiz4QcLSPnyiAFNCKdg+ixKJu9lCD4fBNg7o4=
X-Received: by 2002:a25:c58b:0:b0:d72:8661:ee26 with SMTP id
 v133-20020a25c58b000000b00d728661ee26mr333047ybe.4.1692390101183; Fri, 18 Aug
 2023 13:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230818041740.gonna.513-kees@kernel.org> <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
 <202308181131.045F806@keescook>
In-Reply-To: <202308181131.045F806@keescook>
From:   David Windsor <dwindsor@gmail.com>
Date:   Fri, 18 Aug 2023 16:21:30 -0400
Message-ID: <CAEXv5_h4T38JSMxQd7Px3MrgqOyBsDDSMh8Q=Wr8Tu7=TBvG1Q@mail.gmail.com>
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Given this, I have no idea why this discussion is even being continued
further. These features have more than justified themselves. Shall we
speculate what may have happened had these self-protections not been
present? Of course not.

Also, with respect to a switch for turning this off, nobody is going
to want it. If they haven't yet requested it (this feature has been in
mainline for years), I seriously doubt anyone will care.


On Fri, Aug 18, 2023 at 2:46=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, Aug 18, 2023 at 10:55:42AM -0700, Andrew Morton wrote:
> > On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wr=
ote:
> >
> > > From: Elena Reshetova <elena.reshetova@intel.com>
> > >
> > > atomic_t variables are currently used to implement reference counters
> > > with the following properties:
> > >  - counter is initialized to 1 using atomic_set()
> > >  - a resource is freed upon counter reaching zero
> > >  - once counter reaches zero, its further
> > >    increments aren't allowed
> > >  - counter schema uses basic atomic operations
> > >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > >
> > > Such atomic variables should be converted to a newly provided
> > > refcount_t type and API that prevents accidental counter overflows an=
d
> > > underflows. This is important since overflows and underflows can lead
> > > to use-after-free situation and be exploitable.
> >
> > ie, if we have bugs which we have no reason to believe presently exist,
> > let's bloat and slow down the kernel just in case we add some in the
> > future?  Or something like that.  dangnabbit, that refcount_t.
> >
> > x86_64 defconfig:
> >
> > before:
> >    text          data     bss     dec     hex filename
> >    3869           552       8    4429    114d kernel/cred.o
> >    6140           724      16    6880    1ae0 net/sunrpc/auth.o
> >
> > after:
> >    text          data     bss     dec     hex filename
> >    4573           552       8    5133    140d kernel/cred.o
> >    6236           724      16    6976    1b40 net/sunrpc/auth.o
> >
> >
> > Please explain, in a non handwavy and non cargoculty fashion why this
> > speed and space cost is justified.
>
> Since it's introduction, refcount_t has found a lot of bugs. This is easy
> to see even with a simplistic review of commits:
>
> $ git log --date=3Dshort --pretty=3D'format:%ad %C(auto)%h ("%s")' \
>           --grep 'refcount_t:' | \
>   cut -d- -f1 | sort | uniq -c
>       1 2016
>      15 2017
>       9 2018
>      23 2019
>      24 2020
>      18 2021
>      24 2022
>      10 2023
>
> It's not really tapering off, either. All of these would have been silent
> memory corruptions, etc. In the face of _what_ is being protected,
> "cred" is pretty important for enforcing security boundaries, etc,
> so having it still not protected is a weird choice we've implicitly
> made. Given cred code is still seeing changes and novel uses (e.g.
> io_uring), it's not unreasonable to protect it from detectable (and
> _exploitable_) problems.
>
> While the size differences look large in cred.o, it's basically limited
> only to cred.o:
>
>    text    data     bss     dec     hex filename
> 30515570        12255806        17190916        59962292        392f3b4 v=
mlinux.before
> 30517500        12255838        17190916        59964254        392fb5e v=
mlinux.after
>
> And we've even seen performance _improvements_ in some conditions:
> https://lore.kernel.org/lkml/20200615005732.GV12456@shao2-debian/
>
> Looking at confirmed security flaws, exploitable reference counting
> related bugs have dropped significantly. (The CVE database is irritating
> to search, but most recent refcount-related CVEs are due to counts that
> are _not_ using refcount_t.)
>
> I'd rather ask the question, "Why should we _not_ protect cred lifetime
> management?"
>
> -Kees
>
> --
> Kees Cook
