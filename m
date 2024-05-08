Return-Path: <linux-nfs+bounces-3197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F38BF6A1
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 08:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1009C1C21160
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5471A2C15;
	Wed,  8 May 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cvdHfVks";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="smy8940K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cvdHfVks";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="smy8940K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65B22338;
	Wed,  8 May 2024 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715151276; cv=none; b=mq+VxLiIq/qR0LuSqslWBzR1cKwu/IaP/cFCMG6cZGs6TPT2KFYklPpumoynUVI7KaYTq+vYJxaWOfqbgXlT3uUFdXTB9+CMCmhHg7im1I3B00EXzPaIUl1LSFRmevkJKazUPSfgfssMZJaf8XoQUmqPy9jj6iYponVEM/VGI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715151276; c=relaxed/simple;
	bh=W5YKaZoQaIweD0X4GgzncnBDS/tkINhgL4sKlP5282k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Z7tBLTZotCNf1CP7JBWCWle/O/y1TwGGY+uehpXtHfTyA5ZZ6soQ5ECrhwRd69whmiqEk+LonnFnZj5g4D0Go3IhYvOZdf91ua/Jn3BvEf3cbHesCFTIJieatr+6NA+7aCm/CaKK5Lo/HSFZe/rCKS6MZbPH4tUywnUDeEyurqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cvdHfVks; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=smy8940K; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cvdHfVks; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=smy8940K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 136655C509;
	Wed,  8 May 2024 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715151273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgI7PUIiVJJDn5EVTzirnarsfZdzpeWQPUTrE4Ft8uk=;
	b=cvdHfVksVbZVaqcrHpD6mFbO9cToG770lVBEFfLtqDg4QPV0N+9DShzUa5/Fl2N1RB0vtF
	3UnL4B4mHW1AXvEo/LiD4P1+GrXb2xi0sU7nBeaEzwEQoha52R+gqlGU05W9/+2d31fYen
	aeT4DGq6rGgkC5OWE+HnsIii52Nf94s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715151273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgI7PUIiVJJDn5EVTzirnarsfZdzpeWQPUTrE4Ft8uk=;
	b=smy8940KXPHOcgagZuWTALD62t4d+CvRPu5elF2pH/NMv3KHDK5sKkNvcoL5/XpRlxSNyt
	aRBVzlU4kasYXbCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cvdHfVks;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=smy8940K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715151273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgI7PUIiVJJDn5EVTzirnarsfZdzpeWQPUTrE4Ft8uk=;
	b=cvdHfVksVbZVaqcrHpD6mFbO9cToG770lVBEFfLtqDg4QPV0N+9DShzUa5/Fl2N1RB0vtF
	3UnL4B4mHW1AXvEo/LiD4P1+GrXb2xi0sU7nBeaEzwEQoha52R+gqlGU05W9/+2d31fYen
	aeT4DGq6rGgkC5OWE+HnsIii52Nf94s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715151273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgI7PUIiVJJDn5EVTzirnarsfZdzpeWQPUTrE4Ft8uk=;
	b=smy8940KXPHOcgagZuWTALD62t4d+CvRPu5elF2pH/NMv3KHDK5sKkNvcoL5/XpRlxSNyt
	aRBVzlU4kasYXbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA1051386E;
	Wed,  8 May 2024 06:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GBjaEqUhO2YnZgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 08 May 2024 06:54:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Stephen Smalley" <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, linux-nfs@vger.kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, paul@paul-moore.com, omosnace@redhat.com,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] nfsd: set security label during create operations
In-reply-to:
 <CAEjxPJ6W7UGvPUMt82+_tB2MPmcmG7JaUjH6HhgjwTqOzQL_xA@mail.gmail.com>
References:
 <>, <CAEjxPJ6W7UGvPUMt82+_tB2MPmcmG7JaUjH6HhgjwTqOzQL_xA@mail.gmail.com>
Date: Wed, 08 May 2024 16:54:25 +1000
Message-id: <171515126555.4857.14866053620991695880@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 136655C509
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

