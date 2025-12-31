Return-Path: <linux-nfs+bounces-17370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AF0CEB0A0
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7DDD300EA16
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CA61FC0EA;
	Wed, 31 Dec 2025 02:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW0hp+ee"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30298257851
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147734; cv=none; b=D5E68AjA92GCXGyo3z1JnOOdvLIskCX54llk4hkdbueXFz56PI5glahq9Jv/WXg9+h/EzXvadtscaaLER918AsgV19VtLUjQtBR0CTdkqs1QPN7/ybXS8PgW/AaYoVthuLwI8uDoueQKrLpuc9MH7oZwp7LnRDiNYUJbaORfnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147734; c=relaxed/simple;
	bh=SVQw+5HqGDz5CD33PZQXXYoZlMH68GWbcFezN0bDyOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YY1R2HYVWmC2hc3sAXRsw+AUgg0psFFbStivyOK7wYl3l1YqtQzMA5GrD1VIWmi2aO6zfqDhqqRj9Nfo0zKX0tPXRqL84eNEPI+Nxn6UrbyZdYSZzY4KSBisPVDs6qfB35waAE6HzJJH5CcRKQOL617GsmEytn1E8N4yzVkCHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW0hp+ee; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7f0da2dfeaeso11262110b3a.1
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147730; x=1767752530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq3NcbAmZ5bQFnNesv2bk8vQQZRu3yZLxVeAyQY7GtY=;
        b=GW0hp+eeJt8cWK/C9qgUK9PUeRgdTUkXocTiUj3edUfOlvYPxV6O/FUPknxsfCn8a9
         B1oIP/ZadZBN2PcDEtDsx1pBpR9IHxQlNrlQIKvoeq4C0j7iKRPA6fx/0WTVk8gq3Orj
         PY2wlEQia5sJlxOqRYx23mULS7ZnhbX5dGkMhPzzxYQ4tTgMmtN0a+wWBwS3RapqUSFE
         zskX/QWqUwQa6W1ivQm11Fy6x+prd5zRqkGr77t8/gTlr7ryosrj5ZAPfO82d8WyE0qx
         UJcqGXHUUy6RAbwbmrLCivjwj2KXXN4PuKI2SOFThh0R+ja31hus7yUf68X/Bv5Knhud
         hr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147730; x=1767752530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aq3NcbAmZ5bQFnNesv2bk8vQQZRu3yZLxVeAyQY7GtY=;
        b=g8Ew6eGJbOHz3+gGQ6z2JZ3X9quNN1aNUgq4Jg53Sje7mc1nigwOHIerqplEHGwHZC
         8WIVNZbu62cvcHs8VPUx3F5LDbtiLs8K00Hy156jItahBdW8T5HpsQ0UrioHuFPqSHLM
         iIgy6R2IfZmayxVQ2LkIbE+d4zv2kiKOU76676oQ6IeFU6OWWiERnEZ+LTAtkDe0s512
         2ejaiIW53ZPl7SK6Ud4knW6z66o4kGdb8XBQYN4xG13WBoQ0VQVx9z+Pl12Y2+HyDAap
         VLNKd75HG81GT9HKzzbRSFDtXApZ77vB4IZlPL18KTYZGgC3dn+aMVQ9E/N92z9aEnh7
         Bp3Q==
X-Gm-Message-State: AOJu0Yw8chOwB9tKkFDdTl2+vOcuNVWmlgUjzllF3XyOR0KMa6ZK7JK5
	gS0P9qdp8SNVjmg6sW1L16sf0t25f39Lmifhhl5TjVhL1rBzAAHe1zrkOVrqs3I7vg==
