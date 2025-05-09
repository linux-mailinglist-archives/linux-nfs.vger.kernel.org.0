Return-Path: <linux-nfs+bounces-11612-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035FEAB074A
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 02:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2683B001E
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 00:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FE24B29;
	Fri,  9 May 2025 00:49:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29FA1EB39
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751757; cv=none; b=X1atdYJQ200Fu+JdgzN/YUsExTMHLnv8PlI95W5TTzmf2xxWGkEXkLxsbH5rRw//EMarKuBN+0lxtshT/FJxAOaNG/6UVcWy5uuXOx8PodwnGaO7xi/EYjlVDifvN3lmORAayddP8BlgjevaSJlAzDEqnWXz59/ylZ05U+kvtw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751757; c=relaxed/simple;
	bh=36t/unwGnueDmaCWVhCsmSsqInFM+ztd0UUhyRJ+/fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksZTA6UYKBeKSJX+DabOid4LmN3RrH5HkxkaTVYbc5V6NYjaYb66dfUvBr3WDAhKTxhBZwlkQ7VgagLxVJTN41qLQLzsddWA23wtUmfyOrIzc+eBkB3mXldoArzamDKoQDXn1yQOoLID7xUih9d6EwxkPJDJ9vCly15fnEvG1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uDBvI-00HQUp-Bw;
	Fri, 09 May 2025 00:49:08 +0000
From: NeilBrown <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 4/6] nfs_localio: duplicate nfs_close_local_fh()
Date: Fri,  9 May 2025 10:46:41 +1000
Message-ID: <20250509004852.3272120-5-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509004852.3272120-1-neil@brown.name>
References: <20250509004852.3272120-1-neil@brown.name>
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
 fs/nfs_common/nfslocalio.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 503f85f64b76..49c59f0c78c6 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -171,7 +171,26 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 
 	/* Walk list of files and ensure their last references dropped */
 	list_for_each_entry_safe(nfl, tmp, &local_files, list) {
-		nfs_close_local_fh(nfl);
+		struct nfsd_file *ro_nf;
+		struct nfsd_file *rw_nf;
+
+		ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
+		rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
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
+		if (ro_nf)
+			nfs_to_nfsd_file_put_local(ro_nf);
+		if (rw_nf)
+			nfs_to_nfsd_file_put_local(rw_nf);
+
 		cond_resched();
 	}
 
-- 
2.49.0


