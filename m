Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E44BA602
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 17:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbiBQQdv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 11:33:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiBQQdv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 11:33:51 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74092B2C6A
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 08:33:33 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 48BCC6CD5; Thu, 17 Feb 2022 11:33:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 48BCC6CD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1645115612;
        bh=5qKalY3QxBx1IY9Lj/2mFGqEQOZq5BFaea6tO27X7gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPaXF+4Wvff7FolqSJ/MeHifyC05tEigtnZVUa8t2v1nHYPVB3t/XKTZEEHf44gWU
         hQWpkmX+rJWRSNuw+XyiWBQzJPNPX7hplk+o3rckI+uMmKJZxRL98xgtTtWCzRvY57
         im5nfehIWapDPm7GQiROO879Mf5Amsq3fiRStQTQ=
Date:   Thu, 17 Feb 2022 11:33:32 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org, david@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com
Subject: Re: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports
Message-ID: <20220217163332.GA16497@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217131531.2890-1-richard@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 17, 2022 at 02:15:25PM +0100, Richard Weinberger wrote:
> This is the second iteration of the NFS re-export improvement series for nfs-utils.
> While the kernel side didn't change at all and is still small,
> the userspace side saw much more changes.
> Please note that this is still an RFC, there is room for improvement.
> 
> The core idea is adding new export option: reeport=
> Using reexport= it is possible to mark an export entry in the exports file
> explicitly as NFS re-export and select a strategy how unique identifiers
> should be provided.
> "remote-devfsid" is the strategy I have proposed in my first patch,
> I understand that this one is dangerous. But I still find it useful in some
> situations.
> "auto-fsidnum" and "predefined-fsidnum" are new and use a SQLite database as
> backend to keep track of generated ids.
> For a more detailed description see patch "exports: Implement new export option reexport=".

Thanks, I'll try to take a look.

Before upstreaming, I would like us to pick just one.  These kind of
options tend to complicate testing and documentation and debugging.

For an RFC, though, I think it makes sense, so I'm fine with keeping
"reexport=" while we're still exploring the different options.  And,
hey, maybe we end up adding more than one after we've upstreamed the
first one.

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
> I'm also not sure about the rearrangement of the reexport code,
> currently it is a helper library.
> 
> Please let me know whether you like this approach.
> If so I'd tidy it up and submit it as non-RFC.
> 
> TODOs/Open questions:
> - When re-exporting, fs.nfs.nfs_mountpoint_timeout should be set to 0
>   to make subvolumes not vanish.
>   Is this something exportfs should do automatically when it sees an export entry with a reexport= option?

Setting the timeout to 0 doesn't help with re-export server reboots.
After a reboot is another case where we could end up in a situation
where a client hands us a filehandle for a filesystem that isn't mounted
yet.

I think you want to keep a path with each entry in the database.  When
mountd gets a request for a filesystem it hasn't seen before, it stats
that path, which should trigger the automounts.

And it'd be good to have a test case with a client (Linux client or
pynfs) that, say, opens a file several mounts deep, then reboots the
reexport server, then tries to, say, write to the file descriptor after
the reboot.  (Or maybe there's a way to force the mounts to expire as a
shortcut instead of doing a full reboot.)

> - exportd saw only minimal testing so far, I wasn't aware of it yet. :-S
> - Currently wtere is no way to release the shared memory which contains the database lock.
>   I guess it could be released via exportfs -f, which is the very last exec in nfs-server.service
> - Add a tool to import/export entries from the reexport database which obeys the shared lock.
> - When doing v4->v4 or v3->v4 re-exports very first read access to a file block a few seconds until
>   the client does a retransmit. 
>   v3->v3 works fine. More investigation needed.

Might want to strace mountd and look at the communication over the
/proc/fs/nfsd/*/channel files, maybe mountd is failing to respond to an
upcall.

--b.

> 
> Looking forward for your feedback!
> 
> Thanks,
> //richard
> 
> Richard Weinberger (6):
>   Implement reexport helper library
>   exports: Implement new export option reexport=
>   export: Implement logic behind reexport=
>   export: Record mounted volumes
>   nfsd: statfs() every known subvolume upon start
>   export: Garbage collect orphaned subvolumes upon start
> 
>  configure.ac                 |  12 +
>  support/Makefile.am          |   4 +
>  support/export/Makefile.am   |   2 +
>  support/export/cache.c       | 241 +++++++++++++++++-
>  support/export/export.h      |   3 +
>  support/include/nfslib.h     |   1 +
>  support/nfs/Makefile.am      |   1 +
>  support/nfs/exports.c        |  73 ++++++
>  support/reexport/Makefile.am |   6 +
>  support/reexport/reexport.c  | 477 +++++++++++++++++++++++++++++++++++
>  support/reexport/reexport.h  |  53 ++++
>  utils/exportd/Makefile.am    |   8 +-
>  utils/exportd/exportd.c      |  17 ++
>  utils/exportfs/Makefile.am   |   4 +
>  utils/mount/Makefile.am      |   6 +
>  utils/mountd/Makefile.am     |   6 +
>  utils/mountd/mountd.c        |   1 +
>  utils/mountd/svc_run.c       |  18 ++
>  utils/nfsd/Makefile.am       |   6 +
>  utils/nfsd/nfsd.c            |  10 +
>  20 files changed, 934 insertions(+), 15 deletions(-)
>  create mode 100644 support/reexport/Makefile.am
>  create mode 100644 support/reexport/reexport.c
>  create mode 100644 support/reexport/reexport.h
> 
> -- 
> 2.31.1
