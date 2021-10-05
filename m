Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DFB422ED5
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 19:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJERPu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 13:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhJERPu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Oct 2021 13:15:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B77F36117A
        for <linux-nfs@vger.kernel.org>; Tue,  5 Oct 2021 17:13:59 +0000 (UTC)
Subject: [PATCH RFC 0/5] Update RPC task pid as displayed by tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Oct 2021 13:13:58 -0400
Message-ID: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

So based on Trond's earlier comment, this is what I've come up with.
These apply on top of the three patches Trond has already accepted.

I kind of wanted to do "task:%04x@%04x", but the "-1" still displays
as "ffffffff", so I left it as "task:%08x@%08x" to keep the fields
lined up in aligned columns. Any different ideas are welcome.

There are a couple of other fix-ups I found while working on this
update, and I've also included an optional patch to add the
nfs_readpage(s) tracepoints I found useful while tracking down
recent fsx failures.

---

Chuck Lever (5):
      SUNRPC: Tracepoints should display tk_pid and cl_clid as a fixed-size field
      SUNRPC: Avoid NULL pointer dereferences in tracepoints
      SUNRPC: Use BIT() macro in rpc_show_xprt_state()
      SUNRPC: Don't dereference xprt->snd_task if it's a cookie
      NFS: Replace dprintk callsites in nfs_readpage(s)


 fs/nfs/nfs4trace.h                 |  17 ++-
 fs/nfs/nfstrace.h                  |  79 ++++++++++++-
 fs/nfs/read.c                      |   8 +-
 include/trace/events/rpcgss.h      |  36 +++---
 include/trace/events/rpcrdma.h     | 104 +++++++----------
 include/trace/events/sunrpc.h      | 182 +++++++++++++----------------
 include/trace/events/sunrpc_base.h |  42 +++++++
 7 files changed, 265 insertions(+), 203 deletions(-)
 create mode 100644 include/trace/events/sunrpc_base.h

--
Chuck Lever

