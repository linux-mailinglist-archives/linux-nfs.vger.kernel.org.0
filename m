Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7853B764D
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 18:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhF2QP3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 12:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhF2QP3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 12:15:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FDAC061760
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 09:13:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hz1so37250576ejc.1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rCEiOG/SIaB4xX1AFO5rZm200DyZepqukCHjS7jGnw=;
        b=K6ckdcKNKI4dUYjVEwL0+hKaLtlMygrCTN9rnQZaCZoZLYP9rkjDEdYwUWW33QQjFo
         D99s9LgFkpfyP5e82gjsT72DfHZ09tCa8ToWxPH2kiRjnJ+M6Fdi10UPoMWYODU2Zrmm
         LgMJyuh0/ixS3PwMj18L1PjIMINv76I9sfo5zwJzrgcwFpE7COXpq1ELGfsm/exYK5wt
         lz4C1bZz2o3uiPGhhLVqqEj7h45SSvypgin+N0f3sUGBYnxvSv/J3hadXN7jDSwW0rhB
         wyRUTVrvTumu5wnyG+1WO+b8cOTXVJu+6VqWlxmECujlS4BKuropRrQsg/ejXDObeu3y
         +pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rCEiOG/SIaB4xX1AFO5rZm200DyZepqukCHjS7jGnw=;
        b=c7TNdHgy8CL17g5W06ukjycYWIIHG5wQtY7o7KiyboiDr87n2LinqK0qAM+Iwms3P9
         /nxQ3Dpr/E4JPeS47wHlAdb89OENJldRVK5k+PKrbwCkb03AEtNZtuwuMIY82T+hfPsd
         aBA+xDGZ9c83BsdBtqzsyU21ashKQtzT27kN8p1ZUFyu24VPTDwgnawX+1JmPWubf6j0
         FFBfuUwT99k7s6m/dBdab3pAenmoPIvlNpdc+HjJGfChBbgP8HaT1FVC26DaP10xl99J
         tJosGTnE7A02SUReSI08tVc4xHgB8AxDOozshejFAWClrrRhMiGjJOXyCHWEtJIsZFgu
         98Ew==
X-Gm-Message-State: AOAM533Br9sYwkVDwi3qO/T5onH+H0B2WFgGQJI3uZycmmttjdsaxArX
        E3yLKPt0Iw7VeQ/G0Cv9nFGg4Ms+I0gX2bOZtFVX+42hev0=
X-Google-Smtp-Source: ABdhPJzBjdI9faVWFaORzSOuEs3XlFLFlkWJK0pEJFc+VcVyk9A/ff0mtImV/0fGbFfzgHOJNdg2BELOdrgBZoZ0lCg=
X-Received: by 2002:a17:906:e256:: with SMTP id gq22mr6112117ejb.248.1624983180417;
 Tue, 29 Jun 2021 09:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
 <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com> <CAN-5tyHTavHRmQKGhUmBvngMwAAK2pr89zBuppK_s27HduJfqQ@mail.gmail.com>
In-Reply-To: <CAN-5tyHTavHRmQKGhUmBvngMwAAK2pr89zBuppK_s27HduJfqQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 29 Jun 2021 12:12:49 -0400
Message-ID: <CAN-5tyHu3BQaCEvwewNEJnwJTiD9oLmYTUKchciP+1HP8v909Q@mail.gmail.com>
Subject: Re: client's caching of server-side capabilities
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 29, 2021 at 9:41 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Mon, Jun 28, 2021 at 6:06 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Mon, 2021-06-28 at 16:23 -0400, Olga Kornievskaia wrote:
> > > Hi folks,
> > >
> > > I have a general question of why the client doesn't throw away the
> > > cached server's capabilities on server reboot. Say a client mounted a
> > > server when the server didn't support security_labels, then the
> > > server
> > > was rebooted and support was enabled. Client re-establishes its
> > > clientid/session, recovers state, but assumes all the old
> > > capabilities
> > > apply. A remount is required to clear old/find new capabilities. The
> > > opposite is true that a capability could be removed (but I'm assuming
> > > that's a less practical example).
> > >
> > > I'm curious what are the problems of clearing server capabilities and
> > > rediscovering them on reboot? Is it because a local filesystem could
> > > never have its attributes changed and thus a network file system
> > > can't
> > > either?
> > >
> > > Thank you.
> >
> > In my opinion, the client should aim for the absolute minimum overhead
> > on a server reboot. The goal should be to recover state and get I/O
> > started again as quickly as possible. Detection of new features, etc
> > can wait until the client needs to restart.
>
> Do I interpret this correctly: no capability discoveries before
> RECLAIM_COMPLETE but perhaps after? I agree that reboot recovery
> should be done as quickly as possible. If it's some time after, then
> perhaps it can be done on-demand thru say nfs sysfs api: have ability
> to clear current capabilities (or a specific one) and do discover new
> ones?
>
> The use case I'm going for is when a server upgrades and comes up with
> support for new features. Currently, it requires a client re-mount.
> But perhaps requiring "mount -o remount" in that case isn't any
> different than requiring use of sysfs.

Actually, I tried to do a "mount -o remount" after taking down the
server and changing its features (ie security label support), and the
client does not query for supported attributes. So I think either at
least perhaps that can be changed somehow or we do need a sysfs api to
be able to change server's capabilities of a given mount.

>
> Thank you for the feedback.
>
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
