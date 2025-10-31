Return-Path: <linux-nfs+bounces-15830-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A871C232A2
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4743BEDF0
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880128E5;
	Fri, 31 Oct 2025 03:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Qh2lu0sp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5eQe8jP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CA26B96A
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881169; cv=none; b=k9Fk5HbIuYNZA6mgD9zI3C/r9M0kDOM93tQ5GThFVe3SB7Xa//F6ME19kQ+d6vXC6s+tuvt71WmWrndvJlmAc7u/hqaxcu/TEjv9ZqTOGmzmOtYZ3s6d8YTaq0Tgc+qxngTbNeVm0Rv9wbUs4KQYU/YoOomsbqoNFOa/G+Y9+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881169; c=relaxed/simple;
	bh=f8xkFMCpbbniT31Af/KlVN0z/oewq8xNn1UcOPOzXtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohbmjtpDtvj/0Ix8LoyIm4iQsFH6VJedOuE66Q4d+IGbYHfe3+OZGfJ9Ol8i0gK3vfWpTM8JzDSSNhHSQnuLjG6giXYBZgndmoa9wyk417t+/dixcOHdbuIUa0t3QCXcRuRBgoZhemvhIB2MyQPJ1e9n1GqH/caEYrRU9j8y0Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Qh2lu0sp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5eQe8jP; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AF367A0162;
	Thu, 30 Oct 2025 23:26:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 23:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761881167;
	 x=1761967567; bh=vx/SlLlJZpy8mf6FdHuEJQQqUHlf7kyAuXrGtPJ6H9s=; b=
	Qh2lu0spgl0V11Tt5C9p3S2Uv9h0fcIuOihk1hAQlooLfhdkPb538JGkX3q5bxho
	i95T2hNKyCUe0SumdMDI48/Pc5F6xY31SX5woReCcgThN2I4BWQFHBziAM1ocK6h
	3uVWYP5ub7kOdP2X7n/qh62j8cf5RD6q0apTU0gLnkzvfyg0PmHMYcMJwaVFGjrJ
	ti41Wo2yFAeGPckQZyhHsnWQp6f7qcYklqOaEdRgUyNfMFsmgFxBPsifW/TWFFQG
	sxOWIzNwD3AGVXD/6KI7w3MPEnHzR2dUnuw38v7fqjwb2gEQKy7r0qz4cK9Ydu+r
	aAs1gtDZ/5xXIAqt4NKstg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761881167; x=1761967567; bh=v
	x/SlLlJZpy8mf6FdHuEJQQqUHlf7kyAuXrGtPJ6H9s=; b=Y5eQe8jPIdbL1Ytwl
	KaWfqRIZpkb5Hc0FD27uvA4zDPhEfvHZ13S7LyWcrCFtDlCpc3OIU4CIAWnE1VFE
	D4IAcDsTZPDl3jmJeRdaOLO5lQQk6Np82xBfnpOGeXU3EemmDjhKqex/PHteDQ4N
	f8n4mBfeTPjlCLtYGUBecHg4Wkmuz9ajERup2VmB/XeOS2dNaS8/nezST1S5ce6t
	3p95AOM6G4D4DCddWHOO7HXpYguAFvfiJlRZPvuw4LaPTquOjGKqv7tgEoxb4mXg
	dhAnWRHpKrK6enKG16+5XwHhY7Tmw7qn/NiPYCh88s4pzUkEIOwOBGEnWklbyqit
	9Oj2A==
X-ME-Sender: <xms:TiwEaUIpte7wn1bQ0HIinhqF7x6iPAY0hbTHhii13XIwFl6ER1vfaQ>
    <xme:TiwEaX0efaI7PknyWEWCbBeyyOD5IRj7xlPTeBkYI9mO7JzcjO6AlJKKeAQfvwyR4
    G_0z70YEP-ooThSR_ecJzObs6noaRdH7DrBMdVU0VcnDRMYXQ>
X-ME-Received: <xmr:TiwEaeijqWKlyBSHfQWIWdULgK1iQlfGMNtGIVTQjK-7djsHPVvZxrA6yAG45QeOwOqG5mUaNs-0yuiL5DZIOW6dcLz_OHYDRA2EDiaKfTpm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:TywEaYWpSplU7Rw2Typcvsl3tRuPOpEH7dzlZz3ILWpZRrYQj7O0MA>
    <xmx:TywEadV6KVxYDsVj4ulOpYIJ6V_zFJYBmwSIyrX7s-DjBw4_zhBfUg>
    <xmx:TywEaYjJkAPXSrqENYNKfqqzxSNPHpQ408vxJmU-WJBXdF561cguuQ>
    <xmx:TywEaYZ1HmGogKoSi_H_lmP0vEJGPDmYKgP0kKNEBAeVVmj1DLGkYg>
    <xmx:TywEadpgMr5qhHWEuAxMkDSuezn6iVYcB1pjzRZ3tEab05mKPpokF3a5>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:26:04 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 06/10] nfsd: change bools in svc_fh it single-bits.
Date: Fri, 31 Oct 2025 14:16:13 +1100
Message-ID: <20251031032524.2141840-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251031032524.2141840-1-neilb@ownmail.net>
References: <20251031032524.2141840-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

There are now 9 consecutive bools which, one x86_64, results in a 7 byte
hole reported by pahole.  When there were 8, there was no hole.

If we switch them to :1 bit fields then they use 2 bytes instead of 9.
There is still a hole, but the struct is the same size as when there
were 8 bools.

Providing we *don't* change fh_want_write to a bit field, this also
reduces the code size on x86_64.  fh_want_write is set in lots of places
(via a static inline) and I think that causes significant code growth.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfsfh.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 995fafc383a0..a570b8a7adfe 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -85,18 +85,18 @@ typedef struct svc_fh {
 	struct svc_export *	fh_export;	/* export pointer */
 
 	bool			fh_want_write;	/* remount protection taken */
-	bool			fh_no_wcc;	/* no wcc data needed */
-	bool			fh_no_atomic_attr;
+	bool			fh_no_wcc:1;	/* no wcc data needed */
+	bool			fh_no_atomic_attr:1;
 						/*
 						 * wcc data is not atomic with
 						 * operation
 						 */
-	bool			fh_use_wgather;	/* NFSv2 wgather option */
-	bool			fh_64bit_cookies;/* readdir cookie size */
-	bool			fh_foreign;
-	bool			fh_have_stateid; /* associated v4.1 stateid is not special */
-	bool			fh_post_saved;	/* post-op attrs saved */
-	bool			fh_pre_saved;	/* pre-op attrs saved */
+	bool			fh_use_wgather:1;/* NFSv2 wgather option */
+	bool			fh_64bit_cookies:1;/* readdir cookie size */
+	bool			fh_foreign:1;
+	bool			fh_have_stateid:1; /* associated v4.1 stateid is not special */
+	bool			fh_post_saved:1;/* post-op attrs saved */
+	bool			fh_pre_saved:1;	/* pre-op attrs saved */
 
 	/* Pre-op attributes saved when inode is locked */
 	__u64			fh_pre_size;	/* size before operation */
-- 
2.50.0.107.gf914562f5916.dirty


