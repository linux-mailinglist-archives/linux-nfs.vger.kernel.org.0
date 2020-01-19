Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E94141FA2
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jan 2020 19:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgASSpZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Jan 2020 13:45:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33559 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbgASSpZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Jan 2020 13:45:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id z16so14651834pfk.0
        for <linux-nfs@vger.kernel.org>; Sun, 19 Jan 2020 10:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aWBr8l+L4UosfWP9L5d63U48+ZImuFUZVGlkn+qOt6I=;
        b=pXWBmJae0o+kxTv3CrnwL5a2xbIiy9StEvoVq51OedK1twwxPbKG5zqMAvmYGIzmDM
         czJNyadYShdpQAiyHxZSnHJwMP775rqra7pPLJ9o23LGtWtdoWDfaBX3POdXZ4cnDrWU
         HuiT0HyBKWtxDpQw6gfGSdvyKLig2u1H9WN508WAtzHAHQx4DCUK1yI4U6kk8xrYIIC6
         uKkeJeyeJM6JE3Rcfm/P30xUD27ELcB9yrDOXjbDUNxNZU4gMy6LVEnh/r21vjV6NIyi
         3exSb+fv4bt4/Vx6Z+OsANlUjSZxYCcsE1SP4Lpy2hkFhBklWe5kCgCw8ZWa9jp2q9UT
         KbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aWBr8l+L4UosfWP9L5d63U48+ZImuFUZVGlkn+qOt6I=;
        b=aw3hD6tqO0+jB3kXyo4kxbGUlB3EfuU3kjR8+SeAjwRrgDZXMXwICaVVdx3IdGAi19
         vBQvQUtNFeWAxZEOlL6DZw4odn7lk3UqoD9VStbAgP338yLYfElk4LQYOgFvq0sg0kbc
         8Ygo1ORQ71XUz77daJaANlMG/eFS2sydOANauZGzaB8kcc2m3lSFpB52HKyDGUFPz/Zl
         JJvweXvEw3AxZozXwxfFcgOvrXMkFytwe0qcbovo7qLYXvXeG8BpqDV197uQZX7ysFif
         JGVKqycAdj67b1Bs5gF4f0rT/rs81NXwXe0nAUBptgWix8uEp7alEzaTzMtAPCqkxrGw
         ZXHw==
X-Gm-Message-State: APjAAAVsGbJ3r4KfhgV1kkC8L2cM0QUFS17RXI1DfNriewytZ0PVHKih
        Yc23JuvwQjwu5Q928l97NllcWpjF
X-Google-Smtp-Source: APXvYqykgHRaCm1w0bw5ZF0W6RAQ1hOck+FBDqCmH29I03Cie22Dp7BGOSIWKJQRAylW4Qur9TiEAQ==
X-Received: by 2002:a65:640e:: with SMTP id a14mr51970465pgv.402.1579459524757;
        Sun, 19 Jan 2020 10:45:24 -0800 (PST)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id n24sm36383494pff.12.2020.01.19.10.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 10:45:24 -0800 (PST)
Date:   Sun, 19 Jan 2020 19:45:01 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>
Subject: Re: [nfs-utils PATCH 0/3] bump rpcgen version and silence some
 warning
Message-ID: <20200119184501.GA11432@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
 <30b28d4e-71a5-f412-23e7-877a4eff17bd@RedHat.com>
 <fdbade7a-f8f6-16b1-1a18-e9742b9a0aa0@benettiengineering.com>
 <6fdcbba5-e965-fe69-569b-7f32005ce1bf@benettiengineering.com>
 <c1e96762-0f3a-b465-da1b-f7bc7a687948@RedHat.com>
 <20200117063032.GA6351@dell5510>
 <818c66c5-6f8b-927f-229e-52a00f50c682@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <818c66c5-6f8b-927f-229e-52a00f50c682@RedHat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

> On 1/17/20 1:30 AM, Petr Vorel wrote:
> >>> If you have the chance to commit before releasing version it would be great!
> >> Your patch on my radar... but... conflicts  with Petr's cross-compilation patch
> >> https://lore.kernel.org/linux-nfs/20200114183603.GA24556@dell5510/T/#t

> >> That patch causes an automake warnings which is something I'm trying to avoid.

> >> No worries... I will not do a release w/out your patch.... or something close to it. 

> > Giulio, thanks for your patch. I'll have a look on it over a weekend.
> > Maybe Mike's cross-compilation patch is really not needed.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Tested-by: Petr Vorel <petr.vorel@gmail.com>
NOTE: as I understand it's a compilation issue of a tool, so I didn't run
rpcgen, I just test various compilation variants.

Considering recently merged Giulio's change in tools/rpcgen/Makefile.am
e61775d1 ("rpcgen: bump to latest version") I'm for trying this one.

I tested buildroot compilation of Giulio's changes [1] [2] and it works.
Notable change is to move from nfs-utils' internal rpcgen to external one from system
(replace --with-rpcgen=internal with --with-rpcgen=$(HOST_DIR)/bin/rpcgen in [2]).
IMHO Mike's patch is not needed for buildroot.

@Mike, could you please test it for Gentoo?

Looking at Gentoo package history, all packages [3] [4] [5] use rpcgen from system
(--with-rpcgen). This change was added 2 years ago for, nfs-utils 2.3.x [6];
but Mike's patch was here at least 5 years ago [7], for nfs-utils 1.2.x and
1.3.x (actually sent to ML in 2013-03-25 [8], so for 1.2.x?), so the patch might
not be needed any more since then anyway.

BTW NEWS file for nfs-utils 1.1.0 states that by default use rpcgen from system,
so it looks to me that at the time of Mike's patch needed for Gentoo it was also
using internal rpcgen, but maybe I'm wrong.

Kind regards,
Petr

[1] https://github.com/giuliobenetti/nfs-utils/commit/c45edd7a5d5aa51c735017a7fd4fd89948ad05b2
[2] https://github.com/giuliobenetti/buildroot/commit/e4ae0d0e33e61858701bfe44e9777f7c69584706
[3] https://gitweb.gentoo.org/repo/gentoo.git/tree/net-fs/nfs-utils/nfs-utils-2.3.4.ebuild
[4] https://gitweb.gentoo.org/repo/gentoo.git/tree/net-fs/nfs-utils/nfs-utils-2.4.1-r4.ebuild
[5] https://gitweb.gentoo.org/repo/gentoo.git/tree/net-fs/nfs-utils/nfs-utils-2.4.2-r1.ebuild
[6] https://gitweb.gentoo.org/repo/gentoo.git/commit/net-fs/nfs-utils?id=d3c1580e4b5e583a457055f1a01818269e65459f
[7] https://gitweb.gentoo.org/repo/gentoo.git/commit/net-fs/nfs-utils?id=56bd759df1d0c750a065b8c845e93d5dfa6b549d
[8] https://lore.kernel.org/linux-nfs/1364163668-15490-1-git-send-email-vapier@gentoo.org/
