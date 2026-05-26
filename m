Return-Path: <linux-nfs+bounces-21960-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJfjNhOjFWprWwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21960-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:41:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA725D6B56
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D155D301B303
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A93FAE11;
	Tue, 26 May 2026 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhzXXq6a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0E3FA5EF;
	Tue, 26 May 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802575; cv=none; b=VXQVi64qKM+HlltvLH0UVPy5pYNJeIdT705w7FUAhAcoOBiaelZ3I02Ju1m+mUMHMfZOAOC6ssE+LWwAGz9Y/b2ZDAJht7m27qFQDREvA7ztli4Z5h/kMF2iTUcc9BLq8lG2xrPuEPe/ThedM4sd6P4U6vMyAOmzeWjcYYdVWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802575; c=relaxed/simple;
	bh=7cqAwPCKd7MbuY3l6i8kxAqekRXFhuC6iHww/DvRYDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvQ207AVlf3kO5MyGMkdWFqrzPGLvRyJaLItQy8vF9MmMaDsOUJ/dqcZc+w4Dm6fhHNomtNtAc89Li1Jv6U9x12X4LvqGxpwxXs0Md7Mi90SPKNpGHgjQR3AZ2I/pOYztX0Rf0e6ZUH2HnI+cR4aISLkNnq1GWpjJuVbmTysmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhzXXq6a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6E31F00A3A;
	Tue, 26 May 2026 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802573;
	bh=Py/t1qdPM8/CYeVJC2fR5yUF9PXCwu01EqSknL4K7Rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hhzXXq6a/zDxHjs7hyHSjbAhT1IHfHalIX9D0GiQQnbcR+G9lIPX7YF38eIAO9FMT
	 cJH2qnWT0hljLf80B0Y59ARbMRpNEBVVYdtfkvimnGfZufxKINT9dmb4wkwIu0iNUj
	 eKUXK87+KxoE7ylac0mnV7RJdp1d/HG3PB5P1YdG4SWl6ifZ2ce7aivQW81Kqw3uLD
	 9HxpQ33qxkE10X7ZmbOLlll8jMw5Nthh2yNTV2psV1Sd2meWL0ry5Elprqzf5GtmxD
	 xhCrLpRgxjf79CZXxJf0e5WElfANnMseddZhzxZabfNg56GQV0Mi6wRqf4xn7cCFZL
	 Ogdv1hEehkYDg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 09:35:58 -0400
Subject: [PATCH 4/6] svcrdma: fix pcl_for_each_segment for empty chunks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-rpc-kernel-bugs-v1-4-e251306ccca9@oracle.com>
References: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
In-Reply-To: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Chris Mason <clm@meta.com>, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=YUAkqIVawbGaiiOZ+0EiUC6qToS4dhKvzLqmTVlb0dI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFaHJxSYD7285liycfdKBYsqeIOrxFOKMKvXlN
 mhU/NPZiS2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWhyQAKCRAzarMzb2Z/
 l4xWD/44PsK7xRZZDx+Bl3Xb7Sk13I9B3xLaUEhUoLRHbm4nRc8yinEqzz7DnZrfDwLVprv1+q5
 Plbye/iNea3tG/iMgojk3mqAK+4tjpZHvTjtJwgC8nIDIDLQQGPqtjDjdpT3FN+lkGMlks/2HBK
 Ve0WRzHDZ4Yt4DQU175f9wjQSj4hk3Ht54xWkLCtUZCN6C79jo13KVDZFkUi6QOPe4y/vwFY0pV
 j4KqrFnWbzMaGcH3Br/+vbQMV0ubWLm+GJpCQwo3SzEGZ08LrrZzKgUwFAkYMrpNAOAZMznD7Cn
 TEX5Pd0PNMR3PuQ4zG/FbzJ2QrOCS34QiLI+QIljAZ8CBTGcHbJcyDMSW693arSAG9X5Crp6nBD
 yuHkCQa3KL6vcCAPywbrOZUFZdmSF8Hi/7ONG979i6426qH4Aih8EpVcxYctA/MuQgg3uC8HskE
 QqTP/Z8CFqIlRmbhYtEcfnNpnj7lzPQjhURl4Sak/QG07PEfTe1w8hKGBPaj4jSCX6uCIK7fy+P
 oSWZ5MxEOwtjJUFRLJPnbKgELHNcpqLaasOsIH3ym3jQjx3k2U+SHAwldDk57mCdu08fTN+sgwk
 NRFZM21Aiy2fuwSeqLnZuTwqU8r+hfC/EStiA3cjTFNfjPS7wziyekTY0s4Atc2gvgLOlXfAphL
 1hex0WYQ9ogot/A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21960-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,oracle.com:mid,oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0CA725D6B56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

