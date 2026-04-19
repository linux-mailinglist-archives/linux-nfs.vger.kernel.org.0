Return-Path: <linux-nfs+bounces-20957-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE1qIqQk5WmXegEAu9opvQ
	(envelope-from <linux-nfs+bounces-20957-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:53:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1DA4251ED
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 986F1300A7D3
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAEB2E7657;
	Sun, 19 Apr 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDRdrHP4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BD2E1EF4;
	Sun, 19 Apr 2026 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776624799; cv=none; b=nqfzelN+ZKaJgpaUKrGscW/4ufi08K3CDUNl0f8BY2/IEHse/Ztr+epKjm1lIuZg5ISQegHn36fZUrsUfDd1uX9W7VymPCiMrygMSPOCpJa16Iw9mJCmSjls2QgetFJPu+LfA9yWv4vXekESFteq6iVaTWQ7MD+xw0+nkPMZdes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776624799; c=relaxed/simple;
	bh=ZuZqq7Hx1zy3ru4qrGLkmxP8OwTLUe0nL1wCmOk+FOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIx9/RyG33FdM+9OMaLkMCg30m/gUtGuMu8xSnsU0JlpWBm2EFdtHT5pfw3wgcQu1lkqp7a46quDwXSsuPblbcooY/pLim7US5PMD39lQZ6R3/am+Vwz1uBZqisYKZu2uGCUSGUPDrL1o9icEARhsY/QFe5Vkh8FC+3X9uFsQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDRdrHP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D276C2BCB4;
	Sun, 19 Apr 2026 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776624799;
	bh=ZuZqq7Hx1zy3ru4qrGLkmxP8OwTLUe0nL1wCmOk+FOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QDRdrHP43/fvOP6CvVcNkVIvvfzn710zG90MeN9W79qTmyme8ckKPKpvIe3izZC/V
	 Oie7obB4MVaB/IYpRJnxWbHz9PbBgl6tg6NIax2FU/hdUk53MEWNSkbBajPvvKsEWa
	 Hl3UDdSzBItQXwf4vGZw9jSr8mwf7I7TXIjXdsb63Jm2TPT+S6AONs+oY+bwEdyDjY
	 nWTLckWexwPRFeXpqSwaI5go2KZWjTts0i4GuZCabsvUjclvUklle3YxCORIMyFetg
	 jnVXx1QoBBi1jhf1aVIiVP8aqlVyKkwnS0T4YJOc2quBvg2TBeXUyrW0RATcOyNIqk
	 yOSTEHTMGq6MQ==
From: Chuck Lever <cel@kernel.org>
Date: Sun, 19 Apr 2026 14:52:59 -0400
Subject: [PATCH v9 1/9] NFSD: Fix infinite loop in layout state revocation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-umount-kills-nfsv4-state-v9-1-0660bd06d2b6@oracle.com>
References: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
In-Reply-To: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=JMFnt4/5MnlUyN17Ahy8RVhCA2J8fWAEPxzbyI9tZFc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp5SSdvwW2pm2GzFJ14R24qXCVTc1MLV4wn4foA
 iDYHhAcBYiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeUknQAKCRAzarMzb2Z/
 l+MOD/0U2wmIWSqTKUXkBZWZ/pXrgTV5FrusDJOnKLOrMT9HnsFCx83AYq2wSHwhZIED1YHbxdd
 hpbwRsifEhUQPJVbO2VZajmVygX4/hndj2nJZJIF9j1FBgtVlaQ+9cnmakqvquUePO73oLEu+5A
 gnsEMJXHq6h30IbOXBMyCcwqGABvxefY95vdrXTDk068cugHOpB9hmqGDCFhHWZCcEguvmMSsy/
 Xf0I908ZwMinm6OxTXDyQgg9u2o0SWi+S4fuJ4hwKHJeE4I+NaT1bwwrrch5SQTUPdXPdUX5ezo
 Z3d2mzzIdY9JwIXHyVPYLDPlQdOEatYpZ/kEJ+hU6olR8zZQ9wgsupINK8f0ZzEF4SYi86EiMXa
 Fkuh7GMQu/6oWRDkjMCbfJUYWBOmW/nRFWrru4ydQgOeNES6ETPDUQivRpyiN5UD3+Di8fZWmCO
 /JqDscKbcj+n05VMXastxA1sA4YIcsLnO93L0qXRbPA7bMeqJA/PK7vXfzOfeQ9Ah6dhAJWi9aF
 9YswnAJD8Kd3HacIv61b6opjmXpDbcTugALndKy/vnDbMTrti2ocmodVUU+fmRXpcM/tnJX0n0T
 CEtpVXDv0HbGGhCkV/XR0apf9aFuLQhFc5i75Eyh4GhZdV6Zoptde3s+92J1DBPOFbF2oxjP6Jh
 DqPf4AJLDYZuYWw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20957-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: BF1DA4251ED
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


