Return-Path: <linux-nfs+bounces-23190-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 00etAfbeT2rppQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23190-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:48:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A072733F60
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 19:48:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cfb1pxZ6;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23190-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23190-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9834B3029FF1
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D914195AE;
	Thu,  9 Jul 2026 17:40:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101974195A8
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 17:40:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618841; cv=none; b=GC811adrY2OR5LWRKWjmhfCTSrsqGDDTMsqP3ZYm/fwV/ndUf972C6rUZrvYqB9MV7qbXUIzTLba/7EqLjgiU6jJjZ2uTkSxX5p7mcbn19hmOOw5ad8KPZQuUeqdyR1p2yesP4Oj1oxYFA04q8V/xtsjRkAjXvjANy40f6DceXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618841; c=relaxed/simple;
	bh=Bnz0DH+LSldhHkcyXR2kaynlY6v1355RFkpwxlsqFnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=saalZOXtuDsRUrniwYuAmR1FRPHO2MIDp534u33rorGqkjr6Yl5L7aMnyFlgsli2nWf+Fz7TETlvirAm6leZa0Rxfl2FUY2KAymONaJNC4PUA1oq3PRZpwj3jKcZck+CMWeXIOJCs6KPL+wc3mUhk0dpxIV88O5G8xNanKPJd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfb1pxZ6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2832C1F00A3D;
	Thu,  9 Jul 2026 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618839;
	bh=T4mQmBtcEZgche4SQCCmXZcj0Cp2O6lYsK3HIu6Ohu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cfb1pxZ62YXclneA01WwPP/jBGsCnqiTcaRboaP2u86xJRB64gN3FLkC27hc8uca8
	 i0TgwjpXa/Mv7rhdiRGMBlJL7qjNhLo075awG5e/uN7XIvd6PbVEJhFRmb5XJwUljS
	 VKKz2kvUGPrsRgSNRaba1KGNAMn6UKRj1bWLXfMrzcDv8NCXMsGgXIENyOOAcqxApw
	 qY/lGd4gVWz/ejeKeN0XiqCU8naxDvnlppgTDMSLeWr2ja8QoBqE1Ht/z4nnSt4Ma9
	 eXeRNFRcBt6oAROj1xAUKZzsVFdvWnlZSflY+u0nzTzWUWXSgjm7TUIzl3LQdVGE7O
	 /SWaF7eYsIccg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 09 Jul 2026 13:40:24 -0400
Subject: [PATCH v4 1/9] NFSD: Prevent lock owner use-after-free during
 client teardown
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-cel-v4-1-1d519d9be0cb@kernel.org>
References: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
In-Reply-To: <20260709-cel-v4-0-1d519d9be0cb@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Wolfgang Walter <linux@stwm.de>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2595; i=cel@kernel.org;
 h=from:subject:message-id; bh=Bnz0DH+LSldhHkcyXR2kaynlY6v1355RFkpwxlsqFnk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqT90VNDwdVP9G3p2t30JpsxzVCmiMmVVcCJ6CJ
 me5W8dj4FWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak/dFQAKCRAzarMzb2Z/
 l+OPEACaLjjqbTXyftnZZvZ6qSwR+iQFptHvc9OFpDA/iAQb4fdxj2mZpl+afku1eojoRB+6iHz
 f3/AX54BO1mfxqbTveJNYlZsxA+BtoJcAtjowB2NeHhz3jE9kzO4mu9jgW0oQWmFXCSxu1jr7HD
 wbjoXn801fN/N+6VnEb8p0vWPgXhDHC2Hp2zTMhFVXJRIvF2FRp8RZLwniQxLwosWFbBws77phg
 DO8BRms3rlVoh56/6u1T929zhpTmPNw0z5Z+7f/Ud+vH3jjIzknL3QkF+Yw2f2cZSZ9UpeJ8487
 fGhLsyfCgw4ztNHfa8eP9zHLOmecrpPlVtSPsh52zOWjPMq6SyGeKNriXSFA69V58gKVO0hCb1z
 QoqAw/hjM0yEh4kLS0w4FqdJns0Wl81xG7OkrD177gvXrup5+gB7Oiq5FkxdP0Epj9g0sDhjZFX
 gbg/z2/rFTWRYTZqyEyORnIKOL/Tq9joJJ2j2WJ3r+NOIbotmzW/iYVTpGCZv4OcyadWghheeCl
 VTzZDMlU+wcCcOO3IUGZXmwuD6UeUdApXxgqgRnHTg89VT/OecgGLzIPjOqCc8iBUMYZQ017pbX
 fUOvlebALEFEYBVLgC+ovrlLatkXVnVQ3lmDDxRJRCD+TkrxkC7STCcbnhNYcs+kEkGJ06obXJ0
 ZCdZgQAE7mI8IlA==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23190-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux@stwm.de,m:cel@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,brown.name:email,stwm.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A072733F60

__destroy_client() releases a client's open owners, but a lock owner
whose only reference is a blocked lock (nbl) stays on
cl_ownerstr_hashtbl.  client_has_state() does not count a bare owner,
so DESTROY_CLIENTID can reach __destroy_client() with such owners
present.

__destroy_client() then walks the table, calling remove_blocked_locks()
on each owner without a reference.  Freeing a blocked lock drops the
owner reference held via flc_owner.  The per-net laundromat reaps
blocked locks from nn->blocked_locks_lru independently of client state.
The two paths share blocked_locks_lock only for the list splice, not
the owner's lifetime.  The laundromat therefore frees the owner as
__destroy_client() dereferences it, a NULL dereference in
remove_blocked_locks().

nfsd4_release_lockowner() holds a reference across the same call;
__destroy_client() does not.  Hold cl_lock across the walk, taking a
reference and unhashing each owner, then drop it before
remove_blocked_locks() and nfs4_put_stateowner(), which take
blocked_locks_lock and cl_lock.

Reported-by: Wolfgang Walter <linux@stwm.de>
Closes: https://lore.kernel.org/linux-nfs/6eccafaaaa60651ef091257c3439c46b@stwm.de/
Fixes: 68ef3bc31664 ("nfsd: remove blocked locks on client teardown")
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a4398dc861a5..e000ed3e96e9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2758,14 +2758,24 @@ __destroy_client(struct nfs4_client *clp)
 		release_openowner(oo);
 	}
 	for (i = 0; i < OWNER_HASH_SIZE; i++) {
-		struct nfs4_stateowner *so, *tmp;
+		struct nfs4_stateowner *so;
 
-		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
-					 so_strhash) {
+		spin_lock(&clp->cl_lock);
+		while (!list_empty(&clp->cl_ownerstr_hashtbl[i])) {
+			so = list_first_entry(&clp->cl_ownerstr_hashtbl[i],
+					      struct nfs4_stateowner, so_strhash);
 			/* Should be no openowners at this point */
 			WARN_ON_ONCE(so->so_is_open_owner);
+			nfs4_get_stateowner(so);
+			unhash_lockowner_locked(lockowner(so));
+			spin_unlock(&clp->cl_lock);
+
 			remove_blocked_locks(lockowner(so));
+			nfs4_put_stateowner(so);
+
+			spin_lock(&clp->cl_lock);
 		}
+		spin_unlock(&clp->cl_lock);
 	}
 	nfsd4_return_all_client_layouts(clp);
 	nfsd4_shutdown_copy(clp);

-- 
2.54.0


