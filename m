Return-Path: <linux-nfs+bounces-13577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0BFB22CD9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 18:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FF91AA27ED
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ED22F83BF;
	Tue, 12 Aug 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmvSZBrn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7727FD78
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014608; cv=none; b=LZLEoXgxudkii3ksD26wxDnVTQXxcApZs7nhLYXKn38lIcdRkfYjSf2Qyp7qMCXv8Y0XJwBxd5TGRKkL4qMdZ/7n67BDJDGpFb0ofB/aKtuM3LhOfjDV0jDAroCW77iRkTtbLiPNpZJ62vX4A69tvxXTVH7FqMKhSMTkvsFFo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014608; c=relaxed/simple;
	bh=j/rEZXybLIAbgEs6uk1nYwL8vwBisBt0xig0NzLX4tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e1QL+i1AyUpa8yWgylBFkzL/JATQJK2dTM68wdYa2ttSTpakg1BY39QsnbXs5/9RHum9mZxrAXbbLQHLTut+Qg3ysb9vgLb2nuAYDJ/hgWrD17SW6uaeWfZDI04qeIbeqcodBnc40ET0cG51sDKdYNXHxLFEZbS9Eh0YoZOsRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmvSZBrn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755014605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IVMS8MZkuk8+JfV1LKdBRE8bWDryWo/UEZ9h8lfNiDc=;
	b=QmvSZBrnNPxIQ+OQAyUQqSU1iWPgGRbyDTCeHV1x0vhVcPhT6CJbXGS2QXGpYFPaDWCpYN
	wd8zmnOgLTUAYqJHBtNMV7e4f8ZQqXA4PM9nCRRMRiJ+jbi3pyyrRbJZZ0tw+uX4/8ii9H
	d8CofB/jpvzvqfSSFhSXtyWie7X79PQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-TNEoEkN9NsmxOenplBuMjQ-1; Tue,
 12 Aug 2025 12:03:21 -0400
X-MC-Unique: TNEoEkN9NsmxOenplBuMjQ-1
X-Mimecast-MFC-AGG-ID: TNEoEkN9NsmxOenplBuMjQ_1755014599
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1F9C1800370;
	Tue, 12 Aug 2025 16:03:19 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 389EB300146B;
	Tue, 12 Aug 2025 16:03:18 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v2 1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
Date: Tue, 12 Aug 2025 12:03:16 -0400
Message-Id: <20250812160317.25363-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When v3 NLM request finds a conflicting delegation, it triggers
a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
of returning nlm_failed for when there is a conflicting delegation,
drop this NLM request so that the client retries. Once delegation
is recalled and if a local lock is claimed, a retry would lead to
nfsd returning a nlm_lck_blocked error or a successful nlm lock.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/lockd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index edc9f75dc75c..8fdc769d392e 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -57,6 +57,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	switch (nfserr) {
 	case nfs_ok:
 		return 0;
+	case nfserr_jukebox:
+		/* this error can indicate a presence of a conflicting
+		 * delegation to an NLM lock request. Options are:
+		 * (1) For now, drop this request and make the client
+		 * retry. When delegation is returned, client's retry will
+		 * complete.
+		 * (2) NLM4_DENIED as per "spec" signals to the client
+		 * that the lock is unavaiable now but client can retry.
+		 * Linux client implementation does not. It treats
+		 * NLM4_DENIED same as NLM4_FAILED and errors the request.
+		 * (3) For the future, treat this as blocked lock and try
+		 * to callback when the delegation is returned but might
+		 * not have a proper lock request to block on.
+		 */
 	case nfserr_dropit:
 		return nlm_drop_reply;
 	case nfserr_stale:
-- 
2.47.1


