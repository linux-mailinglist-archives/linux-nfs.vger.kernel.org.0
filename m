Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607913C5E95
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhGLOzI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 10:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235209AbhGLOzF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Jul 2021 10:55:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C33126120A
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jul 2021 14:52:16 +0000 (UTC)
Subject: [PATCH RFC 0/7] XDR overhaul of NFS callback service
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Jul 2021 10:52:16 -0400
Message-ID: <162610122257.2466.7452891285800059767.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The purpose of this series is to prepare for the optimization of
svc_process_common() to handle NFSD workloads more efficiently. In
other words, NFSD should be the lubricated common case, and callback
is the use case that takes exceptional paths.

Note: For the moment these are compile-tested only.

There are some additional clean-ups that will be possible once this
series is merged. See

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-xdr-stream

for follow-on work.

---

Chuck Lever (7):
      SUNRPC: Add svc_rqst::rq_auth_stat
      SUNRPC: Set rq_auth_stat in the pg_authenticate() callout
      SUNRPC: Eliminate the RQ_AUTHERR flag
      NFS: Add a private local dispatcher for NFSv4 callback operations
      NFS: Remove unused callback void encoder and decoder
      NFS: Extract the xdr_init_encode/decode() calls from decode_compound
      NFS: Clean up the synopsis of callback process_op()


 fs/lockd/svc.c                    |  2 +
 fs/nfs/callback.c                 |  4 ++
 fs/nfs/callback_xdr.c             | 64 ++++++++++++++-----------------
 include/linux/sunrpc/svc.h        |  3 +-
 include/linux/sunrpc/svcauth.h    |  4 +-
 include/trace/events/sunrpc.h     |  9 ++---
 net/sunrpc/auth_gss/svcauth_gss.c | 47 ++++++++++++-----------
 net/sunrpc/svc.c                  | 39 ++++++-------------
 net/sunrpc/svcauth.c              |  8 ++--
 net/sunrpc/svcauth_unix.c         | 18 +++++----
 10 files changed, 92 insertions(+), 106 deletions(-)

--
Chuck Lever

