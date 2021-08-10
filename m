Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B8C3E82D6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 20:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhHJSVD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 14:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbhHJSVA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 14:21:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6564FC0764C6
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 11:02:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h9so16191448ejs.4
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mDIgaqyR1mF3eAi0sBVFaqFkNtEIARsMAdsluT1lpQ=;
        b=Xa6KNn49QnwPx+4zY53Ul1/Fumxso33P/BbpXFAwpO+g5acxLT45sqSTxmwAJ/RaBp
         /7djM6GBZdWEV7IFyps5rsDhNJG2eH1ASPDhyVLvo1HRYojMKAp7pL7maK/hdNs+4XWT
         59GabnVn6d2J8otcWltOaqk1TXQRsc8yWAJNk3WSRT2dNzc5WkoRIPZQr30KKqruA3xO
         12e1bpa/s9CmSwQj3eLw5uA3ft9CvvKekhmZYByQIxvkGJ4X9VFtFXgkCdV+kR26ti1j
         tWW/F4vbmoOxlCVK+lLZH4QHa0NpG2fc5u29COCRj4z35yFly2HsdMNXpNJNd7lynSIQ
         Mn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mDIgaqyR1mF3eAi0sBVFaqFkNtEIARsMAdsluT1lpQ=;
        b=WWmlTybyRQZvHrplEW51YMsaPrsNg3qxPqbgDzDEDIsj25EwPZL1THXSwvgI3xamck
         bupDvjfg9vaKCEc0f+kr8zCF6zCTbIAA7o6eAu5uDQouNWwR0ZEZ2xBv18oquq5lI5BG
         FBoskDy1NnjGSuJGyM3ymU8/FiJA0Q4uHwv4R+Z09M1WoohcXLQX1q5sDb/YYk82PYOk
         L4BkK8UzI3CXkl1fQIfgKVZGZ54H4i+pim3MZFt7WOvxU+p1rWNtd3mc8nSprD+BBnaK
         9F5bfajQsx+n5bzQ1ayLCgqp3qOIrvdQs9ink8gpGM7EzWOPJTF+FWqBU1jOsz5RrqoK
         j1dw==
X-Gm-Message-State: AOAM531fECVTypYf37aV+VQiiszPIQjH36KIeFzosocOBLDfwRu1DgtU
        BGw9xFTxT4g+cE13liTMiwVr7M/HN3uKiP6vbr0=
X-Google-Smtp-Source: ABdhPJxs9ni6SZyonAStsAdKmY+tLNYI1L/0ylwIaBGBsce9MiwEhw3szFjn6fStYws9GcJ62wmJFzKGTPwFuoToRR4=
X-Received: by 2002:a17:907:78cf:: with SMTP id kv15mr15412180ejc.460.1628618520804;
 Tue, 10 Aug 2021 11:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
 <02B12E59-E014-4CF6-9A5B-58E5F426F964@oracle.com>
In-Reply-To: <02B12E59-E014-4CF6-9A5B-58E5F426F964@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 10 Aug 2021 14:01:44 -0400
Message-ID: <CAFX2JfkSG5Qe4_svtunwRhMvwdN=bNP0VtuSFtU6siDihjWpZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] XDR overhaul of NFS callback service
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Fri, Jul 30, 2021 at 3:53 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hi Trond-
>
> > On Jul 15, 2021, at 3:52 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > Trond, please let me know if you want to take these or if I may
> > handle them through the NFSD tree for v5.15. Thanks.
>
> I've included these in the NFSD for-next topic branch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=for-next
>
> They can be removed if you would like to take them through
> your tree instead.

These look to be mostly client-side changes, so it would make sense to
take them through the NFS tree. Would that cause problems now that
they've been in your for-next branch for a while?

Anna

>
> If I am to take these, Bruce and I would like an Acked-by:
> from you.
>
>
> > The purpose of this series is to prepare for the optimization of
> > svc_process_common() to handle NFSD workloads more efficiently. In
> > other words, NFSD should be the lubricated common case, and callback
> > is the use case that takes exceptional paths.
> >
> > Changes since RFC:
> > - Removed RQ_DROPME test from nfs_callback_dispatch()
> > - Restored .pc_encode call-outs to prevent dropped replies
> > - Fixed whitespace damage
> >
> > ---
> >
> > Chuck Lever (7):
> >      SUNRPC: Add svc_rqst::rq_auth_stat
> >      SUNRPC: Set rq_auth_stat in the pg_authenticate() callout
> >      SUNRPC: Eliminate the RQ_AUTHERR flag
> >      NFS: Add a private local dispatcher for NFSv4 callback operations
> >      NFS: Remove unused callback void decoder
> >      NFS: Extract the xdr_init_encode/decode() calls from decode_compound
> >      NFS: Clean up the synopsis of callback process_op()
> >
> >
> > fs/lockd/svc.c                    |  2 +
> > fs/nfs/callback.c                 |  4 ++
> > fs/nfs/callback_xdr.c             | 61 ++++++++++++++++---------------
> > include/linux/sunrpc/svc.h        |  3 +-
> > include/linux/sunrpc/svcauth.h    |  4 +-
> > include/trace/events/sunrpc.h     |  9 ++---
> > net/sunrpc/auth_gss/svcauth_gss.c | 47 +++++++++++++-----------
> > net/sunrpc/svc.c                  | 39 ++++++--------------
> > net/sunrpc/svcauth.c              |  8 ++--
> > net/sunrpc/svcauth_unix.c         | 18 +++++----
> > 10 files changed, 96 insertions(+), 99 deletions(-)
> >
> > --
> > Chuck Lever
> >
>
> --
> Chuck Lever
>
>
>
