Return-Path: <linux-nfs+bounces-17431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1AACF0729
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 00:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 996E53007296
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 23:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC632773C3;
	Sat,  3 Jan 2026 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlYsxbWS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB872C21FA
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767483699; cv=none; b=Uy3w0OQA96C1XkDDosuF20RyX4kB+FcY6YdDKpc6aQUovxz79unGy/5B/Mx7Lxoq130AemMTyVs6yMa0mtlLfZnv8G1QqMfNztddf5by0VyCusA8nFIrora3TXhPSTJ/Nav3tFpHmlZ3ot5SJ58dzhgsdQE0iv5RlqFyjgPSfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767483699; c=relaxed/simple;
	bh=MeC24JUSgKJE1Vng2tcv9AEvvcrWFEVXTNsGAIE6pGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmYz9o52nqvZAwLDXK8uV3yxVjCrfDPfSJi4x6jaFUiPDYz86u5wKub9HR2bi1PVzRMg68P3ufR4KsKgI5mEdQM8gjx2tlevATcH1H2elAw6uN4qZ4+74g3QlTfJ3TxgozBwVQIMLdeX1/J5B06o1l8Gv1PUrLZrQLZvqKFRQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlYsxbWS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7f121c00dedso17286553b3a.0
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jan 2026 15:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767483697; x=1768088497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFoR23QTnItvlkSNa1Mk9p53HZ7Qx6OZWaSOCUBDiig=;
        b=GlYsxbWSIQ05TNF+ChuKiVksTL286iwjWcaKtgCDDxtlQK3bhcqcyWdNEjJmiwPjRc
         wB1YwYhBUCtwz2bLoOSPSj4dcyDM0lj1DtefZW/rUmNri7fEO9MDdsTdRoZv13Vrg+5K
         mEp0PwICsMaz8XyktJ7ocQdmiT2mn0ibyFaILhfRriKikMbO4gGMtaNELS3XRA32wkP9
         HCyLUgO3vh4HXrI+K1oQWvhFsq7FRk3wOwNRc3kHv6jBQ/rmIdTxH/AoZBpSHeMoid0W
         Rj5g5Dt88xtk7FlMDL1+Rof6xKYU9wsnBAcHtLIc+bQdoTscbpXZXr5eqAmmFjnqi2RN
         IDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767483697; x=1768088497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFoR23QTnItvlkSNa1Mk9p53HZ7Qx6OZWaSOCUBDiig=;
        b=T04PwZRtnOMC7l+6yr/aNMQHiF97b9Apsfn1REsyzK6l/dvbZizdPNGlj0tXH0KG2D
         TyOO1V11vHHRIkrB55fPRMu7cr4zvKQ2u7VQm5a5W/qcXqiesaspbHA/+3f5sxxPZiB5
         s56e3WL3L0/Yk+DutRDjP434/ZIyRYHU5o/DYwBzwIeqzZ4soef/CWaY8AmmxE1STWwR
         5x2vU6lhPCKCYgmH7UPbX8Nd0VgjiRNjGRtV8oU/0heFQI/ZDAZnX/O3WRE9WBBT2KES
         C5gAlRvAJ+kX7gWjrTltYsCJuKRgcMtUwRIZrD7P6aBUPOtY8zmmmhSjBwCAJyhklr0B
         dytA==
X-Gm-Message-State: AOJu0YzzvG+KQjmB6j37RBTezEuUcHfK4gD06RgV5rNN9PED3k6Wn7AS
	bo9eD1Mas4pjPBnRN/Sg2+ZE8xCxZcPrrnnmJg7WZi7+9F0VG19P8KrxxZMXMbE=
X-Gm-Gg: AY/fxX7PF9/I/XB71u5sxHp2L1e4LIUKasyMpd+BYzd8vl1E3cCvFK8XISZg0VNmNpm
	y5WnCuEbaZ3efyBFYEPQtSKNmgwtY4w6aPqM4KT084PKxWI9xACSOWf1K+fac7mtk5yB3Ccl6n1
	kbe4xqSo1Dm1cW6394w62UZ9YDCYIoE9n/vYLpfgydkEBOuvwDxa/xkb6A3spEQITLzivnPPV1S
	i1PQ+rl/iiWJGE0+Y7DLFHT3iUH+BGmdGKGde/oj1ISEl94p84Kzc+XR039vexckmrwQu6MzhbK
	/Ggcqka6/GVWAlvKSoc8N5XKknQT8gz2BW/sQ++ecZKuvsx2WbkvvDBY6Qo3nuSoGSv0qaUfidz
	l41MGdEVKOq8yIK1qF8cluEoritN4lNndewZ2S+wvGQeLSBjeo9AaMST/YsTTyPOSPGzfYbprVy
	jN3wGKPN74HS2bQUq1Ll6YLPyuxvv7uMMYeL2298olPDi2EBwh/gsz2TO0m1nMQwXP+D0=
X-Google-Smtp-Source: AGHT+IHTPOSpGmrzzr0z8cbcOXwhOccsd6cZpXD0KnzshLA51VB2oNHSNeDy1GiBz05GAVUjg4fYlQ==
X-Received: by 2002:a05:6a20:394a:b0:350:9b6b:8ea8 with SMTP id adf61e73a8af0-376aa4fc508mr45430638637.51.1767483696439;
        Sat, 03 Jan 2026 15:41:36 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm38472577a12.28.2026.01.03.15.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 15:41:35 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 8/8] Add support for the NFSv4.2 POSIX draft ACL attributes
