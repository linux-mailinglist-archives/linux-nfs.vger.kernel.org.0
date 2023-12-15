Return-Path: <linux-nfs+bounces-620-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E0D814394
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 09:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B662284227
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F7217987;
	Fri, 15 Dec 2023 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zc5Iu7XG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gyeHSIk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zc5Iu7XG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/gyeHSIk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D117981
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA77D1F821;
	Fri, 15 Dec 2023 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702628844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSzW/5B1MhiMU/2YXDsppFBwMeE/9rRSOY5c35twg70=;
	b=Zc5Iu7XGSIdzavAOjljuGEwbWvmfHqdKYeUeBZnVsvvCytIgERYEVTnkNxWnS4Z2Rw2dnk
	Lfap5oTUjJuqMlFDeGD1KBrOC6nva99V7sHTZhSP9xea82iHdpccDDwIq5rfVE9G4KxeXX
	juODoWtl8/eP8ktqD4VAAilwl4GiAOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702628844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSzW/5B1MhiMU/2YXDsppFBwMeE/9rRSOY5c35twg70=;
	b=/gyeHSIkxVHvOW7GouNABIa9+a/Ymto9a1RQHjwi0P9hgEPejPPr1RSNRFi2CQ7vvPUtF/
	CNFHr5nzXqKwV7CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702628844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSzW/5B1MhiMU/2YXDsppFBwMeE/9rRSOY5c35twg70=;
	b=Zc5Iu7XGSIdzavAOjljuGEwbWvmfHqdKYeUeBZnVsvvCytIgERYEVTnkNxWnS4Z2Rw2dnk
	Lfap5oTUjJuqMlFDeGD1KBrOC6nva99V7sHTZhSP9xea82iHdpccDDwIq5rfVE9G4KxeXX
	juODoWtl8/eP8ktqD4VAAilwl4GiAOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702628844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSzW/5B1MhiMU/2YXDsppFBwMeE/9rRSOY5c35twg70=;
	b=/gyeHSIkxVHvOW7GouNABIa9+a/Ymto9a1RQHjwi0P9hgEPejPPr1RSNRFi2CQ7vvPUtF/
	CNFHr5nzXqKwV7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99D74137D4;
	Fri, 15 Dec 2023 08:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dYM7FOoNfGU4PQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Dec 2023 08:27:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject:
 [PATCH 3/2 SQUASH] nfsd: use __fput_sync() to avoid delayed closing of files.
In-reply-to: <20231215012059.30857-3-neilb@suse.de>
References: <20231215012059.30857-1-neilb@suse.de>,
 <20231215012059.30857-3-neilb@suse.de>
Date: Fri, 15 Dec 2023 19:27:19 +1100
Message-id: <170262883968.12910.3593954866329935845@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.97%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -3.09


After posting I remembered that you suggested a separate function would
be a good place for relevant documentation.

Please squash this into 2/2.

Thanks.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c |  4 +---
 fs/nfsd/vfs.c       | 34 +++++++++++++++++++++++++++++++++-
 fs/nfsd/vfs.h       |  2 ++
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f9da4b0c4d42..9a6ff8fcd12e 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -280,9 +280,7 @@ nfsd_file_free(struct nfsd_file *nf)
 		nfsd_file_mark_put(nf->nf_mark);
 	if (nf->nf_file) {
 		nfsd_file_check_write_error(nf);
-		get_file(nf->nf_file);
-		filp_close(nf->nf_file, NULL);
-		__fput_sync(nf->nf_file);
+		nfsd_filp_close(nf->nf_file);
 	}
=20
 	/*
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 998f9ba0e168..f365c613e39e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2141,11 +2141,43 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *f=
hp, loff_t *offsetp,
 	if (err =3D=3D nfserr_eof || err =3D=3D nfserr_toosmall)
 		err =3D nfs_ok; /* can still be found in ->err */
 out_close:
-	__fput_sync(file);
+	nfsd_filp_close(file);
 out:
 	return err;
 }
=20
+/**
+ * nfsd_filp_close: close a file synchronously
+ * @fp: the file to close
+ *
+ * nfsd_filp_close() is similar in behaviour to filp_close().
+ * The difference is that if this is the final close on the
+ * file, the that finalisation happens immediately, rather then
+ * being handed over to a work_queue, as it the case for
+ * filp_close().
+ * When a user-space process closes a file (even when using
+ * filp_close() the finalisation happens before returning to
+ * userspace, so it is effectively synchronous.  When a kernel thread
+ * uses file_close(), on the other hand, the handling is completely
+ * asynchronous.  This means that any cost imposed by that finalisation
+ * is not imposed on the nfsd thread, and nfsd could potentually
+ * close files more quickly than the work queue finalises the close,
+ * which would lead to unbounded growth in the queue.
+ *
+ * In some contexts is it not safe to synchronously wait for
+ * close finalisation (see comment for __fput_sync()), but nfsd
+ * does not match those contexts.  In partcilarly it does not, at the
+ * time that this function is called, hold and locks and no finalisation
+ * of any file, socket, or device driver would have any cause to wait
+ * for nfsd to make progress.
+ */
+void nfsd_filp_close(struct file *fp)
+{
+	get_file(fp);
+	filp_close(fp, NULL);
+	__fput_sync(fp);
+}
+
 /*
  * Get file system stats
  * N.B. After this call fhp needs an fh_put
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index e3c29596f4df..f76b5c6b4706 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -147,6 +147,8 @@ __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
 				struct dentry *, int);
=20
+void		nfsd_filp_close(struct file *fp);
+
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
--=20
2.43.0


