Return-Path: <linux-nfs+bounces-22934-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6CjzCqXBRWr/EgsAu9opvQ
	(envelope-from <linux-nfs+bounces-22934-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:40:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE06F2D17
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:40:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=PSpL7nWX;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=YWWVSWL5;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22934-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22934-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B4A1301B581
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E6282F1C;
	Thu,  2 Jul 2026 01:40:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF81A3166
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 01:40:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956451; cv=none; b=lTfUq5zUkTgPT/ply/UnJ2qB4aKLpz6utrXBi5TEJXs+9EYpaKCTYX4CczJV3tH5PMqmkdEBs5BD/lc+JvandWa3UmD7AklmRPcBDF17fxlDkrwB1mweYS+H62PPZd42reuHmvRpWLAGPa7vrD+BAQtgjXXAt1u+5sdx/WsLuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956451; c=relaxed/simple;
	bh=gCMHcxW8QosAXVii92DTz5qO08gCmX9nJPzZfjW2O0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enjQaC/XoOwEzrK78ql/Ii0er0XKbzd8DwPj7BSXfD8AH9O6sQrwnV7X4sdYNfzVVpbm51mL15XwZr8bLxEUZYbt+Ge3OU/l+est+l2vf+qahtqAwELZyIy5uZhA3O5sh10YQsguYBRb/QZ7zyGLlpC09CfsDo6vx4nNJXkHAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PSpL7nWX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWWVSWL5; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2DE0B140014D;
	Wed,  1 Jul 2026 21:40:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 21:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782956449;
	 x=1783042849; bh=GfI8y2tDNQ6MZtVcXvofH/0hWvP1+1W3zzOcAAkq8tE=; b=
	PSpL7nWXKfp6ygr2NYaUHC3Kk9q6u5UrWX+g+5mErPIN1Awtzs/6MMpjYfqtI8XT
	W37zJXM64WYHRYdtjZHk1VCNFomRtRmJzs6DqVIaTFcYcvRriCysSDA5o7aSwaQN
	2d2rKj/XeIkhlH8ocgfKN4aL52D/6czrKT9dNVFEtNttGdU3ZoxmO4n1BUq0aRWO
	L1irMMJTD6fiKeYFygZxemZz19QzhIL5CApdxqBzsR2MOCsSowQtUsLl1EcchZVA
	vHS19OM8Oy4qVXE0y8NlYtj0NYcdDAVpxsilDJiVp7giLGDL2NRQSjJUhS5fRaa+
	3DOAFZ/ZF+dFGjF5MBdxqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782956449; x=1783042849; bh=G
	fI8y2tDNQ6MZtVcXvofH/0hWvP1+1W3zzOcAAkq8tE=; b=YWWVSWL5u0f9ysCO/
	ssM9gJNcSWs6fmmTzxka1XWOM8mW4t9qrGIS/tfiqFNlTtv0H11goJZjBBy7Tnkj
	nXZ5Mr53f0rB3fIPbDJIQNeJ1TJ/u0oBKZtZsbsCDX5te83gSHbbllejfi2b+Mm6
	0SQsCwi+3/ewvVkj9iQKIqGVhmpR36FEWcTnte+GvZlsekuGArYtPo6EtknlSK5W
	EpYvzXl5ylz/kDz23sImySPH4uWr3whHaoqW6heztr2yNO+gl1+WYb53iuevxXmb
	Pqq7dxEW4RppPnASlB+vLfSL0VjqY+gDuzP/DTKzLxWWGHRqOtRe01T+sAAdomHj
	K569Q==
X-ME-Sender: <xms:ocFFalrDr88M1iJQQy_dP1sI6j6L6BU5gQoxKKn7N6IDBB-grv4neg>
    <xme:ocFFarVKwnFy7utCEwBA9fStrnGnF1L4U5LghDarLQ_9TBS-iaxZA5CaB1-N_tSen
    FLPdxBQEi7tbPXOZTin6rAta8aEoNXN2Npg73jACqHL900cn38>
X-ME-Received: <xmr:ocFFasDHdxzXuisgtqXnv_hjBe9ui3V9Q7xqph4UGpM7VLW15nKBqYPf7Z7CJB_zRnjB8l9QggsQZf1tZ6zWKRtBjcQIT_U>
X-ME-Proxy-Cause: dmFkZTFiJL6QbtCUqoKdB6pLLGQDEKADja0Lsm386zcq3Uh3PMXgOxtAbpVb5rwK8HM+vo
    zOoAE8FRZAxNPuZ3WU8E8R+XUnWOmQRkSPifW+OIAx583+ZVb4SG1RobDLaPIVUDbIiv/p
    kOTJNxwynW8RB/QcGXD7f8+UHCEnjKCXLSBeI2dgVNt1fH8Fq3ZPaViBeUAZ2gGTkG+cPm
    l9Phf7MU2SyDpzxLpfqmEaKbs6w9YtHq7Hw9h/TV37jzbVcWsI6hLNM8VDOcsFUQqp0Gir
    oIHXiYKKx6nxsjYUdeqIqofQQHYc+O0WyvQqDAy05W+GOLD90n4z+/IAHpLUpECB9iL/CB
    INJWr1JWS/hqBkqMdVLkNAIxwPLV/Lu8Fa+tltxl7OtFQQqeP+dZbM5rXzgdKH37RJV1tR
    VoEpvRzo1dlKx9B4iiyXKoa8pNRA2Fpx77/emIfJKv1sYiFg/VNkjk6ffdKIyx5HySDawu
    UKBCqt1ZwOsSVvVZ298kJOyTdRFDj5ZA6QcxVtjH/0cYi6R3g825F+8HIBwAZztbY+9HgE
    f/Qm8lKGAxPzqp3srZwczqcsU+JbOWn4nHS98i1V0u9KUt1GUwGqP/cNEUfAH0v2J4+xmn
    dC+LUcGfvF1FUnP41YCCqErlIf5DrtwWjwj4/q/2MGGSCVzoc0QQ63stAioQ
X-ME-Proxy: <xmx:ocFFan38Y0UU7mtEJkYMGEqI1o3wAo3TZWH3VXAiVqD7K8b1Dh5LIw>
    <xmx:ocFFam2eHPAk8GFD1Vj6nwYIORKEV9V1ehoBPhZf35m6QSvL7wvjfg>
    <xmx:ocFFakCBMRQ6eBNA_kXyi6YfzLNWQhsLe_BHGOr3fQVE6uLN_1EGcg>
    <xmx:ocFFat7-O8gEH29ALiuCm1So84jOyqVxY92xQqIcILq1pdk7pK9CFw>
    <xmx:ocFFavKIkY_y4Zcjg9hSbYw7eZSJBXdiAV4pGxMOwRj3psy_uyB4buUB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:40:47 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 08/10] nfsd: open-code nfsd4_vfs_create() into nfsd4_create_file()
