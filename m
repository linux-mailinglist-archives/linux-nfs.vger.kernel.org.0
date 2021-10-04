Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4E421104
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 16:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhJDOLm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 10:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhJDOLl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 10:11:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49777611C1;
        Mon,  4 Oct 2021 14:09:52 +0000 (UTC)
Subject: [PATCH 0/4] A collection of NFS client tracepoint patches
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Oct 2021 10:09:51 -0400
Message-ID: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

This series proposes a small handful of tracepoint-related changes.

The first patch is clean-up.

The second and third patches are part of the ongoing effort to
replace dprintk with tracepoints.

The last patch adds some tracepoints I found useful while diagnosing
the recent NFSv3 fsx failures.

---

Chuck Lever (4):
      NFS: Remove unnecessary TRACE_DEFINE_ENUM()s
      SUNRPC: Tracepoints should store tk_pid and cl_clid as a signed int
      SUNRPC: Per-rpc_clnt task PIDs
      NFS: Instrument i_size_write()


 fs/nfs/inode.c                 |   9 +--
 fs/nfs/nfs4trace.h             |  12 +--
 fs/nfs/nfstrace.h              | 122 ++++++++++++----------------
 fs/nfs/write.c                 |   1 +
 include/linux/sunrpc/clnt.h    |   3 +-
 include/trace/events/rpcgss.h  |  30 +++----
 include/trace/events/rpcrdma.h |  90 ++++++++++-----------
 include/trace/events/sunrpc.h  | 140 ++++++++++++++++-----------------
 net/sunrpc/sched.c             |  12 ++-
 9 files changed, 204 insertions(+), 215 deletions(-)

--
Chuck Lever

