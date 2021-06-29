Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2B63B7366
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 15:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhF2Noa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 09:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbhF2Noa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 09:44:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C2C061760
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 06:42:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t3so9823578edt.12
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDx/bqcRYl+A0B4p2ELXuVZNad5CSbPLu2bfOHsDfFw=;
        b=n40B3frrLNlfVgjeja52COBRii8wD1Ks2CNRSyG0ixDVQGhNHQDmhbUE+zzaGX9Gnj
         bb1SMjD0fm7kOkGb10Sv9LO6uVSKjChGnP+0oYlm7MThD6qSCC+bVjzSXyRS/WKOBXY6
         r7ny2afxrx5D14aSPZpjb5GFVFobvnhy6QvcDkeiOvoGahMboZWLx5kbyQfyOAlrb10j
         aRU2E/6Fcf2VOWlDfH3WH4NbrOynIeSWqRj/H/7H1F+Yw9bE1t2nAudIQtvywkmQRAxM
         PnxvMVQJLO1dHzgrK8LHUuwWDhkAPrijmzYcLRQ+pswNbBV5VFBtJtcn5EKaY15y0Y93
         +r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDx/bqcRYl+A0B4p2ELXuVZNad5CSbPLu2bfOHsDfFw=;
        b=NbZzl7/VKVx8TJoL0qytjz0zwFgvYH3x70xhkjBPZrfnq9AFUIKjNrO/rais6kfK31
         cO5jKQUI76O07btBYOY4C5Ylym1gPvyP+Fe+/5VFmsMNs6rIsD3PSQfIQ6Rg10vxRGrA
         D8Pe4HHtCiJf9ZbsdRzWfu6pQhZryTVOFGAHuiIWI4JKUMtmft9wYr9JX/RbePCTCXZD
         8BsQGOqALEPaaiB9elskdZk/7I4wLfEsVjokcKB5EqfrRsbhxccBIdmQiNKApBUUvoNl
         nmGjPohHMM04TLFBRZ109wp/3PHiSkpzXdEaPkJEx3l8EgIB+rndp0FmEPPbhGrlIZam
         kP1Q==
X-Gm-Message-State: AOAM531evGXViH8ENiC/ZXMOQXh/fkuNdk8m+WKJ/5eceTdVQXibGN8v
        UlpRKmvB7J1iNMdn9g6N2FpVzCiPafrzoxJqZitKgw8ByaA=
X-Google-Smtp-Source: ABdhPJz8Lp7Lno/iLHG82EpRm+4dfMVYQadyXqq1Jnrrpecs6UcjZUPZ6uCnrbb9H32J1OcrHizjXJZLIvW9lJZHfQE=
X-Received: by 2002:aa7:c614:: with SMTP id h20mr40343235edq.67.1624974121123;
 Tue, 29 Jun 2021 06:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
 <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
In-Reply-To: <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 29 Jun 2021 09:41:49 -0400
Message-ID: <CAN-5tyHTavHRmQKGhUmBvngMwAAK2pr89zBuppK_s27HduJfqQ@mail.gmail.com>
Subject: Re: client's caching of server-side capabilities
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 28, 2021 at 6:06 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2021-06-28 at 16:23 -0400, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > I have a general question of why the client doesn't throw away the
> > cached server's capabilities on server reboot. Say a client mounted a
> > server when the server didn't support security_labels, then the
> > server
> > was rebooted and support was enabled. Client re-establishes its
> > clientid/session, recovers state, but assumes all the old
> > capabilities
> > apply. A remount is required to clear old/find new capabilities. The
> > opposite is true that a capability could be removed (but I'm assuming
> > that's a less practical example).
> >
> > I'm curious what are the problems of clearing server capabilities and
> > rediscovering them on reboot? Is it because a local filesystem could
> > never have its attributes changed and thus a network file system
> > can't
> > either?
> >
> > Thank you.
>
> In my opinion, the client should aim for the absolute minimum overhead
> on a server reboot. The goal should be to recover state and get I/O
> started again as quickly as possible. Detection of new features, etc
> can wait until the client needs to restart.

Do I interpret this correctly: no capability discoveries before
RECLAIM_COMPLETE but perhaps after? I agree that reboot recovery
should be done as quickly as possible. If it's some time after, then
perhaps it can be done on-demand thru say nfs sysfs api: have ability
to clear current capabilities (or a specific one) and do discover new
ones?

The use case I'm going for is when a server upgrades and comes up with
support for new features. Currently, it requires a client re-mount.
But perhaps requiring "mount -o remount" in that case isn't any
different than requiring use of sysfs.

Thank you for the feedback.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
