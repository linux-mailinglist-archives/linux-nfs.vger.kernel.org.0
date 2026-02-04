Return-Path: <linux-nfs+bounces-18688-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HuKFFoWg2nihQMAu9opvQ
	(envelope-from <linux-nfs+bounces-18688-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 10:50:18 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF75AE4116
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 10:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6059C309E151
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CA3B8BB1;
	Wed,  4 Feb 2026 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIi3MIpf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197EE3B8BA6;
	Wed,  4 Feb 2026 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198317; cv=none; b=XOR6YB/ucUQlPB4uVvZQQ9DJHOZP2QPGXzfS41XCkg2bOQ7cB5CCVu6RAZjFoEvmWMv2YR6nrJ1XN8+pn4qBTaoRxVZBpHhmCYnJvMdoTHXnsbyqO3X9Cw6H1ccuNq7DyAa4rTRjohv9j7/PKwIzAtSCvTYdWYe+VTGaDbQyHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198317; c=relaxed/simple;
	bh=2e9s9fwPW3oN675uLAdbz6Qx4muyla7Q5cCEmFZSCqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMMUG6p6Y5hv3bNO5ewC8uI5JJ0jyCkxEqYpBbApf8TtsUP5UKeqQZsDoQr8sbQdskrXTMrRTwvsFgxWTWbpw5XwOBy8XApRzy5CdxF+CyM84PBBCHdyTlARAlp/t/QeUcLwlOkJUeNcr0GxRZrNPNnS+f6pXnLLlk60ymt4NxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIi3MIpf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770198317; x=1801734317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2e9s9fwPW3oN675uLAdbz6Qx4muyla7Q5cCEmFZSCqY=;
  b=gIi3MIpfw1tElGsgscxsD394wxft9gN1B9lqMyFz6tTMc/WiIfFQAHGk
   G0QmOg3f3jHKSqXQZ5upjb9XPwoIjUr/rsuNVzSwHBIHcJMXpTNFLvhnR
   2c/6jwsnpKGz47HzrDcykyLEcZa0VeBnUDt9JToSSoi3eHgN33ecp5zsx
   e/9M9UugQXvHu3vVOZ+I1P6QjaKNMjCYkQLz8pE8WVm1mbHs3T4hAVrje
   6L+4mv49/O9O7MHH36OrKtVCc0//a6SwZLPybcSYTbg4R2+t6BKxNnhlC
   rhkJgHkYGaa77cF3pmWO0N7xpDlHXaqDyaXJC537g/p2zyS8Y9UtYdNQS
   Q==;
X-CSE-ConnectionGUID: qX2/Fc/GSPGlBFN4ZTBGdw==
X-CSE-MsgGUID: APc6AromRMmpWIW0El0C/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71110482"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71110482"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:45:16 -0800
X-CSE-ConnectionGUID: a2SnfuewQrm27diOooRnXA==
X-CSE-MsgGUID: d4jwL7IhR9eToI60hx0RmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214597137"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 04 Feb 2026 01:45:12 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0F5B495; Wed, 04 Feb 2026 10:45:11 +0100 (CET)
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/3] sunrpc: Fix `make W=1` build issues
Date: Wed,  4 Feb 2026 10:41:20 +0100
Message-ID: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18688-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: EF75AE4116
X-Rspamd-Action: no action

Compiler is not happy about unused variables (especially when
dprintk() call is defined as no-op). Here is the series to
address the issues.

Changelog v2:
- added patch to kill RPC_IFDEBUG() macro (LKP, Geert)
- united separate patches in the series
- collected tags (Geert)

v1: 20260204010402.2149563-1-andriy.shevchenko@linux.intel.com
v1: 20260204010415.2149607-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (3):
  nfs/blocklayout: Fix compilation error (`make W=1`) in
    bl_write_pagelist()
  sunrpc: Kill RPC_IFDEBUG()
  sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op

 fs/lockd/svclock.c                       |  5 +++++
 fs/nfs/blocklayout/blocklayout.c         |  4 +---
 fs/nfsd/nfsfh.c                          |  9 +++++---
 include/linux/sunrpc/debug.h             | 10 +++++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 27 ++++++++++++------------
 5 files changed, 32 insertions(+), 23 deletions(-)

-- 
2.50.1


