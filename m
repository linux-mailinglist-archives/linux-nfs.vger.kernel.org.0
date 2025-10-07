Return-Path: <linux-nfs+bounces-15026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AA5BC2086
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 18:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3EE3AEC50
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D56D2E7647;
	Tue,  7 Oct 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVM7DSJL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E372E7637
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853061; cv=none; b=LZkCxNJu+FfxOcZ+sUdbMlTY+sWEsUrHS4LjwKQmrsFR6v3MfQRadJ5j1VPGobw9nY7NLJl32fDXBi7EEigoEYJu9/df+fUxlBAkkkwSsR6ghtH6mddS1fpfT4nebt+MImSrkvtWBuFvyBxWmHAUgw14mRNOwz8HtMPaQVUb0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853061; c=relaxed/simple;
	bh=j9RVdYGkpy1zDLBhDmv5n19I4xw30Cu1t/2GUbnU3CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOVaqBrRaby4YtgmiKc0GAP+BpsXSV7E5bxcF0NwXck3gdgUdQo9yJYuKciI62r8+r0ImZNBBlr0ouXF05AulBlUR4F0SfKx/7VsBp7K+ILWZmM0usn1PKP1QJ1iLj9JlLVkK3cfliRPCnJiIZA8z9V19fUbCASUn7+ps5uH2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVM7DSJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168ADC4CEF7;
	Tue,  7 Oct 2025 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759853060;
	bh=j9RVdYGkpy1zDLBhDmv5n19I4xw30Cu1t/2GUbnU3CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVM7DSJLyj0LH2t4voITXL536cZB+hVMAG8Nvle9pXyhwEsx6PPAyLkv7/A8Gb2NY
	 T95DWVDJ5wedd5bs4YvzaFNJnKVfMfIdzn7PyunbcBqsV/brIwtdBOz4SXubmvkSur
	 OS553CtvuiAIag4A8AJyEiGYa+yjIsx8DDsXfSk1RUDMa+VuoHZcGPpkWLFNMhG9tt
	 MVDfHu+9E13bF3DTBJOYQgGbnHtcSfGwoFlrmB5CpPH6rjM3/Y6dE/uz8i1F6bvQUE
	 BQE/cwjmHpxNFr6kUC3x+FrIfCHrCGM6SJUctuaceKIKUoKs45Bj7WoSKIO0nTq9CR
	 Lwqwk9/7IWDng==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/4] NFSD: Do not cache solo SEQUENCE operations
Date: Tue,  7 Oct 2025 12:04:12 -0400
Message-ID: <20251007160413.4953-4-cel@kernel.org>
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

 RFC 8881 Section 2.10.6.1.3 says:

> On a per-request basis, the requester can choose to direct the
> replier to cache the reply to all operations after the first
> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.

RFC 8881 Section 2.10.6.4 further says:

> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
> cache a reply except if an error is returned by the SEQUENCE or
> CB_SEQUENCE operation (see Section 2.10.6.1.2).

This suggests to me that the spec authors do not expect an NFSv4.1
server implementation to ever cache the result of a SEQUENCE
operation (except perhaps as part of a successful multi-operation
COMPOUND).

NFSD attempts to cache the result of solo SEQUENCE operations,
however. This is because the protocol does not permit servers to
respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
always caches solo SEQUENCE operations, then it never has occasion
to return that status code.

However, clients use solo SEQUENCE to query the current status of a
session slot. A cached reply will return stale information to the
client, and could result in an infinite loop.

Change the check in nfsd4_

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/xdr4.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index d1837a10b0c2..9619e78f0ed2 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -931,18 +931,19 @@ static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
 }
 
 /*
- * The session reply cache only needs to cache replies that the client
- * actually asked us to.  But it's almost free for us to cache compounds
- * consisting of only a SEQUENCE op, so we may as well cache those too.
- * Also, the protocol doesn't give us a convenient response in the case
- * of a replay of a solo SEQUENCE op that wasn't cached
- * (RETRY_UNCACHED_REP can only be returned in the second op of a
- * compound).
+ * Solo SEQUENCE operations are not supposed respect the setting in the
+ * sa_cachethis field, since that field controls whether the operations
+ * /after/ the SEQUENCE are preserved in the slot reply cache. Because
+ * clients might use a solo SEQUENCE to query the current state of the
+ * session or slot, a cached reply would return stale data to the client.
+ *
+ * Therefore NFSD treats solo SEQUENCE as an uncached operation no matter
+ * how the sa_cachethis field is set.
  */
 static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
 {
-	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
-		|| nfsd4_is_solo_sequence(resp);
+	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS) &&
+		!nfsd4_is_solo_sequence(resp);
 }
 
 static inline bool nfsd4_last_compound_op(struct svc_rqst *rqstp)
-- 
2.51.0


