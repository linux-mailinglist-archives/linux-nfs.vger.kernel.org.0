Return-Path: <linux-nfs+bounces-22545-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hZ0RIdTWLWp0lAQAu9opvQ
	(envelope-from <linux-nfs+bounces-22545-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 00:16:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AB67FE77
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 00:16:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IB0J+5zH;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22545-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22545-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 828DF30015BF
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97856315D21;
	Sat, 13 Jun 2026 22:16:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2EE257845
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jun 2026 22:16:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389007; cv=none; b=KOYRte2WNq39JWECIWBp+LUm9h2Ylqm5nG0Ky2tE+HV890qyBuJ6y/6rLZE83aMUxDNQvm7cnhs5I1cCGJ+gNweenkzzmAsMfA+JbbXK3jWOFXFl8l/42XQSbKiQn88T/quCTRuA1E0i6h1eCNGE+sB5SYA8m6z3frHDlZ4dz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389007; c=relaxed/simple;
	bh=dSZVqqZK+wzjQqLxHShwg64UsD5cGG3X5gZ2D/WdOKk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vlv3VHkJB0QwfIeUMEO+vXAOj4anxKrBouO0WBUp17GE6Q5A7rgc+UpwI/oQinr/OL24sfbOTV9rPQpXmeAwnoOL+uGhc4GYhfbPClIQU/lkJROJ/3RKBEuvj+4OAN69et1hZZ+S4pyW+mNx/kkssB2AipdQUiwq7L1m49Il6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB0J+5zH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAF81F000E9;
	Sat, 13 Jun 2026 22:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781389006;
	bh=0+fLI91pa/Xv3FD1+RFHBdOmEDeulJXtr3rw3jCfjvU=;
	h=From:Subject:Date:To:Cc;
	b=IB0J+5zHNaROe2nUKJIMcgj5G+c4Mf5SU1bnfEL5f9mWC4BUb00ImbvHEeMErfFBC
	 ynrFvU4K1UmjqopaTSBJ/gi8xXpwiwXIQLT0QA1+kBnT0AOA4lDE+goo+8K/ki0Flh
	 TelUF6UFotmGqKIlsk/qy3nQJAiQ+13Nxxrad77DSCiZu/QfsmTw4uHpzOqlCKfPHm
	 8tQEZJEAfvFb0NnPUmcY56kPi6px0NYb32oXYjPWfxNvVzJdUGuTkBrw95WaAG2ntv
	 DssFBAdUHUikTzRQ/22pSK7T7OXyuWuSHXCHE73yFC3Qk65s/CS35LnAxd62/gbF3D
	 H4DgXHcESA1fg==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/3] Fix NFSD post-shutdown use-after-free in the
 unlock_filesystem paths
Date: Sat, 13 Jun 2026 18:16:31 -0400
Message-Id: <20260613-unlock-filesystem-uaf-v1-0-462b9bec8c84@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBBFr0Jm7USokQavYlwMZQqjWEinNRrC3
 QVdvp//3gLKUVjhUiwQ+SUqU9igOhTgBgo9o3QbgylNXdbVCXMYJ/dALyPrRxM/MZPHpiF7ttY
 Rk4HNnSN7ef+619ufNbd3dmmP7Y+WlLGNFNywT47HY/DaYWJNEnpY1y/cTSv0nAAAAA==
