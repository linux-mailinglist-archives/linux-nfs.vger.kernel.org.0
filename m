Return-Path: <linux-nfs+bounces-22425-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +Dd3JRhWKGqLCQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22425-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:06:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33A6632BB
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:06:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QEl77KvL;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22425-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22425-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0CBD3064AD0
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E893C1096;
	Tue,  9 Jun 2026 17:48:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D23C1080;
	Tue,  9 Jun 2026 17:48:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027303; cv=none; b=cSGIdeOPcK12SVpJ+Fm8Yh95BR+HHVpoUXPTFSxum6ooUYlbHm9+ZShckZ1ftGdqJnm9VG7bizwuD7zP/5SoZXVuIgy0R8favsS4TlQu6FV9V/IItwrjTOhWg2fYTgFI0s8mXipkSw3jOTf0ukn5gzzvVR66VAJp0L+vGXRLAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027303; c=relaxed/simple;
	bh=+BX/F5t6UbaW8f6cZR75zWLul5OcpS5cpITd0rvsxtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iEslCKESs0RO0kepbIU3tB9lNklMP2QqtYQzmF4hGZ5x0hZ+aLh88FWgBiK2bGtrZdnFzv5Am4r1U7G2Qcc0NzDDAy5mEj5RTaEyDVOVvdhzpI3KO+W3S9SBTcyVNB9T/SscdXJjKFcWHEKWDbW3/VIC1DvI1mIBSBYkgWB087o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEl77KvL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82611F00899;
	Tue,  9 Jun 2026 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027302;
	bh=NAEvMwCPKo9IvCK1nLH/PJL4Fw8CuWJ5RzWY701L9xM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QEl77KvLDsKCmp6gGSBKnkFj9V8ioOhzQcv8wPizgm7fmfF5qgnHec1PCtoLgXDPU
	 uUBYzM1lSUWnIKike9myNPMBsIemUv6YU67XYhDzbS/J0CDkuZUce+cxfLzsQVzLQm
	 GKRew/QFXtsCpXTCifSDA1rb0/9mdr/seVWAyNuzCG5FOFgZuifxpVaEZB0Q4zmJkW
	 BqCcjxIPpeyWEIdCyupA8E32yefp2mbnVL8EGS2NNNT+fs98J0Npc1FQta+1DSg7Hk
	 bijJhQjOWkuPVF3wHFwS2txlahiynE9LbZHgW5MSOOuVOdnXuayvEjC1t0NXRLawq5
	 z4W555iVl/xLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:39 -0400
Subject: [PATCH 18/19] nfsd: move nfsd_debugfs_init() after
 nfsd4_init_slabs() in init_nfsd()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-18-e83acead2ae8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+BX/F5t6UbaW8f6cZR75zWLul5OcpS5cpITd0rvsxtg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG9dCBaL/cvkqBCak7RJnMmxTv4ARyFTSfz+
 sw4cJCyfDOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRvQAKCRAADmhBGVaC
 FatlD/4kLYC0tw7agDidFUAyET3IzP2Rbr5TmNekndcADManWYWNLTU6jUuLED2I358vLLtRDKI
 XPmj7xTn0JnZt7wrZZrS9Wt4XMOCMysAfjpA8Fs0GgqrcoBCucgrEsikZLLRvun6ESvT4C5RyQD
 7rmUNCNwGJo8Xy8FPM1BnSzXBW/ySW1mw14E4YXRWvBNrWUtLdnQDTUxL85jcihOK5tmipX1FQA
 swUrVSM4hHPixvS7xTKibkDWNbKxOHylVdTyGOivFZqh1zF5ecwjYYKZSOTIH+DyiyyDOs9jKD6
 ELGkQ6RUsGaqEY1Fy4pHpRzjPilb9iXhxv52zt2rFx0ij2lofhrlkfPHHMRyJ5n7BhqdZ+oVtx9
 6ccRTrDB9X6Ilc8+C1WrtSpMQUqTmbkKp4naWlA+a5f1DP1mX7cbxwwHJuJ239ydX+WpvR0hD0b
 zLWa1sbg8XmIeuvms5BtqbjEPV4EDXwIGZXqLlRu2zBvg3SJQ2KsqQ4W8zmNriuRCS3xH1/Q+NX
 rDIvFWd5/dRf2+P+o1+B6s/kijbW+ufEEOvtOYSd7Ec8qoSbVSinOlQR9x/ASKyEE70X3r8GkNu
 oZekwBBL9ZuHbn1kjPLewewnxZzFHlkq72H6jwH1KBVuveNunTvF4hCSDeuRRL/DM8VoLDEAJ+y
 Ho+9Ty3I9kHI4Ww==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22425-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D33A6632BB

nfsd_debugfs_init() runs before nfsd4_init_slabs() in init_nfsd().
If the slab allocation fails, the bare "return retval" bypasses
nfsd_debugfs_exit(), leaving orphan debugfs files with stale fops
pointers into the freed module text.

Move nfsd_debugfs_init() to after the slab init succeeds, so the
early return has no debugfs state to clean up.

Fixes: 9fe5ea760e64 ("NFSD: Add /sys/kernel/debug/nfsd")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f3b3154b16c5..b69e5f686e9d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2557,11 +2557,12 @@ static int __init init_nfsd(void)
 {
 	int retval;
 
-	nfsd_debugfs_init();
-
 	retval = nfsd4_init_slabs();
 	if (retval)
 		return retval;
+
+	nfsd_debugfs_init();
+
 	retval = nfsd4_init_pnfs();
 	if (retval)
 		goto out_free_slabs;

-- 
2.54.0


