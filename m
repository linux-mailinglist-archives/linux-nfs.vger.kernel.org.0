Return-Path: <linux-nfs+bounces-16517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06D1C6C9D3
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A989C2C68C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5942ECD32;
	Wed, 19 Nov 2025 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="R7kSw0HY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSGCQGSQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB328C2DD
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523183; cv=none; b=WZBQ3gd1qj899GzHvkNKxhENGJZcYmniCQX6siu6g1CWnAOGZyJ6pbKdBfTQm/ocSclUVMPvrZw1xJgtPe+7oJIYm9JOWd4eUlAwvyUeQ48gmdNmsZyFHG8PX7MJmh4e9H4nE57qGEXAbNTBqMpBSGNulzDVvqEc7w8bgnNqhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523183; c=relaxed/simple;
	bh=bZsp3L5aUO42Gi1A/OJoCrgJqdCbytpM5e2v2ewki+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPUDIcT8FAdYKTjKvMThR4ojfEqh1N0Yw48WOXGj+aQMVWecbY+TjTIvekD8CnK3wR1egSB5WHhV5kn3a9GNJhAHID3zMXP94txYCeoCL/oFWrI6eZG438Tt0VT/yrE9bnXxy/AkVE0Zj1d5uPFxnxXPpbQkFMyCS9AXOtUVM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=R7kSw0HY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dSGCQGSQ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAC7D7A0110;
	Tue, 18 Nov 2025 22:33:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Nov 2025 22:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523180;
	 x=1763609580; bh=hk2OWJ8+5QCCb16sYjPqq1bRZBdrq2l3ODnGLsFmmDU=; b=
	R7kSw0HYtR6e6dKQndUh3CaRdlfZHgTGPCpLHOKSQdqaCw6YDkUtnD0YUpel5g41
	dRy+7CjQvX13qrkTl2G2OhW858Yt+iLyx0wgVNVQrb5DpzzfU9xxmrMovXJv5q0o
	/rHqccD6iHJTI3VXYwoykoJGt1UZKPMO7r0vSrycJOG0gjt6p5Gp1g2gl+sPqf1+
	Gf8picK8WLZgGZqrUqm2WzpOhird07gnPiNT0rZehRhMlApaLrmC5k/Qq9nbYq2m
	DWMJ40qsCO1ymZrnbGNX9xnNGy7mrcrGGUzgu7G8Jki3xIBZ80TaMJyOjG1QUA34
	N2fOPkfc5fJRhvQY+kMXAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523180; x=1763609580; bh=h
	k2OWJ8+5QCCb16sYjPqq1bRZBdrq2l3ODnGLsFmmDU=; b=dSGCQGSQ25aV8OgZJ
	VvwhYEolbHvHCHmhvihcI+z+xlLRE6/8JossK0NsJ0HMi1gGPBZBO+8utwvEsP5t
	EGDG8JAppkl9s8QH1sSO85hY2odoVNCShkFO3pAaQNXxZgsx2xhl6EIBjEG3kHPn
	hFGPgXRiiEtQg+mi0FL2JvHqdJHYSJlQmTLPzy90rn9T4AgaxdXh0DCbDkO7h4O+
	MHkgZdamDZ2X23esysvpGPzf3W0xKYVf8ENaMGfFC2ijgDsvNkeQcEnAH8IhqA5e
	aKRc6olBv5lE5g2we/Q8Z4S1cabHcLAZYhfA1fWNO/0DXzVJ6VyhnTN+uJ8OKEOz
	oHt5A==
X-ME-Sender: <xms:bDodaTfgmxQ2RhkLmTvN836H0UM9eTg5eUBs5BMF0s5pM-eUM-pPag>
    <xme:bDodac4i9S3OffZCRMxoerFTH6UsnvP-aJd6v-ZHzA28Z0jU7I3zHL42FXJ38sXx3
    yXpARNzGRb6Ao9Dauon50EUSZK69rnhmCnpChNzuwsbECpfRQ>
X-ME-Received: <xmr:bDodaWVAUNGiDY5G6B6oaRVcLWtO4yYJrAd1enYVXvKUVlwiTWKAevFBqdgiQY-c3VQXIjC0UDd4QWxqH3EPToKEg9HXnIPs2IgKKuir18IR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bDodab6YDxDE0_pVBAkADywe0i70eilsMBCs9NU-0EKPQDJSNSqU-Q>
    <xmx:bDodaRqMfNNJ13QObhzGWzgTbAuiIy9R6GPQqW4BtFOBb2dISHyXoQ>
    <xmx:bDodaekhDzUXUDxduUr4LsnhXyq1hSi3kWm2DWkxkY21Bx--gGdvOA>
    <xmx:bDodadM8vY56lCIOGE7vevWCJb0sDe9ZtwwTUa2Jgx6afQ_2WZO6Dg>
    <xmx:bDodaQ988uhdgOhUYWVwb0dO9i2NLrJEpNkZXfTBs0m92TcWbsGUYO7K>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:58 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 10/11] nfsd: discard current_stateid.h
Date: Wed, 19 Nov 2025 14:28:56 +1100
Message-ID: <20251119033204.360415-11-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251119033204.360415-1-neilb@ownmail.net>
References: <20251119033204.360415-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

current_stateid.h no longer contains anything useful.  So remove it.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/current_stateid.h | 8 --------
 fs/nfsd/nfs4proc.c        | 1 -
 fs/nfsd/nfs4state.c       | 1 -
 3 files changed, 10 deletions(-)
 delete mode 100644 fs/nfsd/current_stateid.h

diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
deleted file mode 100644
index 9dce3004b846..000000000000
--- a/fs/nfsd/current_stateid.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NFSD4_CURRENT_STATE_H
-#define _NFSD4_CURRENT_STATE_H
-
-#include "state.h"
-#include "xdr4.h"
-
-#endif   /* _NFSD4_CURRENT_STATE_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index eaa6a8c25ed6..0c980dfc5177 100644
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
index f01c72876ca9..7508158f5f8c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -50,7 +50,6 @@
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
-#include "current_stateid.h"
 
 #include "netns.h"
 #include "pnfs.h"
-- 
2.50.0.107.gf914562f5916.dirty


