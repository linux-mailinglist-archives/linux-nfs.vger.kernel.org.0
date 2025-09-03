Return-Path: <linux-nfs+bounces-14023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C83B42B55
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 22:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6447C53EB
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 20:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACCB2DCF73;
	Wed,  3 Sep 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StQJGtAf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA32E62B4
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932693; cv=none; b=rsASniab7VYEF7SB542KgqlqpvNnJt3sjB7UCO66o1wc/Oeagadv26USqaoMH6th/cEF0sum2m3i4YVFfvLG1k3iyaoenR+1NKZcESRksur3/IhiGJa3Tjdbu3q4THOSd9lJoTs9BTqs/deWbz867HQ/E9CFTsLQy6V6HXvfzIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932693; c=relaxed/simple;
	bh=CLuoRVJK5L26Kz/5uLGx5IK4uBejqQFiyxmGAnvvnok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INvXPD5ozoob80jtqTZ+dH9jaDSRq2X71wgGuyMnw2Sz6Pz80q0LvIK3pPazxsBZj3VfT3g9P8t7CgtFLOwxa6nNbudvd0Tr1nhzQ2ZMfcSUTqqiNyLJJaQ+Jb3oCejTIXXUuOop9aurDFlqHKfFJ2kqE5NfyUOVXsKiPNgXplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StQJGtAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042C6C4CEE7;
	Wed,  3 Sep 2025 20:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932693;
	bh=CLuoRVJK5L26Kz/5uLGx5IK4uBejqQFiyxmGAnvvnok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StQJGtAfZcjB9wYLUyB341cK9K9GnDxLc/p0yQ7DawnNCMsz3NbVqjLNDhVhfkJco
	 SbfJjyG3gjU6iW68YmGoY/uUTA2IcTH2Cv+Na360fzmiD/PPr53uepRCr4h0Y4Yfct
	 iDv21xQAxL+XS2k3VMK3RwYywcGPbGt87JnuJySuebbT/QI3eltj3cYUSkkFVmRTKQ
	 481YN9sR44x5ukAvHhr9owf8noXAWzQM+UzkcRYHKLMcPRXNGUlZY1lac6ndCn055/
	 id7O9mKy/LDuQdFbVCtJjM5fkVIrXnUxy7tNknoXngzAvwZaxX+jC+PAP6QrAqe1aD
	 0SECN0OhCGlSg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 8/9] NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst
Date: Wed,  3 Sep 2025 16:51:20 -0400
Message-ID: <20250903205121.41380-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250903205121.41380-1-snitzer@kernel.org>
References: <20250903205121.41380-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This document details the NFSD IO modes that are configurable using
NFSD's experimental debugfs interfaces:

  /sys/kernel/debug/nfsd/io_cache_read
  /sys/kernel/debug/nfsd/io_cache_write

This document will evolve as NFSD's interfaces do (e.g. if/when NFSD's
debugfs interfaces are replaced with per-export controls).

Future updates will provide more specific guidance and howto
information to help others use and evaluate NFSD's IO modes:
BUFFERED, DONTCACHE and DIRECT.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 .../filesystems/nfs/nfsd-io-modes.rst         | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst

diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentation/filesystems/nfs/nfsd-io-modes.rst
new file mode 100644
index 0000000000000..4863885c70352
--- /dev/null
+++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
@@ -0,0 +1,144 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+NFSD IO MODES
+=============
+
+Overview
+========
+
+NFSD has historically always used buffered IO when servicing READ and
+WRITE operations. BUFFERED is NFSD's default IO mode, but it is possible
+to override that default to use either DONTCACHE or DIRECT IO modes.
+
+Experimental NFSD debugfs interfaces are available to allow the NFSD IO
+mode used for READ and WRITE to be configured independently. See both:
+- /sys/kernel/debug/nfsd/io_cache_read
+- /sys/kernel/debug/nfsd/io_cache_write
+
+The default value for both io_cache_read and io_cache_write reflects
+NFSD's default IO mode (which is NFSD_IO_BUFFERED=0).
+
+Based on the configured settings, NFSD's IO will either be:
+- cached using page cache (NFSD_IO_BUFFERED=0)
+- cached but removed from the page cache upon completion
+  (NFSD_IO_DONTCACHE=1).
+- not cached (NFSD_IO_DIRECT=2)
+
+To set an NFSD IO mode, write a supported value (0, 1 or 2) to the
+corresponding IO operation's debugfs interface, e.g.:
+  echo 2 > /sys/kernel/debug/nfsd/io_cache_read
+
+To check which IO mode NFSD is using for READ or WRITE, simply read the
+corresponding IO operation's debugfs interface, e.g.:
+  cat /sys/kernel/debug/nfsd/io_cache_read
+
+NFSD DONTCACHE
+==============
+
+DONTCACHE offers a hybrid approach to servicing IO that aims to offer
+the benefits of using DIRECT IO without any of the strict alignment
+requirements that DIRECT IO imposes. To achieve this buffered IO is used
+but the IO is flagged to "drop behind" (meaning associated pages are
+dropped from the page cache) when IO completes.
+
+DONTCACHE aims to avoid what has proven to be a fairly significant
+limition of Linux's memory management subsystem if/when large amounts of
+data is infrequently accessed (e.g. read once _or_ written once but not
+read until much later). Such use-cases are particularly problematic
+because the page cache will eventually become a bottleneck to surfacing
+new IO requests.
+
+For more context, please see these Linux commit headers:
+- Overview:  9ad6344568cc3 ("mm/filemap: change filemap_create_folio()
+  to take a struct kiocb")
+- for READ:  8026e49bff9b1 ("mm/filemap: add read support for
+  RWF_DONTCACHE")
+- for WRITE: 974c5e6139db3 ("xfs: flag as supporting FOP_DONTCACHE")
+
+If NFSD_IO_DONTCACHE is specified by writing 1 to NFSD's debugfs
+interfaces, FOP_DONTCACHE must be advertised as supported by the
+underlying filesystem (e.g. XFS), otherwise all IO flagged with
+RWF_DONTCACHE will fail with -EOPNOTSUPP.
+
+NFSD DIRECT
+===========
+
+DIRECT IO doesn't make use of the page cache, as such it is able to
+avoid the Linux memory management's page reclaim scalability problems
+without resorting to the hybrid use of page cache that DONTCACHE does.
+
+Some workloads benefit from NFSD avoiding the page cache, particularly
+those with a working set that is significantly larger than available
+system memory. The pathological worst-case workload that NFSD DIRECT has
+proven to help most is: NFS client issuing large sequential IO to a file
+that is 2-3 times larger than the NFS server's available system memory.
+
+The performance win associated with using NFSD DIRECT was previously
+discussed on linux-nfs, see:
+https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
+But in summary:
+- NFSD DIRECT can signicantly reduce memory requirements
+- NFSD DIRECT can reduce CPU load by avoiding costly page reclaim work
+- NFSD DIRECT can offer more deterministic IO performance
+
+As always, your mileage may vary and so it is important to carefully
+consider if/when it is beneficial to make use of NFSD DIRECT. When
+assessing comparative performance of your workload please be sure to log
+relevant performance metrics during testing (e.g. memory usage, cpu
+usage, IO performance). Using perf to collect perf data that may be used
+to generate a "flamegraph" for work Linux must perform on behalf of your
+test is a really meaningful way to compare the relative health of the
+system and how switching NFSD's IO mode changes what is observed.
+
+If NFSD_IO_DIRECT is specified by writing 2 to NFSD's debugfs
+interfaces, ideally the IO will be aligned relative to the underlying
+block device's logical_block_size. Also the memory buffer used to store
+the READ or WRITE payload must be aligned relative to the underlying
+block device's dma_alignment.
+
+But NFSD DIRECT does handle misaligned IO in terms of O_DIRECT as best
+it can:
+
+Misaligned READ:
+    If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
+    DIO-aligned block (on either end of the READ). The expanded READ is
+    verified to have proper offset/len (logical_block_size) and
+    dma_alignment checking.
+
+    Any misaligned READ that is less than 32K won't be expanded to be
+    DIO-aligned (this heuristic just avoids excess work, like allocating
+    start_extra_page, for smaller IO that can generally already perform
+    well using buffered IO).
+
+Misaligned WRITE:
+    If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
+    middle and end as needed. The large middle extent is DIO-aligned and
+    the start and/or end are misaligned. Buffered IO is used for the
+    misaligned extents and O_DIRECT is used for the middle DIO-aligned
+    extent.
+
+    If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
+    invalidate the page cache on behalf of the DIO WRITE, then
+    nfsd_issue_write_dio() will fall back to using buffered IO.
+
+Tracing:
+    The nfsd_analyze_read_dio trace event shows how NFSD expands any
+    misaligned READ to the next DIO-aligned block (on either end of the
+    original READ, as needed).
+
+    This combination of trace events is useful for READs:
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_read_dio/enable
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
+    echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
+
+    The nfsd_analyze_write_dio trace event shows how NFSD splits a given
+    misaligned WRITE into a mix of misaligned extent(s) and a DIO-aligned
+    extent.
+
+    This combination of trace events is useful for WRITEs:
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_write_dio/enable
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
+    echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
-- 
2.44.0


