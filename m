Return-Path: <linux-nfs+bounces-11283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E468EA9C93A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 14:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9103AF5C7
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EAA1F4626;
	Fri, 25 Apr 2025 12:49:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D85912CD8B
	for <linux-nfs@vger.kernel.org>; Fri, 25 Apr 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585366; cv=none; b=ClBo3AICxlHsi0ksVUrQXj08PCfrIupl8P/fMRGU+7EcolrtT8/WxWp4mdA70szgAtvmNDDb0b5xUbFZPaJfdeaVew6H4vdwk3mGZD/JSQZXWV1EdR+ksIQnir+mgvXG2PPRvqizc+eNXvTpU0XJ6xyaQ5RJx5ltgMsqfRY9hl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585366; c=relaxed/simple;
	bh=ijHjcFHGsByhSStv7cyz57wcNEahtqmcHquH+jyQ08w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=penaTr5VO/b+Oh+k0N7KO2NchmXdVcQ1RZHNgaFLGLlmttYCn672Pyq7+s6VtKclkJeFMQQ3eaqC0Xos2W177VVH5eZVDnXurZDbxQu/l3ly2BDO8zLInrP98/JgeqSFFKNZ2yznYYl3CbaMtUjDo2Hi+eO7Zv0EPvj0tkD+bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so19381755e9.3
        for <linux-nfs@vger.kernel.org>; Fri, 25 Apr 2025 05:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585362; x=1746190162;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa+0OMtdcwPp012VI9oZOHod2d6JvyzGy9s0gFBpF1Y=;
        b=wzGjTSOLtoyWFmXIdzARXbfi46aE2kFBKqeyVFZqxy0DomzPukDsYSHKv83Adm8rPd
         yZYygrjyAa1f5jZamY58zlpx02bXGezvjeMkv80pQ3dlLZIigLwcM4L1CXo/BJ/mF2pj
         IBUjNwx+8cvBYjVao1ZWpOR8gA2riKT1GDMGND8urYWlIt/BWoYPRgPB+RKME8OOPbDi
         inr2S2yZy85vA+2mxRw9bklIbdN7klZR07+JbMn65TjM3c9X3gtxIz/Ika1nsZG7BeiT
         WPctsDUDKOTblmZlBNPcqV8nHSPD+ItWTXofMWVdEgBuUsTHrTUPMnZu4CWoV0XaJ0j/
         KWBQ==
X-Gm-Message-State: AOJu0YxUx2w+zD9O7Ut7UjeP3hEH8eJwNnAGwf97I75EyaUY1cbDWcwB
	9tsuGtrsIGJjWfsEL0EeJRgK7cKWOpNqRCk9FOXJTKfCBo9DS6XuVbwp4Q==
X-Gm-Gg: ASbGnctASITTRcQuDgBy92RHKRzW6sWUzTeV8AO0qzHWinsu1Ji738LwfwB1cjjg3w9
	EsUjaSna3xnQCoxHEY5UqBpizd4f0hYiZB4pS7qtFi+wOi6ghTEmxINWIADcWOCJdokKy+RKHHQ
	xhf7GDFcr85ldUP5GNPAtyJP0w2PutgK4H04sVO7Dsu8Dp17vAPn3ZgX5GIEMsg/lp3/nbkSvqb
	mfSMjS8RGBlLINUEeZBiCzdkS9y0BQz011/QF7zBxRAGwcklMhoCg7ZWQ+nGlQ24KPb9HzqoXiE
	gXLcGolAseiz9IPSsI+GXRgzOvaRpzzUQF5KTJ6VoCG+j5F/44Ndow==
X-Google-Smtp-Source: AGHT+IE5TK7bwAFfQnRDVZ4TmY++BYnKqajGIlMGlSTJvRzuCl1vPX/78XKs7NFj4BjJDX1sBK0Q5A==
X-Received: by 2002:a05:600c:190b:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-440a65ba213mr18981785e9.5.1745585361991;
        Fri, 25 Apr 2025 05:49:21 -0700 (PDT)
Received: from vastdata-ubuntu2.vstd.int ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5369cdasm24424935e9.31.2025.04.25.05.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:49:21 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <Anna.Schumaker@netapp.com>
Subject: [PATCH] NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET when timestamps are delegated
Date: Fri, 25 Apr 2025 15:49:19 +0300
Message-ID: <20250425124919.1727838-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfs_setattr will flush all pending writes before updating a file time
attributes. However when the client holds delegated timestamps, it can
update its timestamps locally as it is the authority for the file
times attributes. The client will later set the file attributes by
adding a setattr to the delegreturn compound updating the server time
attributes.

