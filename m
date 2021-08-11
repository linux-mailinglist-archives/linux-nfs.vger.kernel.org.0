Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E936C3E97BF
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 20:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHKSin (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 14:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhHKSim (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Aug 2021 14:38:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C792C061765
        for <linux-nfs@vger.kernel.org>; Wed, 11 Aug 2021 11:38:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z20so6203884ejf.5
        for <linux-nfs@vger.kernel.org>; Wed, 11 Aug 2021 11:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csVrkopVfutecL9GyjyrQ3IXnImw8dHRzC8RAH6XarI=;
        b=as2N2xXvtEPnd91PO8DUYBE4iET6mzqqyoGm9b1fKBETw5zD7Vgm289Q8j+U5D9I/4
         IDLLsl/PWvD3ONmEsdRuU+OU8anurYxmvD1GqLJVKO5uY4m1uu63JzziO/kpKZsNXCva
         +NYJanxdvCK/UhLOsLD++jCykAESvSyuzrzzk9wgpCBZekVBVUgQE8vKCW2jDnWODm0W
         e2OsauJaPnn+bjV9uq5BkzojMCLMMiIPaRnCeZUTLmO1joHnUMhNhWsl8qnlEXSEfdM6
         tecrKq4dmYFjH8oc86W5UMUNhPp/38h8DyAXeKHCDsO+en2O6Bf/K8RausqGr3s8t6rO
         NePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csVrkopVfutecL9GyjyrQ3IXnImw8dHRzC8RAH6XarI=;
        b=dD6ZFTpGuTXSXazvX/fUSxZXI1nI137cYDNUxTBi69xbxnyBUzqcCyUSyi8YQybIny
         Oukm0S+4X6GDkwtFRHQU+jJ+pqsh2nK41nBbS0eQYfmSmdVOZ1V8186SteXWl8KUDu5O
         tQLHRo7bst3200YnDJWgzMcwiFyY5uUTTPJxqvvS9+RtLDK5JBIfmbnX7LTsSPcSodYx
         KrWpRMHgZIJbx27k1Dx+VDP2U7ROq/6U0Wxj98JdDul7chR9jZhssoyXXmmKM77bkYRJ
         t+/A8kDpl7GiLlfVpfdoOrMhkjTlBmEamfb6vtueVP+7i4MHVegulD4t5AtrrcZoee9h
         6a/Q==
X-Gm-Message-State: AOAM532WfVeUSjE7MigPoJEnrxgvJv36wrPDVkmMNHaQt0Bd3PixAuEc
        PrO9k3NP4RUDCBBThOgouhRVa7p2F56vIgQiTpk=
X-Google-Smtp-Source: ABdhPJy+RKufybS3ym6vxO/uiLKBCb0CxiOA39GX83/p7JUopyQLs06kcSfRJyxpPpoSzkgcPcEoPSW+OImGCiXRgf0=
X-Received: by 2002:a17:906:c006:: with SMTP id e6mr5081837ejz.510.1628707097091;
 Wed, 11 Aug 2021 11:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com> <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org> <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org> <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org> <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com> <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org> <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org> <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
In-Reply-To: <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 11 Aug 2021 14:38:05 -0400
Message-ID: <CAN-5tyHNvYWd1M7sfZNV5q3Y_GZA2-DoTd=CxYvniZ1zkB5hyw@mail.gmail.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 11, 2021 at 1:30 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Aug 11, 2021, at 12:20 PM, Timo Rothenpieler <timo@rothenpieler.org> wrote:
> >
> > resulting dmesg and trace logs of both client and server are attached.
> >
> > Test procedure:
> >
> > - start tracing on client and server
> > - mount NFS on client
> > - immediately run 'xfs_io -fc "copy_range testfile" testfile.copy' (which succeeds)
> > - wait 10~15 minutes for the backchannel to time out (still running 5.12.19 with the fix for that reverted)
> > - run xfs_io command again, getting stuck now
> > - let it sit there stuck for a minute, then cancel it
> > - run the command again
> > - while it's still stuck, finished recording the logs and traces
>
> The server tries to send CB_OFFLOAD when the offloaded copy
> completes, but finds the backchannel transport is not connected.
>
> The server can't report the problem until the client sends a
> SEQUENCE operation, but there's really no other traffic going
> on, so it just waits.
>
> The client eventually sends a singleton SEQUENCE to renew its
> lease. The server replies with the SEQ4_STATUS_BACKCHANNEL_FAULT
> flag set at that point. Client's recovery is to destroy that
> session and create a new one. That appears to be successful.
>
> But the server doesn't send another CB_OFFLOAD to let the client
> know the copy is complete, so the client hangs.
>
> This seems to be peculiar to COPY_OFFLOAD, but I wonder if the
> other CB operations suffer from the same "failed to retransmit
> after the CB path is restored" issue. It might not matter for
> some of them, but for others like CB_RECALL, that could be
> important.

Thank you for the analysis Chuck (btw I haven't seen any attachments
with Timo's posts so I'm assuming some offline communication must have
happened).
?
I'm looking at the code and wouldn't the mentioned flags be set on the
CB_SEQUENCE operation?  nfsd4_cb_done() has code to mark the channel
and retry (or another way of saying this, this code should generically
handle retrying whatever operation it is be it CB_OFFLOAD or
CB_RECALL)? Is that not working (not sure if this is  a question or a
statement).... I would think that would be the place to handle this
problem.

>
>
> --
> Chuck Lever
>
>
>
