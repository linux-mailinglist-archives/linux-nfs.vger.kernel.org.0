Return-Path: <linux-nfs+bounces-11188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907A6A944DB
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB2B7ABF77
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DB01E0E0B;
	Sat, 19 Apr 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCUFQ2oc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904901DC992
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083710; cv=none; b=LeDxpDpatBoT8wbsdSKsnKmaBRvLZ112FxEDlS7xYkuiGhOzw3Qe795NAtp2ieb76WpXGEHisPW1ML0SWpl5YbUqlGfS8XydvyrhB4XrnrnddkpKsuglUojdzeTeQx7m/zqlQqOvjyR4F7sug3LTDiaQPseL0kvP2RGpex75NaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083710; c=relaxed/simple;
	bh=KAXcUookChJ4Jf1AiWnD5F8WvErtwrUmeJSQrmBtOp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/ye2fTxkPPI9dHf8O4wusat4Rqr/ZZrDwEefajOHbOLvPRrbKWzaM0o6x3XyRYePiIwHZKfHNlIRpTcyakps9AioNm2AsXBxnpw/V15/oxdEtzSnxmlX7Kf2JCaQfIpIEFxjyb1DWcfDKnLWmpTOyUUG/nWJVMKnejfC1Wh82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCUFQ2oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E0BC4CEEC;
	Sat, 19 Apr 2025 17:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083710;
	bh=KAXcUookChJ4Jf1AiWnD5F8WvErtwrUmeJSQrmBtOp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCUFQ2octjCfjxWg7ZNeIU3o+5StGq39AQtcptPJrSNrPqPQ5t1NwTDHBJ9mRhrKA
	 ecn+ysjIml2nMNSj6TYcT6YRz6kVaS+/XKqXBIIIfC/EfA1hnIfiymm04ZXvx23twp
	 zb8Iphf+fXsH7BaJlxsmfRsYx6bByhIG+ARjzdWv90t8JOl+ukPYTRJGhcrGq7ZhPF
	 zAPc6ltJtI5VOQX6lgkiN1bD3LBqgE8vPLsbTSvrW4IfoD6jInlGPd5doax0pJ1pjm
	 FIP+LHf5blSAMTfDfvKsW7e7SKEZDO+PmWFFLCI3DMBcGUwDw/TCZ33PzzU29hceZP
	 w3nCcS+Par2ug==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 10/10] sunrpc: Remove the RPCSVC_MAXPAGES macro
Date: Sat, 19 Apr 2025 13:28:18 -0400
Message-ID: <20250419172818.6945-11-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419172818.6945-1-cel@kernel.org>
References: <20250419172818.6945-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

It is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index a524564094d6..f12abb476e07 100644
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
  * svc_serv_maxpages - maximum pages/kvecs needed for one RPC message
@@ -165,6 +158,11 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  *
  * Returns a count of pages or vectors that can hold the maximum
  * size RPC message for @serv.
+ *
+ * Each request/reply pair can have at most one "payload", plus two
+ * pages, one for the request, and one for the reply.
+ * nfsd_splice_actor() might need an extra page when a READ payload
+ * is not page-aligned.
  */
 static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
 {
-- 
2.49.0


