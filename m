Return-Path: <linux-nfs+bounces-16991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA23CAE212
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 21:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9861D3017391
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7E26A1AF;
	Mon,  8 Dec 2025 20:04:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F83D76
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765224293; cv=none; b=E4cQiTxWYcHOsCXj2UvsHnkAty8EG0XNndVx+mxY5YLmDBPSU185/FTF5pam9jUNy6DFuT85SgQBx2O9P541LN0Pzw3E7EGEHTuSqYm1t5PrwMuZjGvrQHkjsLccyxEmY0pputBdrQb1oc//RTT/d1nwqhU6pUhoJFx39NsoIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765224293; c=relaxed/simple;
	bh=7ZN1RB1uR25yPJQmq1DEa4qSUs8pLk+A1PuztypjI1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prJBDVIUpjs4xfKqZoOKmSQucMKpQtjrsLsci2pRqp/JJTrLOasYK4iB5vhPKfOiPj/5tvZjbx5/Qe5YXb/WdvX4mX0qVTgSSUWzRxR6+1yfteO13BjlXNwbPi07Vb6ApSab5rUy5PL3g3giAjvjRuBNBSvF0iErktpQ9cdDSNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from wasted (213.87.153.35) by msexch01.omp.ru (10.188.4.12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 8 Dec
 2025 23:04:39 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	<linux-nfs@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 1/2] NFSv4: pass lease period in seconds to nfs4_set_lease_period()
Date: Mon, 8 Dec 2025 23:03:36 +0300
Message-ID: <20251208200345.20414-2-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251208200345.20414-1-s.shtylyov@omp.ru>
References: <20251208200345.20414-1-s.shtylyov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 12/08/2025 19:47:10
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 198802 [Dec 08 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.20
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 83 0.3.83
 09a3d723d526c988752a5a52c43a1b245451c48d
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.153.35 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.153.35 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.153.35
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/08/2025 19:48:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/8/2025 6:46:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

There's no need to multiply the lease period by HZ at all the call sites of
nfs4_set_lease_period() -- it makes more sense to do that only once, inside
that function, by passing to it lease period as 32-bit # of seconds instead
of 32/64-bit *unsigned long* # of jiffies...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 fs/nfs/nfs4_fs.h    | 3 +--
 fs/nfs/nfs4proc.c   | 2 +-
 fs/nfs/nfs4renewd.c | 7 ++++---
 fs/nfs/nfs4state.c  | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index c34c89af9c7d..44cf167f65c6 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -464,8 +464,7 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *);
 extern void nfs4_schedule_state_renewal(struct nfs_client *);
 extern void nfs4_kill_renewd(struct nfs_client *);
 extern void nfs4_renew_state(struct work_struct *);
-extern void nfs4_set_lease_period(struct nfs_client *clp, unsigned long lease);
-
+extern void nfs4_set_lease_period(struct nfs_client *clp, u32 period);
 
 /* nfs4state.c */
 extern const nfs4_stateid current_stateid;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ec1ce593dea2..b66f97acafde 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5556,7 +5556,7 @@ static int nfs4_do_fsinfo(struct nfs_server *server, struct nfs_fh *fhandle, str
 		err = _nfs4_do_fsinfo(server, fhandle, fsinfo);
 		trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
 		if (err == 0) {
-			nfs4_set_lease_period(server->nfs_client, fsinfo->lease_time * HZ);
+			nfs4_set_lease_period(server->nfs_client, fsinfo->lease_time);
 			break;
 		}
 		err = nfs4_handle_exception(server, err, &exception);
diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index 18ae614e5a6c..043b2de8d416 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -137,11 +137,12 @@ nfs4_kill_renewd(struct nfs_client *clp)
  * nfs4_set_lease_period - Sets the lease period on a nfs_client
  *
  * @clp: pointer to nfs_client
- * @lease: new value for lease period
+ * @period: new value for lease period (in seconds)
  */
-void nfs4_set_lease_period(struct nfs_client *clp,
-		unsigned long lease)
+void nfs4_set_lease_period(struct nfs_client *clp, u32 period)
 {
+	unsigned long lease = period * HZ;
+
 	spin_lock(&clp->cl_lock);
 	clp->cl_lease_time = lease;
 	spin_unlock(&clp->cl_lock);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 01179f7de322..a435d4d47b3c 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -103,7 +103,7 @@ static int nfs4_setup_state_renewal(struct nfs_client *clp)
 
 	status = nfs4_proc_get_lease_time(clp, &fsinfo);
 	if (status == 0) {
-		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ);
+		nfs4_set_lease_period(clp, fsinfo.lease_time);
 		nfs4_schedule_state_renewal(clp);
 	}
 
-- 
2.52.0


