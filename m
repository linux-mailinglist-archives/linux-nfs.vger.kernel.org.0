Return-Path: <linux-nfs+bounces-7135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DBE99C7EA
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 13:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C228578A
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECF319D889;
	Mon, 14 Oct 2024 10:59:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329C41A7053;
	Mon, 14 Oct 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903597; cv=none; b=dYJdShBaD9XF79QkXmTcypClq/EOozgjG4LQpFxqPkOnCYoa5rkfc0755ORDB+2AqaCBeZqL4EohtAR9qV1W8neklVVtZjpKui7oA7HbXugLgsMVCvpPrR4T+E/D6pjZ5e3H/xuLuB8fSRnrqpND+QM2XDkrcK3DGUMwxMr+ra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903597; c=relaxed/simple;
	bh=7yj401S/QfEgPguHrgI7BCX+1aPLUKhWdK1yTuic9xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UauQlKoZgDQdQO9fYMoV52Iv3gZcsnLP8AKf56afupQUDp32kzYcAVnYA2zCOFTB2wbJQy25Wu+Ray8j04y04wk727Pn47MCkHh6A7x7rxr3ZjrEDkzO2gfeBbVPQpvoHpdHDnXnlpKDzKu/Cm9NjWUmIa6jO/cNVxc4gInL8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6B51424;
	Mon, 14 Oct 2024 04:00:25 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5CEC3F51B;
	Mon, 14 Oct 2024 03:59:52 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anna Schumaker <anna@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v1 09/57] fs/nfs: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:16 +0100
Message-ID: <20241014105912.3207374-9-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Calculation of NFS4ACL_MAXPAGES and NFS4XATTR_MAXPAGES are modified to
give max pages when page size is at the minimum.

BUILD_BUG_ON() is modified to test against the min page size, which
implicitly also applies to all other page sizes.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 fs/nfs/nfs42proc.c  | 2 +-
 fs/nfs/nfs42xattr.c | 2 +-
 fs/nfs/nfs4proc.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 28704f924612c..c600574105c63 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1161,7 +1161,7 @@ int nfs42_proc_clone(struct file *src_f, struct file *dst_f,
 	return err;
 }
 
-#define NFS4XATTR_MAXPAGES DIV_ROUND_UP(XATTR_SIZE_MAX, PAGE_SIZE)
+#define NFS4XATTR_MAXPAGES DIV_ROUND_UP(XATTR_SIZE_MAX, PAGE_SIZE_MIN)
 
 static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
 {
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index b6e3d8f77b910..734177eb44889 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -183,7 +183,7 @@ nfs4_xattr_alloc_entry(const char *name, const void *value,
 	uint32_t flags;
 
 	BUILD_BUG_ON(sizeof(struct nfs4_xattr_entry) +
-	    XATTR_NAME_MAX + 1 > PAGE_SIZE);
+	    XATTR_NAME_MAX + 1 > PAGE_SIZE_MIN);
 
 	alloclen = sizeof(struct nfs4_xattr_entry);
 	if (name != NULL) {
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b8ffbe52ba15a..3c3622f46d3e0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5928,7 +5928,7 @@ static bool nfs4_server_supports_acls(const struct nfs_server *server,
  * it's OK to put sizeof(void) * (XATTR_SIZE_MAX/PAGE_SIZE) bytes on
  * the stack.
  */
-#define NFS4ACL_MAXPAGES DIV_ROUND_UP(XATTR_SIZE_MAX, PAGE_SIZE)
+#define NFS4ACL_MAXPAGES DIV_ROUND_UP(XATTR_SIZE_MAX, PAGE_SIZE_MIN)
 
 int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
 		struct page **pages)
-- 
2.43.0


