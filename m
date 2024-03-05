Return-Path: <linux-nfs+bounces-2204-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB659871464
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 04:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1991B222FA
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 03:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9C38385;
	Tue,  5 Mar 2024 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tKCPENQm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719EC3EA9B
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 03:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709610168; cv=none; b=CHeiOAnH6PxHUvc8meRyq1ov0XHXp3AneQpl7xjm7K4D6I6J5xp7wIVYCxVbQmCwZO0r6nBLbjFGueQsl2Fvx2uJsyB0i9BDi124CaT0KkBvaw521G0Xtf2XdyeSG0+2rVJ5pWPCheuhlX8X1ygO9Uo2/+Dvs1ntWZdtkgaMfqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709610168; c=relaxed/simple;
	bh=iTPQFbJSvt5nh+OfTUz1Vd8tvV/g3WWOb3P3nB+esnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YLJMTZbpf/8Jv9dy8gny4398rfDB56x4U2jrTtK6a4WoDJvOikqwjWi5XyDpmAVMAbAgUvTaer+BchbI91OcXnk+6RDNt7RXHlqVdU9jT5KHoF2zCiL5E7bAe2R+GC0ucCPTbm0rCQ4UT0dqsnVdsX/8iIcJQnyg/wwxi/yd5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tKCPENQm; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709610167; x=1741146167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iTPQFbJSvt5nh+OfTUz1Vd8tvV/g3WWOb3P3nB+esnQ=;
  b=tKCPENQmMs0hzkkC1qMC9yf0yKX6HxSS9OqbhE5L7IDgNBdjyh0M+Cvl
   fz5MDCUwOJCX0+tOrYXZM2VBntkfHczBBXHus0sJI8WoUZ3Z3ZplLS9/6
   7Q5iidjDNx/VHjusfaih6BrahAh94b6qTMl9Kgl2jtBYp4BcGaXPafr+m
   NP/5LcLzUQ5Mtimkwk5I+VsAV51JXH3dF4D4rCqJGb1dPK1UPOBo0FGZ0
   E1n5SvbH1lTp+ScOC4XT8dNj3/uMJieAMquPUfLqNfiS2yglAe25Isrhh
   gJY17kR70FGw4NL/pPig+j5tJBB+LEaV39fJq4KL7bKr0K1mikDGve4NA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="150685329"
X-IronPort-AV: E=Sophos;i="6.06,205,1705330800"; 
   d="scan'208";a="150685329"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 12:41:34 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id B1D81CDB69
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 12:41:31 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E1B79C7263
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 12:41:30 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6625540FCC
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 12:41:30 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B2D9C1A006B;
	Tue,  5 Mar 2024 11:41:29 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: add a tracepoint for uniquifier of fscache
Date: Tue,  5 Mar 2024 11:41:22 +0800
Message-Id: <20240305034122.172-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28232.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28232.004
X-TMASE-Result: 10--1.097700-10.000000
X-TMASE-MatchedRID: a4Q7dosAlP5SuJfEWZSQfDllFsU0CXSPwTlc9CcHMZerwqxtE531VIpb
	wG9fIuITNscteyNb+fjZ+KWHmPMJheVHGbcDbAq6FEUknJ/kEl5jFT88f69nG/oLR4+zsDTt9xS
	3mVzWUuDxMZjMz3w2b8bsxHT46vhiDCMi4QPbLeUDkNY2zEPb+zRaKNHQGNBz5tje4EdcDjiTdi
	NUYOrn5ddcs1QDKsp+IqK74C65BpqoLqpKq8LGG8BgvHuudtHysNDybdOqCWh6WkJecb4mO8MYF
	nUbyvVJ/YPqDH/SjOk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Add a tracepoint to the mount fsc=xxx option

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfs/fs_context.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 853e8d609bb3..fd8813222cd2 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -652,6 +652,9 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		ctx->fscache_uniq = NULL;
 		break;
 	case Opt_fscache:
+		if (!param->string)
+			goto out_invalid_value;
+		trace_nfs_mount_assign(param->key, param->string);
 		ctx->options |= NFS_OPTION_FSCACHE;
 		kfree(ctx->fscache_uniq);
 		ctx->fscache_uniq = param->string;
-- 
2.39.1