X-Gm-Gg: AY/fxX6vcijmGIJDsClWZa7IkRfJm8+6yVtzgoamYnXUx6yeuVmU89Ghtiq0dZkYosd
	CxI6sNw7itpzolL3M3WeDqDlv0p2JxSgB2ZGCiOUQvHL1y4OHVi1t/v/5+bNTEOsEk6yYuAlIm4
	IxtcT/Cw1crHtOy4uiEfEnKCP50sXXyIfkAfbbu7f0oYajrGkLFmBnErBwTURb9YOOM/xqPjNFV
	ltub/Lw+lyu9gPAe3OpqxEB/Ha7egZez8oxnHGqULvrKfVX9m2yhvxWtDtt9/o0OoBydmGXxxFN
	m74te/cn/6ZLM0EyoXErx82NNPsEt4pGM+rR5oS4hUtblp5xj9VsyusbH6WRUU61PfoPrdaRTII
	SDOhNY66e/uikUxJOaGQg9w6KN6+DPOcP9RqSNMKOt1jILEvvRr4TJlykIymUvp+c+Ged03nmOm
	yF5PkmjvkVosQ6OeilmWEIV0kmIhUkvRGMSnoT7be1tgBYM9uGlBvuq0Xl411YTNFc4B4=
X-Google-Smtp-Source: AGHT+IG4ZMPtfhpYALgDMsXngbVeEBhw4JdVnSkDaoHzxk7QkBlMeaza/c6GMYv/iJuJlwaXHs6TzA==
X-Received: by 2002:a05:6a00:4298:b0:7a2:8529:259 with SMTP id d2e1a72fcca58-7ff650c7d8dmr29771794b3a.9.1767147730420;
        Tue, 30 Dec 2025 18:22:10 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:10 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 03/17] Add a function to set POSIX ACLs
Date: Tue, 30 Dec 2025 18:21:05 -0800
Message-ID: <20251231022119.1714-4-rick.macklem@gmail.com>
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

This patch adds the function that sets a POSIX draft ACL
called nfsd4_proc_setacl() and calls it from nfsd4_setattr()
to set the POSIX draft ACLs when a SETATTR of the new
POSIX draft ACL attributes is done by a NFSv4.2 client.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfs4proc.c | 32 ++++++++++++++++++++++++++++++++
 fs/nfsd/xdr4.h     |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2b805fc51262..b92477c87db1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1162,6 +1162,31 @@ vet_deleg_attrs(struct nfsd4_setattr *setattr, struct nfs4_delegation *dp)
 	}
 }
 
+/*
+ * Set the Access and/or Default ACL of a file.
+ */
+static __be32
+nfsd4_proc_setacl(struct svc_rqst *rqstp, svc_fh *fh, struct inode *inode,
+		struct posix_acl *dpacl, struct posix_acl *pacl)
+{
+	int error = 0;
+
+	if (dpacl == NULL && pacl == NULL)
+		return nfs_ok;
+
+	inode_lock(inode);
+
+	if (dpacl != NULL)
+		error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
+				      ACL_TYPE_DEFAULT, dpacl);
+	if (!error && pacl != NULL)
+		error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
+				      ACL_TYPE_ACCESS, pacl);
+
+	inode_unlock(inode);
+	return nfserrno(error);
+}
+
 static __be32
 nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
@@ -1229,11 +1254,18 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	cstate->current_fh.fh_no_wcc = true;
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
 	cstate->current_fh.fh_no_wcc = save_no_wcc;
+	if (!status && (setattr->sa_dpacl != NULL || setattr->sa_pacl != NULL))
+		status = nfsd4_proc_setacl(rqstp, &cstate->current_fh, inode,
+					setattr->sa_dpacl, setattr->sa_pacl);
 	if (!status)
 		status = nfserrno(attrs.na_labelerr);
 	if (!status)
 		status = nfserrno(attrs.na_aclerr);
 out:
+	if (setattr->sa_dpacl != NULL)
+		posix_acl_release(setattr->sa_dpacl);
+	if (setattr->sa_pacl != NULL)
+		posix_acl_release(setattr->sa_pacl);
 	nfsd_attrs_free(&attrs);
 	fh_drop_write(&cstate->current_fh);
 	return status;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ae75846b3cd7..eebbcc579c31 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -483,6 +483,8 @@ struct nfsd4_setattr {
 	struct iattr	sa_iattr;           /* request */
 	struct nfs4_acl *sa_acl;
 	struct xdr_netobj sa_label;
+	struct posix_acl *sa_dpacl;
+	struct posix_acl *sa_pacl;
 };
 
 struct nfsd4_setclientid {
-- 
2.49.0


