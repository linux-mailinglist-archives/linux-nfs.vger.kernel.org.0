Return-Path: <linux-nfs+bounces-22547-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zRJVCNPWLWptlAQAu9opvQ
	(envelope-from <linux-nfs+bounces-22547-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 00:16:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450267FE74
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 00:16:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KELa8Ota;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22547-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22547-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 282DB300F16D
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jun 2026 22:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C52F99BD;
	Sat, 13 Jun 2026 22:16:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464D344DA2
	for <linux-nfs@vger.kernel.org>; Sat, 13 Jun 2026 22:16:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389008; cv=none; b=bQan/6fsHfyptpn3GOkIJyD5cin5FYMUr8dLKEV+e1ISR/obk/tIZYEjdpXEc0bfTphXs+QJL+WHAuGUr0bYihV1lHuCbW/j1sfLNPq1IFLhC362ZBFIEQT0bMWLPkAUGFBLF0wuPf1hr5f0qCXs6ZLCelSCYq18QwwqoTsek/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389008; c=relaxed/simple;
	bh=qRxN9Rw07i/bQprMgmGuaLJAGTsMO7dmw7O19YdLwJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6eeFc3YeQSEkQGiz5Jt7YcH13eJcnCHaBrHM44i131mpjsFlxfsrbelMK2yXS0YjA1DhZQPAaZb/ZNeF+UaMvHN4JLARJeiTobIEKe7+VowhPv5Suhh0ac9m5gKcb6MPH+B9gbfzXl9PU5k0AlG57nxSZ/iQFXJLiYN2KE7Ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KELa8Ota; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CBC1F00A3D;
	Sat, 13 Jun 2026 22:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781389007;
	bh=R2aPBJxUzCcib6c6LOiwM9Di/XX9CEWZH4oezVsFeSE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KELa8Otae4bxHuqvv/HyWisu1pVVA0b7hJF3Gh8geFS7ZtNg+klKjG7Tbtqw6BPNW
	 lP+biKfkQFSql5eXpSrpn9IXy1IWb+dpSMEqPlj3tSc1Dwt532bTNPBxdCSwAMLf1p
	 abA+/diMNvDTDVEjCtH8SFz2LlKYpDpOc6YSVmePilCkV9fIPDEsSIYsVDUoaZXXMs
	 Q1+so5E8xoUwRSyo8ODXLfmccB6jPstr5saBFoHwRhXLiwQHix+g0CdZXbEm4hAq3i
	 mJyi6Y42axdpD5UMrdMzpdGsS/eA79Invc3BVy1GGDM1luJZut3+m5eX2j+MTYtvgz
	 DAyUk2JeB+4+A==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 13 Jun 2026 18:16:33 -0400
Subject: [PATCH 2/3] NFSD: Prevent post-shutdown use-after-free in
 NFSD_CMD_UNLOCK_FILESYSTEM
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-unlock-filesystem-uaf-v1-2-462b9bec8c84@kernel.org>
References: <20260613-unlock-filesystem-uaf-v1-0-462b9bec8c84@kernel.org>
In-Reply-To: <20260613-unlock-filesystem-uaf-v1-0-462b9bec8c84@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Musaab Khan <musaab.khan@protonmail.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=cel@kernel.org;
 h=from:subject:message-id; bh=qRxN9Rw07i/bQprMgmGuaLJAGTsMO7dmw7O19YdLwJA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqLdbN0sCM9r729kibKyvdVzvRcAwDBWkQSA7VJ
 r3yqi+242eJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCai3WzQAKCRAzarMzb2Z/
 l15kD/4zx8UqebpcsgphkO759WYNBk7y8GSO4l8TYRZXsalKsT6q3WmnmcMf5owVeav6VgfBkEz
 uT16jrUaJMrWC30JnNP+tTbgRbnguF3/YfyCecvWTuXZEcjoGhWkM7RnOSeltO/3XyenEa6ZDAZ
 hodqf9FxskYIH74o0KaHSfGLEKYKwulj/6jOYdp3chil4KIFPG86TIzOw5183fdNcZLTm4bwwyb
 SlSTcOWz+lrrklzax1NTrzaCkbses2XQK0McPjOAXyKNWCaHyrg2CsqJb3x1vWzb+n4C1KHUYyp
 wLYN6MDzP4ZjEbUwk/OioXoqDti4gopoE/By6BOc1jos+xiZkNvYVqccmzApQYvOO3hwV0hRZOD
 AsJ8aniNgNkzZa76xSo21Guxh9CJTP578NfBfNcrsPUaEBhfWTrdrbMr2l/uwWq430h5jQGmrk/
 QUNKqDCLGQinvn3oFxtMTYeB3+T4CbXdNZwkfyO08767KGuTGUq/JS7HDCchIm2tA3IaNYX0GAz
 TKAuu9rWsqbuv9C/wU1Q3gavon1rh34QqE/XLlH6cP5hnuOBgSBSbN0hosso7bBeYzwb4bE7hLw
 TxG7Yxgk0/2Dr01JHiPK83DMJpWTuoSaUFx2qfagbqiFP3iSSBVjo0buqcKFL93ep/vivX0DHXL
 sNvekZ3CKKBJLlA==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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
	TAGGED_FROM(0.00)[bounces-22547-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8450267FE74

The NFSD_CMD_UNLOCK_FILESYSTEM netlink command runs
nfsd4_cancel_copy_by_sb() before nfsd_mutex is held and before
nn->nfsd_serv is confirmed set, the same pre-mutex ordering the procfs
unlock_filesystem path carried. Once nfsd has shut down,
nfs4_state_destroy_net() has freed nn->conf_id_hashtbl but left the
pointer intact, so the cancel helper iterates freed slab memory as an
array of struct list_head and then dereferences a bogus nfs4_client
when it takes clp->async_lock. A local administrator holding
CAP_SYS_ADMIN can reach this use-after-free by stopping the server and
then issuing the command.

Move the async COPY cancel into the nfsd_mutex section, after
nn->nfsd_serv is confirmed, so every NFSv4 state-table walker on this
path observes a running server. Async copies exist only while the
server runs, so gating the cancel on nn->nfsd_serv loses nothing.

Fixes: 327c5168eff2 ("NFSD: Add NFSD_CMD_UNLOCK_FILESYSTEM netlink command")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfsctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 29d68abfa5c8..f1ecbb13f642 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2368,14 +2368,15 @@ int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb,
 	if (error)
 		return error;
 
-	nfsd4_cancel_copy_by_sb(net, path.dentry->d_sb);
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv)
+	if (nn->nfsd_serv) {
+		nfsd4_cancel_copy_by_sb(net, path.dentry->d_sb);
 		nfsd4_revoke_states(nn, path.dentry->d_sb);
-	else
+	} else {
 		error = -EINVAL;
+	}
 	mutex_unlock(&nfsd_mutex);
 
 	path_put(&path);

-- 
2.54.0


