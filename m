Return-Path: <linux-nfs+bounces-5060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 917DD93CCB8
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 04:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E388AB20C69
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 02:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E71B947;
	Fri, 26 Jul 2024 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X8flVzIw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VxWmPdV2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X8flVzIw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VxWmPdV2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC99320B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960806; cv=none; b=QnMDSfQVEBj0BvdRx79al5RnF8FagYZF8u3W8FPgmup8VZhpbYI5tW9PGQciSuChjpr4MfZKG/7VS/HxhwyyH/kEZZX62eTzIWGzW3VXlhZpC/pFZRAJdiy/kmyvAvfHf1m5t9vmMVJ2UoFI89TpHekh/NBRPHhtS6PwY7Yx2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960806; c=relaxed/simple;
	bh=ESEBH2VtZEob5eW0Iz9fMVQ784mOIB2aWYRU8vtmS8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lln64FUAX7shvrWN8s8PmEKwMnFtJene9LwbCLJxTVwly9uwXajK5tRNeJKB0GlahBKW4WE2eYbZYqBGyHvjejjS4PeBMHHv1AEO+yamFIV4S6qdBo5bkvX+17nl12jb0J+BRcYTIgrw1Z82XLXGGdTaK+ymZ0UjwOz3MT4eW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X8flVzIw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VxWmPdV2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X8flVzIw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VxWmPdV2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8795E218D5;
	Fri, 26 Jul 2024 02:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qy3dk9757y1Cd6wFkx/UFQ/5Z/ToDtIT1CfPT5/BsGw=;
	b=X8flVzIwC1bA7VBp+O+7jS7pESBAleSCvNApMP0cwZPzkXF3wsB00DasJjL2JThlE2O31x
	8vaOPTIhtPT5rgfEXumXlN3eMoxj7QATyLcJb1+Sm2y9jBEVBwWdCEAqb5UoY/mEovREr2
	KaSU6CEWut3OgleZgXexSbiPJUiTJzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qy3dk9757y1Cd6wFkx/UFQ/5Z/ToDtIT1CfPT5/BsGw=;
	b=VxWmPdV2ioDKB77FE6DC4nubvajhslRG7ezWWr6N9tBKPSGXKhdKHHr0r5qjKKHrEfpcgc
	5sVS/HR/XbL+dYBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qy3dk9757y1Cd6wFkx/UFQ/5Z/ToDtIT1CfPT5/BsGw=;
	b=X8flVzIwC1bA7VBp+O+7jS7pESBAleSCvNApMP0cwZPzkXF3wsB00DasJjL2JThlE2O31x
	8vaOPTIhtPT5rgfEXumXlN3eMoxj7QATyLcJb1+Sm2y9jBEVBwWdCEAqb5UoY/mEovREr2
	KaSU6CEWut3OgleZgXexSbiPJUiTJzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qy3dk9757y1Cd6wFkx/UFQ/5Z/ToDtIT1CfPT5/BsGw=;
	b=VxWmPdV2ioDKB77FE6DC4nubvajhslRG7ezWWr6N9tBKPSGXKhdKHHr0r5qjKKHrEfpcgc
	5sVS/HR/XbL+dYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70BB8138A7;
	Fri, 26 Jul 2024 02:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w2rwCWEJo2bZWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Jul 2024 02:26:41 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 6/6] nfsd: move V4ROOT version check to nfsd_set_fh_dentry()
Date: Fri, 26 Jul 2024 12:21:35 +1000
Message-ID: <20240726022538.32076-7-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240726022538.32076-1-neilb@suse.de>
References: <20240726022538.32076-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

This further centralizes version number checks.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsfh.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index e21647cbfca9..845ab4f077ca 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -114,19 +114,11 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	return nfserrno(nfsd_setuser(&rqstp->rq_cred, exp));
 }
 
-static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
-	struct dentry *dentry, struct svc_export *exp)
+static inline __be32 check_pseudo_root(struct dentry *dentry,
+				       struct svc_export *exp)
 {
 	if (!(exp->ex_flags & NFSEXP_V4ROOT))
 		return nfs_ok;
-	/*
-	 * v2/v3 clients have no need for the V4ROOT export--they use
-	 * the mount protocl instead; also, further V4ROOT checks may be
-	 * in v4-specific code, in which case v2/v3 clients could bypass
-	 * them.
-	 */
-	if (!nfsd_v4client(rqstp))
-		return nfserr_stale;
 	/*
 	 * We're exposing only the directories and symlinks that have to be
 	 * traversed on the way to real exports:
@@ -284,11 +276,15 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
 			fhp->fh_no_wcc = true;
 		fhp->fh_64bit_cookies = true;
+		if (exp->ex_flags & NFSEXP_V4ROOT)
+			goto out;
 		break;
 	case 2:
 		fhp->fh_no_wcc = true;
 		if (EX_WGATHER(exp))
 			fhp->fh_use_wgather = true;
+		if (exp->ex_flags & NFSEXP_V4ROOT)
+			goto out;
 	}
 
 	return 0;
@@ -358,7 +354,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	 *	  (for example, if different id-squashing options are in
 	 *	  effect on the new filesystem).
 	 */
-	error = check_pseudo_root(rqstp, dentry, exp);
+	error = check_pseudo_root(dentry, exp);
 	if (error)
 		goto out;
 
-- 
2.44.0