Date: Thu,  2 Jul 2026 11:34:27 +1000
Message-ID: <20260702014000.3397240-9-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260702014000.3397240-1-neilb@ownmail.net>
References: <20260702014000.3397240-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22934-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:mid,ownmail.net:from_mime,brown.name:replyto,brown.name:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFFE06F2D17

From: NeilBrown <neil@brown.name>

Having this sub function separate doesn't really add clarity, and merging
allows for some refactoring and ultimately using a different VFS
interface.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 70 +++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9dfdeb6dc379..6e94f88d79da 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -201,41 +201,6 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
 		createmode == NFS4_CREATE_EXCLUSIVE4_1;
 }
 
-static __be32
-nfsd4_vfs_create(struct svc_fh *fhp, struct dentry **child,
-		 struct nfsd4_open *open)
-{
-	struct file *filp;
-	struct path path;
-	int oflags;
-
-	oflags = O_CREAT | O_LARGEFILE;
-	if (nfsd4_create_is_exclusive(open->op_createmode))
-		oflags |= O_EXCL;
-
-	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
-	case NFS4_SHARE_ACCESS_WRITE:
-		oflags |= O_WRONLY;
-		break;
-	case NFS4_SHARE_ACCESS_BOTH:
-		oflags |= O_RDWR;
-		break;
-	default:
-		oflags |= O_RDONLY;
-	}
-
-	path.mnt = fhp->fh_export->ex_path.mnt;
-	path.dentry = *child;
-	filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
-			     current_cred());
-	*child = path.dentry;
-
-	if (IS_ERR(filp))
-		return nfserrno(PTR_ERR(filp));
-
-	open->op_filp = filp;
-	return nfs_ok;
-}
 
 /*
  * Implement NFSv4's unchecked, guarded, and exclusive create
@@ -330,12 +295,41 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	if (d_really_is_negative(child)) {
-		status = nfsd4_vfs_create(fhp, &child, open);
+		struct file *filp;
+		struct path path;
+		int oflags;
+
+		oflags = O_CREAT | O_LARGEFILE;
+		if (nfsd4_create_is_exclusive(open->op_createmode))
+			oflags |= O_EXCL;
+
+		switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
+		case NFS4_SHARE_ACCESS_WRITE:
+			oflags |= O_WRONLY;
+			break;
+		case NFS4_SHARE_ACCESS_BOTH:
+			oflags |= O_RDWR;
+			break;
+		default:
+			oflags |= O_RDONLY;
+		}
+
+		path.mnt = fhp->fh_export->ex_path.mnt;
+		path.dentry = child;
+		filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
+				     current_cred());
+		child = path.dentry;
+
+		if (IS_ERR(filp)) {
+			end_creating(child);
+			status = nfserrno(PTR_ERR(filp));
+			goto out;
+		}
+
+		open->op_filp = filp;
 		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
 	}
 	end_creating(child);
-	if (status != nfs_ok)
-		goto out;
 
 	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
 	if (status != nfs_ok)
-- 
2.50.0.107.gf914562f5916.dirty


