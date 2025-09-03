Return-Path: <linux-nfs+bounces-14014-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D50B42A08
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 21:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253507B8D36
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 19:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141CC3629AC;
	Wed,  3 Sep 2025 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTso5ylS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8443680AD;
	Wed,  3 Sep 2025 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928087; cv=none; b=EURpSEewDZYEqiv+vbIrD3gYQ1AfdCG8HE2MCvR7ITzdQns+arPbkgMIdQvw6ZeRIWvcYnQezZmAGIHZ7YyApWrk3rogOuDvhCCeEtPzGCTx8TyvRwcH6WCo3OeUCmpGExogCty2ORs8MZUk5e3SWeZ+9kZeALCVcQUfPkbwSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928087; c=relaxed/simple;
	bh=od0iOEyF9QpRrHdG1LYp/fOb6P41PETICpxHH3SYReQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwKpnRah6+rsLryH4wCyx4ITj1RVNoCjTsFk4g59nEgps6W6PTYskHuEQvU1LgRs4WlU+lri0UWp90rdfMoPZRgVcAIt+ec2edLdxzyxniwNKSk+yFY1hx7UhZPefdwx1l8L2wC7fHjcl0Qo1lMqptIMEEIsTonKkiMPOR+0mrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTso5ylS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6f7edf45so190465e87.2;
        Wed, 03 Sep 2025 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756928083; x=1757532883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YhoPZ3kKabKK8oSei6TeoqSwcdOczo6L1cK0Io5ZzOU=;
        b=WTso5ylSryc8QNwnECV8zHhLGl0JyebO7whT5ymiA66ZdWgP+cJ+/m796k9YQHO6P4
         PfAw6IqV8cHfuSUCPZvug0yjbJrctlcpjnAEBripMvyp0xYilLpmHnOopkONykBoYCZq
         0gIjfRBowQDpnJkOuGyHj2jqWCBMDDyhoV7JVZjujFx5lGi51k1kT0D5zPGiNdltGVua
         sr5jAQlunlV946Kl3weKyyiHjV8MnpwmmsXauQhvZ5QxptoMoBXy2z9bHtG/6dq0wPG8
         KQ1rTQ0MxyXbrgFTdQaT2S3OVHQkNNoRSnzHVi9nSJFUWQ5/DRtA1mJsB3IRKSLI6oeq
         biCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756928083; x=1757532883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhoPZ3kKabKK8oSei6TeoqSwcdOczo6L1cK0Io5ZzOU=;
        b=Q3NycwSHaFDi1FHjRFCZDDNEdXWJqaLgKm5zde0S8yIfLZoaN0iLmbNGfM+Y2Q4zd/
         CVh3wdOlXjTRycAZTS/nkFRxxS14SzyWjvxThZgJ3hQnK0O7TwNh0iaRUS98E+aAxvei
         2k2OgCujjv+Cn/Op2P46HQHhq5yC6G9GO3B+nl8IHg6ziQ7cOU8jXdoalzOvl1ZNreHz
         VupxsrKy8jK3Z6LxTIISaOQf3s3CHjkbe4v2LYMaihsJC40ynX/TTe6/WR8Q8zFWDTex
         2fCbHCN1cjjs3NCfC/94Kmu0yN+aKZ1EyU1APcGrtgnsOcd3misGbPPBtgIIfka06B3F
         UEdg==
X-Forwarded-Encrypted: i=1; AJvYcCVSwyd1RPkX624zbZN3Wd5AwgJ2CA9rJlO+PQRw0a+Ou251GHO3llokhRnb0vtO1aamrU/f+9IIqd/tUwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwkZhXagHi0H0sswHaC0wNNwFO5jVm/eOZFWGyTHmMn2tVgXt
	WeFookO5vK9iuOA+zCN/BhQdPCBmBuKCSlM+kKpgLFAcXS0tAKHz/WAY
