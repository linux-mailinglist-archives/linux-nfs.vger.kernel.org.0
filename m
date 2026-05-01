Return-Path: <linux-nfs+bounces-21330-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCyMGhJ49Gk7BgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21330-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 11:53:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B31BC4AB69B
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 11:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9775630515D0
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134253822A2;
	Fri,  1 May 2026 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFr0k+75"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE525381B17;
	Fri,  1 May 2026 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629033; cv=none; b=ZvAuZZnQZBroHXQoRVyePv2QrecoGAYEERvbh+VrVpkbQsBByyoDluwECESVRzKUutpcmNdRdL4pZpfAh7xMcBMuQCPZkqKrfkcf3qZZJOOFOY0nMzktsa92u2OS/e4qIXHDx7JMtv1DXI2D6JqKOeIdouwUEAisLBFsrsqBHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629033; c=relaxed/simple;
	bh=hUHYNCWIhSe+/Qh/K+BvAkMBd2YFsTCdG8HEoxi1nKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9T7aPtHNJa0GJlgwnAsO9+/dCnnbVA7rTNJ3udOCQCUXpGZi1ZxMInqPbJgJny/guhGqpN0l0yf/y7KTlnrYXFNcIlD300ShBCYrmBSeEHkeRhFB3Zue8ucJZGZvLm10S22ULYyyfqLXvGmGfFQx3N9co44b9BlUk6F+7jJ7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFr0k+75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9062C2BCC6;
	Fri,  1 May 2026 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777629033;
	bh=hUHYNCWIhSe+/Qh/K+BvAkMBd2YFsTCdG8HEoxi1nKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KFr0k+75l3BFWhtSlVbO2I3cFTGv5p0dYo4MMDPn8eYBsBvduwWX9gCoZDsDEL+/s
	 yk0UN5i3MONRX4tN+vjpmb+HbeQ0DOC5sfEpxhfyqL2ysD6GvUvyYYI79K/9P24vWK
	 EKKHSXnJtBP3IMwc+FWdvvOI25anLnd5mjK8G7JHxxoyrGq52dlnim+3gOkaaYBH2m
	 RtjQxOSZHqosjgOaK8mRHtGAXUaGjgIVgbxckisBCF5TphHHBFdp5cmhmPSbG3uWfG
	 AKlbIIVoOozNz7ULwMVTyrYP7BdlYEoHsFyiIN609bd1cbNOr6gD79HfH+AHId5R7x
	 8VHAYLlXknj0w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 01 May 2026 10:49:38 +0100
Subject: [PATCH v4 4/4] testing: add dontcache-bench local filesystem
 benchmark suite
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260501-dontcache-v4-4-5d5e6dc71cb3@kernel.org>
References: <20260501-dontcache-v4-0-5d5e6dc71cb3@kernel.org>
In-Reply-To: <20260501-dontcache-v4-0-5d5e6dc71cb3@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=36514; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hUHYNCWIhSe+/Qh/K+BvAkMBd2YFsTCdG8HEoxi1nKc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp9HdRJAO6PBfMG3nSIH53z1iYHC1PfmzCF6wYD
 JjAVTpM5bSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafR3UQAKCRAADmhBGVaC
 FWzzD/9njwPC3Frl8e3NHB04t4oA55Q5AHAntkIn7NWKuUpEvu5DeJvwpOU59quxVLOjXtDtRwG
 Encfl48/cJ9bYVfbUy55OnZ/Kgr2uFd4lmp6ugVHC/WkWEwX48GG8VQ0nQ1rq2cNZiC2D/l0g3c
 rPvhYhxipDO3sCfz04etWRCj/LdRazZic/xT0RMoLwZuGhGFQMZ201/oeD7Q+d7r0O8x62jMQLA
 P2h2byXwAQqLdrHjTuTWJ6FZM7O/KI8grPw//RzlbjLv6Lvu3n8gQvGAgAXVoDdQ0PvsL7SmvtV
 ux9xjgzua3zKMZNd3FxNkfaDYDckwBllCIgjWuzH/7qYIWj8eKNihGcSSfYaQjnb/bLUbkD5h3C
 EfLSoe+WeSI2S+YLeuRRnO11yrQh3sif3BS/4d/4l90pIzuG+UDGWlH4J8RVXLfRaSKjFz8meNz
 ntqqnmONaJ/SftPTyniXoUpyutDg2M+dYM7upIFJO/voR65WRAl7j1rNqxnr8PEdhQYoO0D/rVD
 EBCiRBexU2etL9+f+Tj+jpx2xfiPn6vRFpdA56Wv7Zo9loDz8vRbAfm/wkXSNJrYc9rXzQMLfc+
 m0+Fhj3/cSJb5QI4Dok1nWGdKmxabtqhZeZ2Bh87eyFbkVOHboojktPh9ERP/qXet91YfOcySiE
 m1XiAkOAmdoJwUg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: B31BC4AB69B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21330-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,run-benchmarks.sh:url,parse-results.sh:url]

Add a benchmark suite for testing IOCB_DONTCACHE on local filesystems
via fio's io_uring engine with the RWF_DONTCACHE flag.

The suite mirrors the nfsd-io-bench test matrix but uses io_uring with
the "uncached" fio option instead of NFSD debugfs mode switching:
 - uncached=0: standard buffered I/O
 - uncached=1: RWF_DONTCACHE
 - Mode 2 uses O_DIRECT via fio's --direct=1

Additionally, this benchmark includes:

 - a benchmark for competing buffered vs. dontcache writers to
   different files on the same backing device.
 - a benchmark mirroring Jens Axboe's original RWF_UNCACHED write test:
   32 concurrent writers with 64K block size, time-based (300s), with
   per-second bandwidth logging

Includes fio job files, run-benchmarks.sh, and parse-results.sh.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 .../dontcache-bench/fio-jobs/axboe-write.fio       |  14 +
 .../dontcache-bench/fio-jobs/lat-reader.fio        |  12 +
 .../dontcache-bench/fio-jobs/multi-write.fio       |  11 +
 .../dontcache-bench/fio-jobs/noisy-writer.fio      |  12 +
 .../testing/dontcache-bench/fio-jobs/rand-read.fio |  13 +
 .../dontcache-bench/fio-jobs/rand-write.fio        |  13 +
 .../testing/dontcache-bench/fio-jobs/seq-read.fio  |  13 +
 .../testing/dontcache-bench/fio-jobs/seq-write.fio |  13 +
 .../dontcache-bench/scripts/parse-results.sh       | 346 +++++++++++
 .../dontcache-bench/scripts/run-benchmarks.sh      | 643 +++++++++++++++++++++
 10 files changed, 1090 insertions(+)

