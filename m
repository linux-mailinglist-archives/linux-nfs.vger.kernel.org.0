Return-Path: <linux-nfs+bounces-23152-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pe0CHH1VTWoUygEAu9opvQ
	(envelope-from <linux-nfs+bounces-23152-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:37:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B99771F49F
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:37:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PUW7LxPc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23152-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23152-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3556305244D
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 19:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454753A1A27;
	Tue,  7 Jul 2026 19:31:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128C3932DB
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 19:31:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452709; cv=none; b=Nm3Kgno+2fNRBAyziQCDJUGNQSzPBNNtgOSuc5UKbdN5nTmvfo4lQdXC1G1juhmMT4hPT66hObg+pQDL9aC0SW6NvmE9IUbt0w7f9DlPivmpDVhuNFy8eRFKlViz5USGHSe4Uho77QbqTUBJBqJPhfjQSxLhVX4ubpyF6ze3hc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452709; c=relaxed/simple;
	bh=C/PRiHg4de5N2jIv5cfFWWBc9LhSsZWZfE5DfFGG70c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpPkDqlRamUT+vg6R/z4eCyVT6OnXizAWTTg89awMvalj2YGHurZhjg5uWrjguvxEMFyrKqKxu679jeujFRbU69lJ2IABucV182uUMv/Hs8eFi9CBCUoXLRWEWxuMPo5FFlESuLZsI5zQuSaYNjUpmGDT0Ds3blldtPYG0o6QMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUW7LxPc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483FD1F00A3A;
	Tue,  7 Jul 2026 19:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783452707;
	bh=VQ7J4NdSjBCU7Vp1jxy5+r87K4j63ZM7eZBZOQA7GyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PUW7LxPcgwKchH6NdcvNlzczlDIzMVdsi43o+n/bX9BEz/fmX6fWvkAjUw/RWEwEp
	 uc84VpLMR/VKjK2K0FFdg/u/G24DPlO6RQXSkjNxa6vJCZj9G+qAAFdpPLvST20V33
	 YH0FWuXSVcsDX3mKlE2wZSM5SKVouoE4hTmVYvQrERGZwGCGYA95rLlfqrtfW+mR4u
	 0um8PtprVCH/9LZdbWsj98LTbTqkoWfPYpmwYxs4WUqAXMJUmc1bEKZC5UP36OTmRL
	 w13/kV9Kooy7+HNCz32JuN6lZszLrHmig3dCarvBODiUChfBagfO6Ghz3X25B3I2dM
	 VUMbwsGU2eYmA==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 07 Jul 2026 15:31:29 -0400
Subject: [PATCH v3 9/9] NFSD: Release the export reference when reaping
 open stateids
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-cel-v3-9-7c0cc16fd54f@kernel.org>
References: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
In-Reply-To: <20260707-cel-v3-0-7c0cc16fd54f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=cel@kernel.org;
 h=from:subject:message-id; bh=C/PRiHg4de5N2jIv5cfFWWBc9LhSsZWZfE5DfFGG70c=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqTVQcZi4k+5ZfAVZf4gxbmuZVM/c5Ss2gi5Ku5
 0Mio5qVp+OJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCak1UHAAKCRAzarMzb2Z/
 lyxCEACzEpYksr7IcUzjp8D831mv1GAfRMVoPMUra5Y0TMS56RI9ZDNCd28Zmlz4ph93gktabXP
 Xp9MbkfiZsGTJ62QIwNikRekq4kjeDsnQWrVrKhlFSuMEDo0S001mQxz9Ej9N6TjyQHs/p5b49z
 7HW6oxV8d/5ixvnd8mj4Bm+Bn7/tIul2prX+TzrfAhVNcJ3LPKOR6k67Snz5HYJhxBR1DdSqGtZ
 3tNBipJjZvRKvhLqT6DmAYWVeYuGbBt94hXuwaTYqni0OpWHHVltOTWUDdrrkdaaDovsqPzd6Jg
 pEsVLo/p6QlIpdfhyOTo8fe3Gk672t0diUxB+vj3bYhHXOWgecSj0Svk0fxICYW+8QVVor3Zm+1
 rO3qZDnodszGIC8Sruq4mEHj68Mr0v18eMUUID+T1lCspdv7RElr48otCBPntIOvWmoTmuvno8K
 WLV3F1DqpfMbupWlH8S4RWJKRCd16M5heXLtnXW+d/GS94VihT0x2R4nLaiU2C/hytrzWSfeqEf
 M/+HOlV92SPYFbHJi9+KPDvGwkDrByNkPNIDCOe8E+KRQblqkMOmRmiukrE4eBc/DrJBOPKOBBM
 CG5dUJCcegyr9ntkZITEUe8AyV/1JG5ukQBcZp6toCkZAW32JW9dEpKZt3WAs1Tu31q5yGoT/GW
 INwm09LN5yXzDXw==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23152-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B99771F49F

nfs4_put_stid() releases the svc_export tracked in
nfs4_stid.sc_export, but free_ol_stateid_reaplist() frees open and
lock stateids by calling ->sc_free() directly, bypassing that path.
An open stateid takes an sc_export reference in nfs4_open() and a
lock stateid takes its own in init_lock_stateid(); both reach
free_ol_stateid_reaplist() through their normal teardown, the open
stateid via release_open_stateid() and the lock stateid via
nfsd4_release_lockowner(), each through put_ol_stateid_locked().
The reference is therefore never dropped, pinning the export and
blocking unmount for the lifetime of the stateid.

Release sc_export in free_ol_stateid_reaplist() the way
nfs4_put_stid() does. ->sc_free() runs once per stateid, and a
stateid reaches free_ol_stateid_reaplist() or nfs4_put_stid() but
never both, so the reference is dropped exactly once. Revoked
stateids reach this path with sc_export already cleared by
drop_stid_export(), so they are skipped rather than double-freed.

Fixes: ba0cde5dc81d ("NFSD: Track svc_export in nfs4_stid")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 20556b8f186a..8e4cee571994 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1744,6 +1744,7 @@ static void
 free_ol_stateid_reaplist(struct list_head *reaplist)
 {
 	struct nfs4_ol_stateid *stp;
+	struct svc_export *exp;
 	struct nfs4_file *fp;
 
 	might_sleep();
@@ -1753,9 +1754,12 @@ free_ol_stateid_reaplist(struct list_head *reaplist)
 				       st_locks);
 		list_del(&stp->st_locks);
 		fp = stp->st_stid.sc_file;
+		exp = stp->st_stid.sc_export;
 		stp->st_stid.sc_free(&stp->st_stid);
 		if (fp)
 			put_nfs4_file(fp);
+		if (exp)
+			exp_put(exp);
 	}
 }
 

-- 
2.54.0


