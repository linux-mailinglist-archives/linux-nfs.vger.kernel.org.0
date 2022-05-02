Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604EB517413
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243352AbiEBQUy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 12:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386243AbiEBQUq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 12:20:46 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B0FDFAB
        for <linux-nfs@vger.kernel.org>; Mon,  2 May 2022 09:17:14 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E5F3E6CCD; Mon,  2 May 2022 12:17:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E5F3E6CCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651508233;
        bh=HbQWCtBRxcfJAUKd02jWRBKGaLkl1/d/Wwh9A9Rh4q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITGa+iAlUGE+BUMc7XRmzUx7DQycokkpwtsDOPtWRJ01LL1NGTioY6cdNwYRHiXK2
         5Bi+MteluEXJNLJbGutquXhifMuunh+dRex3P+aNn465I3GrZz6XlrNVLn3rY1skAX
         kZeYNJt7bcZfJd+wh9DfZRo0Y3Na//nAD4ow0Ma8=
Date:   Mon, 2 May 2022 12:17:13 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org, david@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, steved@redhat.com,
        chris.chilvers@appsbroker.com
Subject: Re: [PATCH 0/5] nfs-utils: Improving NFS re-exports
Message-ID: <20220502161713.GI30550@fieldses.org>
References: <20220502085045.13038-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502085045.13038-1-richard@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 02, 2022 at 10:50:40AM +0200, Richard Weinberger wrote:
> This is the first non-RFC iteration of the NFS re-export
> improvement series for nfs-utils.
> While the kernel side[0] didn't change at all and is still small,
> the userspace side saw much more changes.
> 
> The core idea is adding new export option: reeport=
> Using reexport= it is possible to mark an export entry in the exports
> file explicitly as NFS re-export and select a strategy how unique
> identifiers should be provided.
> Currently two strategies are supported, "auto-fsidnum" and
> "predefined-fsidnum", both use a SQLite database as backend to keep
> track of generated ids.
> For a more detailed description see patch "exports: Implement new export option reexport=".
> I choose SQLite because nfs-utils already uses it and using SQL ids can nicely
> generated and maintained. It will also scale for large setups where the amount
> of subvolumes is high.
> 
> Beside of id generation this series also addresses the reboot problem.
> If the re-exporting NFS server reboots, uncovered NFS subvolumes are not yet
> mounted and file handles become stale.
> Now mountd/exportd keeps track of uncovered subvolumes and makes sure they get
> uncovered while nfsd starts.
> 
> The whole set of features is currently opt-in via --enable-reexport.

Can we remove that option before upstreaming?

For testing purposes it may makes sense to be able to turn the new code
on and off quickly.  But for something we're really going to support,
it's just another hurdle for users to jump through, and another case we
probably won't remember to test.  The export options themselves should
be enough configuration.

Anyway, basically sounds reasonable to me.  I'll try to give it a proper
review sometime, feel free to bug me if I don't get to it in a week or
so.

--b.


> I'm also not sure about the rearrangement of the reexport code,
> currently it is a helper library.
> 
> A typical export entry on a re-exporting server looks like:
> 	/nfs *(rw,no_root_squash,no_subtree_check,crossmnt,reexport=auto-fsidnum)
> reexport=auto-fsidnum will automatically assign an fsid= to /nfs and all
> uncovered subvolumes.
> 
> Richard Weinberger (5):
>   Implement reexport helper library
>   exports: Implement new export option reexport=
>   export: Implement logic behind reexport=
>   export: Avoid fsid= conflicts
>   reexport: Make state database location configurable
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git/log/?h=nfs_reexport_clean
> 
>  configure.ac                   |  12 ++
>  nfs.conf                       |   3 +
>  support/Makefile.am            |   4 +
>  support/export/Makefile.am     |   2 +
>  support/export/cache.c         |  71 ++++++-
>  support/export/export.c        |  27 ++-
>  support/include/nfslib.h       |   1 +
>  support/nfs/Makefile.am        |   1 +
>  support/nfs/exports.c          |  68 +++++++
>  support/reexport/Makefile.am   |   6 +
>  support/reexport/reexport.c    | 354 +++++++++++++++++++++++++++++++++
>  support/reexport/reexport.h    |  39 ++++
>  systemd/Makefile.am            |   4 +
>  systemd/nfs-server-generator.c |  14 +-
>  systemd/nfs.conf.man           |   6 +
>  utils/exportd/Makefile.am      |   8 +-
>  utils/exportd/exportd.c        |   5 +
>  utils/exportfs/Makefile.am     |   6 +
>  utils/exportfs/exportfs.c      |  21 +-
>  utils/exportfs/exports.man     |  31 +++
>  utils/mount/Makefile.am        |   7 +
>  utils/mountd/Makefile.am       |   6 +
>  utils/mountd/mountd.c          |   1 +
>  utils/mountd/svc_run.c         |   6 +
>  24 files changed, 690 insertions(+), 13 deletions(-)
>  create mode 100644 support/reexport/Makefile.am
>  create mode 100644 support/reexport/reexport.c
>  create mode 100644 support/reexport/reexport.h
> 
> -- 
> 2.31.1
