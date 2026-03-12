Return-Path: <linux-nfs+bounces-20055-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KmSNBipsmnwOQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20055-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 12:52:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF44A2714DC
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 12:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B20D300107B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784C2D879F;
	Thu, 12 Mar 2026 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKsK7IeM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFA36166D
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316347; cv=none; b=a6O/pi4gSbqgP8FZRiu72aqaSxEglFuI0BCyvWvAB8v3dSkEQjU3AAezvqwg1RTxhlEawWtKO7mHzqAiNHgyLI3W7r1sJLYCgu0+SfzTdJE3OwIIEjC5uCsp5lV54NSq/WKycpzpfsCKOxEur3sfEVvk7WrOddVbC2Qkclj2dZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316347; c=relaxed/simple;
	bh=Op1aHwhgExf86xOYejYZA/ld47YNLsvYnRZ2tHtXjGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzikdzjp64bjAJ7vNmQ0coH7DvkjNEpp9q8H/3uJAciZOaNQUiX5ME/ERX0U0pMAIvV675njg3duNEJQRo6inEt4BFkeSgjPOT3hPeKgIftpYSIaeogwnsfr2SZyKQc34cT8ODAccAiMXL0Yucb/md9F48Sw5UYfAziDY4iU36M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKsK7IeM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773316343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7+DyFxMBJcNeh2ajv0FFEoUpeU+taDjjsVpiwEblils=;
	b=hKsK7IeM4YDe/T0sPtihzY3lY65iYFuJg3hw6qlhPJosCREY0ipDSpxuYHU2B+aCtdRX6o
	0obrD4ZsLHDtwEWM+D0GDANoX5+SDQm1X80pJaH0CrooPv3nkJ051IuluTquEFrzA6OlDQ
	llYVtMPPqby7mw4oi9cJPMN+c09+tyA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-DccWkz2rMPeNAaFnm6jPhw-1; Thu,
 12 Mar 2026 07:52:20 -0400
X-MC-Unique: DccWkz2rMPeNAaFnm6jPhw-1
X-Mimecast-MFC-AGG-ID: DccWkz2rMPeNAaFnm6jPhw_1773316339
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58C941945CBB;
	Thu, 12 Mar 2026 11:52:19 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAD2018001FE;
	Thu, 12 Mar 2026 11:52:17 +0000 (UTC)
From: Roberto Bergantinos Corpas <rbergant@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	neil@brown.name
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH RESEND] nfs: return EISDIR on nfs3_proc_create if d_alias is a dir
Date: Thu, 12 Mar 2026 12:52:16 +0100
Message-ID: <20260312115216.3718747-1-rbergant@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20055-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbergant@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF44A2714DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If we found an alias through nfs3_do_create/nfs_add_or_obtain
/d_splice_alias which happens to be a dir dentry, we don't return
any error, and simply forget about this alias, but the original
dentry we were adding and passed as parameter remains negative.

This later causes an oops on nfs_atomic_open_v23/finish_open since we
supply a negative dentry to do_dentry_open.

This has been observed running lustre-racer, where dirs and files are
created/removed concurrently with the same name and O_EXCL is not
used to open files (frequent file redirection).

While d_splice_alias typically returns a directory alias or NULL, we
explicitly check d_is_dir() to ensure that we don't attempt to perform
file operations (like finish_open) on a directory inode, which triggers
the observed oops.

Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.")
Reviewed-by: Olga Kornievskaia <okorniev@redhat.com>
Reviewed-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 fs/nfs/nfs3proc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1181f9cc6dbd..f8bc9bffdad9 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -392,8 +392,13 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	if (status != 0)
 		goto out_release_acls;
 
-	if (d_alias)
+	if (d_alias) {
+		if (d_is_dir(d_alias)) {
+			status = -EISDIR;
+			goto out_dput;
+		}
 		dentry = d_alias;
+	}
 
 	/* When we created the file with exclusive semantics, make
 	 * sure we set the attributes afterwards. */
-- 
2.53.0


