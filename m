Return-Path: <linux-nfs+bounces-11367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A89AA41A1
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 06:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA94665D2
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 04:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14F516EB42;
	Wed, 30 Apr 2025 04:05:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC302DC761
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745985905; cv=none; b=RZ1Zi51Xj0ojde10KPfRrV49JpJoD/c9+frmOjvfrL77P0OIGnh3drLsQVpa11shtvHzn+qSojeP63qokTt+RvVZgBDjzqf8B+3vHOKzk6gr2NAVu4MuzGkeiEQS40eWExY7/vvFnJCGYebfFLHTL9p7bgLXiEhMI8TBShBk1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745985905; c=relaxed/simple;
	bh=giwQrLQUlVIxLryGRCCMgylV9eQiYXVisSoHCxBbnU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh3vjW++kR45A+ogY7OV90oTmT+ZojADFC2KoQlSgJFaE+bnTyru658WF+fRdpiX2AC7jqRFvF5I/M1C9vmzHHwI76kcvczB6jSkjGuTu/U8uHONBsl+/HdP69Enuk8FQM5LDT+cFPKlmZIoMB1SeWixPWdi+MUyQyDselW3ifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u9ygp-005EZE-IX;
	Wed, 30 Apr 2025 04:04:55 +0000
From: NeilBrown <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 5/6] nfs_localio: duplicate nfs_close_local_fh()
Date: Wed, 30 Apr 2025 14:01:15 +1000
Message-ID: <20250430040429.2743921-6-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430040429.2743921-1-neil@brown.name>
References: <20250430040429.2743921-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfs_close_local_fh() is called from two different places for quite
different use case.

It is called from nfs_uuid_put() when the nfs_uuid is being detached -
possibly because the nfs server is not longer serving that filesystem.
In this case there will always be an nfs_uuid and so rcu_read_lock() is
not needed.

It is also called when the nfs_file_localio is no longer needed.  In
this case there may not be an active nfs_uuid.

These two can race, and handling the race properly while avoiding
excessive locking will require different handling on each side.

This patch prepares the way by opencoding nfs_close_local_fh() into
nfs_uuid_put(), then simplifying the code there as befits the context.

Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs_common/nfslocalio.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index cbf3e38443f9..abf1591a3b7f 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -171,7 +171,24 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 
 	/* Walk list of files and ensure their last references dropped */
 	list_for_each_entry_safe(nfl, tmp, &local_files, list) {
-		nfs_close_local_fh(nfl);
+		struct nfsd_file __rcu *ro_nf;
+		struct nfsd_file __rcu *rw_nf;
+
+		ro_nf = xchg(&nfl->ro_file, RCU_INITIALIZER(NULL));
+		rw_nf = xchg(&nfl->rw_file, RCU_INITIALIZER(NULL));
+
+		spin_lock(&nfs_uuid->lock);
+		/* Remove nfl from nfs_uuid->files list */
+		list_del_init(&nfl->list);
+		spin_unlock(&nfs_uuid->lock);
+		/* Now we can allow racing nfs_close_local_fh() to
+		 * skip the locking.
+		 */
+		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
+
+		nfs_to_nfsd_file_put_local(ro_nf);
+		nfs_to_nfsd_file_put_local(rw_nf);
+
 		cond_resched();
 	}
 
-- 
2.49.0


