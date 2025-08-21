Return-Path: <linux-nfs+bounces-13859-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23684B3073A
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 22:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C14B02510
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 20:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258E72FC010;
	Thu, 21 Aug 2025 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AV958N5O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810611B21BF
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808316; cv=none; b=VlzeXnA5sUypUmmp8tF6tHIX7TdiRJPkmwVJVu0nj4ETZER6YK7FuiE6SDSK2ncXcgv4Nzcu3GkEu2/g1txRbS7iLX4iRGHBJxd4WqEoS/1jmEs2k8dTKexSacWAOWQ5frrw3491YgIJ4BNaPnHuHhJIr+XJsgJCwTpg0RLLet8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808316; c=relaxed/simple;
	bh=AmLqLvv84sIA/VZ5jMiwa5U7HoPCV5+btp7HnhSnHtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sZg7Mn2ylC6aWrosCtVGiaKtJoUfI7fXWEJTCyFAuu/3YnrVCDdyFgKZGRwtwI5dS4EPKzKqAQOZdqFwBZvdm0hmv4nokasMKg6XSDJkwW9GpoLNNhtNVXv5VO+t0uSsd79iv/S2ZLPtWztCEZvCK9Wfa+pTk0hPanS8KsbE3/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AV958N5O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755808312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ROCZDpf2X492yMEmRQpPv8i79zIu2MpwrNgpMwNh/bs=;
	b=AV958N5OWCs21fYNAL6LT6Vf01D8y64k2fHuGG+F2K6eCq6rW/13L86dj8ukm+cO8TpgTk
	2HQ5DWQD32Tt7D6giYlprQcpWOj62XNb5auTL7ePcl9rnZFeuLP21zcLiBfw9cDjk8mjcy
	98ngk4WNgwNY0QD0p6gKIbch51Z1J/w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-tODzvauJPkCNVqBPzR-_7g-1; Thu,
 21 Aug 2025 16:31:50 -0400
X-MC-Unique: tODzvauJPkCNVqBPzR-_7g-1
X-Mimecast-MFC-AGG-ID: tODzvauJPkCNVqBPzR-_7g_1755808309
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48A9C195608E;
	Thu, 21 Aug 2025 20:31:49 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.163])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB1AA1800447;
	Thu, 21 Aug 2025 20:31:47 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v3 1/1] nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
Date: Thu, 21 Aug 2025 16:31:46 -0400
Message-Id: <20250821203146.88671-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When v3 NLM request finds a conflicting delegation, it triggers
a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
of returning nlm_failed for when there is a conflicting delegation,
drop this NLM request so that the client retries. Once delegation
is recalled and if a local lock is claimed, a retry would lead to
nfsd returning a nlm_lck_blocked error or a successful nlm lock.

Fixes: d343fce148a4 ("[PATCH] knfsd: Allow lockd to drop replies as appropriate")
Suggested-Cc: stable@vger.kernel.org # v6.6
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/lockd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index edc9f75dc75c..6b042218668b 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -57,6 +57,21 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	switch (nfserr) {
 	case nfs_ok:
 		return 0;
+	case nfserr_jukebox:
+		/* this error can indicate a presence of a conflicting
+		 * delegation to an NLM lock request. Options are:
+		 * (1) For now, drop this request and make the client
+		 * retry. When delegation is returned, client's lock retry
+		 * will complete.
+		 * (2) NLM4_DENIED as per "spec" signals to the client
+		 * that the lock is unavailable now but client can retry.
+		 * Linux client implementation does not. It treats
+		 * NLM4_DENIED same as NLM4_FAILED and errors the request.
+		 * (3) For the future, treat this as blocked lock and try
+		 * to callback when the delegation is returned but might
+		 * not have a proper lock request to block on.
+		 */
+		fallthrough;
 	case nfserr_dropit:
 		return nlm_drop_reply;
 	case nfserr_stale:
-- 
2.47.1