On Tue, 07 May 2024, Stephen Smalley wrote:
> On Mon, May 6, 2024 at 1:46=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
> >
> > On Fri, 03 May 2024, Stephen Smalley wrote:
> > > When security labeling is enabled, the client can pass a file security
> > > label as part of a create operation for the new file, similar to mode
> > > and other attributes. At present, the security label is received by nfsd
> > > and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
> > > called and therefore the label is never set on the new file. This bug
> > > may have been introduced on or around commit d6a97d3f589a ("NFSD:
> > > add security label to struct nfsd_attrs"). Looking at nfsd_setattr()
> > > I am uncertain as to whether the same issue presents for
> > > file ACLs and therefore requires a similar fix for those.
> > >
> > > An alternative approach would be to introduce a new LSM hook to set the
> > > "create SID" of the current task prior to the actual file creation, whi=
ch
> > > would atomically label the new inode at creation time. This would be be=
tter
> > > for SELinux and a similar approach has been used previously
> > > (see security_dentry_create_files_as) but perhaps not usable by other L=
SMs.
> > >
> > > Reproducer:
> > > 1. Install a Linux distro with SELinux - Fedora is easiest
> > > 2. git clone https://github.com/SELinuxProject/selinux-testsuite
> > > 3. Install the requisite dependencies per selinux-testsuite/README.md
> > > 4. Run something like the following script:
> > > MOUNT=3D$HOME/selinux-testsuite
> > > sudo systemctl start nfs-server
> > > sudo exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
> > > sudo mkdir -p /mnt/selinux-testsuite
> > > sudo mount -t nfs -o vers=3D4.2 localhost:$MOUNT /mnt/selinux-testsuite
> > > pushd /mnt/selinux-testsuite/
> > > sudo make -C policy load
> > > pushd tests/filesystem
> > > sudo runcon -t test_filesystem_t ./create_file -f trans_test_file \
> > >       -e test_filesystem_filetranscon_t -v
> > > sudo rm -f trans_test_file
> > > popd
> > > sudo make -C policy unload
> > > popd
> > > sudo umount /mnt/selinux-testsuite
> > > sudo exportfs -u localhost:$MOUNT
> > > sudo rmdir /mnt/selinux-testsuite
> > > sudo systemctl stop nfs-server
> > >
> > > Expected output:
> > > <eliding noise from commands run prior to or after the test itself>
> > > Process context:
> > >       unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> > > Created file: trans_test_file
> > > File context: unconfined_u:object_r:test_filesystem_filetranscon_t:s0
> > > File context is correct
> > >
> > > Actual output:
> > > <eliding noise from commands run prior to or after the test itself>
> > > Process context:
> > >       unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> > > Created file: trans_test_file
> > > File context: system_u:object_r:test_file_t:s0
> > > File context error, expected:
> > >       test_filesystem_filetranscon_t
> > > got:
> > >       test_file_t
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > v3 removes the erroneous and unnecessary change to NFSv2 and updates the
> > > description to note the possible origin of the bug. I did not add a
> > > Fixes tag however as I have not yet tried confirming that.
> >
> > I think this bug has always been present - since label support was
> > added.
> > Commit d6a97d3f589a ("NFSD: add security label to struct nfsd_attrs")
> > should have fixed it, but was missing the extra test that you provide.
> >
> > So
> > Fixes: 0c71b7ed5de8 ("nfsd: introduce file_cache_mutex")
> > might be appropriate - it fixes the patch, though not a bug introduced
> > by the patch.
> >
> > Thanks for this patch!
> > Reviewed-by: NeilBrown <neilb@suse.de>
> >
> > NeilBrown
>=20
> Thanks for confirming. Do we need to also check for the ACL case in
> nfsd_attrs_valid() or is that covered in some other way?
>=20

Thanks a good question.  I should have asked it myself!
No, ACLs aren't covered some other way.  They have the same problem.

I'm tempted to suggest that we simple drop the guard and call
nfsd_setattr() unconditionally.  The cost is primarily the we call
inode_lock() without needing to do anything.

Maybe moving the test inside nfsd_setattr() makes it a bit more obvious
what is needed:

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2e41eb4c3cec..c738e9dfd72f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -499,6 +499,14 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	bool		size_change =3D (iap->ia_valid & ATTR_SIZE);
 	int		retries;
=20
+	if (!(iap->ia_valid ||
+	      (attr->na_seclabel && attr->na_seclabel->len) ||
+	      (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl) ||
+	      (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
+	       !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))))
+		/* Don't bother with inode_lock() */
+		goto out;
+
 	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |=3D NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
 		ftype =3D S_IFREG;
@@ -1418,14 +1426,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
 	if (!uid_eq(current_fsuid(), GLOBAL_ROOT_UID))
 		iap->ia_valid &=3D ~(ATTR_UID|ATTR_GID);
=20
-	/*
-	 * Callers expect new file metadata to be committed even
-	 * if the attributes have not changed.
-	 */
-	if (iap->ia_valid)
-		status =3D nfsd_setattr(rqstp, resfhp, attrs, NULL);
-	else
-		status =3D nfserrno(commit_metadata(resfhp));
+	status =3D nfsd_setattr(rqstp, resfhp, attrs, NULL);
=20
 	/*
 	 * Transactional filesystems had a chance to commit changes


Thoughts?

Thanks,
NeilBrown

