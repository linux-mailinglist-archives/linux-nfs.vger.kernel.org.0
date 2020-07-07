Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345FC21783E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2020 21:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgGGTuA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jul 2020 15:50:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37613 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgGGTt7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jul 2020 15:49:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id g20so39430766edm.4;
        Tue, 07 Jul 2020 12:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59CnLlZuQYJRv5f6MuQjRUDt5zs45SxsEopHLHhK6qY=;
        b=BR5avhd930Wo1TE4fsM5t2Q0LQ6Nfk+C28JoUrdaWFlCtE6CTjK1jtp112x4B0VUxR
         5HT6tTZuy4NtcfezJKuIBt0FIOWttaT28ErbhjR5PFFddALdrcg4K8eIrj3XmA70mzlr
         zoFbu25f894nCKcCfsnpwfBRlA4sBX8CUTSjHpi1VEsuNWdOXKQa14q46sDZAaDZOOv4
         r4a4nAAT1emQD+MU84rsRLXI3bKoDrW2T2GD3Sh9AoqRu4uKGvw2ZSSr49Rp5lsuecu/
         JkHYfSPLP/icGXHOfarigyCWvc4MSX0DZT1ymIWonf75ia47OCZcwvHA5vsTYb1GuKTy
         9Dmw==
X-Gm-Message-State: AOAM5327pEWbT5fX7Y3RS702vjQwxPvdNFyYIqfWVnzMPas16ZKgctK6
        q9dp+ew8lJ6sL0pQDzMoWl8WdClYYa4T8ZBsIg8=
X-Google-Smtp-Source: ABdhPJwJ5xO2pBLUtt+0k0DFCEknrpQ4pRGf6muaNnjO2HzWc7hov3lLbhJ21RZ3kMzNGlRZpfAInCZhGE1J6hTWmGA=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr65525230edo.102.1594151397718;
 Tue, 07 Jul 2020 12:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200627162911.22826.34426.stgit@manet.1015granger.net> <441C4FBC-31AF-4F29-B77F-C67814DA7957@oracle.com>
In-Reply-To: <441C4FBC-31AF-4F29-B77F-C67814DA7957@oracle.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 7 Jul 2020 15:49:41 -0400
Message-ID: <CAFX2Jf=_8RyRuLmHrPo+DpdeE4iBSDqQAuTFhpFDwN7fy7Mt2A@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Fix more issues in new connect logic
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Dan Aloni <dan@kernelim.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 6, 2020 at 2:42 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Anna, I haven't found any additional issues with this series that
> can't wait until 5.9 or later. Can you see that it gets into 5.8-rc ?
> Thanks!

No problem! I'll plan on including them in my next bugfixes pull.

Anna
>
>
> > On Jun 27, 2020, at 12:34 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > This series addresses several more flaws in the recent overhaul of
> > the client's RPC/RDMA connect logic. More testing is called for,
> > but these are ready for review. They apply on the fixes that were
> > pulled into Linus' tree yesterday.
> >
> > See also the "cel-testing" topic branch in my kernel repo:
> >
> >  git://git.linux-nfs.org/projects/cel/cel-2.6.git
> >
> > ---
> >
> > Chuck Lever (4):
> >      xprtrdma: Fix double-free in rpcrdma_ep_create()
> >      xprtrdma: Fix recursion into rpcrdma_xprt_disconnect()
> >      xprtrdma: Fix return code from rpcrdma_xprt_connect()
> >      xprtrdma: Fix handling of connect errors
> >
> >
> > net/sunrpc/xprtrdma/transport.c |  5 +++++
> > net/sunrpc/xprtrdma/verbs.c     | 28 ++++++++++++++--------------
> > 2 files changed, 19 insertions(+), 14 deletions(-)
> >
> > --
> > Chuck Lever
>
> --
> Chuck Lever
>
>
>
