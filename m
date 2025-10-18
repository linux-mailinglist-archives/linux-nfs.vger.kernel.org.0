Return-Path: <linux-nfs+bounces-15356-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1524DBEC151
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CE1408788
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73C2F5E;
	Sat, 18 Oct 2025 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LXoqXDr0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o58hNEW8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6028F49
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745993; cv=none; b=SniFXH/J+kpoiWC/oPd9sCIQR55pMPqgrnyUl24XV8hrkbNbvG8cVPGTeCr9aRfSF+zTtew9gHKvs0IOlj7la5o8pr/WX5d5R8ngPtOkXQZx582BhsvchjSwlgWcARPW7VjqebTssiJR/KxbVypSXwTyE8q4VBGK2O7eFnzMPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745993; c=relaxed/simple;
	bh=415s1OiFNPTFWnXkd/Nl44lrKBRZJycKznk+8FNN1FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0ZlWSYJoCKHO8DEqAXxaQkYh+NHAqPBy6MT9UsbweuskpvCnD8CNFVBTvgQpiMz6Ukc71V+ZNCRolEP+klqScECQQLX2t68cADmNg+V/3Q0T/3EgaITai4dbhQIVI1H3JEruizlpcB3eqCaep1e6UjgR44RXGen1VvLvcYqqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LXoqXDr0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o58hNEW8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DEA921D000EC;
	Fri, 17 Oct 2025 20:06:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 17 Oct 2025 20:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760745990;
	 x=1760832390; bh=D5gErs3S9cT1gcUhY78GgQoeNXqOC7WTWbyfqKB/ylY=; b=
	LXoqXDr0NO1/hf2Ywb7BbCb24MoZ6hx26GMPaX5kGdwG7PRUxvZLuzf5AD4a01WT
	DLfdgbaUsbWXBuUKMuGD8LpADlyECAPtLizf8qs0pwJqmpOVBmAcH9pJ8kiu3hwz
	f4HJd9xm7cnSI2juZnBMfsPRF7aW4yC4xeys0QXdfhgE3Mc2da+SdMIj+OU8KU1y
	StwMUBE79Eaba8htMG2eFpmeC9rKh4+UiAclh7oYQQk+Gq72eRUAu+AwixgWuG+0
	/rl8S61uMi/QyMHxNjdCWXU/+LLdCt/8bNc9/7l82kJCc0zw/oMm0q5nk/xbeZQ2
	bmXPebLrGn/GlnSlO9zNLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760745990; x=1760832390; bh=D
	5gErs3S9cT1gcUhY78GgQoeNXqOC7WTWbyfqKB/ylY=; b=o58hNEW84vWoyr4lB
	qfM0X3FS541PuNEnf4AhK5+b/2tWeTp58MkBEaV5R81BF4ILdzwrEhLMr3E/sBEv
	QAeMdm7zMY8QSAraWxXkZaHHkPFUmoeMMQryn2sVUd+P4PcBDy4Xb6C0JiSyLO3e
	4+gRA9iBvUmiGU8qdnjGWPlPJ1DqpHZ0MqTxicASP8MxSbDld4gCT1bKkcZ/mXwP
	sShmHed9wW3PpsKCvABg1A6wjyEiFxIObqmuFm2P1IuBxg5rTKmMKQQO+i57kssE
	tFFIcY8kDubc+ZxyLcmxcmu6yZZ1Rmx7B9vBvYisMVSo90c6jDQfokffaUvT75fe
	XPUQA==
X-ME-Sender: <xms:BtryaBNU_yMAyFMsXA5DHyRmIGCM_AmbT7wDx8KVW8O3buum10pWTw>
    <xme:BtryaHofNawBpOdJV2TgTwFX0KGF6rUEJFkxnOXw3lZIzRgpOCpwVvmvcEhmmlMwu
    Mx2cD0GzJ_xr59ShcarT4Rzo-1asgdFaCQuKk0JxYi3J04bnw>
X-ME-Received: <xmr:BtryaKFdISbyJ3c4Qo4UP9KsE-pKWDrfA1nw0h9wrZiqlM_05kKfkOVClC5arihRrDonW0tgXBCYAfHcj15XmYrWx8yJyvOo6Lc0auFf5rNO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BtryaErzrAio5Xx-xs9OlpHjxLx3nl2v3CeIXrsUHsVCXS2fU00UoA>
    <xmx:BtryaLbh5e6SPx3f_ssnQpFlfo78ucg8Jjm3lenlF1ZdM9fBhSC0xw>
    <xmx:BtryaFW9ordLllfhz4cyOZMhZdQ5-wx7_KD4aqUNoIW0A4L3gc6_9w>
    <xmx:BtryaM9xybS3uFzFiwhUVlUELFtnjFNWusiL5S_HELnkypZzVLUxrQ>
    <xmx:BtryaOvaXrYSiaBx5uv2BdUbNOjxxxIY5AXUdff585wOgTg8ZQpjNslW>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 20:06:28 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 6/7] nfsd: discard current_stateid.h
Date: Sat, 18 Oct 2025 11:02:26 +1100
Message-ID: <20251018000553.3256253-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251018000553.3256253-1-neilb@ownmail.net>
References: <20251018000553.3256253-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

current_stateid.h no longer has enough content to justify its
existence.  So remove it and incorporate the content into xdr4.h.

clear_current_stateid() is moved to xdr4.h and made static-inline.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h | 12 ------------
 fs/nfsd/nfs4proc.c        |  1 -
 fs/nfsd/nfs4state.c       |  7 -------
 fs/nfsd/xdr4.h            |  8 ++++++++
 4 files changed, 8 insertions(+), 20 deletions(-)
 delete mode 100644 fs/nfsd/current_stateid.h

diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
deleted file mode 100644
index 8eb0f689b3e3..000000000000
--- a/fs/nfsd/current_stateid.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NFSD4_CURRENT_STATE_H
-#define _NFSD4_CURRENT_STATE_H
-
-#include "state.h"
-#include "xdr4.h"
-
-void clear_current_stateid(struct nfsd4_compound_state *cstate);
-void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
-void put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
-
-#endif   /* _NFSD4_CURRENT_STATE_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7b6a40cf8afd..bb432b5b63ac 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -46,7 +46,6 @@
 #include "cache.h"
 #include "xdr4.h"
 #include "vfs.h"
-#include "current_stateid.h"
 #include "netns.h"
 #include "acl.h"
 #include "pnfs.h"
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dbf5300c8baa..635c7560172c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -50,7 +50,6 @@
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
-#include "current_stateid.h"
 
 #include "netns.h"
 #include "pnfs.h"
@@ -9093,12 +9092,6 @@ put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
 	cstate->have_current_stateid = true;
 }
 
-void
-clear_current_stateid(struct nfsd4_compound_state *cstate)
-{
-	cstate->have_current_stateid = false;
-}
-
 /**
  * nfsd4_vet_deleg_time - vet and set the timespec for a delegated timestamp update
  * @req: timestamp from the client
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 7218c503e5fe..76b828a50ece 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -196,6 +196,14 @@ static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
 	return cs->slot != NULL;
 }
 
+void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
+void put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
+static inline void
+clear_current_stateid(struct nfsd4_compound_state *cstate)
+{
+	cstate->have_current_stateid = false;
+}
+
 struct nfsd4_change_info {
 	u32		atomic;
 	u64		before_change;
-- 
2.50.0.107.gf914562f5916.dirty


