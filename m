Return-Path: <linux-nfs+bounces-23295-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 78TdKmuEVGprmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23295-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF6174781F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=PqBQkxgR;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=ZJ4E7W7f;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23295-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23295-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4E1230086CE
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FDD363083;
	Mon, 13 Jul 2026 06:23:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F135F165
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:23:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923816; cv=none; b=c/0cbkpj6WZtrdvDNeYatBfue2iTeICds80IoVRoWEhj2Idlod5SCkAFO4R8rzOzjKVNZe7i0L8oBSAI3u86fNnibPlPP1Z8MO8VvN5DeP4i5OGqZ1WaMXPGLGxUxKIMyIb2ZmW7u2g3xJkPdftkadQRzqQxY1WESGjoPP0sEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923816; c=relaxed/simple;
	bh=CHb2sanz0ZYV34ytfbopUuYqkOKgKzV0smEI01kzQ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVcjF0yQYYMtjr+Lve3dgjfhW1YpSbX1uIOtDIoVPdbxEeghr3MaJ5fgLhPH7aZMCmmWYzJokloE1WSVmvdFEO4DNnALWbtHpC6zpLe63o3UijP2NukLMpz05UgFeV4W/YeOvGN2cY3wtD/2yEf0OBWWzqnuazcAtZUKQZRe1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PqBQkxgR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJ4E7W7f; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5939B7A0048;
	Mon, 13 Jul 2026 02:23:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 02:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923814;
	 x=1784010214; bh=HKZZn4YME1jB3L7sjK6cgirTQOiEmJu4PHFmBo8Nma0=; b=
	PqBQkxgRHWy8K0bpNAXBnVDg4/P2kQXTZcEJf1MebSBQG8OAwnckJ5HX0aFfidA+
	pRdnojzakkto5zH28s5dyizTNnQWVzjAVm3nDKE4nP5UrOJgd88vdosUo+KKSmAM
	/JCcif6uK9lTf2/tMy2VZQrh2HHLJ4zDKYrBa+CxIXvb0XZQedABQAUSDyRg3k3v
	4rH9GKzHT2R8Zdh5xjfN/h8g5jplDD9WW9m8hcNt9gYITZQYyDOIl0CiNRewd7yM
	PDgkdVZPVq+s9dd3+wTuBsI8X3PEg22AeZz2YsvyS5D4bGU31ebVBRrawtIco3j5
	oldQesFqrmJPBFH8UMMOEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923814; x=1784010214; bh=H
	KZZn4YME1jB3L7sjK6cgirTQOiEmJu4PHFmBo8Nma0=; b=ZJ4E7W7fYKYtqIwQe
	R7KewgzpRCP+g6TLGn+VPpLJYPfkgBIq2x6lZAVVcDgrxDwbJMNfFTgoYclGQtWB
	WQv7rUotvhUG+AzSkTjZ4FnGWpuPnwrnsrW5+Wf4uzhQSAC9Zp3uaAmGaczmqRut
	uqbgUx4u0Q2Aw6gpdRAZw68tjFsOw6+qkCRuFm8W8kP5mvxKDRHql32k5kmWWsdd
	8V9Y+h5nlP7RQ8UjrdIYGJeGNCIRFKVPG0s1QVqkJjEp0dJpX+efy0HTUXUodnkq
	M+7Vn1A3gEMeLCam+/+Jz5E+iJOL1JbmqTWdoKvtQ+rexJwk0RuWIcHKFy8Ts9Xd
	6iEnA==
X-ME-Sender: <xms:ZoRUascrxmBqUt2wg87-TQh6vK0bbKCrSuKD0K5p5CGgmGUH5mdDgA>
    <xme:ZoRUamrI7HXj7T5eRuW6SPTZbnul15_EqjCDzDU6pN-lsRHXuY9PBYJuL4v8xZ_1n
    LxojY3yp2kBzsMUv4VL4tc6QtsIGkBRqy2u0ZTOhYEi0UFv_A>
