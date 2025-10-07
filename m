Return-Path: <linux-nfs+bounces-15025-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4FBC2083
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 18:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803583E24EC
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22E32E719D;
	Tue,  7 Oct 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao6uugUz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7252E7199
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853060; cv=none; b=Bq2VWJfmLJDCY4X28fQxQk75A4FpB2929tsM16UkeULlrxRf3hoZRLmpTmRNsoEE5isd7lZLli4z3CAheDg0+l1i0v8SyzLfO7kXnX0km4V4iNStiquU0zVpCEef/8XcSPI1fejzo6yI0RTM9ZEPR1y09W130sdDVx6j1He8Pzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853060; c=relaxed/simple;
	bh=vBlJjLZh86nBoitsUMcC2g4vqXmKkd6Nhd0AGqaCnpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXon1offptP2aP7i34hDy9+IrS0v5eZe6HJ9i6id19w2fT4IxOCHTZqRgCWGym7g1RCq6pG4F+Px8jNs544kv96IYkZoaygObhUkUDSZKzxFuus0gH1wP15sZuHBZvljasQuO9seGWqKTefmYRSImxjTKoLgVXlYdZdbnPubIxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao6uugUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4CAC4CEFE;
	Tue,  7 Oct 2025 16:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759853059;
	bh=vBlJjLZh86nBoitsUMcC2g4vqXmKkd6Nhd0AGqaCnpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ao6uugUzS73qPRdEmqF7QdS4+ALqr654VQvTcqFfw4NodkLoa6uxcw80ejpFWvHz0
	 xYwyK9ZZ/gYkFXN/S8+ynD2LgbUJbiR1wlEQZfxVczzR/Q3vQjXrXwfs8dWqJLnzza
	 emzHUqzZRa6NPO1qiTGWZp3FgVOPSrJ+o5+niJXVytmvYoOcDoHCU0F6tStIalSli6
	 oqaeanLonwfviWzZFmZnjPoAMHUScGQBHS07pZw+WuYgrdqE+oZPSHgkF5WHh77fNR
	 BiSoA5lZtAdzlIfoqb0g62KfrublxraNdD5rSHZT1Z0Ak7OdOCDf0zdC1w2jwbI1tT
	 yBJAzDOmrF4Cg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v2 2/4] NFSD: Fix the "is this a solo SEQUENCE" predicate
Date: Tue,  7 Oct 2025 12:04:11 -0400
Message-ID: <20251007160413.4953-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007160413.4953-1-cel@kernel.org>
References: <20251007160413.4953-1-cel@kernel.org>
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

The logic in nfsd4_is_solo_sequence() is incorrect: it checks the
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


