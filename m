Return-Path: <linux-nfs+bounces-21958-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFlnLqOjFWprWwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21958-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:44:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E85D6C05
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C60C3301B3E0
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8AB3FA5E1;
	Tue, 26 May 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLp04D4l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F030AD0A;
	Tue, 26 May 2026 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802573; cv=none; b=HiSR3UEC/m1j5a+JKDTQKoKlKSsUrijnCVaSGGRx3dIjGoswVfLLdKmXAh61cXCfzK+AwviLY5M7R/7nINgpuabZqvde4G7m4O8uVAwxf5a9CpSuy76yAEkyGDPw/sCQQzazDDb/IoaCjlzLDXLdLOVgTk4COa+hkA8dEsu/1q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802573; c=relaxed/simple;
	bh=LHDWF8ywGhssNiSkfZbEm15c7a7VsjjXiA1PcBG9Gc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MCpkSMr1mISPVmPWiu192+GxQJ7zrjAHK1X9bzLxXvvIlmPAW5LNC6mZthBaYVnBv+lET9VU+6nyoYY73yYhvl160Mvm/PZ5oXid4TshbIhW3DSMPdZAUrBewbGKWoXhBDOLDf6+UxnzIRxm6l8ffmkPxMuINBOhpkZLBtY9D9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLp04D4l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B681F00A3D;
	Tue, 26 May 2026 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802572;
	bh=TUL8xctbnq4UK573WJ7ShuQUa47RoP0WeevkUSAJO18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gLp04D4lsTDPFM2f/waBpPo2PkV/awuN8jETeEQjDrwS4PeDFoxmL/OEk4knIL+v4
	 vQAIRLAjeUKiKDA2d+AQTO/IMt83UVf3cZ7F/g+MBQSYbfd92hs1XybLLR5oxSiVkR
	 0ROqJxqHhRvUIPyxJ1luGa8C66uRBtwoY3EZ2grnSTtSUjCY/GqkigEMNJCG7kdqYX
	 v6pCcJgwmlvaaxqXMtfexOLb28DDPDgeGlOtLPCzGUUPN+6Wg/EXQ5O4+j07RjZNgR
	 SpsrpcK//JQTC6DhC/hAbXSVg+4FY7EqOy16JUCASNkJIVdeCrjBbv87rXH0OXYAAO
	 yzvEK6nLQonNg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 09:35:56 -0400
Subject: [PATCH 2/6] svcrdma: Fix offset arithmetic in read_chunk_range
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-rpc-kernel-bugs-v1-2-e251306ccca9@oracle.com>
References: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
In-Reply-To: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Chris Mason <clm@meta.com>, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=cEKy5fCX3fTxKm+4E+QhBo9OAh1Zpt/deF8qxI1okUw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFaHJcFstWbR5MjLrRrvQGaPRruLQ/Mph8SaqJ
 zRxdkzXJveJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWhyQAKCRAzarMzb2Z/
 lzTsD/9JF/BMfrtiLGXGtxpReKVcwzwPCh1oqaGToirZKLmQ5Apv2xeT0lA7GI6/GUTF7gNJrNi
 mLfvuiuwhK+GxB7FuI3p+t71nOzSe28H0zLui74xnFveHwV4FDm0588Y6381stThd5kOB6oo2/n
 BHOHMNZeNU1RGNs/U5ipqZ4bxZy95t3FfbnbcgmBflmvpsYRrFAswqPKCOcivWXSYh0dcdH9yXN
 JDQ65NlipU2C5sA7pRnBrFU03/JCArXtRoM7GNsairdL/k9+1d3JjfUvbSmgrqgcy4MmeKCNCZo
 D9ij9aDuBqdQ3rFK3x7rVv1hF0YJP83u9U+XIyf6oHXEek/q0OOgVlGIFRtyEMJdWHm/64iMTQY
 srH4CHLUhlXTSSnAf2JXfG5EMsz3dlc0nGG7hwgwIlt/kSQrErXNozduIAZzuv5zvSj5la07Rb7
 LaFJ5zNAs7xpOh087ftk4Jm5SAQwwlywXF02a5qc6aM81g/6Uwuj0evFRz30JnkR0IAuTtWyw+K
 86GsxhkaywtU4vlIDPeJA5Jz2pOI9IBEjRmJr/nVBL0uPVAHihMy87fZGh5Fo68tmH6PSztpyFA
 Jue8kFsnQwsTp54pGr5mj1EqTX2qVxhIfxQ/FWSfl7R98Do3Vg7Zu4KVDvW0m4RHblnSmxABwCO
 ou4sDd4JiTbX0/Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21958-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,oracle.com:mid,oracle.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 707E85D6C05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

