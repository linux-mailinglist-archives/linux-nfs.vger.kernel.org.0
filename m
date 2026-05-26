Return-Path: <linux-nfs+bounces-21961-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLCILhyjFWprWwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21961-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:41:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9575D6B67
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B53663040E19
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220E73FB05D;
	Tue, 26 May 2026 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzXiU3FS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A13FAE10;
	Tue, 26 May 2026 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802576; cv=none; b=KehIPT/4VBBPESBQ3kO15vTJnE7JZI2JqdtBwuQFAoPspx++wtw9CkLWBcR+vOvunnxTXqaF0JoK5f3nZquf+Vr0THn435U0z8+88yOMATQzmrcGvFQbTb+wmyTC9bN1IB4DAsFuevmUfD8O1MWppLRjz3+hVh0DbnGgaGqMrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802576; c=relaxed/simple;
	bh=81Uaye2GhiIyXxVO5/NPGcqCnxQfIRFo8uyzkfCf1qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PmC/qTfswUClHoIXi1hQ5i92QfJ5NJubEz8kVDdK1VOHK9eLtbzXP8I8cPXPVjnQ4Tg9JM83w0Txcs9jmK9PBWGOXHmIod7+bxe4Mhg1tDEfLpMNBsKARpFT//NaO7SQIlgiSFTg0S3ZoaRwu3rNqq5IMxZJQV63DbMQlPKhvIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzXiU3FS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD051F00A3C;
	Tue, 26 May 2026 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802574;
	bh=xhRtTRiC9k8aoGYlV/puFE0SiaTj4OqefosxZwH9VHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kzXiU3FScK1/3+It/CFdcInOL5aGIpMINJlcT0QzIdlbHdBoaXxQ9s5/eoLyHTTVJ
	 VGxJSxtPPKbKF/41AUFoVHVXo3N47S9jkOFbPumMv7rPjpDO6nASa8JaxIjR9ezclE
	 5e1+PIEuZmO4ga507HEX+P7L9h9keOClOz8GqIG4ubbTJMFRefhtoBLjwRw/oNlxZB
	 VDkqjlRgWXD7Xh2aakBd1B9U/7OihMMA4y/bopDeY6/i63buHc7IjE8S8ZeM7kP/Nh
	 /2tf+Wzl+UlNxbPqfjoNy2/IpR2z98wT//Hy8+97/NMYPGYKhTJFFYTr4Tv+wtjiUX
	 aYxjFsBsDD2dw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 09:35:59 -0400
Subject: [PATCH 5/6] svcrdma: reject Write/Reply chunks with segcount 0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-rpc-kernel-bugs-v1-5-e251306ccca9@oracle.com>
References: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
In-Reply-To: <20260526-rpc-kernel-bugs-v1-0-e251306ccca9@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Chris Mason <clm@meta.com>, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=dnsEDiWrnWCei6Rcu0l776N6x3BQvQujvlES+BMAS7w=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFaHJ/B5QpWcSYPulmsElKjp8oh0PW+VrCo35w
 0SZ6fmOTFuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWhyQAKCRAzarMzb2Z/
 l6+lEACFiO5PCw8TSNh/fgSHj47UHOHK3bcuvxCRt5npscL9nINrfx8IrisP/dgMBJ6romhe0Dp
 OXC1LRkb+WP0dzKGwWTrJ4DlR7xyPStZ6+GsfMB9mrfOgUHzP/CBw3WUtY5Dx0zZm2H+xqRsEgu
 qeHGwjq6SvQUxEET+kqZbjp58d41zssi8DgxRTbBdc66GYEGGzzgDauLHEToyUj7HMXcC3wvzvD
 S5JxsT98tDAyfZSOvzYg/tfN0tt9fRnjHVyrhBAvNA4Fl2a69ybg43DUIShPEr9ymgH5ahdSMFk
 46F66hkp/hkOKiJngemutthP/IwlyNjW8cd5d7pJq5lTIU+psH91tdQnI72iA0fzG01iLDvOv6x
 52eXpvEpSiLf5PrDvdP5uvbJhl0ht/ifRrv6Cp161XhfbxUYiiO0xn1vqUgojZB+YXPbx0efQfJ
 TRJUuwvXK027RRn/7TQ7NTq70Wxc1FEpwnCLaBDF9dn2LvcZZXUOPc8wdH9CedUSFvYyAu8iL3D
 THaBdGx5NdS2/y/I6UtaYSjCWdEH8QX6vllQU/K0TjNTJXESly38nwuzCY79HFmKVEtmne1XiqP
 ImMlC/Bq+cp9RO7Fkk4besOdmNDHc5gO+FS9OfJgl+iPx9RGWoTja/GKNjY1e6rtcF7tN6Z8TT6
 v/k7P9srsl7gHnA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21961-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,oracle.com:mid,oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BD9575D6B67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

