Return-Path: <linux-nfs+bounces-18604-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CALPOjswe2kVCQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18604-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 11:02:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F029AE566
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 11:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6417F3030EFA
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117537E2EC;
	Thu, 29 Jan 2026 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7y0MvoA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E8378D88
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680939; cv=none; b=sHyEdhfEJqRIV1xzkIgfOu3pWf2wKyDMBcWnFXeD7wQvp1J5nbNdb2ok3Zv3G7Ftsalq8/PZqitblZOGXvxKqzF/GMvd343OrIVGFMWpkjTJsqm7XfL7BxrKSkYZIkN1avuj3WrMJTY1BYlXgH8hZLwt0be/RCeRWuDaWXyA+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680939; c=relaxed/simple;
	bh=A2DTHUHs1nLGjJLtnrAy7iBy8SHKPDkszdxkI6TM6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzmUYjobEQQ2r0IHhlyd1njJVrT6WWn0dNdhaGRrFiAazvbtwXKLIp7jkC0as6qvObuiNXHjBUFIqC4jBdFOCG26pDBvC+e+yg/KmXqz9orABElDOwkVsuq412K+14S4jFKKaWqdmgmzSo51njGLGJR5lznszEoeh/PFIXvVwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7y0MvoA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658b9e95990so1606271a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 02:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769680936; x=1770285736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m5EDzasxMTMFr0ATlZ8fOFcmFkpPcXbIFJZjfWv3T4=;
        b=R7y0MvoAysRqClrgh9WCnt2zp9fXYQ4tMyYWdeOrDo8b4Jlgn40OHkd1j/kCOIZknb
         35vmZZkj+cC9Q4LlQf/dlTNddWfWevxcXypSNtU/NtyTod/OGOAam8Y6G4MGLeFRcPPP
         heHjzNV2NCNrU6uAxU39da2SxYnZ1BAQCEY2CzpE2JFRzKf1nHCUxs9GAA07whNJ+QjR
         MkruXDkwJ2MME/DXfKBtiwWhM44L7Kqu7xIHc8068ymI5kPrtfJA7OSAsVNtBljt26yP
         quUfYMoc04Cq3v944TnC2cYjry5UrOqY1ARc7S4if6xuOj9LQaNIUjZmilujfwebXezx
         aSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769680936; x=1770285736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8m5EDzasxMTMFr0ATlZ8fOFcmFkpPcXbIFJZjfWv3T4=;
        b=AyWOXHUaoT4+/WagQTv6+Pg/7uMYgiLutfnXj+lI6tdt/CvEvu3SU5ksvkqLnaS59l
         1qnX6uxZaS2r2TStr0LqHMDoRV12FP5pPKtXAO5x1YSP+/KY9UFTiL4L5dIRxnfkYST6
         DAsvN5Ds5O/XlyPRf5lyN6bYpSTu+epYtsiBRLfXcW87UmtDl7xgPwF/BjMlz+z0Vn6H
         SoxoSUc+xVccmsbQ17B52TXQCaQmnn8+aU39+Yc9/Z0KnmcLO/oXtEizeiT9ezIKQtl9
         SwuUOG1rGryz5y3qE5JYi8cDdZ0n/IS0l0BLZ6wAYV+Gq0UQC/x15UhEv6U0x06op72a
         2bSw==
X-Forwarded-Encrypted: i=1; AJvYcCVLwT5HsmdOpWIlqS49uQynwSR254tSfNwJUtk3ZD74mRbh2KmJVhTf9x6dE+PBuQv3dwuTq1T4BYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+PYSP+Jy9UFvB0DAQ0zwPZhgKGzo09EHNREweb7goItmtbje
	mnf4S7oQmVk0eZERZb5eRGLcJ/DvOju9LvNlw87tDnE9QPbqwpXIXGGq
X-Gm-Gg: AZuq6aI8XgR+u0Hx813nYFnODgvdYx1zC5a57mwFofhVtcpMA1qkGR+dGUdYqpbJSgq
	DDAk6fXzUBx86n46wjB423VQQRQ4MY7Bw8GKyf0WiqoxR8DUQYnwSJmENbxXomWDAiS+j69y9wm
	wqcSnhD6DPlVUfIlC8HELh6JyqNIr5kwUNXiOMNkq8xpSp6NbdEubW7wCROjDgHss6mYPHBj6pm
	9qIS2TiZX5G6CgQTE51JAHDOiNiZNqmQBuZurrj6o0Lr3G1vFrGCiw+vk1mK7fXDSXPiia6wnLW
	gDx5aFrBwVLZwU2WirEBJbbs1rxziZegjWqBdEjrVFCtXJHsO8PLD8bdsx5KKhhXSsGTIipj0RC
	GidW0DkTBlc98+zSeLtJJZHrHQSY1ynp5Ee2ulmF8R16KvjQXPZjhB0MsyroVnAyRZQf7xnpn9D
	zDCSA3Jo/qU+2TqYxN8GxdQ/fF7kO/0HIvnEW+RARAns8JydRvdbeJ8d07sEhXUgEAHTN/WdACI
	2SqPhP4ET/XuOVN
X-Received: by 2002:a17:907:9627:b0:b87:756b:cfab with SMTP id a640c23a62f3a-b8dab32ef88mr531554966b.36.1769680936110;
        Thu, 29 Jan 2026 02:02:16 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-983a-6411-8910-8120.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:983a:6411:8910:8120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefc6942sm243114666b.21.2026.01.29.02.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:02:15 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/2] nfsd: do not allow exporting of special kernel filesystems
Date: Thu, 29 Jan 2026 11:02:12 +0100
Message-ID: <20260129100212.49727-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129100212.49727-1-amir73il@gmail.com>
References: <20260129100212.49727-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-18604-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F029AE566
X-Rspamd-Action: no action

pidfs and nsfs recently gained support for encode/decode of file handles
via name_to_handle_at(2)/open_by_handle_at(2).

These special kernel filesystems have custom ->open() and ->permission()
export methods, which nfsd does not respect and it was never meant to be
used for exporting those filesystems by nfsd.

Therefore, do not allow nfsd to export filesystems with custom ->open()
or ->permission() methods.

Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
Fixes: 5222470b2fbb3 ("nsfs: support file handles")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/export.c         | 8 +++++---
 include/linux/exportfs.h | 9 +++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad196..09fe268fe2c76 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -427,7 +427,8 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 	 *       either a device number (so FS_REQUIRES_DEV needed)
 	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
 	 * 2:  We must be able to find an inode from a filehandle.
-	 *       This means that s_export_op must be set.
+	 *       This means that s_export_op must be set and comply with
+	 *       the requirements for remote filesystem export.
 	 * 3: We must not currently be on an idmapped mount.
 	 */
 	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
@@ -437,8 +438,9 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 		return -EINVAL;
 	}
 
-	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
-		dprintk("exp_export: export of invalid fs type.\n");
+	if (!exportfs_may_export(inode->i_sb->s_export_op)) {
+		dprintk("exp_export: export of invalid fs type (%s).\n",
+			inode->i_sb->s_type->name);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 0660953c3fb76..8bcdba28b4060 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -338,6 +338,15 @@ static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
 	return nop && nop->fh_to_dentry;
 }
 
+static inline bool exportfs_may_export(const struct export_operations *nop)
+{
+	/*
+	 * Do not allow nfs export for filesystems with custom ->open() or
+	 * ->permission() ops, which nfsd does not respect (e.g. pidfs, nsfs).
+	 */
+	return exportfs_can_decode_fh(nop) && !nop->open && !nop->permission;
+}
+
 static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 					  int fh_flags)
 {
-- 
2.52.0