svc_rdma_read_chunk_range() walks a Read chunk's segment list to
build a sub-range starting at byte offset and spanning length bytes
for a Position-Zero or Call chunk. Two arithmetic defects in the
per-segment loop produce wrong DMA lengths and a u32 underflow:

    pcl_for_each_segment(segment, chunk) {
            if (offset > segment->rs_length) {
                    offset -= segment->rs_length;
                    continue;
            }

            dummy.rs_handle = segment->rs_handle;
            dummy.rs_length = min_t(u32, length,
                                    segment->rs_length) - offset;
            dummy.rs_offset = segment->rs_offset + offset;

First, the skip predicate uses '>' instead of '>='. When offset
equals the segment's full rs_length, the segment is fully consumed
and should be skipped, but the loop falls through into the body.
The resulting dummy.rs_length is min_t(u32, length, rs_length) -
rs_length, which underflows to a near-UINT_MAX u32 when length is
smaller than rs_length, or is zero otherwise.

Second, the length formula subtracts offset from the min_t() result
rather than from segment->rs_length before the cap. For offset > 0
the segment's residual is rs_length - offset, not rs_length, so the
cap must be applied to the residual. With the current bracketing,
whenever length is smaller than rs_length - offset the per-segment
length becomes length - offset instead of length, silently dropping
offset bytes from the rebuilt chunk. Combined with the boundary
case above it also enables the u32 underflow path, which propagates
a huge nr_bvec into svc_rdma_build_read_segment() and a multi-MiB
kmalloc_array_node() in svc_rdma_get_rw_ctxt().

Additionally, svc_rdma_read_call_chunk() can invoke this function
with length == 0 when the last Read chunk ends exactly at the end
of the Call chunk. With the corrected >= predicate, every segment
is skipped and the function returns the initial -EINVAL, rejecting
a valid request. Return success immediately when length is zero.
Also break out of the loop once length is fully consumed to avoid
passing zero-length segments to svc_rdma_build_read_segment().

Fix by using '>=' so a fully-consumed segment is skipped, by
moving '- offset' inside min_t() so the cap is applied to the
segment's residual length, by returning success for zero-length
requests, and by stopping iteration when the requested range has
been consumed.

Fixes: d7cc73972661 ("svcrdma: support multiple Read chunks per RPC")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index eb4bc56ed387..182bd577e0b7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1227,17 +1227,20 @@ static int svc_rdma_read_chunk_range(struct svc_rqst *rqstp,
 	const struct svc_rdma_segment *segment;
 	int ret;
 
+	if (!length)
+		return 0;
+
 	ret = -EINVAL;
 	pcl_for_each_segment(segment, chunk) {
 		struct svc_rdma_segment dummy;
 
-		if (offset > segment->rs_length) {
+		if (offset >= segment->rs_length) {
 			offset -= segment->rs_length;
 			continue;
 		}
 
 		dummy.rs_handle = segment->rs_handle;
-		dummy.rs_length = min_t(u32, length, segment->rs_length) - offset;
+		dummy.rs_length = min_t(u32, length, segment->rs_length - offset);
 		dummy.rs_offset = segment->rs_offset + offset;
 
 		ret = svc_rdma_build_read_segment(rqstp, head, &dummy);
@@ -1246,6 +1249,8 @@ static int svc_rdma_read_chunk_range(struct svc_rqst *rqstp,
 
 		head->rc_readbytes += dummy.rs_length;
 		length -= dummy.rs_length;
+		if (!length)
+			break;
 		offset = 0;
 	}
 	return ret;

-- 
2.54.0


