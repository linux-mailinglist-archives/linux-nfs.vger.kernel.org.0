Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA450E620
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Apr 2022 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiDYQu7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Apr 2022 12:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243554AbiDYQu7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Apr 2022 12:50:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523E924969
        for <linux-nfs@vger.kernel.org>; Mon, 25 Apr 2022 09:47:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k27so3980459edk.4
        for <linux-nfs@vger.kernel.org>; Mon, 25 Apr 2022 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPzbGzl24JS6dUWQoQTtgRU+KnJivXvjV+kZ1pErbrI=;
        b=YcS2AISBeoNDGJKEP2OCB/e8G6DYcr+s41ur29YKokbKW2NUSPwS7bN45vx/jcGdAR
         cAKBEK+fwNFktAX/pkZ0sVjAfL62LQj+ikXyuFjvUjFwOMjW4dAqkuZmD4cMqnoTdDne
         FdliO4Pd0C8ptGm9inOQu3bPoaghV+fbLUsEHQrTye+UG2AWp3OP3CpViodxgvWaNtVt
         xHm564ZBb0FnSfSmOpeDfrK8ImlYHrSo7GK50VbfH3h67PwkUbnE0CdvRXj4Xg9vAZ0I
         AsLld9Lkva1AUexEv9QiZ7wJEEIlsVQXctCmL29C5PIuNZWBKPpMHL8/ByalY4H3mhxT
         BCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPzbGzl24JS6dUWQoQTtgRU+KnJivXvjV+kZ1pErbrI=;
        b=WezSKsbgtW6yvJSXWsEzdia1UDb6CtKPYU56bwtjNI4w84k5mwSjK2Lc9PKOVELog8
         OOJsxBy1qbex3DksilVe+OOQqCLx6xsVBsJpvhfLbx4Ph8N07d184CYtLxQpwfSG2Yyz
         JWSFVhkxzzKlV5QaO76JAjk3jRCnyT1A8k4wWGScwqzwLJ1j92MBn05QwvFipoM6CpuN
         QkIlyfQPYs3cqocF1bvMLNtHLucj2D15wgR5OEV9ZhAoGDdDrmeJ3HxMZaWXBNA4pIbY
         xnI9X+iS8gwDYjjTYfT0oEDXnY61gKnQKXDPQNBhz0rY28bWVHDkFrSfz7VoSslOpBs2
         10YA==
X-Gm-Message-State: AOAM530vt0uVyDbiB98sVrR+VkUXkgv00OPw8G5C1SMT54cJN5/qOwo/
        HcPM1cXQ3z/i2Uc58TXY+jaRZxEQCcj8wFpU4EM3wAdpyGSJdg==
X-Google-Smtp-Source: ABdhPJyyUzxa6cEepNrif90OGZaJcQYmS5IfblGAojeMCrVfGHbegSoSufDiXyg2m8r+niYNv3tbtaF04/4luZkJZwk=
X-Received: by 2002:a05:6402:3492:b0:423:dfe4:ec43 with SMTP id
 v18-20020a056402349200b00423dfe4ec43mr20375704edc.401.1650905272857; Mon, 25
 Apr 2022 09:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220126025722.GD17638@fieldses.org> <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>
 <20220211155949.GA4941@fieldses.org> <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>
 <164517040900.10228.8956772146017892417@noble.neil.brown.name>
 <CAPt2mGMLQCEPqsYGeaMd3BPGRne4F4h-2-pzqm1a8nwfKqv1ug@mail.gmail.com>
 <CAPt2mGMt3Sq66qmPBeGYE0CASTTy7nY2K_LjQK6VZx-uz2P-wg@mail.gmail.com>
 <20220425132232.GA24825@fieldses.org> <CAPt2mGMtBH=jzK0cTT7+PTbX-iR-iSx1RmF2beCDxBjXY5sj8A@mail.gmail.com>
 <20220425160236.GB24825@fieldses.org>
In-Reply-To: <20220425160236.GB24825@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 25 Apr 2022 17:47:16 +0100
Message-ID: <CAPt2mGPR9c9=rh4p_D7RPo+4S=DgH7VNpqvOKryKsYwaCAtnJA@mail.gmail.com>
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

