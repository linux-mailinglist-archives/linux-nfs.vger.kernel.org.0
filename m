Return-Path: <linux-nfs+bounces-8407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04069E7B73
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 23:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F695282514
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660E61CBEAA;
	Fri,  6 Dec 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="NpT8xM2F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A751DAC81
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523172; cv=none; b=Dtl87NGHBJUXLMlBkAVaJlnaNYNLdirlVyaHv6B4/LfC/CrmacZeCoTlmOHZpoSVzEPNt6VZRLLFCzyMXdnlty2EFsicAY+ipdI9L9xwVqlv8/L4nqEsDt7HhVGenCzFkaN2ViEjaqxXKBVEXIbuySR0dGXnxaq8zVTlIVNZ10o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523172; c=relaxed/simple;
	bh=XTLsB65+TZRrhnpvS8a5Dx/hCZPAprXxUTQvI8/V/hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNaAdhbf6F8OR1Jummc2ArZGFuumRgCoivhnftG/hfhYs0DoC1p6ZVhMrVkeuMnkAL9gu+FuCL9x6SfwFyTqdtZ8Y9IiYhkpfcxUAm86wanwtu2OhXAog/zURVe25bNY09A0JP4+JNyzCNCQRtky3f2c6lfiMbuwVtEqiDpeI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=NpT8xM2F; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1733523163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3079Nq7YObwblUioa2ZscLIwaNHjEb4LgmQVPIzQwY=;
	b=NpT8xM2FhPzRdUfL6pqrNbD2+ofm4EMRVOhorNoON7M0hfxjsKG8XcAVncuuFdaWA8xxhU
	NPk36l8otaOcdTSZx3NrZvGd1Xw8UYgqTWR0TY3zny9Ep1HOvq6M5gi9m2rh06tGRCHstQ
	hUDr8O7VAbMCUCyoYyw+ADXiBePFI3sFyLM+UQpbnzNdO8ZY2GKoxd51CmzZQie2eU8iOs
	jx/kvuEBf0PwXvl/TVgwbRXygVNiTFm6lQyNLIKEfnLVF2SUTEbTHWDznMij/kY31U2rW8
	e0ZWBK7XvyFl5XRgiHqvt/fvaxPx96/Zf9bG4WVcbLzIxuGyKF9qVy3P8JMXgQ==
From: Christopher Bii <christopherbii@hyub.org>
To: steved@redhat.com
Cc: Christopher Bii <christopherbii@hyub.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] support/nfs/exports.c - Small changes
Date: Fri,  6 Dec 2024 17:11:57 -0500
Message-ID: <20241206221202.31507-6-christopherbii@hyub.org>
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
 support/nfs/exports.c | 48 ++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 21ec6486..3c2d4d46 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -186,28 +186,34 @@ getexportent(int fromkernel)
 	}
 	ee.e_hostname = xstrdup(hostname);
 
-	if (parseopts(opt, &ee, NULL) < 0) {
-		if(ee.e_hostname)
-		{
-			xfree(ee.e_hostname);
-			ee.e_hostname=NULL;
-		}
-		if(ee.e_uuid)
-		{
-			xfree(ee.e_uuid);
-			ee.e_uuid=NULL;
-		}
+	if (parseopts(opt, &ee, NULL) < 0)
+                goto out;
 
-		return NULL;
-	}
 	/* resolve symlinks */
-	if (nfsd_realpath(ee.e_path, rpath) != NULL) {
-		rpath[sizeof (rpath) - 1] = '\0';
-		strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
-		ee.e_path[sizeof (ee.e_path) - 1] = '\0';
-	}
+	if (nfsd_realpath(ee.e_path, rpath) == NULL) {
+                xlog(L_ERROR, "nfsd_realpath(): unable to resolve path %s", ee.e_path);
+                goto out;
+        };
 
-	return &ee;
+        if (strlen(rpath) > sizeof(ee.e_path) - 1){
+                xlog(L_ERROR, "%s: export path %s exceeds limit(%lu)", __func__, rpath, sizeof(ee.e_path) - 1);
+                goto out;
+        };
+
+        strcpy(ee.e_path, rpath);
+        return &ee;
+
+out:
+        if (ee.e_hostname){
+                free(ee.e_hostname);
+                ee.e_hostname = NULL;
+        };
+        if (ee.e_uuid){
+                free(ee.e_uuid);
+                ee.e_uuid = NULL;
+        };
+
+        return NULL;
 }
 
 static const struct secinfo_flag_displaymap {
@@ -432,8 +438,8 @@ mkexportent(char *hname, char *path, char *options)
 		xlog(L_ERROR, "path name %s too long", path);
 		return NULL;
 	}
-	strncpy(ee.e_path, path, sizeof (ee.e_path));
-	ee.e_path[sizeof (ee.e_path) - 1] = '\0';
+	strcpy(ee.e_path, path);
+
 	if (parseopts(options, &ee, NULL) < 0)
 		return NULL;
 	return &ee;
-- 
2.47.1


