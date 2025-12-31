Return-Path: <linux-nfs+bounces-17380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0076CEB0C4
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C27301E1A1
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B7F2E22AA;
	Wed, 31 Dec 2025 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS2ld5rY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8F2E542A
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147755; cv=none; b=amle42vG+2yor/FNtsrS7berYhfBxAavzcd8smdna5G/hRTHMEDQ5WkXg7jRoYb7apFc50dSoyr1qexqKaFsYjwaLVIUs4UhEOHqyTCbNhSA84ihhsZ9oLnybVJF3uI8wC879nrHby9P6Nyu5mXE/ofkVTdxGQySHpPfkWjtMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147755; c=relaxed/simple;
	bh=tG1svDUwqiZ826dwhZWfZ1EWq5Y0pespJLfvSUzX2lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bw3dCCmIlYpPdgjQdRd+bUcMlZdQUkP6sxLZH/TkwGQs1vQBitAdIrALRVSYOOwFaaZB+2oO8w9MH730LWlxYWCULC9N7GeRSKueaHmHx6YhOigbcxoWgHY9xeI1d+KtuJYLmR12j/yYfYvk84XJxmuKATV9VUEs73HBhPlsgyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS2ld5rY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7ade456b6abso8522959b3a.3
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147752; x=1767752552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8YLrdzFffswEZequkcqLVLtHoOFr/LoFxn5vu+m4fw=;
        b=lS2ld5rYJWXlnNuDcQHWMrwz375fJ1K/PafUpA1R3+1o9B1wcQZvyMdtOGWx28xIOM
         GAEteEpPMLD+JXDNEbCZrUFFyzDHoudxnekFnBw1HMpEkQxcszoHQLQRQrOyHriv7FM4
         MpyRq96xq4AYm0B1iWaHjpeZJ1fc05u+5UrYtmzZnrn6pHK8+ZD/IGwM9rKCkKxEJSFX
         HMMofg0eU9Dy3uXPdL9jMW7dl+gksKPd+vCfAzvAnQgjQX2m0CDg9qP/D9oUVq9c4ZMp
         r/tu6HBOhhPZs9mPKXVomrZ/Tt0ZCFtElLM9I8ZVXzZ6dBzS8Tr0vVbgtFkEi/DUAzR7
         FlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147752; x=1767752552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8YLrdzFffswEZequkcqLVLtHoOFr/LoFxn5vu+m4fw=;
        b=YqKeTNvZiCDXHeUB5BUu+sH+5GWSvKBN+kE+6U/Sfwy/tq8H3j/zX9ZH4RGvaAZXp5
         ZmHJjZmw+PRL9EhE3cHlwrzMEmPXVXftX001NuZAYIUGtAKHoDIFP5CK2uqnUxowurR1
         V53nxRChWZHraKVLQ5KXkoKJuk9JHWHoMre8+JldUu3goMHVDqobBCjcIX0c4f6sgGON
         kk29SepEdNhx0P7TWuesC1hn/d8k1gBKA/7eoYB8j99UEkynXGo0qFXBZZzgQhHlw5tX
         e+0R45m/KAwSnng+LrhphQWiDWZJzz4fKgw688iuLrv9arNEItsbfqcpw+3T0OOYfmU4
         gtaw==
X-Gm-Message-State: AOJu0YzC00GsWXcx/2ceB+DAE2gMH0IrzU2IOlEree5isl2Kk91ETQLQ
	QY+xChyFXi7f6rv+Rxgj8pJTo/54nKQFZIVKn6nP0KMw8vT+bGcyFM9QbEC3vOE=
X-Gm-Gg: AY/fxX7doKulnrHpoeXPYCRaYLBL1I2IoqdowH8QMl0aWM7nuEXyQGLkldVOBpZMPD2
	FRUmT0vGQDDvoKt/DSnn/1XIszg4tv2L6dw0mNfHpEQ8CVKVXlr4LfmozYBNs7+NMSEuLLMHAdE
	2pEWB5ktM6xul1CwaGh6ov4FPgyFQ11/5oPmj2PxsvLscfji/c3hBxkFTWdYQms8L+Rqo7lh0qV
	X/LnDgsWgii5cintjw/u3k2yVAdv8HAGG5d9vYw3WqsSnPTUpGmPZySM3BbNaXcj9gyJGnAI2em
	KN+mnJrISssH7Wiz3KP5RIkqiVr+aWQE+Qvm+09U5AI4feGbQu1CKGhQN2tKHahoLN9NRMcSnwd
	qjq8l39Njun01EtzvVEWbMSizDAsSF+bJzzPBOKTZBpa5rvcg/gJCOHaPrzE0RV9+dSStrPykqE
	EgFlqlswwWZv7D4sjQIPGfQL8KpUUX3OGT9WXNVTXk4Z7K3WJv5qZdVhjw
X-Google-Smtp-Source: AGHT+IFndbbsnt7ctL9CPKuHSjHSfNoEcs1jXvQm/qh8P3NqzmjVzIK9Vfd5GqTRCbhsRiqrleMfdA==
X-Received: by 2002:a05:6a00:6ca0:b0:7f7:22a7:404f with SMTP id d2e1a72fcca58-7ff64cd4221mr28358183b3a.28.1767147752081;
        Tue, 30 Dec 2025 18:22:32 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:31 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 13/17] Fix handling of POSIX ACLs with zero ACEs
Date: Tue, 30 Dec 2025 18:21:15 -0800
Message-ID: <20251231022119.1714-14-rick.macklem@gmail.com>
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

The NFSv4.2 code does a SETATTR with a POSIX draft default ACL
of zero ACEs to delete the default ACL.  This patch fixes handling
of this case.

Note that the server code does not handle the case where
a file system is of ACL_SCOPE_FILE OBJECT (which means that
NFS4 and POSIX draft ACLs are mixed as the "true form" ACL
for different file objects in the file system).

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfs4proc.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a172bd253086..1dab7d3aa11e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1215,12 +1215,30 @@ nfsd4_proc_setacl(struct svc_rqst *rqstp, svc_fh *fh, struct inode *inode,
 
 	inode_lock(inode);
 
-	if (dpacl != NULL)
-		error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
-				      ACL_TYPE_DEFAULT, dpacl);
-	if (!error && pacl != NULL)
-		error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
-				      ACL_TYPE_ACCESS, pacl);
+	if (dpacl != NULL) {
+		/* a_count == 0 means delete the ACL. */
+		if (dpacl->a_count > 0)
+			error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
+					      ACL_TYPE_DEFAULT, dpacl);
+		else
+			error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
+					      ACL_TYPE_DEFAULT, NULL);
+	}
+	if (!error && pacl != NULL) {
+		/*
+		 * For any file system that is not ACL_SCOPE_FILE_OBJECT,
+		 * a_count == 0 MUST reply nfserr_inval.
+		 * For a file system that is ACL_SCOPE_FILE_OBJECT,
+		 * a_count == 0 means delete the ACL.
+		 * XXX File systems that are ACL_SCOPE_FILE_OBJECT
+		 * are not yet supported.
+		 */
+		if (pacl->a_count > 0)
+			error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
+					      ACL_TYPE_ACCESS, pacl);
+		else
+			error = -EINVAL;
+	}
 
 	inode_unlock(inode);
 	return nfserrno(error);
-- 
2.49.0


