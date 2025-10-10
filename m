Return-Path: <linux-nfs+bounces-15127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF2ABCD5D7
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D54189205D
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319E52F39C8;
	Fri, 10 Oct 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpRHwNYz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE072F1FFE
	for <linux-nfs@vger.kernel.org>; Fri, 10 Oct 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104591; cv=none; b=be6xUKzSoOw6q0vRPu8RT0pudUPB/hKoxHU5RVNfy9qVPS7vnkcNT93At6ec3ldXNNCrEExeZiNJUcW1E4KDUMhDPiprTbibObN/FQYltYTUterDQYRaAH8fqRjfPH+HrO/uClziRGrDoZ+saTX+rf4Fe+4F959ltI2Ar69QjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104591; c=relaxed/simple;
	bh=a9A41uN7jOQ2VvBfex844BcEbxJqR7N0HGWaUJgpLg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0xM+gvVfVpK3M0WciwmQ4+Ozn6cYuZHtw+rcOJ7uzCkoa2GvmOMfNe6vvb8+BqGURVSkny7XOtQH/otfcZ6Bkgm2g5W555S4kYpx13I5kdWDXF01l/m3CR+fCDD+mSsaCoUbY7d3mhzNAx96Q/Lw7cbNLq3pvHO56utA9mYQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpRHwNYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F512C4CEF1;
	Fri, 10 Oct 2025 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760104590;
	bh=a9A41uN7jOQ2VvBfex844BcEbxJqR7N0HGWaUJgpLg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpRHwNYzSICa0j08kAGXfuKBL8zJSfk6gNSZedVB/RQzpFtNQRKimvTSRME5fvFNq
	 iZgS0/FFg4wFT1a9PHRgB1oDZwj2prASSSKrEyfkhLLzJ7/5/FnJhj/vsKJG7T7gGk
	 1E01WEOAPUEYEkJbybq/pFIA03fRjw+zHNQxZDxEdrC0FBSVHh0PteveL00DEtVyjL
	 gw6iX0jLHQdLWRncEaHHiuunBP8DwFYOXP1UxGTldNtqYnTQHT1SOhjRhONyY/xftD
	 6d7MaKk3Fjy88XtlEkBeyJKXKrVKdh5/fExIz1PPVGwdqu150lH+qeewObV0uMy0eY
	 Jt5u/ePbU5jrg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v3 2/5] NFSD: Fix the "is this a solo SEQUENCE" predicate
Date: Fri, 10 Oct 2025 09:56:20 -0400
Message-ID: <20251010135623.1723-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010135623.1723-1-cel@kernel.org>
References: <20251010135623.1723-1-cel@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


