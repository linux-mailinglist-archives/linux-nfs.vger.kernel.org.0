Return-Path: <linux-nfs+bounces-2517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7288904C4
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 17:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC14029833F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19912EBED;
	Thu, 28 Mar 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MR0XMUre"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC97912EBD6
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642643; cv=none; b=M6vcxvouIVEyf5oZaTwgZEXw/ApV8AHKf4pzc8iAx8K6R4WyDF5GiKtNyI8/qCRoq7dAsbJOiTacOexr4Cp+Fn/xRaC993EPDYh3HDC8Arn3KLfrAoJHwa3P6f5FiuKB2m8AqO+NO2AXW3z2NgFBrQ3UjsQw89dzPfhw6xqKuCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642643; c=relaxed/simple;
	bh=jkGW/15tS33hOhb5npPS+j971L13CjSKAZsa3HYuPXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SUZjKA4OpZ1knjZLDnc3Z1tZHkM55wd5t8QbN9m2svRkIDL53yChSaeEE9phi721oSNByzKnp65QrVa6W5kSKvJlhH1yw5Hj3WLrhCbdxmq5X87Y9dWEvNkm1cATb3PRGrr8cC43O3/sGHrz7O2vqMqpb1KUMOV/Hj4kr1CGqC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MR0XMUre; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711642640; x=1743178640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jkGW/15tS33hOhb5npPS+j971L13CjSKAZsa3HYuPXM=;
  b=MR0XMUretuauQzV0I+cQF0KfWS6htL9M3bg6y3VW6xnEknq0lfswFKuY
   XiT3cT7NbgvxSZmDI8tehMU6A+RQZVaDf3QfuNnfuA6Ze91FGSn0EnTF6
   TvBcJfOEWt7VD/jdinhEbu2bE5iHH4Tzb1HOtC3HZpJiZ8gyPd36fnwEW
   ibMjtAdotHWNl5IfYqO4PesuYq6oBysY1nxg+BPKUB9xt7709RSub5REp
   Qo1cOI1+9xOLMutUO93lBG5iMVtawVCl9qSuafs/IA526pTiL8ALREvXt
   X8TXpSnQ2waHGnL+QQGlo2QBkTmYd2gAZjQOAV4JbZaVs9HIefNejN21q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="142111997"
X-IronPort-AV: E=Sophos;i="6.07,162,1708354800"; 
   d="scan'208";a="142111997"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 01:17:11 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C833C6806
	for <linux-nfs@vger.kernel.org>; Fri, 29 Mar 2024 01:17:09 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 97CE8D561A
	for <linux-nfs@vger.kernel.org>; Fri, 29 Mar 2024 01:17:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C40320098E20
	for <linux-nfs@vger.kernel.org>; Fri, 29 Mar 2024 01:17:08 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1EC7B1A006C;
	Fri, 29 Mar 2024 00:17:07 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSD: trace export root filehandle event
Date: Fri, 29 Mar 2024 00:16:54 +0800
Message-Id: <20240328161654.1432-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28280.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28280.000
X-TMASE-Result: 10--2.210900-10.000000
X-TMASE-MatchedRID: hWRIiYV8xz8p3puUGg7rnBIRh9wkXSlFCZa9cSpBObnAuQ0xDMaXkH4q
	tYI9sRE/4K9FmervsqVeww0n8USeIRzIu43df0mMQuFiD+xrWCxYL/tox9XQkUPRcdZ0KZk8ZYj
	faKkAhGDi8zVgXoAltsIJ+4gwXrEtJ0RPnyOnrZJIPLhojlvhsy+sq1/5FvBlHCOACUaSygaMAU
	9xte8a5fWRD6p/GdzaBDvqOZso5fuI93uu7D0aWicys52uVWnUkdfkAYWIS1PAYLx7rnbR8rDQ8
	m3TqgloelpCXnG+JjvDGBZ1G8r1Sf2D6gx/0ozp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Add a tracepoint for obtaining root filehandle event

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v2:
	remove dentry address record
	add netns inum entry
	trace ex_flags

 fs/nfsd/export.c |  4 +---
 fs/nfsd/trace.h  | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 7b641095a665..63acd1564eab 100644
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
 
+	trace_nfsd_exp_rootfh(net, name, clp->name, inode, exp);
 	/*
 	 * fh must be initialized before calling fh_compose
 	 */
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 1cd2076210b1..adac651e398d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -396,6 +396,47 @@ TRACE_EVENT(nfsd_export_update,
 	)
 );
 
+TRACE_EVENT(nfsd_exp_rootfh,
+	TP_PROTO(
+		const struct net *net,
+		const char *name,
+		const char *clp_name,
+		const struct inode *inode,
+		const struct svc_export *exp
+		),
+	TP_ARGS(net, name, clp_name, inode, exp),
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(unsigned int, netns_ino)
+		__string(clp_name, clp_name)
+		__string(s_id, inode->i_sb->s_id)
+		__field(unsigned long, i_ino)
+		__array(unsigned char, uuid, EX_UUID_LEN)
+		__field(int, ex_flags)
+		__field(const void *, ex_uuid)
+	),
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->netns_ino = net->ns.inum;
+		__assign_str(clp_name, clp_name);
+		__assign_str(s_id, inode->i_sb->s_id);
+		__entry->i_ino = inode->i_ino;
+		__entry->ex_flags = exp->ex_flags;
+		__entry->ex_uuid = exp->ex_uuid;
+		if (exp->ex_uuid)
+			memcpy(__entry->uuid, exp->ex_uuid, EX_UUID_LEN);
+	),
+	TP_printk(
+		"path=%s domain=%s sid=%s/inode=%ld ex_flags=%d ex_uuid=%s",
+		__get_str(name),
+		__get_str(clp_name),
+		__get_str(s_id),
+		__entry->i_ino,
+		__entry->ex_flags,
+		__entry->ex_uuid ? __print_hex_str(__entry->uuid, EX_UUID_LEN) : "NULL"
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_io_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
-- 
2.39.1


