Return-Path: <linux-nfs+bounces-22042-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIZxF3uXGGqklQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22042-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:28:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8335F710B
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC57B302BEA6
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEB840756C;
	Thu, 28 May 2026 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Lke6rK8p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A322F3FBED8
	for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996168; cv=none; b=M441xDdQCSRA5u13+0WfdJAvFW72lSZjG3mkuVZgJplssigyVHCTRmjnELHBnbfENt6eBsvmO6VU0YsJZNzx0lVmh0p4leHTOP7wGqpQYD0DoEn75WOI2nBHAx/X/O4Mg1+nEMBq3xfYNbRBppl6kEfGFGScr5RnGoTUAIai0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996168; c=relaxed/simple;
	bh=wFle8wdNZitY26+iINAyU/7Osr6CE2qRhx/Eo0UYvOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmGt/dsG3hC7lFbR1iSpyZuQrNl6Qw8FMTZPeBnHABQOO3bzBVC244cI6/U5dvQbFNuWRdrwTdtsLJL8PnMMqpmJybEGH965VydYp6hE7oNq32sAhSUqvosT4W4UXYSl2R0xvTqpzvQiiIhHqeVR0lswS4W5PCBG9+gAk+PNHhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Lke6rK8p; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e61b59e03eso4382954a34.2
        for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1779996166; x=1780600966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5p1jrxfDK7QO4V9U6GAswPg5bpX3/mTyGsyAQXFq0s=;
        b=Lke6rK8pNShgcoIkyuN02iUZw5F3Mo7kwVq2rRI+/TfPCBPz1QfozfKcMTSTppg2wO
         nfz/ui7XmrZzCIb3mgqqF7h9q2WBjf9njiJbJ0Q7KIQigeQSSc36XVYaXGB97s96QLoD
         LOMKwXLlCp+DVya2bM9gd6+2y8z4WC6otcHPkWrx4NFaEwh2JStfG507V+Cy2UC6BwFQ
         Gu8QTSXohqBMxSDWfS+KqD/+l23BsFa4ykLHd+PHBgCGn4kIU1nnD75Pgc+UC0JOQCtY
         h0J0RkqwA9/a9fmQgSy/tIeyUMKX60lME9Qxsj9yEuBk9QYuTkrgMyvxotQmQRHDNmnd
         Umfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996166; x=1780600966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5p1jrxfDK7QO4V9U6GAswPg5bpX3/mTyGsyAQXFq0s=;
        b=dHpYrdxac/HxsONC95GZT410grkZU/mH64/e/Y1JJ9O5Yr0976wap1Zs4i9VT6ITuE
         r9pM75zESmF/4AkxbrE1UIFzbIfae6m3+5Ng9hwGXuDrNS5bdtisXb4hn01DtV8CCmzZ
         UN0io+a0kG/PxESJYG2OBkAGl46zO28j0+wUWDNQo3FfEA/IWi+w8P9vpmTXgmB33wel
         U7ULGz0loYFK4q5/hcOkoR7obmPywUAVm0qE+my8AxVju90vgg/NlNQq+GS89i5gIR1r
         toewr1Xo7lFKBr5q2BjTOTB27vjaS4pgCiasotDdgGikGoDBMinTQ70oHqKV22hY/chJ
         BKOw==
X-Gm-Message-State: AOJu0YxqpJt3tJ7ycwtWRb0H+GZ2WeeHfyyGNpmVxMKwmz4lGsqBxmgn
	1u5GuBY3n7i7KISIqp5CPl16wzJs2knxGwxVasP+CpNND+XJHCgjJnKiZphKIRPd/3S7yGCuvew
	spDyB
X-Gm-Gg: Acq92OElnAhDr/7aYy9Cl9nPXO5cNB02jXlpDa6IHwIGURubLs0lee6c829hWd21Vb8
	OS8Lr4itCPUby5OeETvrmkhMhq4mJveVve0Zdk+JpRB+U2OZZvptT4/MDlfDrDnYGT8VV7pI8Gq
	3reVp3TQj0Mfw/TAd7HurpX9CD4L4yIMWK3yMoxacqAe4zsb7PeIaWnsNeGyff7ufT2Zpvq5W3C
	BWlf1dlpbpWjSQmEvIsOb3na1dgEKfS47qfLmWHs/Qp0Cl6I3JLW9LeG16KWVyhMk04OZN8v6rw
	YUtasBkrYw2po/0z67yu4uO6DeEpFn8odWroR6p2NFkLvbAbMfXGd81d/SwSe8WDm9VG6fXOXex
	yObx8e0hb+B3emF4T+y+Nq56sjzNMGmeTaOM/BPAP6CZgg1ASmCrq6IGaCFpwCpKxBnSBtAQpNA
	DWDywjeN0kX/R08cFIz6L1xEtb3aERYK+l/94MvMfz2YZ+1uLB3VLv6Z81i7WTUn3VTVxPng+MS
	13EgeTY
X-Received: by 2002:a05:6830:4104:b0:7dc:c4ae:a679 with SMTP id 46e09a7af769-7e6944f6978mr21854a34.9.1779996165551;
        Thu, 28 May 2026 12:22:45 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6064aa0bbsm15006127a34.12.2026.05.28.12.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:22:44 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] nfs: return a write delegation when a SETATTR drops our write access
