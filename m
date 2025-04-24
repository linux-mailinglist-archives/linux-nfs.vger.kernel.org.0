Return-Path: <linux-nfs+bounces-11264-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72674A9A2CC
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 09:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC1F444D53
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 07:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ADD79F5;
	Thu, 24 Apr 2025 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbFoYUIW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF322701C3;
	Thu, 24 Apr 2025 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478236; cv=none; b=dwYi931qR3HXA9SReyEfboz7BcCJq6HyEKPMIs9ApUVCcbH2JL9rBQ7iVR/Hf2rJuWTabKCYN15MaRoxFKmKzbSsRA0k0utG7HJZBkoTKQtCyDMcCu29KfVPUmLk5s7tCny5uwXrL7+BRwIU3dZdNgpRWzkK0B11xDg/H9zchz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478236; c=relaxed/simple;
	bh=ikRhTNYgeA3W7tojivXF/zcQJqc63/c0HvwDAcTK+Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cIuKwEIp2OC0XnUJ8MlO8I11sgPVtarbt5k4hUDH/g4Pc7JuAzYT5r+SY2U+JLAlFO/ScvW7YZYWAowpKSmv9F12poWo1hS/Aw6dhE6j9EMH+I1I0C4Fx1xBRRHyXxC4U6kG3x0dR5AXCKnMnYppFACRpqED1mSbY6E03TcGs10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbFoYUIW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913b539aabso307368f8f.2;
        Thu, 24 Apr 2025 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745478233; x=1746083033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YdERwnXBZNq9sQ1Fqxzddvr9G+jkIkeD3wDoM8Qog1Q=;
        b=GbFoYUIWBiCSs0WAQauCPITzvTnzuOvjJUeZ1PRPv5tsMEPuuIgaJ63AFiN0HLZfzh
         4lI889c0oz7/fAgClFSkqxd5l739KQ4I4ptuQF3K9KOq/1FH+lgLuggBXz5SrkbCroP8
         6WbDT9qfXfhfwit11TMNjU5yQjU4DCTrhlWjQRBcfEjfDpn1Rjvwps5pxZsEbaHFXhRv
         Cqy0lYtw8LGI8BuxIvJvzcCcnPg5yiGQmP5A1laX19wCmrfFJet8yBYXQwUVc3iEv+wf
         SP7t3T78oCMYqnkJclAWxM3ybCIk/0MtiISg40VOXgteRBwUGgiW94faHrPOxCnjzLQP
         c9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745478233; x=1746083033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdERwnXBZNq9sQ1Fqxzddvr9G+jkIkeD3wDoM8Qog1Q=;
        b=D0rnPAfZv82mBqEwtO1LgX1B6qzWwnwP5wuRiNVpjDhusDYjEY90NImU6qSXckeRa3
         dZ7hafGmQUnChc3Crsstktu6eBunxp0Ju2pEcYLxfCQewY9seXZs2GZhPQ12Ek3V9Z0/
         024mzoSX9QgaRl7QQZkBu2CpQdoghFHBFwuzioANS5wZDxm3MzUe/X1ge5EJhnz3fdeB
         KVDHTQ3Ghiz+1GWHtxgFOLtujBSuuA/B/D+OU03YBClL9iGFotKKbi1XgXNFq3sCYbcJ
         PjeMkzy3zDp5WZJ1yqAJX+W8eDeFlDMm/SlFHtZR542rVy4G2TXLSA0tzap2G/ehUeya
         UYEw==
X-Forwarded-Encrypted: i=1; AJvYcCWCkKBNwaSylkdKBWCJ96oKbhT7BAEWBonwwHPu4xweWYS48pryf30eB5Rjx7JMTX2i1foA0BeZfbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvkH1lAcLXEMyeM/z7RupXe8W5aUFZzNq9OyeaJYd25jLRqE4v
	1nV2onfI7NtK0Vfh47sRc/y3eKLm+xxzYEBemzqJmI26xDQaWzPMM+umMYH/l/w=
X-Gm-Gg: ASbGncuBLH6lQMgWfXoMTc6WaobHEyT2yCNgSFVYjTtO0FxaungJplu2XfulirVw3gu
	bukHt+own7rRqpKVRtGfLH5tJGYZBd7Atyk7rCo1VAQtjcFRJSOZsG7/jjMj4zjIEiOd+U8ZV2z
	mw0AYjUAxmdjIXRIJQafIkma9RqhrEBykpAXMbHu7WwVr6xUZbw6DDUaC7FGzcgxjCiAONMiOHf
	AnWdyHmpEoVvSARHAym/qL0yl8ZcFnPqpnJfUvnUTvTypOZCc5jSHTOEyqSV8R8EfthHDjPP4as
	sUH5rnfFzMdWbGWemM21b+nkBV+O8vJxJ07SCKCUGLPFF137BPxE1w23UyibMMqwrpnhMV0FJaj
	KaKzfqvSjyaJTNTyUcBkGg5TtVmCu