Date: Sat,  3 Jan 2026 15:40:32 -0800
Message-ID: <20260103234033.1256-9-rick.macklem@gmail.com>
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

The internet draft
"POSIX Draft ACL support for Network File System Version 4,
Minor Version 2" describes
four new attributes that are extensions to the NFSv4.2 protocol.
These new attributes provide support for POSIX draft ACLs without
any need for mapping to/from NFSv4 ACLs.

This extension allows the getfacl(1)/setfacl(1) commands to work
over an NFSv4.2 mount where the client and server support the
extension.

This patch adds new procedures for getting/setting POSIX draft
ACLs, along with the XDR encoding/decoding needed for the
attributes.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfs/nfs42proc.c | 304 +++++++++++++++++++++
 fs/nfs/nfs42xdr.c  | 642 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h   |   7 +
 fs/nfs/nfs4proc.c  |  12 +-
 fs/nfs/nfs4xdr.c   |   2 +
 5 files changed, 965 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index d537fb0c230e..52a06e031fce 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -11,10 +11,12 @@
 #include <linux/nfs_xdr.h>
 #include <linux/nfs_fs.h>
 #include "nfs4_fs.h"
+#include "nfs.h"
 #include "nfs42.h"
 #include "iostat.h"
 #include "pnfs.h"
 #include "nfs4session.h"
+#include "nfs4idmap.h"
 #include "internal.h"
 #include "delegation.h"
 #include "nfs4trace.h"
@@ -1638,6 +1640,308 @@ ssize_t nfs42_proc_listxattrs(struct inode *inode, void *buf,
 	return err;
 }
 
