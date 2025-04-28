Return-Path: <linux-nfs+bounces-11325-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C17A9F9B9
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F7A1A862C2
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1130B2973D4;
	Mon, 28 Apr 2025 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjDkKOuV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD10E296D23;
	Mon, 28 Apr 2025 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869038; cv=none; b=fOS5euth7DkS4gDbT4lToUzHxJL32Cmx8Sf/PmjXC9ttxt11BQATkkXgQSl4yvSAXaj1cSrrmrKOtZtrZFLURtIkWNu5cMMS7DvUNdnYSrmGIRk+nkDDynnNSzT6Wg+5Oqnr2toB/PNL9bZ6/Bi5cRRMHICE5NYo2CKQ3kkMhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869038; c=relaxed/simple;
	bh=+yM7Syy4c1oC7oGnsDjAUXLPQ0BvPm2m5faVcb9Nwts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyxAuB86SEF6b2YKmmzOItamsmKxJmlQP4JjPpsRYFSI3nN3uP6KCrI4kZR1/8eqgrA6j6fj3luNx5cA+tFP9LKPZWH4d+jLtVzvCRBiv3+37skUBkjYJL8calvNW9mPRp+j/mrUbP+YYswCYDuMKigHCW/BID5na2sMj2RKvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjDkKOuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E058C4CEF0;
	Mon, 28 Apr 2025 19:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869036;
	bh=+yM7Syy4c1oC7oGnsDjAUXLPQ0BvPm2m5faVcb9Nwts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjDkKOuV3T+Zk+jVh0w7pXX9Y0G+YaoHh4BGTbmAlUWQmbRxI15rujE4duL8CkRcg
	 HnIbfc5B/rzX+hQaMJckbphCYzTkK67nvf3BAwh/xJLr0zFM4HxAlSg2Z43a8GkWKe
	 5ewClkJbabHiD72vT+cYbQMsvtGCaWu7aAHJrPowzDG0Itm9zaWuD3i4A0KPBPXQLg
	 L4SAt8biRCdazHeMwFsLk91b00u8dTH0PLVeOrmIyHvt+M14GMf8k8s55Wka3en+l+
	 75ZfpzoKXW2aqT0uO34+EtphnT2gS9ysyPIa0vi4RWiz+hTDaSprPlKTg8oMQ4VIid
	 CGI56/Ub8Xcng==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 10/14] sunrpc: Remove the RPCSVC_MAXPAGES macro
Date: Mon, 28 Apr 2025 15:36:58 -0400
Message-ID: <20250428193702.5186-11-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 4e6074bb0573..e27bc051ec67 100644
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
-- 
2.49.0


