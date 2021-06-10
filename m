Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11233A2EA8
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhFJOyX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 10:54:23 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:43806 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhFJOyV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 10:54:21 -0400
Received: by mail-ej1-f52.google.com with SMTP id ci15so44621408ejc.10
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgrPZgi7b2QFG6cOASs6RJRwLznNzJIFKNPaacIbtEQ=;
        b=s8sqSR9MEC+lvS6IvaTVYsAKgKJj/R2ACxPfsCWvIqtwHS2t9l9gvsjZ6V6RmFyc9v
         powE0S0mXyndbkO6USwkeYvL2iP7oXPnVm/31+TGDM075s46U5w5uPg1esi0iOH6RHyJ
         7mfXnXindr6HsCgwfVOXN/mf3appiSAKl8sPzQ6m0QtDcP45xZK6zAotSFPzz4uM3P3a
         bkffVCsYxxwu1FINmfBcq/ShlRY1pCN21L6Ay+kYMQa4PUwA0OM+vqmv2NllxEK+BbmW
         PoKSWCixbgPz9UR8iQW2aGWfyMAD0gzTxNk4C1a6X6SzgpgSJqE7FFG3cHV1m16TKJap
         P/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgrPZgi7b2QFG6cOASs6RJRwLznNzJIFKNPaacIbtEQ=;
        b=dbokd0YndeHeHS0p7NOiEdCtmC7D3k+X50B97Fc+P4ZaCl8o4Ot9YG29+y+vjuWNHy
         GKEuj0Mwsvbm9mp1eNqQvjx2/VtQr4F5rOBNUPUbdumjD1x8W7FJDw3u6qWjmJjTEFVG
         rbk1IZn6FvFI/sab5fqnHsKh9QP4BhpAZblEOgqW5qEAdfNnm5lhTdzzDc4lU4p+NQ7j
         3HlElW9TymDiy7Jw/qexTsuX77jkua5RVSBrcz3S4fQj0/fXwfQi9P36JF3gR8GqzUlq
         qz36kuOa1163jH7EFQjv8Q2PDj5IH5P2pVqfwdn5aJErdvghMl5MAI7xQXkA1ifwp0Ho
         41nw==
X-Gm-Message-State: AOAM533A3czcVHeIGPCEHWovOGpiHBlfc6mKO12dbmuayqq4HtBmAydC
        at7/KXHnqWLJDQ2DVOAWlHZOxrr48HzviYcEB2M=
X-Google-Smtp-Source: ABdhPJy9B80VtGoAVDzwv9GI2IheRUMULDRhGEiNJYJsJnWQVbviViKZmSH1NZGfaaWOiGAaohkAzleqeJkOsbV4SXM=
X-Received: by 2002:a17:907:1c9e:: with SMTP id nb30mr6512ejc.0.1623336667875;
 Thu, 10 Jun 2021 07:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-2-olga.kornievskaia@gmail.com> <91214898-F21A-4604-9FCB-9E9884F177B3@oracle.com>
In-Reply-To: <91214898-F21A-4604-9FCB-9E9884F177B3@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 10 Jun 2021 10:50:56 -0400
Message-ID: <CAN-5tyHgwnEFWdzLG7b8N6G84cTiHMpdDxLe7V=QD7Jd993QHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] SUNRPC query xprt switch for number of active transports
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 10, 2021 at 9:34 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > To keep track of how many transports have already been added, add
> > ability to query the number.
>
> Just a random thought: Would it make more sense to plug the
> maximum allowed transports value into the struct rpc_clnt,
> and then rpc_clnt_test_and_add_xprt() could prevent the
> addition of the new xprt if the maximum would be exceeded?

Sure that could be done. Then the value of maximum allowed transports
should be defined at the RPC layer and not NFS? I currently check for
upper bounds during the parsing of the mount option, would I be not
doing that or exposing the RPC value to the NFS layer?

Actually I think it might be nice to add some kind of warning in the
log that a trunking transport wasn't created because the limit was
reached but if we move things to the RPC, we can't distinguish between
nconnect and trunking transports.

> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > include/linux/sunrpc/clnt.h |  2 ++
> > net/sunrpc/clnt.c           | 13 +++++++++++++
> > 2 files changed, 15 insertions(+)
> >
> > diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> > index 02e7a5863d28..27042f1e581f 100644
> > --- a/include/linux/sunrpc/clnt.h
> > +++ b/include/linux/sunrpc/clnt.h
> > @@ -234,6 +234,8 @@ void rpc_clnt_xprt_switch_put(struct rpc_clnt *);
> > void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *, struct rpc_xprt *);
> > bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
> >                       const struct sockaddr *sap);
> > +size_t rpc_clnt_xprt_switch_nactive(struct rpc_clnt *);
> > +
> > void rpc_cleanup_clids(void);
> >
> > static inline int rpc_reply_expected(struct rpc_task *task)
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index 42623d6b8f0e..b46262ffcf72 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -2959,6 +2959,19 @@ bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
> > }
> > EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_has_addr);
> >
> > +size_t rpc_clnt_xprt_switch_nactive(struct rpc_clnt *clnt)
> > +{
> > +     struct rpc_xprt_switch *xps;
> > +     size_t num;
> > +
> > +     rcu_read_lock();
> > +     xps = rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
> > +     num = xps->xps_nactive;
> > +     rcu_read_unlock();
> > +     return num;
> > +}
> > +EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_nactive);
> > +
> > #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> > static void rpc_show_header(void)
> > {
> > --
> > 2.27.0
> >
>
> --
> Chuck Lever
>
>
>
