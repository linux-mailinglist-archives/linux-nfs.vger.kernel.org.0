Return-Path: <linux-nfs+bounces-16338-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C5BC56480
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 09:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B655D343885
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA53314C0;
	Thu, 13 Nov 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3gRu1uD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2433122B;
	Thu, 13 Nov 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022701; cv=none; b=ASzsj34cefWxH3Xl340VASNrhUwvYQi/mYBUSAUbirUfHaGCkPfVOX2+l0jyFPhQGpZ97f8JWHZpa30cix8/klxGiFKDHcnZjUnSGIYjbXEuNlNsvLtF78yfrry/AJ2oHiq1/HkUoJc2OSKFLcQT0RsYWzQ1ZR95E+8wF83U9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022701; c=relaxed/simple;
	bh=sh8tPaxzbCRkZTn+mAAnWLRNuBS0xq2IFZWa/aEhdy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxqdfvtKQyz/Hr7amEDLJLoWHl7COxQTtOjmxQgFMqolRxEYq0mYimD5tNmN88LITiw8jwU/PM3RcSK9O9fx3kfTIFmgk9znlha0YB9jBJvfZYbBgPgKe70xwtIkuJpiBGBicJMggkZvIxv7e4XX7+vGAm79xmyBz53FbIx8WYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3gRu1uD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763022699; x=1794558699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sh8tPaxzbCRkZTn+mAAnWLRNuBS0xq2IFZWa/aEhdy0=;
  b=U3gRu1uDcklcJRZM743/HpVsrd2yJCK73LKTbgyZXBKrcqn558QL9FHB
   ffqJeI1iBchIcAlxGdVMMUkUvi49g/Cxb/p4GijOk88fUxsgIsN3Fzvfq
   HdOkLMkdJgcXSHlrZwJvE2gFdFjMRNhdvihervLl5TNZpzdnpJw+82ekf
   Uh8PS4O28rWRffNWfsEE6WuGFsSqDTaNJwS6jBwKnYWa4GCBBYIA43E+t
   z5iLE3U7X0C4UPVsRF1pcugv6hYt5rFHLBL0lsrznv2nqh5gXlOI5Tmde
   6BpaztrofKBGYU0zE0Jr6JyzW+BgXzfsNfPSZZE5oJ6bdi9z3otzA8BmK
   g==;
X-CSE-ConnectionGUID: YIxQ1bYZQ3uEEPDVLrgthg==
X-CSE-MsgGUID: G18EiflaQkCunIW0hybPrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="65190943"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="65190943"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 00:31:38 -0800
X-CSE-ConnectionGUID: HDAOUDW5Tn61WcLFiA0Yxg==
X-CSE-MsgGUID: LRVIW+Y4QreOBP+f6axuRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189101167"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 13 Nov 2025 00:31:36 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9E5E595; Thu, 13 Nov 2025 09:31:34 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] nfsd: Mark variable __maybe_unused to avoid W=1 build break
Date: Thu, 13 Nov 2025 09:31:31 +0100
Message-ID: <20251113083131.2239677-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang is not happy about set but (in some cases) unused variable:

fs/nfsd/export.c:1027:17: error: variable 'inode' set but not used [-Werror,-Wunused-but-set-variable]

since it's used as a parameter to dprintk() which might be configured
a no-op. To avoid uglifying code with the specific ifdeffery just mark
the variable __maybe_unused.

The commit [1], which introduced this behaviour, is quite old and hence
the Fixes tag points to the first of Git era.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=0431923fb7a1 [1]
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/nfsd/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 9d55512d0cc9..2a1499f2ad19 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1024,7 +1024,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
 {
 	struct svc_export	*exp;
 	struct path		path;
-	struct inode		*inode;
+	struct inode		*inode __maybe_unused;
 	struct svc_fh		fh;
 	int			err;
 	struct nfsd_net		*nn = net_generic(net, nfsd_net_id);
-- 
2.50.1


