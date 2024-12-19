Return-Path: <linux-nfs+bounces-8679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1769F8767
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 22:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341B116F3FA
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 21:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746A1D0E2B;
	Thu, 19 Dec 2024 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRG/Zmu3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8EE8F6D
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734645479; cv=none; b=DdKGzOALU3OzEs8V6DzuTgHHxa2WeUOpydSjta7fxrgBupOV3XifknxJVg38JDlojZbWkbhvl1ifWYJCKv5WFc7nUe/pPA3pnZQpxIQhx2Dk9b0T5s/bw8hKFtxp0lqf7wJICaadc/kyerKCohen4FTdmjnY8hDY/D2HY7tvRsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734645479; c=relaxed/simple;
	bh=sJHnSSl1sPn7Dmxid/WwQSnEWjC3yngZg1XPw1wc2u4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5r9m9QbuYNZzTOZFeGYESiPpB6bcJFroxcN2aVidyt4V462vMzuY7NG8EVo5DH9Vrs24j2VDcGvNZTSXBn0U30OVF44j7OKTNK4AUHoMjb6lk2b8UqnYTq6nl2hVmL91BSWMY3lXR1m8Z0BW1tiTw5SUBTkIiZxiq0AReeidKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRG/Zmu3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734645476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3OlgB2OrwIQiyyrdt4LkPDwMx7KEhHAlOD8xekie34M=;
	b=XRG/Zmu3TA5k083L/yFWc6lHl+QDMOrU6yxwwMwAiPQbBTAe/nGMSGPT6GivO+b3QWojSE
	MMZcNt3AAhhZiQIsNrGPLTUTCTyXtIiQDRKC48JAM05XMpQ2OhMZtcR2xQFkqpIgcFk23I
	N0wpI1mvABcT2cWtGpNXEyLbj2+0TsQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-spMYF0s4NKWcvHkbxpXqng-1; Thu,
 19 Dec 2024 16:57:53 -0500
X-MC-Unique: spMYF0s4NKWcvHkbxpXqng-1
X-Mimecast-MFC-AGG-ID: spMYF0s4NKWcvHkbxpXqng
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FEA21956064;
	Thu, 19 Dec 2024 21:57:52 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.81])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60DF3195608A;
	Thu, 19 Dec 2024 21:57:51 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH] NFSD: add cb opcode to WARN_ONCE on failed callback
Date: Thu, 19 Dec 2024 16:57:48 -0500
Message-Id: <20241219215748.13006-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

It helps to know what kind of callback happened that triggered the
WARN_ONCE in nfsd4_cb_done() function in diagnosing what can set
an uncommon state where both cb_status and tk_status are set at
the same time.

Fixes: e8581a912447 ("nfsd: add more info to WARN_ON_ONCE on failed callbacks")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4callback.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f24d8654393d..93b3d27ba0f2 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1397,8 +1397,9 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		return;
 
 	if (cb->cb_status) {
-		WARN_ONCE(task->tk_status, "cb_status=%d tk_status=%d",
-			  cb->cb_status, task->tk_status);
+		WARN_ONCE(task->tk_status,
+			  "cb_status=%d tk_status=%d cb_opcode=%d",
+			  cb->cb_status, task->tk_status, cb->cb_ops->opcode);
 		task->tk_status = cb->cb_status;
 	}
 
-- 
2.43.5