diff --git a/tools/testing/dontcache-bench/fio-jobs/axboe-write.fio b/tools/testing/dontcache-bench/fio-jobs/axboe-write.fio
new file mode 100644
index 000000000000..7cabcb740f0d
--- /dev/null
+++ b/tools/testing/dontcache-bench/fio-jobs/axboe-write.fio
@@ -0,0 +1,14 @@
+[global]
+ioengine=io_uring
+direct=0
+bs=64k
+numjobs=32
+time_based
+runtime=300
+rw=write
+group_reporting=0
+filename_format=$jobname.$jobnum
+log_avg_msec=1000
+write_bw_log=axboe-write
+
+[axboe-write]
diff --git a/tools/testing/dontcache-bench/fio-jobs/lat-reader.fio b/tools/testing/dontcache-bench/fio-jobs/lat-reader.fio
new file mode 100644
index 000000000000..e221e7aedec9
--- /dev/null
+++ b/tools/testing/dontcache-bench/fio-jobs/lat-reader.fio
@@ -0,0 +1,12 @@
+[global]
+ioengine=io_uring
+direct=0
+bs=4k
+numjobs=1
+time_based=0
+rw=read
+log_avg_msec=1000
+write_bw_log=latreader
+write_lat_log=latreader
+
+[latreader]
diff --git a/tools/testing/dontcache-bench/fio-jobs/multi-write.fio b/tools/testing/dontcache-bench/fio-jobs/multi-write.fio
new file mode 100644
index 000000000000..c9cd11ec40fd
--- /dev/null
+++ b/tools/testing/dontcache-bench/fio-jobs/multi-write.fio
@@ -0,0 +1,11 @@
+[global]
+ioengine=io_uring
+direct=0
+bs=1M
+numjobs=4
+time_based=0
+rw=write
+group_reporting=0
+filename_format=$jobname.$jobnum
+
+[multiwrite]
diff --git a/tools/testing/dontcache-bench/fio-jobs/noisy-writer.fio b/tools/testing/dontcache-bench/fio-jobs/noisy-writer.fio
new file mode 100644
index 000000000000..4524eebd4642
--- /dev/null
+++ b/tools/testing/dontcache-bench/fio-jobs/noisy-writer.fio
@@ -0,0 +1,12 @@
+[global]
+ioengine=io_uring
+direct=0
+bs=1M
+numjobs=1
+time_based=0
+rw=write
+log_avg_msec=1000
+write_bw_log=noisywriter
+write_lat_log=noisywriter
+
+[noisywriter]
diff --git a/tools/testing/dontcache-bench/fio-jobs/rand-read.fio b/tools/testing/dontcache-bench/fio-jobs/rand-read.fio
new file mode 100644
index 000000000000..e281fa82b86a
--- /dev/null
+++ b/tools/testing/dontcache-bench/fio-jobs/rand-read.fio
@@ -0,0 +1,13 @@
+[global]
+ioengine=io_uring
+direct=0
+bs=4k
+numjobs=1
+iodepth=16
+time_based=0
+rw=randread
+log_avg_msec=1000
+write_bw_log=randread
+write_lat_log=randread
+
+[randread]
diff --git a/tools/testing/dontcache-bench/fio-jobs/rand-write.fio b/tools/testing/dontcache-bench/fio-jobs/rand-write.fio
new file mode 100644
index 000000000000..cf53bc6f14b9
--- /dev/null
+++ b/tools/testing/dontcache-bench/fio-jobs/rand-write.fio
@@ -0,0 +1,13 @@
+[global]
+ioengine=io_uring
+direct=0
+bs=4k
+numjobs=1
+iodepth=16
+time_based=0
+rw=randwrite
+log_avg_msec=1000
+write_bw_log=randwrite
+write_lat_log=randwrite
+
+[randwrite]
diff --git a/tools/testing/dontcache-bench/fio-jobs/seq-read.fio b/tools/testing/dontcache-bench/fio-jobs/seq-read.fio
new file mode 100644
index 000000000000..ef87921465a7
--- /dev/null
+++ b/tools/testing/dontcache-bench/fio-jobs/seq-read.fio
@@ -0,0 +1,13 @@
+[global]
+ioengine=io_uring
+direct=0
+bs=1M
+numjobs=1
+iodepth=16
+time_based=0
+rw=read
+log_avg_msec=1000
+write_bw_log=seqread
+write_lat_log=seqread
+
+[seqread]
diff --git a/tools/testing/dontcache-bench/fio-jobs/seq-write.fio b/tools/testing/dontcache-bench/fio-jobs/seq-write.fio
new file mode 100644
index 000000000000..da3082f9b391
--- /dev/null
+++ b/tools/testing/dontcache-bench/fio-jobs/seq-write.fio
@@ -0,0 +1,13 @@
+[global]
+ioengine=io_uring
+direct=0
+bs=1M
+numjobs=1
+iodepth=16
+time_based=0
+rw=write
+log_avg_msec=1000
+write_bw_log=seqwrite
+write_lat_log=seqwrite
+
+[seqwrite]
diff --git a/tools/testing/dontcache-bench/scripts/parse-results.sh b/tools/testing/dontcache-bench/scripts/parse-results.sh
new file mode 100755
index 000000000000..ba43a039153f
--- /dev/null
+++ b/tools/testing/dontcache-bench/scripts/parse-results.sh
@@ -0,0 +1,346 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Parse fio JSON output and generate comparison tables.
+#
+# Usage: ./parse-results.sh <results-dir>
+
+set -euo pipefail
+
+if [ $# -lt 1 ]; then
+	echo "Usage: $0 <results-dir>"
+	exit 1
+fi
+
+RESULTS_DIR="$1"
+
+if ! command -v jq &>/dev/null; then
+	echo "ERROR: jq is required"
+	exit 1
+fi
+
+# Extract metrics from a single fio JSON result
+extract_metrics() {
+	local json_file=$1
+	local rw_type=$2  # read or write
+
+	if [ ! -f "$json_file" ]; then
+		echo "N/A N/A N/A N/A N/A N/A"
+		return
+	fi
+
+	jq -r --arg rw "$rw_type" '
+		.jobs[0][$rw] as $d |
+		[
+			(($d.bw // 0) / 1024 | . * 10 | round / 10),    # MB/s
+			($d.iops // 0),                                    # IOPS
+			((($d.clat_ns.mean // 0) / 1000) | . * 10 | round / 10), # avg lat us
+			(($d.clat_ns.percentile["50.000000"] // 0) / 1000), # p50 us
+			(($d.clat_ns.percentile["99.000000"] // 0) / 1000), # p99 us
+			(($d.clat_ns.percentile["99.900000"] // 0) / 1000)  # p99.9 us
+		] | @tsv
+	' "$json_file" 2>/dev/null || echo "N/A N/A N/A N/A N/A N/A"
+}
+
+# Extract server CPU from vmstat log (average sys%)
+extract_cpu() {
+	local vmstat_log=$1
+	if [ ! -f "$vmstat_log" ]; then
+		echo "N/A"
+		return
+	fi
+	# vmstat columns: us sy id wa st — skip header lines
+	awk 'NR>2 {sum+=$14; n++} END {if(n>0) printf "%.1f", sum/n; else print "N/A"}' \
+		"$vmstat_log" 2>/dev/null || echo "N/A"
+}
+
+# Extract peak dirty pages from meminfo log
+extract_peak_dirty() {
+	local meminfo_log=$1
+	if [ ! -f "$meminfo_log" ]; then
+		echo "N/A"
+		return
+	fi
+	grep "^Dirty:" "$meminfo_log" | awk '{print $2}' | sort -n | tail -1 || echo "N/A"
+}
+
+# Extract peak cached from meminfo log
+extract_peak_cached() {
+	local meminfo_log=$1
+	if [ ! -f "$meminfo_log" ]; then
+		echo "N/A"
+		return
+	fi
+	grep "^Cached:" "$meminfo_log" | awk '{print $2}' | sort -n | tail -1 || echo "N/A"
+}
+
+print_separator() {
+	printf '%*s\n' 120 '' | tr ' ' '-'
+}
+
+########################################################################
+# Deliverable 1: Single-client results
+########################################################################
+echo ""
+echo "=================================================================="
+echo "  Deliverable 1: Single-Client fio Benchmarks"
+echo "=================================================================="
+echo ""
+
+for workload in seq-write rand-write seq-read rand-read; do
+	case $workload in
+	seq-write|rand-write) rw_type="write" ;;
+	seq-read|rand-read)   rw_type="read" ;;
+	esac
+
+	echo "--- $workload ---"
+	printf "%-16s %10s %10s %10s %10s %10s %10s %10s %12s %12s\n" \
+		"Mode" "MB/s" "IOPS" "Avg(us)" "p50(us)" "p99(us)" "p99.9(us)" "Sys CPU%" "PeakDirty(kB)" "PeakCache(kB)"
+	print_separator
+
+	for mode in buffered dontcache direct; do
+		dir="${RESULTS_DIR}/${workload}/${mode}"
+		json_file=$(find "$dir" -name '*.json' -not -name 'client*' 2>/dev/null | head -1 || true)
+		if [ -z "$json_file" ]; then
+			printf "%-16s %10s\n" "$mode" "(no data)"
+			continue
+		fi
+
+		read -r mbps iops avg_lat p50 p99 p999 <<< \
+			"$(extract_metrics "$json_file" "$rw_type")"
+		cpu=$(extract_cpu "${dir}/vmstat.log")
+		dirty=$(extract_peak_dirty "${dir}/meminfo.log")
+		cached=$(extract_peak_cached "${dir}/meminfo.log")
+
+		printf "%-16s %10s %10s %10s %10s %10s %10s %10s %12s %12s\n" \
+			"$mode" "$mbps" "$iops" "$avg_lat" "$p50" "$p99" "$p999" \
+			"$cpu" "${dirty:-N/A}" "${cached:-N/A}"
+	done
+	echo ""
+done
+
+########################################################################
+# Deliverable 2: Multi-client results
+########################################################################
+echo "=================================================================="
+echo "  Deliverable 2: Noisy-Neighbor Benchmarks"
+echo "=================================================================="
+echo ""
+
+# Scenario A: Multiple writers
+echo "--- Scenario A: Multiple Writers ---"
+for mode in buffered dontcache direct; do
+	dir="${RESULTS_DIR}/multi-write/${mode}"
+	if [ ! -d "$dir" ]; then
+		continue
+	fi
+
+	json_file=$(find "$dir" -name '*.json' 2>/dev/null | head -1 || true)
+	if [ -z "$json_file" ] || [ ! -f "$json_file" ]; then
+		echo "  Mode: $mode (no data)"
+		continue
+	fi
+
+	echo "  Mode: $mode"
+	printf "  %-10s %10s %10s %10s %10s %10s %10s\n" \
+		"Job" "MB/s" "IOPS" "Avg(us)" "p50(us)" "p99(us)" "p99.9(us)"
+
+	# Parse per-job stats from the single fio JSON output
+	jq -r '.jobs[] |
+		[
+			.jobname,
+			((.write.bw // 0) / 1024 | . * 10 | round / 10),
+			(.write.iops // 0),
+			(((.write.clat_ns.mean // 0) / 1000) | . * 10 | round / 10),
+			((.write.clat_ns.percentile["50.000000"] // 0) / 1000),
+			((.write.clat_ns.percentile["99.000000"] // 0) / 1000),
+			((.write.clat_ns.percentile["99.900000"] // 0) / 1000)
+		] | @tsv
+	' "$json_file" 2>/dev/null | while IFS=$'\t' read -r name mbps iops avg_lat p50 p99 p999; do
+		printf "  %-10s %10s %10s %10s %10s %10s %10s\n" \
+			"$name" "$mbps" "$iops" "$avg_lat" "$p50" "$p99" "$p999"
+	done
+
+	# Aggregate bandwidth
+	total_bw=$(jq '[.jobs[].write.bw // 0] | add / 1024 | . * 10 | round / 10' \
+		"$json_file" 2>/dev/null || echo "N/A")
+	cpu=$(extract_cpu "${dir}/vmstat.log")
+	dirty=$(extract_peak_dirty "${dir}/meminfo.log")
+	printf "  Aggregate BW: %s MB/s | Sys CPU: %s%% | Peak Dirty: %s kB\n" \
+		"$total_bw" "$cpu" "${dirty:-N/A}"
+	echo ""
+done
+
+# Scenario C: Noisy neighbor
+echo "--- Scenario C: Noisy Writer + Latency-Sensitive Readers ---"
+for mode in buffered dontcache direct; do
+	dir="${RESULTS_DIR}/noisy-neighbor/${mode}"
+	if [ ! -d "$dir" ]; then
+		continue
+	fi
+
+	echo "  Mode: $mode"
+	printf "  %-14s %10s %10s %10s %10s %10s %10s\n" \
+		"Job" "MB/s" "IOPS" "Avg(us)" "p50(us)" "p99(us)" "p99.9(us)"
+
+	# Writer
+	if [ -f "${dir}/noisy_writer.json" ]; then
+		read -r mbps iops avg_lat p50 p99 p999 <<< \
+			"$(extract_metrics "${dir}/noisy_writer.json" "write")"
+		printf "  %-14s %10s %10s %10s %10s %10s %10s\n" \
+			"Bulk writer" "$mbps" "$iops" "$avg_lat" "$p50" "$p99" "$p999"
+	fi
+
+	# Readers
+	for json_file in "${dir}"/reader*.json; do
+		[ -f "$json_file" ] || continue
+		reader=$(basename "$json_file" .json)
+		read -r mbps iops avg_lat p50 p99 p999 <<< \
+			"$(extract_metrics "$json_file" "read")"
+		printf "  %-14s %10s %10s %10s %10s %10s %10s\n" \
+			"$reader" "$mbps" "$iops" "$avg_lat" "$p50" "$p99" "$p999"
+	done
+
+	cpu=$(extract_cpu "${dir}/vmstat.log")
+	dirty=$(extract_peak_dirty "${dir}/meminfo.log")
+	printf "  Sys CPU: %s%% | Peak Dirty: %s kB\n" "$cpu" "${dirty:-N/A}"
+	echo ""
+done
+
+# Scenario D: Mixed-mode noisy neighbor
+echo "--- Scenario D: Mixed-Mode Noisy Writer + Readers ---"
+for dir in "${RESULTS_DIR}"/noisy-neighbor-mixed/*/; do
+	[ -d "$dir" ] || continue
+	label=$(basename "$dir")
+
+	echo "  Mode: $label"
+	printf "  %-14s %10s %10s %10s %10s %10s %10s\n" \
+		"Job" "MB/s" "IOPS" "Avg(us)" "p50(us)" "p99(us)" "p99.9(us)"
+
+	# Writer
+	if [ -f "${dir}/noisy_writer.json" ]; then
+		read -r mbps iops avg_lat p50 p99 p999 <<< \
+			"$(extract_metrics "${dir}/noisy_writer.json" "write")"
+		printf "  %-14s %10s %10s %10s %10s %10s %10s\n" \
+			"Bulk writer" "$mbps" "$iops" "$avg_lat" "$p50" "$p99" "$p999"
+	fi
+
+	# Readers
+	for json_file in "${dir}"/reader*.json; do
+		[ -f "$json_file" ] || continue
+		reader=$(basename "$json_file" .json)
+		read -r mbps iops avg_lat p50 p99 p999 <<< \
+			"$(extract_metrics "$json_file" "read")"
+		printf "  %-14s %10s %10s %10s %10s %10s %10s\n" \
+			"$reader" "$mbps" "$iops" "$avg_lat" "$p50" "$p99" "$p999"
+	done
+
+	cpu=$(extract_cpu "${dir}/vmstat.log")
+	dirty=$(extract_peak_dirty "${dir}/meminfo.log")
+	printf "  Sys CPU: %s%% | Peak Dirty: %s kB\n" "$cpu" "${dirty:-N/A}"
+	echo ""
+done
+
+# Scenario E: Competing writers
+echo "--- Scenario E: Competing Writers (Separate Files) ---"
+for dir in "${RESULTS_DIR}"/competing-writers/*/; do
+	[ -d "$dir" ] || continue
+	label=$(basename "$dir")
+
+	echo "  Mode: $label"
+	printf "  %-20s %10s %10s %10s %10s %10s %10s\n" \
+		"Writer" "MB/s" "IOPS" "Avg(us)" "p50(us)" "p99(us)" "p99.9(us)"
+
+	total_bw=0
+	for json_file in "${dir}"/writer*.json; do
+		[ -f "$json_file" ] || continue
+		writer=$(basename "$json_file" .json)
+		read -r mbps iops avg_lat p50 p99 p999 <<< \
+			"$(extract_metrics "$json_file" "write")"
+		printf "  %-20s %10s %10s %10s %10s %10s %10s\n" \
+			"$writer" "$mbps" "$iops" "$avg_lat" "$p50" "$p99" "$p999"
+		total_bw=$(echo "$total_bw + ${mbps:-0}" | bc 2>/dev/null || echo "$total_bw")
+	done
+
+	cpu=$(extract_cpu "${dir}/vmstat.log")
+	dirty=$(extract_peak_dirty "${dir}/meminfo.log")
+	printf "  Aggregate BW: %s MB/s | Sys CPU: %s%% | Peak Dirty: %s kB\n" \
+		"$total_bw" "$cpu" "${dirty:-N/A}"
+	echo ""
+done
+
+########################################################################
+# Deliverable 3: Axboe 32-file write benchmark
+########################################################################
+echo "=================================================================="
+echo "  Deliverable 3: 32-File Write (Axboe Test)"
+echo "=================================================================="
+echo ""
+
+for mode in buffered dontcache direct; do
+	dir="${RESULTS_DIR}/axboe-write/${mode}"
+	if [ ! -d "$dir" ]; then
+		continue
+	fi
+
+	json_file=$(find "$dir" -name '*.json' 2>/dev/null | head -1 || true)
+	if [ -z "$json_file" ] || [ ! -f "$json_file" ]; then
+		echo "--- $mode: (no data) ---"
+		continue
+	fi
+
+	echo "--- $mode ---"
+
+	# Aggregate stats across all 32 jobs
+	agg_bw=$(jq '[.jobs[].write.bw // 0] | add / 1024 | . * 10 | round / 10' \
+		"$json_file" 2>/dev/null || echo "N/A")
+	agg_iops=$(jq '[.jobs[].write.iops // 0] | add | round' \
+		"$json_file" 2>/dev/null || echo "N/A")
+
+	# Average latency across jobs
+	avg_lat=$(jq '[.jobs[].write.clat_ns.mean // 0] | (add / length / 1000) |
+		. * 10 | round / 10' "$json_file" 2>/dev/null || echo "N/A")
+	avg_p50=$(jq '[.jobs[].write.clat_ns.percentile["50.000000"] // 0] |
+		(add / length / 1000) | round' "$json_file" 2>/dev/null || echo "N/A")
+	avg_p99=$(jq '[.jobs[].write.clat_ns.percentile["99.000000"] // 0] |
+		(add / length / 1000) | round' "$json_file" 2>/dev/null || echo "N/A")
+	avg_p999=$(jq '[.jobs[].write.clat_ns.percentile["99.900000"] // 0] |
+		(add / length / 1000) | round' "$json_file" 2>/dev/null || echo "N/A")
+
+	printf "  Aggregate BW: %s MB/s | IOPS: %s\n" "$agg_bw" "$agg_iops"
+	printf "  Avg Latency: %s us | p50: %s us | p99: %s us | p99.9: %s us\n" \
+		"$avg_lat" "$avg_p50" "$avg_p99" "$avg_p999"
+
+	cpu=$(extract_cpu "${dir}/vmstat.log")
+	dirty=$(extract_peak_dirty "${dir}/meminfo.log")
+	cached=$(extract_peak_cached "${dir}/meminfo.log")
+	printf "  Sys CPU: %s%% | Peak Dirty: %s kB | Peak Cached: %s kB\n" \
+		"$cpu" "${dirty:-N/A}" "${cached:-N/A}"
+
+	# Per-second bandwidth from fio bw log (shows the page-cache cliff)
+	bw_log=$(find "$dir" -name '*_bw.*.log' 2>/dev/null | head -1 || true)
+	if [ -n "$bw_log" ] && [ -f "$bw_log" ]; then
+		echo "  Per-second aggregate BW (MB/s):"
+		# fio bw logs: msec, bw_kB, rw, bs — aggregate across all job logs
+		for logfile in "${dir}"/*_bw.*.log; do
+			[ -f "$logfile" ] || continue
+			cat "$logfile"
+		done | awk -F',' '{
+			sec = int($1 / 1000) + 1
+			bw[sec] += $2
+		} END {
+			n = asorti(bw, sorted, "@ind_num_asc")
+			for (i = 1; i <= n; i++)
+				printf "    %2ds: %.0f MB/s\n", sorted[i], bw[sorted[i]] / 1024
+		}'
+	fi
+	echo ""
+done
+
+echo "=================================================================="
+echo "  System Info"
+echo "=================================================================="
+if [ -f "${RESULTS_DIR}/sysinfo.txt" ]; then
+	head -6 "${RESULTS_DIR}/sysinfo.txt"
+fi
+echo ""
diff --git a/tools/testing/dontcache-bench/scripts/run-benchmarks.sh b/tools/testing/dontcache-bench/scripts/run-benchmarks.sh
new file mode 100755
index 000000000000..e7278567e1a5
--- /dev/null
+++ b/tools/testing/dontcache-bench/scripts/run-benchmarks.sh
@@ -0,0 +1,643 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Local filesystem I/O mode benchmark suite.
+#
+# Runs the same test matrix as run-benchmarks.sh but on a local filesystem
+# using fio's io_uring engine with the RWF_DONTCACHE flag instead of NFSD's
+# debugfs mode knobs.
+#
+# Usage: ./run-local-benchmarks.sh [options]
+#   -t <dir>    Test directory (must be on a filesystem supporting FOP_DONTCACHE)
+#   -s <size>   File size (default: auto-sized to exceed RAM)
+#   -f <path>   Path to fio binary (default: fio in PATH)
+#   -o <dir>    Output directory for results (default: ./results/<timestamp>)
+#   -d          Dry run (print commands without executing)
+
+set -euo pipefail
+
+# Defaults
+TEST_DIR=""
+SIZE=""
+FIO_BIN="fio"
+RESULTS_DIR=""
+DRY_RUN=0
+MODES="0 1 2"
+PERF_LOCK=0
+SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
+FIO_JOBS_DIR="${SCRIPT_DIR}/../fio-jobs"
+
+usage() {
+	echo "Usage: $0 -t <test-dir> [-s <size>] [-f <fio-path>] [-o <output-dir>] [-D] [-p] [-d]"
+	echo ""
+	echo "  -t <dir>    Test directory (required, must support RWF_DONTCACHE)"
+	echo "  -s <size>   File size (default: 2x RAM)"
+	echo "  -f <path>   Path to fio binary (default: fio)"
+	echo "  -o <dir>    Output directory (default: ./results/<timestamp>)"
+	echo "  -D          Dontcache only (skip buffered and direct tests)"
+	echo "  -p          Profile kernel lock contention with perf lock"
+	echo "  -d          Dry run"
+	exit 1
+}
+
+while getopts "t:s:f:o:Dpdh" opt; do
+	case $opt in
+	t) TEST_DIR="$OPTARG" ;;
+	s) SIZE="$OPTARG" ;;
+	f) FIO_BIN="$OPTARG" ;;
+	o) RESULTS_DIR="$OPTARG" ;;
+	D) MODES="1" ;;
+	p) PERF_LOCK=1 ;;
+	d) DRY_RUN=1 ;;
+	h) usage ;;
+	*) usage ;;
+	esac
+done
+
+if [ -z "$TEST_DIR" ]; then
+	echo "ERROR: -t <test-dir> is required"
+	usage
+fi
+
+# Auto-size to 2x RAM if not specified
+if [ -z "$SIZE" ]; then
+	mem_kb=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
+	SIZE="$(( mem_kb * 2 / 1024 ))M"
+fi
+
+if [ -z "$RESULTS_DIR" ]; then
+	RESULTS_DIR="./results/local-$(date +%Y%m%d-%H%M%S)"
+fi
+
+mkdir -p "$RESULTS_DIR"
+
+log() {
+	echo "[$(date '+%H:%M:%S')] $*"
+}
+
+run_cmd() {
+	if [ "$DRY_RUN" -eq 1 ]; then
+		echo "  [DRY RUN] $*"
+	else
+		"$@"
+	fi
+}
+
+# I/O mode definitions:
+#   buffered:  direct=0, uncached=0
+#   dontcache: direct=0, uncached=1
+#   direct:    direct=1, uncached=0
+#
+# Mode name from numeric value
+mode_name() {
+	case $1 in
+	0) echo "buffered" ;;
+	1) echo "dontcache" ;;
+	2) echo "direct" ;;
+	esac
+}
+
+# Return fio command-line flags for a given mode.
+# "direct" is a standard fio option and works on the command line.
+# "uncached" is an io_uring engine option that must be in the job file,
+# so we inject it via make_job_file() below.
+mode_fio_args() {
+	case $1 in
+	0) echo "--direct=0" ;;           # buffered
+	1) echo "--direct=0" ;;           # dontcache
+	2) echo "--direct=1" ;;           # direct
+	esac
+}
+
+# Return the uncached= value for a given mode.
+mode_uncached() {
+	case $1 in
+	0) echo "0" ;;
+	1) echo "1" ;;
+	2) echo "0" ;;
+	esac
+}
+
+# Create a temporary job file with uncached=N injected into [global].
+# For uncached=0 (buffered/direct), return the original file unchanged.
+make_job_file() {
+	local job_file=$1
+	local uncached=$2
+
+	if [ "$uncached" -eq 0 ]; then
+		echo "$job_file"
+		return
+	fi
+
+	local tmp
+	tmp=$(mktemp)
+	sed "/^\[global\]/a uncached=${uncached}" "$job_file" > "$tmp"
+	echo "$tmp"
+}
+
+drop_caches() {
+	run_cmd bash -c "sync && echo 3 > /proc/sys/vm/drop_caches"
+}
+
+# perf lock profiling — uses BPF-based live contention tracing
+PERF_LOCK_PID=""
+
+start_perf_lock() {
+	local outdir=$1
+
+	if [ "$PERF_LOCK" -ne 1 ]; then
+		return
+	fi
+
+	log "Starting perf lock contention tracing"
+	perf lock contention -a -b --max-stack 8 \
+		> "${outdir}/perf-lock-contention.txt" 2>&1 &
+	PERF_LOCK_PID=$!
+}
+
+stop_perf_lock() {
+	local outdir=$1
+
+	if [ -z "$PERF_LOCK_PID" ]; then
+		return
+	fi
+
+	log "Stopping perf lock contention tracing"
+	kill -TERM "$PERF_LOCK_PID" 2>/dev/null || true
+	wait "$PERF_LOCK_PID" 2>/dev/null || true
+	PERF_LOCK_PID=""
+}
+
+# Background monitors
+VMSTAT_PID=""
+IOSTAT_PID=""
+MEMINFO_PID=""
+
+start_monitors() {
+	local outdir=$1
+	log "Starting monitors in $outdir"
+	run_cmd vmstat 1 > "${outdir}/vmstat.log" 2>&1 &
+	VMSTAT_PID=$!
+	run_cmd iostat -x 1 > "${outdir}/iostat.log" 2>&1 &
+	IOSTAT_PID=$!
+	(while true; do
+		echo "=== $(date '+%s') ==="
+		cat /proc/meminfo
+		sleep 1
+	done) > "${outdir}/meminfo.log" 2>&1 &
+	MEMINFO_PID=$!
+}
+
+stop_monitors() {
+	log "Stopping monitors"
+	kill "$VMSTAT_PID" "$IOSTAT_PID" "$MEMINFO_PID" 2>/dev/null || true
+	wait "$VMSTAT_PID" "$IOSTAT_PID" "$MEMINFO_PID" 2>/dev/null || true
+}
+
+cleanup_test_files() {
+	local filepath="${TEST_DIR}/$1"
+	log "Cleaning up $filepath"
+	run_cmd rm -f "$filepath"
+}
+
+# Run a single fio benchmark
+run_fio() {
+	local job_file=$1
+	local outdir=$2
+	local filename=$3
+	local fio_size=${4:-$SIZE}
+	local keep=${5:-}
+	local extra_args=${6:-}
+	local uncached=${7:-0}
+
+	# Inject uncached=N into the job file if needed
+	local actual_job
+	actual_job=$(make_job_file "$job_file" "$uncached")
+
+	local job_name
+	job_name=$(basename "$job_file" .fio)
+
+	log "Running fio job: $job_name -> $outdir (file=${TEST_DIR}/$filename size=$fio_size)"
+	mkdir -p "$outdir"
+
+	drop_caches
+	start_monitors "$outdir"
+	# Skip perf lock profiling for precreate/setup runs
+	[ "$keep" != "keep" ] && start_perf_lock "$outdir"
+
+	# shellcheck disable=SC2086
+	run_cmd "$FIO_BIN" "$actual_job" \
+		--output-format=json \
+		--output="${outdir}/${job_name}.json" \
+		--filename="${TEST_DIR}/$filename" \
+		--size="$fio_size" \
+		$extra_args
+
+	[ "$keep" != "keep" ] && stop_perf_lock "$outdir"
+	stop_monitors
+	log "Finished: $job_name"
+
+	# Clean up temp job file if one was created
+	[ "$actual_job" != "$job_file" ] && rm -f "$actual_job"
+
+	if [ "$keep" != "keep" ]; then
+		cleanup_test_files "$filename"
+	fi
+}
+
+########################################################################
+# Preflight
+########################################################################
+preflight() {
+	log "=== Preflight checks ==="
+
+	if ! command -v "$FIO_BIN" &>/dev/null; then
+		echo "ERROR: fio not found at $FIO_BIN"
+		exit 1
+	fi
+
+	if [ ! -d "$TEST_DIR" ]; then
+		echo "ERROR: Test directory $TEST_DIR does not exist"
+		exit 1
+	fi
+
+	# Quick check that RWF_DONTCACHE works on this filesystem
+	local testfile="${TEST_DIR}/.dontcache_test"
+	if ! "$FIO_BIN" --name=test --ioengine=io_uring --rw=write \
+		--bs=4k --size=4k --direct=0 --uncached=1 \
+		--filename="$testfile" 2>/dev/null; then
+		echo "WARNING: RWF_DONTCACHE may not be supported on $TEST_DIR"
+		echo "         (filesystem must support FOP_DONTCACHE)"
+	fi
+	rm -f "$testfile"
+
+	log "Test directory: $TEST_DIR"
+	log "File size: $SIZE"
+	log "fio binary: $FIO_BIN"
+	log "Results: $RESULTS_DIR"
+
+	# Record system info
+	{
+		echo "Timestamp: $(date +%Y%m%d-%H%M%S)"
+		echo "Kernel: $(uname -r)"
+		echo "Hostname: $(hostname)"
+		echo "Filesystem: $(df -T "$TEST_DIR" | tail -1 | awk '{print $2}')"
+		echo "File size: $SIZE"
+		echo "Test dir: $TEST_DIR"
+	} > "${RESULTS_DIR}/sysinfo.txt"
+}
+
+########################################################################
+# Deliverable 1: Single-client benchmarks
+########################################################################
+run_deliverable1() {
+	log "=========================================="
+	log "Deliverable 1: Single-client benchmarks"
+	log "=========================================="
+
+	# Sequential write
+	for mode in $MODES; do
+		local mname
+		mname=$(mode_name $mode)
+		local fio_args
+		fio_args=$(mode_fio_args $mode)
+
+		drop_caches
+		run_fio "${FIO_JOBS_DIR}/seq-write.fio" \
+			"${RESULTS_DIR}/seq-write/${mname}" \
+			"seq-write_testfile" "$SIZE" "" "$fio_args" \
+			"$(mode_uncached $mode)"
+	done
+
+	# Random write
+	for mode in $MODES; do
+		local mname
+		mname=$(mode_name $mode)
+		local fio_args
+		fio_args=$(mode_fio_args $mode)
+
+		drop_caches
+		run_fio "${FIO_JOBS_DIR}/rand-write.fio" \
+			"${RESULTS_DIR}/rand-write/${mname}" \
+			"rand-write_testfile" "$SIZE" "" "$fio_args" \
+			"$(mode_uncached $mode)"
+	done
+
+	# Sequential read — pre-create file, then read with each mode
+	log "Pre-creating sequential read test file"
+	run_fio "${FIO_JOBS_DIR}/seq-write.fio" \
+		"${RESULTS_DIR}/seq-read/precreate" \
+		"seq-read_testfile" "$SIZE" "keep"
+
+	for rmode in $MODES; do
+		local mname
+		mname=$(mode_name $rmode)
+		local fio_args
+		fio_args=$(mode_fio_args $rmode)
+		local keep="keep"
+		[ "$rmode" -eq 2 ] && keep=""
+
+		drop_caches
+		run_fio "${FIO_JOBS_DIR}/seq-read.fio" \
+			"${RESULTS_DIR}/seq-read/${mname}" \
+			"seq-read_testfile" "$SIZE" "$keep" "$fio_args" \
+			"$(mode_uncached $rmode)"
+	done
+
+	# Random read — pre-create file, then read with each mode
+	log "Pre-creating random read test file"
+	run_fio "${FIO_JOBS_DIR}/seq-write.fio" \
+		"${RESULTS_DIR}/rand-read/precreate" \
+		"rand-read_testfile" "$SIZE" "keep"
+
+	for rmode in $MODES; do
+		local mname
+		mname=$(mode_name $rmode)
+		local fio_args
+		fio_args=$(mode_fio_args $rmode)
+		local keep="keep"
+		[ "$rmode" -eq 2 ] && keep=""
+
+		drop_caches
+		run_fio "${FIO_JOBS_DIR}/rand-read.fio" \
+			"${RESULTS_DIR}/rand-read/${mname}" \
+			"rand-read_testfile" "$SIZE" "$keep" "$fio_args" \
+			"$(mode_uncached $rmode)"
+	done
+}
+
+########################################################################
+# Deliverable 2: Multi-client tests
+########################################################################
+run_deliverable2() {
+	log "=========================================="
+	log "Deliverable 2: Noisy-neighbor benchmarks"
+	log "=========================================="
+
+	local num_clients=4
+	local client_size
+	local mem_kb
+	mem_kb=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
+	client_size="$(( mem_kb / 1024 / num_clients ))M"
+
+	# Scenario A: Multiple writers
+	for mode in $MODES; do
+		local mname
+		mname=$(mode_name $mode)
+		local fio_args
+		fio_args=$(mode_fio_args $mode)
+
+		drop_caches
+		run_fio "${FIO_JOBS_DIR}/multi-write.fio" \
+			"${RESULTS_DIR}/multi-write/${mname}" \
+			"multi-write_testfile" "$client_size" "" "$fio_args" \
+			"$(mode_uncached $mode)"
+	done
+
+	# Scenario C: Noisy writer + latency-sensitive readers
+	for mode in $MODES; do
+		local mname
+		mname=$(mode_name $mode)
+		local fio_args
+		fio_args=$(mode_fio_args $mode)
+		local uncached
+		uncached=$(mode_uncached $mode)
+		local writer_job
+		writer_job=$(make_job_file "${FIO_JOBS_DIR}/noisy-writer.fio" "$uncached")
+		local reader_job
+		reader_job=$(make_job_file "${FIO_JOBS_DIR}/lat-reader.fio" "$uncached")
+		local outdir="${RESULTS_DIR}/noisy-neighbor/${mname}"
+		mkdir -p "$outdir"
+
+		# Pre-create read files
+		for i in $(seq 1 $(( num_clients - 1 ))); do
+			log "Pre-creating read file for reader $i"
+			run_fio "${FIO_JOBS_DIR}/seq-write.fio" \
+				"${outdir}/precreate_reader${i}" \
+				"reader${i}_readfile" \
+				"512M" "keep"
+		done
+		drop_caches
+		start_monitors "$outdir"
+		start_perf_lock "$outdir"
+
+		# Noisy writer
+		# shellcheck disable=SC2086
+		run_cmd "$FIO_BIN" "$writer_job" \
+			--output-format=json \
+			--output="${outdir}/noisy_writer.json" \
+			--filename="${TEST_DIR}/bulk_testfile" \
+			--size="$SIZE" \
+			$fio_args &
+		local writer_pid=$!
+
+		# Latency-sensitive readers
+		local reader_pids=()
+		for i in $(seq 1 $(( num_clients - 1 ))); do
+			# shellcheck disable=SC2086
+			run_cmd "$FIO_BIN" "$reader_job" \
+				--output-format=json \
+				--output="${outdir}/reader${i}.json" \
+				--filename="${TEST_DIR}/reader${i}_readfile" \
+				--size="512M" \
+				$fio_args &
+			reader_pids+=($!)
+		done
+
+		local rc=0
+		wait "$writer_pid" || rc=$?
+		for pid in "${reader_pids[@]}"; do
+			wait "$pid" || rc=$?
+		done
+
+		stop_perf_lock "$outdir"
+		stop_monitors
+		[ $rc -ne 0 ] && log "WARNING: some fio jobs exited non-zero"
+
+		[ "$writer_job" != "${FIO_JOBS_DIR}/noisy-writer.fio" ] && rm -f "$writer_job"
+		[ "$reader_job" != "${FIO_JOBS_DIR}/lat-reader.fio" ] && rm -f "$reader_job"
+		cleanup_test_files "bulk_testfile"
+		for i in $(seq 1 $(( num_clients - 1 ))); do
+			cleanup_test_files "reader${i}_readfile"
+		done
+	done
+
+	# Scenario D: Mixed-mode noisy neighbor
+	# dontcache writes + buffered reads
+	local outdir="${RESULTS_DIR}/noisy-neighbor-mixed/dontcache-w_buffered-r"
+	mkdir -p "$outdir"
+	local writer_job
+	writer_job=$(make_job_file "${FIO_JOBS_DIR}/noisy-writer.fio" 1)
+
+	for i in $(seq 1 $(( num_clients - 1 ))); do
+		log "Pre-creating read file for reader $i"
+		run_fio "${FIO_JOBS_DIR}/seq-write.fio" \
+			"${outdir}/precreate_reader${i}" \
+			"reader${i}_readfile" \
+			"512M" "keep"
+	done
+	drop_caches
+	start_monitors "$outdir"
+	start_perf_lock "$outdir"
+
+	# Writer with dontcache
+	run_cmd "$FIO_BIN" "$writer_job" \
+		--output-format=json \
+		--output="${outdir}/noisy_writer.json" \
+		--filename="${TEST_DIR}/bulk_testfile" \
+		--size="$SIZE" \
+		--direct=0 &
+	local writer_pid=$!
+
+	# Readers with buffered (no uncached flag)
+	local reader_pids=()
+	for i in $(seq 1 $(( num_clients - 1 ))); do
+		run_cmd "$FIO_BIN" "${FIO_JOBS_DIR}/lat-reader.fio" \
+			--output-format=json \
+			--output="${outdir}/reader${i}.json" \
+			--filename="${TEST_DIR}/reader${i}_readfile" \
+			--size="512M" \
+			--direct=0 &
+		reader_pids+=($!)
+	done
+
+	local rc=0
+	wait "$writer_pid" || rc=$?
+	for pid in "${reader_pids[@]}"; do
+		wait "$pid" || rc=$?
+	done
+
+	stop_perf_lock "$outdir"
+	stop_monitors
+	[ $rc -ne 0 ] && log "WARNING: some fio jobs exited non-zero"
+
+	[ "$writer_job" != "${FIO_JOBS_DIR}/noisy-writer.fio" ] && rm -f "$writer_job"
+	cleanup_test_files "bulk_testfile"
+	for i in $(seq 1 $(( num_clients - 1 ))); do
+		cleanup_test_files "reader${i}_readfile"
+	done
+
+	# Scenario E: Competing writers (dontcache vs buffered on separate files)
+	# This tests whether the dontcache flusher kick interferes with a
+	# normal buffered writer sharing the same backing device.
+	log "--- Scenario E: Competing writers (separate files) ---"
+
+	# Sub-scenario: dontcache writer vs buffered writer
+	local outdir="${RESULTS_DIR}/competing-writers/dontcache-vs-buffered"
+	mkdir -p "$outdir"
+	local dc_writer_job
+	dc_writer_job=$(make_job_file "${FIO_JOBS_DIR}/noisy-writer.fio" 1)
+
+	drop_caches
+	start_monitors "$outdir"
+	start_perf_lock "$outdir"
+
+	# Writer A: dontcache
+	run_cmd "$FIO_BIN" "$dc_writer_job" \
+		--output-format=json \
+		--output="${outdir}/writer_dontcache.json" \
+		--filename="${TEST_DIR}/writer_a_testfile" \
+		--size="$SIZE" \
+		--direct=0 &
+	local writer_a_pid=$!
+
+	# Writer B: buffered
+	run_cmd "$FIO_BIN" "${FIO_JOBS_DIR}/noisy-writer.fio" \
+		--output-format=json \
+		--output="${outdir}/writer_buffered.json" \
+		--filename="${TEST_DIR}/writer_b_testfile" \
+		--size="$SIZE" \
+		--direct=0 &
+	local writer_b_pid=$!
+
+	local rc=0
+	wait "$writer_a_pid" || rc=$?
+	wait "$writer_b_pid" || rc=$?
+
+	stop_perf_lock "$outdir"
+	stop_monitors
+	[ $rc -ne 0 ] && log "WARNING: some fio jobs exited non-zero"
+
+	[ "$dc_writer_job" != "${FIO_JOBS_DIR}/noisy-writer.fio" ] && rm -f "$dc_writer_job"
+	cleanup_test_files "writer_a_testfile"
+	cleanup_test_files "writer_b_testfile"
+
+	# Sub-scenario: buffered writer vs buffered writer (baseline)
+	outdir="${RESULTS_DIR}/competing-writers/buffered-vs-buffered"
+	mkdir -p "$outdir"
+
+	drop_caches
+	start_monitors "$outdir"
+	start_perf_lock "$outdir"
+
+	# Writer A: buffered
+	run_cmd "$FIO_BIN" "${FIO_JOBS_DIR}/noisy-writer.fio" \
+		--output-format=json \
+		--output="${outdir}/writer_a.json" \
+		--filename="${TEST_DIR}/writer_a_testfile" \
+		--size="$SIZE" \
+		--direct=0 &
+	writer_a_pid=$!
+
+	# Writer B: buffered
+	run_cmd "$FIO_BIN" "${FIO_JOBS_DIR}/noisy-writer.fio" \
+		--output-format=json \
+		--output="${outdir}/writer_b.json" \
+		--filename="${TEST_DIR}/writer_b_testfile" \
+		--size="$SIZE" \
+		--direct=0 &
+	writer_b_pid=$!
+
+	rc=0
+	wait "$writer_a_pid" || rc=$?
+	wait "$writer_b_pid" || rc=$?
+
+	stop_perf_lock "$outdir"
+	stop_monitors
+	[ $rc -ne 0 ] && log "WARNING: some fio jobs exited non-zero"
+
+	cleanup_test_files "writer_a_testfile"
+	cleanup_test_files "writer_b_testfile"
+}
+
+########################################################################
+# Deliverable 3: Axboe 32-file write benchmark
+########################################################################
+run_deliverable3() {
+	log "=========================================="
+	log "Deliverable 3: 32-file write (Axboe test)"
+	log "=========================================="
+
+	# Per-file size: 2x RAM / 32 so total written exceeds RAM
+	local per_file_size
+	local mem_kb
+	mem_kb=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
+	per_file_size="$(( mem_kb * 2 / 1024 / 32 ))M"
+
+	for mode in $MODES; do
+		local mname
+		mname=$(mode_name $mode)
+		local fio_args
+		fio_args=$(mode_fio_args $mode)
+
+		drop_caches
+		run_fio "${FIO_JOBS_DIR}/axboe-write.fio" \
+			"${RESULTS_DIR}/axboe-write/${mname}" \
+			"axboe-write_testfile" "$per_file_size" "" "$fio_args" \
+			"$(mode_uncached $mode)"
+	done
+}
+
+########################################################################
+# Main
+########################################################################
+preflight
+run_deliverable1
+run_deliverable2
+run_deliverable3
+
+log "=========================================="
+log "All benchmarks complete."
+log "Results in: $RESULTS_DIR"
+log "Parse with: scripts/parse-results.sh $RESULTS_DIR"
+log "=========================================="

-- 
2.54.0


