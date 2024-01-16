Return-Path: <linux-nfs+bounces-1135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CABE82F335
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 18:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFA41F23D15
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAF31CAA9;
	Tue, 16 Jan 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxW6C+pT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836E1CA8C;
	Tue, 16 Jan 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426289; cv=none; b=fDypwbvobGJgRN/7IokQAdTVQvwgtkDIZhuN2MjQSnO6PgxNnjvLj2/U6eB6vrkBiS8uXSN8roloyP2vF7sO8+D++fe28RwRjP3qdbTa8Wmj2ieeQZOdn3hLd4i4761Him92sc1pEQXmm375lvRga/zEKgKGC13oZ1jQRVj4nJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426289; c=relaxed/simple;
	bh=U/6k863bSOdTRHr/YigdbpLvuc4GxzvU4FIVevvOFug=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=L+VzXoVCr4GA0Qvw82/xlYRLDm23cE0sOjONZch/CaS28NXjdAAG0SILbQjf1wBTUq7unRFkwMmjHTkb44ci13a3+Bcg1vW+w2n1nY1JS67Vb5QD4OztXuDyg56NPoILUvMdS8veoix3lO5uvcxufV8mS7bQvJi2NbUZiXT3vC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxW6C+pT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFE4C433F1;
	Tue, 16 Jan 2024 17:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705426289;
	bh=U/6k863bSOdTRHr/YigdbpLvuc4GxzvU4FIVevvOFug=;
	h=From:To:Cc:Subject:Date:From;
	b=XxW6C+pT1WK6ZelHTJEgqS50xo2/gLkTjaEs6Q+FmPbs0A+qPH2ixlemnf6VlNPXc
	 pbEj7qjxDm7D7bsq9VXzatw+2gZluo1zzH2FsgoddfZmbVAiCv2nvHM3ijt/bfPKvX
	 xVuOHFH1+NZU7JwX/9B3VwakcM+n3A+pRaTm31DIVtck8FLuu8lKcC9X6IyFqTBb6J
	 VLmEqfddBT+i/WM4jKX+KMeG7Mu/sb4A4MLcvyplhMZ7zixTLB1HD327pardfnrekD
	 vIHoJ7B59kjk5a/SIhOWzF2S4uDe7nBNzizFSY71eN5N/ShbXBJFJn5OgAYMW8yfX1
	 0/Nj3Fnegyw+A==
From: Jeff Layton <jlayton@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH fstests] common/rc: NFSv2/3 do not support negative timestamps
Date: Tue, 16 Jan 2024 12:31:27 -0500
Message-ID: <20240116173127.238994-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NFSv2 and v3 protocols use unsigned values for timestamps. Fix
_require_negative_timestamps() to check the NFS version and _notrun if
it's 2 or 3.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/rc | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a9e0ba7e22f1..d4ac0744fab0 100644
--- a/common/rc
+++ b/common/rc
@@ -2902,6 +2902,27 @@ _require_debugfs()
     [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
 }
 
+#
+# Return the version of NFS in use on the mount on $1. Returns 0
+# if it's not NFS.
+#
+_nfs_version()
+{
+	local mountpoint=$1
+	local nfsvers=""
+
+	case "$FSTYP" in
+	nfs*)
+		nfsvers=`_mount | grep $1 | sed -n 's/^.*vers=\([0-9.]*\).*$/\1/p'`
+		;;
+	*)
+		nfsvers="0"
+		;;
+	esac
+
+	echo "$nfsvers"
+}
+
 # The default behavior of SEEK_HOLE is to always return EOF.
 # Filesystems that implement non-default behavior return the offset
 # of holes with SEEK_HOLE. There is no way to query the filesystem
@@ -2925,7 +2946,7 @@ _fstyp_has_non_default_seek_data_hole()
 	nfs*)
 		# NFSv2, NFSv3, and NFSv4.0/4.1 only support default behavior of SEEK_HOLE,
 		# while NFSv4.2 supports non-default behavior
-		local nfsvers=`_mount() | grep $TEST_DEV | sed -n 's/^.*vers=\([0-9.]*\).*$/\1/p'`
+		local nfsvers=$( _nfs_version "$TEST_DIR" )
 		[ "$nfsvers" = "4.2" ]
 		return $?
 		;;
@@ -5129,6 +5150,16 @@ _require_negative_timestamps() {
 	ceph|exfat)
 		_notrun "$FSTYP does not support negative timestamps"
 		;;
+	nfs*)
+		#
+		# NFSv2/3 timestamps use 32-bit unsigned values, and so
+		# cannot represent values prior to the epoch
+		#
+		local nfsvers=$( _nfs_version "$TEST_DIR" )
+		if [ "$nfsvers" = "2" -o "$nfsvers" = "3" ]; then
+			_notrun "$FSTYP version $nfsvers does not support negative timestamps"
+		fi
+		;;
 	esac
 }
 
-- 
2.43.0


