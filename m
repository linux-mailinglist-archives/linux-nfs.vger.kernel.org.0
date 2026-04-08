Return-Path: <linux-nfs+bounces-20755-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JMaGG1m1mnIEwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20755-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 16:30:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F21B33BDAB3
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 16:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C811308B381
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FA63D4100;
	Wed,  8 Apr 2026 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVCBe72b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD83D3333;
	Wed,  8 Apr 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658342; cv=none; b=hR7dmKPS5DzrhamEYHW4BYpxo36hfMexZaIyZZa/+mkHukbX28jVeSvnOZHKn5VVnMhUnYP90/iPiJM24KrGJghMjeKRAQZgDgiFJ1yy8Jr0h/tIaawk4TP70DUREB/1srxvpy+eu/Hfcq7o5XFzCBRX5NG3490y2cVngA9Ofls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658342; c=relaxed/simple;
	bh=taPEbFgqMwKXv25KgD+71KIz1AKpoNMNwUFNOGFERF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhS1UNaLn6thAlyrL3NBBJirqwqblT1rHEDEXLhP5//NbpV8DQC8ypj+OvnrOY/2difRXNfYlMhrMsTx6jCb1r6IMwTq6XQyoUSmtd7m2JCftO4cK2fazph/IaN6QR6NlV+lXCsH9qEnCFIuAQV3+T5hcBMV3yEy0hambA3UUQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVCBe72b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75BBC2BCB0;
	Wed,  8 Apr 2026 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775658341;
	bh=taPEbFgqMwKXv25KgD+71KIz1AKpoNMNwUFNOGFERF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TVCBe72buTeUVsVPcbc9+qfWlMmhxvbV+YyrzL4D9u2Jpo+xFh/G+/22ne6RiBpS1
	 VIxapl+NWF+yNstIly9Py4PS2opcjmJNk6r5u/z/7Ir1X7Frga5atbKT4/n76qV6bd
	 t4UuOhp2Yz9tai5qWoGU9DXghfweyjuS/7eqedxuhH7yQDEQZR17Qt5niS8B/TbnJU
	 aQKG57nqYY4MFyAswV4ja0b/QTIEflx6L5JFvxEcpuAWZ9fgRrTVtAwSlw+HcVO6AA
	 dL8Vm2bvSFvSi6KBgrGiXjdIzoalTtQNCFLuRT13YDseUirGYxBE6rv0uwvVLhaXC7
	 cx9NexbuVe+kg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 08 Apr 2026 10:25:22 -0400
Subject: [PATCH v2 2/3] testing: add nfsd-io-bench NFS server benchmark
 suite
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-dontcache-v2-2-948dec1e756b@kernel.org>
References: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
In-Reply-To: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=32977; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=taPEbFgqMwKXv25KgD+71KIz1AKpoNMNwUFNOGFERF8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1mVfN9bf/8o1DtS9XpzIGaPB1UpJIMkAnyS+d
 878DF503GGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadZlXwAKCRAADmhBGVaC
 FR3qD/45o1cxW6ieDwXtdV5VOE/pAhY7wqhnUlmaiz1d1rod4Flgzwao3XD5JFwyC2PFhvMGQV9
 amGNGJnnWU2QFm4bFFx1p69p9V/X9ITdo6bA/OtKO2OGhgiQNtD/++yK+9Ox8r4OZDJPWwrRx7O
 byGivTF+t9ZnQFglthwzISn4gd0X+5uCgadxruWvI7ayAI6cddI97gEeP5dJluel69aAHMLiO1Q
 p/KfvQHfuPlb1byK8yCvqM/7oMlHlsvGYP/fjUZppbmRFYOkhPwzlq8SLdEZurMM/vSjivyCy7I
 wS6MHTRKg6RQM4A9t/EaUL+BnM8+wBqo7RrDPE1gAR3BoeezhfMKJd4er38qkEfrWcTSVHOvmJu
 0hToyICJ0fQ+ZAg4v3azCgmHWXOFuw/ilj5hfuI4dON3PofDQwuhEsUSHF/vfuqq/EpKxS/WrDl
 K86XdpItdvDFQSJkqIcS3ywkIHv4uWZqOVn3rwlPkXvx4OoQIUZ2ijPh1dE5L40a5XvqLycHweI
 LwdFCeO5JF6akOQy8SNKd4wE6liIG1jNria2LwF8W7cUM+BdNMSvMpiu5Jk2o374pIt5VQuR1lr
 /o1Zc7gdTqmE6HaZ8BPjFRUnTFH2hFusb1H0zZKe93BKXO4q303qk7on205bYBImXdsvqdD3iMU
 YAFnVLbMLEcI0ZQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20755-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F21B33BDAB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a benchmark suite for testing NFSD I/O mode performance using fio
