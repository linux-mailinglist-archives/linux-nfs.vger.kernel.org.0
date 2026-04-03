Return-Path: <linux-nfs+bounces-20639-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPuhFC7xz2mt1wYAu9opvQ
	(envelope-from <linux-nfs+bounces-20639-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 18:56:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA7D396AF7
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 18:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98BFC3014419
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197CC3CD8CF;
	Fri,  3 Apr 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJc2AP+8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D13CEB85
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775235227; cv=none; b=aFjljkKJ9lkWX0xNRAmZ6UleVPjQT8Hd9HHek6AYBIb+LALoVPdyg+En9bEMsMWW+jQHn+cXCJbQtP21GGEAFQTlnLCJYZGfLyPZ3NVnzL4WGIGqPyeNU9sHTIZlqCJeak+5HO3v6CEgOADzVHO8j8cB/1/aD/sdlWNMOWhCBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775235227; c=relaxed/simple;
	bh=we8d7BVjAzdab18lXNSKfeQrA9R9F6zQWiIW747SN4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKvvUxF4kIZfLA/NOKDaV1pUkdR07h8Kyz10/UC6TO3H6iNPeE3yUpFRTHPcMgn/BHuezJVVry+ds12yxwEmTqvm3jKYtTgNNbHDUCtr3zAZbGEENtmaLzpQ9+EHBFeKVThN+y4QAqBLJM8dfPdLKxev8iMDXm4CL3dzl8SneAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJc2AP+8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775235223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EfkY1fnT5EgFnfzax5+gLmhkflGdbDLwJgHY3NHVt78=;
	b=dJc2AP+8bz2gqc8LABPGx8XyDxNU4IY0Go7T1YtBlktM4evz90+d/aB7mB4GHZumLOU9Zf
	+bvEScoW4RNgWulEaU8d+OsUA3oOVUT357uBGEi9jqoDze9usKByzjieFxV5nnhbdXz5Fr
	ff4XOHz8cZzcX6vTojqK310dDwaNn4Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-QNFNxQSUPdOF0LRNA4w-nA-1; Fri,
 03 Apr 2026 12:53:38 -0400
X-MC-Unique: QNFNxQSUPdOF0LRNA4w-nA-1
X-Mimecast-MFC-AGG-ID: QNFNxQSUPdOF0LRNA4w-nA_1775235217
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97EF119560B0;
	Fri,  3 Apr 2026 16:53:37 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.67])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 752CB19560A6;
	Fri,  3 Apr 2026 16:53:36 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 1/1] nfsd: update mtime/ctime on CLONE and COPY in presence of delegated attributes
Date: Fri,  3 Apr 2026 12:53:35 -0400
Message-ID: <20260403165335.73070-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20639-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BDA7D396AF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When delegated attributes are given on open the file is opened with NOCMTIME
and modifying operations do not update mtime/ctime as to not get out-of-sync
with the client's delegated view. However, for operations CLONE/COPY server
should update its view of mtime/ctime and reflect that in any GETATTR queries.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4proc.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 99b44b6ec056..66bde3732b03 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1396,6 +1396,24 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	goto out;
 }
 
+static bool nfsd4_clear_nocmtime(struct file *f)
+{
+	if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) != 0) {
+		spin_lock(&f->f_lock);
+		f->f_mode &= ~FMODE_NOCMTIME;
+		spin_unlock(&f->f_lock);
+		return true;
+	}
+	return false;
+}
+
+static void nfsd4_restore_nocmtime(struct file *f)
+{
+	spin_lock(&f->f_lock);
+	f->f_mode |= FMODE_NOCMTIME;
+	spin_unlock(&f->f_lock);
+}
+
 static __be32
 nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
@@ -1403,16 +1421,19 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_clone *clone = &u->clone;
 	struct nfsd_file *src, *dst;
 	__be32 status;
+	bool restore_nocmtime = false;
 
 	status = nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stateid, &src,
 				   &clone->cl_dst_stateid, &dst);
 	if (status)
 		goto out;
 
+	restore_nocmtime = nfsd4_clear_nocmtime(dst->nf_file);
 	status = nfsd4_clone_file_range(rqstp, src, clone->cl_src_pos,
 			dst, clone->cl_dst_pos, clone->cl_count,
 			EX_ISSYNC(cstate->current_fh.fh_export));
-
+	if (restore_nocmtime)
+		nfsd4_restore_nocmtime(dst->nf_file);
 	nfsd_file_put(dst);
 	nfsd_file_put(src);
 out:
@@ -2132,6 +2153,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_copy *copy = &u->copy;
 	struct nfsd42_write_res *result;
 	__be32 status;
+	bool restore_nocmtime = false;
 
 	result = &copy->cp_res;
 	nfsd_copy_write_verifier((__be32 *)&result->wr_verifier.data, nn);
@@ -2157,6 +2179,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		}
 	}
 
+	restore_nocmtime = nfsd4_clear_nocmtime(copy->nf_dst->nf_file);
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
@@ -2199,6 +2222,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				       copy->nf_dst->nf_file, true);
 	}
 out:
+	if (restore_nocmtime)
+		nfsd4_restore_nocmtime(copy->nf_dst->nf_file);
 	trace_nfsd_copy_done(copy, status);
 	release_copy_files(copy);
 	return status;
-- 
2.52.0


