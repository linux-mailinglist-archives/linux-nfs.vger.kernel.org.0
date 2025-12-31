Return-Path: <linux-nfs+bounces-17372-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1D5CEB0A3
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6CC83008791
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DF2D7DCE;
	Wed, 31 Dec 2025 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2Y8Sk+E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF002E22AA
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147738; cv=none; b=a/3OG3262ynDWXxnGvsBMlObS41TXxzt2CnM6evHjqJLF7PYLVT5Ag4WVm6UfeRzTl3sbB94jJsFKrW16fFfgtmla/EwSLwMYxhqN7P8QXCz9vrEukuGwJw920KksJ+tzCMudTfGEgzwmvEWxRpWmClEGer8zk6ShK71xACIpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147738; c=relaxed/simple;
	bh=oqf4R2knTZm4vlXy9s4o+y3Aaui76wiv75ZUkvQdLbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teJNX8b0dDHgx4d+nVFEOFT9UF8nFRCB0fOx+hlr0tXtY7pE9U0SGJHDKvW5Rb7toa22vt2vPTZ4rOi1GgBpOPOQxsez70/FD37ynnpypZbrx3YfhTwPNcdNrBNcMhsDOPXPomdkssKYf5MtIUEK81+D/cUSd4M8CeBJ2hy9Mr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2Y8Sk+E; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so10779983b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147735; x=1767752535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Im5awB1FTEmpukw7QHbyQNN7Hry4+njONw8NytkaUI4=;
        b=P2Y8Sk+Ec4g3LJ+m29lFc4jNtUSZL9Yca39Kv8NJQsh4xHMBieZuWyaqvR/0NqEss4
         kmJcf/oWXTalmfdXJjB9c8oPnm+RnGya7IAMpEfRZRzrhpW3csF7VUaWzYzriCrgLAw5
         SZNJi5zerp6bozkhe587YZsSo5nte2Scv0HtrkjrZHJbyMZCaMCz3IPPxGkDfhBv767Y
         xVgyzBb2nm/HISemVCwDM5EGlVxs+kFVi4hjOQzZ79DyLrgSa7ZzjepNALTuXRcpdr8u
         x7Y2LA1ykibzZrTchaC/1jKyl9WfLDJV0bBJMWA4ZH/AvheVWXSaYGYbop8bqDV1Kxwz
         frRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147735; x=1767752535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Im5awB1FTEmpukw7QHbyQNN7Hry4+njONw8NytkaUI4=;
        b=YFKpXaXRzY8mb64vB84tq8UIJsT7grg6iy4kdvuegazGf2AwW1hMiX3+JkCgBCmzZt
         Uneo/a1PLd03wbJjUbckPt65lUOwbUL3gI2PK1+E+KavssxKaKDoDPiNd+KsPy/SWOdm
         K2JoWY4r0sc89z6ZvPTVdUmANFcXCJeVjtWg5q5kx5w16q16K6QGXAEsB8QPn2PEr4Uz
         OhwKIu71JLh+7PIN1TyajaYfKaN29GQlUjXUTOjet6mEyjIdDLS3vi8s0gPC7+23v8Vv
         b/D5/J0Lc3dvCZtkr93u8vpkhE2aqjvqXEDzF+hIoTpIZexGiJtJGEfp0c7DHAQUtujb
         oiig==
X-Gm-Message-State: AOJu0YzzVLbLBwWGeMADx/5Tp72Vl9B2KGX+7XFRLtrWllZ3YdEugWL1
	8ezllc96d5ZuzTkgVt1BNW1qiKukzVXmdTLgSoMz4c8TVzLrqnrmxqbRwYW5c4Q=
X-Gm-Gg: AY/fxX5M/EPGS/u4Cg7SGCNJpbprKsYEk5rQwrORVf0sQBk83tyCtgmiOxQb4YkAAW3
	6yaFm72bocUIlfB4JLjVSxDiSYgA8IFFBzV6JhZ90bj/MsziuqEH0IhTeG0IrJHH3Ti2DckAOQk
	HIyTc1sCpav+KFS9fj6fXi/C28LMXzIFd80ElEodpY9OTE0op9wTDcabh3/2f1KuBJ3lu3a+Gom
	imI0uihzHv4xMIuEZkdAze4Lm4RY9cTysdPFM2BpF5/G15DtS7qF4bXOV76T+KhnHXMjpxOVGRV
	8rAtRXQd164KveHGme2LEtVh7CyTb0AjojDZHC821Fk4Jh8OBgPhk9fHb/tZ6sJ7mRsZmsSU8Vp
	cZDhXNMt31hz1/sPkEWQSlS+Sd1P4jPm0uKfUArNpscBeUt5lR8ovxmvOInoIArbvzTCcXZfxEp
	OYN0ZznnDZQ3FJRAu7S9gqIwF1NTUF8lC1N6Li4JKqNz5oIz6doRLvlUoS
X-Google-Smtp-Source: AGHT+IE1aAPCtT4uUatAELH4it+r9jmvHYjEF5mLAiyWHcW/DOD/EfMkwtL64mmXrs1/JeOmLfWYUg==
X-Received: by 2002:a05:6a00:e12:b0:7f6:2b06:7134 with SMTP id d2e1a72fcca58-7ff66175a58mr29060041b3a.32.1767147734921;
        Tue, 30 Dec 2025 18:22:14 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:14 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 05/17] Add a check for both POSIX and NFSv4 ACLs being set
Date: Tue, 30 Dec 2025 18:21:07 -0800
Message-ID: <20251231022119.1714-6-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251231022119.1714-1-rick.macklem@gmail.com>
References: <20251231022119.1714-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Check that both POSIX and NFSv4 ACLs are not being set by
the same SETATTR.
While here, fix posix_acl_release() for a couple of error cases
by adding a new out_err label, so the POSIX ACLs are released
before returning status.  Note that posix_acl_release() checks
for a NULL argument and just returns for that case.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfs4proc.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b92477c87db1..71e9749375c1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1215,7 +1215,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
 				flags, NULL, &st);
 		if (status)
-			return status;
+			goto out_err;
 	}
 
 	if (deleg_attrs) {
@@ -1233,17 +1233,24 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (st)
 		nfs4_put_stid(st);
 	if (status)
-		return status;
+		goto out_err;
 
 	err = fh_want_write(&cstate->current_fh);
-	if (err)
-		return nfserrno(err);
+	if (err) {
+		status = nfserrno(err);
+		goto out_err;
+	}
 	status = nfs_ok;
 
 	status = check_attr_support(cstate, setattr->sa_bmval, nfsd_attrmask);
 	if (status)
 		goto out;
 
+	if (setattr->sa_acl && (setattr->sa_dpacl || setattr->sa_pacl)) {
+		status = nfserr_inval;
+		goto out;
+	}
+
 	inode = cstate->current_fh.fh_dentry->d_inode;
 	status = nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
 				   setattr->sa_acl, &attrs);
@@ -1262,12 +1269,11 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (!status)
 		status = nfserrno(attrs.na_aclerr);
 out:
-	if (setattr->sa_dpacl != NULL)
-		posix_acl_release(setattr->sa_dpacl);
-	if (setattr->sa_pacl != NULL)
-		posix_acl_release(setattr->sa_pacl);
 	nfsd_attrs_free(&attrs);
 	fh_drop_write(&cstate->current_fh);
+out_err:
+	posix_acl_release(setattr->sa_dpacl);
+	posix_acl_release(setattr->sa_pacl);
 	return status;
 }
 
-- 
2.49.0


