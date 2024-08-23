Return-Path: <linux-nfs+bounces-5668-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C998B95D7DF
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 22:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0800D1C227DF
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 20:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD3B1C7B97;
	Fri, 23 Aug 2024 20:33:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152DD18CC0F
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445210; cv=none; b=s1uSG2jLsTu7bf5zY9sJJjayA7oGRfom7iSwP1KQGtSYaMlo5BTn8Bi82hagRXnxI1OejNW65ZLk76UP+gHDGtu9B+BVXNogLY3Z/GLbdAylHaLTI0tAjEOzVjsOYLZX/aumGUkVtLcRJpvMOTnM/rS188q7YXw+m3vr1LpWfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445210; c=relaxed/simple;
	bh=6Trj7J+4EndIG/4ReUSbD7O1zUrDXY2d10BT0DTj8YE=;
	h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type; b=jQt+vgJEY+TB18B6g2Y86iLk0kQ2fMxyakOMZwylY17/st8+tHpcLmqQwLCQQt31FJd6DmeevrAGM3QrwcZWILt7/RikLteCSsrPJyZDZRjjLgjdT4orWcoAaoCXzcnxRdgJhL15hiVHqfqBoZKeK3i1FtoKwZ4hT0KSIO93uNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.82.175) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 23 Aug
 2024 23:32:59 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
To: <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>
Organization: Open Mobile Platform
Message-ID: <4904f32e-a392-803b-9766-4aa2d5cee12b@omp.ru>
Date: Fri, 23 Aug 2024 23:32:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/23/2024 20:17:57
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 187274 [Aug 23 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 27 0.3.27
 71302da218a62dcd84ac43314e19b5cc6b38e0b6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.82.175
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/23/2024 20:25:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/23/2024 7:17:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The nfs_client::cl_lease_time field (as well as the jiffies variable it's
used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
field is multiplied by HZ -- that might overflow *unsigned long* on 32-bit
arches.  Actually, there's no need to multiply by HZ at all the call sites
of nfs4_set_lease_period() -- it makes more sense to do that once, inside
that function (using mul_u32_u32(), as it produces a better code on 32-bit
x86 arch), also checking for an overflow there and returning -ERANGE if it
does happen (we're also making that function *int* instead of *void* and
adding the result checks to its callers)...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: stable@vger.kernel.org

---
This patch is against the master branch of Trond Myklebust's linux-nfs.git repo.

 fs/nfs/nfs4_fs.h    |    3 +--
 fs/nfs/nfs4proc.c   |    3 ++-
 fs/nfs/nfs4renewd.c |   13 ++++++++++---
 fs/nfs/nfs4state.c  |    4 +++-
 4 files changed, 16 insertions(+), 7 deletions(-)

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
+extern int nfs4_set_lease_period(struct nfs_client *clp, u32 period);
 
 /* nfs4state.c */
 extern const nfs4_stateid current_stateid;
Index: linux-nfs/fs/nfs/nfs4proc.c
===================================================================
--- linux-nfs.orig/fs/nfs/nfs4proc.c
+++ linux-nfs/fs/nfs/nfs4proc.c
@@ -5403,7 +5403,8 @@ static int nfs4_do_fsinfo(struct nfs_ser
 		err = _nfs4_do_fsinfo(server, fhandle, fsinfo);
 		trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
 		if (err == 0) {
-			nfs4_set_lease_period(server->nfs_client, fsinfo->lease_time * HZ);
+			err = nfs4_set_lease_period(server->nfs_client,
+						    fsinfo->lease_time);
 			break;
 		}
 		err = nfs4_handle_exception(server, err, &exception);
Index: linux-nfs/fs/nfs/nfs4renewd.c
===================================================================
--- linux-nfs.orig/fs/nfs/nfs4renewd.c
+++ linux-nfs/fs/nfs/nfs4renewd.c
@@ -137,15 +137,22 @@ nfs4_kill_renewd(struct nfs_client *clp)
  * nfs4_set_lease_period - Sets the lease period on a nfs_client
  *
  * @clp: pointer to nfs_client
- * @lease: new value for lease period
+ * @period: new value for lease period (in seconds)
  */
-void nfs4_set_lease_period(struct nfs_client *clp,
-		unsigned long lease)
+int nfs4_set_lease_period(struct nfs_client *clp, u32 period)
 {
+	u64 result = mul_u32_u32(period, HZ);
+	unsigned long lease = result;
+
+	/* First see if period * HZ actually fits into unsigned long... */
+	if (result > ULONG_MAX)
+		return -ERANGE;
+
 	spin_lock(&clp->cl_lock);
 	clp->cl_lease_time = lease;
 	spin_unlock(&clp->cl_lock);
 
 	/* Cap maximum reconnect timeout at 1/2 lease period */
 	rpc_set_connect_timeout(clp->cl_rpcclient, lease, lease >> 1);
+	return 0;
 }
Index: linux-nfs/fs/nfs/nfs4state.c
===================================================================
--- linux-nfs.orig/fs/nfs/nfs4state.c
+++ linux-nfs/fs/nfs/nfs4state.c
@@ -103,7 +103,9 @@ static int nfs4_setup_state_renewal(stru
 
 	status = nfs4_proc_get_lease_time(clp, &fsinfo);
 	if (status == 0) {
-		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ);
+		status = nfs4_set_lease_period(clp, fsinfo.lease_time);
+		if (status)
+			return status;
 		nfs4_schedule_state_renewal(clp);
 	}
 