When a parsed chunk list contains a chunk whose ch_segcount is zero,
pcl_for_each_segment computes its inclusive upper bound as
&chunk->ch_segments[ch_segcount - 1]. ch_segcount is u32, so the
subtraction wraps to 0xFFFFFFFF and the bound lands far past the
ch_segments flex array. The loop body then walks unrelated memory at
sizeof(struct svc_rdma_segment) stride until it faults.

A zero-segcount chunk is reachable from the wire:
xdr_check_write_chunk() only rejects segcount values greater than
rc_maxpages, and pcl_alloc_write() links a freshly allocated chunk
onto rc_write_pcl/rc_reply_pcl before its segment-fill loop runs,
so a Write or Reply chunk advertising zero segments leaves
ch_segcount == 0 on the list. When the transport has negotiated
Send-With-Invalidate, svc_rdma_get_inv_rkey() iterates all four
PCLs with pcl_for_each_segment and dereferences segment->rs_handle
on each iteration, turning the underflow into an out-of-bounds read
and a general protection fault.

    xdr_check_write_list / xdr_check_reply_chunk
      pcl_alloc_write()
        chunk = pcl_alloc_chunk(...)  /* ch_segcount = 0 */
        list_add_tail(&chunk->ch_list, &pcl->cl_chunks)
        /* fill loop iterates zero times for wire segcount 0 */

    svc_rdma_get_inv_rkey()
      pcl_for_each_chunk(rc_write_pcl)
        pcl_for_each_segment(segment, chunk)
          pos <= &ch_segments[0u - 1u]  /* 0xFFFFFFFF */
          segment->rs_handle            /* OOB read -> GPF */

Fix by switching the macro to a half-open upper bound that uses
ch_segcount directly. For ch_segcount == 0 the loop start equals the
loop end and the body is skipped; for ch_segcount > 0 the iteration
range is unchanged. All six existing call sites in
net/sunrpc/xprtrdma/svc_rdma_recvfrom.c and
net/sunrpc/xprtrdma/svc_rdma_rw.c remain correct under the new bound,
so no caller changes are needed.

Fixes: 78147ca8b4a9 ("svcrdma: Add a "parsed chunk list" data structure")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma_pcl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_rdma_pcl.h b/include/linux/sunrpc/svc_rdma_pcl.h
index 7516ad0fae80..655681cf8fed 100644
--- a/include/linux/sunrpc/svc_rdma_pcl.h
+++ b/include/linux/sunrpc/svc_rdma_pcl.h
@@ -97,7 +97,7 @@ pcl_next_chunk(const struct svc_rdma_pcl *pcl, struct svc_rdma_chunk *chunk)
  */
 #define pcl_for_each_segment(pos, chunk) \
 	for (pos = &(chunk)->ch_segments[0]; \
-	     pos <= &(chunk)->ch_segments[(chunk)->ch_segcount - 1]; \
+	     pos < &(chunk)->ch_segments[(chunk)->ch_segcount]; \
 	     pos++)
 
 /**

-- 
2.54.0


