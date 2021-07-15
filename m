Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB73CAD3F
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 21:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbhGOT4M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 15:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345577AbhGOTyz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Jul 2021 15:54:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 722DE6128A;
        Thu, 15 Jul 2021 19:52:01 +0000 (UTC)
Subject: [PATCH v2 0/7] XDR overhaul of NFS callback service
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 15 Jul 2021 15:52:00 -0400
Message-ID: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond, please let me know if you want to take these or if I may
handle them through the NFSD tree for v5.15. Thanks.


The purpose of this series is to prepare for the optimization of
svc_process_common() to handle NFSD workloads more efficiently. In
other words, NFSD should be the lubricated common case, and callback
is the use case that takes exceptional paths.

Changes since RFC:
- Removed RQ_DROPME test from nfs_callback_dispatch()
- Restored .pc_encode call-outs to prevent dropped replies
- Fixed whitespace damage

---

Chuck Lever (7):
      SUNRPC: Add svc_rqst::rq_auth_stat
      SUNRPC: Set rq_auth_stat in the pg_authenticate() callout
      SUNRPC: Eliminate the RQ_AUTHERR flag
      NFS: Add a private local dispatcher for NFSv4 callback operations
      NFS: Remove unused callback void decoder
      NFS: Extract the xdr_init_encode/decode() calls from decode_compound
      NFS: Clean up the synopsis of callback process_op()


 fs/lockd/svc.c                    |  2 +
 fs/nfs/callback.c                 |  4 ++
 fs/nfs/callback_xdr.c             | 61 ++++++++++++++++---------------
 include/linux/sunrpc/svc.h        |  3 +-
 include/linux/sunrpc/svcauth.h    |  4 +-
 include/trace/events/sunrpc.h     |  9 ++---
 net/sunrpc/auth_gss/svcauth_gss.c | 47 +++++++++++++-----------
 net/sunrpc/svc.c                  | 39 ++++++--------------
 net/sunrpc/svcauth.c              |  8 ++--
 net/sunrpc/svcauth_unix.c         | 18 +++++----
 10 files changed, 96 insertions(+), 99 deletions(-)

--
Chuck Lever

