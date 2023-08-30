Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728FF78E0BA
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 22:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjH3UdH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 16:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbjH3Ucw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 16:32:52 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D548784383
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 12:41:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a3b66f350so23137b3a.3
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693424419; x=1694029219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJ79dv+/GxM/jf2YG/dPkW+2mozkrsO7P8K0km3iOCE=;
        b=gx1tURSl0LyZV9Y8MLleD2Y9aTOFVViYnpnrp0zJ+UWXLlR/DXJWqm10iRExVBZJ0D
         g7/9DgiDKcuh7efQbDgDkBlfKFygsQFQwJMUYCh4bHsNl0oEIYc1I/kqjFjXu4KqL4jy
         VjAiHxV/lZSxNmPv+OWq70V3snqpahZ/19Mm1xjW517IctQSZTCcW6hOXFlCaQ4vLtm9
         wtHdvvFE2sBPwwqAweSAdDcC2x/qBOFozEPa1x/12OJIPmivF4znmbctO7GUpw0zW2lX
         h/VGgFexpVSi4drVOMXvTBJmXT5ZM3Jg54iSJd0DOi6Al9A8bZVi4/roAOZ2Xh2rwSbl
         lHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693424419; x=1694029219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJ79dv+/GxM/jf2YG/dPkW+2mozkrsO7P8K0km3iOCE=;
        b=XLwLBYxZb0UUJ+xxuLgBW45qm1H2DdMHGSA9WQ4WgzfD/alpAvZv+yjP9L6RasVT9p
         Gd6dJbJQs+kQeKmwEjLhydGO7Z37rkSSJjrwmAwkPnXfKjJNztshkVIEpYAEbEQNVreX
         8A3VQorzdhiJD+4QolpUXSsQ8i1bFFwFZCtqmdzkQZXifln2egPkpYPFZ6+lSr+hylOR
         xQKScx+bxQk9RuYsee62N6vVvRokkDmeFw25x50H0FyVCtHihUPytQzPJgGug8OYxgce
         KpGk8F/v63NhJIeRrr+eDNX2PnvJBOrEEacqOOfU43/hTwHC1kLsCLQjxRIS2I5S4rGJ
         xzfQ==
X-Gm-Message-State: AOJu0YxG0q9ME2aWXLzdryB6YT1Ev72fLre7vhRyrf4Zxw84TjTiQ9sv
        ksfrgtn+uourC/+dVlF2c3jSJ43apBRH3PszVUn9UvJbdw==
X-Google-Smtp-Source: AGHT+IEcIbj/jEW4g2Fz5et2oFaO1Invi1D0pNKmOSAeZ9aSRAP9vX4+JxsHfBx/tef6uYDMHZAbr7GC07hxAzm5V3M=
X-Received: by 2002:a05:6a20:4284:b0:13a:6bca:7a84 with SMTP id
 o4-20020a056a20428400b0013a6bca7a84mr3987057pzj.44.1693424419098; Wed, 30 Aug
 2023 12:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5tNy7Q63k+9+f9zrctZrm-NzCbYn8OjYSirQ8g+g7yLaK9jQ@mail.gmail.com>
 <CAMa=BDoUS8ny1X+GjDR1hDGg1h9zjtSzet1Rtu8=GwJfsu-kJQ@mail.gmail.com>
 <CAM5tNy6ecGrKToFneMi14MnWP5BhS39kJJpxLCmk4AWgeU6+tg@mail.gmail.com> <B42FE0D6-F3C1-48D1-BE1E-3B09BF0A7FD2@cert.org>
In-Reply-To: <B42FE0D6-F3C1-48D1-BE1E-3B09BF0A7FD2@cert.org>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Wed, 30 Aug 2023 12:40:08 -0700
Message-ID: <CAM5tNy6n8CSoJdsoTiVphLNmcX_NKtid3p1_c036YgoeOp4TnQ@mail.gmail.com>
Subject: Re: [nfsv4] pNFS/Flexfiles testing at Oct. Bakeathon
To:     Chris Inacio <inacio@cert.org>
Cc:     Tom Haynes <loghyr@gmail.com>, NFSv4 <nfsv4@ietf.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 29, 2023 at 6:24=E2=80=AFPM Chris Inacio <inacio@cert.org> wrot=
e:
>
> >
> >>
> >> My clients will also have the implementations, normally they only talk=
 to my server, but I can bring a standalone client for testing.
> > The FreeBSD pNFS server never issues delegations, so delstid wouldn't
> > really apply.
> > (The non-pNFS server does do delegations. Is delstid generic enough
> > that a non-pNFS
> > server should do it?)
> >
>
> [ci] For the noobs in the audience, if you don=E2=80=99 t mind, why doesn=
=E2=80=99t FreeBSD ever offer delegations?  (I=E2=80=99m getting just smart=
 enough to be a bit dangerous.  Give me a few more months and I=E2=80=99ll =
really be able to ruin something=E2=80=A6)
Good question, although I am not sure I have a good answer...
First off, implementing delegations isn't easy and for a long time
the FreeBSD server probably had bugs. (Delegations are more difficult
for NFSv4.0, since the server cannot easily determine if the client RPC
is from the client that holds the delegation.)
In my opinion, delegations can do two things:
1 - Allow a file to be Open'd locally in the client. For the FreeBSD client
     this has never seemed very useful, since apps. do not normally
      open/close/open/close... the same file.
2 - Allow for improved caching. I actually have a very bit rotted patch
     that did extensive file caching on non-volatile storage (the whole
     file for small files) when it held a delegation for the file.
     This code was never completed, so the effects of a delegation
     on caching in the FreeBSD client is minimal.
Without #2, I do not think delegations are worth the complexity/effort
to do them.  As such, the FreeBSD server does not have them enabled
by default (they can be anabled via a tunable). Historically this was
because of bugs/interoperability problems. More recently, mostly just
do not seem useful.

For the specific case of the pNFS server (which almost no one uses),
a problem was detected at a Bakeathon last year. The client was one
that I do not normally get to test against. The problem was related to
file removal when a delegation was issued to the client (I think it was
4.0, but cannot remember for sure?).
--> I cannot recall the details, but the only obvious fix where there was
     time to test during the Bakeathon was disabling delegations.
     --> As such, I just made the tunable to enable delegations not
          usable for the pNFS server case.
(My vague recollection was that the problem was vaguely similar to
 the Linux knfsd problem for a 4.0 client with a write delegation, in that
 it was difficult to both recall the delegation and remove the data on the =
DS
 correctly. But, I'll admit I cannot recall exactly what it was.)

rick
ps: It does offer delegations for the non-pNFS server if the tunable is use=
d
      to turn them on.

>
>
> > The only other one I recall is the LayoutReturn with an error after the=
 MDS
> > reboot. Not something we'd want to test at the Bakeathon, I'd guess?
> >
> > Thanks for the info, rick
> >
> >>
> >> Tom
>
