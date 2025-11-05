Return-Path: <linux-nfs+bounces-16079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C231DC372E2
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 18:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACE0C4FC5E1
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0008338F45;
	Wed,  5 Nov 2025 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BswYSDoF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB9338939
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364536; cv=none; b=q5Sr0QVByJioIe4ca0NN+NKPs3OeP5F3eT6a8wojrJP69AJeQUenTefxOTbtmb18H0bEaJ2d6zpDmW3/dAwChHkWHJDa9i6zRiZNjuHnyvmbSjzR/uF4CbmO+7zL2VWXT2OujQIjRq2lUKYoRtHYNqu9s8xJ0aSZsLGOJ1oOqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364536; c=relaxed/simple;
	bh=nHB6hYbFaaPL4GzfzOPqdzsWiQHtO7GWidgKzULpetA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sx38mInsLR4pph/PZ3nLrAQFt5YPE1iojSuRbJgPVSnQYM1Wsx1yXlBgVXtJdB7NhWUTGagfOgp/Jxa4puN6drXZhvKweSEjphQqSv2dlLU3m+FfUuRGbcM49BI4AT+AcoxQ+jofKtQABnrZspEyM4/aGI9rE7+NpIMTfzAPCtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BswYSDoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9639C4CEF8;
	Wed,  5 Nov 2025 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364535;
	bh=nHB6hYbFaaPL4GzfzOPqdzsWiQHtO7GWidgKzULpetA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BswYSDoFoNYKXKubKF/pMJJDzH1fIvlMhHPj3fu5gmicZoDsbLqQKahWWhuOno2hd
	 gHMtX6LUjrqtz8Ckfdn7Yn03FLN6/2qp4krpcc0o6w6It9DUsB71n7rrpHLHRrRdrP
	 ZD/QU6TX9H06H5peybdg4IB9pzwomhSwRXB32hdXLIo+BVpymYVNunBdb3rgNp3pRb
	 otc3ovEbNWE8+KEzZxBIihw+9hHYElpmO4FLnZtuPx2bEVWnZ3PHnsqhnvBRJaq40E
	 yR1IwSTObH82ivlAF0fF/YM1dzGUJN4H1Bm03ozElfwaa8oZp2IDG1xqkx9ilvo1Mi
	 AI2B/U57S5elg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 3/3] NFSD: update Documentation/filesystems/nfs/nfsd-io-modes.rst
Date: Wed,  5 Nov 2025 12:42:10 -0500
Message-ID: <20251105174210.54023-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20251105174210.54023-1-snitzer@kernel.org>
References: <20251105174210.54023-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also fixed some typos.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 .../filesystems/nfs/nfsd-io-modes.rst         | 58 ++++++++++---------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentation/filesystems/nfs/nfsd-io-modes.rst
index 4863885c7035..29b84c9c9e25 100644
--- a/Documentation/filesystems/nfs/nfsd-io-modes.rst
+++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
@@ -21,17 +21,20 @@ NFSD's default IO mode (which is NFSD_IO_BUFFERED=0).
 
 Based on the configured settings, NFSD's IO will either be:
 - cached using page cache (NFSD_IO_BUFFERED=0)
-- cached but removed from the page cache upon completion
-  (NFSD_IO_DONTCACHE=1).
-- not cached (NFSD_IO_DIRECT=2)
+- cached but removed from page cache on completion (NFSD_IO_DONTCACHE=1)
+- not cached stable_how=NFS_UNSTABLE (NFSD_IO_DIRECT=2)
+- not cached stable_how=NFS_DATA_SYNC (NFSD_IO_DIRECT_WRITE_DATA_SYNC=3)
+- not cached stable_how=NFS_FILE_SYNC (NFSD_IO_DIRECT_WRITE_FILE_SYNC=4)
 
-To set an NFSD IO mode, write a supported value (0, 1 or 2) to the
+To set an NFSD IO mode, write a supported value (0 - 4) to the
 corresponding IO operation's debugfs interface, e.g.:
   echo 2 > /sys/kernel/debug/nfsd/io_cache_read
+  echo 4 > /sys/kernel/debug/nfsd/io_cache_write
 
 To check which IO mode NFSD is using for READ or WRITE, simply read the
 corresponding IO operation's debugfs interface, e.g.:
   cat /sys/kernel/debug/nfsd/io_cache_read
+  cat /sys/kernel/debug/nfsd/io_cache_write
 
 NFSD DONTCACHE
 ==============
