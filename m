Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3342639A2DA
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 16:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFCOO3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 10:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhFCOO2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 10:14:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D16C66138C;
        Thu,  3 Jun 2021 14:12:43 +0000 (UTC)
Subject: [PATCH] NFS: FMODE_READ and friends are C macros, not enum types
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 10:12:43 -0400
Message-ID: <162272956301.81247.4097672938438656918.stgit@oracle-100.nfsv4.dev>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Address a sparse warning:

  CHECK   fs/nfs/nfstrace.c
fs/nfs/nfstrace.c: note: in included file (through /home/cel/src/linux/rpc-over-tls/include/trace/trace_events.h, /home/cel/src/linux/rpc-over-tls/include/trace/define_trace.h, ...):
fs/nfs/./nfstrace.h:424:1: warning: incorrect type in initializer (different base types)
fs/nfs/./nfstrace.h:424:1:    expected unsigned long eval_value
fs/nfs/./nfstrace.h:424:1:    got restricted fmode_t [usertype]
fs/nfs/./nfstrace.h:425:1: warning: incorrect type in initializer (different base types)
fs/nfs/./nfstrace.h:425:1:    expected unsigned long eval_value
fs/nfs/./nfstrace.h:425:1:    got restricted fmode_t [usertype]
fs/nfs/./nfstrace.h:426:1: warning: incorrect type in initializer (different base types)
fs/nfs/./nfstrace.h:426:1:    expected unsigned long eval_value
fs/nfs/./nfstrace.h:426:1:    got restricted fmode_t [usertype]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 5a59dcdce0b2..ff75df1c883a 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -421,10 +421,6 @@ TRACE_DEFINE_ENUM(O_CLOEXEC);
 		{ O_NOATIME, "O_NOATIME" }, \
 		{ O_CLOEXEC, "O_CLOEXEC" })
 
-TRACE_DEFINE_ENUM(FMODE_READ);
-TRACE_DEFINE_ENUM(FMODE_WRITE);
-TRACE_DEFINE_ENUM(FMODE_EXEC);
-
 #define show_fmode_flags(mode) \
 	__print_flags(mode, "|", \
 		{ ((__force unsigned long)FMODE_READ), "READ" }, \


