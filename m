Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6265148F1D0
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 22:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiANVEM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jan 2022 16:04:12 -0500
Received: from mail-yb1-f176.google.com ([209.85.219.176]:41506 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiANVEM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jan 2022 16:04:12 -0500
Received: by mail-yb1-f176.google.com with SMTP id g14so27176225ybs.8
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jan 2022 13:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSr4jZzYDR7cdtQCLqwhIxU/7ovKE5amFu2j7gtiC2Y=;
        b=Qzgu/0C/T0AvGPecqK9KAZ6tMse+zooHcVPkFoTlpt8kh/WyEVt23nvESf6T62OMgi
         zzI5QivGKBz/ItybUwPelpC4A6h65G6NgOSsDk5h+jTij/U7kOIJkBR8DfNnSdDNpCJi
         cApanS4ABM652kAlWbRZsSqTddRKyt0S9A2KJ2aitOcla+9kTbDGB0rzD6ZkEj8xH18F
         WZvpguNT1ASyENwrs3Nz+qHIN9O14SV/9+av8ZmYOakXZk5kmjxPkq3v4wPGT3xnjA/P
         MqyWSickmteKhfcR2jCHBNvkIkTsPzxNa6C007sB6rcF8PpTUBSOluxlIXMqO7hlBr4B
         gtBQ==
X-Gm-Message-State: AOAM533feM5D+naPSwDLDZen8139wZGf3sTDGHHknEoBGsgR+hj5IQGR
        TxXo8gtqIs8AfMjI14M0eCF1Sda+RH0HkTcK2gc=
X-Google-Smtp-Source: ABdhPJzo9uBYO2aoTZTNpRnqThbbLGqGFEIH1lViIaX2uFcr8yqrfZiw8vdkxcgp+HvcKQ/snvIlfp3262ZBIF7EZ20=
X-Received: by 2002:a25:1ec4:: with SMTP id e187mr14350651ybe.276.1642194251550;
 Fri, 14 Jan 2022 13:04:11 -0800 (PST)
MIME-Version: 1.0
References: <164209428615.12592.12164353310787172940.stgit@morisot.1015granger.net>
In-Reply-To: <164209428615.12592.12164353310787172940.stgit@morisot.1015granger.net>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Fri, 14 Jan 2022 16:03:55 -0500
Message-ID: <CAFX2Jfm8WBXbktmzCamDDMrqcQAjhDDqW68+uJ_tzk8UEEALxw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Minor clean-ups for v5.17
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Fri, Jan 14, 2022 at 3:19 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Sorry, these seem to have gotten lost in the shuffle. They've been
> in my client-miscellany branch on git.kernel.org since late
> November. I must have forgotten to repost them for review.

These look fairly uncontroversial, so I've added them to my linux-next for 5.17.

Anna

>
> Trond rejected "SUNRPC: Don't dereference xprt->snd_task if it's
> a cookie" for v5.16, so I've recrafted it to hopefully address
> his concerns.
>
> ---
>
> Chuck Lever (3):
>       xprtrdma: Remove final dprintk call sites from xprtrdma
>       xprtrdma: Remove definitions of RPCDBG_FACILITY
>       SUNRPC: Don't dereference xprt->snd_task if it's a cookie
>
>
>  include/trace/events/sunrpc.h     | 18 +++++++++++++-----
>  net/sunrpc/xprtrdma/backchannel.c |  4 ----
>  net/sunrpc/xprtrdma/frwr_ops.c    |  4 ----
>  net/sunrpc/xprtrdma/rpc_rdma.c    |  4 ----
>  net/sunrpc/xprtrdma/transport.c   |  4 ----
>  net/sunrpc/xprtrdma/verbs.c       | 23 -----------------------
>  6 files changed, 13 insertions(+), 44 deletions(-)
>
> --
> Chuck Lever
