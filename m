Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6497A6164C
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2019 21:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfGGT0a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Jul 2019 15:26:30 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43649 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbfGGT0a (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Jul 2019 15:26:30 -0400
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        by mx.molgen.mpg.de (Postfix) with ESMTP id DE5FD2000C012;
        Sun,  7 Jul 2019 21:26:27 +0200 (CEST)
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Cc:     Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH V2 0/4] nfs4.0: Refetch lease_time after clientID reset
Date:   Sun,  7 Jul 2019 21:26:06 +0200
Message-Id: <20190707192610.14335-1-buczek@molgen.mpg.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

V2: Make sure, code doesn't depend on CONFIG_NFS_V4_1. I've scattered
#endifs and #ifdefs into the source instead of moving code into other
areas to be more friendly to git. Tell me if you prefer otherwise.

Currently, nfs mounts with vers=4.0 do not pick up a updated
lease_time after a restart of the nfs server. This was discussed in
the thread "4.0 client and server restart with decreased lease time" on
linux-nfs [1].

This patch set fixes the issue for nsf4.0 clients so that hey behave as
nfs4.1 and nfs4.2 clients do.  After a new clientID is established, the
lease_time is re-fetched and used.

Tested with

    CONFIG_NFS_V4=m CONFIG_NFS_V4_1=y CONFIG_NFS_V4_2=y   : mount
    CONFIG_NFS_V4=m CONFIG_NFS_V4_1=y CONFIG_NFS_V4_2=y   : mount vers=4.0
    CONFIG_NFS_V4=m CONFIG_NFS_V4_1=y CONFIG_NFS_V4_2=n   : mount
    CONFIG_NFS_V4=m CONFIG_NFS_V4_1=y CONFIG_NFS_V4_2=n   : mount vers=4.0
    CONFIG_NFS_V4=m CONFIG_NFS_V4_1=n CONFIG_NFS_V4_2=n   : mount

and several restarts of the nfs server with changed leases times, which
were picked up by the client.

[1] https://marc.info/?t=154954022700002&r=1&w=2

Donald Buczek (4):
  nfs: Fix copy-and-paste error in debug message
  nfs4: Make nfs4_proc_get_lease_time available for nfs4.0
  nfs4: Rename nfs41_setup_state_renewal
  nfs4.0: Refetch lease_time after clientid update

 fs/nfs/nfs4_fs.h   |  4 ++--
 fs/nfs/nfs4proc.c  |  6 +++++-
 fs/nfs/nfs4state.c | 46 +++++++++++++++++++++++-----------------------
 fs/nfs/nfs4xdr.c   | 14 ++++++++++++--
 4 files changed, 42 insertions(+), 28 deletions(-)

-- 
2.22.0

