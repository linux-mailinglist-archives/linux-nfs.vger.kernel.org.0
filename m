Return-Path: <linux-nfs+bounces-5710-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF20995E5AD
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 01:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E09DB20F51
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Aug 2024 23:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0236BFC7;
	Sun, 25 Aug 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tpetUtV0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QCmf++cT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tpetUtV0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QCmf++cT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1833987D;
	Sun, 25 Aug 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724628178; cv=none; b=E1oHbp7Aaz0BBWNkh4whyP+wl3IKMOg0FDX/i0CMC2FALJxGVjiX5hvOniCNNqVZ9jBhYnoNRseA2e2IJDbTgtvzgvwLcSfZ1P/7PX2A+c2+z+bQhnpRbvODkWz8q6aoJkK6NDU15lA/hJ3TmqY0WqUSG/M9n8NEM4UnvErWzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724628178; c=relaxed/simple;
	bh=rN38WeAunjinLNGCQxnc3ZuOawCz7tbP5Du3LhIOPj8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mhuXKxEMK3oO7v3mnKnXJGSS8xJvZKm11Bau4U5NniTfLNIUoxHms8EOYzaiE/jz1ilmVoyp6ocv0db55SZFrO8nQavNITdhas6m4EZeWPHOThIFZvNUSnwYKZTz00o2SnBhwEEKdI9Zv8rOXVGynNOS7Oon2q5Gmr9pdq5c84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tpetUtV0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QCmf++cT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tpetUtV0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QCmf++cT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 123F01F80D;
	Sun, 25 Aug 2024 23:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724628168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgbsW3Bbrwsla8I/iSJy5bacxZiaWCI7vnc90WyacrU=;
	b=tpetUtV0wHK9UMOPlcseWUvHr3m3QreXwrqbVxQgFyhgLV8khbq/O8O/a4nwgvIOpeK8lW
	v1wVsBklmuvOfe5uEcfe1w6fZiJ1ja1rmHazzrz5WgjpSe8zh8p8IAoUImATo+4MHTxSZU
	ak5BrpmW6QAQOaotnA5loBGm5EivHT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724628168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgbsW3Bbrwsla8I/iSJy5bacxZiaWCI7vnc90WyacrU=;
	b=QCmf++cTnC2uPVaL7Z2gV182tkKaJUT5b8O2QCwYCZDcN/uRB5jQ5b6tPlzp2rZS/Z0Kne
	2otgzpi9brrzSyBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tpetUtV0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QCmf++cT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724628168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgbsW3Bbrwsla8I/iSJy5bacxZiaWCI7vnc90WyacrU=;
	b=tpetUtV0wHK9UMOPlcseWUvHr3m3QreXwrqbVxQgFyhgLV8khbq/O8O/a4nwgvIOpeK8lW
	v1wVsBklmuvOfe5uEcfe1w6fZiJ1ja1rmHazzrz5WgjpSe8zh8p8IAoUImATo+4MHTxSZU
	ak5BrpmW6QAQOaotnA5loBGm5EivHT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724628168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgbsW3Bbrwsla8I/iSJy5bacxZiaWCI7vnc90WyacrU=;
	b=QCmf++cTnC2uPVaL7Z2gV182tkKaJUT5b8O2QCwYCZDcN/uRB5jQ5b6tPlzp2rZS/Z0Kne
	2otgzpi9brrzSyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B88813704;
	Sun, 25 Aug 2024 23:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i8vaE8W8y2YcSgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Aug 2024 23:22:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] nfsd: CB_GETATTR fixes
In-reply-to: <Zsoe/D24xvLfKClT@tissot.1015granger.net>
References: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>,
 <Zsoe/D24xvLfKClT@tissot.1015granger.net>
Date: Mon, 26 Aug 2024 09:22:42 +1000
Message-id: <172462816214.6062.16988455872478253419@noble.neil.brown.name>
X-Rspamd-Queue-Id: 123F01F80D
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 25 Aug 2024, Chuck Lever wrote:
> On Fri, Aug 23, 2024 at 06:27:37PM -0400, Jeff Layton wrote:
> > Fixes for a couple of CB_GETATTR bugs I found while working on the
> > delstid set. Mostly this just ensures that we hold references to the
> > delegation while working with it.
> >=20
> >=20
>=20
> Applied to nfsd-fixes for v6.11-rc, thanks!
>=20
> [1/2] nfsd: hold reference to delegation when updating it for cb_getattr
>       commit: 8fceb5f6636bbbf803fe29fff59f138206559964
> [2/2] nfsd: fix potential UAF in nfsd4_cb_getattr_release
>       commit: 8bc97f9b84c8852fcc56be2382f5115c518de785
>=20
> --=20
> Chuck Lever
>=20

Maybe the following can tidy up that code.  I can split this into
a few separate patches if you like.
Thoughts?

Note that the patch is easier to review if you apply it then use "git
diff -b".

NeilBrown


From: NeilBrown <neilb@suse.de>
Subject: [PATCH] nfsd: untangle code in nfsd4_deleg_getattr_conflict()

The code in nfsd4_deleg_getattr_conflict() is convoluted and buggy.