Date: Thu, 28 May 2026 15:22:42 -0400
Message-ID: <64a9c99c387432399b4c4d9ce6dd4836b0170c15.1779995818.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779995818.git.bcodding@hammerspace.com>
References: <cover.1779995818.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22042-lists,linux-nfs=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CD8335F710B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A client holding an OPEN_DELEGATE_WRITE delegation can satisfy a later
open(O_WRONLY) from the cached delegation (can_open_delegated()) without
sending an OPEN to the server. That cached "open for write" assertion is
only valid while the delegation holder still has write access. A SETATTR
that changes mode, owner, or group can revoke that access -- after which an
open served from the delegation would bypass an access check the server
would now fail, and, against a server that recalls the delegation on such a
change, the SETATTR draws a CB_RECALL/NFS4ERR_DELAY/DELEGRETURN/retry round
trip.

Before issuing such a SETATTR, check whether the proposed mode/owner/group
would remove write access for the delegation's owning credential, judged by
the resulting POSIX mode bits. If so, return the delegation first: the
return is synchronous and flushes modified data, so the SETATTR proceeds on
an open or special stateid and the next open revalidates access with the
server. Permission changes that keep the holder's write access leave the
delegation in place.

Only the mode bits and the holder's fsuid/fsgid are consulted. An NFSv4 ACL
cannot be evaluated by the client, a privileged caller may retain access the
bits deny, and supplementary group membership is not checked, so the test is
necessarily approximate -- but an inexact answer costs at most an
unnecessary delegation return or a fall back to the server's recall, never
incorrect access.

RFC 8881 Section 10.4.4 permits a client to return a delegation voluntarily,
performing the same pre-return state updates (data flush, pending
truncation, CLOSE/OPEN/LOCK) it would on a recall. Commit c01d36457dcc
("NFSv4: Don't return the delegation when not needed by NFSv4.x (x>0)")
stopped returning write delegations on SETATTR for NFSv4.1+, since the
server can identify the delegation holder from the SEQUENCE clientid and
need not recall. That holds for changes that do not affect the holder's
access; restore a return only for the narrow case where the holder's own
write access is removed.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a9b8d482d289..e4b7322bf75c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4506,7 +4506,55 @@ int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	return err;
 }
 
-/* 
+/*
+ * Would applying @sattr (which changes mode, owner, and/or group) remove the
+ * write access of a held write delegation's owning credential, as judged by
+ * the resulting file mode bits?
+ *
+ * Such a change makes the delegation's cached "open for write" assertion
+ * stale: a later open(O_WRONLY) could be served from the delegation without
+ * the server getting a chance to deny it.  Only the mode bits and the
+ * holder's fsuid/fsgid are consulted; an NFSv4 ACL (which the client cannot
+ * evaluate locally), a privileged caller, or supplementary group membership
+ * may make the answer imprecise, but the cost is at most an unnecessary
+ * delegation return or a fall back to the server's recall -- never incorrect
+ * access.
+ */
+static bool nfs4_setattr_removes_write(struct inode *inode, struct iattr *sattr)
+{
+	struct nfs_delegation *delegation;
+	const struct cred *cred;
+	umode_t mode = inode->i_mode;
+	kuid_t uid = inode->i_uid;
+	kgid_t gid = inode->i_gid;
+	bool ret = false;
+
+	delegation = nfs4_get_valid_delegation(inode);
+	if (!delegation)
+		return false;
+	if (!(delegation->type & FMODE_WRITE))
+		goto out;
+	cred = delegation->cred;
+
+	if (sattr->ia_valid & ATTR_MODE)
+		mode = sattr->ia_mode;
+	if (sattr->ia_valid & ATTR_UID)
+		uid = sattr->ia_uid;
+	if (sattr->ia_valid & ATTR_GID)
+		gid = sattr->ia_gid;
+
+	if (uid_eq(uid, cred->fsuid))
+		ret = !(mode & S_IWUSR);
+	else if (gid_eq(gid, cred->fsgid))
+		ret = !(mode & S_IWGRP);
+	else
+		ret = !(mode & S_IWOTH);
+out:
+	nfs_put_delegation(delegation);
+	return ret;
+}
+
+/*
  * The file is not closed if it is opened due to the a request to change
  * the size of the file. The open call will not be needed once the
  * VFS layer lookup-intents are implemented.
@@ -4555,9 +4603,19 @@ nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 			cred = ctx->cred;
 	}
 
-	/* Return any delegations if we're going to change ACLs */
-	if ((sattr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID)) != 0)
-		nfs4_inode_make_writeable(inode);
+	/*
+	 * A change to mode, owner, or group that removes the write
+	 * delegation holder's own write access makes the delegation's cached
+	 * "open for write" stale; return it so a later open() revalidates
+	 * access with the server.  A change that keeps write access leaves
+	 * the delegation in place.
+	 */
+	if (sattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) {
+		if (nfs4_setattr_removes_write(inode, sattr))
+			nfs4_inode_return_delegation(inode);
+		else
+			nfs4_inode_make_writeable(inode);
+	}
 
 	status = nfs4_do_setattr(inode, cred, fattr, sattr, ctx, NULL);
 	if (status == 0) {
-- 
2.53.0


