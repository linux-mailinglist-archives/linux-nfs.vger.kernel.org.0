Return-Path: <linux-nfs+bounces-4895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79969930F10
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC021C20BA8
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D9F13AD11;
	Mon, 15 Jul 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q1mh5WYg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vG/5zg4P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q1mh5WYg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vG/5zg4P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB5171E60
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029684; cv=none; b=STcotiL1PUSzBoXH0ydUTnhoq+7DLMlMW3Giv4s7IvZ0g5nOl4ZBnBvhykwytFRhkYUMIslDCOewYMwEvm1DeKUlJSfe6kXtJ+T99Eo4UMk5p5f1nzycOQX66iXfoLCvLmAtEYxnQH5ZJjnWUqrXaqHdtsYWFpQ6osnEtvPzHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029684; c=relaxed/simple;
	bh=HMf8nadfHZrqhSMc0OEmbeqj7bjEsGvDPKJgWV+wY40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6+2qxx8OHHSzSe03WUQFbq8a84DsQivQ2QZkZ6OtrXv7/QB/JaHJsinJbvJVnMG5l4TAhdzeatkUc84aCdidDWcgWQMH6NF/G9o075U4gIsNBwYcaDakQlH9FzQeH32r3mdhVGwfCF/n3zgxC2IY+HHp1YX55mupyeasszzwlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q1mh5WYg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vG/5zg4P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q1mh5WYg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vG/5zg4P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA75A21B94;
	Mon, 15 Jul 2024 07:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZt5Mxs7PNooXY2SkHlQyLphtZXwvbQEjr2BEFIyhc8=;
	b=q1mh5WYgaSmpN/lQn1CXp5sBBxmJtbrPXztC0pEpU4HTc6ORiXnDAa+Xw6W/IyFrfa5xXj
	uc5WM8jpEoxoNOAD+OiJfDMcs/3cNGZq+utLaJ/YhO+G9UQc6rqLrbXN4Btodygy/Cj3So
	6H1dYp+9OWq7F05lAhnVRR9pd15CCvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZt5Mxs7PNooXY2SkHlQyLphtZXwvbQEjr2BEFIyhc8=;
	b=vG/5zg4PJzKZ/SKYJgI8GxxIsH7r4jtarRLzT9XkLfXFKE9h+lVep+WuWTs3umdEH0qKOT
	xw+CP0KZr0Q9BdCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q1mh5WYg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="vG/5zg4P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZt5Mxs7PNooXY2SkHlQyLphtZXwvbQEjr2BEFIyhc8=;
	b=q1mh5WYgaSmpN/lQn1CXp5sBBxmJtbrPXztC0pEpU4HTc6ORiXnDAa+Xw6W/IyFrfa5xXj
	uc5WM8jpEoxoNOAD+OiJfDMcs/3cNGZq+utLaJ/YhO+G9UQc6rqLrbXN4Btodygy/Cj3So
	6H1dYp+9OWq7F05lAhnVRR9pd15CCvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZt5Mxs7PNooXY2SkHlQyLphtZXwvbQEjr2BEFIyhc8=;
	b=vG/5zg4PJzKZ/SKYJgI8GxxIsH7r4jtarRLzT9XkLfXFKE9h+lVep+WuWTs3umdEH0qKOT
	xw+CP0KZr0Q9BdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54A0F137EB;
	Mon, 15 Jul 2024 07:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cvrPAi7UlGbZbQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:47:58 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 03/14] nfsd: move nfsd_pool_stats_open into nfsctl.c
Date: Mon, 15 Jul 2024 17:14:16 +1000
Message-ID: <20240715074657.18174-4-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: BA75A21B94

nfsd_pool_stats_open() is used in nfsctl.c, so move it there.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsctl.c | 7 +++++++
 fs/nfsd/nfsd.h   | 2 --
 fs/nfsd/nfssvc.c | 7 -------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 9e0ea6fc2aa3..9b47723fc110 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -174,6 +174,13 @@ static int export_features_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(export_features);
 
+static int nfsd_pool_stats_open(struct inode *inode, struct file *file)
+{
+	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
+
+	return svc_pool_stats_open(&nn->nfsd_info, file);
+}
+
 static const struct file_operations pool_stats_operations = {
 	.open		= nfsd_pool_stats_open,
 	.read		= seq_read,
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index cec8697b1cd6..39e109a7d56d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -111,8 +111,6 @@ int		nfsd_nrthreads(struct net *);
 int		nfsd_nrpools(struct net *);
 int		nfsd_get_nrthreads(int n, int *, struct net *);
 int		nfsd_set_nrthreads(int n, int *, struct net *);
-int		nfsd_pool_stats_open(struct inode *, struct file *);
-int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
 bool		i_am_nfsd(void);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 0bc8eaa5e009..f25b26bc5670 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1084,10 +1084,3 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	return true;
 }
-
-int nfsd_pool_stats_open(struct inode *inode, struct file *file)
-{
-	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
-
-	return svc_pool_stats_open(&nn->nfsd_info, file);
-}
-- 
2.44.0


