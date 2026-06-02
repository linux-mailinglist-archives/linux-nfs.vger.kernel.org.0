Return-Path: <linux-nfs+bounces-22210-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lea4GTIGH2owdgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22210-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:34:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4316303C2
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:34:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H2JxTnCo;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22210-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22210-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 226AD302605F
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A436998C;
	Tue,  2 Jun 2026 16:23:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A4368D72;
	Tue,  2 Jun 2026 16:23:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417417; cv=none; b=SwhezT8IBF0G+0HxVqT2GTBD/byUCdj2SuHciVZZnTQkbsjbELQECKdPt+TPv6TRDO5oHA3ySjHJEUKAqel5/k78zbracPJi5zrjCxQinCAUwIZTmlaw+i6XuKn91KVhMWN0o5Z+WHMo4aR6xRM7xfnrYwnQnR3Gcbs1DVaNOZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417417; c=relaxed/simple;
	bh=5GmFOsoGsxUoKK42L6oIuiqD2T2yto1PqXZGDDjnR7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnNNeAozazXQOEKPb+y8FhszKHpYqxlzi13TsJabfCd/35X21PaPTTVjD/knOz6Af2XCPGaExf/Sz3zuLk1yQB3WV5BkP42oNyc3osnKBjNELuJ2RZug5CCy348+6zKVPXybB4x4rpU9SnYZofDNXURi/+7jwCcPcqXPzK7lda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2JxTnCo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBFF1F0089A;
	Tue,  2 Jun 2026 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417414;
	bh=GQSR5xDyG6bHaFaZRpDiOp0QGRNuyvccZonIX15jpMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=H2JxTnCoGu8WX+wzc0MAVusSiHpKZHuXbdUz+08I7y2B7kAsXI3hjFHxVc8S+oqiT
	 iS9lS9HvSFzAWRQnkeqU1ZQNAEsjvCkth2rCmES53i3z3nL2FY8ucFagOj7vke10+G
	 T6OA2lgSr+XrBpkc3huUHx0ZnZGm0Ewd8U3FITbU8TjkPSYa9A3cLEq6G+kCYuctpF
	 MoEIERYQZP2BsEW7ipZu2ThDMvAhVDs0D7oxyoGPNq8dRP+c1Ib8r6vlXkwdfJaAiC
	 exr4wp/5AV1yQWGibVY9qUbxaxnwNhJVzLm69yu4aSq7jQkmv6etg0LrFxBLyln2b+
	 2SCVprRijCsUw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 02 Jun 2026 12:23:16 -0400
Subject: [PATCH v2 4/9] nfsd: guard nfsd_serv deref in
 nfsd_file_net_dispose
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-nfsd-testing-v2-4-e4ea62e3cd5c@kernel.org>
References: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
In-Reply-To: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@meta.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2274; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Dxlhw3GNlHUspVC5P+k7IYi9cq5Erg9fOpoK54g/QOM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHwN80PjCqEUxeONFLfla8q+g3gzpvZ0XzwiXZ
 YUbBiG0RlCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah8DfAAKCRAADmhBGVaC
 FZRMEACFfDgjU5J1YrmZbXO8B9Lv+beB3Er7RfTK/OvPCmJLNeo1j6f96yUQiZwtPy8njX9nVeV
 OfF9u7fKHzxh5oDZV0LIQ7eDxCU5X4u7XcejqYzMlHfrGZe8A5KBgC0XUGeBsv1J4znB2h3t5st
 oDgs+hbEpC6rrhLgbKufoJPiSiJBv+iu5Cvt/gJLvLNNtTvMgQLCtBgNGuj9hfkm253xZ0tA1l2
 7qmJ9hnqUvxobl1l/XiFLEhs3RrbTZ2sEE/Y3Pu1sEgAZwR6Hxudn15evvzXYB+G3WO0+0J37Mq
 8bZTiIsjDRw41MIsyxTFuXk1AUXOkrSKr9nBohkXjn45gZNhYLGRyTeCFdCXQ3gmRq5FyQ74gEU
 p/I3gQOIyxB//XvI4/hjmD8Gv1UarOS1Mbsn42mZj8VMIEpCeSj58BCDdSXz/SEPOhM0r3OzUhG
 IW+VRXryh43Kw99olGhPZQXtgCci7mbIvJO+oRdmjBjH46y5QJgjcXCJfIGJSA2ZPug2KXwJyso
 JunBN6DRxF8jwC0ZSekhJbjCrXqJEyPXYkdmT5b0zuNkglTtIe5F2SsjrtqXklIa4VpcBjQY84+
 XZMZ0trkDk9wvTd+AhBLQMWvD3NLp5FAVesM65A+xgjzj1h2eRUG9HnGUhn2txCs1Tq+Yiy8Jh8
 xTdtamK2xhe0Slw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22210-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F4316303C2

From: Chris Mason <clm@meta.com>

nfsd_file_net_dispose() is the consumer side of l->freeme: the nfsd
service thread loop calls it to drain entries that the filecache
garbage collector and shrinker append via
nfsd_file_dispose_list_delayed().  During per-net teardown,
nn->nfsd_serv is cleared before the filecache laundrette is shut
down, so the service thread can still run a dispose pass that finds
more than eight entries on l->freeme and dereferences a NULL
svc_serv:

    nfsd service thread loop
      nfsd_file_net_dispose(nn)
        if (!list_empty(&l->freeme)) {
            ...
            svc_wake_up(nn->nfsd_serv);   /* nn->nfsd_serv == NULL */
        }

The sibling helper nfsd_file_dispose_list_delayed() already documents
this ordering and caches nn->nfsd_serv into a local before testing it
for NULL.  nfsd_file_net_dispose() was introduced with the same raw
svc_wake_up(nn->nfsd_serv) call and never picked up the guard.

Fix by loading nn->nfsd_serv into a local svc_serv pointer and only
calling svc_wake_up() when it is non-NULL, matching the pattern in
nfsd_file_dispose_list_delayed().

Fixes: ffb402596147 ("nfsd: Don't leave work of closing files to a work queue")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/filecache.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2f0d4de779af..1e2e1f89216e 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -474,11 +474,20 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
 			list_move(l->freeme.next, &dispose);
 		spin_unlock(&l->lock);
-		if (!list_empty(&l->freeme))
-			/* Wake up another thread to share the work
+		if (!list_empty(&l->freeme)) {
+			/*
+			 * Wake up another thread to share the work
 			 * *before* doing any actual disposing.
+			 *
+			 * The filecache laundrette is shut down after
+			 * the nn->nfsd_serv pointer is cleared, but
+			 * before the svc_serv is freed.
 			 */
-			svc_wake_up(nn->nfsd_serv);
+			struct svc_serv *serv = nn->nfsd_serv;
+
+			if (serv)
+				svc_wake_up(serv);
+		}
 		nfsd_file_dispose_list(&dispose);
 	}
 }

-- 
2.54.0


