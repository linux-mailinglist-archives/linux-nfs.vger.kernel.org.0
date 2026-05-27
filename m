Return-Path: <linux-nfs+bounces-22026-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHTJFXA9F2qg9wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22026-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 20:52:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 649035E93CE
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 20:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC2A4301C9D2
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1463B8921;
	Wed, 27 May 2026 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMsw7Bx9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA613BA241;
	Wed, 27 May 2026 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906651; cv=none; b=tyEnxO+KSLm7n3OglE7DJNdgkY9z5nwk/MwUWO0f0Gd3jEU0YJPLL2+ertBmjxvM909y/agKR+8Fg/lFaCIWBoD+y3R9aYGIQ9Hn8L0mAdiTt7IUgYaomBCE+OfZ153rJNe5EbFONQEyiDNsHfn2RNXrYxIO2HYZpuG6nXSLbUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906651; c=relaxed/simple;
	bh=ZANtEzuGC5cyemDzaR0P6OArQ9HQd2EvvZiHu816dBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JfUkDLva/rkO1TDOm43zvoF1uVEtmuWMg4KavVb86UVkBsD+R9ltkQRz9RMaK4+IGwrBfjeZlDmJWIc72j/8Y8wWiKGLoKrgpeqcPnraaWtdgdXIJUI5YqaLzZBuHzdFtl598kqAz23SiRRiRkaFVp0Yk0Vf1lT6+Npzm2gYrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMsw7Bx9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9271F000E9;
	Wed, 27 May 2026 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779906650;
	bh=+8kZw9j4jyv71Pq5CFD164U5DTMxo9JNNcbMN3/oa7s=;
	h=From:Date:Subject:To:Cc;
	b=PMsw7Bx9DVyxf8AiRCirKDJ5VaqGMhw+W53R0p/7Y+qX9IEtABZ3RdWFSeN/GTEdV
	 0gyT0uIz5Why2isynbIvW3sox501IhYuDaNyhRCF2oU4GFmQO5YjdAp+i8Kye839x2
	 TJKZqocPzYnOaq17tum/TFgX8fZUsunVTuRK4WdCk0L5g+gk8LRROs2k7FdXI9oBBw
	 VjcWkV/VtwFPwMAbsXr8x8bEP2rUvVT4kZRwWGMZDbKw8nOmsWQ/SDUaOifSkJz67P
	 6MVT4yBmwmJJTaWjBPhpIWBTYWUGRO5xMFVtylNRBGRWFyilqcbQuzLIzp0361wnw/
	 u9kAAneKgKLaA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 27 May 2026 14:30:41 -0400
Subject: [PATCH] nfsd: fix XDR padding calculation in
 ff_encode_getdeviceinfo
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-pnfs-fixes-v1-1-784f39dc1eca@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNz3YK8tGLdtMyK1GJdI2MTU8OkJAPjFFNzJaCGgqJUsARQfXRsbS0
 Aeht3BVwAAAA=
X-Change-ID: 20260527-pnfs-fixes-23451bb03d57
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Sasha Levin <sashal@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZANtEzuGC5cyemDzaR0P6OArQ9HQd2EvvZiHu816dBA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFzhVYCnHfvYxBd+pHRdXUTvnjDis1aL82VAY2
 Ux0nuT5nd6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahc4VQAKCRAADmhBGVaC
 FSh7D/4hnRt78c4nDL3wQIUgdgO92BmwrG24g/7Xjff7Hs6ltR8+eUk8rh9ESfOnvb7ZMjKQ+vn
 nE++/r/aiJUwMLguek86vJPMrkd24kLHEBV09jNkKqq4FeZrTa0xHVMc/Cn+r73BCrYDMWKuLnh
 71cOp6GCTgrCjOzHVWBhAQeHZ73sGBwthEhcUc6Q88Hbf/Fn8A15kM4kJz0rl55UuNZ4rzO9tOs
 CaJTb3TgEgwpODsQJvqL33lvZnXQilym3b+m1DmaeotUMZBntaW2rQXlVFOuSjXrdSmr2xNY1t3
 DDQunqvHoEKgcUD6QLByQ/PSpphcHe/Ei9/vPSpyQMwwRSDrdByooU3cjzikGcw/e7OlAbiffNq
 Sp31vg5dFcExMDbS4PcBAOccOnZrPhodl6EPWVSSFR8XmeMH8tFU1j3IOO6htvumQISl99k1qG7
 lLq+oyEwy+Xs4b3QqPjc7iB0DkPmAGngEfHlLq/wjV1U/S1F+7KxZ4iTRg31DznKmSFZCc1meuV
 dDf6wR8z4rYrPhVr9TtnQdVGxNW2kW9zGsxW6HJ6mpy0/n7nr8k4oddrRjbFLwLdbvJGm50NhO6
 0E9KqUjRfEmq4dJu1kVSUqRZ51Kpq8DufY/HR3nP/Ioxh6DZvZ2IILxfjCGOMGMwv0T3/QsoYwR
 M7tF4gNNzQ3P8lw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22026-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 649035E93CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_ff_encode_getdeviceinfo() computes the da_addr_body reservation
as 16 + netid_len + addr_len, but the subsequent xdr_encode_opaque()
calls emit 8 + round_up(netid_len, 4) + round_up(addr_len, 4) bytes.
The mismatch means the declared da_addr_body length exceeds the actual
encoded data by 2-8 bytes on every flexfile GETDEVICEINFO reply,
leaking stale reply-page content to the client and mis-aligning the
subsequent version list decode.

Use xdr_align_size() for each string length to match what
xdr_encode_opaque() actually writes.

Fixes: efcae97fa425 ("NFSD: da_addr_body field missing in some GETDEVICEINFO replies")
Assisted-by: kres:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/flexfilelayoutxdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index f9f7e38cba13..7f357dbd1bb1 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -94,7 +94,8 @@ nfsd4_ff_encode_getdeviceinfo(struct xdr_stream *xdr,
 	}
 
 	/* len + padding for two strings */
-	addr_len = 16 + da->netaddr.netid_len + da->netaddr.addr_len;
+	addr_len = 8 + xdr_align_size(da->netaddr.netid_len) +
+		   xdr_align_size(da->netaddr.addr_len);
 	ver_len = 20;
 
 	len = 4 + ver_len + 4 + addr_len;

---
base-commit: b69fc3eaa867d0caa904634ea7a1b4569411b163
change-id: 20260527-pnfs-fixes-23451bb03d57

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


