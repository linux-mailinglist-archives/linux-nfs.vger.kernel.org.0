Return-Path: <linux-nfs+bounces-15640-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06815C0B5E0
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CF63A847B
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 22:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8059C28468D;
	Sun, 26 Oct 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="jkwqKsxw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mBHzSDmm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68861F30C3
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517679; cv=none; b=ajzG5KckSgXImP2f0bizh9G+klz/qDJ1lvSsgp/uYTUWGzrBFh2ydtGfpsfe+mVw/9FZq684jtCYB7O2dpOlV9Jr6hwFzOfaCkPRZV3YRG05oDPqd3PG9ggUK2GvuKugf13bB4Qi43pUGeBiyM4tX4m6Dw6seSAKCG6w/rJKRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517679; c=relaxed/simple;
	bh=4ljh4ZcioO+/HAOzEB5W6dDVpR8M0ZiuCTztIRSmhcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ad0kDKVRBjfbCoclbmdDBvoLgW4FWee4EtRKXX0J7RggD4/nGeLfcTRfBH7WRuMTEm5FEa4iXjd5hRgf8mQApUvAtbxXWhMJBaUHL1Gp851Mi61iJ8ErIt3O1WZZ44fJ3zRKk59Xg7/F1aEWzUg3CAnkmEvbe/XuisoGRIgmIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=jkwqKsxw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mBHzSDmm; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3ADB11D001B0;
	Sun, 26 Oct 2025 18:27:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 26 Oct 2025 18:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1761517677;
	 x=1761604077; bh=1j0DJ0mOjW9m0sLlkqlp/Hpz6S8qq2wXHmybEfvgtIg=; b=
	jkwqKsxwgGrlBj6gkaw479ZKGTOAg5t4Nvbx5bPlzSj+axNgsrlYWYKVxZhQVzXZ
	YhbQOgaUa2Duvl9RWHAGXE/vo8gZqfgLj1JrXbdZuXY7De0aPT/tMBz7Jt5tlt59
	DFipORnV9wU8wBi6EOeschl2BvDKBhtLDSkzndyR7PXFWA2qqHCzayvYIG+Y7I+N
	6AoDmS0WhGRDluF6uKwTR2qj+x8ZDsEXGz+9Z3yut1dq+zjO4SQOm0u70AsoAT+R
	38tHwfVM0eqJtWuW58E/ZRLY7XWBFAkyW1OogAAOi9yfG6MSaMkoWozcT2hda58p
	vT8gLMbzJsnthcJllk8HDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761517677; x=1761604077; bh=1
	j0DJ0mOjW9m0sLlkqlp/Hpz6S8qq2wXHmybEfvgtIg=; b=mBHzSDmmZdZUCxbyB
	MNmOmQykiJON2BFdwQjEpbigkxXpzrGAo/KYu7vjpEf+6zu5zB5pi5PGllvPpH07
	blpU8ImgWj29AnneFey5kLHcIwWRA3KqaPE7U6J5iHpWOXCoTg3U0HR28yeUVte4
	/EQY0mlJS+7xlqHzAKVTznTyr3SpfgebtxCV+tVxkU7PTAE9bGOaEtZw6wiV2IY5
	n5ck5UVyNFCBBESGOLJPUMcXwVV5/AxtlWxBczCePQRLySVzppiouGv59gJK+rIW
	haRVkk61nCQ9M6+ml5uxs2Ne66Eyv77eSBcFNCZsiWMXbWrxexbtQmAVxGa0w8ko
	lqI+A==
X-ME-Sender: <xms:bKD-aDJIsUt-RHUqj3i6Sijq--KclODAkoWh9JI1lH6KtOr9SOwWjQ>
    <xme:bKD-aK3q4WLx0iML9fmMgEzEpovwaGQDeDx15QNpSxPX2viy_X-hVp8_x4vyaZV0l
    dxqtw7IiKggBJRmMkMOSsi9ytWkbM_2zI1I04VwM9fJGjYh_w>
X-ME-Received: <xmr:bKD-aFi0R7lCt4DONy-Seq3NhXW5Y-dSqFxvyAfdA4HtuMN0ts2MF6eRDmQXJHtLa21jYJRmndLGLhjDrz8IQxNPOkWIJ3HdgtL0Z5xYzdsG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeivdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bKD-aDVJnMTIw4_7FPQXr0dBG9QKJ8LcV0pGTCk48JITmVGeRCAeoQ>
    <xmx:bKD-aMWYovlzg8UBiYttU6xtogCnkLlKVTAftx8WRDqLwVRbdide7w>
    <xmx:bKD-aLgoSJr8QhObUWvUtLh8GkTaNfBlMXWCFhctWYR-93Ur_HYFrw>
    <xmx:bKD-aPYc96wxbMhDeYnsU_cti5AchBpAlTbhpU84IAT2xiUUkvUxAw>
    <xmx:baD-aMqLAE-aXmMNCsbQIfnAcTk359zDDvJGoXF3WIkUh1u0P-yseut4>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 18:27:54 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 09/10] nfsd: discard current_stateid.h
Date: Mon, 27 Oct 2025 09:23:54 +1100
Message-ID: <20251026222655.3617028-10-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251026222655.3617028-1-neilb@ownmail.net>
References: <20251026222655.3617028-1-neilb@ownmail.net>
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
index 54564e09cf99..3ebc4357cd67 100644
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
index 96c490f24527..a5bdd7bcd887 100644
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


