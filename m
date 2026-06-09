Return-Path: <linux-nfs+bounces-22409-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ik/BNpdSKGqeCAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22409-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:51:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 843F7663133
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:51:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TQmaKb4F;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22409-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22409-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E854307FE27
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEBB4D90DF;
	Tue,  9 Jun 2026 17:47:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A474D90CE;
	Tue,  9 Jun 2026 17:47:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027269; cv=none; b=JYudY/b8QRO4B1JNFdBF4tjiPXVT+U1XjundOgB4OokRcT1lAo6WMtWFXx4ztwbn91H3q4NULaJNYcspsK9vkDYLA7A0hEhIBqnNZNpcHunuUVI/bhyXPK0jnrTQbX54ECEujnqWy6rFmzsd/CqN5kOC9xeY8fjs97Pszeq0Oe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027269; c=relaxed/simple;
	bh=0zVSMKuIenVnVpy2Q3C9APLyKF0iawqJthV9fr+HXKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4cYpkhPanAek6pvAtlYyWafuqQy4F+allYZsh5nhGmmkIJ2REcMiL5BmldD1mqsTkYhP/hdPHXYz3bdXaQCq8woMu4sWQYDAB1d0lvq8cu8Y7W/T8Aym0iwH/vPfuzB72/WIFKbUxxw5Ih1yml5hWHj8uIWS61Bsb9MnYyEhwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQmaKb4F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE3D1F00898;
	Tue,  9 Jun 2026 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027268;
	bh=dGIYHSoSgcfqdopVWrafKZi9HKgDYhLdhUGzfdrh3FI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TQmaKb4F6d3S7/KdkrF7HhzUv0YYSXzrXIq7gTlNx+hBdd0v+4IZERF6p53PLFuHp
	 TxX9lukhz6ixaxeK50M7nQt9O/LVzeQkZsfUFE0zb/82hQv1ZK6luhvl78wD0+wa9g
	 VWcuvTwBR2hWnJWOOJeZMdQoR/l/BDeQq+vaSEjXbzEh5GPDOkXtn6RmhUsSzsuTJB
	 Pqdtfc1QqmOtI0ep4MpAnglUSnKS6h/qbQ0AovYdhSWKbA5HEplwaqLlNFVSn7c/UH
	 /Hj9cxNczN5eBDeFCR29AceXDR0NOtqnqkn7fBoy81tUp+aonjcrYZJqeoyQtzRri/
	 VD8tVXq0039rQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:23 -0400
Subject: [PATCH 02/19] nfsd: clear opcnt on compound arg release to prevent
 OOB read
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-2-e83acead2ae8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0zVSMKuIenVnVpy2Q3C9APLyKF0iawqJthV9fr+HXKA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG5S6dtjpizvsFDrRNB9RxXiSmbL+KhO2vOC
 VYyINGpwk2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRuQAKCRAADmhBGVaC
 FdVZD/48gn1c0m7IMvBQU6zIQviFzF/Zvcc/0/xD2EaDNCG0/af6WMDlmjGgS76sZO2t5eRfbjE
 zD0xvp5q/8gjpbC4pdFNYSAkaKD0k1Bqn42cuOkKnMmEr2WEO/0VctKlwRgK2fSibUf/HqQ9Z8+
 1SXx4AIdji5UrA66iWGyvgaAKA9r5rmOtWCTubCPnAuWBvlo+hxW12HPdesy1dJ7HyhX8Lxg/L/
 +DegBn6rixN3E4ofedc0gVdSqL154LyUKso2MYHL/Carbb/at/nuHMOnc7msRy/SFJuENLmEThZ
 hTolzovvKX94QmB9sMcY0NJQG9oPCxJq7hb7NRB/vDtzBP7V7T1I3F885pawk8sCW/6dnGJ02VQ
 anokTHuxPYOi3e2GW3/x4j2wXODvIEhRdLlzNPk1nYtnm2H8TWRew6vGMquqc+Cc0HFMOcJcc9C
 cRV3gFZSWsewvkZGTli4jXE58/nbXFblMA+1Vj8cIq5cPiJg+vZEJKdsextQxiT4p6cqL63bHTg
 F0IYWxITsabOUQ1opZr7mch1W1P1HvmSyHKTxzJPuAkE9WOpKNxWEPx2n/j6kyazQcVJh50TPId
 tjGu1dJWtB/9wQXWbcbORBHi5Xabgcxvs/RdW2Ibe+Q7Co9hr58ZpsFQ9Ig0WNmHq6TuXVk9zvl
 BRc/LKCWcciF5sQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-22409-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 843F7663133

nfsd4_release_compoundargs() resets args->ops to the inline iops[8]
array when the dynamically-allocated ops buffer is freed, but leaves
args->opcnt at its original value (which can be up to 200 for NFSv4.1+
compounds).

If rq_status_counter is stuck at an odd value (which can happen when
nfsd_dispatch() hits an error path after setting it odd), the RPC
status dumpit handler reads min(opcnt, 16) entries from args->ops[].
Since iops only has 8 elements and is the last field in struct
nfsd4_compoundargs, reading indices 8-15 accesses adjacent slab memory
and leaks it to userspace via netlink.

Zero opcnt unconditionally in nfsd4_release_compoundargs() so stale
compound metadata is never exposed through the status interface.

Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b9037d99b564..1e4a51926910 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -6440,6 +6440,7 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 		args->ops = args->iops;
 		kvfree_rcu_mightsleep(old_ops);
 	}
+	args->opcnt = 0;
 	while (args->to_free) {
 		struct svcxdr_tmpbuf *tb = args->to_free;
 		args->to_free = tb->next;

-- 
2.54.0