X-ME-Received: <xmr:ZoRUat8AhoPZgzDYS5V0xG4q8LI-1pZ2GFRE1MesYc1nUc6Ceu9EeRr4M90BzqMDGz85B5NrU0UhrQvw9dV2r53rDoVHHMI>
X-ME-Proxy-Cause: dmFkZTGCQLlV7rkBD/d/I31+FnWtoJqihf/xdHHsD1TT1SXgkZmv6s4HWqyOhFnVY9n5MU
    BOJtfUQyVpUKpBykWA7VcVygcWfF57rWMRxVOWH1WLSaRWqIdVkOkFztYwGNBEJqYCGdER
    lIjYSwxT52xjXFVZpJf8rJpvaK2n+rZveXXBjrP8wYzN/FLD3xS33T1EHtom553cqC8fjn
    PrLIVOrVJtl+mjvVoS1EqhD6Dvk80GmCtdpbSpYdhpfrTqNe15e9hEbxs6wUV0rVyj4+GV
    nLsskUnL0p4PWJePiP27X7oGhT/Dg2xDgvflUJ5tmToCi4jiK9SzoT7k7idnqqIq2oUzqs
    zphhbkpk+x060c+gdVGcGWX1FIsqQr1jfqNiByKuGAD2003btNeArPRNo2ZvA6yoGhz4wK
    PGiI+bO4wY6dj9NC0KiWf1N6CHyfmGxp9Ttn9sq/Y9XWCFi5GjGB/+KL7kycuXZ+4nIAJo
    3OtwrodRmy5BZyqhWP+dpSFiORLjwNAEWR9p9q9q29RcF5AXxEDTHtQjd57KH5OJSc2hFQ
    vvE+oK1I7IiKWhMuY+M+vszsut+txi5wtTfz8b/IoGiMUGKtdVOqENQA/IBzSmUFya3lRA
    j+K8miFd586RWyFGtKKMmN0U1CrXNobwNqrP4N1NlvE997/rW5nxlv/nEHtg
X-ME-Proxy: <xmx:ZoRUaieI4PqbuV2YhEH18fX0jBXET2KW9NC6GG3cwqfR4OiglOjyJg>
    <xmx:ZoRUanIhEXGAVBWwE_5QALjs7op5wYQIqU6BGEvcDLvEotuw5epvow>
    <xmx:ZoRUaiggeEdo5UWJvdsTcHezDQhWu46gppPTexnpQhyIM-B_kAED3A>
    <xmx:ZoRUalSlt64g2lg60PF3lzsWJLRgusclwVVBb4gIQflBCtHbE6R1HQ>
    <xmx:ZoRUatp9IlX0PcY02Z2W39e-Go-ryy2pL27wCHr1IV8E1KiwlzBB5RiX>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:23:32 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 12/17] nfsd: open-code nfsd4_vfs_create() into nfsd4_create_file()
Date: Mon, 13 Jul 2026 16:15:35 +1000
Message-ID: <20260713062219.6399-13-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260713062219.6399-1-neilb@ownmail.net>
References: <20260713062219.6399-1-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23295-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BF6174781F

From: NeilBrown <neil@brown.name>

Having this sub function separate doesn't really add clarity, and merging
allows for some refactoring and ultimately using a different VFS
interface.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 76 +++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a1dfe0a31ad7..32b6c0e507ea 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -201,46 +201,6 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
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
-	/*
-	 * For the EXCLUSIVE modes we do our own uniqueness tests
-	 * so don't want O_EXCL.
-	 */
-	if (open->op_createmode == NFS4_CREATE_GUARDED)
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
-
 /*
  * Implement NFSv4's unchecked, guarded, and exclusive create
  * semantics for regular files. Open state for this new file is
@@ -398,9 +358,41 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	} else if (create_status) {
 		status = create_status;
 	} else {
-		status = nfsd4_vfs_create(fhp, &child, open);
-		if (status == nfs_ok)
+		struct file *filp;
+		struct path path;
+		int oflags;
+
+		oflags = O_CREAT | O_LARGEFILE;
+		/*
+		 * For the EXCLUSIVE modes we do our own uniqueness tests
+		 * so don't want O_EXCL.
+		 */
+		if (open->op_createmode == NFS4_CREATE_GUARDED)
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
+			status = nfserrno(PTR_ERR(filp));
+		} else {
+			open->op_filp = filp;
 			open->op_created = open->op_filp->f_mode & FMODE_CREATED;
+		}
 	}
 	end_creating(child);
 	if (status != nfs_ok)
-- 
2.50.0.107.gf914562f5916.dirty


