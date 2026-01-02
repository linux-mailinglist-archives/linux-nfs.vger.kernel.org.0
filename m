Return-Path: <linux-nfs+bounces-17403-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42030CEF78A
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 00:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ABB93009F1B
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jan 2026 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E526D1F8AC8;
	Fri,  2 Jan 2026 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtAapF4C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569DF288514
	for <linux-nfs@vger.kernel.org>; Fri,  2 Jan 2026 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396637; cv=none; b=VkP9UFuAB76y2BS0G5UUl+9U1mD9HEijnHVaAUgPDF9+pC7teq/hxMC3YpdtwnSxzrb4BLSQdPj6t6RDTcaH5FKSurngdrRB++3cmyL/OLsanxl0TCmwIgvv134fod7E/05YWR4ZrsF9NmOkd0QjHwk7/VcLriqqvgqx+EivNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396637; c=relaxed/simple;
	bh=rUjSI6Onvd1J0UVmSWZdLBsHzaKJcJ4lBhkGc20jNaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhZiUO7ibqZzIy96iD+5R3l8cJSt4hy3OqwETlOiueLC7gOds2Za4o/fIv6KVlbwEuo1oa8q+HIn2eFBpXa9JX2aivcFDTaR+Yi9sAu/z5deWGpbxlpb3xELur7JcIkS0PMPSKm3juaac2fhLJG5CHcRHJT4jj2ymTHXCKVG3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtAapF4C; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a081c163b0so113762895ad.0
        for <linux-nfs@vger.kernel.org>; Fri, 02 Jan 2026 15:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767396636; x=1768001436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhhtwk+QsfgjLiFEziuVlErgGkl5GmJlgUVG7kF0ePI=;
        b=BtAapF4CrmH1jKOqaP3Wh3soEI8+OZJ5TdQVhuyc38ZoWlUl25zX+11l4KIFDjOpZU
         O5mvwbqKhc2K++52+H8CW1G1h6ySOZdlLRM2EeLz24AZgNhuAhFym6b013oWlmPvH9Jo
         +dlhGMs1qyBXZuSxi0GM7KIJfqfojsi7tfGJ7dlb4h4IYL8g4nvbOCgho2Qvxwar4kv5
         kiHfoq3Qp1kjA//VGlZT2gScsnoeOsvjeDJ3s3GaDd94Q+ZWZwv6Vawey2cDDyxc99Ml
         mWrmISOV+929cVggViV+Jih75fksK69WCgjdLAT2/a7EuCLESjbomWnPGVEdpe+J/6Xd
         wpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767396636; x=1768001436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qhhtwk+QsfgjLiFEziuVlErgGkl5GmJlgUVG7kF0ePI=;
        b=AiIv2QYEZJa151+SMgY+09QXda6DyyFu/5Z7pdJtTj+qXmb8SqHVCmZQQG7gvSwpBG
         lPid++KDVd1HOnqcXN8ii0JtOBnYGfPK8hqFLUx3sc/bIQDxMubpQZ55LTrUzsaxISFK
         aXGyDv3Jk5lQ11mJLGxgCrt2jIicZ6+cj8nTz7mnLLr35ysoOwsrpKIAiVXIAXVz+jeq
         a5fg5O7adG5o+0F7eEPcZzKBqrd+cnJRGUNyAPLPQ+Tu0pFvbEcFpayBQz8eshxyrF0s
         Bq+kHSU0qdCvTh5ncuLtZgT8LUuoQSKuoeKzKPDJj8Y3zyTxgFAUslSwDvzGDLwRsiaN
         +kVQ==
X-Gm-Message-State: AOJu0Yxc6M+ljIsG+8vDc/q2N/YskD1ZMlc2eC1LMjyvzaNiioF2VsiK
	ZXE677PEBHH8kay7XOqP4ysWsItWk8duSDxitNVVPy3rkHtn4gslWxPMdBYD4qw=
X-Gm-Gg: AY/fxX5cStE9+lX2V7+OW0Vub4EiP+PRiqA+mEqgflJjbm0wI+xeFrXZVD51s7z9SFR
	dfBm37XXf7NrSJT25KPWy0QwwnnJRY3Oc8Tz9gG2rq3h0IT64xtZx8/8cSfmaA6hUVGnirew85k
	hEUI9B+hAPiTvcD1Gg+AeibHUPsUQusAEjsm/Mf+OgRgJD1cqezItfrd9NbHBuxBvxGcWYV3e+5
	U69exFmwOa/wWpK+1ydySdFp7ARW1dWOXTAEVYUkyh24yCt4TvbpXZq2TkImNGx00xk5hDkfpF0
	1/YMA+f7bTSLsropIyyUzKOh+PmH8dGSgR+RM+UquReTaRjZeoIzVm8bFR3493P+16zctWNgVKs
	EeUGVWDxoqJ/58Qouf5QXc6pA/8kuttWo63hRKrQxyP4qTltnmAzELnypR6ZExQzS99pWvaz0xQ
	EUkbL+mPSVJjqjDIYxMp+v0aj/47dqENWdlLVq0MB05ak+KxVk4zZk/Aax0Yc9dJCh4+s=
X-Google-Smtp-Source: AGHT+IHwRGsk/X/BkHWrc3xZXXOm8khW70+tS7gn+fT8W96KsJVr4tAxanuuPHL/32EMj8MaCv98Sg==
X-Received: by 2002:a17:902:d2c4:b0:2a0:d662:7285 with SMTP id d9443c01a7336-2a2f1f789ffmr455127055ad.0.1767396635451;
        Fri, 02 Jan 2026 15:30:35 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c71853sm391508805ad.19.2026.01.02.15.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 15:30:34 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 5/7] Make nfs4_server_supports_acls() global
Date: Fri,  2 Jan 2026 15:29:32 -0800
Message-ID: <20260102232934.1560-6-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260102232934.1560-1-rick.macklem@gmail.com>
References: <20260102232934.1560-1-rick.macklem@gmail.com>
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
index 5ff8ab3f0f84..3b656086b452 100644
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


