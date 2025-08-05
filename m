Return-Path: <linux-nfs+bounces-13448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3983AB1BD07
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA32180D55
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179BF29CB4D;
	Tue,  5 Aug 2025 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq/5ynzm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892C20B7ED
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436070; cv=none; b=Vv94ogim9/KnDYXYLIGfkwqh2rQ9vifIBmzIKj5j8ywwlsxSiZT/XoiFRu0QOc5Reiwr4W92bpMZ9OZefCJ3/GBOw/pEY4NxKQA66WJYcxXhkAMPPrbbFFK3WzJUNgUdORp4KC0Y8+d31NJbRJInreWdPrhSXOLAFSxC9UCdszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436070; c=relaxed/simple;
	bh=uouKT2je5aM/89mJRiC6fFLu8P/NrKMwThqvZyWw0j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTaown9NMjMpFuI8YWa0r6gL6XcM7L6xej5G6pmqKefx2xd0Ha6/5qxxqKyaKdRjhl2HeGPN5Rb6Gsbu/KAOW+Ut9XxGv/wPdPuSnb12bh5AngzxE2BAXTkTvw0wehphyp4Cq9/B4s2TEeZkTe+qL4lDF4lkHyEvPlsTUuyRYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq/5ynzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7C9C4CEF9;
	Tue,  5 Aug 2025 23:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436069;
	bh=uouKT2je5aM/89mJRiC6fFLu8P/NrKMwThqvZyWw0j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rq/5ynzmmtQ5/boJKyGQhfHX8M2SXdp0OHzuMxXzy2a8VM9XPiK2J6kwNeyKd53aB
	 1tloVUpjGf3HEdXhv6Ki+oXXsNK/hAlmtmSm+ZBaDiWIythQgO/4uThB73Or0zMPjU
	 Gjhh7fg6Gtk5weAIUPu/nQfNG1DsoR0lKqYBUj3+0+Xe36YgpwYjENp5ELZsIcyGFC
	 Hg/iKcUaPUulutOqG8k9T4GtpFAVfLw+h0JAAI+0QJwiZXUcw6H+ne2xY///ywsNHf
	 9NRc1C7jOxfOKFAKqAtHfRN3RzZTdFvjwu74UPw2rYHdwYnNqJijzLuIe4PBJGKQio
	 PWdC+YCKJrhaQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 01/11] NFS/localio: nfs_close_local_fh() fix check for file closed
Date: Tue,  5 Aug 2025 19:20:56 -0400
Message-ID: <20250805232106.8656-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805232106.8656-1-snitzer@kernel.org>
References: <20250805232106.8656-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the struct nfs_file_localio is closed, its list entry will be empty,
but the nfs_uuid->files list might still contain other entries.

Acked-by: Mike Snitzer <snitzer@kernel.org>
Tested-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs_common/nfslocalio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 05c7c16e37ab4..64949c46c1741 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -314,7 +314,7 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 		rcu_read_unlock();
 		return;
 	}
-	if (list_empty(&nfs_uuid->files)) {
+	if (list_empty(&nfl->list)) {
 		/* nfs_uuid_put() has started closing files, wait for it
 		 * to finished
 		 */
-- 
2.44.0


