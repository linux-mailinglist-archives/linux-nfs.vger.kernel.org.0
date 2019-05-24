Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2005729C7C
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2019 18:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390448AbfEXQsA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 May 2019 12:48:00 -0400
Received: from fieldses.org ([173.255.197.46]:33266 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390346AbfEXQsA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 24 May 2019 12:48:00 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 5916FBD2; Fri, 24 May 2019 12:47:59 -0400 (EDT)
Date:   Fri, 24 May 2019 12:47:59 -0400
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     "J . Bruce Fields" <bfields@redhat.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] NLM fl_pid fixup
Message-ID: <20190524164759.GA23881@fieldses.org>
References: <cover.1558622651.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558622651.git.bcodding@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 23, 2019 at 10:45:43AM -0400, Benjamin Coddington wrote:
> This series aims to correct the fl_pid value for locks held by the NLM
> server, or lockd.  It applies onto the revert of the previous attempt to fix
> this problem sent ealier this week: '[PATCH] Revert "lockd: Show pid of
> lockd for remote locks"'.
> 
> The problem with the earlier attempt was that we discarded the svid, and so
> we couldn't distinguish remote lockowners on each host.  It is necessary to
> turn the svid and host into a distinct owner.

So, to make sure I understand, we've got multiple ways to identify a
lock owner:

	- the svid, the pid of the client process: this gets returned to
	  the client in grant callbacks and (possibly to a different
	  client) in testd results.
	- the pid of the server's lockd process: this is what other
	  processes on the server see as the owner of locks held by nfs
	  clients.
	- the nlm_lockowner: a (nlm_host, svid) pair, used to actually
	  decide when locks conflict.

Makes sense to me.

I'll send your earlier revert to stable, then add this on top for the
5.3 merge window.  Sound OK?

--b.

> 
> We can take a page from the NLM client and make an allocation to track the
> svid and host together, which is what we do here.  The mechanisms to do so
> aren't quite similar enough to generalize, but I did share the nlm_lockowner
> structure.  There is one field unsed on the server: nlm_lockowner.owner.
> 
> It turns out that the LTP's testcases/network/nfsv4/locks/locktests.c was
> useful for testing this, as it coordinates locking tests amongst NFS
> clients.
> 
> Changes on:
> 	v2 - Fixed typos in commit log messages, and whitespace.
> 
> Benjamin Coddington (5):
>   lockd: prepare nlm_lockowner for use by the server
>   lockd: Convert NLM service fl_owner to nlm_lockowner
>   lockd: Remove lm_compare_owner and lm_owner_key
>   lockd: Show pid of lockd for remote locks
>   locks: Cleanup lm_compare_owner and lm_owner_key
> 
>  Documentation/filesystems/Locking |  14 ----
>  fs/lockd/clntproc.c               |  21 +++---
>  fs/lockd/svc4proc.c               |  14 +++-
>  fs/lockd/svclock.c                | 118 +++++++++++++++++++++++++-----
>  fs/lockd/svcproc.c                |  14 +++-
>  fs/lockd/svcsubs.c                |   2 +-
>  fs/lockd/xdr.c                    |   3 -
>  fs/lockd/xdr4.c                   |   3 -
>  fs/locks.c                        |   5 --
>  include/linux/fs.h                |   2 -
>  include/linux/lockd/lockd.h       |   2 +
>  11 files changed, 138 insertions(+), 60 deletions(-)
> 
> -- 
> 2.20.1
