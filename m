Return-Path: <linux-nfs+bounces-2718-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4113189C7D7
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2078BB26721
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958241C6C;
	Mon,  8 Apr 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="d7KG8dE9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585413F425
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588822; cv=none; b=gBMvYfx3X00/RbN3BNGwUAieA2pqh26U2qpD4A9cb7jZYeQeeWG8S5/a+HKnb3pQtnoj27qbr169fBEXRctOq7hQjvR22nFvZyFNcW9ET3TjkUQqKz1Q4MwPuIXY5jWHclj1QBMQLKojhjCh+zfCJodSYbgO1hP9Dx9QpX+logc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588822; c=relaxed/simple;
	bh=H4iPozBvCcFnXOLRK7iwL7F2RXwMh+vZ6f/UNWLh85Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MbW6GGTx1li+6paa6OEZ6e5FY4YEnVnchH7mFv+VcQPiux/NQxNHd4zpABQSzZqTPm3kHyto3lIqtCXxJdviiz8q6Q4b+Mx7GoofozYZudin54c85ToKTyUkKy5iay6h/pg60xe5zS/vq15CqcuWCY4Wyr3v3tPaOIgdeU279IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=d7KG8dE9; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712588819; x=1744124819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H4iPozBvCcFnXOLRK7iwL7F2RXwMh+vZ6f/UNWLh85Q=;
  b=d7KG8dE9Y176U6gaQOKSF+gdfhDsXuziMMGUXFx3Pt/B6shsF6u9KH4H
   8w3iQ+zzz11psuaRbZyoJTDwvT7Qp67BLt54uwBCv7apIdxIkrirdJQgf
   3dGm1JmfzBYeQUdcqeF25Z07iHZkzmy0Rg3QjoScJntZr2gtQc1Z1yyJb
   cbpWsyUqZI45mtcDkoVtJJYdEsHtCrMYrSYdDedHkJV1un51OpfQ8kloA
   nrRuY93JrZAsW9PhHqc1vsyOpycdrNDvQLE9DdqP7dpM0+o5KShJQpt5h
   7Ke3nY5yd57LeAY0LTrXKAuNfqfVfAVC7cH5ZNQOonp9XxTE2L70Cuk1z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="142545721"
X-IronPort-AV: E=Sophos;i="6.07,187,1708354800"; 
   d="scan'208";a="142545721"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 00:06:50 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D0DECB001D
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 00:06:47 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0956CE4AC5
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 00:06:47 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7C53A20097AF3
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 00:06:46 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 81EC61A000B;
	Mon,  8 Apr 2024 23:06:45 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: remove redundant dprintk in exp_rootfh
Date: Mon,  8 Apr 2024 23:06:36 +0800
Message-Id: <20240408150636.417-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28306.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28306.000
X-TMASE-Result: 10-1.029400-10.000000
X-TMASE-MatchedRID: OdGOxzKcwDQqr12s6iu4vDz10wykBXFMMVx/3ZYby7/AuQ0xDMaXkH4q
	tYI9sRE/4K9FmervsqVeww0n8USeIZcFdomgH0lnFEUknJ/kEl5jFT88f69nG/oLR4+zsDTtjoc
	zmuoPCq2Z07TQaE1TCAPeD5CRSBJHBbKJun1yoeH+k36lANi19WZNVl14z92jBQtggn717XanVF
	5RMST1yKqv2eL1k8dQdK8BAZWZQ0IVwbf5lERMgI/2RRfVn5u4Tcu6aRtCI3BUKpNI+7y1VHsDE
	gQ63iHZ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

trace_nfsd_ctl_filehandle in write_filehandle has
some similar infos.

write_filehandle is the only caller of exp_rootfh,
so just remove the dprintk parts.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfsd/export.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 7b641095a665..e7acd820758d 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1027,9 +1027,6 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
 	}
 	inode = d_inode(path.dentry);
 
-	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
-		 name, path.dentry, clp->name,
-		 inode->i_sb->s_id, inode->i_ino);
 	exp = exp_parent(cd, clp, &path);
 	if (IS_ERR(exp)) {
 		err = PTR_ERR(exp);
-- 
2.39.1


