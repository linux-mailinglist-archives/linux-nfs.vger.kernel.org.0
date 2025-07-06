Return-Path: <linux-nfs+bounces-12851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DB3AF04FD
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 22:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A74E485FE7
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 20:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE8A302049;
	Tue,  1 Jul 2025 20:35:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221142EE27B;
	Tue,  1 Jul 2025 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402133; cv=none; b=kz86YRwlCh1Kej1H+W2f2TeoAMRDiGHtd65eqPP7BrMozLxJ6avVj7wrWkuNXpXHQnd1t5U++ObQoJI3kl1peE7+OV4SiwHA5KpN4LoYh1vlwJ8askOPze39ESGiHRY00fvpn/JkykFuSJ08q+gzZ0v7W0gLAYUgNnRycU9RpUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402133; c=relaxed/simple;
	bh=aFFF1mLuYBw2ufmFNwubdrwFdnLPXZHdYb0mk4i6WbE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=eCrlnaJ055TP9Ui2JtoS6zeP9HhrhzK11hqr+NT+xZ9XGihGInbPyrtmQ04JO88avYv7LCntF49L6w1YcQhc9nm3dtPm6UI5Ug/bh6QfmEM6mlZ4A0zUi/YJHUnvVqqm1MZkTtUkD2oCdelAQCxQFKT5G65WVGcJjhgFNpZZr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.131.62) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 1 Jul
 2025 23:35:07 +0300
Message-ID: <f769ad67-fc6b-4101-8bdc-8b41eba73a21@omp.ru>
Date: Tue, 1 Jul 2025 23:35:05 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
To: <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>
Content-Language: en-US
CC: <linux-kernel@vger.kernel.org>
Organization: Open Mobile Platform
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/01/2025 20:22:13
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194471 [Jul 01 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.131.62 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.131.62 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.131.62
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/01/2025 20:24:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/1/2025 6:30:00 PM
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
once, inside that function, calling check_mul_overflow() and capping result
at ULONG_MAX on actual overflow...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: stable@vger.kernel.org

---
The patch is against the master branch of Trond Myklebust's linux-nfs.git repo.

Changes in version 2:
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
@@ -463,8 +463,7 @@ struct nfs_client *nfs4_alloc_client(con
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
@@ -5476,7 +5476,7 @@ static int nfs4_do_fsinfo(struct nfs_ser
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
+		lease = ULONG_MAX;
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
 

