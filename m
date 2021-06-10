Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1403A3253
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 19:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhFJRmK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 13:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFJRmH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 13:42:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3541C061574
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 10:39:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a11so488738ejf.3
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvvRfhsZzjiniGgbWxyGCYQREMiXFzh1htplZR9bBoo=;
        b=RppxbcQ2ZPIsqRzq7bVBk/X9Obx0GzxwQ/U8SAWZ+vgO+hWou3o7gf52RVaTnVUxym
         mCmJJZI/4zH0RjhQmgDp610Bgz53b/4nKvebFUICokEi5RNvGBFyWeoHI/roS1pQHoz5
         d4tlloIFhPr5YawbvT2FTkJYmlxoDEanO2UZ7tITzCg5mMg9Ngq/qU+kqIf33Wi+EXP9
         xN8A/ZVD2u7Iz7xnbXu16ObXWJ7U/sYqVCkLJdBP139btpZaSgm37cQpB5Ife48eZEbI
         FZCa6rl5jePWXYn4Qr+ANwNeSk08FicvXC0HSRebEh/RUeklZjLbZ7CuSYorjTGYQB8Z
         6jXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvvRfhsZzjiniGgbWxyGCYQREMiXFzh1htplZR9bBoo=;
        b=V1MDbit6C2tQga+WJPlOVlnog6Rvt7WAoyOjsMoqfgvSYoRhX3npv7HZO/6WuLvI4B
         S15wZUXnS/8H4SD9yucN/2Mf/BCzToKlgPJo8zXg4g+PtVG+yCmn5l4K2DRTcCmuTXXV
         HRpSQ74Q142aH5yCWZW28UiFRR0Jnz1LJ99pO5uZEHmCl2boevSUC5ylzXqKqmyp4F5z
         ITRAAQPKkXlFShij4nTZH0mz8lYrHTS0/oIydkQJMkN51dCq5hwyF3QIdC+Yyc5//krn
         eTM9uH6DwxFx4HHGpRGreeWItyJsPUUmSUdm8cTYwsU8wKmXKXpnRJxBNll0C7jq7+vb
         BsNA==
X-Gm-Message-State: AOAM530Tc7mLWsTaPUVD2T18Hqzt0xnsCjeybRY8K3an9nz0x4py4Y2i
        s4fcFdjVk9EKfk+DIJcsCUu8VDhxkSoq3W9wWgccwfC0Bbc=
X-Google-Smtp-Source: ABdhPJxtXfcCHSc1ahDpfwOiSj0fxiRQpk1n5mJlCwvhNmaQMVPZpRHh/nHFTAKubc8p9B0Bu1jSdfGqFFvAODBkm1I=
X-Received: by 2002:a17:907:1c9e:: with SMTP id nb30mr742694ejc.0.1623346793232;
 Thu, 10 Jun 2021 10:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <9657859a-7e65-0b38-a4c5-3f74d0bdc5e8@redhat.com> <CAN-5tyG6Hs3yt4+GPBA6_x-vCC5aj-WPk6+HtLsQS-d+NY2a_A@mail.gmail.com>
In-Reply-To: <CAN-5tyG6Hs3yt4+GPBA6_x-vCC5aj-WPk6+HtLsQS-d+NY2a_A@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 10 Jun 2021 13:39:42 -0400
Message-ID: <CAN-5tyE6R3oCZdiCbNfnqG8F+ppipw2Mj6dUB-zdun7Vj06Cqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] don't collapse transports for the trunkable
To:     Steve Dickson <steved@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 10, 2021 at 1:33 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Thu, Jun 10, 2021 at 9:29 AM Steve Dickson <steved@redhat.com> wrote:
> >
> > Hey!
> >
> > On 6/9/21 5:53 PM, Olga Kornievskaia wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > This patch series attempts to allow for new mounts that are to the
> > > same server (ie nfsv4.1+ session trunkable servers) but different
> > > network addresses to use connections associated with those mounts
> > > but still use the same client structure.
> > >
> > > A new mount options, "max_connect", controls how many extra transports
> > > can be added to an existing client, with maximum of 128 transports in
> > > total for either nconnect transports (which are multiple connections
> > > but to the same IP) or transports that are going to different network
> > > addresses.
> > I'm trying to figure out why this new mount option is needed...
> > What is it protecting? What am I missing?
>
> Hopefully comments on patch3 of this series can help you answer that.

I mean patch2. But to answer briefly. It protects not creating too
many transports.

>
> > Plus it needs to be documented....
>
> Indeed a man page patch is needed but I was waiting to get a more
> commonly accepted version of the code before adding the man page
> patch.
>
> > steved.
> > >
> > > Olga Kornievskaia (3):
> > >    SUNRPC query xprt switch for number of active transports
> > >    NFSv4 introduce max_connect mount options
> > >    NFSv4.1+ add trunking when server trunking detected
> > >
> > >   fs/nfs/client.c             |  1 +
> > >   fs/nfs/fs_context.c         |  8 +++++++
> > >   fs/nfs/internal.h           |  2 ++
> > >   fs/nfs/nfs4client.c         | 43 +++++++++++++++++++++++++++++++++++--
> > >   fs/nfs/super.c              |  2 ++
> > >   include/linux/nfs_fs_sb.h   |  1 +
> > >   include/linux/sunrpc/clnt.h |  2 ++
> > >   net/sunrpc/clnt.c           | 13 +++++++++++
> > >   8 files changed, 70 insertions(+), 2 deletions(-)
> > >
> >