With this patch we:
 - properly handle non-nfsd leases.  We must not assume flc_owner is a
    delegation unless fl_lmops =3D=3D &nfsd_lease_mng_ops
 - move the main code out of the for loop
 - have a single exit which calls nfs4_put_stid()
   (and other exits which don't need to call that)

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 130 ++++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2c4b9a22b2bb..7672fa7a70f3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8837,6 +8837,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, st=
ruct dentry *dentry,
 	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct inode *inode =3D d_inode(dentry);
 	struct file_lock_context *ctx;
+	struct nfs4_delegation *dp =3D NULL;
 	struct nfs4_cb_fattr *ncf;
 	struct file_lease *fl;
 	struct iattr attrs;
@@ -8845,77 +8846,76 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, =
struct dentry *dentry,
 	ctx =3D locks_inode_context(inode);
 	if (!ctx)
 		return 0;
+
+#define NON_NFSD_LEASE ((void*)1)
+
 	spin_lock(&ctx->flc_lock);
 	for_each_file_lock(fl, &ctx->flc_lease) {
-		unsigned char type =3D fl->c.flc_type;
-
 		if (fl->c.flc_flags =3D=3D FL_LAYOUT)
 			continue;
-		if (fl->fl_lmops !=3D &nfsd_lease_mng_ops) {
-			/*
-			 * non-nfs lease, if it's a lease with F_RDLCK then
-			 * we are done; there isn't any write delegation
-			 * on this inode
-			 */
-			if (type =3D=3D F_RDLCK)
-				break;
-			goto break_lease;
-		}
-		if (type =3D=3D F_WRLCK) {
-			struct nfs4_delegation *dp =3D fl->c.flc_owner;
-
-			if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker)) {
-				spin_unlock(&ctx->flc_lock);
-				return 0;
-			}
-break_lease:
-			nfsd_stats_wdeleg_getattr_inc(nn);
-			dp =3D fl->c.flc_owner;
-			refcount_inc(&dp->dl_stid.sc_count);
-			ncf =3D &dp->dl_cb_fattr;
-			nfs4_cb_getattr(&dp->dl_cb_fattr);
-			spin_unlock(&ctx->flc_lock);
-			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
-					TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
-			if (ncf->ncf_cb_status) {
-				/* Recall delegation only if client didn't respond */
-				status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
-				if (status !=3D nfserr_jukebox ||
-						!nfsd_wait_for_delegreturn(rqstp, inode)) {
-					nfs4_put_stid(&dp->dl_stid);
-					return status;
-				}
-			}
-			if (!ncf->ncf_file_modified &&
-					(ncf->ncf_initial_cinfo !=3D ncf->ncf_cb_change ||
-					ncf->ncf_cur_fsize !=3D ncf->ncf_cb_fsize))
-				ncf->ncf_file_modified =3D true;
-			if (ncf->ncf_file_modified) {
-				int err;
-
-				/*
-				 * Per section 10.4.3 of RFC 8881, the server would
-				 * not update the file's metadata with the client's
-				 * modified size
-				 */
-				attrs.ia_mtime =3D attrs.ia_ctime =3D current_time(inode);
-				attrs.ia_valid =3D ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
-				inode_lock(inode);
-				err =3D notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
-				inode_unlock(inode);
-				if (err) {
-					nfs4_put_stid(&dp->dl_stid);
-					return nfserrno(err);
-				}
-				ncf->ncf_cur_fsize =3D ncf->ncf_cb_fsize;
-				*size =3D ncf->ncf_cur_fsize;
-				*modified =3D true;
-			}
-			nfs4_put_stid(&dp->dl_stid);
-			return 0;
+		if (fl->c.flc_type =3D=3D F_WRLCK) {
+			if (fl->fl_lmops =3D=3D &nfsd_lease_mng_ops)
+				dp =3D fl->c.flc_owner;
+			else
+				dp =3D NON_NFSD_LEASE;
 		}
 		break;
 	}
+	if (dp =3D=3D NULL || dp =3D=3D NON_NFSD_LEASE ||
+	    dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breaker)) {
+		spin_unlock(&ctx->flc_lock);
+		if (dp =3D=3D NON_NFSD_LEASE) {
+			status =3D nfserrno(nfsd_open_break_lease(inode,
+								NFSD_MAY_READ));
+			if (status !=3D nfserr_jukebox ||
+			    !nfsd_wait_for_delegreturn(rqstp, inode))
+				return status;
+		}
+		return 0;
+	}
+
+	nfsd_stats_wdeleg_getattr_inc(nn);
+	refcount_inc(&dp->dl_stid.sc_count);
+	ncf =3D &dp->dl_cb_fattr;
+	nfs4_cb_getattr(&dp->dl_cb_fattr);
 	spin_unlock(&ctx->flc_lock);
-	return 0;
+
+	wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
+			    TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
+	if (ncf->ncf_cb_status) {
+		/* Recall delegation only if client didn't respond */
+		status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+		if (status !=3D nfserr_jukebox ||
+		    !nfsd_wait_for_delegreturn(rqstp, inode))
+			goto out_status;
+	}
+	if (!ncf->ncf_file_modified &&
+	    (ncf->ncf_initial_cinfo !=3D ncf->ncf_cb_change ||
+	     ncf->ncf_cur_fsize !=3D ncf->ncf_cb_fsize))
+		ncf->ncf_file_modified =3D true;
+	if (ncf->ncf_file_modified) {
+		int err;
+
+		/*
+		 * Per section 10.4.3 of RFC 8881, the server would
+		 * not update the file's metadata with the client's
+		 * modified size
+		 */
+		attrs.ia_mtime =3D attrs.ia_ctime =3D current_time(inode);
+		attrs.ia_valid =3D ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
+		inode_lock(inode);
+		err =3D notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
+		inode_unlock(inode);
+		if (err) {
+			status =3D nfserrno(err);
+			goto out_status;
+		}
+		ncf->ncf_cur_fsize =3D ncf->ncf_cb_fsize;
+		*size =3D ncf->ncf_cur_fsize;
+		*modified =3D true;
+	}
+	status =3D 0;
+out_status:
+	nfs4_put_stid(&dp->dl_stid);
+	return status;
 }
--=20
2.44.0


