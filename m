Return-Path: <linux-nfs+bounces-5622-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C8D95D20A
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CA61C21211
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB331586D3;
	Fri, 23 Aug 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jH9PMI4y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9114AD30
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428282; cv=none; b=CigwgdR0iiOOrHW+XsM5ys4MivSh14faNVIaQ0Exx2MTyC29WpRmDGWXuXkmOL5AC9vSXduQN9kcP2TQRJLbJh9p0AcyOEpIDCE0Eh3eqlo679enhZlNYguGg6Dn/OHkTBm+0P97zn6ln9FoENPZO4OQjzXkqxuNNJLsnOu2y7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428282; c=relaxed/simple;
	bh=h0+EBPe1/PQnExCPumpuhhzU8MeiHwWdoutfAH9pcCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=euOvCT/lZt4TCC4OwlIzvgbMphDO17Z3NkG8uXo4UGwLOVDmMrgExHulpzLVx+ePYCFw9i7KVD8Bb2Jtd/gycO3HOLstyRiDMVh9X0nqGull/6QVuw9scaSpzsTJWC1cavp3TNPm3BsnY8Bu/YJO677Zsnq2fTWB7XnxB2iArgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jH9PMI4y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724428279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UcIY1F+thTkIL+lzr1bPi5PJLfstA1r3aRJPxcPafVc=;
	b=jH9PMI4yyU/oQJwwUOAbAS7E6JYlWO1EmTnjQGtDK5maZb1gwt+IHJhq90nOD7IeZ2jmDR
	bVrIbWYiYM3Uze38G14asGQDfZdG+xujBedsN5M1gtbXLnxclMmjathY94X7fayMSCWHE1
	Q0jUWN27EAelqKy+408tYKzTuHCbcOA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-LXKMGKbhOa2xsaUK2IYXgQ-1; Fri,
 23 Aug 2024 11:51:13 -0400
X-MC-Unique: LXKMGKbhOa2xsaUK2IYXgQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C0B519560B0;
	Fri, 23 Aug 2024 15:51:12 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.16.6])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1356419560A3;
	Fri, 23 Aug 2024 15:51:10 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH v2] nfsd: prevent panic for nfsv4.0 closed files in nfs4_show_open
Date: Fri, 23 Aug 2024 11:51:08 -0400
Message-Id: <20240823155108.72516-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Prior to commit 3f29cc82a84c ("nfsd: split sc_status out of
sc_type") states_show() relied on sc_type field to be of valid
type before calling into a subfunction to show content of a
particular stateid. From that commit, we split the validity of
the stateid into sc_status and no longer changed sc_type to 0
while unhashing the stateid. This resulted in kernel oopsing
for nfsv4.0 opens that stay around and in nfs4_show_open()
would derefence sc_file which was NULL.

Instead, for closed open stateids forgo displaying information
that relies of having a valid sc_file.

To reproduce: mount the server with 4.0, read and close
a file and then on the server cat /proc/fs/nfsd/clients/2/states

[  513.590804] Call trace:
[  513.590925]  _raw_spin_lock+0xcc/0x160
[  513.591119]  nfs4_show_open+0x78/0x2c0 [nfsd]
[  513.591412]  states_show+0x44c/0x488 [nfsd]
[  513.591681]  seq_read_iter+0x5d8/0x760
[  513.591896]  seq_read+0x188/0x208
[  513.592075]  vfs_read+0x148/0x470
[  513.592241]  ksys_read+0xcc/0x178

Fixes: 3f29cc82a84c ("nfsd: split sc_status out of sc_type")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c3def49074a4..2b1f8053b9c1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2786,15 +2786,18 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 		deny & NFS4_SHARE_ACCESS_READ ? "r" : "-",
 		deny & NFS4_SHARE_ACCESS_WRITE ? "w" : "-");
 
-	spin_lock(&nf->fi_lock);
-	file = find_any_file_locked(nf);
-	if (file) {
-		nfs4_show_superblock(s, file);
-		seq_puts(s, ", ");
-		nfs4_show_fname(s, file);
-		seq_puts(s, ", ");
-	}
-	spin_unlock(&nf->fi_lock);
+	if (nf) {
+		spin_lock(&nf->fi_lock);
+		file = find_any_file_locked(nf);
+		if (file) {
+			nfs4_show_superblock(s, file);
+			seq_puts(s, ", ");
+			nfs4_show_fname(s, file);
+			seq_puts(s, ", ");
+		}
+		spin_unlock(&nf->fi_lock);
+	} else
+		seq_puts(s, "closed, ");
 	nfs4_show_owner(s, oo);
 	if (st->sc_status & SC_STATUS_ADMIN_REVOKED)
 		seq_puts(s, ", admin-revoked");
-- 
2.43.5