X-Change-ID: 20260613-unlock-filesystem-uaf-99a7577caea2
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Musaab Khan <musaab.khan@protonmail.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=cel@kernel.org;
 h=from:subject:message-id; bh=dSZVqqZK+wzjQqLxHShwg64UsD5cGG3X5gZ2D/WdOKk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqLdbEgMzxwztgqp05hGDEeVGbvbc+WoZJuSkBd
 1PNosZjbmOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCai3WxAAKCRAzarMzb2Z/
 lxYTD/48T248W5RdNWjdPuXpFqghQotZXLmxo2RkedwM7LzIhzp+MV7U/r85V9JUyl2qOkrCHrN
 pstTkiHe1aXfM9DiSFh5bIyLk+BelJGQxJYAJvkoKyphvX284guJiJvMMU/DrqZfYQbQjhM4X18
 E50MztWMGr+zaZztUnBMx8LpT03oDCtQ5801fyoRjpOVZetfOFRskB8rQKcA0WGh/XDvvAEyrC+
 14KdsBLWR23b81U67MtrtihH1NKoqziXRpcJmT5SZqPX/KJvdW3ZFv3s4J5gNejJqyX/8hoqx37
 kt39nH+pYucxGNCEDLMkJb/qPKtDg41NnsxIYn4+QfRDCovxja+/6TmoEpDUIanN04uB+bQZ21m
 R6CuhmsyOSfMq32vN0b/yEsIqYwiTJaVuiOPhU5hob5506cLhZ07QYThcNY3A+DFzsdclS75L95
 LxR2BlZ0ppAnQm/ZFxDeKIQdY47NndNsakzCzoicrTHzOBg17KGhniQP3TblqLN4wDfhLdUDJ+z
 olAzfvH0UvEJ2N3C5YdhSPsfjZHnoFXqJ3rgyrwmEwQ7vnZV6aFUk3Tv1bpo9Gnl89HmTdykkd3
 Dhw0cnyNYth8mwNfBN6xuqzO9uPzsBQCmOPLkfeeo4hULEaB4XbsCosqXT26jlNIGP9iUudFsUy
 eyMHqeg0GY8rKcQ==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22545-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:musaab.khan@protonmail.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[protonmail.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B9AB67FE77

Musaab Khan reported that a local administrator holding CAP_SYS_ADMIN
can trigger a use-after-free in nfsd by writing a filesystem path to
/proc/fs/nfsd/unlock_filesystem after the server has been stopped.

write_unlock_fs() calls nfsd4_cancel_copy_by_sb() before it takes
nfsd_mutex and before it confirms that nn->nfsd_serv is set. Once nfsd
has shut down, nfs4_state_destroy_net() has freed nn->conf_id_hashtbl
but left the pointer intact, so the cancel helper walks freed slab
memory as an array of struct list_head and then dereferences a
bogus nfs4_client when it takes clp->async_lock. KASAN reports a
slab-use-after-free read in nfsd4_cancel_copy_by_sb().

nfsd4_revoke_states() walks the same state tables and for that reason
already runs only under nfsd_mutex with nn->nfsd_serv confirmed
present. The async COPY cancel was added ahead of that protected
section, so it escaped the guard. The first two patches move the cancel
inside the protected section on both the procfs unlock_filesystem path
and the NFSD_CMD_UNLOCK_FILESYSTEM netlink path. Async copies exist
only while the server runs, so gating the cancel on nn->nfsd_serv loses
nothing.

The netlink command that patch 2 corrects, 327c5168eff2 ("NFSD: Add
NFSD_CMD_UNLOCK_FILESYSTEM netlink command"), has not yet reached
mainline; it sits in nfsd-next, destined for v7.2. Patch 2 therefore
applies to nfsd-next, not to a released kernel, and needs no stable
backport.

The last patch adds lockdep_assert_held(&nfsd_mutex) to the state-table
walkers and documents the nfsd_mutex / nn->nfsd_serv precondition in
a Context: kdoc section, so a future caller added to this path cannot
silently reintroduce the same use-after-free.

---
Chuck Lever (3):
      NFSD: Prevent post-shutdown use-after-free in unlock_filesystem
      NFSD: Prevent post-shutdown use-after-free in NFSD_CMD_UNLOCK_FILESYSTEM
      NFSD: Annotate caller preconditions for the state-table walkers

 fs/nfsd/nfs4proc.c  |  6 ++++++
 fs/nfsd/nfs4state.c | 16 +++++++++++++++-
 fs/nfsd/nfsctl.c    | 14 ++++++++------
 3 files changed, 29 insertions(+), 7 deletions(-)
---
base-commit: 56d6b74e37708005739ef00bb59db34bffac15a8
change-id: 20260613-unlock-filesystem-uaf-99a7577caea2

Best regards,
--  
Chuck Lever


