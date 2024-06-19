Return-Path: <linux-nfs+bounces-4071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C536490EF6D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 15:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0E1284999
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299714EC6E;
	Wed, 19 Jun 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ouj2ynTG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6814EC4B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805187; cv=none; b=nYRyO0Vo7PII5My4biA2VrP4exdrHCquFZ8UtGORRVRjiFboGIZrt+jV7TD35M0eYw2FzrqKf71rjURx/qh0OTsMl/EnV9UBQbbeIEjjytZ3mrX/UkzwK7j7qTn4fWhQ0YisTZcBPJ/6YP0Iqi3AVNZTgFkI0C6xE7A9UnicVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805187; c=relaxed/simple;
	bh=xpd0Hiluzr5n/BFhEA7c9EsM6ixjjTC7k8+w9Hk87+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooXp0auAQTBgZEYEi3sT3k9AtCFyO8edqWjVYSjL2nZb4a4HEiuKlgb9Po70DriufZuUVM7E97tAHNr8rCXHenO40xaDWWGf7h0OD9lLu8ZlYJszFZ1Oys/9JVGG3AqbiRu6HeOHFsNn/9Q8/WdB0oVgEBjGNV2ewY+3Yba1nIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ouj2ynTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6928C32786;
	Wed, 19 Jun 2024 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805187;
	bh=xpd0Hiluzr5n/BFhEA7c9EsM6ixjjTC7k8+w9Hk87+w=;
	h=From:To:Cc:Subject:Date:From;
	b=Ouj2ynTGx8ALE7l+figB9Yq7Ds8o82+K6b3+CylZcur7Dbsws3cB4TulVCXb9npHf
	 VCZ+x+HwUZQ8TYgXe/b9XFwZr/FXKjTEy2uR6V39nQpZVq6zRnAjQoQLyqPlPXVCNF
	 qL0cPKJBgI4fz/qTmWZ7xD8JedW2JW7A/Wss8ufXDhK39NDq6JxsqefPAgSc6wdI6R
	 et2W64zzMIhm//9g0EeTH9HDTyl0f4eRl+uLXFNVyb0El9PvtSQVlp/L1CyE0P0kK9
	 Ei2zpxNBdnYMv7IYW21n6GvIP6hHlROLcyN+bR4JAC5nNo3RLLo1axOvaWvRUT5JvE
	 pAR2nodWXNZ8A==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Ben Coddington <bcodding@redhat.com>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] nfs/blocklayout: fput() needed for ENODEV error flow
Date: Wed, 19 Jun 2024 09:52:56 -0400
Message-ID: <20240619135255.176454-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=chuck.lever@oracle.com; h=from:subject; bh=fFWWOXgdO8u7lRnm5NyxLdKGCfLRrzlbOyOQVqgb1ug=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmcuK36hQCEqVtKMoYvSjDZlya37DEfeVx5qNVN 9mTJI95yViJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnLitwAKCRAzarMzb2Z/ l68qD/45gmjr7BmzsPB9SVMRMKsrRDYdmmmH0cI/4Jvb5lWT9ciopdMMH+MkOtvF4QZE/bRm1zF G5pOO1B7rbRs+xOW4A60gMfkoqh8yEsb6AClUBMEN9uA0n2skvVKqRRWBj+A2Zy5flVfg1mtilt tjKy/eSkVh+RiwQZ+jt/Tq6Aj9oLs23VAnBccV0YFlwCQS5EtT73/4nD3A4UY9U7DUKki4uDA7x Id4QnKhlkldzfg3IbHhMfibijhJNLjP7pMInvYH2rJdLE9WQw9N19SSnxMIFi8Zy8+VG64o4R+n MeEEfy0G3DlygeEGB1VSJ5BEX9shoM6FXtJGiX1kkVoW/NvrKMKvAnuZxXQJ9XbCeTeOzpe7cuP UoYBlzLmnDUDbzVJh96gFhsX5FJdSFg5AKYdEwOAnA5hSYEn6te4zZU9w0NqLz+3jfYYmBb+T68 U+cTt+7LgFVHxQj83Jmb8qUjySQ/SV3plYoQ2kgOvXf6S/glJkY/WjNigdQnNVHm2DjyV8mNN66 MnklAPAxTwS7yheHGOLlOQgJ+dNueGH/N1pI7FwTLYyzajynCQyBZ3SVOdoxvCF6KNhJEo+sIdI p22AKi4WUizDhUt/1Q4bU17KwvoTwlggXKAKJOFPHyBJAUiCb+alpTWZpnpvm9ZK9W/NCI34NQv gQ1lvWk/Eewc9Pg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

A recently-added error flow needs to fput() the block device just
like the other error flows in this area; otherwise the device is
leaked.

Fixes: d76c769c8db4 ("pnfs/blocklayout: Don't add zero-length pnfs_block_dev")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 93ef7f864980..519c310c745d 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -351,8 +351,10 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
-	if (d->len == 0)
-		return -ENODEV;
+	if (d->len == 0) {
+		error = -ENODEV;
+		goto out_blkdev_put;
+	}
 
 	pr_info("pNFS: using block device %s (reservation key 0x%llx)\n",
 		file_bdev(d->bdev_file)->bd_disk->disk_name, d->pr_key);
-- 
2.45.1


