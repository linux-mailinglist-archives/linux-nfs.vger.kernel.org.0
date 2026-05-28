Return-Path: <linux-nfs+bounces-22051-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCndN7q6GGqsmggAu9opvQ
	(envelope-from <linux-nfs+bounces-22051-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:59:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F085FAA7F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67D78317913C
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08B3364E9E;
	Thu, 28 May 2026 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqP9WU9Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE6F3672BE;
	Thu, 28 May 2026 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005328; cv=none; b=UM1S5bkoi9BeWN6WuQVe7T7cK9b78oP7r9CrDMzvduub8pVb8bnkKqcxpH2X4qlxdF302ZSWxrSPYb2miTMn2giu8V12XcawpZIkI1vh7uvEbNrnRSiVBSyvVQ0ESJe4hchI0JM1Ex5SU0SpRGiGVY5EHbMMs7UGSVjvvuNtBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005328; c=relaxed/simple;
	bh=cX9C/qVyQU8pvqlAUJU6eoyurocysZu5TAs9BRPfrRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWGYsHwqc2LfbaC/n1xSyJKqv63Vl3riwje985niGjKIKqc7CCkIUP/xGSt4YGH1lZkKTtj0D5gMNbKzqkpDvYTDGj9fGjaU21dK4pIPfqlhitY1yhdA8TOrFPm5BxnuPrIsTL0mnUCSRwoMeWdeDX3Pp6po4QEaJkW3/GVUJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqP9WU9Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCC41F000E9;
	Thu, 28 May 2026 21:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005327;
	bh=LPLNwfji0HPhNzNdQtvJ/50kq50rLrKE1Be8JnkY63g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JqP9WU9Y5kdfa6RGlatFinXE09612BbivgX6AWepeUr71ETKwx1PFVmuO8QHx78IV
	 SWYEEsYS1tectnBwkp7tOYQxvElZzQ/ZhFdrfh7Mz0IaIoYikazJtWXVTWeqR9EKzE
	 zMizq4XpJtel6j/pjjQsyJsaueG8qgi0Iy5tTeVDmrgjauIAvjNvDo27AyREFintmY
	 ZnlzL3+v/e5Jj0PO1GEC4tam/z+QgTdFCsREiFYt6XV3Z5dpX8AUKLMS7aT3H2mkuM
	 OWaREMKwFgjNx2WWh6UXUV5za+e1fVdCehQHxwXUB1Oyl52czBC86N10QdcfgAXa7X
	 YXTMoFmE/8Ecg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 17:55:12 -0400
Subject: [PATCH 01/10] nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on
 racing delegation revoke
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-nfsd-fixes-v1-1-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cX9C/qVyQU8pvqlAUJU6eoyurocysZu5TAs9BRPfrRA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGLnJMxZdUpKbZD69svgy6FKF7BxP7SPSuaRF+
 IrEY1zUHQOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahi5yQAKCRAADmhBGVaC
 FcCHD/0dhxKO14VGazK5MQTth84tAg4nOadzgPfe/hSDYfFNvQh7Ps/iBFCHjZ6X+KFV1PAeRiv
 q87sjv3WxlchTRzMgmOMl1xzxdoxyC6aBOxWECSdbLKoUONXImujMH93YFm0LKF/jPsM5X5/pHP
 P9cL7YPkn+oPiAOhI3lLFLUAGfGg5v7GO6lP4WdjdE8p0e0CdrceWd6I4Ugrjcc31LezGG21SMA
 /hrZ1ZSKGgHzg8TvXWfe0IWz27I5NeKE7o45AjFplJ1E47ranboRqmB0IwHPq+5OJx0hxQ0SVNg
 k7399hRLC+Q50ZbwaT2z5ZDS0Qsjflx7vSh08MMlb8twXcJfSnchBK32KyUSB5GFPCgA/m8z7SD
 e85sqwwHaAXnr6DI96XP876Uk9ROhzaZJHWmZXc/+Lugdf0l77Y0u4Fi6T/PjzWxpWFtkRnTzL6
 Ru6OueYYct4q8aF4LrTJvcXgSV7MTkHsaV9gfLyzQQZfIeKKJEtyjHcMzLmx3xFOtS7CgsupRxZ
 B+A/Q+0QORRmXjQa9S+SQowajSUxKMRVoSUJ1mgCT/GXLys2y2cPw49z2E5ki8TVmytqmpGrcW1
 9rReBVCoOjDMZM1D1i/eX9ytZSRIloC2IiswVW3ldAWH1PwBwYkc1bcGivQp7y06hHOtyd+0lvY
 x843d49M5qjJLFw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22051-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 44F085FAA7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_alloc_layout_stateid reads fp->fi_deleg_file without holding
fi_lock when the parent stateid is a delegation. A concurrent delegation
revoke via the laundromat can clear fi_deleg_file under fi_lock, causing
nfsd_file_get() to return NULL and triggering the BUG_ON.

This race is client-reachable: two NFS clients can trigger it by having
one hold a delegation while another opens the same file to force a
recall. When the first client doesn't respond to the recall, the
laundromat revokes it. A concurrent LAYOUTGET from any client using the
delegation stateid hits the race window.

Fix this by taking fi_lock around the fi_deleg_file read in the
SC_TYPE_DELEG path, and replacing the BUG_ON with a graceful error
return that cleans up the partially-initialized layout stateid.

Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 9ed2e3d65062..5d48c7673fa1 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -247,11 +247,17 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	nfsd4_init_cb(&ls->ls_recall, clp, &nfsd4_cb_layout_ops,
 			NFSPROC4_CLNT_CB_LAYOUT);
 
-	if (parent->sc_type == SC_TYPE_DELEG)
+	if (parent->sc_type == SC_TYPE_DELEG) {
+		spin_lock(&fp->fi_lock);
 		ls->ls_file = nfsd_file_get(rcu_dereference_protected(fp->fi_deleg_file, 1));
-	else
+		spin_unlock(&fp->fi_lock);
+	} else {
 		ls->ls_file = find_any_file(fp);
-	BUG_ON(!ls->ls_file);
+	}
+	if (!ls->ls_file) {
+		nfs4_put_stid(stp);
+		return NULL;
+	}
 
 	ls->ls_fenced = false;
 	ls->ls_fence_delay = 0;

-- 
2.54.0