X-Gm-Gg: ASbGncsQYKdqIGN/JD+1OIAvMuCGv8YKYIJyyQ6zfBo3pAam/UDmSZXofz2mGel0sOM
	aeJiOylzusn+5grCLsccAi6Bg4P9lb6Db8omvRznSkgVMcV2jd4VdN97zmHIZvVIGTOqckqA6o+
	gowmKEtsZ4jvH5TJ8RNzPLqLJ+d2kmGcZQuIgvcgfRbEFPnRLUBYJ9wHMwVw7sc/iWNT/CX6Xc+
	ewDlkWKdESg4/TGnXn8d2WZst+YZyNqhFhIVEnWbMpOa6Ud/Te4QtQMCcyMb8D1EiNnF+rxmUfT
	DrtFTG3ujrrq1Q5Be13MPLgRvpUnv/jaxXSDFGqwRhbB6wbH3jLsOyffYi2n1wJQvDHlEkc4gqo
	gLwT50rWhA9al8MfvN4NIrB0LFP8j3tVNY491F8nt1allvmEFpDYY
X-Google-Smtp-Source: AGHT+IH53+Pe/rLVNPa4pTx6F4mHwzKqIBoVE9zH5oUFhoPYZcYHAHSykvrKWge0h4IW+cPiwTLC+A==
X-Received: by 2002:a05:6512:1390:b0:55f:33e0:9602 with SMTP id 2adb3069b0e04-55f708a3a29mr5464842e87.9.1756928082878;
        Wed, 03 Sep 2025 12:34:42 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([95.220.211.111])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd3e9sm673862e87.110.2025.09.03.12.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:34:42 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: [PATCH v2] NFSD: Disallow layoutget during grace period
Date: Wed,  3 Sep 2025 22:34:24 +0300
Message-ID: <20250903193438.62613-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the block/scsi layout server is recovering from a reboot and is in a
grace period, any operation that may result in deletion or reallocation of
block extents should not be allowed. See RFC 8881, section 18.43.3.

If multiple clients write data to the same file, rebooting the server
during writing can result in the file corruption. Observed this behavior
while testing pNFS block volume setup.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Changes in v2:
 - Push down the check to layout driver level

 fs/nfsd/blocklayout.c    | 8 +++++++-
 fs/nfsd/flexfilelayout.c | 2 +-
 fs/nfsd/nfs4proc.c       | 3 ++-
 fs/nfsd/pnfs.h           | 2 +-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 0822d8a119c6..1fbc5bbde07f 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -19,7 +19,7 @@
 
 static __be32
 nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
-		struct nfsd4_layoutget *args)
+		struct nfsd4_layoutget *args, bool in_grace)
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
@@ -34,6 +34,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
 		goto out_layoutunavailable;
 	}
 
+	if (in_grace)
+		goto out_grace;
+
 	/*
 	 * Some clients barf on non-zero block numbers for NONE or INVALID
 	 * layouts, so make sure to zero the whole structure.
@@ -111,6 +114,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
 out_layoutunavailable:
 	seg->length = 0;
 	return nfserr_layoutunavailable;
+out_grace:
+	seg->length = 0;
+	return nfserr_grace;
 }
 
 static __be32
diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 3ca5304440ff..274a1e9bb596 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -21,7 +21,7 @@
 
 static __be32
 nfsd4_ff_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
-		struct nfsd4_layoutget *args)
+		struct nfsd4_layoutget *args, bool in_grace)
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	u32 device_generation = 0;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d7c58aa64f06..5d1d343a4e23 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2435,6 +2435,7 @@ static __be32
 nfsd4_layoutget(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
 {
+	struct net *net = SVC_NET(rqstp);
 	struct nfsd4_layoutget *lgp = &u->layoutget;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
@@ -2498,7 +2499,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 		goto out_put_stid;
 
 	nfserr = ops->proc_layoutget(d_inode(current_fh->fh_dentry),
-				     current_fh, lgp);
+				     current_fh, lgp, locks_in_grace(net));
 	if (nfserr)
 		goto out_put_stid;
 
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index dfd411d1f363..61c2528ef077 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -30,7 +30,7 @@ struct nfsd4_layout_ops {
 			const struct nfsd4_getdeviceinfo *gdevp);
 
 	__be32 (*proc_layoutget)(struct inode *, const struct svc_fh *fhp,
-			struct nfsd4_layoutget *lgp);
+			struct nfsd4_layoutget *lgp, bool in_grace);
 	__be32 (*encode_layoutget)(struct xdr_stream *xdr,
 			const struct nfsd4_layoutget *lgp);
 
-- 
2.43.0


