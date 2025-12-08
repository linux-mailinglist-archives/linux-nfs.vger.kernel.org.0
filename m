Return-Path: <linux-nfs+bounces-16994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4917FCAE24E
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 21:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B22633000B37
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA833B8D74;
	Mon,  8 Dec 2025 20:15:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E84205E25
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765224934; cv=none; b=FTT+RPEuUVdaGHjgqmT8uByPmkLdEiPex5mPbkT5mlMJpM8QNTtMlyTjXNr8DO5Vp61EtztYeja3zzbbXCXB7sMm2rFoG4fYmTAle9sagx4t6SIa2RL3ehIpkPpb+CtppM8W63UTibabKsV2umWMwNmPuOfOzDNAUN8onZz5wbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765224934; c=relaxed/simple;
	bh=wgMhRdNndt5ihz00iqNKaO5TlxeMFRbubpfs0Xmhzx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oc84QB3rQg2RgklNmQIiw42xQ6ELJjYo3pBUizxswr7NNBqim1OlbYKbSdNym1afhzy/04ogt/v2nkya9/U/HJYkuq5ffsF8Fp5P3Il/PiMJd2vM0KQsdXNULld0Zx+fcMgTPR1Kt+gDd59VfvjhdTjxfDQgIsjwoGpJgVhVUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from wasted (213.87.153.35) by msexch01.omp.ru (10.188.4.12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 8 Dec
 2025 23:15:22 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	<linux-nfs@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH RESEND 0/2] NFSv4: prevent the lease period overflow
Date: Mon, 8 Dec 2025 23:15:02 +0300
Message-ID: <20251208201506.20880-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.52.0
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
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
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

The nfs_client::cl_lease_time field (as well as the jiffies variable it's
used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
field is multiplied by HZ -- that might overflow before being implicitly
cast to *unsigned long*.  Actually, there's no need to multiply by HZ at
all the call sites of nfs4_set_lease_period() -- it makes more sense to do
that once, inside that function.  That way, we can avoid such overflow by
capping the lease period at e.g. 1 hour before multipying it by HZ...

The patches below are against the linux-next branch of Trond Myklebust's
linux-nfs.git repo.

Sergey Shtylyov (2):
  NFSv4: pass lease period in seconds to nfs4_set_lease_period()
  NFSv4: limit lease period in nfs4_set_lease_period()

 fs/nfs/nfs4_fs.h    |  3 +--
 fs/nfs/nfs4proc.c   |  2 +-
 fs/nfs/nfs4renewd.c | 15 ++++++++++++---
 fs/nfs/nfs4state.c  |  2 +-
 4 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.52.0