with the libnfs backend against an NFS server on localhost.  Tests
buffered, dontcache, and direct I/O modes via NFSD debugfs controls.

Includes:
 - fio job files for sequential/random read/write, multi-writer,
   noisy-neighbor, and latency-sensitive reader workloads
 - run-benchmarks.sh: orchestrates test matrix with mode switching
 - parse-results.sh: extracts metrics from fio JSON output
 - setup-server.sh: configures NFS export for testing

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 .../testing/nfsd-io-bench/fio-jobs/lat-reader.fio  |  15 +
 .../testing/nfsd-io-bench/fio-jobs/multi-write.fio |  14 +
 .../nfsd-io-bench/fio-jobs/noisy-writer.fio        |  14 +
 tools/testing/nfsd-io-bench/fio-jobs/rand-read.fio |  15 +
 .../testing/nfsd-io-bench/fio-jobs/rand-write.fio  |  15 +
 tools/testing/nfsd-io-bench/fio-jobs/seq-read.fio  |  14 +
 tools/testing/nfsd-io-bench/fio-jobs/seq-write.fio |  14 +
 .../testing/nfsd-io-bench/scripts/parse-results.sh | 238 +++++++++
 .../nfsd-io-bench/scripts/run-benchmarks.sh        | 591 +++++++++++++++++++++
 .../testing/nfsd-io-bench/scripts/setup-server.sh  |  94 ++++
 10 files changed, 1024 insertions(+)

