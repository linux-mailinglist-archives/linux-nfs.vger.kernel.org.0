Return-Path: <linux-nfs+bounces-2218-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A81B8732C3
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Mar 2024 10:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0430B21FB2
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Mar 2024 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE93A1EEE9;
	Wed,  6 Mar 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tp7gVJWL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688265EE7B
	for <linux-nfs@vger.kernel.org>; Wed,  6 Mar 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718045; cv=none; b=QgzExn3Vvga+IFdh2LdWgTtelO+6grhawgUvYc3A8buF0VRZ8DB5k05GqCgo57SSXZg7Z3r6/7LwiRWrVbqKCNj/xlK3ItO+G3YD7yXRUOlREj9oABL+zgCirehVvafQ72PPaR+MRR/SKtGeofhA1cN673t1Clq9073KQvs5QaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718045; c=relaxed/simple;
	bh=w+p9x6CmwdMGCJmm69YoKI9Ku/1jrBSw7soBg8rgcac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=scw7NvyPzFVK/Dzw5OJNzMeTfv8Lq1rQUVS1k7v/CUTONd4NjuBw/0YqjiYbGMZ2qEHQf0ZweHTqrQaoOu7nsWoMf78Q1kbfY4z5CutxieKzwRz7bYUvSxB1T1Y9hm7EvFwNdr1iSmNTf4IRx9zeJEtWkd42Dk6jkFH+eOIVFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tp7gVJWL; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709718043; x=1741254043;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w+p9x6CmwdMGCJmm69YoKI9Ku/1jrBSw7soBg8rgcac=;
  b=tp7gVJWLNJs5ZYfv4ZrEnWXjEYMGBFaFirFBsi4V3zAp1uo5chwXrPp8
   E2xtfDfl9lIZB7evvKOOhnOIkjwHFoDI6sUaqgY3jfw+XD8sP4SmKUIib
   TOUZ7kMs3oQkez4Xy49sA/X934WkeHWyIfIl9RIzI6Bgq2A8UpfWdjLG7
   Pw8JvqBe+kSg6GnT21lsytFwqemSKRNIMaeEbqwoBOVTBGdeQCgXaqPdX
   bqY/RRDcuODfdIR1HSev0YqqSZQEk12bxQpfxVKNchBWFFJz0lETSsDXz
   ZXudt056G4o5b2ws5FTeO5Nv4bsyi9do+hngp6icQN8C+8gvhwgE65uwg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="153202203"
X-IronPort-AV: E=Sophos;i="6.06,207,1705330800"; 
   d="scan'208";a="153202203"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 18:39:31 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A1603E9BA6
	for <linux-nfs@vger.kernel.org>; Wed,  6 Mar 2024 18:39:28 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E6501F658
	for <linux-nfs@vger.kernel.org>; Wed,  6 Mar 2024 18:39:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C0F841189
	for <linux-nfs@vger.kernel.org>; Wed,  6 Mar 2024 18:39:27 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C3BE11A006D;
	Wed,  6 Mar 2024 17:39:26 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: trace the uniquifier of fscache
Date: Wed,  6 Mar 2024 17:39:02 +0800
Message-Id: <20240306093902.220-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10--2.242600-10.000000
X-TMASE-MatchedRID: zIrlg0XZqis23LDAh/mSxUrOO5m0+0gEBGvINcfHqhfmWHHSYEnI8b8F
	Hrw7frluf146W0iUu2tU3a+owMO/avTPTYKNobBkngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
	Wy9W70AHfd+P6wwCt85Rncg/kBNofFJPUiNHDrjG4dnFmTLeMnCzKE0WNtifrOgJl/YKuJMRMH/
	ErkTGlbc+zeMtF+8FHc40Rdkzo8HcoRrvD1h5xpV8+5m37I8PKEWW0bEJOTAVAdUD6vW8Z1mZAM
	QMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Trace the mount option fsc=xxx.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v2:
   remove useless NULL check and update commit messages

 fs/nfs/fs_context.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 853e8d609bb3..d0a0956f8a13 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -652,6 +652,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		ctx->fscache_uniq = NULL;
 		break;
 	case Opt_fscache:
+		trace_nfs_mount_assign(param->key, param->string);
 		ctx->options |= NFS_OPTION_FSCACHE;
 		kfree(ctx->fscache_uniq);
 		ctx->fscache_uniq = param->string;
-- 
2.39.1


