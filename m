Return-Path: <linux-nfs+bounces-17828-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D7DD1BE16
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 02:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CD10300D80F
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 01:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED2E1B6527;
	Wed, 14 Jan 2026 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibyQT1j4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB750097D
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768352553; cv=none; b=SmQrpTeALzW4eaqCwCYctWsWp7yUuzrDpDyiULKl+OQbk/wdU/SPggDDUWSKBICJ8DZiSu1YZ4392gTRZ7X+//mqgULp/0f6nzf3kiqcFWkWwD1/er8xESGOdR+4aTjOdt2ZNz7bqhOv8aegrXjoDQV9L9nsdg3cRul6Zr/veaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768352553; c=relaxed/simple;
	bh=CFAOTJEgfFsJI7yKMeUS1EriVs9mzE1q2E/1Vs4yHIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HuHsBrJCx55Tt3w2yBamCUcUGoyuCGVYc5DyWZ0H/mVLE7aJriJkgd6KyJsaGzhcSqQRjMSY37ZpSSg05d+HKLoq3XuDcNDeFTWiioq8PvyrMB0id5oza4TF1zJzqEFeNddIa/JFdfpQqBPkpfbju5r0fQlagiaag8tqkDP/Sqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibyQT1j4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a09d981507so2717105ad.1
        for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 17:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768352552; x=1768957352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KnF91RCP71yrKiXq8eNbrPWHF6nT/NHw+60IKzYyVK0=;
        b=ibyQT1j4QcBLAoWQwVrxXqG45WvTiFABr5Egk8k36VF+aT03PJgD81xprmzd1OZeyn
         4z6tW9Yyqf7A+ECCJorEFDGCARdee4uuxRWnjQfxu8cQDSLWFb/AchfIf7T+CJ2NcVDp
         pgvcX8N3FS4eG/s2F1jP+t7FX1Kz+GfZ5hEFRCP+SEAA5Kl8zTsg3s32P2T/0hOXEcPw
         B5K22fETQYvcWRnk2NCCrhHShz02CAg782qGo1BEkX13hUrioIN0I++09rYHuULxue6o
         ABp6xRx9EV6G9IhhAgV5PioGIg+NQYUOwJYbq9pDPqsUSPhz5mqkLwvhWI3M/SnUhUGi
         EqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768352552; x=1768957352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnF91RCP71yrKiXq8eNbrPWHF6nT/NHw+60IKzYyVK0=;
        b=e7VjdlVJznK+sZ4RAsoKomANdCbNDjbAtum9oEF05XUFY9kn69WMQFWLgy9qJwcqcd
         ZgPfZbut+QWndf/dJTLGQPWh+vjkLy6OK4czvVcjDS2cPGqVsXdZkiQ/bf9kItuJUF/C
         y/IfMJay8cwGSXs8jqa4TGIePIl8DX3R1FC1qRalX3+BZCapI6FjckObx5YilXZZ/ks+
         R2KC0XLnKzLRMdVtStwcxuiR8pZYh5la4LjET5aao5Mhsia8MzfT41/0vBn6p2LRtoAj
         yWfcFksEkmdR+wvqH/o5iYumSHDUnEWiAfWI4oBmQtFh9u5MN+6/zJuI25jmLrwAh9Em
         7K7Q==
X-Gm-Message-State: AOJu0Yx/qPoks0LUbMctUhqMp/xxMC67WTC3V/1/igej6biZK/SpkwFk
	jvAyot22ZgvD5jHymMziEk5aA2kbwKDXXQUHOXrxqsRf9dcruh9mBQpg4bKy
X-Gm-Gg: AY/fxX7eEd+LQXY+lp7GdB23NMiUwMnsFrWgpzoUvaNgeHsddk3SOMLeOu2HxQYDHzZ
	Bd4hNzQyKaW/Xm1nOXJFGYbBSeLL8rV4uEDUjKydR1vl+UprKQfijdlV9u2JnJbCyZCvu0JKjfQ
	kYKeUwnSHtfULcVJUER3SG0ngLGJrnmsqVUrfnjpkNRAqYS+lKwSUsqkuyWsT8bYWtNoljh/KFO
	M0EsKTseWKY3bVWxYShSJJnnntlxDk5RZltvbSmW0X0HvMvoO3QE1S2xZ231R52VCu+i6MHQ5MW
	HcZOXdfNcJkw/kZjD7lMgoNXdwDRq4NVokPxkdFcOMELkDRf3lEToustacKmKaTmJPfc+wmXIZj
	QDjtOF2nShrLcDoseyYyXMMcwf+u1quEoB8ULFOWTQkFz3E1+BDHyXsjCzJUoqDUvbxSaFlo0VE
	VfdNyavFfb/I/fI1EKXMkMit+Dm8It85BQfJaP8PFdXP665HyPs8tUVw==
X-Received: by 2002:a17:903:3d91:b0:2a0:9238:881d with SMTP id d9443c01a7336-2a58b51b633mr34153875ad.15.1768352551283;
        Tue, 13 Jan 2026 17:02:31 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d154-20-96-77.bchsia.telus.net. [154.20.96.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c47221sm209812565ad.23.2026.01.13.17.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 17:02:30 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 7/8] Set SB_POSIXACL if the server supports the extension
Date: Tue, 13 Jan 2026 17:01:41 -0800
Message-ID: <20260114010141.1297-1-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Check to see if both the POSIX draft default ACL and
POSIX draft access ACL are supported by the server.
If so, set SB_POSIXACL.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 57d372db03b9..04c40c9d783a 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1352,6 +1352,13 @@ int nfs_get_tree_common(struct fs_context *fc)
 		goto error_splat_super;
 	}
 
+#ifdef CONFIG_NFS_V4_2
+	/* Set SB_POSIXACL if the server supports the NFSv4.2 extension. */
+	if ((server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) &&
+	    (server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL))
+		s->s_flags |= SB_POSIXACL;
+#endif
+
 	s->s_flags |= SB_ACTIVE;
 	error = 0;
 
-- 
2.49.0


