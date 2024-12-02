Return-Path: <linux-nfs+bounces-8312-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C6F9E0E10
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 22:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C92B251D1
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 20:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ED3B667;
	Mon,  2 Dec 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5/kFL20"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442122EEF
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171455; cv=none; b=b75U7S3ab2/eM8bQSxl2CrvqKUXitI5aHzk7YuuHUcgaHK9hAJSK4Tf5PMB/88r9t34dHpMGT0fViqjYp2tYPZjfSz5y2Q7ktGnwqbwmNgRX4NvxC7NyWMgPUBF6hw2o05W715RITqwtcR/HuDDZEP+eNzM9+u8InH+EtKHlWnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171455; c=relaxed/simple;
	bh=RXw+Gh5K2ZT9CNFfiKgBhta6cE1YzWmr88eir+/aueA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEWrV56u0Rr1mYKm8rt/T77ZyWwUHCHIVxYBuqU8oCz2Q3mUIvPL2W8RDosH0ooSieZh0rHtlKpCCF+AUjmm4qOKYTpf6wcZm+q0/DbZMAb8sCRWQJ5a/nHwBd+0DKD69kL9UTqrghCTgwmIrcP93+K5hhpo9HGWPZ+e0Fite2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5/kFL20; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733171452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73iWeDopw+44V7T5iWCFVTd1WgY9GHG4/rtoT43XPCc=;
	b=g5/kFL20jE0sJsgG2ooO6RwtdV31HrWqjk1YfJadoAoSObsH+DCP+YHb2pNnqDJjUxzRRe
	3B+NFGDlcICs6w+h4dKNjKi2FHooiv894cFPtbAYO6kjb6K/Y+w9wctcZ1fVwKarBmY2Lw
	NU5L4txBIW22jYd3z61JqE3cYtEbYrM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-GwXdJ--XPA2aaO5w3nPCnA-1; Mon,
 02 Dec 2024 15:30:49 -0500
X-MC-Unique: GwXdJ--XPA2aaO5w3nPCnA-1
X-Mimecast-MFC-AGG-ID: GwXdJ--XPA2aaO5w3nPCnA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E96D1944DDA
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 20:30:48 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 460921956056;
	Mon,  2 Dec 2024 20:30:48 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 704D5224462;
	Mon,  2 Dec 2024 15:30:46 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] exports: Fix referrals when --enable-junction=no
Date: Mon,  2 Dec 2024 15:30:46 -0500
Message-ID: <20241202203046.1436990-1-smayhew@redhat.com>
In-Reply-To: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
References: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit 15dc0bea ("exportd: Moved cache upcalls routines into
libexport.a") caused write_fsloc() to be elided when junction support is
disabled.  Get rid of the bogus #ifdef HAVE_JUNCTION_SUPPORT blocks so
that referrals work again (the only #ifdef HAVE_JUNCTION_SUPPORT should
be around actual junction code).

Fixes: 15dc0bea ("exportd: Moved cache upcalls routines into libexport.a")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 support/export/cache.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 6c0a44a3..3a8e57cf 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -34,10 +34,7 @@
 #include "pseudoflavors.h"
 #include "xcommon.h"
 #include "reexport.h"
-
-#ifdef HAVE_JUNCTION_SUPPORT
 #include "fsloc.h"
-#endif
 
 #ifdef USE_BLKID
 #include "blkid/blkid.h"
@@ -999,7 +996,6 @@ static void nfsd_retry_fh(struct delayed *d)
 	*dp = d;
 }
 
-#ifdef HAVE_JUNCTION_SUPPORT
 static void write_fsloc(char **bp, int *blen, struct exportent *ep)
 {
 	struct servers *servers;
@@ -1022,7 +1018,6 @@ static void write_fsloc(char **bp, int *blen, struct exportent *ep)
 	qword_addint(bp, blen, servers->h_referral);
 	release_replicas(servers);
 }
-#endif
 
 static void write_secinfo(char **bp, int *blen, struct exportent *ep, int flag_mask, int extra_flag)
 {
@@ -1120,9 +1115,7 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
 		qword_addint(&bp, &blen, exp->e_anongid);
 		qword_addint(&bp, &blen, fsidnum);
 
-#ifdef HAVE_JUNCTION_SUPPORT
 		write_fsloc(&bp, &blen, exp);
-#endif
 		write_secinfo(&bp, &blen, exp, flag_mask, do_fsidnum ? NFSEXP_FSID : 0);
 		if (exp->e_uuid == NULL || different_fs) {
 			char u[16];
-- 
2.46.2


