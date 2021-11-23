Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EFE45A610
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 15:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhKWOxF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 09:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhKWOxF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Nov 2021 09:53:05 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173BC061574
        for <linux-nfs@vger.kernel.org>; Tue, 23 Nov 2021 06:49:57 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4157832EC; Tue, 23 Nov 2021 09:49:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4157832EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637678996;
        bh=oW3+zy8J0lwbotUqbynLTKo85SyUQ3edRIRxuxlprwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=St6k8F9D0Ov31cb6xgZRtkVg5eudl1hofSbWiwcowNwUXfIaAI/+Amt5CFnj6latO
         gWNwu9Rg2i0t23R7tG0NJaG90BIScKDLPfNqlTEqUet21GG5p2rH81jm2ODh59upDE
         ZcaWXV+npirVEr1ZitCAxT/CBS6FascMojaiEdHA=
Date:   Tue, 23 Nov 2021 09:49:56 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 00/19 v2] SUNRPC: clean up server thread management
Message-ID: <20211123144956.GA8978@fieldses.org>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 23, 2021 at 12:29:35PM +1100, NeilBrown wrote:
> This is a revision of my series for cleaning up server thread
> management.

For what it's worth, this version now passes my usual regression tests.

--b.

> Currently lockd, nfsd, and nfs-callback all manage threads slightly
> differently.  This series unifies them.
> 
> Changes since first series include:
>   - minor bug fixes
>   - kernel-doc comments for new functions
>   - split first patch into 3, and make the bugfix a separate patch
>   - fix management of pool_maps so lockd can usse svc_set_num_threads
>     safely
>   - switch nfs-callback to not request a 'pooled' service.
> 
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (19):
>       SUNRPC/NFSD: clean up get/put functions.
>       NFSD: handle error better in write_ports_addfd()
>       SUNRPC: stop using ->sv_nrthreads as a refcount
>       nfsd: make nfsd_stats.th_cnt atomic_t
>       SUNRPC: use sv_lock to protect updates to sv_nrthreads.
>       NFSD: narrow nfsd_mutex protection in nfsd thread
>       NFSD: Make it possible to use svc_set_num_threads_sync
>       SUNRPC: discard svo_setup and rename svc_set_num_threads_sync()
>       NFSD: simplify locking for network notifier.
>       lockd: introduce nlmsvc_serv
>       lockd: simplify management of network status notifiers
>       lockd: move lockd_start_svc() call into lockd_create_svc()
>       lockd: move svc_exit_thread() into the thread
>       lockd: introduce lockd_put()
>       lockd: rename lockd_create_svc() to lockd_get()
>       SUNRPC: move the pool_map definitions (back) into svc.c
>       SUNRPC: always treat sv_nrpools==1 as "not pooled"
>       lockd: use svc_set_num_threads() for thread start and stop
>       NFS: switch the callback service back to non-pooled.
> 
> 
>  fs/lockd/svc.c             | 194 ++++++++++++-------------------------
>  fs/nfs/callback.c          |  12 +--
>  fs/nfsd/netns.h            |  13 +--
>  fs/nfsd/nfsctl.c           |  24 ++---
>  fs/nfsd/nfssvc.c           | 139 +++++++++++++-------------
>  fs/nfsd/stats.c            |   2 +-
>  fs/nfsd/stats.h            |   4 +-
>  include/linux/sunrpc/svc.h |  58 ++++-------
>  net/sunrpc/svc.c           | 166 ++++++++++++++-----------------
>  9 files changed, 248 insertions(+), 364 deletions(-)
> 
> --
> Signature
