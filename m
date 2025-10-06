Return-Path: <linux-nfs+bounces-14998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477FCBBF030
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 20:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8E83B8B3F
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B67231836;
	Mon,  6 Oct 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjcnAXsg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808032DEA70
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776307; cv=none; b=iPKvDzkClIINAEVYsLKMQ5ljpQBVtxBpeK/dSDr++LdjWV9qR15jLV/f5hZBRChbBTmMuAXawWaslRhu1WxFV74tIeNZGtflHbzHclhXCe7Fkev2n1+4BYKwF3rnka8f/ZObLyG/Z2Tw5Fv9jU78EHTnzUKGler3L7ZfGix9hVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776307; c=relaxed/simple;
	bh=f4CfluBEPsZTnviEDazyVOXcON9su064XsYwKM5VggA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5K8xIXuw5hphDKDy3gtBRBsuF4YuizAgBA2p6/9qvo+rB5hLBQac9QT7cBG1WYMBIHts2z7RDNy/+AvuqqkLMO1zGhUUY4vIZGLNZyj9JBI18sL7wF5B9i7zQ+oBay2TY+HHtgdEIv2Jx28c5TkoDXXuzsWq8DNICEGzktMqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjcnAXsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C16C4CEFE;
	Mon,  6 Oct 2025 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759776307;
	bh=f4CfluBEPsZTnviEDazyVOXcON9su064XsYwKM5VggA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjcnAXsgG/3L/jul5qJuzOmW9l1jBl4lW/TLt3Mx33WBGU+9aJT9548hY8gXqjyK/
	 OJq3MWvzvcI6dKhe4rVS4bS1CIz9AgVIrF+r2FeX/jr4G456v+ZZVAeEseSH0HVJFR
	 ONI524WGbNyKY1QQCnIhFUBHfZ6foSzP4qu825Sy2TMCCfsEKj+h3u6M7CnYfyLx/N
	 pIYTXOvC2el3efes5VlQDvGsTvGlVS9YZhMhlWLr29wWYSLazzEU9DN94pVFlun6lE
	 jSbhCVdNhCc8tSwypb55o3SHQIu7/6ktzxXfZUA8s12TSK+rLC+tcEtv7xpx9b7MCD
	 C5WJpIw+S952Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v1 1/2] NFSD: Do not cache failed SEQUENCE operations
Date: Mon,  6 Oct 2025 14:45:01 -0400
Message-ID: <20251006184502.1414-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006184502.1414-1-cel@kernel.org>
References: <20251006184502.1414-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 8881 Section 2.10.6.4 says:

> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
> cache a reply except if an error is returned by the SEQUENCE or
> CB_SEQUENCE operation (see Section 2.10.6.1.2).

This text also appears in RFC 5661. Further, Section 2.10.6.1.2
says:

> Any time SEQUENCE or CB_SEQUENCE returns an error, the sequence ID
> of the slot MUST NOT change. The replier MUST NOT modify the reply
> cache entry for the slot whenever an error is returned from
> SEQUENCE or CB_SEQUENCE.

NFSD caches the result of solo SEQUENCE operations, but rtm's
reproducer sends two operations in the failing COMPOUND. NFSD should
not attempt to cache the reply.

The logic in nfsd4_is_solo_sequence() was incorrect: it checked the
current operation index, not the total count of operations in the
COMPOUND. If the SEQUENCE operation, which is always operation 1,
fails in a multi-operation compound, resp->opcnt is always 1. Thus
when a SEQUENCE operation fails, nfsd4_is_solo_sequence() always
returns true.

Reported-by: <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/c3628d57-94ae-48cf-8c9e-49087a28cec9@oracle.com/T/#t
Fixes: 468de9e54a90 ("nfsd41: expand solo sequence check")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/xdr4.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ee0570cbdd9e..d1837a10b0c2 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -926,7 +926,8 @@ struct nfsd4_compoundres {
 static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
 {
 	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
-	return resp->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
+
+	return args->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
 }
 
 /*
-- 
2.51.0


