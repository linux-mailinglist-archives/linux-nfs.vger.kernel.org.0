Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EBD3C87F7
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jul 2021 17:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbhGNPxE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jul 2021 11:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239625AbhGNPxE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Jul 2021 11:53:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58AC66128D
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jul 2021 15:50:12 +0000 (UTC)
Subject: [PATCH RFC 0/4] Ensure RPC_TASK_NORTO is disabled for select
 operations
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 14 Jul 2021 11:50:11 -0400
Message-ID: <162627611661.1294.9189768423517916152.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a set of patches I've been toying with to get better
responsiveness from a client when a transport remains connected but
the server is not returning RPC replies.

The approach I've taken is to disable RPC_TASK_NO_RETRANS_TIMEOUT
for a few particular operations to enable them to time out even
though the connection is still operational. It could be
appropriate to take this approach for any idempotent operation
that cannot be killed with a ^C.

The test is simply to mount the addled server with NFSv4.1, sec=sys,
and TCP. Both sides happen to have keytabs, so Kerberos is used to
protect lease management operations.

       mount.nfs-1181  [004]    65.367559: rpc_request:          task:1@1 nfsv4 NULL (sync)
       mount.nfs-1181  [004]    65.369735: rpc_task_end:         task:1@1 flags=NULLCREDS|DYNAMIC|SOFT|SOFTCONN|SENT|CRED_NOREF runstate=RUNNING|ACTIVE status=0 action=rpc_exit_task
       mount.nfs-1181  [004]    65.369830: rpc_request:          task:2@1 nfsv4 EXCHANGE_ID (sync)
       mount.nfs-1181  [004]    65.616381: rpc_task_end:         task:2@1 flags=DYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NOREF runstate=RUNNING|ACTIVE status=0 action=rpc_exit_task
 192.168.2.55-ma-1196  [009]    65.616467: rpc_request:          task:3@1 nfsv4 EXCHANGE_ID (sync)
 192.168.2.55-ma-1196  [009]    65.616706: rpc_task_end:         task:3@1 flags=DYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NOREF runstate=RUNNING|ACTIVE status=0 action=rpc_exit_task
 192.168.2.55-ma-1196  [009]    65.616722: rpc_request:          task:4@1 nfsv4 CREATE_SESSION (sync)
 192.168.2.55-ma-1196  [009]    65.616963: rpc_task_end:         task:4@1 flags=DYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NOREF runstate=RUNNING|ACTIVE status=0 action=rpc_exit_task
 192.168.2.55-ma-1196  [009]    65.616995: rpc_request:          task:5@1 nfsv4 RECLAIM_COMPLETE (sync)
 192.168.2.55-ma-1196  [009]    65.618621: rpc_task_end:         task:5@1 flags=DYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|NORTO|CRED_NOREF runstate=RUNNING|ACTIVE status=0 action=rpc_exit_task
       mount.nfs-1181  [004]    65.618642: rpc_request:          task:6@2 nfsv4 LOOKUP_ROOT (sync)
       mount.nfs-1181  [004]    65.619940: rpc_task_end:         task:6@2 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|ACTIVE status=0 action=rpc_exit_task
       mount.nfs-1181  [004]    65.619951: rpc_request:          task:7@2 nfsv4 SERVER_CAPS (sync)
       mount.nfs-1181  [004]    65.620041: rpc_task_end:         task:7@2 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|ACTIVE status=0 action=rpc_exit_task
       mount.nfs-1181  [004]    65.620049: rpc_request:          task:8@2 nfsv4 FSINFO (sync)

Server stops replying.

   kworker/u26:0-47    [009]    70.944662: rpc_request:          task:9@1 nfsv4 SEQUENCE (async)

Client wonders what's up.

       mount.nfs-1181  [004]    76.367642: rpc_task_end:         task:8@2 flags=MOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=RUNNING|ACTIVE|NEED_RECV|SIGNALLED status=-512 action=rpc_exit_task

User ^C's the mount.nfs command.

  kworker/u25:10-213   [000]   251.165539: rpc_task_end:         task:9@1 flags=ASYNC|MOVEABLE|DYNAMIC|SOFT|SENT|TIMEOUT runstate=RUNNING|ACTIVE|NEED_RECV status=-110 action=rpc_exit_task
  kworker/u25:10-213   [000]   251.165553: rpc_request:          task:10@1 nfsv4 DESTROY_SESSION (sync)

Client attempts to tear down the nfs_client since there are no more
mounts of that server and the lease renewal query has finally timed
out.

  kworker/u25:10-213   [001]   431.386315: rpc_task_end:         task:10@1 flags=DYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|CRED_NOREF runstate=RUNNING|ACTIVE|NEED_RECV status=-110 action=rpc_exit_task
  kworker/u25:10-213   [001]   431.386339: rpc_request:          task:11@1 nfsv4 DESTROY_CLIENTID (sync)
  kworker/u25:10-213   [001]   611.607170: rpc_task_end:         task:11@1 flags=DYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|CRED_NOREF runstate=RUNNING|ACTIVE|NEED_RECV status=-110 action=rpc_exit_task
   kworker/u25:1-1205  [000]   611.607253: rpc_request:          task:12@1 nfsv4 NULL (async)

Client sends GSS_DESTROY_CTX for the lease management GSS context.

   kworker/u25:1-1205  [000]   791.827916: rpc_task_end:         task:12@1 flags=ASYNC|NULLCREDS|DYNAMIC|SOFT|SOFTCONN|SENT runstate=RUNNING|ACTIVE|NEED_RECV status=-5 action=rpc_exit_task
     kworker/0:2-215   [000]   791.828351: xprt_destroy:         peer=[192.168.2.55]:2049 state=LOCKED|CONNECTED|BOUND

It's not until task:12@1 exits that the client can finally complete
the destruction of the RPC transport and the nfs_client. It takes
about 12 minutes from the ^C before the client's state is finally
completely cleaned up.

NB: For NFS/RDMA mounts, during that time the client can't complete
a system shutdown because the rpc_xprt holds hardware resources that
block driver removal.

---

Chuck Lever (4):
      NFS: Unset RPC_TASK_NO_RETRANS_TIMEOUT for async lease renewal
      NFS: Unset RPC_TASK_NO_RETRANS_TIMEOUT for session/clientid destruction
      SUNRPC: Refactor rpc_ping()
      SUNRPC: Unset RPC_TASK_NO_RETRANS_TIMEOUT for NULL RPCs


 fs/nfs/nfs4client.c |  1 +
 fs/nfs/nfs4proc.c   |  9 +++++++++
 net/sunrpc/clnt.c   | 33 ++++++++++++++++++++++++---------
 3 files changed, 34 insertions(+), 9 deletions(-)

--
Chuck Lever

