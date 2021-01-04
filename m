Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8BD2E954E
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 13:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbhADMwQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 07:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbhADMwP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 07:52:15 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62122C061793
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 04:51:34 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y19so63819869lfa.13
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17h4DVYYLIKG8v65xrZ8jYyqgZOp4MkPRCBBpTx7hNY=;
        b=aZP7ZAlDG63htcEOdZGkIfDcmuGcrNODTXU/qSJU/5AnA+qrrOPoerE6xs7uzTA2qF
         nbi32op1K0FkKSScQw17zSMUoxLKkGAzMjD7kqCXm1l49kxAhYyDowSDtBgttNFHNFm/
         2049hA4Le7nvuGO7Rdy5QZzRGblnEgJI+TtxPjTYX1l2FWSO8W5OjyjGSWocSD2/ESjm
         nuGTPJi3jcF+SbZJfWX2VV94SMC/4+uGpMUZut4iBG9o1m7X9uo3PWh4mLZ85i/XNKQL
         86q3xBe/RopSVHfJ/VrDZvcTGZNr/5NSlZGYPqNn67musi1jANLfcnF/Wt7iWdd0+gdf
         m84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17h4DVYYLIKG8v65xrZ8jYyqgZOp4MkPRCBBpTx7hNY=;
        b=ibF6UM6VgTSYxKnKmZ4noznNhvQg5+D61ZswHcw/ZNn8cLHkVszueL9QvnHGDQ1i+V
         5nqeUPDwkCZiD9lTSnAZKtcV0wytcMcn8ZbiVvd2Ntu5UKcMlGGsUoR2u1+M5DaP8ABO
         4ir8zc5fxNo1J6urV0WT9JvbJwbO3SFju1QVEN0ny9hdaTmg9K4UaE53S1OqalpK6mtF
         NqfWyz9Q+J6j0qj6URwpK/M4IeORq2QeaE8c5tG4kcyUiFMGJODhqcEW41UFzxcNLq78
         2IQgfP8ys5vG7Zg0M5NcX1lFGyoew0XvgQTG8g3EDmTIU71iMCLJ3CMV6rR8nFE2szXW
         M/LA==
X-Gm-Message-State: AOAM532r2ahQgzP95LwuQ/9nx5nqBcz03gwREbXQIOsPDrS/es4OX1K2
        PAaFxIwEsExSHm9f17z8dTy8s9xCHkFOQ5g0yhKwW/9LM7OC+w==
X-Google-Smtp-Source: ABdhPJzHsYtUuHz+LOy9crycuxSQ/DWxqEmbKPsD3hVqqBhW2n3lat5eMixgHIuqMOXiUNpBDqpXZGQOr/87Xun2fms=
X-Received: by 2002:a2e:8e37:: with SMTP id r23mr34886455ljk.292.1609764692968;
 Mon, 04 Jan 2021 04:51:32 -0800 (PST)
MIME-Version: 1.0
References: <CAL5u83HS=nurJ=r0tJU8ZqAXXkvu9-vWZpbVWoKALNh22WdKnw@mail.gmail.com>
 <87F51982-465A-46D4-BFB9-4B5E5A7EB82C@oracle.com>
In-Reply-To: <87F51982-465A-46D4-BFB9-4B5E5A7EB82C@oracle.com>
From:   Hackintosh Five <hackintoshfive@gmail.com>
Date:   Mon, 4 Jan 2021 12:51:21 +0000
Message-ID: <CAL5u83FRJQ_ys32S1KWjx72kamNw_3a2eFEAwH=MNMhruU9X=g@mail.gmail.com>
Subject: Re: Boot time improvement with systemd and nfs-utils
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, thanks for the fast reply

I have never even used nfs and I'm not a systemd expert, so I'm not at
all sure this interpretation is correct, but here goes. I only removed
the dependency from rpc.statd.notify, not rpc.statd. I didn't remove
the `After=nfs-server` line, and for nfs-server to be up,
network-online must be up first (there's an After requirement in the
nfs-server unit). So if the nfs-server is enabled, the
rpc-statd-notify will order itself after the server is up, which
depends on the network. That means that, if there is a server, the
server must be up before it sends notifications, so it will have the
right hostname. This only improves boot speed on nfs clients, where
nfs-client.target pulls in rpc-statd-notify.service.


On Mon, Jan 4, 2021 at 12:27 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hello, thanks for your report.
>
> The dependency you are removing addresses a bug -- if the network is not configured when rpc.statd is started, the rpc.statd process continues to use incorrect local address information even after the network is up.
>
>
> > On Jan 4, 2021, at 6:32 AM, Hackintosh Five <hackintoshfive@gmail.com> wrote:
> >
> > rpc-statd-notify is causing a 10 second hang on my system during boot
> > due to an unwanted dependency on network-online.target. This
> > dependency isn't needed anyway, because rpc-statd-notify (sm-notify)
> > will wait for the network to come online if it isn't already (up to 15
> > minutes, so no risk of timeout that would be avoided by systemd)
> > =============================================
> > From c90bd7e701c2558606907f08bf27ae9be3f8e0bf Mon Sep 17 00:00:00 2001
> > From: Hackintosh 5 <git@hack5.dev>
> > Date: Sat, 2 Jan 2021 14:28:30 +0000
> > Subject: [PATCH] systemd: network-online.target is not needed for
> > rpc-statd-notify.service
> >
> > Commit 09e5c6c2 changed the After line for rpc-statd-notify to change
> > network.target to network-online.target, which is incorrect, because
> > sm-notify has a default timeout of 15 minutes, which is longer than
> > the timeout for network-online.target. In other words, the dependency
> > on network-online.target is useless and delays system boot by ~10
> > seconds.
> > ---
> > systemd/rpc-statd-notify.service | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/systemd/rpc-statd-notify.service
> > b/systemd/rpc-statd-notify.service
> > index aad4c0d2..8a40e862 100644
> > --- a/systemd/rpc-statd-notify.service
> > +++ b/systemd/rpc-statd-notify.service
> > @@ -1,8 +1,8 @@
> > [Unit]
> > Description=Notify NFS peers of a restart
> > DefaultDependencies=no
> > -Wants=network-online.target
> > -After=local-fs.target network-online.target nss-lookup.target
> > +Wants=network.target
> > +After=local-fs.target network.target nss-lookup.target
> >
> > # if we run an nfs server, it needs to be running before we
> > # tell clients that it has restarted.
> > --
> > 2.29.2
>
> --
> Chuck Lever
>
>
>
