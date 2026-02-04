Return-Path: <linux-nfs+bounces-18726-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PCyCSOrg2lvsgMAu9opvQ
	(envelope-from <linux-nfs+bounces-18726-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 21:25:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB130EC6E4
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 21:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A42F301F4A2
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6724242DFF3;
	Wed,  4 Feb 2026 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjXKHvni"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095B42B75C;
	Wed,  4 Feb 2026 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236690; cv=none; b=GCrU8okzBgESePtCJt/GPUlwP7GY1Db1+ueR1sQ1xlDc/1Luae29Swdk2HpDVsvKgSQOfrgH5Gr+NQlzB8Q5BfQbiJOvuebBHTt++R3Qp0cMYPUYzxh8RsZ94wzgviqWgGB9k4y2K1Wu9xrPqXdvG6y/qnvTb8EXnqhPIHWtl5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236690; c=relaxed/simple;
	bh=klIpozQMkLc7s5yVg1iFiQSRxFidEGW6c7R0cBcAX10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgX3kAPftGUFSkKk4ih/YYrb+vp+S1U5AFSR9ZnCB13/feRSTVtddmKD1LBzCpWjXWeRL88LvjVWAey6UfXxqq/NSPHnVFnmyzv7Pi+i+lbZzJ4ge//RwXkuPWbFY8WWrgBL9OVyMgen8FXAjItXBP0sK+8fu0Ek+RVGzNhJEbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjXKHvni; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770236690; x=1801772690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=klIpozQMkLc7s5yVg1iFiQSRxFidEGW6c7R0cBcAX10=;
  b=kjXKHvniL1wc23jDUOGdO7Wo2g7sc4VQYNejTuo2p8XAkdQ1MLF8zCHH
   mmX8Tp/sziEyIKpW9hEDaamuQDLO1B+vFRC7Zix4LlIEk6dsBP8IZKio4
   z0e+dHU0prpPwVa4D0Xo6BM8b5adFEaVvNm4LfewaKQ3mun2bkIjuC14z
   r6x9V0d2l/1GKp/q/oiRO8ZNqj7JJ/3Rq1zE/HncJDZwljvYMm5qMr6AQ
   tRpdwEiHE1NCr5vwL234bTYDjiemtD9xgMxQdfhTgPK5FkVR8+7wS+yTT
   ECy9S7+0VQeZ+KbWQJ/mcxZIDglY0Bu/sBOlJ7fczvonyHD8rQP11oY/d
   g==;
X-CSE-ConnectionGUID: w7qQE0F1ScKuz2MfAJVqoA==
X-CSE-MsgGUID: o5Y2oh9JRFKb1WIdg6ziLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71335500"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="71335500"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 12:24:49 -0800
X-CSE-ConnectionGUID: d9oNWrkQTZurP4dKMVyg7w==
X-CSE-MsgGUID: xTnETfOyQh2hMBb9gRz16Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="210051958"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 04 Feb 2026 12:24:45 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 81E6099; Wed, 04 Feb 2026 21:24:43 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/3] sunrpc: Kill RPC_IFDEBUG()
Date: Wed,  4 Feb 2026 21:21:50 +0100
Message-ID: <20260204202437.2762161-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204202437.2762161-1-andriy.shevchenko@linux.intel.com>
References: <20260204202437.2762161-1-andriy.shevchenko@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,gmail.com,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18726-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: AB130EC6E4
X-Rspamd-Action: no action

RPC_IFDEBUG() is used in only two places. In one the user of
the definition is guarded by ifdeffery, in the second one
it's implied due to dprintk() usage. Kill the macro and move
the ifdeffery to the regular condition with the variable defined
inside, while in the second case add the same conditional and
move the respective code there.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/nfsd/nfsfh.c                          |  9 +++++---
 include/linux/sunrpc/debug.h             |  2 --
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 27 ++++++++++++------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..68b629fbaaeb 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -105,9 +105,12 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 {
 	/* Check if the request originated from a secure port. */
 	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
-		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
-		dprintk("nfsd: request from insecure port %s!\n",
-		        svc_print_addr(rqstp, buf, sizeof(buf)));
+		if (IS_ENABLED(CONFIG_SUNRPC_DEBUG)) {
+			char buf[RPC_MAX_ADDRBUFLEN];
+
+			dprintk("nfsd: request from insecure port %s!\n",
+			        svc_print_addr(rqstp, buf, sizeof(buf)));
+		}
 		return nfserr_perm;
 	}
 
diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index 891f6173c951..e947d668f7b7 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -51,12 +51,10 @@ do {									\
 	}								\
 } while (0)
 
-# define RPC_IFDEBUG(x)		x
 #else
 # define ifdebug(fac)		if (0)
 # define dfprintk(fac, fmt, ...)	do {} while (0)
 # define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
-# define RPC_IFDEBUG(x)
 #endif
 
 /*
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 9b623849723e..f2d72181a6fe 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -414,7 +414,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	struct ib_qp_init_attr qp_attr;
 	struct ib_device *dev;
 	int ret = 0;
-	RPC_IFDEBUG(struct sockaddr *sap);
 
 	listen_rdma = container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	clear_bit(XPT_CONN, &xprt->xpt_flags);
@@ -560,18 +559,20 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		goto errout;
 	}
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-	dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
-	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
-	dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
-	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
-	dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
-	dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
-	dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
-	dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
-	dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
-	dprintk("    ord             : %d\n", conn_param.initiator_depth);
-#endif
+	if (IS_ENABLED(CONFIG_SUNRPC_DEBUG)) {
+		struct sockaddr *sap;
+
+		dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
+		sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
+		dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
+		sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
+		dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
+		dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
+		dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
+		dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
+		dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
+		dprintk("    ord             : %d\n", conn_param.initiator_depth);
+	}
 
 	return &newxprt->sc_xprt;
 
-- 
2.50.1


