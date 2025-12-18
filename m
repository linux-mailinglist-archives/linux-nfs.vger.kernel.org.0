Return-Path: <linux-nfs+bounces-17147-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F895CCA5CB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 06:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FCDA30245C9
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 05:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78C30ACF2;
	Thu, 18 Dec 2025 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t0VNFQOa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836693112B7
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037085; cv=none; b=dIwCz28pQJoYR3a6svulsHcY5MWi7gHQqAkE531b2aD2i+x2Ra9f/5kIjWLZboa79AI3CDruIHGi3/6lu+3LxWV4Drv1EgANdUvDa4sU9V81t66GWmU3v1ei2+OHxLhDKDMF6B6DNhP/pNSapKe7WPnLDJ5XsM/MI0AMfeejXBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037085; c=relaxed/simple;
	bh=57Q0zAiuzozNXDTcj6+40KzI+o5Pdh8TUQJ6biHnS8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSG3vNOhkgp4OAkMfx0d8LL1CAdhtQXt1ICTe4i71SynsJLNPy2jlT/yXo5kP7h1MpgCXR29cIzunDtCctwMwGg0dBAorfa6NgxVyJeNh55u14LPHo99bbRgEl6TjVK5fw9A3r7aTrBEJSEjCzxzIjPLRmLLJGhNoFnJY0M6IcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t0VNFQOa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dXgViH3CjUKKhWtmueXlRdXj01zWIVWuZjXXPmHiuzA=; b=t0VNFQOa+kdY7FlhWrP9K0bcSb
	GaG03fpg+2AjNKtcRlhDBkDAvU06mXT72EbIv8bJiOGG+Il1PWi5z7cciZaGuxJwTFX7UxIjj0wzc
	eJoDGWF45tnf0n9FDXShzxxKQ6o4HeXqqQzoPZJjXto3z08yHfS+WA4bWDThv1f7KtDJNjW2QIj6q
	TPbmohG8T8nSpH1+NBzoDBpRupDG8UInekNJbVXwtTCrH7TzDvsSFzNW+c8epOTJUxcBbfbWqONDM
	s+IcQVcJiqDF0kHAenfMtz0zA1kSGgvNDkB56LCXwH3IBzDg8kxpsZMACaay5ZKa/rCLlb3XmRzbP
	NwJ/ewcg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6v4-00000007rF9-1cgg;
	Thu, 18 Dec 2025 05:51:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: add a LRU for delegations
Date: Thu, 18 Dec 2025 06:50:07 +0100
Message-ID: <20251218055116.1530970-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

currently the NFS client is rather inefficient at managing delegations
not associated with an open file.  If the number of delegations is above
the watermark, the delegation for a free file is immediately returned,
even if delegations that were unused for much longer would be available.
Also the periodic freeing marks delegations as not referenced for return,
even if the file was open and thus force the return on close.

This series reworks the code to introduce an LRU and return the least
used delegations instead.

For a workload simulating repeated runs of a python program importing a
lot of modules, this leads to a 97% reduction of on-the-wire operations,
and ~40% speedup even for a fast local NFS server.  A reproducer script
is attached.

You'll want to make sure the dentry caching fix posted by Anna in reply
to the 6.19 NFS pull is included for testing, even if the patches apply
without it.


Diffstat:
 fs/nfs/callback_proc.c    |   13 -
 fs/nfs/client.c           |    3 
 fs/nfs/delegation.c       |  546 +++++++++++++++++++++++-----------------------
 fs/nfs/delegation.h       |    4 
 fs/nfs/nfs4proc.c         |   82 +++---
 fs/nfs/nfs4trace.h        |    2 
 fs/nfs/super.c            |   14 -
 include/linux/nfs_fs_sb.h |    8 
 8 files changed, 344 insertions(+), 328 deletions(-)

Reproducer:
#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <NFS_MOUNT_PATH>"
    exit 1
fi

NFS_MOUNT="$1"
WARMUP_FILE_COUNT="8000"
RUNS=200
MODULE_COUNT=200
SAVEFILE="/tmp/nfsstat.bak"

echo "=== NFS delegation benchmark ==="
echo "NFS mount:          $NFS_MOUNT"
echo "Warmup file count:  $WARMUP_FILE_COUNT"
echo "Number of runs:     $RUNS"
echo "Module count:       $MODULE_COUNT"
echo


################################################################################
# Step 1: Create temporary directory on NFS
################################################################################
TEST_DIR=$(mktemp -d "$NFS_MOUNT/test_deleg_bench.XXXXXX")
MODULE_DIR="$TEST_DIR/pymods"
mkdir -p "$MODULE_DIR/delegtest"
MODDIR_INIT="$MODULE_DIR/delegtest/__init__.py"

cat > "$MODDIR_INIT" <<EOF
import os
import glob

file_paths = glob.glob(os.path.join(os.path.dirname(__file__), "*.py"))

__all__ = [
    os.path.basename(f)[:-3] 
    for f in file_paths 
    if os.path.isfile(f) and not f.endswith("__init__.py")
]
EOF

echo "[1] Creating $WARMUP_FILE_COUNT tiny files to accumulate delegations..."
mkdir -p "$TEST_DIR/fill"
for i in $(seq 1 "$WARMUP_FILE_COUNT"); do
    echo "f$i" > "$TEST_DIR/fill/file_$i"
done

echo "[1] Warmup delegation files created."

################################################################################
# Step 2: Create many tiny Python modules to exercise import workload
################################################################################
echo "[2] Creating $MODULE_COUNT dummy python modules..."
for i in $(seq 1 "$MODULE_COUNT"); do
    echo "x = $i" > "$MODULE_DIR/delegtest/mod$i.py"
done
#umount -o remount $NFS_MOUNT

# Python snippet:
# repeatedly import all modN modules; measure iterations completed
BENCH_SCRIPT="$TEST_DIR/bench.py"

cat > "$BENCH_SCRIPT" <<EOF
import sys

sys.path.insert(0, "$MODULE_DIR")

from delegtest import *
EOF

################################################################################
# Step 3: Pre-benchmark NFS client counters
################################################################################
echo "[3] Capturing baseline NFS client stats..."
sync $NFS_MOUNT
#mount -o remount $NFS_MOUNT
cp /proc/net/rpc/nfs $SAVEFILE

################################################################################
# Step 4: Run Python benchmark
################################################################################
echo "[4] Running Python import benchmark..."

time {
for i in $(seq 1 "$RUNS"); do
    python3 "$BENCH_SCRIPT"
done
}

################################################################################
# Step 5: Produce NFS client delta report
################################################################################
echo
echo "=== NFS client DELTA REPORT ==="
echo

nfsstat -c -S $SAVEFILE  -l
rm -f $SAVEFILE

echo
echo "Test directory:       $TEST_DIR"
echo
echo "=== Done ==="

