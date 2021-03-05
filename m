Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B638E32DF1F
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 02:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCEBcQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 20:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhCEBcP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 20:32:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F8C06175F
        for <linux-nfs@vger.kernel.org>; Thu,  4 Mar 2021 17:32:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id c10so339226ejx.9
        for <linux-nfs@vger.kernel.org>; Thu, 04 Mar 2021 17:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80N8FTktWaHp8/7shNAGY0Bb2p2RGTW77BNazisTaqc=;
        b=kwO3ZbQJvmoyZEcCsnZ+O5lefcSrFp4+zNeyaTxwbMuTmfsqLF3Zl3diE3rtVg3Nf5
         XWXIutDh7iwVsvz7hM2SbHDz75L4k1hdS7zjWDfGrEGtSQIalEqcvAeA+6ZMUMeIj4pe
         CMcbLw1BJUAAT79MYajlSgDqsgLNlVf56KvxaVcF6odqfB14mHAKqbBmKjnjbgbNRFkV
         /5bGDWxr9WX5/onrBYptac6azV0Lcs/AChdKXyW5sv+uplHNQIj1kdeUTSi0JzenFZwl
         FovvuSszpmZUmsiCuYj6WrEaKmUvmLlJhO0txFw323fvX3ZlpQ35xFNA7tudurvk0PjE
         Gwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80N8FTktWaHp8/7shNAGY0Bb2p2RGTW77BNazisTaqc=;
        b=gEOFP/7xBi5g0N1AIylii49nNCSp3RnL0nE5QNz82fijuKfP2jzl9SgDYRmQKFaA35
         7vEvkWyfoUYCuz9BV9biyKDXvwojZByAaxp8J5Xg7+IKoeG+C3Ea8CGehgtICf1UbQOh
         XFP4D4Su307aVZare6kDhgFUVHoSydReK2RJjeSe/6RRPVLSseID7tt5+t5+8bqusAjd
         h8dRUdrHw1LEANswDHCgdTqrymehb9sUw8UHmYFrsfaIXEwH1hXW/biLapo7U7vzrmbc
         dGee8OEXhB8LJd4s2KrZqKA8uU6sIlNVnXTqkgKJpm8ACq8thCiFj5PRJHtyhO3rHCC+
         YhAw==
X-Gm-Message-State: AOAM532oWekuwYz90w256q6N3ft4IXnTH7J19rMOEaEp6rci2EFn99vS
        F4ELeRTIX4zJc4O2eUC7MtTBDsCP3U8yKydJZrXQ
X-Google-Smtp-Source: ABdhPJwXTiyn3oCcRf5J9N21dl1QmjUNUXvdO1Y1u5UMG7hWl+cnxknz1WGXfqwWJgv/kNeDf6uhKrTXixDZprq98tc=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr227254ejf.431.1614907933967;
 Thu, 04 Mar 2021 17:32:13 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com>
In-Reply-To: <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 20:32:02 -0500
Message-ID: <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 2, 2021 at 10:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/2/2021 10:20 AM, Anna Schumaker wrote:
> > Hi Casey,
> >
> > On Fri, Feb 26, 2021 at 10:40 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> >> From: Olga Kornievskaia <kolga@netapp.com>
> >>
> >> Add a new hook that takes an existing super block and a new mount
> >> with new options and determines if new options confict with an
> >> existing mount or not.
> >>
> >> A filesystem can use this new hook to determine if it can share
> >> the an existing superblock with a new superblock for the new mount.
> >>
> >> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > Do you have any other thoughts on this patch? I'm also wondering how
> > you want to handle sending it upstream.
>
> James Morris is the maintainer for the security sub-system,
> so you'll want to send this through him. He will want you to
> have an ACK from Paul Moore, who is the SELinux maintainer.

In the past I've pulled patches such as this (new LSM hook, with only
a SELinux implementation of the new hook) in via the selinux/next tree
after the other LSMs have ACK'd the new hook.  This helps limit merge
problems with other SELinux changes and allows us (the SELinux folks)
to include it in the ongoing testing that we do during the -rcX
releases.

So Anna, if you or anyone else on the NFS side of the house want to
add your ACKs/REVIEWs/etc. please do so as I don't like merging
patches that cross subsystem boundaries without having all the
associated ACKs.  Casey, James, and other LSM folks please do the
same.

-- 
paul moore
www.paul-moore.com
