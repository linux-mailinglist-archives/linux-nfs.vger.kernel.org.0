Return-Path: <linux-nfs+bounces-13114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044BBB07A82
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 17:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107ADA43984
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BBD2F4A00;
	Wed, 16 Jul 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iyr0WH3n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A429E0EE
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681561; cv=none; b=PGFvLHKxXyd2RFWGhxVLkBOubLTNfSriaxkzxfLkCL25b9wsYIpeWp0boUiLNYCwvG8zf99XLfe7cKb0rdfE0nj/slZ3gpgPEpaAIa9YjVfci8hEH+a3F8DQgWvEa/WAVy4pAomy9z1bgxPyqFrFELuQJT6w1MfaqfvzPGxBJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681561; c=relaxed/simple;
	bh=vFOe1vvPBJiSBL+R79B+pp/IHV0R74pYsy2wma0Kl5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rA74W7XKcFAa0WHGsbCH5jKPf9PDjcUX7yBWl61e15fL+TFtJN5rRrUVZIZ57xfbWoIWGrnJAUkReYb9AXr1YHrgDz2F+sJ0UuaZlw12AcoN5HImC7w9fX4TrH8C1QT8g1l8mxKPXrK4Eq40N8cP5+LqWZAO5Q+lMQqf3vE130s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iyr0WH3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B343C4CEF0;
	Wed, 16 Jul 2025 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752681560;
	bh=vFOe1vvPBJiSBL+R79B+pp/IHV0R74pYsy2wma0Kl5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iyr0WH3n66CT/MBX18nHgbC4L4QXqYXyHL2yKSOfGZZI85rJA1XXAzqRb1v7AoKzK
	 VVE9+7l2kBs4mbRXw/mBl5Tx8BKaUIpMFS8OTcFgCbtDs8+9nZ6rfwbV87kWrJKjUJ
	 euuNyPFh+uD5p6Lvhup6iyiH4t8U3vK9TKnpfCtcFYQ+91M0N7hvyYgeeh3KYPIi8E
	 T6DriLP+wtVnwveNFIW4whD8ggbCjj4/DHU2H1m6WqLPQI/J+nGZkqxsRCi8mJd4xb
	 BAS/OAjjld5jCmRNw0X5Y0FxylPf/7vmaNzaGQUpM0mO9Qs28KHjkO8cqeJ1boJWF9
	 yQQw5FMvuKGBw==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>,
	Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] NFS/localio: nfs_close_local_fh() fix check for file closed
Date: Wed, 16 Jul 2025 08:59:16 -0700
Message-ID: <9f5029854eb30a42bf5707e8335196cebc6833bc.1752671200.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752671200.git.trond.myklebust@hammerspace.com>
References: <cover.1752671200.git.trond.myklebust@hammerspace.com>
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
index 05c7c16e37ab..64949c46c174 100644
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
2.50.1


