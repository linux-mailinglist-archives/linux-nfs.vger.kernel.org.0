Return-Path: <linux-nfs+bounces-22426-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id okSFE3lUKGoqCQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22426-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:59:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34D663226
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:59:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ipNqYq0z;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22426-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22426-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7973D317719C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247474DB570;
	Tue,  9 Jun 2026 17:48:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817A3C10B2;
	Tue,  9 Jun 2026 17:48:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027306; cv=none; b=ILxHJHts5+MAbxZLZxZwV+HrwyMPXVJ33HYnJ5eGolGNsAyHmPzYTidRqBq0EkbH58sm0EIby4hPdPxQCPyIQydxfgi5z4ScjBMdQR/0q1+q+JNggHz5BM22sEiaka2/8ghQx1PcJjeZdQAR7ansjO7SKnyG2PsefxGtMPEH6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027306; c=relaxed/simple;
	bh=ElXBJxHoO/+5LnrW3BYnMZfLR1dfH4fwXtgt+PNtj7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fRx9WLIh+Sxfc2+aJ3QaHA4TQZ/zHp8LfHuq3W00bZN1LPMfw0OSjVnXAnP8CJmCpIHJ+j3yawz3d3/PebnauHVbOtH5QOPQm0ilyBe9iwNFSJ0CNpaXLkJvgBMn+cAFeM8qW7LXtDmGzVXgy0mARRY1o3Fonu/1WhCPoHNaSGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipNqYq0z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69631F0089A;
	Tue,  9 Jun 2026 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027304;
	bh=d9q6zLjIiqDu4jNpYSKwcJp0GtnMDCSLQqjcxNlh3Ho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ipNqYq0z+IBf7k7uIpftYQM0bnm/8M7Q9E8orYYg0eNoHo3a/9piT6wEa28b1/BDB
	 XnoyWtwGU7cL/qUJ2/rNmsODT3J0BvVE5yDZM5t1yAdlftVKR6lMa2LeAQ29QT+P/C
	 j4wFRo+jPoJxBqOvacsEtnqz++80828NUL5xicLlFWPPDIpWTsTtPkXGjdL4YBO6sy
	 oC5+huh1IK7Bxn31gwBdAvSloC4JuhgFX/Lqo6FvglrVYGdUde4wetGoUKG5LYeLy4
	 2uEyligRN3KDrAWM8CYMbSa/nkymYuc79Vwf8sUE+CVWClaf6gIJ07XSGKdfsBSXKB
	 6X2WVAm70WjRA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:40 -0400
Subject: [PATCH 19/19] nfsd: initialize DRC hash table before registering
 shrinker
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-19-e83acead2ae8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ElXBJxHoO/+5LnrW3BYnMZfLR1dfH4fwXtgt+PNtj7Q=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG98mA2HmN6vZjthOxq617T80VlmQVCt2gSP
 tWUjr2aHdaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRvQAKCRAADmhBGVaC
 FctYD/9CJX7SEDUiXBQWdaJOTrVh78wpvPKeefQoky5pgLeTaew0c+vsSVlS5lH431Q99lcABLw
 W8a0qWWG+zqylj4jcTkhfXQ2j2sYiesIKqib3cBBtFznav1ODQ3gYF63mM+Pc9z5rocwMD/YHEP
 A0B/2a8ZRz9W2g52CzOKYadkOIAmBCo+Zua/rxHAdXoTCYBBlRj9yzHvjUb1bDiS/XfUD+y5ywG
 kJ/8qCXafMDW4wmawltGOE6/J1NbdpaU8iSoZ2yJ3MMpMUe+NJ3dp4pqFigEHNJIm09B1EjykrQ
 u6Qc0QfvGQQHLOq/WM3UyE8Tev0NEW9AMcNzmo52jOoX6gw5LiEaUd/AAPZsBaQ4Ze9uzJXdlrD
 zJfTZUEPWbTw+FHD/NcLBtlHMZO+enfzy8hAKPDEH/PC59TleLi22GEAAgYIK1Drz9Ou7zHa5Z2
 BM2AlVDMryh/T6OwHLt6I7PVSkgcllt0vStZ98D/AloQnhQgP7ThwJgvrzuhXqTmA4TlkzoZsBu
 Bu0Hnk/4Kk3MiE++9SvU9ZsqbZq1h1C19IA4FJg/aEf1f54ATa+XJReefW3niK6FU5c5SU0wbFp
 BzpLqOwa1KukjatJY9Odt6oYPqy4AuC47uL8/db4pA8y8KCmmjlX+FvGkvZvE7U3n4IScPiAXCi
 i+uUvP7EqMMRV6w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22426-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC34D663226

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


