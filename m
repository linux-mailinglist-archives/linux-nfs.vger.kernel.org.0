Return-Path: <linux-nfs+bounces-16662-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54BEC7C0A9
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DB23A6F0F
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88EB239E9B;
	Sat, 22 Nov 2025 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="g4senwF/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIab3iNW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF823D2AB
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772824; cv=none; b=RaVLw8zR7J6T5ov/tqbBNpGL8WMMdcOaRyQZ841Dtd1Tq+R5FaSSRqLEPax0ikfC4tu+xG/uqZSGcxM9KylFNgryPllaMg63Th6HZpxvyZJO8pIQ9+UrY3FjXzRBq5YYVDwRWm0FPHpcsMqHZ5ZGhpoVcEp4ky8vY55+p0vpwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772824; c=relaxed/simple;
	bh=bk+VpdS+xmZ6lYC44vRVAC5n4b8zdEOD7p9nDo0lUL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRUoTaB8ImQ/d2KdilOl4vxBeKbs80BlFyB7GsB/52IWDSjLtHfuunYD7V67mj0DMz2EzmoG9ObC/2TexEWtlYS6sGnVAunxz/EiMxG8zCRA3AvbHC48gyQ12nfhbU4325Q5Fmsa+kCjnox9M2Ff95TbdgRXUvsTTVwm1w2XorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=g4senwF/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uIab3iNW; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 44087EC037A;
	Fri, 21 Nov 2025 19:53:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 19:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772822;
	 x=1763859222; bh=N+rwtp/5IcN4XGexzABfQtbggikJBRc8kebpxVtc85E=; b=
	g4senwF/E3VkdQlfyYc0iXytV46UXgCE2N/L9Ia3zfXIZqTihfQS3c1N8lsYf2rc
	GPZ7oOIQ/MoQ1tw7r61mX1VaYNXHnMRseNd1Wgg5NqTBE49WGDEu//ScvAAFilS3
	4OsdbGJqe3UldnAzeErdQRfdsi6e0RDxIkWfiWR6t0KQtLOeuYPFQk8wbEIHzkeS
	2Kh/K2V8yXNZipGalfd+Iw2g1xBeDcosz4nyPzjlBI95l6IbvICPt6A14znvR6LV
	azOOpuxBFuRuQ/kzXFXxrxnZHGfALowj0paSoK0RgUjuQ/9qvUuCp/1UX2y6MX3m
	SUTq0CojaUVE7ihTN08Ltg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772822; x=1763859222; bh=N
	+rwtp/5IcN4XGexzABfQtbggikJBRc8kebpxVtc85E=; b=uIab3iNWevygtBDxg
	TX/qJVd1z2qbKrNRAQv7z/smRCU8Ff3Fg7nu7VvFpTehM1RrOvDYySO/Kny8khQu
	9iKzYOlYQtabehTMiU+44gsFyCBPa9aUJtbpkWtfarwaYPuUewFU0nWXxwSVR5Gp
	C4tNwLAgWbDNb7OgUDRtjZzgpJksUm7ti0xbwOT+gRcYr+PQ6ui5LysaHQ0kG0Ez
	GTxZ5S8vCbaEQCJVKPl/rLVLNMy08d7KjO9sW+nllN9mOCd+pmo94zLLnU10FsZn
	4B5ebjhK0g6AJbVL1htvbwR5LELSJ/830DF6xFrKKiP+czG+iUXzsG6MI4PpD+3T
	aKMMw==
X-ME-Sender: <xms:lQkhafZlPn_m6OFNqO32Xot1VFN1mn-sZO5KeN9M-KDvn8Ggw8Wz4w>
    <xme:lQkhaSGvZYca67iz4wm7pxLqsUb8XrkDDAvys88nhFSAOPTfqxLFL_SSkWSuZUSfC
    cbjDnpoI8AC4ED_hDJzitwIu9qQOdhUgHPoZe62Wz_F73qlxQ>
X-ME-Received: <xmr:lQkhabyR0lrt2qsA-FX35NtHb41Z1SF2hRkWowBBnuHPYOd1801TwmUonGw5Bg1twZ7FD7BCeFxpxAygSaAVndkddblPeVcnwvV7bKnE5ULP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:lgkhaclk1B_2QU4EHqvrDNo8T39RguPYaUB-Ebn4H5BPGLFEEUGTPA>
    <xmx:lgkhaclOvf2r3NH_bZsjQeqEPJOOkTTeryWgNpk7wSGo0W5ZonPyQQ>
    <xmx:lgkhaWxA35zQW7bEeRqdX-TFHvA11m6HJsZGwPQE3WRpuKXAA0eRkg>
    <xmx:lgkhaZrsh3gKkwtdCHn2loeRThM0eAVJQCTz82DNt_K51XNTUPFteA>
    <xmx:lgkhaY4Gr8pLuq0-SGpnfBOotF3g028T0T2K9l21_N11p26dLY83_iFy>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:40 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 13/14] nfsd: discard current_stateid.h
Date: Sat, 22 Nov 2025 11:47:11 +1100
Message-ID: <20251122005236.3440177-14-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251122005236.3440177-1-neilb@ownmail.net>
References: <20251122005236.3440177-1-neilb@ownmail.net>
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
index 806306f48043..49700e85761f 100644
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
index e3b38245ba45..67afa253f408 100644
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


