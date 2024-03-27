Return-Path: <linux-nfs+bounces-2497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E59488E94C
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3D91C30C08
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E52613118F;
	Wed, 27 Mar 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="luoTbyRm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55E130E39
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553351; cv=none; b=KvGSwtNfeuN303bUhBtJtjAPSXBgtYNf6h34u9a7qSD2DWKgkyvQoKIX3IqlRN3nid2Y7q9LImaz8QTa5jj2tHQ3Xi4zAufEX6ASAO6iMKgAithk+IXIEqmQ7PxVbta5CIyG4g6tGsUyB9msOn6JussDBNY8t0n4M1IsMmB1tOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553351; c=relaxed/simple;
	bh=0UXy+KKsPYPoGOHTztAUDVzQQFtPRUZ6CRvg7azDiXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OCEEoiNHb0tmQIf9FP2rgbO3fS5zsJgco/dLggFjOF4JRzBhf1vQAiZGEZR2scHhsz73IVIfgjqbXTUwyo9YTk4+ZSPdQwsr3ecaNvoGWgwdp8Dj8d9DoFstCxje/MmndIeQTk5nQ33TUyto0881RwhzZ4/qVcgnekI+QJJAI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=luoTbyRm; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711553348; x=1743089348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0UXy+KKsPYPoGOHTztAUDVzQQFtPRUZ6CRvg7azDiXs=;
  b=luoTbyRmvY/K71AaE3qyVm4bzOl2uj3r0rW+4hJt9kP1zjDjfLzlTOs/
   bQjhP7LSBPGQ/vP/7PB9DSeC9/RrhgIZ/eb+1KWIrkPR928JrlMcR3k+n
   Y7/iwDT201DJ1uoegWadtGUhUsIcYP0b65nQayGCgEuuc73ZFIolVEHYQ
   Hu37feg/EM0V2byLuRTOajzUaS73SPVYdVQ9tQbySNHejG8a1Bs0fnt5Z
   7moV46exbt+F1HhEWmMJ1al+w3B8i54aoXgvifkgUYUAKmZS7sRN11nSL
   HBGMT4fIGiS/0EKW4o9ADL6TUxlxfUVda8jIezt85MDtCzVn6YhzYNXny
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="141524188"
X-IronPort-AV: E=Sophos;i="6.07,159,1708354800"; 
   d="scan'208";a="141524188"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:27:57 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B5BBD772B
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 00:27:55 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 736C7D506E
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 00:27:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D85752008FF93
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 00:27:53 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id EDE311A006C;
	Wed, 27 Mar 2024 23:27:52 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: trace export root filehandle event
Date: Wed, 27 Mar 2024 23:27:37 +0800
Message-Id: <20240327152737.1411-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28278.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28278.000
X-TMASE-Result: 10--2.938100-10.000000
X-TMASE-MatchedRID: hVaMx/vKxVQp3puUGg7rnLnHu4BcYSmtwTlc9CcHMZerwqxtE531VIPc
	XuILVCbaOAXtpFFfBP5p/U3tORb5kSJFbDWAdpZLL2JUO7sQ9/wYH39vFLryE0iOBKRPRuNqo8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtNiTbyWpVrSvqmiVaBUQw54NOhQtWwTDSSj1Qxa0PfN2+2z
	7H8fVzf4qTYu4PTjQkmuyXsFDB6HgvCqCJyFyzhchlZAAVDWEyFcG3+ZRETICP9kUX1Z+buE3Lu
	mkbQiNwVCqTSPu8tVR7AxIEOt4h2Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Add a tracepoint for obtaining root filehandle event

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfsd/export.c |  4 +---
 fs/nfsd/trace.h  | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 7b641095a665..690721ba42f3 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1027,15 +1027,13 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
 	}
 	inode = d_inode(path.dentry);
 
-	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
-		 name, path.dentry, clp->name,
-		 inode->i_sb->s_id, inode->i_ino);
 	exp = exp_parent(cd, clp, &path);
 	if (IS_ERR(exp)) {
 		err = PTR_ERR(exp);
 		goto out;
 	}
 
+	trace_nfsd_exp_rootfh(name, path.dentry, clp->name, inode, exp);
 	/*
 	 * fh must be initialized before calling fh_compose
 	 */
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 1cd2076210b1..a11b348f5d6d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -396,6 +396,45 @@ TRACE_EVENT(nfsd_export_update,
 	)
 );
 
+TRACE_EVENT(nfsd_exp_rootfh,
+	TP_PROTO(
+		const char *name,
+		const struct dentry *dentry,
+		const char *clp_name,
+		const struct inode *inode,
+		struct svc_export *exp
+		),
+	TP_ARGS(name, dentry, clp_name, inode, exp),
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(const void *, dentry)
+		__string(clp_name, clp_name)
+		__string(s_id, inode->i_sb->s_id)
+		__field(unsigned long, i_ino)
+		__array(unsigned char, uuid, 16)
+		__field(const void *, ex_uuid)
+	),
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->dentry = dentry;
+		__assign_str(clp_name, clp_name);
+		__assign_str(s_id, inode->i_sb->s_id);
+		__entry->i_ino = inode->i_ino;
+		__entry->ex_uuid = exp->ex_uuid;
+		if (exp->ex_uuid)
+			memcpy(__entry->uuid, exp->ex_uuid, 16);
+	),
+	TP_printk(
+		"path=%s dentry=%p domain=%s sid=%s/inode=%ld uuid=%s",
+		__get_str(name),
+		__entry->dentry,
+		__get_str(clp_name),
+		__get_str(s_id),
+		__entry->i_ino,
+		__entry->ex_uuid ? __print_hex_str(__entry->uuid, 16) : "NULL"
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_io_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
-- 
2.39.1