On Mon, 25 Apr 2022 at 17:02, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Apr 25, 2022 at 04:24:50PM +0100, Daire Byrne wrote:
> > On Mon, 25 Apr 2022 at 14:22, J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Mon, Apr 25, 2022 at 02:00:32PM +0100, Daire Byrne wrote:
> > > > On Mon, 21 Feb 2022 at 13:59, Daire Byrne <daire@dneg.com> wrote:
> > > > >
> > > > > On Fri, 18 Feb 2022 at 07:46, NeilBrown <neilb@suse.de> wrote:
> > > > > > I've ported it to mainline without much trouble.  I started some simple
> > > > > > testing (parallel create/delete of the same file) and hit a bug quite
> > > > > > easily.  I fixed that (eventually) and then tried with more than 1 CPU,
> > > > > > and hit another bug.  But then it was quitting time.  If I can get rid
> > > > > > of all the easy to find bugs, I'll post it with a CC to you, and you can
> > > > > > find some more for me!
> > > > >
> > > > > That would be awesome! I have a real world production case for this
> > > > > and it's a pretty heavy workload. If that doesn't shake out any bugs,
> > > > > nothing will.
> > > > >
> > > > > The only caveat being that it will likely be restricted to NFSv3
> > > > > testing due to the concurrency limitations with NFSv4.1+ (from the
> > > > > other thread).
> > > > >
> > > > > Daire
> > > >
> > > > Just to follow up on this again - I have been using Neil's patch for
> > > > parallel file creates (thanks!) but I'm a bit confused as to why it
> > > > doesn't seem to help in my NFS re-export case.
> > > >
> > > > With the patch, I can achieve much higher parallel (multi process)
> > > > creates directly on my re-export server to a high latency remote
> > > > server mount, but when I re-export that to multiple clients, the
> > > > aggregate create rate again degrades to that which we might expect
> > > > either without the patch or if there was only one process creating the
> > > > files in sequence.
> > > >
> > > > My assumption was that the nfsd threads of the re-export server would
> > > > act as multiple independent processes and it's clients would be spread
> > > > across them such that they would also benefit from the parallel
> > > > creates patch on the re-export server. So I expected many clients
> > > > creating files in the same directory would achieve much higher
> > > > aggregate performance.
> > >
> > > That's the idea.
> > >
> > > I've lost track, where's the latest version of Neil's patch?
> > >
> > > --b.
> >
> > The latest is still the one from this thread (with a minor update to
> > apply it to v5.18-rc):
> >
> > https://lore.kernel.org/lkml/893053D7-E5DD-43DB-941A-05C10FF5F396@dilger.ca/T/#m922999bf830cacb745f32cc464caf72d5ffa7c2c
>
> Thanks!
>
> I haven't really tried to understand that patch--but just looking at the
> diffstat, it doesn't touch fs/nfsd/.  And nfsd calls into the vfs only
> after it locks the parent.  So nfsd is probably still using
> the old behavior, where local callers are using the new (parallel)
> behavior.
>
> So I bet what you're seeing is expected, and all that's needed is some
> updates to fs/nfsd/vfs.c to reflect whatever Neil did in fs/namei.c.
>
> --b.

Ah right, that would explain it then - thanks. I just naively assumed
that nfsd would pass straight into the VFS and rely on those locks.

I'll stare at fs/nfsd/vfs.c for a bit but I probably lack the
expertise to make it work.

It's also not entirely clear that this parallel creates RFC patch will
ever make it into mainline?

Daire


> > My test is something like this:
> >
> > reexport1 # for x in {1..5000}; do
> >     echo /srv/server1/touch.$HOSTNAME.$x
> > done | xargs -n1 -P 200 -iX -t touch X 2>&1 | pv -l -a >|/dev/null
> >
> > Without the patch this results in 3 creates/s and with the patch it's
> > ~250 creates/s with 200 threads/processes (200ms latency) when run
> > directly against a remote RHEL8 server (server1).
> >
> > Then I run something similar to this but simultaneously across 200
> > clients of the "reexport1" server's re-export of the originating
> > "server1". I get an aggregate of around 3 creates/s even with the
> > patch applied to reexport1 (v5.18-rc2) which is suspiciously similar
> > to the performance without the parallel vfs create patch.
> >
> > The clients don't run any special kernels or configurations. I have
> > only tested NFSv3 so far.
