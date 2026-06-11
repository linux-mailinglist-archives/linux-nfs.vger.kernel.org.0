Return-Path: <linux-nfs+bounces-22512-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l8WBH2EVK2p92QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22512-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:06:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA19674F40
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:06:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hfTltCDz;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22512-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22512-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEB9731B96DE
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4273A7F6F;
	Thu, 11 Jun 2026 20:01:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6DC367288;
	Thu, 11 Jun 2026 20:01:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208086; cv=none; b=ulPhBWk96+pZpRRP0AzY/8K4Sq5pI04LVndcNRRu5uKJRE2ve2ijviChEIUXjLoTCBEXQTvnVYPeKdKQXMLgpvcWcV7MlVA6fhdYG8jSDjAi6UF8abd34coL8BxvBYYhz3CTpsmXZrlpUKQ4Ji4h08CIOi+m3ZsR3KDzxgCGkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208086; c=relaxed/simple;
	bh=ElXBJxHoO/+5LnrW3BYnMZfLR1dfH4fwXtgt+PNtj7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NlyQQxmWhsKmkF2d+HhU7rMOA0RIFsteQz5o2gf/FtcztyRooeRX4fLL/lke1RyEu6FEYRrJGPms5ucbMLHmZKH7bglxX9hwGtBhh4xnSPXgtRraZtThImgmgvFWj9DuROE7u6zQazm15C50gIx4KzxUznb2nNKq9C2EofUh5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfTltCDz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088111F000E9;
	Thu, 11 Jun 2026 20:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208084;
	bh=d9q6zLjIiqDu4jNpYSKwcJp0GtnMDCSLQqjcxNlh3Ho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hfTltCDzFcKxVG7J9cigAyHQDBizcKAyD1pjN3NLffQaJm4x0XZXv07Qv42sEN891
	 wAJSxIACqzExhoD9s3vY8hSC7v/Dan5WqMd57taf8rZF9vgZmMQsFvj+Ijb0T5nXrV
	 7KE1BfEtHCU4bRGyGXKr5159Zda9S+bn33gnb1baQBPyBq+Iq8xf1Os0PIc/ZWfaTC
	 WhCdOOwB/GZmz1fPBNCYF0dKtqDL8HFDlqNEGc43lUMV2nxNOtplB+knUEBjtg5kjg
	 A+ob7JvodIFaFbrirQObgjeLh36RnzRnL+9lN/eB/kW6tKaYwWLJ2xf1sEgRj0V0mP
	 z7y54I7w+hqig==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:01:01 -0400
Subject: [PATCH v2 18/21] nfsd: initialize DRC hash table before
 registering shrinker
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-18-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ElXBJxHoO/+5LnrW3BYnMZfLR1dfH4fwXtgt+PNtj7Q=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxQArBJLYrE86dLPlRjhSQPFkhHCUFAhTbnCF
 YEPEkgyiEuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisUAAAKCRAADmhBGVaC
 FVU5EACtIuULxg1XakR8IH3KM5bPyArzQ1hNeAvuFLgpaiCWu5aRPTa6ujGQpmF6HND3Nn5TsDy
 dZDvpj1t+OjgWgtsb0LYf92tQFGt2EViKxgcNkvHE+L9tFIl4bBJIglxmGYJ5oRKYHu/gWuPLe9
 PkyXDBe4xRvlk5pBeDntSR9GIibOn3vAAhq5vtyS1LBy/fA3w1Rb+tQOhqv6+v3tTkBpXHKZbtJ
 +1JviCHSC6hGdTP82nUXpmTvWM+qBrIpNbHstUKLHg9MeMa0vhTIi1AqPd0pCZptM5sbHb781ZZ
 +Xng4cxHRLCRxR3km0x/f0csz7FtgVx+MJ8r6vZlfivjkUfau2BENfgUa8Qbzvsa1eEcBhyQUCc
 sCXUaFzI4TswAsqQNDOPv1IADnLhKnKTpgrMtBieHq9+pzku4BwnZj2w8tN3N2ZIav/wXBiu9bW
 KDiNAc4xLS2Thqf2t30jYzTWfDZ8blpocqurNK+ZMq9GR/LZ8wP1Ghrke8dzDvupJyK7kT1ek4R
 u4036B7lGQ0BTHNwu6tDeHrQoD7M+SMUR6Lz/oTCqmODkckhYD8jbrMWqvUyvfgfKjM9mTnU04G
 z0XjnnHNEdNKSUG/3WXGD4CVJRrZZdh1Wzs1c85RgY1P06w+Tq079IBJJ5g0epeQcMPph9xkHhj
 qltwr3r55XbF2mA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22512-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DA19674F40

shrinker_register() precedes the INIT_LIST_HEAD loop and the
drc_hashsize store. On weakly-ordered architectures (arm64, ppc),
a shrinker scan can observe drc_hashsize before the bucket list
heads are initialized, causing a NULL deref in the DRC shrinker
callback.

Move bucket initialization and the drc_hashsize store before
shrinker_register() so the hash table is fully initialized before
it becomes visible to the shrinker.

Fixes: 8eea99a81c6f ("nfsd: dynamically allocate the nfsd-reply shrinker")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfscache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 154468ceccdc..18f8556d33dd 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -200,14 +200,14 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	nn->nfsd_reply_cache_shrinker->seeks = 1;
 	nn->nfsd_reply_cache_shrinker->private_data = nn;
 
-	shrinker_register(nn->nfsd_reply_cache_shrinker);
-
 	for (i = 0; i < hashsize; i++) {
 		INIT_LIST_HEAD(&nn->drc_hashtbl[i].lru_head);
 		spin_lock_init(&nn->drc_hashtbl[i].cache_lock);
 	}
 	nn->drc_hashsize = hashsize;
 
+	shrinker_register(nn->nfsd_reply_cache_shrinker);
+
 	return 0;
 out_shrinker:
 	kvfree(nn->drc_hashtbl);

-- 
2.54.0


