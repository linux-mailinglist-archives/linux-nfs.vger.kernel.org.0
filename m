Return-Path: <linux-nfs+bounces-19044-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IsHAjWLl2n/0AIAu9opvQ
	(envelope-from <linux-nfs+bounces-19044-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5418B1630F7
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF4A330363BF
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A832DB79E;
	Thu, 19 Feb 2026 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ9mvrO3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9E2D7D47
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539235; cv=none; b=UdpUX1miM2dMWZ1XllXpk/4SqdRKpHXZpTuZalAhJEPIX4zbCEeEzTEjtsmjSwmAMPb2Hs5lEt3TkvShIEpGQDesaFzmyEkhGkEzKmvuUVj9Fs/y+hZYuJ1NZZaqD6yaoNwTDKu3lfad5N/doXOsU7AxwNuGgntHSnqqpp9ugcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539235; c=relaxed/simple;
	bh=0rxfzvXvLBOxaxDYj8qLocE4MaO3/5xZnquDZJNvePA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjSB9P4mB+K3LnhpIwO18q4MLedwDV67qf/vShq/zAJXRRbGC3F4jgXl2I+hImZw44z1pumzsqK0ovAbE7bxcLjU5Z9PDO3oyglSh1Wti5Csxx9kie6/hsF+wyvjWYqtU9kTd/UKpyAwU/73/L/aBYsjP1j2uuWNT+o0OVI+c1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ9mvrO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384A6C116C6;
	Thu, 19 Feb 2026 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539235;
	bh=0rxfzvXvLBOxaxDYj8qLocE4MaO3/5xZnquDZJNvePA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZ9mvrO3MsF0ATjV4vOuVsOY/E8LJWALgryYYAkAHONJhAFMgto+3AQ3P5cl7bgDa
	 wKJQ4QZDlX+j7yo1OvuPa2NM12sPWV7JsyTTpzXwe1fNse3V3dIDHyXgecocPAdVU9
	 ZneVgSp2ob+IRoCdBv4IUuO/L8Dt4LkuePyVKU0iKXWv8u4CqD2lxgGFwD220JEkde
	 8fJPBpB6mJRTCCQwZaf9e6E0RGiMoSx8sIfoE5b7Tcyhlg5xQtoXEh5F0gHb9hO3tw
	 XAAReQFTfpzvJoeEDq3TRtMNB/yh0RLguXCjrEwCYyDLUYbMvs/mWDHrzWUdTOYWRF
	 wMlxDVjD65jpw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 01/11] exportfs: add ability to advertise NFSv4 ACL passthru support
Date: Thu, 19 Feb 2026 17:13:42 -0500
Message-ID: <20260219221352.40554-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260219221352.40554-1-snitzer@kernel.org>
References: <20260219221352.40554-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19044-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 5418B1630F7
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

Add EXPORT_OP_NFSV4_ACL_PASSTHRU flag that an export should set if
relevant new methods are added to export_operations (e.g. .setacl and
.getacl which will be added in future commits).

NFSD will use exportfs_may_passthru_nfs4acl() to check for this flag
before passing nfs4_acl thru to exported FS (using new methods in
export_operations).

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 include/linux/exportfs.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 9369a607224c..0262c9258b34 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -247,6 +247,7 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
+#define EXPORT_OP_NFSV4_ACL_PASSTHRU	(0x80) /* fs MAY handle NFSv4 ACL passthru */
 	unsigned long	flags;
 };
 
@@ -262,6 +263,18 @@ exportfs_cannot_lock(const struct export_operations *export_ops)
 	return export_ops->flags & EXPORT_OP_NOLOCKS;
 }
 
+/**
+ * exportfs_may_passthru_nfs4acl() - check if export MAY passthru NFSv4 ACLs
+ * @export_ops:	the nfs export operations to check
+ *
+ * Returns true if the export MAY support NFSv4 ACL passthru.
+ */
+static inline bool
+exportfs_may_passthru_nfs4acl(const struct export_operations *export_ops)
+{
+	return export_ops->flags & EXPORT_OP_NFSV4_ACL_PASSTHRU;
+}
+
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent,
 				    int flags);
-- 
2.44.0


