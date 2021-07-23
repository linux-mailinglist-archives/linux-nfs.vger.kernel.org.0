Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA43D4185
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jul 2021 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhGWTss (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jul 2021 15:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhGWTss (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jul 2021 15:48:48 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EF9C061575
        for <linux-nfs@vger.kernel.org>; Fri, 23 Jul 2021 13:29:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 800D27C76; Fri, 23 Jul 2021 16:29:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 800D27C76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1627072160;
        bh=/1qqV55i2QaVP5rrCZuLf+J9xZRlzqtwB1h0eqikb34=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=IEZIc3xuc3GSXVqy8op4HddI5HFsGVQKDBukTgdQ+2Zo/8qwFjFXwewKtnh1It8J4
         4PrlJxeXPDveitcxP1pjU4HFikU5zzTN8huMTmJ9KkAiKYzmpm+l84KXdEt4uGMp9k
         3paxsvtKrz2dzoh7NCfCtobDCl+W88KtLlWkNKds=
Date:   Fri, 23 Jul 2021 16:29:20 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/7] XDR overhaul of NFS callback service
Message-ID: <20210723202920.GB1278@fieldses.org>
References: <162610122257.2466.7452891285800059767.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162610122257.2466.7452891285800059767.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These patches look OK to me.  (And they pass my usual tests, fwiw.)

--b.

On Mon, Jul 12, 2021 at 10:52:16AM -0400, Chuck Lever wrote:
> The purpose of this series is to prepare for the optimization of
> svc_process_common() to handle NFSD workloads more efficiently. In
> other words, NFSD should be the lubricated common case, and callback
> is the use case that takes exceptional paths.
> 
> Note: For the moment these are compile-tested only.
> 
> There are some additional clean-ups that will be possible once this
> series is merged. See
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-xdr-stream
> 
> for follow-on work.
> 
> ---
> 
> Chuck Lever (7):
>       SUNRPC: Add svc_rqst::rq_auth_stat
>       SUNRPC: Set rq_auth_stat in the pg_authenticate() callout
>       SUNRPC: Eliminate the RQ_AUTHERR flag
>       NFS: Add a private local dispatcher for NFSv4 callback operations
>       NFS: Remove unused callback void encoder and decoder
>       NFS: Extract the xdr_init_encode/decode() calls from decode_compound
>       NFS: Clean up the synopsis of callback process_op()
> 
> 
>  fs/lockd/svc.c                    |  2 +
>  fs/nfs/callback.c                 |  4 ++
>  fs/nfs/callback_xdr.c             | 64 ++++++++++++++-----------------
>  include/linux/sunrpc/svc.h        |  3 +-
>  include/linux/sunrpc/svcauth.h    |  4 +-
>  include/trace/events/sunrpc.h     |  9 ++---
>  net/sunrpc/auth_gss/svcauth_gss.c | 47 ++++++++++++-----------
>  net/sunrpc/svc.c                  | 39 ++++++-------------
>  net/sunrpc/svcauth.c              |  8 ++--
>  net/sunrpc/svcauth_unix.c         | 18 +++++----
>  10 files changed, 92 insertions(+), 106 deletions(-)
> 
> --
> Chuck Lever
