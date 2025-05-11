Return-Path: <linux-nfs+bounces-11661-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC7EAB2BB6
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 23:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2E018972C0
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 21:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DEA57C93;
	Sun, 11 May 2025 21:54:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB38535D8
	for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747000483; cv=none; b=BT/D13RO5fHI681I4Af0lMn4j1v+uJDgRh4g3ejBcxroj1263l2imdqs+X2mwBxJLJuMH0vWVdAPeJtyxTI6sJrEssE3acgWWd9TfuYYp8vn4Dcevf/jw/N/NxuC3OumIDiGLYKDSZ1mLHWbMlY+M8NLp+ECK0CQpusULxq+pMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747000483; c=relaxed/simple;
	bh=6PEB3MaHXfZvi0zCNrW97maGshR7FSIDFvU2NhFqanA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+DgKLNbBbbKssEeH+vuP3SExeQDKMI/EmYcSi7n6sgvGbKmUXpN/MPEhn7moj6dkmDs6zmiE+pZMK65QjuNpHJf8kgPmkdpxiLHKwdPf52ygm0uUOVNXYi5U0kOrF0YCA5k+sHen5eIEtTCKMEHy253emqnnSQucbVUnn6JkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5faaddb09feso7623174a12.2
        for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 14:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747000479; x=1747605279;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTTFeritYFcDE57c5uoA/BKnLkHrIhWgvNc4HqwynZw=;
        b=YUGuV2uFLf5i4enZwTO/qq2WkEO+QjO7EqAPy8o0TuxBdtUQsF13MnvJ5FzKMqfzuJ
         YFHz8NsL0c7jhPFfLVbQA8jiHjVhFShbcBNBtZngzsD0O+w47699ulxsV18wJSt1QQO4
         dnQPhbV1KiTxYbrqGIlq+Y2ZDitpBJ7SKHUpB/JlX3QYCb4T9Ipn9Jz+aO9cM7OvHg6F
         OxXf2Z10t557/hP2D2o9+7llCiuYQ548z6Q98i0Gn/3S5Is1y46N6yvMtaEFfzZmcAJ7
         3XR5QsyXBKfUndIKuwoV+lmv91qG8CZi+OP8ZAFsUCjYsFmWsWPQ5lO7+cnCe7WNWSL6
         Ywjw==
X-Gm-Message-State: AOJu0YxL6VJzRDzBLdyyfNCqa7OOiCMtORimpXWS6jCIPtdVkX4xRvZg
	j9WW7GPTHV+otxopdaFLWwGS05/XthNgP15LC8yk3QlVTCOgEZiIcA7TPA==
X-Gm-Gg: ASbGncvOEnyYwp9X+EkIVvhXSFyWL8kQbqBiZwlCIl1VXFwJLfyc94TmP/OJd6/kgDS
	Uvnl4bH7n1DXvbgSxbUUtjtKtPZTTOIX3SseDTsw+Dy+RIypO+gAIUHfkSdfRFO2bq6iTwSwsGa
	O88CqfW0SXJ72OU3dEx0K4Yu8LLIrXdPo2mLAIPIn3rjmoFtxmywDzaAWvwh3l2+VcsRJ2awRTN
	gYrBHZ8tq48Oer/TKI9139+mD1RdkkpWm2unVLSsuSp/PP4izYsT8MjqPrsIBbYSmuemH4Nuf1B
	5OR2WGkhyRI9+PKSbYX76wwGdJJS3lzP7q6/Z5+HI0eckymvIrs5vdJ4O4NKWtzDxF4Jamowfvk
	yo0q2PIbcvzyDIpFiklFBxcJbFa8OAC4wuv88zg==
X-Google-Smtp-Source: AGHT+IGVCJQVMK7mHdS7Plqp1d60awzUfs2LRo3+hpH/CKD9WNIOGq/Hq+M9+Z4gd14BZGL3pvbdyA==
X-Received: by 2002:a17:907:9704:b0:ad2:35db:a732 with SMTP id a640c23a62f3a-ad235dbb8aamr589367366b.22.1747000478415;
        Sun, 11 May 2025 14:54:38 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad22fccc23esm363426666b.4.2025.05.11.14.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 14:54:38 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH v2] NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET when timestamps are delegated
Date: Mon, 12 May 2025 00:54:36 +0300
Message-ID: <20250511215436.457429-1-sagi@grimberg.me>
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
Baseline: 0m44.407s
Patched: 0m29.712s

Which is more than 30% latency improvement.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- Moved attr->ia_valid assignments as well as inode->lock handling to
  nfs_set_timestamps_to_ts helper

 fs/nfs/inode.c    | 54 +++++++++++++++++++++++++++++++++++++++++------
 fs/nfs/nfs4proc.c |  8 +++----
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 119e447758b9..295e2776053c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -633,6 +633,40 @@ nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
 	}
 }
 
+static void nfs_set_timestamps_to_ts(struct inode *inode, struct iattr *attr)
+{
+	unsigned int cache_flags = 0;
+
+	spin_lock(&inode->i_lock);
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
+		attr->ia_valid &= ~(ATTR_MTIME|ATTR_MTIME_SET|
+					ATTR_ATIME|ATTR_ATIME_SET);
+
+	}
+	if (attr->ia_valid & ATTR_ATIME_SET) {
+		inode_set_atime_to_ts(inode, attr->ia_atime);
+		cache_flags |= NFS_INO_INVALID_ATIME;
+		attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
+	}
+	NFS_I(inode)->cache_validity &= ~cache_flags;
+	spin_unlock(&inode->i_lock);
+}
+
 static void nfs_update_timestamps(struct inode *inode, unsigned int ia_valid)
 {
 	enum file_time_flags time_flags = 0;
@@ -700,15 +734,23 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
-		spin_lock(&inode->i_lock);
-		nfs_update_timestamps(inode, attr->ia_valid);
-		spin_unlock(&inode->i_lock);
-		attr->ia_valid &= ~(ATTR_MTIME | ATTR_ATIME);
+		if (attr->ia_valid & ATTR_MTIME_SET) {
+			nfs_set_timestamps_to_ts(inode, attr);
+		} else {
+			spin_lock(&inode->i_lock);
+			nfs_update_timestamps(inode, attr->ia_valid);
+			spin_unlock(&inode->i_lock);
+			attr->ia_valid &= ~(ATTR_MTIME|ATTR_ATIME);
+		}
 	} else if (nfs_have_delegated_atime(inode) &&
 		   attr->ia_valid & ATTR_ATIME &&
 		   !(attr->ia_valid & ATTR_MTIME)) {
-		nfs_update_delegated_atime(inode);
-		attr->ia_valid &= ~ATTR_ATIME;
+		if (attr->ia_valid & ATTR_ATIME_SET) {
+			nfs_set_timestamps_to_ts(inode, attr);
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


