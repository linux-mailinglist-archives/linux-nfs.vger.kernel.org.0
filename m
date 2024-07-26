Return-Path: <linux-nfs+bounces-5059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF35293CCB7
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 04:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E61B20C4D
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 02:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327E18E11;
	Fri, 26 Jul 2024 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p59urOrp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+1Dr0gcL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p59urOrp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+1Dr0gcL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7B320B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960793; cv=none; b=Ki3uos0g2p2EYHulcKwPdEpaMqnrxcBsO+GyAAKrf9JhGAeBHqgAY1sGA+r9t/lKG1JbvGBaCP/vWm+CxsDHySiol2VoLJ2zjIxDJJdSN6oSUH4E+U4G8qzOlooTfBUoZBiV+n4FBE0R4LcsH2ZlB/PIRzIPnnc7hQqoZxhu1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960793; c=relaxed/simple;
	bh=yYk3Ed8LgtENSLsQml/V/zzpitRsk4zXFfu40C5sMuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrSrzgq03G/is4DoqM0/DPUGuAdjQbOUJBkn8eHZZ4AKDIr3osJH12VKoxw+JEZUZttDaGKWbGU5fgliNuj00NaJxRQ2o6v/xS+96nthY0fpdZTzmeC5Rc1Fcwx+9SIMSs6ps60f2JCkNKFczIrqtoSciPemfB30gQd+4rzVyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p59urOrp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+1Dr0gcL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p59urOrp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+1Dr0gcL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1266F1F7DB;
	Fri, 26 Jul 2024 02:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZGwaaCHjgjIRrOTgzx/sHL/MXZiqFB9Htyt5FS4Kl0=;
	b=p59urOrp6q/8O5PNb3TcvslTVtiwPzt2gogR3EaviozzTO8QUwQXdxDpdMbN47zF0flMcE
	9Fkby6qZNgvn5YlFfuxXoo92RxIe8dZ3vt6rKKgpbYLBc0wmVOYbhEE7qRPA/+pDhyiBCd
	5zFptFMapWnXKBQ0sMuBoZmTvmUDbUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZGwaaCHjgjIRrOTgzx/sHL/MXZiqFB9Htyt5FS4Kl0=;
	b=+1Dr0gcL+x24tIMogmnZHIse9vMmmASJFY6j8e97SV6ph1xN3ZBafPSUAdzJN1BTDCYC9W
	PwbeJ4MydJex33Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZGwaaCHjgjIRrOTgzx/sHL/MXZiqFB9Htyt5FS4Kl0=;
	b=p59urOrp6q/8O5PNb3TcvslTVtiwPzt2gogR3EaviozzTO8QUwQXdxDpdMbN47zF0flMcE
	9Fkby6qZNgvn5YlFfuxXoo92RxIe8dZ3vt6rKKgpbYLBc0wmVOYbhEE7qRPA/+pDhyiBCd
	5zFptFMapWnXKBQ0sMuBoZmTvmUDbUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZGwaaCHjgjIRrOTgzx/sHL/MXZiqFB9Htyt5FS4Kl0=;
	b=+1Dr0gcL+x24tIMogmnZHIse9vMmmASJFY6j8e97SV6ph1xN3ZBafPSUAdzJN1BTDCYC9W
	PwbeJ4MydJex33Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA4F1138A7;
	Fri, 26 Jul 2024 02:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T+l0J1MJo2bBWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Jul 2024 02:26:27 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 5/6] nfsd: further centralize protocol version checks.
Date: Fri, 26 Jul 2024 12:21:34 +1000
Message-ID: <20240726022538.32076-6-neilb@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.40

With this patch the only places that test ->rq_vers against a specific
version are nfsd_v4client() and nfsd_set_fh_dentry().
The latter sets some flags in the svc_fh, which now includes:
  fh_64bit_cookies
  fh_use_wgather

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsfh.c | 4 ++++
 fs/nfsd/nfsfh.h | 2 ++
 fs/nfsd/vfs.c   | 9 +++------
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 8fb56e2f896c..e21647cbfca9 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -278,13 +278,17 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	case 4:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
 			fhp->fh_no_atomic_attr = true;
+		fhp->fh_64bit_cookies = true;
 		break;
 	case 3:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
 			fhp->fh_no_wcc = true;
+		fhp->fh_64bit_cookies = true;
 		break;
 	case 2:
 		fhp->fh_no_wcc = true;
+		if (EX_WGATHER(exp))
+			fhp->fh_use_wgather = true;
 	}
 
 	return 0;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 6ebdf7ea27bf..8d46e203d139 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -88,6 +88,8 @@ typedef struct svc_fh {
 						 * wcc data is not atomic with
 						 * operation
 						 */
+	bool			fh_use_wgather;	/* NFSv2 wgather option */
+	bool			fh_64bit_cookies;/* readdir cookie size */
 	int			fh_flags;	/* FH flags */
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cf96a2ef6533..ec99c91df173 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1162,7 +1162,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
-	int			use_wgather;
 	loff_t			pos = offset;
 	unsigned long		exp_op_flags = 0;
 	unsigned int		pflags = current->flags;
@@ -1188,12 +1187,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	}
 
 	exp = fhp->fh_export;
-	use_wgather = (rqstp->rq_vers == 2) && EX_WGATHER(exp);
 
 	if (!EX_ISSYNC(exp))
 		stable = NFS_UNSTABLE;
 
-	if (stable && !use_wgather)
+	if (stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
 	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
@@ -1212,7 +1210,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (host_err < 0)
 		goto out_nfserr;
 
-	if (stable && use_wgather) {
+	if (stable && fhp->fh_use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
 		if (host_err < 0)
 			commit_reset_write_verifier(nn, rqstp, host_err);
@@ -2175,8 +2173,7 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp,
 	loff_t		offset = *offsetp;
 	int             may_flags = NFSD_MAY_READ;
 
-	/* NFSv2 only supports 32 bit cookies */
-	if (rqstp->rq_vers > 2)
+	if (fhp->fh_64bit_cookies)
 		may_flags |= NFSD_MAY_64BIT_COOKIE;
 
 	err = nfsd_open(rqstp, fhp, S_IFDIR, may_flags, &file);
-- 
2.44.0


