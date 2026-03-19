Return-Path: <linux-nfs+bounces-20275-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EdDEXsHvGkArgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20275-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 15:26:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BAA2CCC1D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 15:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACA0332E51FB
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B879372674;
	Thu, 19 Mar 2026 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W82Arv4k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144B371046
	for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929947; cv=none; b=MXdI/lwmkH/up/2vCF5zFsXmpA38P1gat0iLayuKWCxEZE0g/9A5XWNf5Y/6JQloGz+qK0Rlu/8IHO4ma7TgQEeVyyDEUsqh9HYPYibCX8sxpCRzTZJtSwPefyqsxcHU1pIgrthwVUhXRfGv4OEaJOZXp4yT3wF4FFnscnkjdY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929947; c=relaxed/simple;
	bh=LyOAcv8pOrNZtKwp9vpRm97qmAqdwUyyyBfIQEjIiu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlmlKu1qabkU/qMIUf0PG5HQpIPzN/tM0FsihAINhS98994z7ze8QlpfnCHSlZ7hH6/kVVAwQrHagS6fXvKfRrpV7vIGBxBTDX87GeNIZu36YF7RT7NpYkuZ79l9kxgEMmzM+wtmQ+1nJ7gi7zKDX1ihISjT2S/d/cr6oa4q9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W82Arv4k; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso533397a91.3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773929945; x=1774534745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Juaqw75BGT6mprObL/AlBCbjvTBGCqm62mz9LEt4i84=;
        b=W82Arv4kxLwqLKYHBB/lchtnVYurezipBWqBFyKDxSwo/HTQ51mxBuVe3Z0pzSPG4X
         JfeYCRB9EGUuK3aZ6po5Ng/l/sgotiyxNtU7qoexZ6BW83PQN3/8rrwxC6XK5gZxkylx
         Df7OBNFbqXATubwo/KvBpGliLe/0q6amFmc45DoWFlXEAgnNBP5djdnTc87N1zoXF3hg
         OR9UyqDIGnABl8YwlJ/uBXoLcNdSzpGYYKldw5by9gDiiVNUIfTy6qEBMN4raf22C1LY
         VJ8BLJaePMS3atG0szN1ZlZY9JVYKiu42GToApobB2i2LrdVkW421yxBP1DBgZFmBM58
         W6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929945; x=1774534745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Juaqw75BGT6mprObL/AlBCbjvTBGCqm62mz9LEt4i84=;
        b=MEFYH0dJnHnZ3NBUHOo+uCL3vfa246hsN4jg89qRPmmxSGlkUUfq+X2GbWNpNsLdWW
         W3bhHDto4JQ4vp4I0ZMmo9MRBZbtDX1kBVFZcCXoJ8uFNtPaK18BvGkALhKck4b7RCmg
         OhN2DJ/UC/fDyKJbMbpL5cBOsq+ZpVUToYE72CiwdAsGVOzXTxIuNq8zHs4xIcZsPzno
         +sTZx//jyzIKymA6Su6URletSNfxr8K5paSOuGI0pUtx/mTn2nVnRmW5iA7XTD9vZzKl
         k5dLxmI7bukV/CAx8d9EKqNMrs/djsRi2Gz5zEXMVA+Jy8j8Vx4+Q2UrrCPSV+UAyeNA
         CuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7fBROv1uX49PKZGRGJtz9HcJCBLTxUPx6TPDDLmOsgbLGmjJ2rJ4RrMaMEFXD8hWYpE5ii6/pYKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJL8v/exdJ84IQNnBoHi+Bd4+XQNkagZ3i73nr/CPvc32xqgU
	+x8tW+q4DWdrUCDzLDc8iUHC/oa9wz2JKxZ6c964tL2RBanWTW6g91K6
