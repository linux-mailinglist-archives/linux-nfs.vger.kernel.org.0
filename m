Return-Path: <linux-nfs+bounces-17429-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B0FCF0723
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 00:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2B2830072B4
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 23:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A52773C3;
	Sat,  3 Jan 2026 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT0zqSxT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A320322
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767483694; cv=none; b=mXXq00RoMifU26u9P5I/yntse8cPNhjomGzqUYIj5nIQsvJw6+zjcSUTpQSAlGihSv4Ck41/GdCuI7Rtp+X/lGwvninuu8eO4HtpUCr2mzupovVVrMwOmZvPAR91g1VEr0yVq/XaLkkIn8Z9IMdKYhUoJatAPnRIYvN5lf3me+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767483694; c=relaxed/simple;
	bh=8KzajKml905g8kx3GrQ5CYw2bPziS+4YfnkjE6Ux4Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbGTRfO4C5K38eg2dBdOYGw+dBuxTGpLp4iKwXjMADGe/T95+A5ELbkntJHsihQ+hk3XuwqF6j8JQfq0yEEraNfn66DBKUUYF5sF6uIElUImyAoAv+StcKsXVbTfeyLf3hmcCQqoQ/0FfSqncqRu/MNlKDGd9KMLYYuX9VOYbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT0zqSxT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aab7623f42so14229604b3a.2
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jan 2026 15:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767483692; x=1768088492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTyCwZbRLffJB6DG+jS6SMz+cAIlZiC88HiXq34nBik=;
        b=LT0zqSxTyFErclkXoaS6fr25TKvRTaT5GVjbnY8MeuUQVq1K8lw+sxvgP9s7W4orbF
         Y8S290m/kDztUxHL0oDPU7r93LCm1AAYB/kppfi24wL0WvA2uO7EA5XP/aG7DNSQKuWo
         wX3HCrOJSLfT/GQIsRIGotYtkxfg4c4JNqajjABJUUeo4ZnuAPAhcLvCxlmNubfM5P8D
         FRyG2ZKHdcTU3kRm3caTAPGL+/azvOypEklu4Rwvcl83XkrCdzxZEfwaQtqOLx8msfH7
         hZ8C5xgZcUITDHqbI+jdfXd9CveiiCPLDEyE5nPKGu7elYYcD+1Wx5+M7EBJpR2XI87V
         m+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767483692; x=1768088492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTyCwZbRLffJB6DG+jS6SMz+cAIlZiC88HiXq34nBik=;
        b=Rytwn+7CkXXXE2RSP79yQyZc9zdBxbRKR7K7UxytWesyOV+Ehjs8i0HM2qb4kEbmST
         msX4VThZJ1++IFA8z2V6Miu0tYt6W9g0G8D0+hKJDpYL/h0TILkXrYz94VF7Dkav/URj
         oQgG8RCQLBPLOSTs0tKfbtpWhowGF1xdcD6+dGLFNCNwdf9Rhwm6G1IcW4Alc6ERG5gF
         6qB9z3R3iWu16oo1UYWikYFuRCT3yzgxBJrEksC+1eU+2cSRcv9mnLZoR8TubK/jU1wP
         SRHA/DeHOqIk4lMGkxsNIPNpoPfPGxl9rWwzH2SN8BcCNvHx4a+rDTpIpi4MF/8S9ac5
         4J8Q==
X-Gm-Message-State: AOJu0YwVxIbrPbaaX3KecATq35qF6JraPvnA1+X5zDUiM1QSV7557GTj
	prJp3yxELPtXcrF73eBrF3yWHIpHOIsW+TjqQa383OfVqVAPyvl4wLAfKgY8380=
