Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA8C37CAD3
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhELQcV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238719AbhELQGI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:06:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78CF261CEA;
        Wed, 12 May 2021 15:35:03 +0000 (UTC)
Subject: [PATCH v2 01/25] NFSD: Fix TP_printk() format specifier in
 trace_nfsd_dirent()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:35:02 -0400
Message-ID: <162083370248.3108.7424008399973918267.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 9a6944fee68e ("tracing: Add a verifier to check string
pointers for trace events"), which was merged in v5.13-rc1,
TP_printk() no longer tacitly supports the "%.*s" format specifier.

Note that __string() and __assign_str() cannot be used for
non-NUL-terminated C strings because they perform a strlen() on
the string that is to be copied.

Instead, memcpy the whole file name into the record, but display
just the part up to the first NUL. In almost every case that will
show the whole file name.

Reported-by: David Wysochanski <dwysocha@redhat.com>
Fixes: 6019ce0742ca ("NFSD: Add a tracepoint to record directory entry encoding")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 fs/nfsd/trace.h |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 27a93ebd1d80..781af519b40c 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -400,19 +400,17 @@ TRACE_EVENT(nfsd_dirent,
 	TP_STRUCT__entry(
 		__field(u32, fh_hash)
 		__field(u64, ino)
-		__field(int, len)
-		__dynamic_array(unsigned char, name, namlen)
+		__dynamic_array(char, name, namlen + 1)
 	),
 	TP_fast_assign(
 		__entry->fh_hash = fhp ? knfsd_fh_hash(&fhp->fh_handle) : 0;
 		__entry->ino = ino;
-		__entry->len = namlen;
 		memcpy(__get_str(name), name, namlen);
-		__assign_str(name, name);
+		__get_str(name)[namlen] = '\0';
 	),
-	TP_printk("fh_hash=0x%08x ino=%llu name=%.*s",
-		__entry->fh_hash, __entry->ino,
-		__entry->len, __get_str(name))
+	TP_printk("fh_hash=0x%08x ino=%llu name=%s",
+		__entry->fh_hash, __entry->ino, __get_str(name)
+	)
 )
 
 #include "state.h"