A peer can send a Write or Reply chunk whose segcount field is zero.
xdr_check_write_chunk() only rejects segcount > rc_maxpages, so zero
passes the range check, and xdr_inline_decode(stream, 0) returns the
current (non-NULL) cursor without advancing. The function returns
true and pcl_alloc_write() then links a struct svc_rdma_chunk with
ch_segcount == 0 onto rc_write_pcl or rc_reply_pcl.

An earlier patch in this series made pcl_for_each_segment() safe for
ch_segcount == 0, so this no longer drives the memory walk it used
to. Rejecting the malformed frame at the decode boundary is still
worthwhile as defense in depth: it keeps degenerate zero-segment
chunks off the parsed chunk lists entirely, so any future consumer
that walks ch_segments directly cannot observe one, and it makes the
zero-floor easy to backport to trees where the macro change is more
intrusive. RFC 8166 has no meaning for a Write/Reply chunk that
describes no remote buffer, so no legitimate client is affected.

xdr_check_reply_chunk() funnels Reply chunks through
xdr_check_write_chunk() and inherits the same rejection.

pcl_alloc_write() also links each chunk onto the parsed chunk list
before filling its segment array. If a future change weakens the
segcount-0 rejection, an incomplete chunk is visible to consumers
during the fill loop. Reorder so that list_add_tail() follows the
segment fill loop, ensuring only fully-populated chunks appear on
the list.

Fixes: 78147ca8b4a9 ("svcrdma: Add a "parsed chunk list" data structure")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_pcl.c      | 2 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_pcl.c b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
index 1f8f7dad8b6f..18d1045799ce 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_pcl.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
@@ -213,7 +213,6 @@ bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
 		chunk = pcl_alloc_chunk(segcount, 0);
 		if (!chunk)
 			return false;
-		list_add_tail(&chunk->ch_list, &pcl->cl_chunks);
 
 		for (j = 0; j < segcount; j++) {
 			segment = &chunk->ch_segments[j];
@@ -225,6 +224,7 @@ bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
 			chunk->ch_length += segment->rs_length;
 			chunk->ch_segcount++;
 		}
+		list_add_tail(&chunk->ch_list, &pcl->cl_chunks);
 	}
 	return true;
 }
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 15c1d8ae5301..f6a7533a7555 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -510,10 +510,13 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
 		return false;
 
 	/* Before trusting the segcount value enough to use it in
-	 * a computation, perform a simple range check. This is an
-	 * arbitrary but sensible limit (ie, not architectural).
+	 * a computation, perform a simple range check. A zero
+	 * segcount describes no remote buffer and is rejected so
+	 * downstream consumers never see a degenerate ch_segcount==0
+	 * chunk. The upper bound is an arbitrary but sensible limit
+	 * (ie, not architectural).
 	 */
-	if (unlikely(segcount > rctxt->rc_maxpages))
+	if (segcount == 0 || unlikely(segcount > rctxt->rc_maxpages))
 		return false;
 
 	p = xdr_inline_decode(&rctxt->rc_stream,

-- 
2.54.0


