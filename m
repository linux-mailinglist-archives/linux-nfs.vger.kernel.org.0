Return-Path: <linux-nfs+bounces-11046-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D54A81730
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 22:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1460917A613
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 20:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796D23E351;
	Tue,  8 Apr 2025 20:54:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5023C8C1
	for <linux-nfs@vger.kernel.org>; Tue,  8 Apr 2025 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145647; cv=none; b=X02QyRgjdKlmE1hBRY+iVoNlGPsR4OtKNyuuhrJf9ciJuFxt8L+7DpTwMbyxdjZsoyfScMIorHcmTbVGD9iokWWPJ0MMey37sJgSCCFhuB4DIKzBKV6GRu3agTP6t7VWlS4QFP6wwHh9UZVPa+feGvoIkG0dEuXE9ycKctEjJXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145647; c=relaxed/simple;
	bh=3xT6uS8HztkRqOOr0LTbG8hzn5pb6pq/trhliBKKZ8c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=UzqDoEASs4AVlJMSRJKx1s7jt5DKKrr303KflPyidlRYySOLssD67C2mejuwZF41JL3fFXRiJwYU0kRmEl0TdYW4Fx4iTTe3zW9FTQ1fVsfMqKF5MB6S7/+TgCYDOrcn5oIzckg7h3Rb0Mza/2qRq9qbO4XhV0JCOyt7rH+++gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.130.132) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 8 Apr
 2025 23:53:44 +0300
Message-ID: <416219f5-7983-484b-b5a7-5fb7da9561f7@omp.ru>
Date: Tue, 8 Apr 2025 23:53:42 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] nfs: direct: drop useless initializer in
 nfs_direct_write_completion()
To: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
	<anna@kernel.org>, <linux-nfs@vger.kernel.org>
Content-Language: en-US
CC: <lvc-project@linuxtesting.org>
Organization: Open Mobile Platform
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/08/2025 20:37:33
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 192477 [Apr 08 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 54 0.3.54
 464169e973265e881193cca5ab7aa5055e5b7016
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.130.132 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.130.132 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.130.132
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/08/2025 20:39:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/8/2025 7:41:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

In nfs_direct_write_completion(), the local variable req isn't used outside
the *while* loop and is assigned to right at the start of that loop's body,
so its initializer appears useless -- drop it; then move the declaration to
the loop body (which happens to have a pointless empty line anyway)...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the linux-next branch of Trond Myklebust's linux-nfs.git
repo.

 fs/nfs/direct.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-nfs/fs/nfs/direct.c
===================================================================
--- linux-nfs.orig/fs/nfs/direct.c
+++ linux-nfs/fs/nfs/direct.c
@@ -757,7 +757,6 @@ static void nfs_direct_write_completion(
 {
 	struct nfs_direct_req *dreq = hdr->dreq;
 	struct nfs_commit_info cinfo;
-	struct nfs_page *req = nfs_list_entry(hdr->pages.next);
 	struct inode *inode = dreq->inode;
 	int flags = NFS_ODIRECT_DONE;
 
@@ -786,6 +785,7 @@ static void nfs_direct_write_completion(
 	spin_unlock(&inode->i_lock);
 
 	while (!list_empty(&hdr->pages)) {
+		struct nfs_page *req;
 
 		req = nfs_list_entry(hdr->pages.next);
 		nfs_list_remove_request(req);