X-Gm-Gg: ATEYQzyFIwaYYfJgm1KLtXzek37VynVEXFNMbRlJfJ38x3ZpDZGMr4H6CPCPT8OOnzv
	NRZtEO4cWJlxYQgQcJGmbY2JyKdzhjqYfOT+BKWHKE095u7UZ+c1YjcS9V9rYIgYb5wl7fJb3bU
	JMYcMmNfpjYRogs5DRtgqp8IEVzbL2mjtupwClAnTZMwzU0rmG8b/5WLpN/6uKtWydQsojqEMkB
	Fuc8uGmX5naBawJ41vi8BXU5VDdQy0rrq9h2xeJ05aCJAGMz/j7jAXFykPBsRnvHnnao0LALKmA
	qtoVFAfb+12FyrhEdBWp/8/13EPFSFDf9Bzz5jpzH1vKVJQZLkHCxk7A+3eKUQOFhdNtTPqzMrP
	a08bQVzpWKNUiNADckIU6d11u6DonPo1q+CKFx/aOZz790g7KLU9Sy0sMJJZ5JyEuLOmtlizgup
	liMYdgJCHzQBVw86OGDmVeU0pfViQIdUWH7tZDdgz2d+HhsgOudrXhuP7Y5DCttvHuoZQ/oHQ=
X-Received: by 2002:a17:90b:3d8e:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-35bb9e456a3mr6473615a91.4.1773929945118;
        Thu, 19 Mar 2026 07:19:05 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63286ebsm2695321a91.17.2026.03.19.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:19:04 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 3/3] nfs: refactor nfs_errorf macros and remove unused ones
Date: Thu, 19 Mar 2026 22:18:46 +0800
Message-Id: <20260319141846.78222-4-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319141846.78222-1-seanwascoding@gmail.com>
References: <20260319141846.78222-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20275-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.770];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A4BAA2CCC1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
pattern for safer macro expansion and kernel style compliance.

additionally, remove nfs_warnf() and nfs_fwarnf() as git grep
confirms they have no callers in the current tree.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603110038.P6d14oxa-lkp@intel.com/
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfs/internal.h | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 63e09dfc27a8..59ab43542390 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -161,13 +161,19 @@ enum nfs_lock_status {
 	NFS_LOCK_NOLOCK		= 2,
 };
 
-#define nfs_errorf(fc, fmt, ...) ((fc)->log.log ?		\
-	errorf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
-
-#define nfs_ferrorf(fc, fac, fmt, ...) ((fc)->log.log ?		\
-	errorf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
+#define nfs_errorf(fc, fmt, ...) do { \
+	if ((fc)->log.log) \
+		errorf(fc, fmt, ## __VA_ARGS__); \
+	else \
+		dprintk(fmt "\n", ## __VA_ARGS__); \
+} while (0)
+
+#define nfs_ferrorf(fc, fac, fmt, ...) do { \
+	if ((fc)->log.log) \
+		errorf(fc, fmt, ## __VA_ARGS__); \
+	else \
+		dfprintk(fac, fmt "\n", ## __VA_ARGS__); \
+} while (0)
 
 #define nfs_invalf(fc, fmt, ...) ((fc)->log.log ?		\
 	invalf(fc, fmt, ## __VA_ARGS__) :			\
@@ -177,14 +183,6 @@ enum nfs_lock_status {
 	invalf(fc, fmt, ## __VA_ARGS__) :			\
 	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
 
-#define nfs_warnf(fc, fmt, ...) ((fc)->log.log ?		\
-	warnf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dprintk(fmt "\n", ## __VA_ARGS__); }))
-
-#define nfs_fwarnf(fc, fac, fmt, ...) ((fc)->log.log ?		\
-	warnf(fc, fmt, ## __VA_ARGS__) :			\
-	({ dfprintk(fac, fmt "\n", ## __VA_ARGS__); }))
-
 static inline struct nfs_fs_context *nfs_fc2context(const struct fs_context *fc)
 {
 	return fc->fs_private;
-- 
2.34.1


