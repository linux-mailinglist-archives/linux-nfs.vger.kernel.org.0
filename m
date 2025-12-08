Return-Path: <linux-nfs+bounces-16997-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3ACAE261
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 21:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3574B3009B4B
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 20:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A52343BE;
	Mon,  8 Dec 2025 20:19:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C52236E3
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765225169; cv=none; b=JS1MFqy1+p2RmE0VBc6s0C9CPjl+LiIwH761uqq9LY4X5kij0GAcG6szFihEm2ejKJhK9NfdGplCjoyTR9qIdC+xqFo+cDP3LSD9l4ZfaRla4U94NvHQfB/ntVkwbRI8XEtHPKlIJkF8/3y2k85bEyXTQ2zy1IoMqjUSTnBskJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765225169; c=relaxed/simple;
	bh=wgMhRdNndt5ihz00iqNKaO5TlxeMFRbubpfs0Xmhzx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XhMCcubOmHX0aQjqHNsysdhf+JfWk0PCb8piz5hWZv3HviJ4hYOWFffb7YnDLYf4zibsDmLDglgIELVlQUjPwBKb11lKWDsSdj2E7u6Cmz4lucV7BpH8F5xy4R4k44gMbsSEFIaGrBu3P5AAJaN9I7ANdVolSgZev5QU5OluMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from wasted (213.87.153.35) by msexch01.omp.ru (10.188.4.12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 8 Dec
 2025 23:04:10 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	<linux-nfs@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 0/2] 
Date: Mon, 8 Dec 2025 23:03:35 +0300
Message-ID: <20251208200345.20414-1-s.shtylyov@omp.ru>
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

