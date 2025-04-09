Return-Path: <linux-nfs+bounces-11075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D503FA83209
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 22:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408F37AC37E
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD42212B3D;
	Wed,  9 Apr 2025 20:36:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEE154BF5
	for <linux-nfs@vger.kernel.org>; Wed,  9 Apr 2025 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744231005; cv=none; b=rMHpszzi4ubslECKeEzEfsyNrRs1FfTLtDwCP06RQSPTRKXhKR4YmzFzyP8mcmAHeXTwK02Htd35iC6ToqnTTl2jqbLh5+ngZwaC5Tpaj+6Trpy8Gu74NYy6HLXn5RCw3IXARo7SWEbdlM9gpzrDMUZMWWS41GAp5wUg1SCUNGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744231005; c=relaxed/simple;
	bh=EF6bs4l0O8EVyfbM6tndjzITPHRhgEdAy8miSNeyejE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=r4R4cxYwuViBVIJh8xsIzsMujg0/+qQ6qjD+qRskToFWpQGWdGGyK9Udh5kVFWXhfHJPiqxtTB4gfqSZ1yJTY6Ikali3wATXjVQ06gZaKG4g+Udtldd8tg2qmZFv8+OhEn8/xnpYLqsC+Q5YoOmQclk+kF2W8FRLl4kciZXBdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.153.136) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 9 Apr
 2025 23:36:34 +0300
Message-ID: <c32dced7-a4fa-43c0-aafe-ef6c819c2f91@omp.ru>
Date: Wed, 9 Apr 2025 23:36:33 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] nfs: nfs3acl: drop useless assignment in nfs3_get_acl()
To: Anna Schumaker <anna@kernel.org>, <linux-nfs@vger.kernel.org>, Trond
 Myklebust <trondmy@kernel.org>
CC: <lvc-project@linuxtesting.org>
Content-Language: en-US
Organization: Open Mobile Platform
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/09/2025 20:00:22
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 192518 [Apr 09 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 54 0.3.54
 464169e973265e881193cca5ab7aa5055e5b7016
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;213.87.153.136:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.153.136
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/09/2025 20:02:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/9/2025 7:16:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

In nfs3_get_acl(), the local variable status is assigned the result of
nfs_refresh_inode() inside the *switch* statement, but that value gets
overwritten in the next *if* statement's true branch and is completely
ignored if that branch isn't taken...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the linux-next branch of Trond Myklebust's linux-nfs.git
repo.

 fs/nfs/nfs3acl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-nfs/fs/nfs/nfs3acl.c
===================================================================
--- linux-nfs.orig/fs/nfs/nfs3acl.c
+++ linux-nfs/fs/nfs/nfs3acl.c
@@ -104,7 +104,7 @@ struct posix_acl *nfs3_get_acl(struct in
 
 	switch (status) {
 		case 0:
-			status = nfs_refresh_inode(inode, res.fattr);
+			nfs_refresh_inode(inode, res.fattr);
 			break;
 		case -EPFNOSUPPORT:
 		case -EPROTONOSUPPORT:

