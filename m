Return-Path: <linux-nfs+bounces-8672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1AE9F859C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 21:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D309F189465C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B768C19F13B;
	Thu, 19 Dec 2024 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyE8D6/L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578F13D279
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639135; cv=none; b=frXkL5gf66aEo4RXq4H/3ykl1jcl/5rVzrMJDteNPtxM0bMcs05XUIgXMFAirYgDne6LxBxhoDLm77+TCc7y6OrPnRHsn/zUWtUao+ESUcGEttEnTK95OrzltC1yGxFfVJXGSDVgUaphRAQNPXXVlOut2R9qrQC4E2v10rflJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639135; c=relaxed/simple;
	bh=C7oRa0mAKyd+fnG6lNSVLxNk23Ys/1IjfP5/PiUh3lw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mKqUjtVKcxnfQPRB5A1madwtQVH+bJVWjrAXcA8f7UVbVzhxuui0GGftyzBZlxuu10ERVn6JS0X3g0FNNpfWpjI5ZcaDGT88ExTU81qYdI4E5yq+/NHio6Q211+yMQ1cM73Jcfak4wfPPsFkjQ979YKOPh6gnOU8tCClIWzM0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyE8D6/L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734639132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FDS3cuHec5qbafI/gidM0OmHvNbHhdDKkjbbqpalkpc=;
	b=IyE8D6/LdBmacA48kjgmZLy+LgpjUfvBPLH4pAdrIOq/8koUmzX6hbrXCnxUJvyd/WVp8l
	SgB4VVE3LIR0BAal1JJ/jttG3H3Mwi+CRJAUC1kn5zFlOxSNjS4omdR44R2DMRXQQDuQIS
	F0pPPiC1S97d6fFellazFLyApbnuCnw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-CItHYdiJO3C7bRb_7igDrA-1; Thu,
 19 Dec 2024 15:12:09 -0500
X-MC-Unique: CItHYdiJO3C7bRb_7igDrA-1
X-Mimecast-MFC-AGG-ID: CItHYdiJO3C7bRb_7igDrA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FA51195609D;
	Thu, 19 Dec 2024 20:12:08 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EE8419560A2;
	Thu, 19 Dec 2024 20:12:07 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] NFSD: fix decoding in nfs4_xdr_dec_cb_getattr
Date: Thu, 19 Dec 2024 15:12:04 -0500
Message-Id: <20241219201204.10367-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If a client were to send an error to a CB_GETATTR call, the code
erronously continues to try decode past the error code. It ends
up returning BAD_XDR error to the rpc layer and then in turn
trigger a WARN_ONCE in nfsd4_cb_done() function.

Fixes: 6487a13b5c6b ("NFSD: add support for CB_GETATTR callback")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4callback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 3877b53e429f..f24d8654393d 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -647,7 +647,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
 		return status;
 
 	status = decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
-	if (status)
+	if (status || cb->cb_status)
 		return status;
 	if (xdr_stream_decode_uint32_array(xdr, bitmap, 3) < 0)
 		return -NFSERR_BAD_XDR;
-- 
2.43.5


