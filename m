Return-Path: <linux-nfs+bounces-619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D2813F21
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 02:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7990B1C22019
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 01:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021E7E4;
	Fri, 15 Dec 2023 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gQkD28eF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X1GfI6rN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CUpo8kNr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S/htBL0y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247BD806
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA9421F7FB;
	Fri, 15 Dec 2023 01:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702603289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz/nim8/jsHsvIcB/XFyn5964zo5YwD/Bt3+nB8GV4w=;
	b=gQkD28eF7SuAOnGpBHFuxHrXiISZL/x1WhSSwL0B/Yda2IFO6LAwY+OM+60TfehKEI4t5+
	kggd8Tv6Hq5xKCqvxXzdhJg5h7iA/ktnGEOd7W6/XuDqCsOeQHHBw5KmizavVaG4LRoQVV
	OyXoPZTngsviyfeknaPwhWR4fgXns60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702603289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz/nim8/jsHsvIcB/XFyn5964zo5YwD/Bt3+nB8GV4w=;
	b=X1GfI6rNexsdoyvOJWXzVygemA9Z5ZM7+bm+EGXHyvi7iDQ+QTNy3gG52+RfGxUe911SKD
	DW5cc6YDFXL57oAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702603288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz/nim8/jsHsvIcB/XFyn5964zo5YwD/Bt3+nB8GV4w=;
	b=CUpo8kNrVQ++NTYZOp+4BAcG4IbAzZ0SkXtLF1r4sOlMDMx/H3J+5xw6Nm30lksN4jqri2
	Vh3c1wDeuvQv4ogm1a/fEgE/tF3EpCuVmlPc4++F8U20bRB3lKjhvxwvXoY8eUYfORoyoH
	OdbsFznv3EurHl/HE1SUPxbnavd1Xpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702603288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz/nim8/jsHsvIcB/XFyn5964zo5YwD/Bt3+nB8GV4w=;
	b=S/htBL0yzmV9XV6VYfrKNENz0rDzzS+tBfj/w7r5uYdOBk/tt5txcTRt9EDG+S7gO9nYqu
	824mCm5FHxhBMoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB7901342E;
	Fri, 15 Dec 2023 01:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QB4XIBaqe2U0VQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Dec 2023 01:21:26 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/2] nfsd: use __fput_sync() to avoid delayed closing of files.
Date: Fri, 15 Dec 2023 12:18:31 +1100
Message-ID: <20231215012059.30857-3-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215012059.30857-1-neilb@suse.de>
References: <20231215012059.30857-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 12.31
X-Spam-Flag: NO
X-Spam-Flag: NO
X-Spamd-Result: default: False [10.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[99.99%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *********
X-Spam-Score: 10.00
Authentication-Results: smtp-out2.suse.de;
	none

Calling fput() directly or though filp_close() from a kernel thread like
nfsd causes the final __fput() (if necessary) to be called from a
workqueue.  This means that nfsd is not forced to wait for any work to
complete.  If the ->release or ->destroy_inode function is slow for any
reason, this can result in nfsd closing files more quickly than the
workqueue can complete the close and the queue of pending closes can
grow without bounces (30 million has been seen at one customer site,
though this was in part due to a slowness in xfs which has since been
fixed).

nfsd does not need this.  It is quite appropriate and safe for nfsd to
do its own close work.  There is no reason that close should ever wait
for nfsd, so no deadlock can occur.

It should be safe and sensible to change all fput() calls to
__fput_sync().  However in the interests of caution this patch only
changes two - the two that can be most directly affected by client
behaviour and could occur at high frequency.

- the fput() implicitly in flip_close() is changed to __fput_sync()
  by calling get_file() first to ensure filp_close() doesn't do
  the final fput() itself.  If is where files opened for IO are closed.

- the fput() in nfsd_read() is also changed.  This is where directories
  opened for readdir are closed.

This ensure that minimal fput work is queued to the workqueue.

This removes the need for the flush_delayed_fput() call in
nfsd_file_close_inode_sync()

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c |  3 ++-
 fs/nfsd/vfs.c       | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2521379d28ec..f9da4b0c4d42 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -280,7 +280,9 @@ nfsd_file_free(struct nfsd_file *nf)
 		nfsd_file_mark_put(nf->nf_mark);
 	if (nf->nf_file) {
 		nfsd_file_check_write_error(nf);
+		get_file(nf->nf_file);
 		filp_close(nf->nf_file, NULL);
+		__fput_sync(nf->nf_file);
 	}
 
 	/*
@@ -658,7 +660,6 @@ nfsd_file_close_inode_sync(struct inode *inode)
 		list_del_init(&nf->nf_lru);
 		nfsd_file_free(nf);
 	}
-	flush_delayed_fput();
 }
 
 static int
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fbbea7498f02..998f9ba0e168 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1884,10 +1884,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	fh_drop_write(ffhp);
 
 	/*
-	 * If the target dentry has cached open files, then we need to try to
-	 * close them prior to doing the rename. Flushing delayed fput
-	 * shouldn't be done with locks held however, so we delay it until this
-	 * point and then reattempt the whole shebang.
+	 * If the target dentry has cached open files, then we need to
+	 * try to close them prior to doing the rename.  Final fput
+	 * shouldn't be done with locks held however, so we delay it
+	 * until this point and then reattempt the whole shebang.
 	 */
 	if (close_cached) {
 		close_cached = false;
@@ -2141,7 +2141,7 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp,
 	if (err == nfserr_eof || err == nfserr_toosmall)
 		err = nfs_ok; /* can still be found in ->err */
 out_close:
-	fput(file);
+	__fput_sync(file);
 out:
 	return err;
 }
-- 
2.43.0