X-Gm-Gg: AY/fxX7SKcwoqPlgtQtGNJ0YB9ovh3fG09GMa/gnOXcFuEg2ViptbETowZFLEktdWVu
	YeQKJGQfr43/5cDZBoWBS+OTqF5PaLPIzePX4M+lFiVSeDPl8PyFB1zxtPXSSCVWdJuwTuj6C+9
	zZc28htwqa5JGdGLRihnCI9RDpgH1CoPwsGl6YjypH8CChAtTmStkCIWEngRaEVvOypzPE0E5qj
	3ykMGna+Bl2CUEt1taiJlxu2nmemA9rYY7RXaaehV/SUo+krA5xrqfMl4i+dcHXp7RvLdiSw8ZI
	uCg+ahO2IpR5lVVFz3klMh4yyv6GbMR6rwFW5rkXzEK1BmEbnt/HoDYTCreO8R86mqpbHmdzXPE
	gv801BX73MNs8LlHB9/MxgiBiaMTbEO14UeGiVqM3VblngeTKRC3YQ75VeeCe7BfdcBlxlE9bgj
	gO84KJg4NVXaDPy6uk3H53M4xNMq+D2+OHMs5w/zqcpnhvm8u9u4+zCpr1
X-Google-Smtp-Source: AGHT+IFp7aIS5JI7EQBCHDoK6UMzZ/owdT7wHNk7a2qUMzQak4OmfR6FpahGOKeaI15YM2NJNnL/Kw==
X-Received: by 2002:a05:6a20:4323:b0:358:dc7d:a2cc with SMTP id adf61e73a8af0-376a7af34c5mr40803380637.17.1767483691912;
        Sat, 03 Jan 2026 15:41:31 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm38472577a12.28.2026.01.03.15.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 15:41:30 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 6/8] Make nfs4_server_supports_acls() global
Date: Sat,  3 Jan 2026 15:40:30 -0800
Message-ID: <20260103234033.1256-7-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260103234033.1256-1-rick.macklem@gmail.com>
References: <20260103234033.1256-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Add support for the POSIX draft ACL attributes to
nfs4_server_supports_acls() and make it global,
so that support for POSIX draft ACLs can be checked
in nfs4proc.c.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfs/nfs4_fs.h        | 2 ++
 fs/nfs/nfs4proc.c       | 6 +++++-
 include/linux/nfs_xdr.h | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index c34c89af9c7d..19e3398d50f7 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -337,6 +337,8 @@ extern void nfs4_update_changeattr(struct inode *dir,
 				   struct nfs4_change_info *cinfo,
 				   unsigned long timestamp,
 				   unsigned long cache_validity);
+extern bool nfs4_server_supports_acls(const struct nfs_server *server,
+				      enum nfs4_acl_type type);
 extern int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
 				    struct page **pages);
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ec1ce593dea2..3057622ed61a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6069,7 +6069,7 @@ static int nfs4_proc_renew(struct nfs_client *clp, const struct cred *cred)
 	return 0;
 }
 
-static bool nfs4_server_supports_acls(const struct nfs_server *server,
+bool nfs4_server_supports_acls(const struct nfs_server *server,
 				      enum nfs4_acl_type type)
 {
 	switch (type) {
@@ -6079,6 +6079,10 @@ static bool nfs4_server_supports_acls(const struct nfs_server *server,
 		return server->attr_bitmask[1] & FATTR4_WORD1_DACL;
 	case NFS4ACL_SACL:
 		return server->attr_bitmask[1] & FATTR4_WORD1_SACL;
+	case NFS4ACL_POSIXDEFAULT:
+		return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL;
+	case NFS4ACL_POSIXACCESS:
+		return server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL;
 	}
 }
 
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e787de158fd9..1c21a1aac56f 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -832,6 +832,8 @@ enum nfs4_acl_type {
 	NFS4ACL_ACL,
 	NFS4ACL_DACL,
 	NFS4ACL_SACL,
+	NFS4ACL_POSIXDEFAULT,
+	NFS4ACL_POSIXACCESS,
 };
 
 struct nfs_setaclargs {
-- 
2.49.0


