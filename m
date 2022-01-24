Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65FB499BFC
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 23:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiAXV6j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 16:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448495AbiAXVM6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 16:12:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AB0C06E006
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jan 2022 12:10:45 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j23so53501334edp.5
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jan 2022 12:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzfolGDrA4UCfRfVV5gIE3fyq2mpnZXd452vGMghDqc=;
        b=XkE2cgE+qsyCE/zqYuNAsWe72Dud7/bAOyVpUpRjSGKjRI4rDSzy3X7MDBjldUzXcz
         z4Dkc5/BAtKqBXTMxuScYhcq75RHt+9U/nx6WVTSb0WPQzk81tU5DYaS/xepwFH1Lsjx
         xYOiT6IcdS9qU7bhV41Egmkvg5dLv3LGrxPP9WO+bLI2hnZHdoFq64QIya2cotDTSFHm
         +bKic/jYkcXEq57fNMlaIKct2ZWatm5gkzqr5PScu9ioSCtfcB6B/n9v72kPDU+TqyVI
         ChLygEM7YGNYNI807VMAs72+Q02O//0nnwIxvAUfKMXUkKWeqPYuWtDNIN3p7AuWrouc
         +K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzfolGDrA4UCfRfVV5gIE3fyq2mpnZXd452vGMghDqc=;
        b=SXw0DgZfmJfWedsz4+HkLW18Qw++5toXJln7Tiy9SpXKiPw2amd2YmIkOC57o18zmC
         TeKVMFjFj1v3F2XGgn3d5oFwM3zPnWj4+xS7EEA5Hqd+ydOolLOgypLgok2I0OtrztMa
         iv6J6bI7HPAlipDWBG3eOVWoB8Hi7759F07VM6LawjK/AGC+YO8RF8l6CSMa1nu5ek+d
         wWDzjp8vnbl5aQWd8Ecl4YEXoDyfAnbwz88c06U7DuAOI6v9kMKC8sc9x5wpUC+z4rRx
         Qt9SSqVR+Dm4DrwyXJrmfZxo7vl7Z5lRZHQCyoIZ2pNtlaMgyHPi8xMDXH8DSY+pZgAO
         pI6Q==
X-Gm-Message-State: AOAM532fCnMBJe5PflB9Ypft0qKfax0MrBWtIGQmqNCPLcAFykc2MOcD
        GLMTgaAOXA4h2i3xPPLD81Ev5Ht7ZADcEYJDc8rUeHR8Ya0EPA==
X-Google-Smtp-Source: ABdhPJwBnL1rS/c9MloYXr70O/0MSuDyRhAvMOv9p0weMLLcQRMoQd/lVnt9Le+1bbOFeLJPLJWE/x+TGBt+ybjnBzw=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr6048555edd.61.1643055043519;
 Mon, 24 Jan 2022 12:10:43 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
In-Reply-To: <20220124193759.GA4975@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 24 Jan 2022 20:10:07 +0000
Message-ID: <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 24 Jan 2022 at 19:38, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Sun, Jan 23, 2022 at 11:53:08PM +0000, Daire Byrne wrote:
> > I've been experimenting a bit more with high latency NFSv4.2 (200ms).
> > I've noticed a difference between the file creation rates when you
> > have parallel processes running against a single client mount creating
> > files in multiple directories compared to in one shared directory.
>
> The Linux VFS requires an exclusive lock on the directory while you're
> creating a file.

Right. So when I mounted the same server/dir multiple times using
namespaces, all I was really doing was making the VFS *think* I wanted
locks on different directories even though the remote server directory
was actually the same?

> So, if L is the time in seconds required to create a single file, you're
> never going to be able to create more than 1/L files per second, because
> there's no parallelism.

And things like directory delegations can't help with this kind of
workload? You can't batch directories locks or file creates I guess.

> So, it's not surprising you'd get a higher rate when creating in
> multiple directories.
>
> Also, that lock's taken on both client and server.  So it makes sense
> that you might get a little more parallelism from multiple clients.
>
> So the usual advice is just to try to get that latency number as low as
> possible, by using a low-latency network and storage that can commit
> very quickly.  (An NFS server isn't permitted to reply to the RPC
> creating the new file until the new file actually hits stable storage.)
>
> Are you really seeing 200ms in production?

Yea, it's just a (crazy) test for now. This is the latency between two
of our offices. Running batch jobs over this kind of latency with a
NFS re-export server doing all the caching works surprisingly well.

It's just these file creations that's the deal breaker. A batch job
might create 100,000+ files in a single directory across many clients.

Maybe many containerised re-export servers in round-robin with a
common cache is the only way to get more directory locks and file
creates in flight at the same time.

Cheers,

Daire
