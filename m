Return-Path: <linux-nfs+bounces-18691-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFWAOjcVg2nihQMAu9opvQ
	(envelope-from <linux-nfs+bounces-18691-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 10:45:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17FE4051
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 10:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D56330078AD
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D203B8BCD;
	Wed,  4 Feb 2026 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfNdAEEM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7E3B8BBA;
	Wed,  4 Feb 2026 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198317; cv=none; b=nMOsoVushry1Z9UUNIERcGy4wujStylgwhG13dQXnCZ8KAKBYC+eeLoBetwE1f1+RuQb+Ix+eNm3GYz/dOY4m6EbMWWQDikOZ411E8M4/5T6QPifeWgAc2Vk/5oxj8zO7TH1Hbzbm7CnlWrG2hpfHq6ojO825dRmVZTalfAP+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198317; c=relaxed/simple;
	bh=YrUQlyrHEX5MNyRLxbo3Ww4o9KuASOkuXaymD1/wJ98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCh1fvwS543yAG59AHOud0cwwOaZ/fxyx3btZb20ZvZ+Z85WfU615W4Ki1KVmVMoC1NpCh/qt26Kn68LN91SvqCJIaNTk+Tqlv9prKahjnpA69PuoephNkuhGNk/y87rkyP/MeK8GF/hlgGMpKJUESqn7U9pZeHWcgdy7NgDk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfNdAEEM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770198318; x=1801734318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YrUQlyrHEX5MNyRLxbo3Ww4o9KuASOkuXaymD1/wJ98=;
  b=nfNdAEEMn8ichNAvnGrf3j2Vl/Cl96AgRsT45SqmTOOMukBXyMtVbddT
   zPDh47EprxOwf1/XOB5ARhFnjsWwJ4eCdKHtuEsYfscMUUmB+mkxPuZt7
   JUg6p0RR9/mjkM9A7eGVBORBqSHOISzyjJ4Swk4U6BRG/VAXPr6A7N8rg
   ImCyPco8b7Qgtv65fA7xazM9zjqFA54G2LzkcVCjTwGy3BtBsmM8Y0QfR
   Wz00VxFwKdKaZovNdhyCmvAdPFW4y8810k6Z3xHiQm5FuR3E6hPJOPR+S
   DKMjMarApgBnN2rslAUh1EA4wUs9CFYT4I72EVK/9vsewmA+zKmr1SAGH
   w==;
X-CSE-ConnectionGUID: SVcFdlMlSr+MBz2OxwHqLA==
X-CSE-MsgGUID: fBszilsgQUqqCbWdVGWwCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71110501"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71110501"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:45:17 -0800
X-CSE-ConnectionGUID: zINygFoMTM+ROCfeM5ib3g==
X-CSE-MsgGUID: kaE1IdPVQPafwuOWu0sj+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214597138"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 04 Feb 2026 01:45:12 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1C4B49B; Wed, 04 Feb 2026 10:45:11 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/3] sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op
Date: Wed,  4 Feb 2026 10:41:23 +0100
Message-ID: <20260204094500.2443455-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com,linux.intel.com,glider.be];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18691-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs,lkml,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email,intel.com:dkim,glider.be:email]
X-Rspamd-Queue-Id: 8E17FE4051
X-Rspamd-Action: no action

Clang compiler is not happy about set but unused variables:

.../flexfilelayout/flexfilelayoutdev.c:56:9: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
.../flexfilelayout/flexfilelayout.c:1505:6: error: variable 'err' set but not used [-Werror,-Wunused-but-set-variable]
.../nfs4proc.c:9244:12: error: variable 'ptr' set but not used [-Werror,-Wunused-but-set-variable]

Fix these by forwarding parameters of dprintk() to no_printk().
The positive side-effect is a format-string checker enabled even for the cases
when dprintk() is no-op.

Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Fixes: fc931582c260 ("nfs41: create_session operation")
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/lockd/svclock.c           | 5 +++++
 include/linux/sunrpc/debug.h | 8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 712df1e025d8..dcd3e0b4d997 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -80,6 +80,11 @@ static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
 
 	return buf;
 }
+#else
+static inline const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
+{
+	return "???";
+}
 #endif
 
 /*
diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index e947d668f7b7..82239d5c262e 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -40,6 +40,8 @@ extern unsigned int		nlm_debug;
 do {									\
 	ifdebug(fac)							\
 		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
+	else								\
+		no_printk(fmt, ##__VA_ARGS__);				\
 } while (0)
 
 # define dfprintk_rcu(fac, fmt, ...)					\
@@ -48,13 +50,15 @@ do {									\
 		rcu_read_lock();					\
 		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
 		rcu_read_unlock();					\
+	} else {							\
+		no_printk(fmt, ##__VA_ARGS__);				\
 	}								\
 } while (0)
 
 #else
 # define ifdebug(fac)		if (0)
-# define dfprintk(fac, fmt, ...)	do {} while (0)
-# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
+# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
+# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 /*
-- 
2.50.1


