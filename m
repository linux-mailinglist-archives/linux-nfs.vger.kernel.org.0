Return-Path: <linux-nfs+bounces-16361-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCBC5A04B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 21:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B02D93545F6
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7618D322C70;
	Thu, 13 Nov 2025 20:52:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DC9320CDF;
	Thu, 13 Nov 2025 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763067154; cv=none; b=r/MBXQiyWwUKDaCxXO8eGNRBU/04kXVHo/bYyqryySCCvFgg2TN2RQEy+Oyu+tqptbYSuUMpKIlV9pR8LKBiV+gNETm1ihYl00rK2jfKqsZ6bL2AdJ8j87uWVOs6x5dPsUOS2EnVR2vy+DhqTMyEw/xurmzlnQgDxgOm2OZZ0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763067154; c=relaxed/simple;
	bh=p/TgItdkrTm/R1pCYzci8v/BqsK12QgO5gBxM+vmYQo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=pXH3cjxgLgDBJLL6FFVED8AE0/gIs64XBL3hL+y7HgF+gUoQ70Fj0khqjJSqGV4yTfNoAY+NYFt/VgS6JzoWKLKah3YLA19iLNUOts56YKWWyedaPj1s9fOahLsmKdp1yzQWOfjN4bDx51nL4nhhF8wdosgGIS+HKgz9gxngcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (213.87.135.56) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 13 Nov
 2025 23:37:04 +0300
Message-ID: <e0d1a313-f359-4ad0-bee3-3fcf0ffc0cda@omp.ru>
Date: Thu, 13 Nov 2025 23:37:03 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
To: <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>
CC: <linux-kernel@vger.kernel.org>
Content-Language: en-US
Organization: Open Mobile Platform
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/13/2025 20:28:27
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 198067 [Nov 13 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 76 0.3.76
 6aad6e32ec76b30ee13ccddeafeaa4d1732eef15
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.135.56 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.135.56
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/13/2025 20:30:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/13/2025 4:28:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The nfs_client::cl_lease_time field (as well as the jiffies variable it's
used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
field is multiplied by HZ -- that might overflow before being implicitly
cast to *unsigned long*. Actually, there's no need to multiply by HZ at all
the call sites of nfs4_set_lease_period() -- it makes more sense to do that
once, inside that function, calling check_mul_overflow() and falling back
to 1 hour on an actual overflow...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: stable@vger.kernel.org

---
The patch is against the master branch of Trond Myklebust's linux-nfs.git repo.

Changes in version #3:
- changed the lease period overflow fallback to 1 hour, updated the patch
  description accordingly.

Changes in version #2:
- made use of check_mul_overflow() instead of mul_u32_u32();
- capped the multiplication result at ULONG_MAX instead of returning -ERANGE,
  keeping nfs4_set_lease_period() *void*;
- rewrote the patch description accordingly.

 fs/nfs/nfs4_fs.h    |    3 +--
 fs/nfs/nfs4proc.c   |    2 +-
 fs/nfs/nfs4renewd.c |   10 +++++++---
 fs/nfs/nfs4state.c  |    2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

Index: linux-nfs/fs/nfs/nfs4_fs.h
===================================================================
--- linux-nfs.orig/fs/nfs/nfs4_fs.h
+++ linux-nfs/fs/nfs/nfs4_fs.h
@@ -464,8 +464,7 @@ struct nfs_client *nfs4_alloc_client(con
 extern void nfs4_schedule_state_renewal(struct nfs_client *);
 extern void nfs4_kill_renewd(struct nfs_client *);
 extern void nfs4_renew_state(struct work_struct *);
-extern void nfs4_set_lease_period(struct nfs_client *clp, unsigned long lease);
-
+extern void nfs4_set_lease_period(struct nfs_client *clp, u32 period);
 
 /* nfs4state.c */
 extern const nfs4_stateid current_stateid;
Index: linux-nfs/fs/nfs/nfs4proc.c
===================================================================
--- linux-nfs.orig/fs/nfs/nfs4proc.c
+++ linux-nfs/fs/nfs/nfs4proc.c
@@ -5478,7 +5478,7 @@ static int nfs4_do_fsinfo(struct nfs_ser
 		err = _nfs4_do_fsinfo(server, fhandle, fsinfo);
 		trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
 		if (err == 0) {
-			nfs4_set_lease_period(server->nfs_client, fsinfo->lease_time * HZ);
+			nfs4_set_lease_period(server->nfs_client, fsinfo->lease_time);
 			break;
 		}
 		err = nfs4_handle_exception(server, err, &exception);
Index: linux-nfs/fs/nfs/nfs4renewd.c
===================================================================
--- linux-nfs.orig/fs/nfs/nfs4renewd.c
+++ linux-nfs/fs/nfs/nfs4renewd.c
@@ -137,11 +137,15 @@ nfs4_kill_renewd(struct nfs_client *clp)
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
+	unsigned long lease;
+
+	if (check_mul_overflow(period, HZ, &lease))
+		lease = 60UL * 60UL * HZ; /* one hour */
+
 	spin_lock(&clp->cl_lock);
 	clp->cl_lease_time = lease;
 	spin_unlock(&clp->cl_lock);
Index: linux-nfs/fs/nfs/nfs4state.c
===================================================================
--- linux-nfs.orig/fs/nfs/nfs4state.c
+++ linux-nfs/fs/nfs/nfs4state.c
@@ -103,7 +103,7 @@ static int nfs4_setup_state_renewal(stru
 
 	status = nfs4_proc_get_lease_time(clp, &fsinfo);
 	if (status == 0) {
-		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ);
+		nfs4_set_lease_period(clp, fsinfo.lease_time);
 		nfs4_schedule_state_renewal(clp);
 	}
 

