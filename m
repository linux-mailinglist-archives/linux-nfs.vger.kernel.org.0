Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B7D3BE6BF
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jul 2021 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhGGLAZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 07:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhGGLAZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jul 2021 07:00:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F34CC061574
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jul 2021 03:57:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hc16so2545579ejc.12
        for <linux-nfs@vger.kernel.org>; Wed, 07 Jul 2021 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWTttnrndqcShbxtXvUql7j1vpYXbJXHSqHT4KaBdrw=;
        b=Rr1N5cOxeQXAIgH2qVoy+XUTcL7bMILvyUQ+dYjSQZix/arcIzoSjnuJtu8hBKhnkz
         N8DFiP6yfIUNJt8Ev3/n/xq9xu5AZVbnZrhJAG1UrBdP0Q6ZuSQJ1ZDpJw6EQNFwZQjT
         bHiZxBcbxNMJBj2bVKr998tEX0NI9HHh05EAyS0GxBeRSFYWUHv0EMh8ZCcpbMWq94+S
         nzQjg8l7HZqg2hUoesLPAkOnSNoC8I4EYW+7rRtTKL0xDObOPld5SjfOwVxGg4O70i46
         YmaplkriZBsLSHWRsbxHQNButPiAQte1wAb5Jau06sH37dTQtmprnWIXOu6kWCpbM49D
         R1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWTttnrndqcShbxtXvUql7j1vpYXbJXHSqHT4KaBdrw=;
        b=mLpO5BjGVrAXYJhLVG6uL3J4I0xGeO7Dgz6bmzF/PYyv/RF6zLr1nv15BDjQvs8F38
         ucbSts72Fgyaur3154KasLGl5ZMToHjhOHNoR8KgHkiZAh9Wop26tMaHK+mxqkKYTWsd
         sUwbWxyx7HZsk5s0I/vpN1d4XpJb/Zi7FYPMmEpSHUF8Z6xtFDyKaRaAYaxnxXlf/TYD
         k2g3sHEsL0vhiBwwiRpLLBtF4ku7Cqp7EKyAflqucYYxi27VwM3uTD4v91E4kKBJrKx8
         IgoLHUfWYTywYPh4ix5NgBP4/cEnpq29y8ZF+N7kjyYoLXmkmrqzJ2C3PG3oynLS+sMU
         40AA==
X-Gm-Message-State: AOAM533HWy5F/JWdgBb7Z4I6uTxOb5NzGYeqXJgAIeEZ9JzV8vMIqEBN
        6zspyDr03EVFyJmaPTmmQb0uiaMbzxbgGJPxZDMl4A==
X-Google-Smtp-Source: ABdhPJwRL+eclYFaI2Nux99ylV56zHEVyUuPYSZb0ZpyKJJsV42N7boVIT6e+/Nfr0oFRj49ZUDUFQTRa3Z54RsH8h0=
X-Received: by 2002:a17:907:948a:: with SMTP id dm10mr23296834ejc.200.1625655463731;
 Wed, 07 Jul 2021 03:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>
 <162510089174.7211.449831430943803791@noble.neil.brown.name>
 <CAPt2mGMgCHwvmy2MA4c2E316xVYPiRy4pRdcX4-1EAALfcxz+A@mail.gmail.com>
 <162513954601.3001.5763461156445846045@noble.neil.brown.name>
 <CAPt2mGNCV7Sh0uXA0ihpuSVcecXW=5cMUAfiS0tYr_cTQ0Du8w@mail.gmail.com>
 <162535340922.16506.4184249866230493262@noble.neil.brown.name>
 <CAPt2mGNOMh0uWozi=L5H6X7aKUuh_+-QxJ7OK9e6ELiKnSh1hg@mail.gmail.com> <162562036711.12832.7541413783945987660@noble.neil.brown.name>