Fix nfs_setattr to avoid flushing pending writes when the file time
attributes are delegated and the mtime/atime are set to a fixed
timestamp (ATTR_[MODIFY|ACCESS]_SET. Also, when sending the setattr
procedure over the wire, we need to clear the correct attribute bits
from the bitmask.

I was able to measure a noticable speedup when measuring untar performance.
Test: $ time tar xzf ~/dir.tgz
Baseline: 1m13.072s
Patched: 0m49.038s

Which is more than 30% latency improvement.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Tested this on a vm in my laptop against chuck nfsd-testing which
grants write delegs for write-only opens, plus another small modparam
that also adds a space_limit to the delegation.

 fs/nfs/inode.c    | 49 +++++++++++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs4proc.c |  8 ++++----
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 119e447758b9..6472b95bfd88 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -633,6 +633,34 @@ nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
 	}
 }
 
+static void nfs_set_timestamps_to_ts(struct inode *inode, struct iattr *attr)
+{
+	unsigned int cache_flags = 0;
+
+	if (attr->ia_valid & ATTR_MTIME_SET) {
+		struct timespec64 ctime = inode_get_ctime(inode);
+		struct timespec64 mtime = inode_get_mtime(inode);
+		struct timespec64 now;
+		int updated = 0;
+
+		now = inode_set_ctime_current(inode);
+		if (!timespec64_equal(&now, &ctime))
+			updated |= S_CTIME;
+
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
+		if (!timespec64_equal(&now, &mtime))
+			updated |= S_MTIME;
+
+		inode_maybe_inc_iversion(inode, updated);
+		cache_flags |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
+	}
+	if (attr->ia_valid & ATTR_ATIME_SET) {
+		inode_set_atime_to_ts(inode, attr->ia_atime);
+		cache_flags |= NFS_INO_INVALID_ATIME;
+	}
+	NFS_I(inode)->cache_validity &= ~cache_flags;
+}
+
 static void nfs_update_timestamps(struct inode *inode, unsigned int ia_valid)
 {
 	enum file_time_flags time_flags = 0;
@@ -701,14 +729,27 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
 		spin_lock(&inode->i_lock);
-		nfs_update_timestamps(inode, attr->ia_valid);
+		if (attr->ia_valid & ATTR_MTIME_SET) {
+			nfs_set_timestamps_to_ts(inode, attr);
+			attr->ia_valid &= ~(ATTR_MTIME|ATTR_MTIME_SET|
+						ATTR_ATIME|ATTR_ATIME_SET);
+		} else {
+			nfs_update_timestamps(inode, attr->ia_valid);
+			attr->ia_valid &= ~(ATTR_MTIME|ATTR_ATIME);
+		}
 		spin_unlock(&inode->i_lock);
-		attr->ia_valid &= ~(ATTR_MTIME | ATTR_ATIME);
 	} else if (nfs_have_delegated_atime(inode) &&
 		   attr->ia_valid & ATTR_ATIME &&
 		   !(attr->ia_valid & ATTR_MTIME)) {
-		nfs_update_delegated_atime(inode);
-		attr->ia_valid &= ~ATTR_ATIME;
+		if (attr->ia_valid & ATTR_ATIME_SET) {
+			spin_lock(&inode->i_lock);
+			nfs_set_timestamps_to_ts(inode, attr);
+			spin_unlock(&inode->i_lock);
+			attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
+		} else {
+			nfs_update_delegated_atime(inode);
+			attr->ia_valid &= ~ATTR_ATIME;
+		}
 	}
 
 	/* Optimization: if the end result is no change, don't RPC */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970f28dbf253..c501a0d5da90 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -325,14 +325,14 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 
 	if (nfs_have_delegated_mtime(inode)) {
 		if (!(cache_validity & NFS_INO_INVALID_ATIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
+			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
 		if (!(cache_validity & NFS_INO_INVALID_MTIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_MODIFY;
+			dst[1] &= ~(FATTR4_WORD1_TIME_MODIFY|FATTR4_WORD1_TIME_MODIFY_SET);
 		if (!(cache_validity & NFS_INO_INVALID_CTIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_METADATA;
+			dst[1] &= ~(FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY_SET);
 	} else if (nfs_have_delegated_atime(inode)) {
 		if (!(cache_validity & NFS_INO_INVALID_ATIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
+			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
 	}
 }
 
-- 
2.43.0


