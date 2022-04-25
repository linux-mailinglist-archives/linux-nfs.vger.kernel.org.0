Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA0450E458
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Apr 2022 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiDYP2h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Apr 2022 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242843AbiDYP2f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Apr 2022 11:28:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7081D1
        for <linux-nfs@vger.kernel.org>; Mon, 25 Apr 2022 08:25:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w16so9052062ejb.13
        for <linux-nfs@vger.kernel.org>; Mon, 25 Apr 2022 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8yilIeS1cexB/KwWPhxbowiG06wMF7He60cV8jFEKA=;
        b=IzagTh22H2s3sozwKcgqtfSU7WP9t2phi64g2FrnFpBCWoO61TrDaktx2lqKVLfk6O
         q2p7nyKJlVRzDzk2jP6w5x4BuaLstgmzjj3vlWLL2/Yq9xfKma6NFtkZwQV+830V12t7
         9EoztENQ+guRsG12s3zjCOnTLdtOJp69T3oTWSwzcT+ZbOJ/qs4GYliM6bWedDN4/Pvw
         ++oVClhmwd2eBwrh/uqIAKmrYiB74SOZOM7CQFuIn8pN3RWgHkFJhmeDyfuZtVG3P6o3
         Hr9aTobEqfhMpOePbRIKBsgzped3qDTyJfGqvkVfk3HkjVK4rjyvqeeajJ6FGMO5M2et
         3LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8yilIeS1cexB/KwWPhxbowiG06wMF7He60cV8jFEKA=;
        b=S+bLFOO7MKKrVGhWjIYFAmpW5CGcAD5EQSTo3+e0Twue8gnl0bSPnSMcYHv5JanHgJ
         3ZhlXJnntyk031gPEK7ShR8RzTlPGXd+xRum5iqLb6gyPj0JDSOvlvy7Ktyv9ZNm+ZZq
         aih4enjt1efWhR2rSUVfD4dMrVfXQ404mzFd/fgWUQL36Dwi0QSWEZXJ0tYzaN15/jl1
         Y8O8nq3AHygn8BxTmfhMR8VHYBjZgqozGNd/B9dsh38uvf//lyhYFXapB/1lMA6MZLK8
         t0SSqOj01i04IiBu8cI9ah49gPGNyYtY7Jqlk03hcGItN1CDRMj1k13TmXzPX+0yQADJ
         qVJQ==
X-Gm-Message-State: AOAM533z+pSvT3DBu012lvmqscEwwYHI5edIH855jjFvATxz8JtuC83J
        e0NH1RktflAOH1BuPhisNYWqFCkZMdvj9q0oUtekSg==
X-Google-Smtp-Source: ABdhPJwQn3hlw4ZR3pVZVIuvevf+226UiBlg33ZPleIOG+xhoT/24dXH4LVYWEwnl9wMcDyr2ouqLSeh3iF8tlFkTZs=
X-Received: by 2002:a17:906:2991:b0:6cd:ac19:ce34 with SMTP id
 x17-20020a170906299100b006cdac19ce34mr17364775eje.746.1650900326961; Mon, 25
 Apr 2022 08:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220125212055.GB17638@fieldses.org> <164315533676.5493.13243313269022942124@noble.neil.brown.name>
 <20220126025722.GD17638@fieldses.org> <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>
 <20220211155949.GA4941@fieldses.org> <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>
 <164517040900.10228.8956772146017892417@noble.neil.brown.name>
 <CAPt2mGMLQCEPqsYGeaMd3BPGRne4F4h-2-pzqm1a8nwfKqv1ug@mail.gmail.com>
 <CAPt2mGMt3Sq66qmPBeGYE0CASTTy7nY2K_LjQK6VZx-uz2P-wg@mail.gmail.com> <20220425132232.GA24825@fieldses.org>
In-Reply-To: <20220425132232.GA24825@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 25 Apr 2022 16:24:50 +0100
Message-ID: <CAPt2mGMtBH=jzK0cTT7+PTbX-iR-iSx1RmF2beCDxBjXY5sj8A@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.de>, Patrick Goetz <pgoetz@math.utexas.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 25 Apr 2022 at 14:22, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Apr 25, 2022 at 02:00:32PM +0100, Daire Byrne wrote:
> > On Mon, 21 Feb 2022 at 13:59, Daire Byrne <daire@dneg.com> wrote:
> > >
> > > On Fri, 18 Feb 2022 at 07:46, NeilBrown <neilb@suse.de> wrote:
> > > > I've ported it to mainline without much trouble.  I started some simple
> > > > testing (parallel create/delete of the same file) and hit a bug quite
> > > > easily.  I fixed that (eventually) and then tried with more than 1 CPU,
> > > > and hit another bug.  But then it was quitting time.  If I can get rid
> > > > of all the easy to find bugs, I'll post it with a CC to you, and you can
> > > > find some more for me!
> > >
> > > That would be awesome! I have a real world production case for this
> > > and it's a pretty heavy workload. If that doesn't shake out any bugs,
> > > nothing will.
> > >
> > > The only caveat being that it will likely be restricted to NFSv3
> > > testing due to the concurrency limitations with NFSv4.1+ (from the
> > > other thread).
> > >
> > > Daire
> >
> > Just to follow up on this again - I have been using Neil's patch for
> > parallel file creates (thanks!) but I'm a bit confused as to why it
> > doesn't seem to help in my NFS re-export case.
> >
> > With the patch, I can achieve much higher parallel (multi process)
> > creates directly on my re-export server to a high latency remote
> > server mount, but when I re-export that to multiple clients, the
> > aggregate create rate again degrades to that which we might expect
> > either without the patch or if there was only one process creating the
> > files in sequence.
> >
> > My assumption was that the nfsd threads of the re-export server would
> > act as multiple independent processes and it's clients would be spread
> > across them such that they would also benefit from the parallel
> > creates patch on the re-export server. So I expected many clients
> > creating files in the same directory would achieve much higher
> > aggregate performance.
>
> That's the idea.
>
> I've lost track, where's the latest version of Neil's patch?
>
> --b.

The latest is still the one from this thread (with a minor update to
apply it to v5.18-rc):

https://lore.kernel.org/lkml/893053D7-E5DD-43DB-941A-05C10FF5F396@dilger.ca/T/#m922999bf830cacb745f32cc464caf72d5ffa7c2c

My test is something like this:

reexport1 # for x in {1..5000}; do
    echo /srv/server1/touch.$HOSTNAME.$x
done | xargs -n1 -P 200 -iX -t touch X 2>&1 | pv -l -a >|/dev/null

Without the patch this results in 3 creates/s and with the patch it's
~250 creates/s with 200 threads/processes (200ms latency) when run
directly against a remote RHEL8 server (server1).

Then I run something similar to this but simultaneously across 200
clients of the "reexport1" server's re-export of the originating
"server1". I get an aggregate of around 3 creates/s even with the
patch applied to reexport1 (v5.18-rc2) which is suspiciously similar
to the performance without the parallel vfs create patch.

The clients don't run any special kernels or configurations. I have
only tested NFSv3 so far.

Daire