In-Reply-To: <162562036711.12832.7541413783945987660@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Wed, 7 Jul 2021 11:57:07 +0100
Message-ID: <CAPt2mGM6mcqM9orzHuyTVgX2pnG5Y7nLeM85tdZ5LoDO9XozBA@mail.gmail.com>
Subject: Re: [PATCH/rfc v2] NFS: introduce NFS namespaces.
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 7 Jul 2021 at 02:12, NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 07 Jul 2021, Daire Byrne wrote:
> > On Sun, 4 Jul 2021 at 00:03, NeilBrown <neilb@suse.de> wrote:
> > > > [  360.481824] ------------[ cut here ]------------
> > > > [  360.483141] kernel BUG at mm/slub.c:4205!
> > >
> > > Thanks for testing!
> > >
> > > It misunderstood the use of kfree_const().  It doesn't work for
> > > constants in modules, only constants in vmlinux.  So I guess you built
> > > nfs as a module.
> > >
> > > This version should fix that.
> > >
> > > Thanks,
> > > NeilBrown
> >
> > Yep, that was the issue and the latest patch certainly helped. I ran a
> > few load tests and everything seemed to be working fine.
> >
> > However, once I tried mounting the same server again using a different
> > namespace, I got a different looking crash under moderate load. I am
> > pretty sure I applied your latest patch correctly, but I'll double
> > check. I should probably remove some of the other patches I have
> > applied too.
> >
> > # mount -o vers=4.2 server:/srv/export /mnt/server1
> > # mount -o vers=4.2,namespace=server2 server:/srv/export /mnt/server2
> >
> > [ 3626.638077] general protection fault, probably for non-canonical
> > address 0x375f656c6966ff00: 0000 [#1] SMP PTI
> > [ 3626.640538] CPU: 9 PID: 12053 Comm: ls Not tainted 5.13.0-1.dneg.x86_64 #1
> > [ 3626.642270] Hardware name: Red Hat dneg, BIOS
> > 1.11.1-4.module_el8.2.0+320+13f867d7 04/01/2014
> > [ 3626.644443] RIP: 0010:__kmalloc_track_caller+0xfa/0x480
> > [ 3626.646138] Code: 65 4c 03 05 28 4d d5 69 49 83 78 10 00 4d 8b 20
> > 0f 84 4c 03 00 00 4d 85 e4 0f 84 43 03 00 00 41 8b 47 28 49 8b 3f 48
> > 8d 4a 01 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 bb 41
> > 8b 47
> > [ 3626.650253] RSP: 0018:ffffaadecf2afb90 EFLAGS: 00010206
> > [ 3626.651747] RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000003d41
> > [ 3626.653479] RDX: 0000000000003d40 RSI: 0000000000000cc0 RDI: 000000000002fbe0
> > [ 3626.655293] RBP: ffffaadecf2afbd0 R08: ffff985aabc6fbe0 R09: ffff985689c76b20
> > [ 3626.657034] R10: ffff9858408a0000 R11: ffff985966e69ec0 R12: 375f656c6966ff00
> > [ 3626.658794] R13: 0000000000000000 R14: 0000000000000cc0 R15: ffff985680042200
>
> The above Code: shows the crash happens at
>
>   2a:*  49 8b 1c 04             mov    (%r12,%rax,1),%rbx               <-- trapping instruction
>
> and %r12 (which should be a memory address) is 375f656c6966ff00, which
> contains ASCII "file_7".
> So my guess is that a file name was copied into a buffer that had
> already been freed.
> This could be caused by a malloc bug somewhere else, but as the crash
> was in readdir code, and shows evidence of a file name, it seems likely
> that the bug is near by.  Do you have patches to anything that works
> with file names?
>
> NeilBrown

I stripped out all my patches so it's just this one on top of 5.13-rc7
and I can still reproduce it.

I can only trigger it by mounting the same export (RHEL7 server) using
two different namespaces and performing a heavy IO benchmark to either
mount (leaving one idle). Part of the benchmark walks thousands of
dirs with files (hence the readdirs).

If I mount the same server twice with no (same) namespaces, even with
the patch applied, it works fine without any crash.

Daire
