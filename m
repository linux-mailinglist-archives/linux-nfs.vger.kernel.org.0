Return-Path: <linux-nfs+bounces-17373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9E1CEB0AC
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCD530221A9
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F27A2E36F1;
	Wed, 31 Dec 2025 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlN8IJ3t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8331FC0EA
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147739; cv=none; b=YZIgufVNnF5rUfTYYAX6nEtZI8WchX8LhzzuhbT1iCSDllgCY1Y8vexYvEqF6tInaOReulf1m10Ab6V75GuH2fdYq7fawu7YAHWSFT8kBtdPN6cVR+c8j5QyxPpcKP67N9ychkwf/vMRMr/IN7vOO6WPBNUVXRyofustT1aSZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147739; c=relaxed/simple;
	bh=zIu/002ghKFl3vk2NgM1rhExThv76+lwWD/Hmqb+ISU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUIafVthkCEa+4eMMTQibjEqozU1/wOQr5PBVV6fyiIjDHzXyDlGOepyUmpaHJK676khRubHx0ZjwBa3JbLjyW9a3lrB/GPJuj7v+vLps6GntKfuEQARRQYzsbt2h6F8j48bdIaHy7I8IKKQPrL+luqL7CDpwusNHSgiqzRaHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlN8IJ3t; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso7986794b3a.3
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147737; x=1767752537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPqpTeJYvne9S/rzjND4X66lSSHyyvDhex1XtaZ6drY=;
        b=YlN8IJ3tObMOzvR+5ARd30meMcGQHDnBGX8GAc/dmKRb7HlawF5dhYBghm5Fm8vPkM
         KX73V6xqW2W6Dfpshjv5jEDHyRXloTbdQ98Bj8M1abWzim3TyCObCtfj/a0WKpjxfxK8
         yjnGBhdYPdNE3gVIe748CJ1aT9hw0IVKPCwra/zn5d9HFXwwcwe4cpTG3rTEBlR5cxbd
         Zp5vIQSRbFo019LNp0gWrqZOdtdYApYPZvP0DK7J7n29SMzN1tdfcrI+YHt+fkL9X+HF
         3KNV2msaf1N5Rztr/JyoSATP1HD1lW3eSewK7kXztneIS8JPrvdYYAeHumMNvTDPEY+1
         Cv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147737; x=1767752537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yPqpTeJYvne9S/rzjND4X66lSSHyyvDhex1XtaZ6drY=;
        b=BH+KU0DzjtJy/f/JI02rtv3e+r8rjP13nfOctw+HTKq9uRPEoVyRjIZ79x6fZi+P+c
         I3IJYCDQDbBkCtmjvOyRCkZQDkAAckGtlqGSNPGe3T120kvso5HJcQh5Q04PjthbXDFI
         mroseO8M+ajmFS9x/8K3Ei2Pb79L0TfSpWbYM7VEn/YKf80yAcZ9S9ninWjhSq4FnofU
         xg3EmCcq4JMEWjMSy82O7sC6TZqqED6BgmAf0jvbqAn9V2IF6JxxjmIb33h9wwpZlQQh
         0+V5nBZIBnmSHKBS0BY/c5hwaDMxG/ioVk12UkJZdAbsus/GVKvmIe6uwTJuwC4TGk1x
         WS9Q==
X-Gm-Message-State: AOJu0Yym/TOb+SqgpESRvKxYPLlrvptAp7arJFYuCs+y1U+LlpR+mgUA
	h6ptyfktrHAQGWHLGmqKjfovuctW0dEJqjbsILAzUCPQIHs/5SmMRX5xVtnctv0=
X-Gm-Gg: AY/fxX4ZnBhn8KqOSF2sm+lMisjLa4L4Fgc+G6e3E7/cmagO0JTMpPvlro8TZOoO39j
	pw71GQYi4V6KlZbNHFuyhgdEjWMaIoTkrCyURTmPkMwux3/JQrS+E20JdW5jHfWw5aSUpXZa5bD
	cf+/0ML5mJ8iqtgPIYI7CVa8E5v3C0sk908i1LcaDtwvZ1t3wK1SzCL/CFRlxj296yL9YnVXxIP
	ja4TrSIyriom4DHiALeYgxe+KrNOwtPTDu51mUJhwz/o/XtEcKv4sesYxQa51oDglBj8yzWeHWV
	DpwbKYZZVxMnjlpp1iEsJLG6U83fabZzXMzMgjCcNozq//g5m7j+tJ0Lhg5gWwYSEnv4FveNyVe
	CEZA4aUgYD2R7uptEcBieibBbzi3nn43wj7Z/j07bTVPgJz+JAvTV5fUJe8Emg62PIYCWYm3J4M
	qjbd5emSY39faxX5f4fM9WJORzojOo0RqJygVnwdeXMEsBxJyz/LSwRzqr
X-Google-Smtp-Source: AGHT+IGyqjedNIcdhrNOPQMykBtYGSBZBMo3zQWu4uuLWxmp4pHh5GTsDxKfzTYPUlgke1V6yGUhZQ==
X-Received: by 2002:a05:6a00:3022:b0:7e8:43f5:bd49 with SMTP id d2e1a72fcca58-7ff6725883dmr33131727b3a.53.1767147737094;
        Tue, 30 Dec 2025 18:22:17 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:16 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 06/17] Add na_dpaclerr and na_paclerr for file creation
Date: Tue, 30 Dec 2025 18:21:08 -0800
Message-ID: <20251231022119.1714-7-rick.macklem@gmail.com>
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

When new file objects are created, a client might choose to specify
POSIX draft ACLs for it.  If the set_posix_acl() fails, note the
failure in these fields.  The file object has already been created,
so the creation cannot now fail, but the attribute bits can be cleared
in the reply.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/vfs.c | 6 +++---
 fs/nfsd/vfs.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 168d3ccc8155..146483bf8a65 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -597,12 +597,12 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_labelerr = security_inode_setsecctx(dentry,
 			attr->na_seclabel->data, attr->na_seclabel->len);
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl)
-		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
+		attr->na_paclerr = set_posix_acl(&nop_mnt_idmap,
 						dentry, ACL_TYPE_ACCESS,
 						attr->na_pacl);
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
-	    !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))
-		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
+				attr->na_dpacl && S_ISDIR(inode->i_mode))
+		attr->na_dpaclerr = set_posix_acl(&nop_mnt_idmap,
 						dentry, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
 out_fill_attrs:
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index e192dca4a679..26c4b396558a 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -54,6 +54,8 @@ struct nfsd_attrs {
 
 	int			na_labelerr;	/* output */
 	int			na_aclerr;	/* output */
+	int			na_dpaclerr;	/* output */
+	int			na_paclerr;	/* output */
 };
 
 static inline void nfsd_attrs_free(struct nfsd_attrs *attrs)
-- 
2.49.0


