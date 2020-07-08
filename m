Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73892191EF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGHVEs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 17:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVEs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 17:04:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0634DC061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 14:04:48 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b15so131071edy.7
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVcAyzqkDmcnHPhUL2dnDbBqJTsqCzTuGvs02s1BTec=;
        b=noGIzdOQ1V7LOinWGdj5HVCSvcDoUv0JVYVnfQU3CV5YRCMh5MfwakA4x+fw3/D7P3
         TkxuMku8GIjdxCu8LsSKNFDsEiVaPREtkaGALxKNcTyUbfizkcRwGkIdPzNK1shaDm/Q
         iLdADyRIdLXJ7vJSfzO+Y+hhPkl0TFbY1BMamyIS3oVF0ZsVSyYV+0uL06J4dzc0+zFb
         wirJU5zvCWldUZ+onVBEJpI6FeJ8bbyKxsF7GUL00zErS1XN9edpa3H4VA9dgeqrJ6F/
         36UMpsfEW+txiz3w2UaMf3PSYxsFsACAbL9Kzo7ebub1SPtplRyW8z+ywzbkB3frkUUJ
         i6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVcAyzqkDmcnHPhUL2dnDbBqJTsqCzTuGvs02s1BTec=;
        b=drp2kdvQ3qUB9cOogcamg4GMTvipEtl+SbkKLuTlkcIk476APmsWac5n1wVF4FwE/4
         XRecAWiFzbe0rlRe7NDAfayK2ZOLfs+hVhQ0scdscsho/u+iRpgqFzFxix/4LI2SpWVl
         Kj1Nhk9ugr+9Z/QgY2Mv+TfciOVK3zWaQu1UMIgzvSIV6YF/KCwqiOuFRLp6J244uZmI
         ip8hewm3rKJCD2fkNLR4DpTxtMU75rMko4LMEOYI+8NVPvyaKKcxJjKB3UhQ1tQnA4rB
         w5RXgq115xEmeQqVr+irMnmYnaWkVIhpBaDsNlRqzmXoI2iwwrNhOXgO8WiCLmB4t36c
         pwYA==
X-Gm-Message-State: AOAM5310c/8bt+wAplSXKM14li+R+7FXBGSi5b1dF+FHj9L6hnCwW3Rl
        PXdcBG7H3rRKb/vMGT13R95WbVb2shxvCSgfvWPy9w==
X-Google-Smtp-Source: ABdhPJy21KK9u8Zk1c2/QZP/OSYXix/3p2lVV9xW6LnxA1SH1+tKmJwq9PloEJ5dLcC4cZjZtLRfn8p1rZI00cX26gk=
X-Received: by 2002:a50:8adb:: with SMTP id k27mr66862945edk.267.1594242286770;
 Wed, 08 Jul 2020 14:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200623152409.70257-1-olga.kornievskaia@gmail.com>
 <CAN-5tyHuZwA-mrwUu1U+85-=mAFFtPZZJLAXyKyTaq7vqGwAfw@mail.gmail.com> <b9c8d38a17d89c231ed1b11f3e730ab4475ce85a.camel@hammerspace.com>
In-Reply-To: <b9c8d38a17d89c231ed1b11f3e730ab4475ce85a.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 8 Jul 2020 17:04:36 -0400
Message-ID: <CAN-5tyGLQbzWEHBsmRuZ0LAWHNBobQ50cEOMp_REvWpa6SOjbw@mail.gmail.com>
Subject: Re: [PATCH 1/1] SUNRPC dont update timeout value on connection reset
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jun 28, 2020 at 5:16 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Sun, 2020-06-28 at 14:03 -0400, Olga Kornievskaia wrote:
> > Trond/Anna,
> >
> > Any comments on this patch?
> >
> > On Tue, Jun 23, 2020 at 11:22 AM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > > Current behaviour: every time a v3 operation is re-sent to the
> > > server
> > > we update (double) the timeout. There is no distinction between
> > > whether
> > > or not the previous timer had expired before the re-sent happened.
> > >
> > > Here's the scenario:
> > > 1. Client sends a v3 operation
> > > 2. Server RST-s the connection (prior to the timeout) (eg.,
> > > connection
> > > is immediately reset)
> > > 3. Client re-sends a v3 operation but the timeout is now 120sec.
>
> Ah... The problem here is clearly '3.' incrementing the timeout value
> before we've actually hit a minor or major timeout...
>
> So I think we want to look carefully at xprt_adjust_timeout(). The
> first rule there should be that if we're below the threshold for a
> minor timeout, we just want to exit without changing anything.
>
> The second rule is then that if we're below the threshold for a major
> timeout, then we adjust the timeout value by doubling it (if to-
> >to_exponential) or adding the value to->to_increment (if !to-
> >to_exponential) and then exit.
>
> Finally, if this is a major timeout, we reset req->rq_timeout to to-
> >to_initval, reset req->rq_retries, call xprt_reset_majortimeo(), reset
> the RTT counters and return ETIMEDOUT.
>
> None of this should be specific to your connection reset case. This is
> how we want timeouts to work in the generic case, so we need to fix
> that.
>

Ok thanks for comments. I don't know if I got it right but I submitted
a new version.

> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