diff --git a/tools/testing/nfsd-io-bench/fio-jobs/lat-reader.fio b/tools/testing/nfsd-io-bench/fio-jobs/lat-reader.fio
new file mode 100644
index 000000000000..61af37e8b860
--- /dev/null
+++ b/tools/testing/nfsd-io-bench/fio-jobs/lat-reader.fio
@@ -0,0 +1,15 @@
+[global]
+ioengine=nfs
+nfs_url=nfs://localhost/export
+direct=0
+bs=4k
+numjobs=16
+runtime=300
+time_based=1
+group_reporting=1
+rw=randread
+log_avg_msec=1000
+write_bw_log=latreader
+write_lat_log=latreader
+
+[lat_reader]
diff --git a/tools/testing/nfsd-io-bench/fio-jobs/multi-write.fio b/tools/testing/nfsd-io-bench/fio-jobs/multi-write.fio
new file mode 100644
index 000000000000..16b792aecabb
--- /dev/null
+++ b/tools/testing/nfsd-io-bench/fio-jobs/multi-write.fio
@@ -0,0 +1,14 @@
+[global]
+ioengine=nfs
+nfs_url=nfs://localhost/export
+direct=0
+bs=1M
+numjobs=16
+time_based=0
+group_reporting=1
+rw=write
+log_avg_msec=1000
+write_bw_log=multiwrite
+write_lat_log=multiwrite
+
+[writer]
diff --git a/tools/testing/nfsd-io-bench/fio-jobs/noisy-writer.fio b/tools/testing/nfsd-io-bench/fio-jobs/noisy-writer.fio
new file mode 100644
index 000000000000..615154a7737e
--- /dev/null
+++ b/tools/testing/nfsd-io-bench/fio-jobs/noisy-writer.fio
@@ -0,0 +1,14 @@
+[global]
+ioengine=nfs
+nfs_url=nfs://localhost/export
+direct=0
+bs=1M
+numjobs=16
+time_based=0
+group_reporting=1
+rw=write
+log_avg_msec=1000
+write_bw_log=noisywriter
+write_lat_log=noisywriter
+
+[bulk_writer]
diff --git a/tools/testing/nfsd-io-bench/fio-jobs/rand-read.fio b/tools/testing/nfsd-io-bench/fio-jobs/rand-read.fio
new file mode 100644
index 000000000000..501bae7416a8
--- /dev/null
+++ b/tools/testing/nfsd-io-bench/fio-jobs/rand-read.fio
@@ -0,0 +1,15 @@
+[global]
+ioengine=nfs
+nfs_url=nfs://localhost/export
+direct=0
+bs=4k
+numjobs=16
+runtime=300
+time_based=1
+group_reporting=1
+rw=randread
+log_avg_msec=1000
+write_bw_log=randread
+write_lat_log=randread
+
+[randread]
diff --git a/tools/testing/nfsd-io-bench/fio-jobs/rand-write.fio b/tools/testing/nfsd-io-bench/fio-jobs/rand-write.fio
new file mode 100644
index 000000000000..d891d04197ae
--- /dev/null
+++ b/tools/testing/nfsd-io-bench/fio-jobs/rand-write.fio
@@ -0,0 +1,15 @@
+[global]
+ioengine=nfs
+nfs_url=nfs://localhost/export
+direct=0
+bs=64k
+numjobs=16
+runtime=300
+time_based=1
+group_reporting=1
+rw=randwrite
+log_avg_msec=1000
+write_bw_log=randwrite
+write_lat_log=randwrite
+
+[randwrite]
diff --git a/tools/testing/nfsd-io-bench/fio-jobs/seq-read.fio b/tools/testing/nfsd-io-bench/fio-jobs/seq-read.fio
new file mode 100644
index 000000000000..6e24ab355026
--- /dev/null
+++ b/tools/testing/nfsd-io-bench/fio-jobs/seq-read.fio
@@ -0,0 +1,14 @@
+[global]
+ioengine=nfs
+nfs_url=nfs://localhost/export
+direct=0
+bs=1M
+numjobs=16
+time_based=0
+group_reporting=1
+rw=read
+log_avg_msec=1000
+write_bw_log=seqread
+write_lat_log=seqread
+
+[seqread]
diff --git a/tools/testing/nfsd-io-bench/fio-jobs/seq-write.fio b/tools/testing/nfsd-io-bench/fio-jobs/seq-write.fio
new file mode 100644
index 000000000000..260858e345f5
--- /dev/null
+++ b/tools/testing/nfsd-io-bench/fio-jobs/seq-write.fio
@@ -0,0 +1,14 @@
+[global]
+ioengine=nfs
+nfs_url=nfs://localhost/export
+direct=0
+bs=1M
+numjobs=16
+time_based=0
+group_reporting=1
+rw=write
+log_avg_msec=1000
+write_bw_log=seqwrite
+write_lat_log=seqwrite
+
+[seqwrite]
diff --git a/tools/testing/nfsd-io-bench/scripts/parse-results.sh b/tools/testing/nfsd-io-bench/scripts/parse-results.sh
new file mode 100755
index 000000000000..0427d411db04
--- /dev/null
+++ b/tools/testing/nfsd-io-bench/scripts/parse-results.sh
@@ -0,0 +1,238 @@
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
+	echo "  Mode: $mode"
+	printf "  %-10s %10s %10s %10s %10s %10s %10s\n" \
+		"Client" "MB/s" "IOPS" "Avg(us)" "p50(us)" "p99(us)" "p99.9(us)"
+
+	total_bw=0
+	count=0
+	for json_file in "${dir}"/client*.json; do
+		[ -f "$json_file" ] || continue
+		client=$(basename "$json_file" .json)
+		read -r mbps iops avg_lat p50 p99 p999 <<< \
+			"$(extract_metrics "$json_file" "write")"
+		printf "  %-10s %10s %10s %10s %10s %10s %10s\n" \
+			"$client" "$mbps" "$iops" "$avg_lat" "$p50" "$p99" "$p999"
+		total_bw=$(echo "$total_bw + ${mbps:-0}" | bc 2>/dev/null || echo "$total_bw")
+		count=$(( count + 1 ))
+	done
+
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
+echo "=================================================================="
+echo "  System Info"
+echo "=================================================================="
+if [ -f "${RESULTS_DIR}/sysinfo.txt" ]; then
+	head -6 "${RESULTS_DIR}/sysinfo.txt"
+fi
+echo ""
diff --git a/tools/testing/nfsd-io-bench/scripts/run-benchmarks.sh b/tools/testing/nfsd-io-bench/scripts/run-benchmarks.sh
new file mode 100755
index 000000000000..2b0cf6e79dff
--- /dev/null
+++ b/tools/testing/nfsd-io-bench/scripts/run-benchmarks.sh
@@ -0,0 +1,591 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# NFS server I/O mode benchmark suite
+#
+# Runs fio with the NFS ioengine against an NFS server on localhost,
+# testing buffered, dontcache, and direct I/O modes.
+#
+# Usage: ./run-benchmarks.sh [OPTIONS]
+#
+# Options:
+#   -e EXPORT_PATH   Server export path (default: /export)
+#   -s SIZE          fio file size, should be >= 2x RAM (default: auto-detect)
+#   -r RESULTS_DIR   Where to store results (default: ./results)
+#   -n NFS_VER       NFS version: 3 or 4 (default: 3)
+#   -j FIO_JOBS_DIR  Path to fio job files (default: ../fio-jobs)
+#   -d               Dry run: print commands without executing
+#   -h               Show this help
+
+set -euo pipefail
+
+# Defaults
+EXPORT_PATH="/export"
+SIZE=""
+RESULTS_DIR="./results"
+NFS_VER=3
+SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
+FIO_JOBS_DIR="${SCRIPT_DIR}/../fio-jobs"
+DRY_RUN=0
+MODES="0 1 2"
+PERF_LOCK=0
+
+DEBUGFS_BASE="/sys/kernel/debug/nfsd"
+IO_CACHE_READ="${DEBUGFS_BASE}/io_cache_read"
+IO_CACHE_WRITE="${DEBUGFS_BASE}/io_cache_write"
+DISABLE_SPLICE="${DEBUGFS_BASE}/disable-splice-read"
+
+usage() {
+	echo "Usage: $0 [OPTIONS]"
+	echo "  -e EXPORT_PATH   Server export path (default: /export)"
+	echo "  -s SIZE          fio file size (default: 2x RAM)"
+	echo "  -r RESULTS_DIR   Results directory (default: ./results)"
+	echo "  -n NFS_VER       NFS version: 3 or 4 (default: 3)"
+	echo "  -j FIO_JOBS_DIR  Path to fio job files"
+	echo "  -D               Dontcache only (skip buffered and direct tests)"
+	echo "  -p               Profile kernel lock contention with perf lock"
+	echo "  -d               Dry run"
+	echo "  -h               Help"
+	exit 1
+}
+
+while getopts "e:s:r:n:j:Dpdh" opt; do
+	case $opt in
+	e) EXPORT_PATH="$OPTARG" ;;
+	s) SIZE="$OPTARG" ;;
+	r) RESULTS_DIR="$OPTARG" ;;
+	n) NFS_VER="$OPTARG" ;;
+	j) FIO_JOBS_DIR="$OPTARG" ;;
+	D) MODES="1" ;;
+	p) PERF_LOCK=1 ;;
+	d) DRY_RUN=1 ;;
+	h) usage ;;
+	*) usage ;;
+	esac
+done
+
+# Auto-detect size: 2x total RAM
+if [ -z "$SIZE" ]; then
+	MEM_KB=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
+	MEM_GB=$(( MEM_KB / 1024 / 1024 ))
+	SIZE="$(( MEM_GB * 2 ))G"
+	echo "Auto-detected RAM: ${MEM_GB}G, using file size: ${SIZE}"
+fi
+
+
+log() {
+	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
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
+# Preflight checks
+preflight() {
+	log "=== Preflight checks ==="
+
+	if ! command -v fio &>/dev/null; then
+		echo "ERROR: fio not found in PATH"
+		exit 1
+	fi
+
+	# Check fio has nfs ioengine
+	if ! fio --enghelp=nfs &>/dev/null; then
+		echo "ERROR: fio does not have the nfs ioengine (needs libnfs)"
+		exit 1
+	fi
+
+	# Check debugfs knobs exist
+	for knob in "$IO_CACHE_READ" "$IO_CACHE_WRITE" "$DISABLE_SPLICE"; do
+		if [ ! -f "$knob" ]; then
+			echo "ERROR: $knob not found. Is the kernel new enough?"
+			exit 1
+		fi
+	done
+
+	# Check NFS server is exporting
+	if ! showmount -e localhost 2>/dev/null | grep -q "$EXPORT_PATH"; then
+		echo "WARNING: $EXPORT_PATH not in showmount output, proceeding anyway"
+	fi
+
+	# Print system info
+	echo "Kernel:     $(uname -r)"
+	echo "RAM:        $(awk '/MemTotal/ {printf "%.1f GB", $2/1024/1024}' /proc/meminfo)"
+	echo "Export:     $EXPORT_PATH"
+	echo "NFS ver:    $NFS_VER"
+	echo "File size:  $SIZE"
+	echo "Results:    $RESULTS_DIR"
+	echo ""
+}
+
+# Set server I/O mode via debugfs
+set_io_mode() {
+	local cache_write=$1
+	local cache_read=$2
+	local splice_off=$3
+
+	log "Setting io_cache_write=$cache_write io_cache_read=$cache_read disable-splice-read=$splice_off"
+	run_cmd bash -c "echo $cache_write > $IO_CACHE_WRITE"
+	run_cmd bash -c "echo $cache_read  > $IO_CACHE_READ"
+	run_cmd bash -c "echo $splice_off  > $DISABLE_SPLICE"
+}
+
+# Drop page cache on server
+drop_caches() {
+	log "Dropping page cache"
+	run_cmd bash -c "sync && echo 3 > /proc/sys/vm/drop_caches"
+	sleep 1
+}
+
+# Start background server monitoring
+start_monitors() {
+	local outdir=$1
+
+	log "Starting server monitors in $outdir"
+	run_cmd vmstat 1 > "${outdir}/vmstat.log" 2>&1 &
+	VMSTAT_PID=$!
+
+	run_cmd iostat -x 1 > "${outdir}/iostat.log" 2>&1 &
+	IOSTAT_PID=$!
+
+	# Sample /proc/meminfo every second
+	(while true; do
+		echo "=== $(date '+%s') ==="
+		cat /proc/meminfo
+		sleep 1
+	done) > "${outdir}/meminfo.log" 2>&1 &
+	MEMINFO_PID=$!
+}
+
+# Stop background monitors
+stop_monitors() {
+	log "Stopping monitors"
+	kill "$VMSTAT_PID" "$IOSTAT_PID" "$MEMINFO_PID" 2>/dev/null || true
+	wait "$VMSTAT_PID" "$IOSTAT_PID" "$MEMINFO_PID" 2>/dev/null || true
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
+# Run a single fio benchmark.
+# nfs_url is set in the job files; we pass --filename and --size on
+# the command line to vary the target file and data volume per run.
+# Pass "keep" as 5th arg to preserve the test file after the run.
+run_fio() {
+	local job_file=$1
+	local outdir=$2
+	local filename=$3
+	local fio_size=${4:-$SIZE}
+	local keep=${5:-}
+
+	local job_name
+	job_name=$(basename "$job_file" .fio)
+
+	log "Running fio job: $job_name -> $outdir (file=$filename size=$fio_size)"
+	mkdir -p "$outdir"
+
+	drop_caches
+	start_monitors "$outdir"
+	# Skip perf lock profiling for precreate/setup runs
+	[ "$keep" != "keep" ] && start_perf_lock "$outdir"
+
+	run_cmd fio "$job_file" \
+		--output-format=json \
+		--output="${outdir}/${job_name}.json" \
+		--filename="$filename" \
+		--size="$fio_size"
+
+	[ "$keep" != "keep" ] && stop_perf_lock "$outdir"
+	stop_monitors
+
+	log "Finished: $job_name"
+
+	# Clean up test file to free disk space unless told to keep it
+	if [ "$keep" != "keep" ]; then
+		cleanup_test_files "$filename"
+	fi
+}
+
+# Remove test files from the export to free disk space
+cleanup_test_files() {
+	local filename
+	for filename in "$@"; do
+		local filepath="${EXPORT_PATH}/${filename}"
+		log "Cleaning up: $filepath"
+		run_cmd rm -f "$filepath"
+	done
+}
+
+# Ensure parent directories exist under the export for a given filename
+ensure_export_dirs() {
+	local filename
+	for filename in "$@"; do
+		local dirpath="${EXPORT_PATH}/$(dirname "$filename")"
+		if [ "$dirpath" != "${EXPORT_PATH}/." ] && [ ! -d "$dirpath" ]; then
+			log "Creating directory: $dirpath"
+			run_cmd mkdir -p "$dirpath"
+		fi
+	done
+}
+
+# Mode name from numeric value
+mode_name() {
+	case $1 in
+	0) echo "buffered" ;;
+	1) echo "dontcache" ;;
+	2) echo "direct" ;;
+	esac
+}
+
+########################################################################
+# Deliverable 1: Single-client fio benchmarks
+########################################################################
+run_deliverable1() {
+	log "=========================================="
+	log "Deliverable 1: Single-client fio benchmarks"
+	log "=========================================="
+
+	# Write test matrix:
+	# mode 0 (buffered):    splice on  (default)
+	# mode 1 (dontcache):   splice off (required)
+	# mode 2 (direct):      splice off (required)
+
+	# Sequential write
+	for wmode in $MODES; do
+		local mname
+		mname=$(mode_name $wmode)
+		local splice_off=0
+		[ "$wmode" -ne 0 ] && splice_off=1
+
+		drop_caches
+		set_io_mode "$wmode" 0 "$splice_off"
+		run_fio "${FIO_JOBS_DIR}/seq-write.fio" \
+			"${RESULTS_DIR}/seq-write/${mname}" \
+			"seq-write_testfile"
+	done
+
+	# Random write
+	for wmode in $MODES; do
+		local mname
+		mname=$(mode_name $wmode)
+		local splice_off=0
+		[ "$wmode" -ne 0 ] && splice_off=1
+
+		drop_caches
+		set_io_mode "$wmode" 0 "$splice_off"
+		run_fio "${FIO_JOBS_DIR}/rand-write.fio" \
+			"${RESULTS_DIR}/rand-write/${mname}" \
+			"rand-write_testfile"
+	done
+
+	# Sequential read — vary read mode, write stays buffered
+	# Pre-create the file for reading
+	log "Pre-creating sequential read test file"
+	set_io_mode 0 0 0
+	run_fio "${FIO_JOBS_DIR}/seq-write.fio" \
+		"${RESULTS_DIR}/seq-read/precreate" \
+		"seq-read_testfile" "$SIZE" "keep"
+
+	# shellcheck disable=SC2086
+	local last_mode
+	last_mode=$(echo $MODES | awk '{print $NF}')
+
+	for rmode in $MODES; do
+		local mname
+		mname=$(mode_name $rmode)
+		local splice_off=0
+		[ "$rmode" -ne 0 ] && splice_off=1
+		# Keep file for subsequent modes; clean up after last
+		local keep="keep"
+		[ "$rmode" = "$last_mode" ] && keep=""
+
+		drop_caches
+		set_io_mode 0 "$rmode" "$splice_off"
+		run_fio "${FIO_JOBS_DIR}/seq-read.fio" \
+			"${RESULTS_DIR}/seq-read/${mname}" \
+			"seq-read_testfile" "$SIZE" "$keep"
+	done
+
+	# Random read — vary read mode, write stays buffered
+	# Pre-create the file for reading
+	log "Pre-creating random read test file"
+	set_io_mode 0 0 0
+	run_fio "${FIO_JOBS_DIR}/seq-write.fio" \
+		"${RESULTS_DIR}/rand-read/precreate" \
+		"rand-read_testfile" "$SIZE" "keep"
+
+	for rmode in $MODES; do
+		local mname
+		mname=$(mode_name $rmode)
+		local splice_off=0
+		[ "$rmode" -ne 0 ] && splice_off=1
+		# Keep file for subsequent modes; clean up after last
+		local keep="keep"
+		[ "$rmode" = "$last_mode" ] && keep=""
+
+		drop_caches
+		set_io_mode 0 "$rmode" "$splice_off"
+		run_fio "${FIO_JOBS_DIR}/rand-read.fio" \
+			"${RESULTS_DIR}/rand-read/${mname}" \
+			"rand-read_testfile" "$SIZE" "$keep"
+	done
+}
+
+########################################################################
+# Deliverable 2: Multi-client (simulated with multiple fio jobs)
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
+	# Each client gets RAM/num_clients so total > RAM
+	client_size="$(( mem_kb / 1024 / num_clients ))M"
+
+	# Scenario A: Multiple writers
+	for mode in $MODES; do
+		local mname
+		mname=$(mode_name $mode)
+		local splice_off=0
+		[ "$mode" -ne 0 ] && splice_off=1
+		local outdir="${RESULTS_DIR}/multi-write/${mname}"
+		mkdir -p "$outdir"
+
+		set_io_mode "$mode" "$mode" "$splice_off"
+		drop_caches
+
+		# Ensure client directories exist on export
+		for i in $(seq 1 $num_clients); do
+			ensure_export_dirs "client${i}/testfile"
+		done
+
+		start_monitors "$outdir"
+		start_perf_lock "$outdir"
+
+		# Launch N parallel fio writers
+		local pids=()
+		for i in $(seq 1 $num_clients); do
+			run_cmd fio "${FIO_JOBS_DIR}/multi-write.fio" \
+				--output-format=json \
+				--output="${outdir}/client${i}.json" \
+				--filename="client${i}/testfile" \
+				--size="$client_size" &
+			pids+=($!)
+		done
+
+		# Wait for all
+		local rc=0
+		for pid in "${pids[@]}"; do
+			wait "$pid" || rc=$?
+		done
+
+		stop_perf_lock "$outdir"
+		stop_monitors
+		[ $rc -ne 0 ] && log "WARNING: some fio jobs exited non-zero"
+
+		# Clean up test files
+		for i in $(seq 1 $num_clients); do
+			cleanup_test_files "client${i}/testfile"
+		done
+	done
+
+	# Scenario C: Noisy writer + latency-sensitive readers
+	for mode in $MODES; do
+		local mname
+		mname=$(mode_name $mode)
+		local splice_off=0
+		[ "$mode" -ne 0 ] && splice_off=1
+		local outdir="${RESULTS_DIR}/noisy-neighbor/${mname}"
+		mkdir -p "$outdir"
+
+		set_io_mode "$mode" "$mode" "$splice_off"
+		drop_caches
+
+		# Pre-create read files for latency readers
+		for i in $(seq 1 $(( num_clients - 1 ))); do
+			ensure_export_dirs "reader${i}/readfile"
+			log "Pre-creating read file for reader $i"
+			run_fio "${FIO_JOBS_DIR}/multi-write.fio" \
+				"${outdir}/precreate_reader${i}" \
+				"reader${i}/readfile" \
+				"512M" "keep"
+		done
+		drop_caches
+		ensure_export_dirs "bulk/testfile"
+		start_monitors "$outdir"
+		start_perf_lock "$outdir"
+
+		# Noisy writer
+		run_cmd fio "${FIO_JOBS_DIR}/noisy-writer.fio" \
+			--output-format=json \
+			--output="${outdir}/noisy_writer.json" \
+			--filename="bulk/testfile" \
+			--size="$SIZE" &
+		local writer_pid=$!
+
+		# Latency-sensitive readers
+		local reader_pids=()
+		for i in $(seq 1 $(( num_clients - 1 ))); do
+			run_cmd fio "${FIO_JOBS_DIR}/lat-reader.fio" \
+				--output-format=json \
+				--output="${outdir}/reader${i}.json" \
+				--filename="reader${i}/readfile" \
+				--size="512M" &
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
+		# Clean up test files
+		cleanup_test_files "bulk/testfile"
+		for i in $(seq 1 $(( num_clients - 1 ))); do
+			cleanup_test_files "reader${i}/readfile"
+		done
+	done
+	# Scenario D: Mixed-mode noisy neighbor
+	# Test write/read mode combinations where the writer uses a
+	# cache-friendly mode and readers use buffered reads to benefit
+	# from warm cache.
+	local mixed_modes=(
+		# write_mode read_mode label
+		"1 0 dontcache-w_buffered-r"
+	)
+
+	for combo in "${mixed_modes[@]}"; do
+		local wmode rmode label
+		read -r wmode rmode label <<< "$combo"
+		local splice_off=0
+		[ "$wmode" -ne 0 ] && splice_off=1
+		local outdir="${RESULTS_DIR}/noisy-neighbor-mixed/${label}"
+		mkdir -p "$outdir"
+
+		set_io_mode "$wmode" "$rmode" "$splice_off"
+		drop_caches
+
+		# Pre-create read files for latency readers
+		for i in $(seq 1 $(( num_clients - 1 ))); do
+			ensure_export_dirs "reader${i}/readfile"
+			log "Pre-creating read file for reader $i"
+			run_fio "${FIO_JOBS_DIR}/multi-write.fio" \
+				"${outdir}/precreate_reader${i}" \
+				"reader${i}/readfile" \
+				"512M" "keep"
+		done
+		drop_caches
+		ensure_export_dirs "bulk/testfile"
+		start_monitors "$outdir"
+		start_perf_lock "$outdir"
+
+		# Noisy writer
+		run_cmd fio "${FIO_JOBS_DIR}/noisy-writer.fio" \
+			--output-format=json \
+			--output="${outdir}/noisy_writer.json" \
+			--filename="bulk/testfile" \
+			--size="$SIZE" &
+		local writer_pid=$!
+
+		# Latency-sensitive readers
+		local reader_pids=()
+		for i in $(seq 1 $(( num_clients - 1 ))); do
+			run_cmd fio "${FIO_JOBS_DIR}/lat-reader.fio" \
+				--output-format=json \
+				--output="${outdir}/reader${i}.json" \
+				--filename="reader${i}/readfile" \
+				--size="512M" &
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
+		# Clean up test files
+		cleanup_test_files "bulk/testfile"
+		for i in $(seq 1 $(( num_clients - 1 ))); do
+			cleanup_test_files "reader${i}/readfile"
+		done
+	done
+}
+
+########################################################################
+# Main
+########################################################################
+preflight
+
+TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
+RESULTS_DIR="${RESULTS_DIR}/${TIMESTAMP}"
+mkdir -p "$RESULTS_DIR"
+
+# Save system info
+{
+	echo "Timestamp: $TIMESTAMP"
+	echo "Kernel: $(uname -r)"
+	echo "Hostname: $(hostname)"
+	echo "NFS version: $NFS_VER"
+	echo "File size: $SIZE"
+	echo "Export: $EXPORT_PATH"
+	cat /proc/meminfo
+} > "${RESULTS_DIR}/sysinfo.txt"
+
+log "Results will be saved to: $RESULTS_DIR"
+
+run_deliverable1
+run_deliverable2
+
+# Reset to defaults
+set_io_mode 0 0 0
+
+log "=========================================="
+log "All benchmarks complete."
+log "Results in: $RESULTS_DIR"
+log "Run: scripts/parse-results.sh $RESULTS_DIR"
+log "=========================================="
diff --git a/tools/testing/nfsd-io-bench/scripts/setup-server.sh b/tools/testing/nfsd-io-bench/scripts/setup-server.sh
new file mode 100755
index 000000000000..0efdd74a705e
--- /dev/null
+++ b/tools/testing/nfsd-io-bench/scripts/setup-server.sh
@@ -0,0 +1,94 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# One-time setup script for the NFS test server.
+# Run this once before running benchmarks.
+#
+# Usage: sudo ./setup-server.sh [EXPORT_PATH]
+
+set -euo pipefail
+
+EXPORT_PATH="${1:-/export}"
+FSTYPE="ext4"
+
+log() {
+	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
+}
+
+if [ "$(id -u)" -ne 0 ]; then
+	echo "ERROR: must run as root"
+	exit 1
+fi
+
+# Check for required tools
+for cmd in fio exportfs showmount jq; do
+	if ! command -v "$cmd" &>/dev/null; then
+		echo "WARNING: $cmd not found, attempting install"
+		dnf install -y "$cmd" 2>/dev/null || \
+		apt-get install -y "$cmd" 2>/dev/null || \
+		echo "ERROR: cannot install $cmd, please install manually"
+	fi
+done
+
+# Check fio has nfs ioengine
+if ! fio --enghelp=nfs &>/dev/null; then
+	echo "ERROR: fio nfs ioengine not available."
+	echo "You may need to install fio with libnfs support."
+	echo "Try: dnf install fio libnfs-devel  (or build fio from source with --enable-nfs)"
+	exit 1
+fi
+
+# Create export directory if needed
+if [ ! -d "$EXPORT_PATH" ]; then
+	log "Creating export directory: $EXPORT_PATH"
+	mkdir -p "$EXPORT_PATH"
+fi
+
+# Create subdirectories for multi-client tests
+for i in 1 2 3 4; do
+	mkdir -p "${EXPORT_PATH}/client${i}"
+	mkdir -p "${EXPORT_PATH}/reader${i}"
+done
+mkdir -p "${EXPORT_PATH}/bulk"
+
+# Check if already exported
+if ! exportfs -s 2>/dev/null | grep -q "$EXPORT_PATH"; then
+	log "Adding NFS export for $EXPORT_PATH"
+	if ! grep -q "$EXPORT_PATH" /etc/exports 2>/dev/null; then
+		echo "${EXPORT_PATH} 127.0.0.1/32(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports
+	fi
+	exportfs -ra
+fi
+
+# Ensure NFS server is running
+if ! systemctl is-active --quiet nfs-server 2>/dev/null; then
+	log "Starting NFS server"
+	systemctl start nfs-server
+fi
+
+# Verify export
+log "Current exports:"
+showmount -e localhost
+
+# Check debugfs knobs
+log "Checking debugfs knobs:"
+DEBUGFS_BASE="/sys/kernel/debug/nfsd"
+for knob in io_cache_read io_cache_write disable-splice-read; do
+	if [ -f "${DEBUGFS_BASE}/${knob}" ]; then
+		echo "  ${knob} = $(cat "${DEBUGFS_BASE}/${knob}")"
+	else
+		echo "  ${knob}: NOT FOUND (kernel may be too old)"
+	fi
+done
+
+# Print system summary
+echo ""
+log "=== System Summary ==="
+echo "Kernel:      $(uname -r)"
+echo "RAM:         $(awk '/MemTotal/ {printf "%.1f GB", $2/1024/1024}' /proc/meminfo)"
+echo "Export:      $EXPORT_PATH"
+echo "Filesystem:  $(df -T "$EXPORT_PATH" | awk 'NR==2 {print $2}')"
+echo "Disk:        $(df -h "$EXPORT_PATH" | awk 'NR==2 {print $2, "total,", $4, "free"}')"
+echo ""
+log "Setup complete. Run benchmarks with:"
+echo "  sudo ./scripts/run-benchmarks.sh -e $EXPORT_PATH"

-- 
2.53.0


