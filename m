Return-Path: <linux-nfs+bounces-11245-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FBCA99222
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E847921D99
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC1285417;
	Wed, 23 Apr 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOrZd110"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC62BE118
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421689; cv=none; b=PrLjE9OxkLk8xcziZwmmDhG0fnyq+vJjmh37EzmT/sK6buMKujGyrGZBL12oVjrVYQZfSNRMb28U2IL7yevTnsxbHnaVtEIPKlLPJLeqsk0Lv/EZOrGILH35S+Wp962kzIjs6JFcfBIc4GLx+oz5SY5z4mpk4gXGQt+qBnps9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421689; c=relaxed/simple;
	bh=+yM7Syy4c1oC7oGnsDjAUXLPQ0BvPm2m5faVcb9Nwts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh1+JgAevDX0f3OP+M6b1GMozJ2PzQ18luZ4pzIbdoBWBdgfag/9u8GeRoraVERe6a7/gx/sgUD1Nr1brPidlT3CEt1+nLjecdwRFqMJ2WZu8tZhcoy+xfXnQLUZAi2OdAz2MiFJjEsD2pZnMBZIxn3PFGVPBlzBFKNqD+RzSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOrZd110; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E7FC4CEE8;
	Wed, 23 Apr 2025 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421689;
	bh=+yM7Syy4c1oC7oGnsDjAUXLPQ0BvPm2m5faVcb9Nwts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOrZd110jdhzR1f8bKPZbZk6ug5w4OwDIVfjx4CcbVe/O9mgzrGbaLi/nVrgb0uSi
	 EssL8gQUP2sGMpXvjyz7fhg8qA3XgyZsV0hPxXuCWKwKaWSaXwHE7ND7IUTvGtcICN
	 eivRMyKVMBogwWQziMtBAnH26YvDIuvRqg0yAMy9Aab3QLnaqSVA76bo4aHtdOinju
	 waCVqnh/aLZgBiVJWb+REng7AYaC5RccgO//ebIvecqUQPo4b2+v5YySqnDw0woCtc
	 rVbFauI/lDiTskQGqFaJD9ZyF6TnCQXi73dXVzNsh0Zp9QO0Cfx72JVDY+krg7csft
	 hrhzZV77l1yJQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 10/11] sunrpc: Remove the RPCSVC_MAXPAGES macro
Date: Wed, 23 Apr 2025 11:21:16 -0400
Message-ID: <20250423152117.5418-11-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423152117.5418-1-cel@kernel.org>
References: <20250423152117.5418-1-cel@kernel.org>
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