+static int _nfs4_proc_getposixacl(struct nfs42_getposixaclargs *arg,
+				struct nfs42_getposixaclres *res,
+				struct rpc_message *msg,
+				struct nfs_server *server,
+				struct inode *inode)
+{
+	struct nfs4_exception exception = {
+		.interruptible = true,
+	};
+	int err;
+	do {
+		err = nfs4_call_sync(server->client, server, msg,
+					&arg->seq_args, &res->seq_res, 0);
+		err = nfs4_handle_exception(server, err,
+				&exception);
+	} while (exception.retry);
+	return err;
+}
+
+struct posix_acl *nfs4_get_posixacl(struct inode *inode, int type, bool rcu)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct page *pages[NFS4_ACL_MAXPAGES] = { };
+	struct nfs42_getposixaclargs args = {
+		.fh = NFS_FH(inode),
+		/* The xdr layer may allocate pages here. */
+		.pages = pages,
+	};
+	struct nfs42_getposixaclres res = {
+		.server = server,
+	};
+	struct rpc_message msg = {
+		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_GETPOSIXACL],
+		.rpc_argp = &args,
+		.rpc_resp = &res,
+	};
+	int status, count;
+
+	if (rcu)
+		return ERR_PTR(-ECHILD);
+
+	/*
+	 * Check that NFS4ACL_POSIXDEFAULT and NFS4ACL_POSIXACCESS
+	 * attributes are supported by the server.
+	 * We get acl_trueform and return EOPNOTSUPP if the acl_trueform
+	 * is not POSIX_DRAFT_ACL.  This allows the case where the
+	 * acl_trueform's scope is file object to work when the acl_trueform
+	 * is not POSIX_DRAFT_ACL.
+	 */
+	if (!nfs4_server_supports_acls(server, NFS4ACL_POSIXDEFAULT) ||
+	    !nfs4_server_supports_acls(server, NFS4ACL_POSIXACCESS))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	status = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
+	if (status < 0)
+		return ERR_PTR(status);
+
+	/*
+	 * Only get the access acl when explicitly requested: We don't
+	 * need it for access decisions, and only some applications use
+	 * it. Applications which request the access acl first are not
+	 * penalized from this optimization.
+	 */
+	if (type == ACL_TYPE_ACCESS)
+		args.mask |= NFS_ACLCNT|NFS_ACL;
+	if (S_ISDIR(inode->i_mode))
+		args.mask |= NFS_DFACLCNT|NFS_DFACL;
+	if (args.mask == 0)
+		return NULL;
+
+	if (args.mask & NFS_ACL)
+		nfs34_prepare_get_acl(&inode->i_acl);
+	if (args.mask & NFS_DFACL)
+		nfs34_prepare_get_acl(&inode->i_default_acl);
+
+	status = _nfs4_proc_getposixacl(&args, &res, &msg, server, inode);
+
+	/* pages may have been allocated at the xdr layer. */
+	for (count = 0; count < NFS4_ACL_MAXPAGES && args.pages[count]; count++)
+		__free_page(args.pages[count]);
+
+	switch (status) {
+		case 0:
+			break;
+		case -EPFNOSUPPORT:
+		case -EPROTONOSUPPORT:
+			fallthrough;
+		case -ENOTSUPP:
+			status = -EOPNOTSUPP;
+			goto getout;
+		default:
+			goto getout;
+	}
+	if ((args.mask & res.mask) != args.mask) {
+		status = -EIO;
+		goto getout;
+	}
+
+	if (res.acl_access != NULL) {
+		if ((posix_acl_equiv_mode(res.acl_access, NULL) == 0) ||
+		    res.acl_access->a_count == 0) {
+			posix_acl_release(res.acl_access);
+			res.acl_access = NULL;
+		}
+	}
+
+	if (res.mask & NFS_ACL)
+		nfs34_complete_get_acl(&inode->i_acl, res.acl_access);
+	else
+		forget_cached_acl(inode, ACL_TYPE_ACCESS);
+
+	if (res.mask & NFS_DFACL)
+		nfs34_complete_get_acl(&inode->i_default_acl, res.acl_default);
+	else
+		forget_cached_acl(inode, ACL_TYPE_DEFAULT);
+
+	if (type == ACL_TYPE_ACCESS) {
+		posix_acl_release(res.acl_default);
+		return res.acl_access;
+	} else {
+		posix_acl_release(res.acl_access);
+		return res.acl_default;
+	}
+
+getout:
+	nfs34_abort_get_acl(&inode->i_acl);
+	nfs34_abort_get_acl(&inode->i_default_acl);
+	posix_acl_release(res.acl_access);
+	posix_acl_release(res.acl_default);
+	return ERR_PTR(status);
+}
+
+static int _nfs4_set_posixacl(struct inode *inode, struct posix_acl *acl,
+			struct posix_acl *dfacl)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct page *pages[NFS4_ACL_MAXPAGES];
+	struct nfs42_setposixaclargs args = {
+		.server = NFS_SERVER(inode),
+		.fh = NFS_FH(inode),
+		.inode = inode,
+		.mask = NFS_ACL,
+		.acl_access = acl,
+	};
+	struct nfs42_setposixaclres res = {
+		.server = server,
+	};
+	struct rpc_message msg = {
+		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_SETPOSIXACL],
+		.rpc_argp = &args,
+		.rpc_resp = &res,
+	};
+	struct nfs4_exception exception = {
+		.interruptible = true,
+	};
+	struct nfs_xdr_putpage_desc desc = {
+		.pages = pages,
+		.max_npages = NFS4_ACL_MAXPAGES,
+	};
+	size_t argslen;
+	int idmax, status = 0;
+
+	if (acl == NULL && (!S_ISDIR(inode->i_mode) || dfacl == NULL))
+		goto out;
+
+	status = -EOPNOTSUPP;
+	/*
+	 * Check that NFS4ACL_POSIXDEFAULT and NFS4ACL_POSIXACCESS
+	 * attributes are supported by the server.
+	 * We get acl_trueform and return EOPNOTSUPP if the acl_trueform
+	 * is not POSIX_DRAFT_ACL.  This allows the case where the
+	 * acl_trueform's scope is file object to work when the acl_trueform
+	 * is not POSIX_DRAFT_ACL.
+	 */
+	if (!nfs4_server_supports_acls(server, NFS4ACL_POSIXDEFAULT) ||
+	    !nfs4_server_supports_acls(server, NFS4ACL_POSIXACCESS))
+		goto out;
+
+	idmax = (XDR_QUADLEN(IDMAP_NAMESZ) << 2);
+	argslen = 0;
+	status = -ENOSPC;
+	if (acl != NULL) {
+		if (acl->a_count > NFS_ACL_MAX_ENTRIES)
+			goto out;
+		argslen += ((1 + (3 * acl->a_count)) << 2);
+		if (acl->a_count > 4)
+			argslen += (acl->a_count - 4) * idmax;
+	}
+	if (dfacl != NULL && dfacl->a_count > NFS_ACL_MAX_ENTRIES)
+		goto out;
+	if (S_ISDIR(inode->i_mode)) {
+		args.mask |= NFS_DFACL;
+		args.acl_default = dfacl;
+		if (dfacl != NULL) {
+			argslen += ((1 + (3 * dfacl->a_count)) << 2);
+			if (dfacl->a_count > 4)
+				argslen += (dfacl->a_count - 4) * idmax;
+		} else {
+			argslen += 4;
+		}
+	}
+
+	do {
+		/*
+		 * We do not know how many pages will be needed for a large ACL,
+		 * so additional pages are allocated, as required.
+		 */
+		if (argslen > NFS4_ACL_INLINE_BUFSIZE) {
+			ssize_t ret, size;
+
+			status = -ENOMEM;
+			size = 0;
+			if (args.mask & NFS_DFACL)
+				size = nfs42_encode_posixacl(server, &desc,
+							dfacl);
+			if (size < 0)
+				goto out_freepages;
+			if ((args.mask & NFS_ACL) && size >= 0) {
+				ret = nfs42_encode_posixacl(server, &desc, acl);
+				if (ret < 0)
+					goto out_freepages;
+				size += ret;
+			}
+			args.len = size;
+			args.pages = desc.pages;
+		}
+
+		status = nfs4_call_sync(server->client, server, &msg,
+					&args.seq_args, &res.seq_res, 0);
+		status = nfs4_handle_exception(server, status, &exception);
+		if (exception.retry) {
+			/* Reset to beginning of page array. */
+			desc.page_pos = 0;
+			desc.p = NULL;
+			desc.endp = NULL;
+		}
+	} while (exception.retry);
+	nfs_access_zap_cache(inode);
+	nfs_zap_acl_cache(inode);
+
+	switch (status) {
+		case 0:
+			break;
+		case -EPFNOSUPPORT:
+		case -EPROTONOSUPPORT:
+			dprintk("NFS_V4_ACL SETACL RPC not supported"
+					"(will not retry)\n");
+			server->caps &= ~NFS_CAP_ACLS;
+			fallthrough;
+		case -ENOTSUPP:
+			status = -EOPNOTSUPP;
+	}
+out_freepages:
+	if (desc.npages > 0)
+		nfs_xdr_putpage_cleanup(&desc);
+out:
+	return status;
+}
+
+int nfs4_set_posixacl(struct mnt_idmap *idmap, struct dentry *dentry,
+		 struct posix_acl *acl, int type)
+{
+	struct posix_acl *orig = acl, *dfacl = NULL, *alloc;
+	struct inode *inode = d_inode(dentry);
+	int status;
+
+	if (S_ISDIR(inode->i_mode)) {
+		switch(type) {
+		case ACL_TYPE_ACCESS:
+			alloc = get_inode_acl(inode, ACL_TYPE_DEFAULT);
+			if (IS_ERR(alloc))
+				goto fail;
+			dfacl = alloc;
+			break;
+		case ACL_TYPE_DEFAULT:
+			alloc = get_inode_acl(inode, ACL_TYPE_ACCESS);
+			if (IS_ERR(alloc))
+				goto fail;
+			dfacl = acl;
+			acl = alloc;
+		}
+	}
+
+	if (acl == NULL) {
+		alloc = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
+		if (IS_ERR(alloc))
+			goto fail;
+		acl = alloc;
+	}
+	status = _nfs4_set_posixacl(inode, acl, dfacl);
+out:
+	if (acl != orig)
+		posix_acl_release(acl);
+	if (dfacl != orig)
+		posix_acl_release(dfacl);
+	return status;
+
+fail:
+	status = PTR_ERR(alloc);
+	goto out;
+}
+
 int nfs42_proc_removexattr(struct inode *inode, const char *name)
 {
 	struct nfs4_exception exception = { };
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index e10d83ba835e..3c92cdbceb0e 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -269,6 +269,33 @@
 					 decode_putfh_maxsz + \
 					 decode_removexattr_maxsz)
 
