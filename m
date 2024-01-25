Return-Path: <linux-nfs+bounces-1331-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0829583B93F
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 06:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07E21F24DC8
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 05:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B78F7489;
	Thu, 25 Jan 2024 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GeW1EcPe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4410A09
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162058; cv=none; b=aag+E06DMVBVtmBNE7Lg3vo5uH8ld2f7eOECFPsziNo8kCETAkgnlP24BhFOghK+kWou33ku9jGuKy4xVwWdEDTvpJkqkWFOxtSi7C92H0CL6obezWYUUyAdMqo3dqKqy49OkDPXbTPPqTq99FWHqfgLgd1NqwHCfnOU9/TsXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162058; c=relaxed/simple;
	bh=e70DRkG8/1kKVFHks7oN8zjkvEr/0a9tCRNy0qwtjIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pDKXaaAp3qKTJsWao8WJ1kZ0nIaDgOBLAyhhGT10Tt5C92AZJMlewsQAIkLJqSeB99TBhH7evfCCOLgAcSLYxL1LUnB0ZjHSimF+D48WbNYUc2jT1nhVhIfiuQLof5cqGQnzWVKwHky5XagasU4UpRbEZwKOmdwRAEMTw9b8Tgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GeW1EcPe; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706162055; x=1737698055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e70DRkG8/1kKVFHks7oN8zjkvEr/0a9tCRNy0qwtjIA=;
  b=GeW1EcPeqnCG2krp4gdwWpxXE163xpq99tl56AQsRsDph4eTfQ4hyd6/
   YaCVs3fOzGwh2JhyTHiRAlvGDKvSgClXMaFnpy+RjSf+z/4LC1w2Ht6RB
   Q5MCgbUTcO4YAHlO9Eevtex/AB1EoJhsCQNxJFWoUjQHgzn8uTFkweIjk
   dmnrHoawvXnROx9Jol5Or5EbQKW4xxIaPLc/sqpJbdECQXOiwTOp8tKuW
   US/rXPmqwDnOjCK2X0ODpOiY9NH6+n+XzwQQToINr+DGhGWIrxeRQJKh5
   t3vUbOQL4k/UBuJA/TAXWD6nW7al4oRcfMrweZV1EPvSxtq7jy/eWpj7F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="126615742"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; 
   d="scan'208";a="126615742"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 14:53:03 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A096EDC146
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 14:53:01 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D5FC9D5D6D
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 14:53:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 63BB1E5E65
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 14:53:00 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id AC9C91A006A;
	Thu, 25 Jan 2024 13:52:59 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Display the "fsc=" mount option if it is set
Date: Thu, 25 Jan 2024 13:52:42 +0800
Message-Id: <20240125055242.691-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28140.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28140.005
X-TMASE-Result: 10--0.447700-10.000000
X-TMASE-MatchedRID: Ja7Gtx6NRnyHfxuc8sSk8fCCu8kVj0TRwTlc9CcHMZerwqxtE531VNnf
	JrUSEbFDEdVo3LYPj3WAMuqetGVetk6N1CbkSyKE3QfwsVk0UbvqwGfCk7KUszS+MhrWpApFrwN
	WVJP/b0PESXnMROiZ8gQbatn8g2Fejc+ZRokDJrYXOyMiobl16V8UsGCr+l4f/EDVMNax8XmS67
	2T/cgWUiHJp2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

With this patch, mount command will show fsc=xxx if set:

If -o fsc=6666
clientaddr=192.168.122.208,fsc=6666,local_lock=none

If only -o fsc
clientaddr=192.168.122.208,fsc,local_lock=none

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfs/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 075b31c93f87..dc03f98f7616 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -516,8 +516,16 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	else
 		nfs_show_nfsv4_options(m, nfss, showdefaults);
 
-	if (nfss->options & NFS_OPTION_FSCACHE)
+	if (nfss->options & NFS_OPTION_FSCACHE) {
+#ifdef CONFIG_NFS_FSCACHE
+		if (nfss->fscache_uniq)
+			seq_printf(m, ",fsc=%s", nfss->fscache_uniq);
+		else
+			seq_puts(m, ",fsc");
+#else
 		seq_puts(m, ",fsc");
+#endif
+	}
 
 	if (nfss->options & NFS_OPTION_MIGRATION)
 		seq_puts(m, ",migration");
-- 
2.39.1


