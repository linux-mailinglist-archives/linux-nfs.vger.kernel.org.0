Return-Path: <linux-nfs+bounces-16996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6048CAE254
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 21:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D30B3008B5A
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975AE2236E3;
	Mon,  8 Dec 2025 20:15:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291EF246333
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765224944; cv=none; b=T1b31xnt0ZaG/wMmK4bjr7UXAY6jMIIvg4Zif8QnWCLMd3Kqga4CA+tf0LpAsX0OT1/pAMPZUTaJv/B1xROgSDPqXOn2veUD8eAhc9sgg02137EAHpovWHzZvCZq2MFa0C80gY0FctmQBtdQnPR6TihEC+y3SZ8nA0oSiudcJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765224944; c=relaxed/simple;
	bh=dT1wIW9NCgFNFBS8ApIE067jcZcHdWLCvrILKVEvMww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuDEYf3PDW87Jii1Box3sPbO8yihw3er8+TtO9PE4L9UZjTpd7RTyeX4stRDtlmrKAbH4UPQPcMt2oc0qf9R/UzHO/r1poWQC0xyZw2ZmP2XnNnC6fBroV2KfO451P1e6EVVYJthudOTokTJTguQysMqSaKxKTPVud8jNL8IFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from wasted (213.87.153.35) by msexch01.omp.ru (10.188.4.12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 8 Dec
 2025 23:15:33 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	<linux-nfs@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH RESEND 2/2] NFSv4: limit lease period in nfs4_set_lease_period()
Date: Mon, 8 Dec 2025 23:15:04 +0300
Message-ID: <20251208201506.20880-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251208201506.20880-1-s.shtylyov@omp.ru>
References: <20251208201506.20880-1-s.shtylyov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 12/08/2025 20:05:15
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
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
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
X-KSE-Antiphishing-Bases: 12/08/2025 20:08:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/8/2025 6:46:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

In nfs4_set_lease_period(), the passed 32-bit lease period in seconds is
multiplied by HZ -- that might overflow before being implicitly cast to
*unsigned long* (32/64-bit type), while initializing the lease variable.
Cap the lease period at MAX_LEASE_PERIOD (#define'd to 1 hour for now),
before multipying to avoid such overflow...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Suggested-by: Trond Myklebust <trondmy@kernel.org>
---
 fs/nfs/nfs4renewd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index 043b2de8d416..30065df1482e 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -133,6 +133,8 @@ nfs4_kill_renewd(struct nfs_client *clp)
 	cancel_delayed_work_sync(&clp->cl_renewd);
 }
 
+#define MAX_LEASE_PERIOD (60 * 60)	/* 1 hour */
+
 /**
  * nfs4_set_lease_period - Sets the lease period on a nfs_client
  *
@@ -141,7 +143,13 @@ nfs4_kill_renewd(struct nfs_client *clp)
  */
 void nfs4_set_lease_period(struct nfs_client *clp, u32 period)
 {
-	unsigned long lease = period * HZ;
+	unsigned long lease;
+
+	/* Limit the lease period */
+	if (period < MAX_LEASE_PERIOD)
+		lease = period * HZ;
+	else
+		lease = MAX_LEASE_PERIOD * HZ;
 
 	spin_lock(&clp->cl_lock);
 	clp->cl_lease_time = lease;
-- 
2.52.0