@@ -46,10 +49,10 @@ DONTCACHE aims to avoid what has proven to be a fairly significant
 limition of Linux's memory management subsystem if/when large amounts of
 data is infrequently accessed (e.g. read once _or_ written once but not
 read until much later). Such use-cases are particularly problematic
-because the page cache will eventually become a bottleneck to surfacing
+because the page cache will eventually become a bottleneck to servicing
 new IO requests.
 
-For more context, please see these Linux commit headers:
+For more context on DONTCACHE, please see these Linux commit headers:
 - Overview:  9ad6344568cc3 ("mm/filemap: change filemap_create_folio()
   to take a struct kiocb")
 - for READ:  8026e49bff9b1 ("mm/filemap: add read support for
@@ -73,12 +76,18 @@ those with a working set that is significantly larger than available
 system memory. The pathological worst-case workload that NFSD DIRECT has
 proven to help most is: NFS client issuing large sequential IO to a file
 that is 2-3 times larger than the NFS server's available system memory.
+The reason for such improvement is NFSD DIRECT eliminates a lot of work
+that the memory management subsystem would otherwise be required to
+perform (e.g. page allocation, dirty writeback, page reclaim). When
+using NFSD DIRECT, kswapd and kcompactd are no longer commanding CPU
+time trying to find adequate free pages so that forward IO progress can
+be made.
 
 The performance win associated with using NFSD DIRECT was previously
 discussed on linux-nfs, see:
 https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
 But in summary:
-- NFSD DIRECT can signicantly reduce memory requirements
+- NFSD DIRECT can significantly reduce memory requirements
 - NFSD DIRECT can reduce CPU load by avoiding costly page reclaim work
 - NFSD DIRECT can offer more deterministic IO performance
 
@@ -91,11 +100,11 @@ to generate a "flamegraph" for work Linux must perform on behalf of your
 test is a really meaningful way to compare the relative health of the
 system and how switching NFSD's IO mode changes what is observed.
 
-If NFSD_IO_DIRECT is specified by writing 2 to NFSD's debugfs
-interfaces, ideally the IO will be aligned relative to the underlying
-block device's logical_block_size. Also the memory buffer used to store
-the READ or WRITE payload must be aligned relative to the underlying
-block device's dma_alignment.
+If NFSD_IO_DIRECT is specified by writing 2 (or 3 and 4 for WRITE) to
+NFSD's debugfs interfaces, ideally the IO will be aligned relative to
+the underlying block device's logical_block_size. Also the memory buffer
+used to store the READ or WRITE payload must be aligned relative to the
+underlying block device's dma_alignment.
 
 But NFSD DIRECT does handle misaligned IO in terms of O_DIRECT as best
 it can:
@@ -113,32 +122,29 @@ Misaligned READ:
 
 Misaligned WRITE:
     If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
-    middle and end as needed. The large middle extent is DIO-aligned and
-    the start and/or end are misaligned. Buffered IO is used for the
-    misaligned extents and O_DIRECT is used for the middle DIO-aligned
-    extent.
-
-    If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
-    invalidate the page cache on behalf of the DIO WRITE, then
-    nfsd_issue_write_dio() will fall back to using buffered IO.
+    middle and end as needed. The large middle segment is DIO-aligned
+    and the start and/or end are misaligned. Buffered IO is used for the
+    misaligned segments and O_DIRECT is used for the middle DIO-aligned
+    segment. DONTCACHE buffered IO is _not_ used for the misaligned
+    segments because using normal buffered IO offers significant RMW
+    performance benefit when handling streaming misaligned WRITEs.
 
 Tracing:
-    The nfsd_analyze_read_dio trace event shows how NFSD expands any
+    The nfsd_read_direct trace event shows how NFSD expands any
     misaligned READ to the next DIO-aligned block (on either end of the
     original READ, as needed).
 
     This combination of trace events is useful for READs:
     echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
-    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_read_dio/enable
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_direct/enable
     echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
     echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
 
-    The nfsd_analyze_write_dio trace event shows how NFSD splits a given
-    misaligned WRITE into a mix of misaligned extent(s) and a DIO-aligned
-    extent.
+    The nfsd_write_direct trace event shows how NFSD splits a given
+    misaligned WRITE into a DIO-aligned middle segment.
 
     This combination of trace events is useful for WRITEs:
     echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
-    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_write_dio/enable
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_direct/enable
     echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
     echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
-- 
2.44.0


