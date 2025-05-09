Return-Path: <linux-nfs+bounces-11637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5245EAB1D16
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27677A00162
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844924500A;
	Fri,  9 May 2025 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSz3yLbB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E23245003;
	Fri,  9 May 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817450; cv=none; b=FaHmvChfkmuqsp17Kki6p+xkzvCQfK5nZLoBJKt0ERPH58MrfaE8n/Hak3oJNay/G0dMUqQRwIx91c2RwwbmxVNGidAOcHSCimLFKLGSaoztZTxWtVjptDRBVfWC8BBERd3g3nQBr5fMN7wIaJG75942kqG1Kgypqj7I7Cm6NEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817450; c=relaxed/simple;
	bh=LbkIdg+5qz9GLLe1tdKoyymSPk/AgHic/oHsVR8B2O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uM6ckIAFGM7j4UXb7w909NQYBw0KLb3JywEuDdVN/0+0kfYJrf4nHuvSImpb2wLa6YB688JByj/dKQ3PRQ8uuPMcsPO9rn/d2unNwJvbDCWW5bdI9ZifvBRlMSY46dvCALJtVcSvZZEre13FjRHOieDzVwo1/wUH1kBxUzPMyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSz3yLbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B547C4CEE9;
	Fri,  9 May 2025 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817449;
	bh=LbkIdg+5qz9GLLe1tdKoyymSPk/AgHic/oHsVR8B2O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSz3yLbB5SGPhtGdPnP0yjqfSCJu8SV0c4mpnXFykLTj+7aVDw3boR6qzh4rG9V1w
	 ZkkTGDs8w2n3VPFGT3tPGR/v+xVvTz7ibLssFaE3Wpo+56yzQi7IbB/fXR6rXa4Ael
	 a59vTDmMiFpMgHOkb1/Tq0QEpAyRkn8nuUyeiKWratuux9BEBFlCkyY0IxrsiUpBf+
	 3VvfXjl3TG1M94kydjJ2n15CWfKDTCMI1Y9AwQij59lrIEQJiotedrIZFV2fv8hdOS
	 CdTd8fk7OhMaTlgbfTM13S49bgcl8CrvauYdZGFlRsRP6Kl4pV5o6w1gXT78cc+SrI
	 FwRV7NdHcpFeA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 15/19] sunrpc: Remove the RPCSVC_MAXPAGES macro
Date: Fri,  9 May 2025 15:03:49 -0400
Message-ID: <20250509190354.5393-16-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

It is no longer used.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 6540af4b9bdb..d57df042e24a 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -150,14 +150,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  * list.  xdr_buf.tail points to the end of the first page.
  * This assumes that the non-page part of an rpc reply will fit
  * in a page - NFSd ensures this.  lockd also has no trouble.
- *
- * Each request/reply pair can have at most one "payload", plus two pages,
- * one for the request, and one for the reply.
- * We using ->sendfile to return read data, we might need one extra page
- * if the request is not page-aligned.  So add another '1'.
  */
-#define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
-				+ 2 + 1)
 
 /**
  * svc_serv_maxpages - maximum count of pages needed for one RPC message
-- 
2.49.0