+#define encode_getposixacl_maxsz (encode_getattr_maxsz)
+#define decode_getposixacl_maxsz (op_decode_hdr_maxsz + \
+				 nfs4_fattr_bitmap_maxsz + \
+				 XDR_QUADLEN(NFS4_ACL_INLINE_BUFSIZE) + \
+				 pagepad_maxsz)
+#define encode_setposixacl_maxsz (op_encode_hdr_maxsz + \
+				 encode_stateid_maxsz + \
+				 nfs4_fattr_bitmap_maxsz + 1 + \
+				 XDR_QUADLEN(NFS4_ACL_INLINE_BUFSIZE))
+#define decode_setposixacl_maxsz (decode_setattr_maxsz)
+#define NFS4_enc_getposixacl_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_getposixacl_maxsz)
+#define NFS4_dec_getposixacl_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_getposixacl_maxsz)
+#define NFS4_enc_setposixacl_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_setposixacl_maxsz)
+#define NFS4_dec_setposixacl_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_setposixacl_maxsz)
+
 /*
  * These values specify the maximum amount of data that is not
  * associated with the extended attribute name or extended
@@ -1797,6 +1824,621 @@ static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
 	return status;
 }
 
+static int
+nfsacl4_posix_tagtotype(u32 tag)
+{
+	int type;
+
+	switch(tag) {
+	case ACL_USER_OBJ:
+		type = POSIXACE4_TAG_USER_OBJ;
+		break;
+	case ACL_GROUP_OBJ:
+		type = POSIXACE4_TAG_GROUP_OBJ;
+		break;
+	case ACL_USER:
+		type = POSIXACE4_TAG_USER;
+		break;
+	case ACL_GROUP:
+		type = POSIXACE4_TAG_GROUP;
+		break;
+	case ACL_MASK:
+		type = POSIXACE4_TAG_MASK;
+		break;
+	case ACL_OTHER:
+		type = POSIXACE4_TAG_OTHER;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return type;
+}
+
+static int xdr_nfs4ace_stream_encode(struct xdr_stream *xdr,
+				     const struct nfs_server *server,
+				     struct posix_acl_entry *acep)
+{
+	char owner[IDMAP_NAMESZ];
+	int len, size, type;
+
+	type = nfsacl4_posix_tagtotype(acep->e_tag);
+	if (type < 0)
+		return -EINVAL;
+	if (xdr_stream_encode_u32(xdr, type) < 0)
+		return -EINVAL;
+	if (xdr_stream_encode_u32(xdr, acep->e_perm) < 0)
+		return -EINVAL;
+	size = 2 * XDR_UNIT;
+	switch(acep->e_tag) {
+	case ACL_USER_OBJ:
+	case ACL_GROUP_OBJ:
+	case ACL_MASK:
+	case ACL_OTHER:
+		if (xdr_stream_encode_u32(xdr, 0) < 0)
+			return -EINVAL;
+		size += XDR_UNIT;
+		break;
+	case ACL_USER:
+		len = nfs_map_uid_to_name(server, acep->e_uid, owner,
+					  IDMAP_NAMESZ);
+		if (len < 0) {
+			dprintk("nfs: couldn't resolve uid %d to str\n",
+				from_kuid(&init_user_ns, acep->e_uid));
+			return -EINVAL;
+		}
+		if (xdr_stream_encode_opaque(xdr, owner, len) < 0)
+			return -EINVAL;
+		size += XDR_UNIT + (XDR_QUADLEN(len) << 2);
+		break;
+	case ACL_GROUP:
+		len = nfs_map_gid_to_group(server, acep->e_gid, owner,
+					 IDMAP_NAMESZ);
+		if (len < 0) {
+			dprintk("nfs: couldn't resolve gid %d to str\n",
+				from_kgid(&init_user_ns, acep->e_gid));
+			return -EINVAL;
+		}
+		if (xdr_stream_encode_opaque(xdr, owner, len) < 0)
+			return -EINVAL;
+		size += XDR_UNIT + (XDR_QUADLEN(len) << 2);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return size;
+}
+
+static int encode_stream_posixacl(struct xdr_stream *xdr, struct posix_acl *acl,
+				const struct nfs_server *server)
+{
+	unsigned int cnt;
+	int ret, size;
+
+	if (acl == NULL) {
+		if (xdr_stream_encode_u32(xdr, 0) < 0)
+			return -EINVAL;
+		return XDR_UNIT;
+	}
+	if (acl->a_count > NFS_ACL_MAX_ENTRIES)
+		return -EINVAL;
+	if (xdr_stream_encode_u32(xdr, acl->a_count) < 0)
+		return -EINVAL;
+	size = XDR_UNIT;
+
+	for (cnt = 0; cnt < acl->a_count; cnt++) {
+		ret = xdr_nfs4ace_stream_encode(xdr, server,
+						&acl->a_entries[cnt]);
+		if (ret < 0)
+			return ret;
+		size += ret;
+	}
+
+	return size;
+}
+
+static bool nfs_xdr_putpage_bytes(struct nfs_xdr_putpage_desc *desc,
+		void *bytes, size_t len)
+{
+	size_t tmp, xfer;
+
+	while (len > 0) {
+		if (desc->p == desc->endp) {
+			/* Need to move on to the next page. */
+			if (desc->page_pos == desc->npages) {
+				/* Needs a new page. */
+				if (desc->npages == desc->max_npages)
+					return false;
+				desc->pages[desc->npages] =
+						alloc_page(GFP_KERNEL);
+				if (desc->pages[desc->npages] == NULL)
+					return false;
+				desc->npages++;
+			}
+			desc->p = page_address(desc->pages[desc->page_pos]);
+			desc->endp = desc->p + PAGE_SIZE;
+			desc->page_pos++;
+		}
+		tmp = desc->endp - desc->p;
+		xfer = (tmp < len) ? tmp : len;
+		memcpy(desc->p, bytes, xfer);
+		bytes += xfer;
+		desc->p += xfer;
+		len -= xfer;
+	}
+	return true;
+}
+
+static bool nfs_xdr_putpage_word(struct nfs_xdr_putpage_desc *desc, u32 val)
+{
+	__be32 beval;
+
+	beval = cpu_to_be32(val);
+	return nfs_xdr_putpage_bytes(desc, &beval, sizeof(beval));
+}
+
+void nfs_xdr_putpage_cleanup(struct nfs_xdr_putpage_desc *desc)
+{
+
+	while (desc->npages != 0) {
+		desc->npages--;
+		__free_page(desc->pages[desc->npages]);
+	}
+}
+
+static ssize_t xdr_nfs4ace_encode(const struct nfs_server *server,
+		struct nfs_xdr_putpage_desc *desc, struct posix_acl_entry *acep)
+{
+	char owner[IDMAP_NAMESZ];
+	ssize_t len, size;
+	int type;
+
+	type = nfsacl4_posix_tagtotype(acep->e_tag);
+	if (type < 0)
+		return -EINVAL;
+	if (!nfs_xdr_putpage_word(desc, type))
+		return -EINVAL;
+	if (!nfs_xdr_putpage_word(desc, acep->e_perm))
+		return -EINVAL;
+	size = 2 * XDR_UNIT;
+	switch(acep->e_tag) {
+	case ACL_USER_OBJ:
+	case ACL_GROUP_OBJ:
+	case ACL_MASK:
+	case ACL_OTHER:
+		if (!nfs_xdr_putpage_word(desc, 0))
+			return -EINVAL;
+		size += XDR_UNIT;
+		break;
+	case ACL_USER:
+		len = nfs_map_uid_to_name(server, acep->e_uid, owner,
+					IDMAP_NAMESZ);
+		if (len < 0) {
+			dprintk("nfs: couldn't resolve uid %d to string\n",
+				from_kuid(&init_user_ns, acep->e_uid));
+			return -EINVAL;
+		}
+		if (!nfs_xdr_putpage_word(desc, len))
+			return -EINVAL;
+		size += XDR_UNIT;
+		while (len & 3)
+			owner[len++] = '\0';
+		if (!nfs_xdr_putpage_bytes(desc, owner, len))
+			return -EINVAL;
+		size += len;
+		break;
+	case ACL_GROUP:
+		len = nfs_map_gid_to_group(server, acep->e_gid, owner,
+					IDMAP_NAMESZ);
+		if (len < 0) {
+			dprintk("nfs: couldn't resolve gid %d to string\n",
+				from_kgid(&init_user_ns, acep->e_gid));
+			return -EINVAL;
+		}
+		if (!nfs_xdr_putpage_word(desc, len))
+			return -EINVAL;
+		size += XDR_UNIT;
+		while (len & 3)
+			owner[len++] = '\0';
+		if (!nfs_xdr_putpage_bytes(desc, owner, len))
+			return -EINVAL;
+		size += len;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return size;
+}
+
+ssize_t nfs42_encode_posixacl(const struct nfs_server *server,
+		struct nfs_xdr_putpage_desc *desc, struct posix_acl *acl)
+{
+	unsigned int cnt;
+	ssize_t ret, size;
+
+	if (acl == NULL) {
+		if (!nfs_xdr_putpage_word(desc, 0))
+			return -EINVAL;
+		return XDR_UNIT;
+	}
+	if (acl->a_count > NFS_ACL_MAX_ENTRIES)
+		return -EINVAL;
+	if (!nfs_xdr_putpage_word(desc, acl->a_count))
+		return -EINVAL;
+	size = XDR_UNIT;
+
+	for (cnt = 0; cnt < acl->a_count; cnt++) {
+		ret = xdr_nfs4ace_encode(server, desc, &acl->a_entries[cnt]);
+		if (ret < 0)
+			return ret;
+		size += ret;
+	}
+
+	return size;
+}
+
+static void encode_setposixacl(struct rpc_rqst *req, struct xdr_stream *xdr,
+			const struct nfs42_setposixaclargs *arg,
+			const struct nfs_server *server,
+			struct compound_hdr *hdr)
+{
+	uint32_t bitmap[3];
+	__be32 *sizep;
+	ssize_t ret, size;
+
+	bitmap[0] = 0;
+	bitmap[1] = 0;
+	bitmap[2] = 0;
+	if (arg->mask & NFS_ACL)
+		bitmap[2] |= FATTR4_WORD2_POSIX_ACCESS_ACL;
+	if (arg->mask & NFS_DFACL)
+		bitmap[2] |= FATTR4_WORD2_POSIX_DEFAULT_ACL;
+
+	encode_op_hdr(xdr, OP_SETATTR, decode_setposixacl_maxsz, hdr);
+	encode_nfs4_stateid(xdr, &zero_stateid);
+	xdr_encode_bitmap4(xdr, bitmap, ARRAY_SIZE(bitmap));
+	sizep = reserve_space(xdr, 4);
+	if (sizep != NULL) {
+		size = 0;
+		if (arg->len > 0) {
+			xdr_write_pages(xdr, arg->pages, 0, arg->len);
+			size = arg->len;
+		} else {
+			if (arg->mask & NFS_DFACL)
+				size = encode_stream_posixacl(xdr,
+						arg->acl_default, server);
+			if ((arg->mask & NFS_ACL) && size >= 0) {
+				ret = encode_stream_posixacl(xdr,
+						arg->acl_access, server);
+				if (ret > 0)
+					size += ret;
+			}
+		}
+		if (size >= 0)
+			*sizep = cpu_to_be32(size);
+	}
+}
+
+/*
+ * Encode a GETPOSIXACL request
+ */
+static void nfs4_xdr_enc_getposixacl(struct rpc_rqst *req,
+				struct xdr_stream *xdr, const void *data)
+{
+	const struct nfs42_getposixaclargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+	uint32_t bitmask[3];
+	int getacl_cnt;
+
+	bitmask[0] = 0;
+	bitmask[1] = 0;
+	bitmask[2] = FATTR4_WORD2_ACL_TRUEFORM;
+	getacl_cnt = 0;
+	if (args->mask & (NFS_ACLCNT|NFS_ACL)) {
+		bitmask[2] |= FATTR4_WORD2_POSIX_ACCESS_ACL;
+		getacl_cnt++;
+	}
+	if (args->mask & (NFS_DFACLCNT|NFS_DFACL)) {
+		bitmask[2] |= FATTR4_WORD2_POSIX_DEFAULT_ACL;
+		getacl_cnt++;
+	}
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_getattr(xdr, bitmask, NULL, 3, &hdr);
+
+	if (getacl_cnt > 0) {
+		rpc_prepare_reply_pages(req, args->pages, 0,
+					(NFS4_ACL_MAXPAGES * getacl_cnt) <<
+					PAGE_SHIFT, NFS4_dec_getposixacl_sz -
+					pagepad_maxsz);
+		req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
+	}
+	encode_nops(&hdr);
+}
+
+/*
+ * Encode a SETPOSIXACL request
+ */
+static void nfs4_xdr_enc_setposixacl(struct rpc_rqst *req,
+				struct xdr_stream *xdr, const void *data)
+{
+	const struct nfs42_setposixaclargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_setposixacl(req, xdr, args, args->server, &hdr);
+	encode_nops(&hdr);
+}
+
+static bool
+nfsacl4_posix_xdrtotag(struct xdr_stream *xdr, u32 *tag)
+{
+	u32 type;
+	int ret;
+
+	ret = xdr_stream_decode_u32(xdr, &type);
+	if (ret < 0)
+		return false;
+	switch(type) {
+	case POSIXACE4_TAG_USER_OBJ:
+		*tag = ACL_USER_OBJ;
+		break;
+	case POSIXACE4_TAG_GROUP_OBJ:
+		*tag = ACL_GROUP_OBJ;
+		break;
+	case POSIXACE4_TAG_USER:
+		*tag = ACL_USER;
+		break;
+	case POSIXACE4_TAG_GROUP:
+		*tag = ACL_GROUP;
+		break;
+	case POSIXACE4_TAG_MASK:
+		*tag = ACL_MASK;
+		break;
+	case POSIXACE4_TAG_OTHER:
+		*tag = ACL_OTHER;
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
+
+struct nfsacl4_decode_desc {
+	unsigned int array_len;
+	unsigned int count;
+	struct posix_acl *acl;
+};
+
+static ssize_t
+xdr_nfs4ace_decode(struct xdr_stream *xdr, const struct nfs_server *server,
+		struct nfsacl4_decode_desc *desc)
+{
+	struct posix_acl_entry *entry;
+	char *owner;
+	kuid_t uid;
+	kgid_t gid;
+	u32 val;
+	ssize_t ret;
+
+	if (!desc->acl) {
+		desc->acl = posix_acl_alloc(desc->array_len, GFP_KERNEL);
+		if (!desc->acl)
+			return -ENOMEM;
+		desc->count = 0;
+	}
+
+	entry = &desc->acl->a_entries[desc->count++];
+	if (!nfsacl4_posix_xdrtotag(xdr, &val))
+		return -EBADMSG;
+	entry->e_tag = val;
+	ret = xdr_stream_decode_u32(xdr, &val);
+	if (ret < 0)
+		return -EBADMSG;
+	if (val & ~S_IRWXO)
+		return -EINVAL;
+	entry->e_perm = val;
+	ret = xdr_stream_decode_opaque_inline(xdr, (void **)&owner,
+				IDMAP_NAMESZ);
+	if (ret < 0)
+		return -EBADMSG;
+
+	switch(entry->e_tag) {
+	case ACL_USER:
+		if (ret == 0)
+			return -EBADMSG;
+		if (nfs_map_name_to_uid(server, owner, ret, &uid) == 0)
+			entry->e_uid = uid;
+		else
+			return -EINVAL;
+		break;
+	case ACL_GROUP:
+		if (ret == 0)
+			return -EBADMSG;
+		if (nfs_map_group_to_gid(server, owner, ret, &gid) == 0)
+			entry->e_gid = gid;
+		else
+			return -EINVAL;
+	}
+
+	return (XDR_QUADLEN(ret) << 2) + 3 * XDR_UNIT;
+}
+
+static ssize_t nfs_stream_decode_acl4(struct xdr_stream *xdr,
+		const struct nfs_server *server, unsigned int *aclcnt,
+		struct posix_acl **pacl)
+{
+	struct nfsacl4_decode_desc nfsacl_desc;
+	u32 entries, i;
+	ssize_t ret, retlen;
+
+	ret = xdr_stream_decode_u32(xdr, &entries);
+	if (ret < 0)
+		return -EBADMSG;
+	if (entries > NFS_ACL_MAX_ENTRIES)
+		return -EINVAL;
+	retlen = XDR_UNIT;
+
+	nfsacl_desc.array_len = entries;
+	nfsacl_desc.count = 0;
+	nfsacl_desc.acl = NULL;
+	for (i = 0; i < entries; i++) {
+		ret = xdr_nfs4ace_decode(xdr, server, &nfsacl_desc);
+		if (ret < 0)
+			return ret;
+		retlen += ret;
+	}
+
+	if (pacl) {
+		if (posix_acl_from_nfsacl(nfsacl_desc.acl) != 0) {
+			posix_acl_release(nfsacl_desc.acl);
+			return -EINVAL;
+		}
+		*pacl = nfsacl_desc.acl;
+	}
+	if (aclcnt)
+		*aclcnt = entries;
+	return retlen;
+}
+
+static int decode_getposixacl(struct xdr_stream *xdr,
+		struct nfs42_getposixaclres *res,
+		const struct nfs_server *server)
+{
+	uint32_t bitmap[3] = {0};
+	u32 attrlen, attrsize, trueform;
+	char scratch_buf[IDMAP_NAMESZ];
+	int status;
+
+	status = decode_op_hdr(xdr, OP_GETATTR);
+	if (status < 0)
+		goto xdr_error;
+
+	status = decode_attr_bitmap(xdr, bitmap);
+	if (status < 0)
+		goto xdr_error;
+
+	if (bitmap[0] || bitmap[1] ||
+	    (bitmap[2] & ~(FATTR4_WORD2_POSIX_ACCESS_ACL |
+	     FATTR4_WORD2_POSIX_DEFAULT_ACL |
+	     FATTR4_WORD2_ACL_TRUEFORM))) {
+		status = -EBADMSG;
+		goto xdr_error;
+	}
+
+	status = xdr_stream_decode_u32(xdr, &attrlen);
+	if (status < 0)
+		goto xdr_error;
+
+	trueform = ACL_MODEL_NFS4;
+	if (bitmap[2] & FATTR4_WORD2_ACL_TRUEFORM) {
+		status = xdr_stream_decode_u32(xdr, &trueform);
+		if (status < 0)
+			goto xdr_error;
+		attrsize = XDR_UNIT;
+	}
+
+	/*
+	 * For a ACL_MODEL_NFS4 true form, return EOPNOTSUPP.
+	 * Hopefully this error can be used by getfacl(1) to indicate
+	 * that nfs4_getfacl(1) should be used.
+	 */
+	if (trueform == ACL_MODEL_NFS4) {
+		status = -EOPNOTSUPP;
+		goto xdr_error;
+	}
+
+	xdr_set_scratch_buffer(xdr, &scratch_buf, sizeof(scratch_buf));
+	res->mask = 0;
+	if (bitmap[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) {
+		status = nfs_stream_decode_acl4(xdr, server,
+						&res->acl_default_count,
+						&res->acl_default);
+		if (status < 0)
+			goto xdr_error2;
+		attrsize += status;
+		res->mask |= NFS_DFACL|NFS_DFACLCNT;
+	}
+	if (bitmap[2] & FATTR4_WORD2_POSIX_ACCESS_ACL) {
+		status = nfs_stream_decode_acl4(xdr, server,
+						&res->acl_access_count,
+						&res->acl_access);
+		if (status < 0)
+			goto xdr_error2;
+		attrsize += status;
+		res->mask |= NFS_ACL|NFS_ACLCNT;
+	}
+	status = 0;
+
+	if (attrlen != attrsize)
+		status = -EBADMSG;
+xdr_error2:
+	xdr_reset_scratch_buffer(xdr);
+xdr_error:
+	dprintk("%s: xdr returned %d\n", __func__, -status);
+	return status;
+}
+
+/*
+ * Decode GETPOSIXACL response
+ */
+static int
+nfs4_xdr_dec_getposixacl(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
+		    void *data)
+{
+	struct nfs42_getposixaclres *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_getposixacl(xdr, res, res->server);
+
+out:
+	return status;
+}
+
+/*
+ * Decode SETPOSIXACL response
+ */
+static int nfs4_xdr_dec_setposixacl(struct rpc_rqst *rqstp,
+				struct xdr_stream *xdr,
+				void *data)
+{
+	struct nfs42_setposixaclres *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_setattr(xdr);
+	if (status)
+		goto out;
+out:
+	return status;
+}
+
+
 /*
  * Decode REMOVEXATTR request
  */
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 19e3398d50f7..54da0854ae02 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -660,6 +660,13 @@ extern void nfs4_xattr_cache_set_list(struct inode *inode, const char *buf,
 extern ssize_t nfs4_xattr_cache_list(struct inode *inode, char *buf,
 				     ssize_t buflen);
 extern void nfs4_xattr_cache_zap(struct inode *inode);
+extern struct posix_acl *nfs4_get_posixacl(struct inode *inode, int type,
+					bool rcu);
+extern int nfs4_set_posixacl(struct mnt_idmap *idmap, struct dentry *dentry,
+				struct posix_acl *acl, int type);
+extern ssize_t nfs42_encode_posixacl(const struct nfs_server *server,
+		struct nfs_xdr_putpage_desc *desc, struct posix_acl *acl);
+extern void nfs_xdr_putpage_cleanup(struct nfs_xdr_putpage_desc *desc);
 #else
 static inline void nfs4_xattr_cache_zap(struct inode *inode)
 {
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3057622ed61a..f5d2f80e77e8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3955,7 +3955,7 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 
 #define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_MOUNTED_ON_FILEID - 1UL)
 #define FATTR4_WORD2_NFS41_MASK (2*FATTR4_WORD2_SUPPATTR_EXCLCREAT - 1UL)
-#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_OPEN_ARGUMENTS - 1UL)
+#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_POSIX_ACCESS_ACL - 1UL)
 
 #define FATTR4_WORD2_NFS42_TIME_DELEG_MASK \
 	(FATTR4_WORD2_TIME_DELEG_MODIFY|FATTR4_WORD2_TIME_DELEG_ACCESS)
@@ -4024,7 +4024,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		case 2:
 			res.attr_bitmask[2] &= FATTR4_WORD2_NFS42_MASK;
 			bitmask[2] = (FATTR4_WORD2_SUPPATTR_EXCLCREAT |
-				      FATTR4_WORD2_OPEN_ARGUMENTS) &
+				      FATTR4_WORD2_OPEN_ARGUMENTS |
+				      FATTR4_WORD2_ACL_TRUEFORM |
+				      FATTR4_WORD2_POSIX_DEFAULT_ACL |
+				      FATTR4_WORD2_POSIX_ACCESS_ACL) &
 				     res.attr_bitmask[2];
 		}
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
@@ -6141,6 +6144,7 @@ static void nfs4_set_cached_acl(struct inode *inode, struct nfs4_cached_acl *acl
 static void nfs4_zap_acl_attr(struct inode *inode)
 {
 	nfs4_set_cached_acl(inode, NULL);
+	forget_all_cached_acls(inode);
 }
 
 static ssize_t nfs4_read_cached_acl(struct inode *inode, char *buf,
@@ -11045,6 +11049,8 @@ static const struct inode_operations nfs4_dir_inode_operations = {
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 	.listxattr	= nfs4_listxattr,
+	.get_inode_acl	= nfs4_get_posixacl,
+	.set_acl	= nfs4_set_posixacl,
 };
 
 static const struct inode_operations nfs4_file_inode_operations = {
@@ -11052,6 +11058,8 @@ static const struct inode_operations nfs4_file_inode_operations = {
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 	.listxattr	= nfs4_listxattr,
+	.get_inode_acl	= nfs4_get_posixacl,
+	.set_acl	= nfs4_set_posixacl,
 };
 
 static struct nfs_server *nfs4_clone_server(struct nfs_server *source,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index b6fe30577fab..549c81f2c196 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7842,6 +7842,8 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC42(REMOVEXATTR,	enc_removexattr,	dec_removexattr),
 	PROC42(READ_PLUS,	enc_read_plus,		dec_read_plus),
 	PROC42(ZERO_RANGE,	enc_zero_range,		dec_zero_range),
+	PROC42(GETPOSIXACL,	enc_getposixacl,	dec_getposixacl),
+	PROC42(SETPOSIXACL,	enc_setposixacl,	dec_setposixacl),
 };
 
 static unsigned int nfs_version4_counts[ARRAY_SIZE(nfs4_procedures)];
-- 
2.49.0


