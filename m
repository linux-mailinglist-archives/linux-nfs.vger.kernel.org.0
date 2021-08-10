Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC52D3E5C6D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 16:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbhHJOAi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 10:00:38 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:38703 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhHJOAh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 10:00:37 -0400
Received: by mail-ej1-f41.google.com with SMTP id z20so12891264ejf.5
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 07:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Likup35+S6vxtysMd6++ZEJglljLUpwZsRmcNbAA88=;
        b=s7Sdn8yL7IRuPtVYS6sTFTcfGmBU0FlkeAXZFVOQwnngQmzy7ysu54qkwAieqi8Jv5
         6WVR/bYTjAJ0d6clfZa5zLtuq3QxCFMirNHuanNwLF4pftKC62OT7yHqoQB0FCwhoZmK
         FVUPHuaVRGs1AHNfKE3cKZjsBuYa3QUQ3mzxd0hwZfLa9hqcf9EenD/lLWLQpvMcSDS2
         6JQdypMC07cgk0WgQd4RhIY9sMlxaCszkx8Ph40JOVdNxnGvSL4XgIJFChba51U3Mx61
         8vblLksFznb/moWrkW26+2QNb5rfhByFmH+hNVSVECDXDsgzxk43Gc4KOWj0iuitlTEU
         JPGA==
X-Gm-Message-State: AOAM533gj3OSAzPipI0dBS1WFUxLHJSok5iA+VxTZks0w6ouVMZQWlyT
        3kTHR8UniLq+Y+M3scdTj6nBPnOJ+5xpOer52Fg=
X-Google-Smtp-Source: ABdhPJwZjNYGuJKq7sLEulyemx6vqQM7CmOz9ZSmg+UmN9B+9fpySGWRClQdVuuRRG/UWBFZMvqzNQbmPNFzRQe75eA=
X-Received: by 2002:a17:907:2d0f:: with SMTP id gs15mr1451374ejc.23.1628604014378;
 Tue, 10 Aug 2021 07:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
 <CAFX2Jf=PvvsU8p+3i3OdLOwRCWDedBKhbhnNOe-RyaXx5LWUow@mail.gmail.com> <82A33007-6AE7-49BF-84CF-F960DA1548E3@oracle.com>
In-Reply-To: <82A33007-6AE7-49BF-84CF-F960DA1548E3@oracle.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 10 Aug 2021 09:59:58 -0400
Message-ID: <CAFX2JfkT6VE+ghBzFTWf8XxkpTzd4s9WXGtxud3jajGT_7cCOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Ensure RPC_TASK_NORTO is disabled for select operations
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 9, 2021 at 7:00 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Aug 9, 2021, at 4:37 PM, Anna Schumaker <anna.schumaker@netapp.com> wrote:
> >
> > Hi Chuck,
> >
> > On Mon, Jul 19, 2021 at 10:55 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >> This is a set of patches I've been toying with to get better
> >> responsiveness from a client when a transport remains connected but
> >> the server is not returning RPC replies.
> >>
> >> The approach I've taken is to disable RPC_TASK_NO_RETRANS_TIMEOUT
> >> for a few particular operations to enable them to time out even
> >> though the connection is still operational. It could be
> >> appropriate to take this approach for any idempotent operation
> >> that cannot be killed with a ^C.
> >>
> >> Changes since RFC:
> >> - Dropped changes to async lease renewal and DESTROY_SESSION|CLIENTID
> >> - Cleaned up some tracepoint issues I found along the way
> >
> > Is this the latest version of these patches? If so I can include them
> > in my linux-next branch for 5.14.
>
> AFAIR v2 is the latest, yes. Thanks!

Great, I have them applied!

Anna
>
>
> > Thanks,
> > Anna
> >
> >>
> >> ---
> >>
> >> Chuck Lever (6):
> >>      SUNRPC: Refactor rpc_ping()
> >>      SUNRPC: Unset RPC_TASK_NO_RETRANS_TIMEOUT for NULL RPCs
> >>      SUNRPC: Remove unneeded TRACE_DEFINE_ENUMs
> >>      SUNRPC: Update trace flags
> >>      SUNRPC: xprt_retransmit() displays the the NULL procedure incorrectly
> >>      SUNRPC: Record timeout value in xprt_retransmit tracepoint
> >>
> >>
> >> include/trace/events/sunrpc.h | 51 ++++++++---------------------------
> >> net/sunrpc/clnt.c             | 33 ++++++++++++++++-------
> >> 2 files changed, 35 insertions(+), 49 deletions(-)
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>
