Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094314A6142
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Feb 2022 17:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbiBAQTv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Feb 2022 11:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiBAQTu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Feb 2022 11:19:50 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE36C061714
        for <linux-nfs@vger.kernel.org>; Tue,  1 Feb 2022 08:19:50 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jx6so56219728ejb.0
        for <linux-nfs@vger.kernel.org>; Tue, 01 Feb 2022 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/EA0AhkWiFaOwwty7mH2hCCiTOvQntxOFT+Uv9r6mI=;
        b=lmzPqOHdxn0hc7dFBLY3SQkUuN8/E5zgkhWuFYNNCZY80fRqKvZZiHLjCZFSELf5wt
         fBfAaoq3b5L6sfZamRJ4r9as5w9m2yn2x5kjVQH91u5qzkU4B0X3l8pb4YSIgvY2YQoU
         hLYOHsig6gFhE8uLZXKQjCQGUZdYl3Z4dWDXS94KelY+TVFaf6ZQT+FTU8h0b8OgyVSF
         +vMc/E1jLaqNPkoLezOjgnDMC9VeuCZPuSrCLTTlT2tOaNLt4ZbNIDH7tRFJJF+KWag/
         wG5J3E4/omZOqv7+krqB1k+rt7bzjHGeCvrcOEBpozUkZsDcRNHQwrGH26s3VqMOjExc
         cGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/EA0AhkWiFaOwwty7mH2hCCiTOvQntxOFT+Uv9r6mI=;
        b=mQj2wdfKbjGCcWPmCQbm2fCZ+FvMecvu9gZ0Gv2r9GSBSLyaK9we3Q5ojpu2RoK5L5
         Vm9CIy84kOHzSwhgbSL/28bKMKtar2wo1q5Psml4VrN+pvEDGIeFe6BK95OBw9CqObCx
         qCP6NvYsaKVK6Hnj6PHSb/TEPq3NmO4KoKJqItjIRBrWTaKhCs/XHGr2NW6TgDuRrb+h
         ICxiz7I9WMWRtJjveA7DVSDhLP2RvpJ82+dwkjL8WEqKuX/ONh9O0Ly6Rs/kSZGKxCP3
         YFpwfsNewpBGQuwoDW+nwzP96fb/QSNlzS9BHh9yqMrZMVDrgWFvWvsdtB92UceZ9hLN
         yMDg==
X-Gm-Message-State: AOAM532i17v1tLxeijSchZ/3WHrnCxlgBl3K+B3aM5uywKnq7qz7wLBe
        RrM6DlusvIXt3R/+B4t5WxKNXxpbkJY+XeI25Ftl
X-Google-Smtp-Source: ABdhPJyY2QWbw9iTiEYwXUoRKlv8CqDxjUmVAK+5MN19fpdlGU198KTmUcBPwAV5FDqPW4wyhtc7GkW+of0Vio0Kkrg=
X-Received: by 2002:a17:906:2ed0:: with SMTP id s16mr21589608eji.327.1643732388897;
 Tue, 01 Feb 2022 08:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com>
 <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com>
 <CAFqZXNvny0zJmEMzFeMFuy0DzjAAaB5uqRpQoSMbZwVcUxTDAQ@mail.gmail.com>
 <CAHC9VhQE4JPhTjkKwV3ovRSuPceiHDrP3MDW4RPDcNtLkb7tAQ@mail.gmail.com> <CAFqZXNs7P+p0B-uZ2owMH1qa04unbq870tMqQ4Kwup7dXJ9z=g@mail.gmail.com>
In-Reply-To: <CAFqZXNs7P+p0B-uZ2owMH1qa04unbq870tMqQ4Kwup7dXJ9z=g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 11:19:37 -0500
Message-ID: <CAHC9VhRAPb8PV08fYd-GOY+ZeKX6r+rmGw_Okrwwj6ESTVDYmA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 1, 2022 at 9:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Jan 31, 2022 at 5:16 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Jan 31, 2022 at 7:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Fri, Jan 28, 2022 at 3:28 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Thu, Jan 27, 2022 at 4:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > I wonder if we could make this all much simpler by *always* doing the
> > > > > label parsing in selinux_add_opt() and just returning an error when
> > > > > !selinux_initialized(&selinux_state). Before the new mount API, mount
> > > > > options were always passed directly to the mount(2) syscall, so it
> > > > > wasn't possible to pass any SELinux mount options before the SELinux
> > > > > policy was loaded. I don't see why we need to jump through hoops here
> > > > > just to support this pseudo-feature of stashing an unparsed label into
> > > > > an fs_context before policy is loaded... Userspace should never need
> > > > > to do that.
> > > >
> > > > I could agree with that, although part of my mind is a little nervous
> > > > about the "userspace should *never* ..." because that always seems to
> > > > bite us.  Although I'm struggling to think of a case where userspace
> > > > would need to set explicit SELinux mount options without having a
> > > > policy loaded.
> > >
> > > I get that, but IMO this is enough of an odd "use case" that I
> > > wouldn't worry too much ...
> >
> > I understand, but seeing as I'm the only one that defends these things
> > with Linus and others lets do this:
>
> It's not all black and white:
> https://lore.kernel.org/lkml/Pine.LNX.4.64.0512291322560.3298@g5.osdl.org/

I made my statement above not to ask your opinion, but rather to make a point.

-- 
paul-moore.com
