Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9B3E4E0D
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 22:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhHIUoI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 16:44:08 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:35601 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhHIUoH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 16:44:07 -0400
Received: by mail-ej1-f53.google.com with SMTP id w5so7088763ejq.2;
        Mon, 09 Aug 2021 13:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+10uh1b2KnN8FvhEHcmhEKUUmG16I0o+PmBxu2duzk=;
        b=IvvoQYENgfiobKxWvzuGPWXHW7kZHeK7A8jAL7wEGdPGPavS6H76f+72Jgdcp8BU4A
         3dMAITAvYQOkQb9VYcehK0eec+UtJxwxKpOD7XYERl8NhuZ6u+4SzPISeIYPe7qOhlq1
         hHLBT90a12kfc9JxS5c276XkJr6mzAtYBqx5p34IJZAO4BnXcwquyu4eYU+evoFKhY7h
         DsXZwaXKLuKkGRjpvnmPxcoe2yNYgYMAk2DQm4mg2r0nApTub5Asz/GK1EhZiSBv1gDG
         XS2c0O8K/Y8UxjH0To13xSGJrCJiFpuaOU3Y3Us+QoJbQzW3goWqMhYCM9XMjx+e2Lm2
         BWkg==
X-Gm-Message-State: AOAM530ZvDsF/R/6L/bHt5vTh7/4mnUlhtsxGbnuLNEVpRAIfTG4uwP/
        Nnjcb2xFYRMtVmleM/w70XcqnkEUkMIZbSl/iXA=
X-Google-Smtp-Source: ABdhPJwGnQ4zJqEPuqVs9LHe06zpw17OFi50to6XCFAkFYDHpRCFdEYc8dWUAAXjTzCX07a7EzMc9dpXQwe9qopaWXg=
X-Received: by 2002:a17:906:4d94:: with SMTP id s20mr23459878eju.152.1628541825744;
 Mon, 09 Aug 2021 13:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
In-Reply-To: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Mon, 9 Aug 2021 16:43:29 -0400
Message-ID: <CAFX2JfnXC6opHrc9KPZD7W5GQQUHz8RXzXh5r5PGzad7x_Uk0g@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] NFS/RDMA client fixes
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        List Linux RDMA Mailing <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Mon, Aug 2, 2021 at 2:45 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi-
>
> Not sure I've posted these yet. I've been working on some error
> injection features and while testing them, I found a few bugs in
> the NFS/RDMA client.

Thanks! I've added these to my linux-next branch for 5.14.

Anna

>
> ---
>
> Chuck Lever (5):
>       xprtrdma: Disconnect after an ib_post_send() immediate error
>       xprtrdma: Put rpcrdma_reps before waking the tear-down completion
>       xprtrdma: Add xprtrdma_post_recvs_err() tracepoint
>       xprtrdma: Add an xprtrdma_post_send_err tracepoint
>       xprtrdma: Eliminate rpcrdma_post_sends()
>
>
>  include/trace/events/rpcrdma.h    | 74 ++++++++++++++++++++++++++++---
>  net/sunrpc/xprtrdma/backchannel.c |  2 +-
>  net/sunrpc/xprtrdma/frwr_ops.c    | 14 +++++-
>  net/sunrpc/xprtrdma/transport.c   |  2 +-
>  net/sunrpc/xprtrdma/verbs.c       | 28 +++---------
>  net/sunrpc/xprtrdma/xprt_rdma.h   |  2 +-
>  6 files changed, 90 insertions(+), 32 deletions(-)
>
> --
> Chuck Lever
>
