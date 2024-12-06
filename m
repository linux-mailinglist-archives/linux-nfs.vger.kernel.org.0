Return-Path: <linux-nfs+bounces-8405-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05739E7B71
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 23:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABAEE16A0EB
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AC1F9F4C;
	Fri,  6 Dec 2024 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="AAY3riAx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00422C6E3
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523171; cv=none; b=DTAlT/gAnkuMptCOESEdfOho8omCXqfUMZA/YZxbfUvHMsliGdrgy/353oMSO/uR/ZKp1qn8G2usS5ESZB/1BxalW1rZsZuB7njRb8b60Er7s6GbBgZVpmqChWaOf7YMrtdJoxPfCPTPYodC8kMRteGcHQtzRr3c6JOIPc08g9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523171; c=relaxed/simple;
	bh=qvrdd8iFVOFFQG9jftp/6/Cz0Gtgj6+jaKgtGYydBIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRKYHK7h947mF1fOgQDUWgfWOXv+TiHAHLnTalSOBd5VUx9cAMaMLjtKDwx5qnGgBgVrbghHXmhtz0z1xscPOdJ5dDqNsdy5TbTYrENAgIfE5wk3FqJKU5cO29QvXen1GFJNKQDe+aYHq1VQIzIyFw9qTud2oTOK44i3d1RZCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=AAY3riAx; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1733523161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYWxiTjekFvgmxyc8XZ8//K4ToI5dhLnYjbm1ze+1PQ=;
	b=AAY3riAxa62GWM4tYkKE96Y/RLo4diLpbkCrbfhDC0By42KSPkGfpF/LQ4S7b/8O7Bf+8J
	S8SUvmGco7YULuqQppF/TgWhFrdHrCjllzIMO+FLDa3Rx2bUDWFNp+b0ABc1W6DRFGBqen
	DDVzJZjJuWU76ueExO2fhSwvKoJgVon7odStjBX/eqFsc47dTLV8IKQupj+QEluaauQ2gd
	45xN6vGY5Bw/8FE3sPWTHJ63cgWDhd2IRCnEJEc0AKiEBAaQRA63vVJew887Le2NT1xLk8
	Q29k/7likleN8OG01LUd5PPDMY5MWo+VAUknWRR2W0m5M19FpucTjdRuzfu2yQ==
From: Christopher Bii <christopherbii@hyub.org>
To: steved@redhat.com
Cc: Christopher Bii <christopherbii@hyub.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] nfsd_path.c: - Simplification of nfsd_path_strip_root(char*)
Date: Fri,  6 Dec 2024 17:11:54 -0500
Message-ID: <20241206221202.31507-3-christopherbii@hyub.org>
In-Reply-To: <20241206221202.31507-1-christopherbii@hyub.org>
References: <20241206221202.31507-1-christopherbii@hyub.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Christopher Bii <christopherbii@hyub.org>
---
 support/misc/nfsd_path.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index 5168903d..ff946301 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -55,19 +55,11 @@ nfsd_rootdir_set(void)
 char *
 nfsd_path_strip_root(char *pathname)
 {
-	char buffer[PATH_MAX];
-	const char *dir = nfsd_path_rootdir();
-
-	if (!dir)
-		goto out;
-
-	if (realpath(dir, buffer))
-		return strstr(pathname, buffer) == pathname ?
-			pathname + strlen(buffer) : NULL;
+	if (!rootdir)
+                return pathname;
 
-	xlog(D_GENERAL, "%s: failed to resolve path %s: %m", __func__, dir);
-out:
-	return pathname;
+        return strstr(pathname, rootdir) == pathname ?
+                pathname + rootdir_pathlen : pathname;
 }
 
 char *
-- 
2.47.1


