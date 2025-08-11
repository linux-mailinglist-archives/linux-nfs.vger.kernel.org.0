Return-Path: <linux-nfs+bounces-13559-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D65B21432
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1601907785
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B44E2E8888;
	Mon, 11 Aug 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GT4tdWqX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEB2E285C
	for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936335; cv=none; b=BP/Fk0dnu8Q+9OGo85vCaa/bKQsB6bo+SNEsOsDOAbIqJLGvmCpMOymAx3FQhzKuG3hBQZGB0CNVcD4X0NPC4gEQfknHP9F0gm1J9BWvsoQ0h/L7aojNUmYxqtzF5h/80j3SJ9/DHR8AqFfE83N83L6nffih0rUgslaOoOI8dIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936335; c=relaxed/simple;
	bh=ZuJTsPkrWrTv+D1pmMLy535axr5LRq0WL8I7FDap+Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bw+KOVP/5MhLapq8mmo1gzQoRIFnrMN1PHcGoKsPtlQ1o4thIL2EwWHhsZEA295tSocGQ5qkyK/aibsDm0fE1r63/jSiZeHzlCUhuKrbRsVQAnxkP3j5rg3MheT8p150bhU5UJtMXurINsWjJzvlAVS9xrbCLvEkJnzjFwDKr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GT4tdWqX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754936332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5J9WtBy/oB4JL0duPHAJvNvi6g1+IwsDCb9eWw4zLGA=;
	b=GT4tdWqXGKyU0gvgxhKELuo2kZN7uDfAUqsemgJ0WrgEY/oF/R9gZLfD0kH8RTWdwkcgNt
	vGet5k4D1f9y7LJXYVrMoPm/mRufsaa29OdfDI2tkgQqNhRp3Cx1eufPIxmr/xEStM31+2
	0NXHPNJMZI1BZqgR4boupFgT+N9VoOE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-6HsghXSEPQ6UqJNLGjMHiw-1; Mon,
 11 Aug 2025 14:18:46 -0400
X-MC-Unique: 6HsghXSEPQ6UqJNLGjMHiw-1
X-Mimecast-MFC-AGG-ID: 6HsghXSEPQ6UqJNLGjMHiw_1754936324
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9E6519560A0;
	Mon, 11 Aug 2025 18:18:44 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.42])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 368E81800291;
	Mon, 11 Aug 2025 18:18:42 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [RFC PATCH 1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
Date: Mon, 11 Aug 2025 14:18:39 -0400
Message-Id: <20250811181840.99269-2-okorniev@redhat.com>
In-Reply-To: <20250811181840.99269-1-okorniev@redhat.com>
References: <20250811181840.99269-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When v3 NLM request finds a conflicting delegation, it triggers
a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
of returning nlm_failed for when there is a conflicting delegation,
drop this NLM request so that the client retries. Once delegation
is recalled and if a local lock is claimed, a retry would lead to
nfsd returning a nlm_lck_blocked error or a successful nlm lock.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/lockd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index edc9f75dc75c..ad3e461f30c0 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -57,6 +57,7 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	switch (nfserr) {
 	case nfs_ok:
 		return 0;
+	case nfserr_jukebox:
 	case nfserr_dropit:
 		return nlm_drop_reply;
 	case nfserr_stale:
-- 
2.47.1


