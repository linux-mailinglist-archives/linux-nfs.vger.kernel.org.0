Return-Path: <linux-nfs+bounces-22414-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KuDZK/9TKGoJCQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22414-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:57:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A266631DC
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:57:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=InQax+4c;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22414-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22414-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C65306EF37
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8362C4DC523;
	Tue,  9 Jun 2026 17:48:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC504DBD99;
	Tue,  9 Jun 2026 17:47:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027280; cv=none; b=Q9wnGMvFt6hVh2bjDjGUCxiuLLpUo6DUL436lKIasJS4h+tg8EMhKLa9vh7d7jppibpW7uoApqAhT/VQhfBqYtDSHATY83xgo2pjZHd9Sr1A/nV07UUS71XB+HmL23ifiIotdVyHxci+hoeW3vHr9ypNO7g3sXRjC3Q8B9Ula/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027280; c=relaxed/simple;
	bh=xFqxutJ+f4FpSKjLP0lMdRDlzdB3jsc0hGiwqEaTyOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAcVsh0jGQ31XPfQTH9nDRlgQMXAFoyOmN+z3k7R1S8iMf1EfYvuzERDqFTaywauY/YswoIfsce+OxtzK3DKobxh28WM71csVKiEe+4W7tCMqLr/DNNMW8gYGKM9T9YBDsiKG+5tsfsQlr3qWDfsWQ63NqJub4U5InTxIy5730U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InQax+4c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8781F0089C;
	Tue,  9 Jun 2026 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027279;
	bh=zokuPcGiysTqXDq3BMFb2Qckz2PASHlXgLW22BFrL3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=InQax+4cADS8HfWU+JQA7N5OrGluFfLZYM8eJN2H73ZPC7u9IHU+f1OV0+JDOP1/M
	 Sm33IOVzcEpS3Em86Kdc+L5MGHmCRZ5F7cRcUlkqAcMFueb/w3jGLQnoTrL/lIU4PY
	 ygwPSwCwOcw3FKC0PiBpUO2gOjCpV3/e0uqq4kJbNUy5OJA5XpyWeyjGxPP+i/0FT+
	 2ArGUtkvaNsnJ0+f1pGIGon+GAkkKYCvmLBf9gRC6XkULGiisKmDUjd/DjR7aKsrIE
	 xNNHhatCAPimoPTnoHU8LiM9pONkfs0zZPjq+y1KCXZWdqWGoCO2zo/WxbFvPaX9Dw
	 AYOgE0A0ySaxQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:28 -0400
Subject: [PATCH 07/19] nfsd: add filehandle match check to
 nfsd4_delegreturn()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-7-e83acead2ae8@kernel.org>
References: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
In-Reply-To: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Benjamin Coddington <bcodding@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xFqxutJ+f4FpSKjLP0lMdRDlzdB3jsc0hGiwqEaTyOI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG7lV0p9X5WLeF329VeHtJRWnbRtjBo+9U6C
 xaaXWyYsXOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRuwAKCRAADmhBGVaC
 FQ44EAC/SNEO9iPYjMEkAKMMD6NCZv26mdjmz4UzFHlTyezKcoECf2yJkOetcApnKAyIRdR7Qhr
 oWr7Cm3abInHuaUthcwEm6kSRMBuvjfxIADSBu57HIDLtUScJOeQc9+kZXTbCaysvAhXo6tBkv7
 c/KPNH81rTmYY1KU0xY9fkqJ1HmopmZi19yP1FJ2RpOa009ONH8ABfIabr0Qv+KXhD8Cb9v120c
 s/BqFpzQJNHve8nvF+QLxoll35jnMyea1ZsStjFcoWtLPICjfB72a3nZphpXiVbm7IJzm4dssLi
 FtAtnl3D9p0bzOM5lWO+XQ7kaghoWBD8AzYwFSwGZ+mvJdHJ7rFjx/xhu3KvLfpLGqAJPqwRnrc
 G4bGwhAI2ge6cqmcUtYurGf8L1Y2hUYy3DHsyepqRH5c3jQ4Fb5G8CIo9dOqTXHYLyzIWGvVNxA
 Yd9hIvYryhIThznvcXg+jA3qhOWTcqYlPHnrb6FP5h4D9i/G0jhDYle+lzqKUqZ/9C9uotVchPU
 DbuQ/DM9dZRAQ1E/sDcV/XQg0pjrdTMpVj6S9fdihJ4noEcUyRTdX3ie0k5Pb9BQR1O7o6duVGC
 AyqCbNGMjHsi/wOnzKQGYjIlkqpGOI886XwBIxQ8iem6u5X62U51uk1TW89dieGkirqutIHttmk
 TVBCP9RJeRx/eTA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22414-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11A266631DC

nfsd4_delegreturn() is the only stateful NFSv4 operation that does
not call nfs4_check_fh() to verify the delegation's file matches
cstate->current_fh. A client can DELEGRETURN with a mismatched
filehandle, destroying the correct delegation but waking the wrong
inode's waiters.

Add the missing nfs4_check_fh() call after the generation check.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c88637406773..19aab4c52548 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8079,6 +8079,10 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto put_stateid;
 
+	status = nfs4_check_fh(&cstate->current_fh, &dp->dl_stid);
+	if (status)
+		goto put_stateid;
+
 	trace_nfsd_deleg_return(stateid);
 	destroy_delegation(dp);
 	smp_mb__after_atomic();

-- 
2.54.0


