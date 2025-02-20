Return-Path: <linux-nfs+bounces-10229-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8EBA3E510
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 20:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5920770072F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71A82638AE;
	Thu, 20 Feb 2025 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn+Py7Wl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C363A9;
	Thu, 20 Feb 2025 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079858; cv=none; b=I9ucHivfylxBIsNmcVFWjbblOa5Nt5l1W/jkvqBO0uHX4NxBwvBOwfOr77r3pyZuLhVJpJjrk47OPJ5QPZKR2YLrwWkw2COPU9QNrmMA/H0K4ZRkszY3dnx5DdKF7108wNDMFY1DvDeooE/eveXdQjp7ujPNihdScPkJQrI0+Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079858; c=relaxed/simple;
	bh=5ONRHpMprZ0wN4zA/gIwbZWbUDkCqIaKx/wjTTQgKKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBGixs9FIczRVtibQpuMEVgjY72jQTNA4noyuvg3tlDoH8yJPVZ+8wBwJ1b7ZbaNlqA6Hxk49hvh2ItKsx8girCXu0c/mM0pESajXsAWYXVKqd6T4ZRVHSLTbi06folQHTRobUPqO+El948nHcQe05o1BFBa7gXRij4DuPLzJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn+Py7Wl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0a1c4780bso128223785a.3;
        Thu, 20 Feb 2025 11:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740079856; x=1740684656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruQE5LE0LHj53CdJ1m1i9Ompn3HmodUV4eVZZpvzC7U=;
        b=hn+Py7WlN3OTUDfVP0mDM3UtsC4B9w6JQWCdYOmCSn70K7XV+UoGSoSu2jiWxi1DqA
         Ho0yPVNBUs+cyKvCt17cB2I69qaDPWA31hPEXOfLR+/QRgkjqnXWe3INzs0S+Enqekj6
         K0XEXuoV1hO38AUPxH8PQ8wLZzXubNPSORhF90+Yp9cqzw8Kt+vzmudOOt6eLMQ/4WUN
         tpLQz0gs6gJ3Bx9/spsM2f61K0rmy9F4pcwqHUNEGKp0r4JNXnfqJSYrKWG/P4o8AvE6
         fvzzZBzj9J3k34ljkM+8yVHBug4GUKlJnsAYFRDsm965w87ajsu+o9O2llcauIG7bGQl
         206g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079856; x=1740684656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruQE5LE0LHj53CdJ1m1i9Ompn3HmodUV4eVZZpvzC7U=;
        b=TZUSDNdW53UKjpcw+lpCRYZftagBPk3/nKq3opbsFae28wIuz/nzhBD3NxBQiplE6l
         UCEqv+Q9j0dCVeevuC0adF9VupO2TG2oRo/DFIvui3zrKqrtsAd21l7mjBESiDD2HtVT
         IIm9WYBY5YyQaM9FgWRuIpfdyCdz5ZFTk1hr1aEDD/YUAmBvxB0ZiDuJ4X8a3E8njkBB
         vXpN7MtmklBXx4HFNuA0XV0iuX63kaFTjUdXZ/y3xzrRFpwrLCsdwQ/dG9fO+5dosjJ1
         WwYFFKCwBiLeqh2gX6LUeD6gKbufegAFIt4csX/4LttWoO4KsIoh4MpzrpV60jhyn2YX
         Ie3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJPu7w4G8n87XQJDCG8U9COoBwo+KZBDPScLW5HJ9ElOPgJTSeiFgn495fq0F/l69nBeSfD3lXaVPNvK3JPEzYYqT3Keo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+OshdfYfAcV7daUqF8670ozr6wq3VwbXaeoSghd7or9/7B2E
	0ruhGuY7s6F0DYjb1rPxeWfhw1Ejn/f9iMSXaT655jza/p0UpT6Ho7L97w==
X-Gm-Gg: ASbGncufrzUf0oUUsZNaFW1Fvenb/OLtfyC20HaHw6YBMcTNZeTsJ2gQB/cFuTizeRl
	LEfHDgrWkE4ZBFxdhkotQrY7ADDO/MzaWpBq25/ooYW7Gx+3hLYq4/MV7QyILt2KOFnU2Tk/nqE
	JSoWcA6u75QLeDWyadhE6TS0G4Z//CpT1s+SLLi0d2JB6Gmzv2Ljzu4A0n780Pe90qmLgR6V4T0
	cmYbxgHwLjlQB4+XnQuQZQFxjywgvlygWy9p87MTc/tkMa3nRnHnbWUTwdPM8X3eWpR31gdS9Go
	XRLs0h2Rdy2xKXw+omrpFGCC+gM0x7ukJBmLwgEUhnUbYFqBPEckNULYA8DpeEO1bXND4h7SwOj
	hqOmM97KYBsZZ9bLFabU+CBrEq2e/
X-Google-Smtp-Source: AGHT+IFfr9JtiD5Yf9tAAYIKaaJ9SrkkUsgXQ0tpumr/zpoDkLOS0rQwFrben/L55d3d5ve5geSTdg==
X-Received: by 2002:a05:620a:2456:b0:7c0:a260:ec24 with SMTP id af79cd13be357-7c0ceeec55fmr76639585a.10.1740079856064;
        Thu, 20 Feb 2025 11:30:56 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dcf9645sm89459826d6.123.2025.02.20.11.30.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 11:30:55 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: linux-nfs@vger.kernel.org,
	casey@schaufler-ca.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] lsm,nfs: fix memory leak of lsm_context
Date: Thu, 20 Feb 2025 14:29:36 -0500
Message-ID: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
did not preserve the lsm id for subsequent release calls, which results
in a memory leak. Fix it by saving the lsm id in the nfs4_label and
providing it on the subsequent release call.

Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 fs/nfs/nfs4proc.c    | 7 ++++---
 include/linux/nfs4.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index df9669d4ded7..c0caaec7bd20 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	if (err)
 		return NULL;
 
+	label->lsmid = shim.id;
 	label->label = shim.context;
 	label->len = shim.len;
 	return label;
@@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *label)
 	if (label) {
 		shim.context = label->label;
 		shim.len = label->len;
-		shim.id = LSM_ID_UNDEF;
+		shim.id = label->lsmid;
 		security_release_secctx(&shim);
 	}
 }
@@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 					size_t buflen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs4_label label = {0, 0, buflen, buf};
+	struct nfs4_label label = {0, 0, 0, buflen, buf};
 
 	u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
 	struct nfs_fattr fattr = {
@@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inode *inode,
 static int
 nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 {
-	struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
+	struct nfs4_label ilabel = {0, 0, 0, buflen, (char *)buf };
 	struct nfs_fattr *fattr;
 	int status;
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 71fbebfa43c7..9ac83ca88326 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -47,6 +47,7 @@ struct nfs4_acl {
 struct nfs4_label {
 	uint32_t	lfs;
 	uint32_t	pi;
+	u32		lsmid;
 	u32		len;
 	char	*label;
 };
-- 
2.47.1