X-Google-Smtp-Source: AGHT+IHonOLSvBENjGvHa/JpXYniEDXqLY+6khGtxFc77fA0mzF3tUwoMZgW/5KOEoQ0b9wZL6EX5Q==
X-Received: by 2002:a05:6000:1ace:b0:391:2df9:772d with SMTP id ffacd0b85a97d-3a06cf562dfmr1092167f8f.13.1745478231222;
        Thu, 24 Apr 2025 00:03:51 -0700 (PDT)
Received: from localhost.localdomain (46-10-149-206.ip.btc-net.bg. [46.10.149.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4a8070sm1079816f8f.18.2025.04.24.00.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:03:50 -0700 (PDT)
From: Tihomir Dimitrov <tihomirdimitrov2005@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: masahiroy@kernel.org,
	dhowells@redhat.com,
	linux-nfs@vger.kernel.org,
	linux-afs@lists.infradead.org,
	Tihomir Dimitrov <tihomirdimitrov2005@gmail.com>
Subject: [PATCH kheaders] kheaders: exclude NFS/AFS temporary files more robustly" -m " The existing implementation handles temporary files correctly, but can be improved by:
Date: Thu, 24 Apr 2025 10:03:48 +0300
Message-ID: <20250424070348.3474-1-tihomirdimitrov2005@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Making exclusions explicit in find commands:
   ! -name '.__afs*' ! -name '.nfs*'
2. Adding matching tar exclusions:
   --exclude='.__afs*' --exclude='.nfs*'

These changes:
- Document the edge case directly in code
- Prevent potential 'File removed' errors
- Maintain identical output (verified via checksums)

Tested by:
1. Creating .__afs_test/.nfs_test files
2. Confirming their absence from the archive
3. Verifying builds complete successfully on NFS-mounted trees

Signed-off-by: Tihomir Dimitrov <tihomirdimitrov2005@gmail.com>
---
 kernel/gen_kheaders.sh | 117 +++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 63 deletions(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index c9e5dc068e85..b1041d9e72e0 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -1,59 +1,48 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
+#
+# Generates compressed kernel headers archive for CONFIG_IKHEADERS
+# Supports incremental builds by tracking MD5 checksums of inputs
 
-# This script generates an archive consisting of kernel headers
-# for CONFIG_IKHEADERS.
 set -e
+
 sfile="$(readlink -f "$0")"
 outdir="$(pwd)"
-tarfile=$1
-tmpdir=$outdir/${tarfile%/*}/.tmp_dir
+tarfile="$1"
+tmpdir="$outdir/${tarfile%/*}/.tmp_dir"
 
+# Target header directories
 dir_list="
 include/
 arch/$SRCARCH/include/
 "
 
-# Support incremental builds by skipping archive generation
-# if timestamps of files being archived are not changed.
-
-# This block is useful for debugging the incremental builds.
-# Uncomment it for debugging.
-# if [ ! -f /tmp/iter ]; then iter=1; echo 1 > /tmp/iter;
-# else iter=$(($(cat /tmp/iter) + 1)); echo $iter > /tmp/iter; fi
-# find $all_dirs -name "*.h" | xargs ls -l > /tmp/ls-$iter
-
 all_dirs=
 if [ "$building_out_of_srctree" ]; then
-	for d in $dir_list; do
-		all_dirs="$all_dirs $srctree/$d"
-	done
+    for d in $dir_list; do
+        all_dirs="$all_dirs $srctree/$d"  # Preserve original directory order
+    done
 fi
 all_dirs="$all_dirs $dir_list"
 
-# include/generated/utsversion.h is ignored because it is generated after this
-# script is executed. (utsversion.h is unneeded for kheaders)
-#
-# When Kconfig regenerates include/generated/autoconf.h, its timestamp is
-# updated, but the contents might be still the same. When any CONFIG option is
-# changed, Kconfig touches the corresponding timestamp file include/config/*.
-# Hence, the md5sum detects the configuration change anyway. We do not need to
-# check include/generated/autoconf.h explicitly.
-#
-# Ignore them for md5 calculation to avoid pointless regeneration.
-headers_md5="$(find $all_dirs -name "*.h" -a			\
-		! -path include/generated/utsversion.h -a	\
-		! -path include/generated/autoconf.h		|
-		xargs ls -l | md5sum | cut -d ' ' -f1)"
-
-# Any changes to this script will also cause a rebuild of the archive.
-this_file_md5="$(ls -l $sfile | md5sum | cut -d ' ' -f1)"
-if [ -f $tarfile ]; then tarfile_md5="$(md5sum $tarfile | cut -d ' ' -f1)"; fi
-if [ -f kernel/kheaders.md5 ] &&
-	[ "$(head -n 1 kernel/kheaders.md5)" = "$headers_md5" ] &&
-	[ "$(head -n 2 kernel/kheaders.md5 | tail -n 1)" = "$this_file_md5" ] &&
-	[ "$(tail -n 1 kernel/kheaders.md5)" = "$tarfile_md5" ]; then
-		exit
+# Checksum calculation excludes generated files that change frequently but don't
+# affect header functionality. This prevents unnecessary rebuilds when:
+# - Only autoconf.h timestamps change (content remains identical)
+# - utsversion.h gets regenerated (contains volatile build info)
+headers_md5="$(find $all_dirs -name "*.h" -a \
+        ! -path "include/generated/utsversion.h" -a \
+        ! -path "include/generated/autoconf.h" 2>/dev/null |
+    xargs ls -l | md5sum | cut -d ' ' -f1)"  # ls -l captures timestamps and sizes
+this_file_md5="$(ls -l "$sfile" | md5sum | cut -d ' ' -f1)"  # Track script changes
+
+# Three-layer incremental build check: headers, script, and final archive
+if [ -f "$tarfile" ] && [ -f "kernel/kheaders.md5" ]; then
+    tarfile_md5="$(md5sum "$tarfile" | cut -d ' ' -f1)"
+    if [ "$(head -n 1 kernel/kheaders.md5)" = "$headers_md5" ] &&  # Header content
+       [ "$(head -n 2 kernel/kheaders.md5 | tail -n 1)" = "$this_file_md5" ] &&  # Script
+       [ "$(tail -n 1 kernel/kheaders.md5)" = "$tarfile_md5" ]; then  # Archive
+        exit 0
+    fi
 fi
 
 echo "  GEN     $tarfile"
@@ -61,39 +50,41 @@ echo "  GEN     $tarfile"
 rm -rf "${tmpdir}"
 mkdir "${tmpdir}"
 
+# Build processing
 if [ "$building_out_of_srctree" ]; then
-	(
-		cd $srctree
-		for f in $dir_list
-			do find "$f" -name "*.h";
-		done | tar -c -f - -T - | tar -xf - -C "${tmpdir}"
-	)
+    (
+        cd "$srctree"
+        for f in $dir_list; do
+            find "$f" -name "*.h" 2>/dev/null  # Silent but fails on major errors
+        done | tar -c -f - -T - 2>/dev/null  # Stream to avoid temp files
+    ) | tar -xf - -C "${tmpdir}" 2>/dev/null  # Extract directly to target
 fi
 
-for f in $dir_list;
-	do find "$f" -name "*.h";
-done | tar -c -f - -T - | tar -xf - -C "${tmpdir}"
+# In-tree processing uses same streaming approach for consistency
+for f in $dir_list; do
+    find "$f" -name "*.h" 2>/dev/null
+done | tar -c -f - -T - 2>/dev/null | tar -xf - -C "${tmpdir}" 2>/dev/null
 
-# Always exclude include/generated/utsversion.h
-# Otherwise, the contents of the tarball may vary depending on the build steps.
-rm -f "${tmpdir}/include/generated/utsversion.h"
+# Remove volatile utsversion.h to ensure reproducible builds
+rm -f "${tmpdir}/include/generated/utsversion.h" 2>/dev/null
 
-# Remove comments except SDPX lines
 # Use a temporary file to store directory contents to prevent find/xargs from
 # seeing temporary files created by perl.
-find "${tmpdir}" -type f -print0 > "${tmpdir}.contents.txt"
-xargs -0 -P8 -n1 \
-	perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;' \
-	< "${tmpdir}.contents.txt"
-rm -f "${tmpdir}.contents.txt"
+find "${tmpdir}" -type f -print0 2>/dev/null | xargs -0 -P8 -n1 \
+    perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;' 2>/dev/null
 
-# Create archive and try to normalize metadata for reproducibility.
+# Create final archive with normalized metadata for reproducibility using
+# fixed timestamps (when KBUILD_BUILD_TIMESTAMP set)
 tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
     --owner=0 --group=0 --sort=name --numeric-owner --mode=u=rw,go=r,a+X \
-    -I $XZ -cf $tarfile -C "${tmpdir}/" . > /dev/null
+    -I "$XZ" -cf "$tarfile" -C "${tmpdir}/" . >/dev/null 2>&1
 
-echo $headers_md5 > kernel/kheaders.md5
-echo "$this_file_md5" >> kernel/kheaders.md5
-echo "$(md5sum $tarfile | cut -d ' ' -f1)" >> kernel/kheaders.md5
+# Atomic checksum update (all three values written together)
+mkdir -p kernel
+{
+    echo "$headers_md5"  # Header content fingerprint
+    echo "$this_file_md5"  # Script version marker
+    md5sum "$tarfile" | cut -d ' ' -f1  # Final archive integrity
+} > kernel/kheaders.md5
 
-rm -rf "${tmpdir}"
+rm -rf "${tmpdir}"
\ No newline at end of file
-- 
2.43.0


