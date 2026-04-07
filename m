Return-Path: <linux-nfs+bounces-20686-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEaCFJfr1GkjywcAu9opvQ
	(envelope-from <linux-nfs+bounces-20686-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 13:33:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4BA3ADBF8
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 13:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E0023015E19
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B173AC0FA;
	Tue,  7 Apr 2026 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9YKMgcF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED338F24C
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561571; cv=none; b=edvj1iNEJarVS099mLahmQM0FLnGYuNOdrmbqDPdm5VRb4O8UZpWn5wB1gpmq5uYGr6mN093nE2eNAm29V5AOD4wWOcthnDps/x3zmWTtGS0+4VAPFLmYKmfnFWa0fzKUOBGCYckRH+d2E/iSXOTcZRrm8i7PayBtEVqnClq4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561571; c=relaxed/simple;
	bh=6xLkC1VoZu+nAZzfrZRt2qnmt0mQPIxmOqp2q+L4FTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPR9MwnnTGbIIPIrZcKQHNNlZQwAlWp04Kr2Rlp1exW3/86wvg1+qNiEWzQBRQiRxV8eGW40Db6n6o5bHgQfitYBpzsPoG8tY4EbeYQhnrvPQFUKeF6BCTdGI/Hul7SZbi10OvrcLLABXrrOyreX27/SSM8zmXU0W6VQJMgMxio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9YKMgcF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775561569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5hFJSW9JoQAT/O8L+B/8cCaErEj4DMUlLTsULWomP14=;
	b=C9YKMgcFh5FkhlAUjjtL3wOQLhOIUge0WEM80CdTSOorco34q5B7OgLziO0/WZkmtvhiJK
	lUxLVB//ODE8wcQSlJmrsnVZ5Ans4VubcmX2R5LrMu7qZqhL1K6PgJ/TJs8ZGrrQxDfpPh
	rc4q0SYH47vYoEtcZwmjOGG5urCDnuo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-VrpbVlx7MYmgkJmoL8r0DQ-1; Tue,
 07 Apr 2026 07:32:47 -0400
X-MC-Unique: VrpbVlx7MYmgkJmoL8r0DQ-1
X-Mimecast-MFC-AGG-ID: VrpbVlx7MYmgkJmoL8r0DQ_1775561566
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBF141956051;
	Tue,  7 Apr 2026 11:32:45 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.134])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B239180058C;
	Tue,  7 Apr 2026 11:32:45 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id E605574BF27;
	Tue, 07 Apr 2026 07:32:43 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3] nfsd: fix file change detection in CB_GETATTR
Date: Tue,  7 Apr 2026 07:32:43 -0400
Message-ID: <20260407113243.1754585-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20686-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AD4BA3ADBF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC 8881, section 10.4.3 doesn't say anything about caching the file
size in the delegation record, nor does it say anything about comparing
a cached file size with the size reported by the client in the
CB_GETATTR reply for the purpose of determining if the client holds
modified data for the file.

What section 10.4.3 of RFC 8881 does say is that the server should
compare the *current* file size with size reported by the client holding
the delegation in the CB_GETATTR reply, and if they differ to treat it
as a modification regardless of the change attribute retrieved via the
CB_GETATTR.

Doing otherwise would cause the server to believe the client holding the
delegation has a modified version of the file, even if the client
flushed the modifications to the server prior to the CB_GETATTR.  This
would have the added side effect of subsequent CB_GETATTRs causing
updates to the mtime, ctime, and change attribute even if the client
holding the delegation makes no further updates to the file.

Modify nfsd4_deleg_getattr_conflict() to obtain the current file size
via i_size_read().  Retain the ncf_cur_fsize field, since it's a
convenient way to return the file size back to nfsd4_encode_fattr4(),
but don't use it for the purpose of detecting file changes.

Also, if we recall the delegation (because the client didn't respond to
the CB_GETATTR), then skip the logic that checks the nfs4_cb_fattr
fields.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/nfs4state.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fa657badf5f8..369f30c42115 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9516,11 +9516,16 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 		if (status != nfserr_jukebox ||
 		    !nfsd_wait_for_delegreturn(rqstp, inode))
 			goto out_status;
+		status = nfs_ok;
+		goto out_status;
+	}
+	if (!ncf->ncf_file_modified) {
+		if (ncf->ncf_initial_cinfo != ncf->ncf_cb_change) {
+			ncf->ncf_file_modified = true;
+		} else if (i_size_read(inode) != ncf->ncf_cb_fsize) {
+			ncf->ncf_file_modified = true;
+		}
 	}
-	if (!ncf->ncf_file_modified &&
-	    (ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
-	     ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
-		ncf->ncf_file_modified = true;
 	if (ncf->ncf_file_modified) {
 		int err;
 
-- 
2.53.0


