Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8703E2E9C3
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfE3AnF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:43:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:46376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3AnF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:43:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C34FAC66;
        Thu, 30 May 2019 00:43:03 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 30 May 2019 10:41:28 +1000
Subject: [PATCH 0/9] Multiple network connections for a single NFS mount.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <155917564898.3988.6096672032831115016.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch set is based on the patches in the multipath_tcp branch of
 git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git

I'd like to add my voice to those supporting this work and wanting to
see it land.
We have had customers/partners wanting this sort of functionality for
years.  In SLES releases prior to SLE15, we've provide a
"nosharetransport" mount option, so that several filesystem could be
mounted from the same server and each would get its own TCP
connection.
In SLE15 we are using this 'nconnect' feature, which is much nicer.

Partners have assured us that it improves total throughput,
particularly with bonded networks, but we haven't had any concrete
data until Olga Kornievskaia provided some concrete test data - thanks
Olga!

My understanding, as I explain in one of the patches, is that parallel
hardware is normally utilized by distributing flows, rather than
packets.  This avoid out-of-order deliver of packets in a flow.
So multiple flows are needed to utilizes parallel hardware.

An earlier version of this patch set was posted in April 2017 and
Chuck raised two issues:
 1/ mountstats only reports on one xprt per mount
 2/ session establishment needs to happen on a single xprt, as you
    cannot bind other xprts to the session until the session is
    established.
I've added patches to address these, and also to add the extra xprts
to the debugfs info.

I've also re-arrange the patches a bit, merged two, and remove the
restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
these restrictions were not needed, I can see no need.

There is a bug with the load balancing code from Trond's tree.
While an xprt is attached to a client, the queuelen is incremented.
Some requests (particularly BIND_CONN_TO_SESSION) pass in an xprt,
and the queuelen was not incremented in this case, but it was
decremented.  This causes it to go 'negative' and havoc results.

I wonder if the last three patches (*Allow multiple connection*) could
be merged into a single patch.

I haven't given much thought to automatically determining the optimal
number of connections, but I doubt it can be done transparently with
any reliability.  When adding a connection improves throughput, then
it was almost certainly a good thing to do. When adding a connection
doesn't improve throughput, the implications are less obvious.
My feeling is that a protocol enhancement where the serve suggests an
upper limit and the client increases toward that limit when it notices
xmit backlog, would be about the best we could do.  But we would need
a lot more experience with the functionality first.

Comments most welcome.  I'd love to see this, or something similar,
merged.

Thanks,
NeilBrown

---

NeilBrown (4):
      NFS: send state management on a single connection.
      SUNRPC: enhance rpc_clnt_show_stats() to report on all xprts.
      SUNRPC: add links for all client xprts to debugfs

Trond Myklebust (5):
      SUNRPC: Add basic load balancing to the transport switch
      SUNRPC: Allow creation of RPC clients with multiple connections
      NFS: Add a mount option to specify number of TCP connections to use
      NFSv4: Allow multiple connections to NFSv4.x servers
      pNFS: Allow multiple connections to the DS
      NFS: Allow multiple connections to a NFSv2 or NFSv3 server


 fs/nfs/client.c                      |    3 +
 fs/nfs/internal.h                    |    2 +
 fs/nfs/nfs3client.c                  |    1 
 fs/nfs/nfs4client.c                  |   13 ++++-
 fs/nfs/nfs4proc.c                    |   22 +++++---
 fs/nfs/super.c                       |   12 ++++
 include/linux/nfs_fs_sb.h            |    1 
 include/linux/sunrpc/clnt.h          |    1 
 include/linux/sunrpc/sched.h         |    1 
 include/linux/sunrpc/xprt.h          |    1 
 include/linux/sunrpc/xprtmultipath.h |    2 +
 net/sunrpc/clnt.c                    |   98 ++++++++++++++++++++++++++++++++--
 net/sunrpc/debugfs.c                 |   46 ++++++++++------
 net/sunrpc/sched.c                   |    3 +
 net/sunrpc/stats.c                   |   15 +++--
 net/sunrpc/sunrpc.h                  |    3 +
 net/sunrpc/xprtmultipath.c           |   23 +++++++-
 17 files changed, 204 insertions(+), 43 deletions(-)

--
Signature

