Return-Path: <linux-nfs+bounces-16456-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C0AC6502E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 17:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E47EA28FC0
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E0299ABF;
	Mon, 17 Nov 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7x/rVoi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127F2874E3
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395256; cv=none; b=MA2vMBTf+8mAbs1hIfI8LK/AjhgvdOR0/QUv/6s3AxsAFrrRR1HpT+8V+N1LaXrTULvs8FdVl5ZlwJDjJBZakKCNEyXzBKxWzmKyW+VasLUV6HMyRsuFksAJqg55Hntf0uUGtwTyGyWF+sulZcAmr+WjCVyUVXlo2E3KsbOr6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395256; c=relaxed/simple;
	bh=1Lu3gCox5TSf/ueq33OM0uP8ZA8I8ch9SynnlfUDpeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjodJIPVzgJLriugUABgpTk2CiwdLpCNYZyPCk4zcv5AZHpqQW33FxGvvjhw0tdwcz88NrraPpby+N1H2TpCE+1lHmoMZHKygjzfpILvh84pESh+knaJNAEnPRoAQXPR5rFOONAbhwOluPY/B4LPy4rVtfVIxp6KW+E90FfTbqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7x/rVoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69B7C2BCB4;
	Mon, 17 Nov 2025 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763395255;
	bh=1Lu3gCox5TSf/ueq33OM0uP8ZA8I8ch9SynnlfUDpeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7x/rVoikpow5LSQmYNtGCf28LoYrAEeMRvVC3ECKVa9S5ZnWPEwk82/fuXsC++6K
	 tCmZVHglzDdHZDkzIZlrm1W/IyHSpRKCNqRyu4Yt7i5C1HzL5zj20hXXTUyvkso5UA
	 v4/UwBq1a7wF/NqHHkrPoUvx6jNgNLubKEx8h6VC4kHnFk3+orZMJ0wAxyaxcSAydg
	 bIlqCfBI14KNg2LF+A7P8lBB6x9QIh5my9CR3Q9rIDz/D7d+sAxCExs0zs6YB5jHhV
	 TmlB84M/kmhLNEKBngWTArqRaau5hZF7ichrzo2JUUaXJNs7QQDWo38BdmwWfElsGb
	 UlaNMxVoteSSA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/3] NFSD: Clear TIME_DELEG in the suppattr_exclcreat bitmap
Date: Mon, 17 Nov 2025 11:00:50 -0500
Message-ID: <20251117160051.10213-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117160051.10213-1-cel@kernel.org>
References: <20251117160051.10213-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

From RFC 8881:

5.8.1.14. Attribute 75: suppattr_exclcreat

> The bit vector that would set all REQUIRED and RECOMMENDED
> attributes that are supported by the EXCLUSIVE4_1 method of file
> creation via the OPEN operation. The scope of this attribute
> applies to all objects with a matching fsid.

There's nothing in RFC 8881 that states that suppattr_exclcreat is
or is not allowed to contain bits for attributes that are clear in
the reported supported_attrs bitmask. But it doesn't make sense for
an NFS server to indicate that it /doesn't/ implement an attribute,
but then also indicate that clients /are/ allowed to set that
attribute using OPEN(create) with EXCLUSIVE4_1.

The FATTR4_WORD2_TIME_DELEG attributes are also not to be allowed
for OPEN(create) with EXCLUSIVE4_1. It doesn't make sense to set
a delegated timestamp on a new file.

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index e4263326ca4a..50be785f1d2c 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -547,8 +547,14 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 #define NFSD_SUPPATTR_EXCLCREAT_WORD1 \
 	(NFSD_WRITEABLE_ATTRS_WORD1 & \
 	 ~(FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_MODIFY_SET))
+/*
+ * The FATTR4_WORD2_TIME_DELEG attributes are not to be allowed for
+ * OPEN(create) with EXCLUSIVE4_1. It doesn't make sense to set a
+ * delegated timestamp on a new file.
+ */
 #define NFSD_SUPPATTR_EXCLCREAT_WORD2 \
-	NFSD_WRITEABLE_ATTRS_WORD2
+	(NFSD_WRITEABLE_ATTRS_WORD2 & \
+	~(FATTR4_WORD2_TIME_DELEG_ACCESS | FATTR4_WORD2_TIME_DELEG_MODIFY))
 
 extern int nfsd4_is_junction(struct dentry *dentry);
 extern int register_cld_notifier(void);
-- 
2.51.0


