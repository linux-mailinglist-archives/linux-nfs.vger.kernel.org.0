Return-Path: <linux-nfs+bounces-21918-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM4EAAtDFGqmLQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21918-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:39:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEAB5CA99A
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D9F230221F3
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FB6383332;
	Mon, 25 May 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo0GDr9R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747E382F1D;
	Mon, 25 May 2026 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712742; cv=none; b=A9gM+jdPQrw7XCFo2wWetkQG/13Oeco6ZE+jxsWYSf6S8Zb1B9b89g8kHfJ7gpwa3rutlzWDj+w+Lfj/QeDeA1GDU2nw8wrEXUrDTW0cZiOn3+IxIjjvYY8HaoMYwOWbn1pmxywEG3Tx1OExyuAziXWkwaogqwGK7jsvDvWThR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712742; c=relaxed/simple;
	bh=0DyK6gpsbXEKdN+zvODLIFmNbG9l/JlTuIMh+Vp/ZCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOOROZCzVHTEhTl1XClcMIDmmD3FZY+PyJ5RWJteBQQxcjGJqeu98BAtLyX9Y2x2SZAOGov5nKmOTlwT+93I4iPd718k7+ioPMVHjH4eo5GUBXEeKM6Q971IdrP8/seZhNr/8nJdupK2mgW8jl5VH2C1ViMhTYCaCDN0BKJMWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo0GDr9R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49861F00A3C;
	Mon, 25 May 2026 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779712740;
	bh=7GUrlKj+2ZTyBVhmXbHZ9ccQ+KlfhqvBRavl7nGi83A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Uo0GDr9RNR7ei/nJUwVtYH07PqMhSkZ+vZO7dX8g/lZa0RL2InCaUcDM2QlyG474L
	 oNAQw6T0mF45qSXJP81/ar2NYvl4UC1Fczc8wCHN2zPgd+VOl3EPzmtYYk2m1VKekG
	 76OKSVs7qHNd+n414klvyMU5T5AwsJdX9uVpd5vAZcN9/q1ywdue3cfPzE1jEMw4tb
	 WGKZfme/kCG5qf4zw1HbBSzbkhk1WGOX+Pd7A525kxMsa/enVmipnqftGX1yNyzn7y
	 ZoB7Au9xWpd6PZqUuikQjfRDXRd/m/bG+au9vi9sVZqOkzykrtr92Pw9a43kWFdPtS
	 Ln+4s8q2lT/7g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 25 May 2026 08:38:48 -0400
Subject: [PATCH v2 2/4] sunrpc: use per-net counts in svc_seq_show()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-exportd-netlink-v2-2-40003fed450c@kernel.org>
References: <20260525-exportd-netlink-v2-0-40003fed450c@kernel.org>
In-Reply-To: <20260525-exportd-netlink-v2-0-40003fed450c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0DyK6gpsbXEKdN+zvODLIFmNbG9l/JlTuIMh+Vp/ZCY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFELgg10MtdqX5pEaWFMZuNMew5ooajBL4Q+pw
 AK3ULoXHFCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahRC4AAKCRAADmhBGVaC
 FZkyEACw6RwzmAlRvQpW4pmcW2YIYVgC52iL2N2Qc4LlEFQK7qy0uh43q60nUAX3tTbryEuMK1V
 Sz2VO263UwiNcX4QQJZkmgwnO3LrcKYYkm6qZE5odSjQt+yK90B7rTpId5xXh/whSl6f/mdIgFB
 +HXNx++xiEL+dYls+ObRoBUB+a5EwXqLSY67ZhsOlZwGZvUIu7SOrgyupCAJbk2zZSA1Sq/vUeg
 kPsUgbYV9n5Ak/xpER3DwHdguMZYG/pkVWF0hd2MqtYmF5b5lfddrGfBl/qpRCeCW2bB38YlcLY
 BMZx9UNYkG4BCr8X9eJgEp3msFebzP7HzODkscDLWLqbwTowki2oc066W7p0R54zfsmcWkY9Gfw
 ZXVz7bs1SPrNr8dvjEFR22Qfp1IfaC3Znyvz+inmqnfsvGvxqrU3KFR/QaAMiA3tYKBeK+uTBkK
 j4NQH7wtbghqL4pwvp8qabScwfDERIquvndjm43mntb0DrHMh7BKnBVznb8xxsA8gKAgwYk3HCx
 IUZ6F+AgzGKSd6Q509Np4PLEBWgbvFvb0kHjsVBfWrEHngFFSYggvdb7lNxYcUGTGRjShfOF+qC
 UZMLvDUY38SfcxZepf50qRX1HjUu2702lVmqSiJOFHNBMkmtRHZRTrvpMLYSNzGqMRMJ1OYqtkF
 MfF4ZlsFxQkyN5A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21918-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7FEAB5CA99A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


