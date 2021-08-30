Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB133FBA72
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhH3Q47 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 12:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbhH3Q46 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 12:56:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F1C061575
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 09:56:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u14so32449485ejf.13
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddCNoL2Zx2HbqH2XxVt4devz/+jzm0F/cNGp7KsZTtU=;
        b=sUk3UnfXFN2ltm46XZ8ZHFYmJJcYamb1YdnWYjV4KxWCwug817mWHhmXYv5bbdsKvz
         3p+6X7+WvI+xtXfRi3OnyLEH7HoWsTXxGpl/ukzz8ir5D4+RQEdSDppjAtP0JD0Hg+nK
         EOwHKERe72gSucwOL8RyAq4nF5ZTKtVoCt3nlyDEN0L6h3vk+tb0LlNqTa2UzKcZOIpP
         d70E7mqMXEFYOjW1bXQuLM2Kyb+IvYhdu1JZFIyFSOp3hqkBUT+qLz71iJF7D3ERz7dO
         lQgIJYIj0rzDdhZ5FQAPNpqo5/Y7vQR7TMf+cdD91v4nwpCmkHgEkX/RDsw78kNWV8FO
         vb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddCNoL2Zx2HbqH2XxVt4devz/+jzm0F/cNGp7KsZTtU=;
        b=Rdfp3YDUtX0dAuwC9mBahoYsH8eFvfT2mH33l0We8A/Ppm6K3lCAv5gYLJoZdO4QkO
         LShNKBoYJMQIZtZOW1XiapVcupm4OIhRHzVLwPhhCbmW8Wns1Ua++luJ9GoimJlmKSGG
         cX9mcbBHw7ukM1oZseiehPF2R/rqOWR/tcL4cZrUnlGpbKm3vAMNMk76qyKwSodVqlSg
         CTu3lb5cSUI9cnQXjnMzPrKxxjr9ws7Dn5T+2Mnc+SpKTixaCXu2mH2YTbhSej7r4+lW
         cb+PHnCVEJF5YpRX6Qry+yGNSMsF0/p6Ug6s4UP1z6OAiNlbHvbLkIai+D2bLmayow7Z
         yAGg==
X-Gm-Message-State: AOAM530LRhuiHhM1sV5SrFC3kc8KRk7ptS1pb9p7d8Eenb9BbZY1/0RM
        DnRwjbZMi4ssUaY7889utI7/eVThyEtTAnwpE7GaoLRDTuk=
X-Google-Smtp-Source: ABdhPJxebsXIsn+OKI0T+BUZJIQw4Qs/G4Fb50SFSt6B1nvcrjXiztMKviueII79Mo+7tIGS6U+OUX+4ZGcD+NuNcj4=
X-Received: by 2002:a17:906:5306:: with SMTP id h6mr26063542ejo.248.1630342563549;
 Mon, 30 Aug 2021 09:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 30 Aug 2021 12:55:52 -0400
Message-ID: <CAN-5tyExcCg7vNN=jweMds03QNgHZ1zH5V9KvCxyong2UEq8Yw@mail.gmail.com>
Subject: Re: [RFC 0/2] revisit RMDA XDR padding management
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 30, 2021 at 12:53 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> We have previously revisited how XDR padding management was done
> for the RDMA read chunks.
>
> This patch series attempts to do the same for the RDMA read chunks
> and altogether remove the options of doing an implicit roundup.

Apologies for typos but this is about RDMA write chunks.

> According to the RFC 8166 client "SHOULD NOT" include additional
> space for XDR roundup padding. Furthermore, server MUST NOT write
> XDR padding into the a write chunk. Given those two statement and
> a patch "NFS: Always provide aligned buffers to the RPC read layers",
> there is no reason for the client to look at the tail and assume
> there is any padding data for which it needs to allocate space for.
>
> The only operation that this patch series effects is an NFS read.
> All non-read ops that might use a write chunk are setup to use
> reply chunk if reply is larger than inline threshold, not a write
> chunk.
>
>
>
> *** SUBJECT HERE ***
>
> *** BLURB HERE ***
>
> Olga Kornievskaia (2):
>   xprtrdma: xdr pad optimization revisted again
>   xprtrdma: remove re_implicit_roundup xprt_rdma_pad_optimize
>
>  net/sunrpc/xprtrdma/rpc_rdma.c  | 15 ---------------
>  net/sunrpc/xprtrdma/transport.c |  8 --------
>  net/sunrpc/xprtrdma/verbs.c     |  2 --
>  net/sunrpc/xprtrdma/xprt_rdma.h |  6 ------
>  4 files changed, 31 deletions(-)
>
> --
> 2.27.0
>
