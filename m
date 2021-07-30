Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6389D3DB4C9
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jul 2021 09:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbhG3H75 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jul 2021 03:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237939AbhG3H75 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jul 2021 03:59:57 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11486C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jul 2021 00:59:53 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id t2so4963834vsa.11
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jul 2021 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gK4U84S6B9L4iN73gKuaKX/AcZOyGaMtF/xYKwHgDIU=;
        b=C/ey1SeItuAZAwl7VAHZWwQkJwbhGY4q37umjmbR+XDSekjz3itQg844Fk2dxrC26j
         aRGtxOHIhfjGtHB3vNzFTNZT0XLiRe1N1lOpoEtbpMqXDnW9FNBS+eEWcONAQJIXgxVG
         NLZZmKR0icajN1l9q+ZbPcQKutA4QaiOiving=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gK4U84S6B9L4iN73gKuaKX/AcZOyGaMtF/xYKwHgDIU=;
        b=JA8js9catMvZrUS+y1XskiProlwG98G1Lefte8c8DPDlUP59erPhACGPwVgzsOxI17
         wG0HGZuQX8Qwy1+OOlqoqWBlg70HS8XqJDG8GVkqd4iaLQfBrAM0r0+Y3SK0sB/0DtMc
         2xRtd8qXhy64KhQQ4Nv9SUmsi2iOvXk6L9NDAQ5c0W2j2VM/M4Cu9eobIQsgLcX+ltQE
         mSPcNahcrSh/ISTFevbRxr7KLI0KGPdxQu0qTgEx5JFOWAQTjcw/5vQtQTlKad7hsneU
         eZQb4ZQX8iw+L8jx0TVQaBFd/yTLRfUbYjve0f6fiS9kt1uysGeto1AkKESNwHyzoDJ/
         Zljw==
X-Gm-Message-State: AOAM532t8AZcAaNGXcCuKAOPK+pFioZo13x2laA6Tid8BmNL5IaAmXe0
        zDSYsw9SY95nm4ku/FWP+Qwe2ekjAW/sfSWJoOAcMg==
X-Google-Smtp-Source: ABdhPJzNAQNQqqV/aJfK7JQPWmq2dMTFXC58sCKEj31HVNqDBqtViSN2IlYnT49qjaazqVwklWIuTuBPVPd5xfuBGoU=
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr594234vst.0.1627631992199;
 Fri, 30 Jul 2021 00:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546548.32498.10889023150565429936.stgit@noble.brown>
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk> <162762290067.21659.4783063641244045179@noble.neil.brown.name>
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com> <162763043341.21659.15645923585962859662@noble.neil.brown.name>
In-Reply-To: <162763043341.21659.15645923585962859662@noble.neil.brown.name>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Jul 2021 09:59:41 +0200
Message-ID: <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
Subject: Re: [PATCH 01/11] VFS: show correct dev num in mountinfo
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 30 Jul 2021 at 09:34, NeilBrown <neilb@suse.de> wrote:

> But I'm curious about your reference to "some sort of subvolume
> structure that the VFS knows about".  Do you have any references, or can
> you suggest a search term I could try?

Found this:
https://lore.kernel.org/linux-fsdevel/20180508180436.716-1-mfasheh@suse.de/

I also remember discussing it at some LSF/MM with the btrfs devs, but
no specific conclusion.

Thanks,
Miklos
