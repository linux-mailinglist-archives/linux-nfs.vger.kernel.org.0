Return-Path: <linux-nfs+bounces-16271-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC29C4EACA
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60DA18C595A
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA5933CEAA;
	Tue, 11 Nov 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVjOxxGv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756E28FFF6
	for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873178; cv=none; b=qocH+Sxm5CEpXSDe30jiOrZaUHpbF7J2eMEx3/KyH3yed9kgJ3Mg9tT21+ncRHWh+893KuJEquWvGv198Ym1VF3f0Ne4Mdu9tWdksFxqxGJhvaiDjQ+0dFG76MRVdLII0bh3pt3bj1DD+kr4r7NGgcnn9YThn+npx4NV1M7F1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873178; c=relaxed/simple;
	bh=v07p/4VOC2SprrkXdHWNh2W7Byfr1trYRvRc2DxJgtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekpuFRZRxzAQLhhjXgDAenmkRCTw/nskgjQOFZBDOKQz7o5XdG/0QfTgvs339RpCVJs5hBMvE5O1YJ2+xMW96mmmVJWsochZbaFxMGD8eriHrYImhi60rIsT1N5Oti4DBK5+CiiCNXJ4YU3RvHm3YKzn5DUzC+3TLpBe9vAlJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVjOxxGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508DCC4CEF5;
	Tue, 11 Nov 2025 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762873177;
	bh=v07p/4VOC2SprrkXdHWNh2W7Byfr1trYRvRc2DxJgtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVjOxxGvGHq/vvdpOjjvYO/Tkv4M8ZXAYCXQigtiSmRiG7kzHcJMSQqj/Wf/ojIvU
	 SjyODgvpT8euUrGKtNQPigKinHamrrdsmfrw+PM6ack0QYVXrekka5bRxZj4sZw1Nb
	 gNZjU+l4em6QSC8DI+F2KR7hdlDNnW1aEwWljIDGNfoR9wYjH0Eqhj9FjCqhPRUffW
	 VjTMn9YSsVOgs14seqtyrKyyzfgfjDREylzb25VmmRGm5g6X+CRQKmpziFW2oHT2nF
	 hS5UgU80kWxmur8fOGTmy1RExPTDWGUxwhrOPYsgFbKRYFGNNBDLoREs9tdmJ06xuA
	 nG3nXI7YkOFVw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v12 3/3] NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst
Date: Tue, 11 Nov 2025 09:59:32 -0500
Message-ID: <20251111145932.23784-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111145932.23784-1-cel@kernel.org>
References: <20251111145932.23784-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../filesystems/nfs/nfsd-io-modes.rst         | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst

diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentation/filesystems/nfs/nfsd-io-modes.rst
new file mode 100644
index 000000000000..e3a522d09766
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
+- cached but removed from page cache on completion (NFSD_IO_DONTCACHE=1)
+- not cached stable_how=NFS_UNSTABLE (NFSD_IO_DIRECT=2)
+
+To set an NFSD IO mode, write a supported value (0 - 2) to the
+corresponding IO operation's debugfs interface, e.g.:
+  echo 2 > /sys/kernel/debug/nfsd/io_cache_read
+  echo 2 > /sys/kernel/debug/nfsd/io_cache_write
+
+To check which IO mode NFSD is using for READ or WRITE, simply read the
+corresponding IO operation's debugfs interface, e.g.:
+  cat /sys/kernel/debug/nfsd/io_cache_read
+  cat /sys/kernel/debug/nfsd/io_cache_write
+
+If you experiment with NFSD's IO modes on a recent kernel and have
+interesting results, please report them to linux-nfs@vger.kernel.org
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
+because the page cache will eventually become a bottleneck to servicing
+new IO requests.
+
+For more context on DONTCACHE, please see these Linux commit headers:
+- Overview:  9ad6344568cc3 ("mm/filemap: change filemap_create_folio()
+  to take a struct kiocb")
+- for READ:  8026e49bff9b1 ("mm/filemap: add read support for
+  RWF_DONTCACHE")
+- for WRITE: 974c5e6139db3 ("xfs: flag as supporting FOP_DONTCACHE")
+
+NFSD_IO_DONTCACHE will fall back to NFSD_IO_BUFFERED if the underlying
+filesystem doesn't indicate support by setting FOP_DONTCACHE.
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
+The reason for such improvement is NFSD DIRECT eliminates a lot of work
+that the memory management subsystem would otherwise be required to
+perform (e.g. page allocation, dirty writeback, page reclaim). When
+using NFSD DIRECT, kswapd and kcompactd are no longer commanding CPU
+time trying to find adequate free pages so that forward IO progress can
+be made.
+
+The performance win associated with using NFSD DIRECT was previously
+discussed on linux-nfs, see:
+https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
+But in summary:
+- NFSD DIRECT can significantly reduce memory requirements
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
+If NFSD_IO_DIRECT is specified by writing 2 (or 3 and 4 for WRITE) to
+NFSD's debugfs interfaces, ideally the IO will be aligned relative to
+the underlying block device's logical_block_size. Also the memory buffer
+used to store the READ or WRITE payload must be aligned relative to the
+underlying block device's dma_alignment.
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
+Misaligned WRITE:
+    If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
+    middle and end as needed. The large middle segment is DIO-aligned
+    and the start and/or end are misaligned. Buffered IO is used for the
+    misaligned segments and O_DIRECT is used for the middle DIO-aligned
+    segment. DONTCACHE buffered IO is _not_ used for the misaligned
+    segments because using normal buffered IO offers significant RMW
+    performance benefit when handling streaming misaligned WRITEs.
+
+Tracing:
+    The nfsd_read_direct trace event shows how NFSD expands any
+    misaligned READ to the next DIO-aligned block (on either end of the
+    original READ, as needed).
+
+    This combination of trace events is useful for READs:
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_direct/enable
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
+    echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
+
+    The nfsd_write_direct trace event shows how NFSD splits a given
+    misaligned WRITE into a DIO-aligned middle segment.
+
+    This combination of trace events is useful for WRITEs:
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_direct/enable
+    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
+    echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
-- 
2.51.0


