Return-Path: <linux-nfs+bounces-8349-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E799E4C1C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2024 03:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F8816922D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2024 02:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AF7156F5D;
	Thu,  5 Dec 2024 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="GHO15xkS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C44C96
	for <linux-nfs@vger.kernel.org>; Thu,  5 Dec 2024 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733364269; cv=none; b=Q4PkjJdYCXo4TA6LysFS9Oz7X3VVv+zfLkNZOccTEZNe183gwMAN9syPlorXnOe3Tzs3WDISICZNoKTVGGXj/xpupk/FcoljVX7w5LRwka1wIh30rErhXROfioU3maw3D+Vxh6y0DR+bc8JRFnjVnSG4AppwbPc0rLgLIr0gm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733364269; c=relaxed/simple;
	bh=c09F1EK9MVQpUjsit3kN7AJVz46hR+GzyrrIhOZvfr0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Y7Am4Xn2g8RgSpfL82HDkvvW9rmtFjdPCuAQS7Xh0UB2vK9ISiGabbuVa6yAZCor4wLteaqLhlVercYir7V4tSGy8PcD6I+67YlPeoe74z+7FKvWgZl85xF1VK3N6742qTcZO/429ZbDQdnqiXmjQJW9wptCg0utUhYR9zFLF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=GHO15xkS; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1733364265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JsjRMY1WJx4WsAsjNXQLGc5Ypm6lKloxhLwtFe7ldhI=;
	b=GHO15xkS3BS0yYmbiO1my7in+7qGGXcdkx1vhbw+GRaf52tG4nxER4qyZqtw45xL6TV96i
	kIvagvraH8WYba1iE+NyebYjkrqsy5Ir67yoQB/eTx9ZtYdLGqvtoCfcTGP9hhjwTgtTiZ
	tYAU9Qhc2GeLcqpOVWU+clEoHT7iH45OmePBBmfo8JT3AM5L0YrfDex8uogRHKxzLWs563
	PosRCeGG3+LzxPfT0WPvIvmuZuoEIGBg2iaUgvdst/uzNme5+Srcve3kI8tUPWEoCxv4Hn
	+marYtsa3038Jj72pGiWBYzNuwuUYeK9qq1T1Qjv4xCrmQnbiwXwVYYDkmyyhQ==
Message-ID: <012724c4-12ee-4648-b5cc-b9f8e8322139@hyub.org>
Date: Thu, 5 Dec 2024 02:04:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christopher Bii <christopherbii@hyub.org>
Subject: [PATCH 2/2] Temporary fix for build issue for mount util.
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

---
  support/include/exportfs.h | 1 -
  support/nfs/exports.c      | 8 +++++++-
  2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/support/include/exportfs.h b/support/include/exportfs.h
index c65e2a1c..9edf0d04 100644
--- a/support/include/exportfs.h
+++ b/support/include/exportfs.h
@@ -173,7 +173,6 @@ struct export_features {
   struct export_features *get_export_features(void);
  void fix_pseudoflavor_flags(struct exportent *ep);
-void exportent_free_realpath(struct exportent*);
  char *exportent_realpath(struct exportent *eep);
  int export_test(struct exportent *eep, int with_fsid);
  diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index c8ce8566..ec361486 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -67,6 +67,12 @@ static void	freesquash(void);
  static void	syntaxerr(char *msg);
  static struct flav_info *find_flavor(char *name);
  +static void
+exportent_free_realpath(struct exportent* eep){
+        if (eep->e_realpath && eep->e_realpath != eep->e_path)
+                free(eep->e_realpath);
+};
+
  void
  setexportent(char *fname, char *type)
  {
@@ -191,7 +197,7 @@ getexportent(int fromkernel)
   	/* resolve symlinks */
  	if (nfsd_realpath(ee.e_path, rpath) == NULL) {
-                xlog(L_ERROR, "realpath(): Unable to resolve path at 
%s", ee.e_path);
+                xlog(L_ERROR, "nfsd_realpath(): to resolve path at %s", 
ee.e_path);
                  goto out;
          };
  -- 2.47.1


