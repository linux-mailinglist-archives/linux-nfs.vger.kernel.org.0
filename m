Return-Path: <linux-nfs+bounces-13140-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F009B09923
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 03:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABAC4A72C7
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 01:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC27517C21C;
	Fri, 18 Jul 2025 01:28:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341C13AD3F
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802121; cv=none; b=OtZ869N7f4g2fs70ZeOr4eqfRVoBXFPRGT/9n3yAgdr+ENgTJO/gsbW5N9LrmDDja1bRGMlp5wfLuO92Ryyc3enk1Gf6W9Gcev/wM4CwXjWXxIQYMZQF4QWIJ3mS2tk6Vj3FsI/q9e1u56rBb1KRqO2Do7YkeWSHqShz+hQcBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802121; c=relaxed/simple;
	bh=5j1IG4e5ePKulCLJa/geiHkcJHarrXP/ttbHYaVWi84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPyfN/BZoazYlNA0N8p9UnhR21NYoJqc7j7bDEbz57MwEMXP573Ylz2Hg8cmiv7QeDe3dITfv9kgygiZhBNpaQ56QRzQEadF1fLytRztalIEttAxHV/XTKSlEJsjMcBMcpkwHr2/zaft3GXfIfvQFDIb0afRgmq9f8r6XiFMWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ucZts-002QCF-EA;
	Fri, 18 Jul 2025 01:28:38 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: avoid ref leak in nfsd_open_local_fh()
Date: Fri, 18 Jul 2025 11:26:14 +1000
Message-ID: <20250718012831.2187613-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250718012831.2187613-1-neil@brown.name>
References: <20250718012831.2187613-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If two calls to nfsd_open_local_fh() race and both successfully call
nfsd_file_acquire_local(), they will both get an extra reference to the
net to accompany the file reference stored in *pnf.

One of them will fail to store (using xchg()) the file reference in
*pnf and will drop that reference but WONT drop the accompanying
reference to the net.  This leak means that when the nfs server is shut
down it will hang in nfsd_shutdown_net() waiting for
&nn->nfsd_net_free_done.

This patch adds the missing nfsd_net_put().

Reported-by: Mike Snitzer <snitzer@kernel.org>
Fixes: e6f7e1487ab5 ("nfs_localio: simplify interface to nfsd for getting nfsd_file")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/localio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 80d9ff6608a7..519bbdedcb11 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -103,10 +103,11 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 			if (nfsd_file_get(new) == NULL)
 				goto again;
 			/*
-			 * Drop the ref we were going to install and the
-			 * one we were going to return.
+			 * Drop the ref we were going to install (both file and
+			 * net) and the one we were going to return (only file).
 			 */
 			nfsd_file_put(localio);
+			nfsd_net_put(net);
 			nfsd_file_put(localio);
 			localio = new;
 		}
-- 
2.49.0


