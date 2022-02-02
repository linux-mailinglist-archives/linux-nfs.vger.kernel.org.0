Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965384A69C0
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Feb 2022 03:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243333AbiBBCAO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Feb 2022 21:00:14 -0500
Received: from peace.netnation.com ([204.174.223.2]:57916 "EHLO
        peace.netnation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiBBCAN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Feb 2022 21:00:13 -0500
X-Greylist: delayed 1137 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Feb 2022 21:00:13 EST
Received: from sim by peace.netnation.com with local (Exim 4.92)
        (envelope-from <sim@hostway.ca>)
        id 1nF4dz-0006vM-UM
        for linux-nfs@vger.kernel.org; Tue, 01 Feb 2022 17:41:11 -0800
Date:   Tue, 1 Feb 2022 17:41:11 -0800
From:   Simon Kirby <sim@hostway.ca>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Cache flush on file lock
Message-ID: <20220202014111.GA7467@hostway.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello!

I noticed high traffic in an NFS environment and tracked it down to some
users who moved SQLite databases over from previously-local storage.

The usage pattern of SQLite here seems particularly bad on NFSv3 clients,
where a combination of F_RDLCK to F_WRLCK upgrading and locking polling
is entirely discarding the cache for other processes on the same client.

Our load balancing configuration typically sticks most file accesses to
individual hosts (NFS clients), so I figured it was time to re-evaluate
the status of NFSv4 and file delegations here, since the files could be
delegated to one client, and then maybe the page cache could work as it
does on a local file system. It turns out this isn't happening...

First, it seems that SQLite always opens the file O_RDWR. knfsd does not
seem to create a delegation in this case; I see it only for O_RDONLY.

Second, it seems that do_setlk() in fs/nfs/file.c always nfs_zap_caches()
unless there's a ->have_delegation(inode, FMODE_READ). That condition has
changed slightly over the years, but the basic concept of invalidating
the cache in do_setlk has been around since pre-git.

Since it seems like there's the intention to preserve cache with a read
delegation, I wrote a simplified testcase to simulate SQLite locking.

With the open changed to O_RDONY (and F_RDLCK only), the v3 mount and
server show "POSIX ADVISORY READ" in /proc/locks. The v4 mount shows
"DELEG ACTIVE READ" on the server and "POSIX ADVISORY READ" on the
client.

With O_RDONLY, I can see that cache is zapped following F_RDLCK on v3 and
not zapped on v4, so this appears to be working as expected.

With O_RDWR restored, both server and client show "POSIX ADVISORY READ"
with v3 or v4 mounts, and since there is no read delegation, the cache
gets zapped.

RFC 8881 10.4.2 seems to talk about locking when an OPEN_DELEGATE_WRITE
delegation is present, so it seems this was perhaps intended to work.

How far off would we be from write delegations happening here?

I can post the testcase code if it would be helpful.

Simon-
