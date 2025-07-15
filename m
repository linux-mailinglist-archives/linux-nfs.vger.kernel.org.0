Return-Path: <linux-nfs+bounces-13092-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5C4B0696B
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 00:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712B84E23E6
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F332D0C7B;
	Tue, 15 Jul 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGHebcx+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED429B8E4
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619974; cv=none; b=lAP4Xtf821M7XngrbnQWFg7n8Z3IIfW9MBCnOLC895P1/0ZUaQUq7QIyNlJAMTvZiUEsy4fMFMDuzad/z7HzVJU1CbPaFll+iUlYdthtIWJp3yvtEw7uM3pWrHIHCUfqmuQMXfGpkv0ueQ5BxNm3MU2OU5Oyg1XFP2dzao1RcPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619974; c=relaxed/simple;
	bh=7UR++qsiJ1GnFA3zCp6f0BQITRdjJAgXRXnZwGH+cBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etCzT0xpGKl95h0/RhWmTcYNv7R+lgc08pEKD+Zp74UCWkfdH+egWz534AlZ5tnDVZZns+eishmZQfLU4oa1G5po3MUCQQh4wSZ7hgrumqM0YZc0nZzdklzHUoxZgpkiloHLqxtHP8s0WejKl5sn8wDm+SQ7PQbV9GIWHWPDR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGHebcx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86557C4CEE3;
	Tue, 15 Jul 2025 22:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752619973;
	bh=7UR++qsiJ1GnFA3zCp6f0BQITRdjJAgXRXnZwGH+cBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGHebcx+O6L7MfEq65aTrFwEgL+BmduJe5kh+fGQI3hCTYYi5cUF2egTbFS0dH5hy
	 KWsUNjiZAsDF1ZHJPOLESQI7+2D7VxqX1ZPaFhH6gfsss7mC993o19DPgiLlNCPF9G
	 Wevc2AUT3JX1q31fCCKsvA36e8NPLWEZlSFRW/pXKL/zYyw1Xeeuyl2r/AvYMEoSce
	 Yg2EwpWmHBnw3d0QAfFxb7bqH6y81rnfLa+HERLXB6vx40O13nOyz2sY61VvdYBMo2
	 Q+K9MmmYwuv9Obdi8dIyMx0GG+Hsx1LPJvB1Qo4zbBO3Y1d5rPo7ZSYJqjXhmVT2g+
	 y4Pwi6kwfjmhA==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>,
	Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS/localio: nfs_uuid_put() fix the wait for file unlink events
Date: Tue, 15 Jul 2025 15:52:49 -0700
Message-ID: <5d191a4f112055a6b79881a2dade9c0721f91830.1752618161.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752618161.git.trond.myklebust@hammerspace.com>
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

No reference to nfl is held when waiting in nfs_uuid_put(), so not only
must the event condition check if the first entry in the list has
changed, it must also check if the nfl->nfs_uuid field is still NULL,
in case the old entry was replaced.

Also change the event variable to be nfs_uuid, for the same reason that
no reference is held to nfl.

Acked-by: Mike Snitzer <snitzer@kernel.org>
Tested-by: Mike Snitzer <snitzer@kernel.org>
Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs_common/nfslocalio.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 64949c46c174..d157fdc068d7 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -177,12 +177,13 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 			/* nfs_close_local_fh() is doing the
 			 * close and we must wait. until it unlinks
 			 */
-			wait_var_event_spinlock(nfl,
-						list_first_entry_or_null(
-							&nfs_uuid->files,
-							struct nfs_file_localio,
-							list) != nfl,
-						&nfs_uuid->lock);
+			wait_var_event_spinlock(
+				nfs_uuid,
+				list_first_entry_or_null(
+					&nfs_uuid->files,
+					struct nfs_file_localio, list) != nfl ||
+					rcu_access_pointer(nfl->nfs_uuid),
+				&nfs_uuid->lock);
 			continue;
 		}
 
@@ -338,7 +339,7 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 	 */
 	spin_lock(&nfs_uuid->lock);
 	list_del_init(&nfl->list);
-	wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
+	wake_up_var_locked(nfs_uuid, &nfs_uuid->lock);
 	spin_unlock(&nfs_uuid->lock);
 }
 EXPORT_SYMBOL_GPL(nfs_close_local_fh);
-- 
2.50.1


