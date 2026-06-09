Return-Path: <linux-nfs+bounces-22402-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IsFJDpZDKGoVBQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22402-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 18:47:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7AE662900
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 18:47:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Vryh6vZV;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22402-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22402-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D74A3211DAE
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DEF3B14C7;
	Tue,  9 Jun 2026 16:16:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6053AFCFE;
	Tue,  9 Jun 2026 16:16:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021764; cv=none; b=lljlrjPWzI+P9XOsURg3sDCSIhMgk22Ct7AIv0Nwc2/mKnkg2KIykBzMOF2ScK5BT2WcWaTvHLfTJAaIwlpvBx1Gv7IC7gFUqAeFNm1LIKg7ul/2XuzNVpAdHSjyJ9XYiKGZTRDuD+bTNa8f8aB45+0smx6UbJbV3TyomvyBxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021764; c=relaxed/simple;
	bh=0DyK6gpsbXEKdN+zvODLIFmNbG9l/JlTuIMh+Vp/ZCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q95e89BUKKU0uUCeWVn1mdtegdJgddwOpaiOWs0bg2Kjt2afHmC+PoD3QIZJGYA2Md05XRkbsDH/E9dik1YdfFpMOV6pvo74sc2P92lG8d3+p1N+aMiFlaHfBgvCJsTgzVOvwuiYYFyvV6aSPK7kYCtCYmbXcl7RkXnRwikbNMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vryh6vZV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFC91F00898;
	Tue,  9 Jun 2026 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021763;
	bh=7GUrlKj+2ZTyBVhmXbHZ9ccQ+KlfhqvBRavl7nGi83A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vryh6vZVsKmtPWGRxZCb+u8uN398fKPn8BeyU113+fipGstuQvck+vhYz1XAP9nM7
	 RpALzBBu//5yG1KV/EZBRfVeajqoOB1O1H4SKRRNm60VXwiReUBYGVZX5dkqMNoHFy
	 uPEOj6gsZe0afnZlcRojC0+YWPThDpjXDfO4s9QvdZjlgd7RRJvNIAtpQErbhvdx/C
	 XR/T1cSIqEqZPV9FzS0FU2brxIgo7IwWJheJ9ox7GFxgephI7KyY3MDsA781MJwrrR
	 WBdOpQ5dECAjx3n2vHAQVbRdrp/YyI0jdOHfXGS0InD4mitu1LvvtAVLzY/q1+JWW1
	 YZrVOe0xik9dQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 12:15:55 -0400
Subject: [PATCH v3 2/4] sunrpc: use per-net counts in svc_seq_show()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-exportd-netlink-v3-2-aa5508a5bb1d@kernel.org>
References: <20260609-exportd-netlink-v3-0-aa5508a5bb1d@kernel.org>
In-Reply-To: <20260609-exportd-netlink-v3-0-aa5508a5bb1d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0DyK6gpsbXEKdN+zvODLIFmNbG9l/JlTuIMh+Vp/ZCY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKDw/TZxo+xPVoj/fG58mKcAEfXoVfS4VGzjQR
 4A2hPGN2u6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaig8PwAKCRAADmhBGVaC
 FfZWD/4uh7uGaZkWd8YhQ5QVWgH71guErFduJc29ECSNXNcpBQtQZL5d8YrfzjdZ0wfUq43W8h1
 B77pGEn4ekjxjLsd4F1bRnbK//2CXSHDh5Th/1pcSwYRULbc9JNe+Y/iqBWMr0sxzoaoI/eGbkA
 Hw3oxjSg23U5dqByrO72PyswjbJAm+2rUrtB+Uo0U5IRpo8kLcGGD6zDJY2pWOWt5eWyFiR/O0W
 Eqf/fARqe3JiB2rZ6xlnlNEadKViywhvAOjjQwEaHmdXgE9qLtWNRKVvInqvGgVxCikkuVIt501
 1Y/gPVxI3lMhwbXY1wEVDcl2LuNiCZqJ9+y+eufn52En+ZAwvEcOrFgzPO+7MKytQCpKgzw1/XP
 DMmYZrugxS6hT+O/5hEHmiizcyfuwTwUuhaRiuX370CjVdZAnOUH758V8MzXUjmtU9m3jKINW4O
 dxfK/7jFmSdZddkmu3m7pb9EHkGBPjMV4DQu58jfQFqvycKwjmalLRSWYBY2GUSTynEPvw74DZ4
 G7HAGjo1F1jsJO0EbRDIDUXrQFCPIU//HCM6ucu01npmOhbd3cpxMsenj9qv9ZT4eZCZAr51YyI
 a7HvlmxU+kUqo01RuWPKRZsce67b6fE23e0JBmQvrYzoIpFl77oQOj2PmN0U5rXK7Voy+69QRZ+
 w4TPrKBArCdUXXw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22402-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B7AE662900

Update svc_seq_show() to read from the per-netns
statp->vs_count[] arrays instead of the global
svc_version->vs_count[].

The only caller is nfsd, which always allocates vs_count via
svc_stat_alloc_counts() in nfsd_net_init(), so the per-netns
arrays are always available.

This makes /proc/net/rpc/nfsd report per-network-namespace
procedure call counts.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 5bcecd2919b1..fc2db251dfa0 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -108,7 +108,7 @@ void svc_seq_show(struct seq_file *seq, const struct svc_stat *statp)
 		for (j = 0; j < vers->vs_nproc; j++) {
 			count = 0;
 			for_each_possible_cpu(k)
-				count += per_cpu(vers->vs_count[j], k);
+				count += per_cpu(statp->vs_count[i][j], k);
 			seq_printf(seq, " %lu", count);
 		}
 		seq_putc(seq, '\n');

-- 
2.54.0


