Return-Path: <linux-nfs+bounces-20775-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKJ0AVKs1mmZHAgAu9opvQ
	(envelope-from <linux-nfs+bounces-20775-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 21:28:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CDC3C30AA
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 21:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C80323180C43
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 19:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CAB3AE712;
	Wed,  8 Apr 2026 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeZ0Iz5e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1383DA5AE
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674887; cv=none; b=WZmjJATh7zetgVQ5sxeHHQjCaidT+TV6IeIZAGb3dtoJDvV4vmbwDfL8CZmED+h80n67rGewi3oUEPaF3Wq8WjrgR1CKxGhItvkZUjtW30b0698waKWx8RNwNmgx98gyur8UM3KlUMJ655wk3DZbiRLDJnDpWQqfqJWBzDMsvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674887; c=relaxed/simple;
	bh=elgfAjlC5jqUPZNG+B5PfHUVKYeJPOzMfcreNiNkoxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLxn/54SHde2VVtabUWfVfyTOKLenONUrZsn71I74ztFL0jt3eNMhLglCV5/051nZXIQJvXTGfC+VAAK35ZhhnRH3H286acPd4DbjmaGTpItC9FZQRcL8ILtrYnP6aLVn7PdQBxRjxu/ew7v86h81EK4+MwRtjR4ddxmgPiHyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeZ0Iz5e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775674873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xkpeFguQOryirRfkapm1P7fPxHH/4dN2FUQ2R+fQ6M=;
	b=OeZ0Iz5eDAn2sRI0M5OVcNUqtXJoFDQ8POPcdEEb52wAmCEyUMWFbLwcO47ROuoGgcG1RV
	WkCEeleCT2aUTIJfJz0R4VGTq/SYZiVWJ7PY44wdJp6g1j27obilj6ou0d8LsGrjd5UK0s
	cd3p+Ug292ioDEKT1fDiSjLpb9E7hMo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-It0WTkdfOK6rFEY54p9iWQ-1; Wed,
 08 Apr 2026 15:00:15 -0400
X-MC-Unique: It0WTkdfOK6rFEY54p9iWQ-1
X-Mimecast-MFC-AGG-ID: It0WTkdfOK6rFEY54p9iWQ_1775674813
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B85FD180034E;
	Wed,  8 Apr 2026 19:00:13 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.138])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D114300019F;
	Wed,  8 Apr 2026 19:00:12 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v2 2/3] nfsd: update mtime/ctime on synchronous COPY with delegated attributes
Date: Wed,  8 Apr 2026 15:00:07 -0400
Message-ID: <20260408190008.85082-3-okorniev@redhat.com>
In-Reply-To: <20260408190008.85082-1-okorniev@redhat.com>
References: <20260408190008.85082-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20775-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84CDC3C30AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

COPY should update destination file's mtime/ctime upon completion.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4proc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 1272f2eb5ff4..ac47cddef384 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2211,6 +2211,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	} else {
 		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
 				       copy->nf_dst->nf_file, true);
+		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
+			       FMODE_NOCMTIME) != 0 &&
+				copy->cp_res.wr_bytes_written > 0)
+			nfsd_update_cmtime_attr(cstate->current_fh.fh_dentry);
 	}
 out:
 	trace_nfsd_copy_done(copy, status);
-- 
2.52.0


