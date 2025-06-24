Return-Path: <linux-nfs+bounces-12738-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00045AE72F5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 01:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFF17A6C83
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 23:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3947B226CF3;
	Tue, 24 Jun 2025 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkrw9sT5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125403595C
	for <linux-nfs@vger.kernel.org>; Tue, 24 Jun 2025 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807071; cv=none; b=pcHmVXLfkpEmTgAMISL93vJ+AvW3wed2aIVH0ybnJb3mlf/abjexTrCtVlFfZxuY7sv+E3PSygvc/apsW55NcoB800+/LqiIZrFl2sd2Z3HWwa4wRizAxotH2ahZcnHS637shungJfETI/lVu4wywchdYzhCdjWJ7eor3SnU9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807071; c=relaxed/simple;
	bh=GdV/AuhP/4Vo/+bpi3F+Du4hd4Nb88T1LMt9gJLe1XE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t2sKalImzUuMO60DrKyk3AYEw5DxuH1bQoeoZRGzX1gkBadb4pvtwJhTRtuwpbZPpU2Mep8K9Cave2DOA/OFGz128IxFGz4HbRn1M4KQtzfABjdQSg9KbWlCNZ75eR+MjLuGzwtBNzrjdoQwM5vLi+blWS0aGNzifKFOx3IQhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkrw9sT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B662C4CEE3
	for <linux-nfs@vger.kernel.org>; Tue, 24 Jun 2025 23:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750807070;
	bh=GdV/AuhP/4Vo/+bpi3F+Du4hd4Nb88T1LMt9gJLe1XE=;
	h=From:To:Subject:Date:From;
	b=Xkrw9sT5grFggdM4h217EQSwGAj4s08MnBPpjRNifq9u/1nlS63mthGWnb/CkSuE0
	 S8vLn+yrRRO5abS6JXsJ53tmsmVjvyN1wqVGIXuUhsS5yjebWi5q8ga0jqevvuTYtU
	 sJDfD3Ngsk2epLlJLamqgQyWl/YH//XkB7uSGL0bh4yf41aMaWBOZ0+Tdb3tB03dso
	 QT2mO4MftZo3gm0WCis1TYGQbP1mVpg1q8jr1INLMN/4InoZJ0X4g2ypjWOtxtTn1q
	 AzUDvE8oBE2j2ZUPHZX5n1rQ9eYP6beJcw9BEov58jzlZPsDjMOhJl5qkgKpyhn9wJ
	 qh9JnGPcQp8gQ==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Allow folio migration for the case of mode == MIGRATE_SYNC
Date: Tue, 24 Jun 2025 19:17:48 -0400
Message-ID: <c0011b8a3943e35f7b63551613b9d6cd23e5428e.1750807060.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When the mode is MIGRATE_SYNC, we are allowed to call nfs_wb_folio()
under the folio lock.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 374fc6b34c79..0dd22983f0d0 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2113,8 +2113,12 @@ int nfs_migrate_folio(struct address_space *mapping, struct folio *dst,
 	 *        that we can safely release the inode reference while holding
 	 *        the folio lock.
 	 */
-	if (folio_test_private(src))
-		return -EBUSY;
+	if (folio_test_private(src)) {
+		if (mode == MIGRATE_SYNC)
+			nfs_wb_folio(src->mapping->host, src);
+		if (folio_test_private(src))
+			return -EBUSY;
+	}
 
 	if (folio_test_private_2(src)) { /* [DEPRECATED] */
 		if (mode == MIGRATE_ASYNC)
-- 
2.49.0


