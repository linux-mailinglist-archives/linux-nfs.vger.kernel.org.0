Return-Path: <linux-nfs+bounces-20796-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCF2ITfX12mDTggAu9opvQ
	(envelope-from <linux-nfs+bounces-20796-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 18:43:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 923933CDC0B
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 18:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C34123008CA8
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6BD2D2496;
	Thu,  9 Apr 2026 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNNfq684"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4EC3E122A
	for <linux-nfs@vger.kernel.org>; Thu,  9 Apr 2026 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753008; cv=none; b=gXSa7TcOSqEo2ov+Al9S56HLuHNqj4ndywoSbEyPZSGCOCHBViHR14lfjfq4/j8NIJZ76H0hFZA7ZZQgn4+sA79edfUl/Gav60NEOGNMZaQiBOCPnEzsZZuSt+2O1uHJos59xJgvXy35ST+txBvXz/UCvc6fRdVCWaqZ3k7nAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753008; c=relaxed/simple;
	bh=b5Ad8Q+Ig/7sswU8lD791pYLsvPlXZzQljCjdODNUhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKZIpEFX0sVsmqf6kektbTp818er9y/wCLBBUDyrZ6ofMDmkwhpgAlFrbNGSUOwtr7vz4wMKOOdI53kxPK88hbzsFw5kEG+rwPyvd4Ra3WhVSN9trgmuAWn0WgH1aREHcfUxNDqw8lsirjvjD0gG5vlV+SSqfaBAPB+o6VkhpZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNNfq684; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775753006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7X5+lFRG+AJ+Zo9spJhk23f4YS4s8bLcpwOU7m+orM=;
	b=WNNfq684bmFlXxtxtbSK0zjg42kls+MDx6QLnkwvifvIM6DlLoqohuVmJEvIdknU5nfnQd
	6i9NQ9PeKcWmE/VaX0Rnv0AjRVSH93KUoggVBjjrLd5hAFCNkAOTK8yDcEsu1kS2Mttls9
	cLMLjdA6E6IzBs/AoEJBY2WdZ+1Em1M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-QRynpT1bOEehI69dKNxcJA-1; Thu,
 09 Apr 2026 12:43:22 -0400
X-MC-Unique: QRynpT1bOEehI69dKNxcJA-1
X-Mimecast-MFC-AGG-ID: QRynpT1bOEehI69dKNxcJA_1775753001
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29FCA180028A;
	Thu,  9 Apr 2026 16:43:21 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.236])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13A751801ACA;
	Thu,  9 Apr 2026 16:43:19 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v3 2/2] nfsd: update mtime/ctime on COPY in presence of delegated attributes
Date: Thu,  9 Apr 2026 12:43:16 -0400
Message-ID: <20260409164316.19748-3-okorniev@redhat.com>
In-Reply-To: <20260409164316.19748-1-okorniev@redhat.com>
References: <20260409164316.19748-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20796-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 923933CDC0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

COPY should update destination file's mtime/ctime upon completion.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4proc.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5091527a6dc7..4418e71c8458 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2124,8 +2124,22 @@ static int nfsd4_do_async_copy(void *data)
 
 	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
 	trace_nfsd_copy_async_done(copy);
-	nfsd4_send_cb_offload(copy);
 	atomic_dec(&copy->cp_nn->pending_async_copies);
+	/*
+	 * choosing to check for existence of set dentry pointer to indicate
+	 * that we need to update the attributes and do a dput because the
+	 * file flag could be cleared by a DELEGRETURN and then we'd lose
+	 * that copy was started with file opened with NOCMTIME and we got
+	 * a reference on the dentry.
+	 */
+	if (copy->cp_res.wr_bytes_written > 0) {
+		struct iattr ia = {
+			.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_DELEG,
+		};
+
+		nfsd_update_cmtime_attr(copy->nf_dst->nf_file, &ia);
+	}
+	nfsd4_send_cb_offload(copy);
 	return 0;
 }
 
@@ -2201,8 +2215,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		wake_up_process(async_copy->copy_task);
 		status = nfs_ok;
 	} else {
+		struct iattr ia = {
+			.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_DELEG,
+		};
+
 		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
 				       copy->nf_dst->nf_file, true);
+		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
+			       FMODE_NOCMTIME) != 0 &&
+				copy->cp_res.wr_bytes_written > 0)
+			nfsd_update_cmtime_attr(copy->nf_dst->nf_file, &ia);
 	}
 out:
 	trace_nfsd_copy_done(copy, status);
-- 
2.52.0


