Return-Path: <linux-nfs+bounces-20730-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LtFIONL1ml8DQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20730-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:36:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D683BC37D
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20F74316F207
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C1E3C9441;
	Wed,  8 Apr 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pfp3xUxD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F03C65F6;
	Wed,  8 Apr 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651410; cv=none; b=TG5W5/Abte42hj9rUJ2zOffx3bl8dusJz4x8WB/jkUYyBZiNBOav1UFjVim9/HO2UmJqWiUh31ZByhTqQD0viQMOaCBrGzXj7OOq0yzEI87QFiwkevyE0SIHKfb2Gz9fy0Q3ECx3Oo4MrebvRwH2dslo8bYluA4kVtK4KJOB/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651410; c=relaxed/simple;
	bh=ZuZqq7Hx1zy3ru4qrGLkmxP8OwTLUe0nL1wCmOk+FOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ekr2PqZwp5RXp0J3xC3EXI8r0MlOEghc+Z1QDbU7IkS4D0HJRK9LA7EF6ItnGTMeBWKP6Og9z9FD7vvN8r5HUhYFRUQKOOsn4O6T04JU6r/JwGhv5F8SbgNzea1LTzPfuK73monlZaI95gTh20SShLItGXt8bEuu2IESS3MEf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pfp3xUxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F34C2BCB0;
	Wed,  8 Apr 2026 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775651409;
	bh=ZuZqq7Hx1zy3ru4qrGLkmxP8OwTLUe0nL1wCmOk+FOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pfp3xUxDFWWiTBd841Eur3/Bbj++oZ4Iz43YLhlGuU8fffq8VP8vuYz6P9gUFnf88
	 41VU5JURs+AFPkQOrtvepy1rZJm91QluDCl5GuOIkfpTbgcsqAWTtmqmm/JhgUcg+p
	 MMYdwwvFWMEi+pDzSvL9MJQCSEkN5Wvhaur6T2u3Hr/4tL/KL/Ta6CDXf4Qe8amci+
	 b9xgZphH8kzVRigrtfns0Ez9kjEOiNBZYGvZ5E4HaSGWtUON2lutaVCwmha1ses8nb
	 /8hxKRzEeb9OH1g5FsLKInttbEjr1L4No3Q7wBN7CsvWgQ7jsK25sAK37VLsQwVJ4k
	 FqD/QZR64Ujcg==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 08 Apr 2026 08:29:51 -0400
Subject: [PATCH v8 1/9] NFSD: Fix infinite loop in layout state revocation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-umount-kills-nfsv4-state-v8-1-6e02a1d03d60@oracle.com>
References: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
In-Reply-To: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=JMFnt4/5MnlUyN17Ahy8RVhCA2J8fWAEPxzbyI9tZFc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp1kpPz3AbdjxUJdzhiL5ip5MUxre1Qzn5zI3da
 wMwF0YgJ+6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCadZKTwAKCRAzarMzb2Z/
 l8JID/9oVEvQh9mfEC15XkXRppU24obmh3MPWPtTSf0oDlNAl9szo+Jpb7fFcVOs25ryjkLPRwJ
 2CknvdowvCmbxJr2cFMtt4JrI6UUCXpjRUltK8+ylZj3JXyEyl+/1Gqhe8r0PiBRT5xUQLm7ZAb
 B5FPpB8bIV110dYlV5+bhGPG6TbTyI2uCyE1/oFfitMS3uuHk+TpFrVupj2xtDZtuhq/GtZbpMB
 bk2zIv86dzG7/gASIlv+OtIcwI9DOss9aZ+sic16Hvo5hUNyOtoYLAfJUBqRiVgDrqdYP9C+OHs
 g+765UOvrXFkUvEQ4eqpXZA8/+DvohgsMRYXb1Qwz4gVVZ43NINPUW+XrDJXPi5JR2q1OkMgUSU
 mKQySCeKl4GNG3yiPjYAADruKt8T7F3FRvw3qeC/p2Xsnd/YUj+Caz3fVeTPtxzuwN4aemBlxoW
 d5wnL2vrVVd92gUIwr96kKnXTPHSctOglX9GsjZLnt+cGP1Oe1yQ8YHKX1r+lEU1zSPoTQtWqSs
 FYxL+nbEYLgu98hKKR0eXen2q/4XlKwjjBqvWdVWBGG8xStkXiyj57fdDtHFwDHxt/MwDnjg+gg
 TFht0kfWJ1J15/AzLjcbA7Lq0bGSAIU44Yhx8S8Ol448E6RH6xufcFGZbNuL6fOe9bbRBr8g/4P
 sh4wzzZfP2Drw5w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20730-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21D683BC37D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

find_one_sb_stid() skips stids whose sc_status is non-zero, but the
SC_TYPE_LAYOUT case in nfsd4_revoke_states() never sets sc_status
before calling nfsd4_close_layout(). The retry loop therefore finds
the same layout stid on every iteration, hanging the revoker
indefinitely.

Fixes: 1e33e1414bec ("nfsd: allow layout state to be admin-revoked.")
Reported-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 07df4511ba23..c6cb67cf02ad 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1872,6 +1872,13 @@ void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 					break;
 				case SC_TYPE_LAYOUT:
 					ls = layoutstateid(stid);
+					spin_lock(&clp->cl_lock);
+					if (stid->sc_status == 0) {
+						stid->sc_status |=
+							SC_STATUS_ADMIN_REVOKED;
+						atomic_inc(&clp->cl_admin_revoked);
+					}
+					spin_unlock(&clp->cl_lock);
 					nfsd4_close_layout(ls);
 					break;
 				}

-- 
2.53.0


