Return-Path: <linux-nfs+bounces-3164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D18BC71F
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 07:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE39B20B10
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89D447F4A;
	Mon,  6 May 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BolWuP78";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lLu+0GT0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BolWuP78";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lLu+0GT0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31845944;
	Mon,  6 May 2024 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714974409; cv=none; b=I8wfFN8quZY6MYylRVQogxo8hXzWvpcYFCyHl3Da/1p5m4d0MYdhqPPJtuKU3kJvWGOdCMFh6q005HVip13qO26KMHzVz7BfbRnLo+gBOWaZQbJqT0wbVUQbTJUSVDor5awu0TQN3VL8rcGzUoSN4dM4xiNAAyHWcDy86rvmJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714974409; c=relaxed/simple;
	bh=aa7G9OraNqIaG4CQVfabrd6LwF/tctqeAh8Wzpizg+Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=acbjSmWob6ytOpxK9xjO5H6P+V0azKKPbNqw0NTYh/tbpQm4KUIIpNgxh4yaPSfSyROcCojm/qBaKPQbfrDXoOTtKvqkacky8kldWk7UFBghkRJFQiRi63bPxbROoKNrL5BfXSHjxcYMSuibg96RrmZU9ILTaJXUpMHEq0AHxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BolWuP78; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lLu+0GT0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BolWuP78; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lLu+0GT0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 259C85D2C4;
	Mon,  6 May 2024 05:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714974406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CvcLGZ4YTWAstQCMQoInkF1Pq1UgMZ85xsTp6fXaZc=;
	b=BolWuP78hBVM2IA0G6vg6iWNSNJBZCY64x6IU+DvND4W2s+3JiE+F9y2e41jstlLSvTMBE
	XAA/tCxlEXXYX1vRBICtlhNuBA7nWRzfyGi2xAT+fW38MQGSf8el8H0fQKseDUTBc0AY8b
	aivFIfQg2yPcQhHuwfqC5JAVuYVd1aM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714974406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CvcLGZ4YTWAstQCMQoInkF1Pq1UgMZ85xsTp6fXaZc=;
	b=lLu+0GT0CgFcFoBp+4LYO9xZGPvRbdXFAnMm/gsHZJ+5+5kbckOdnqK1N/7boByK0+ZE9C
	uXI54qZlDORQKaBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714974406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CvcLGZ4YTWAstQCMQoInkF1Pq1UgMZ85xsTp6fXaZc=;
	b=BolWuP78hBVM2IA0G6vg6iWNSNJBZCY64x6IU+DvND4W2s+3JiE+F9y2e41jstlLSvTMBE
	XAA/tCxlEXXYX1vRBICtlhNuBA7nWRzfyGi2xAT+fW38MQGSf8el8H0fQKseDUTBc0AY8b
	aivFIfQg2yPcQhHuwfqC5JAVuYVd1aM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714974406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CvcLGZ4YTWAstQCMQoInkF1Pq1UgMZ85xsTp6fXaZc=;
	b=lLu+0GT0CgFcFoBp+4LYO9xZGPvRbdXFAnMm/gsHZJ+5+5kbckOdnqK1N/7boByK0+ZE9C
	uXI54qZlDORQKaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C65D4134C3;
	Mon,  6 May 2024 05:46:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I4BsGsJuOGZpOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 06 May 2024 05:46:42 +0000
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
 linux-security-module@vger.kernel.org,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3] nfsd: set security label during create operations
In-reply-to: <20240503130905.16823-1-stephen.smalley.work@gmail.com>
References: <20240503130905.16823-1-stephen.smalley.work@gmail.com>
Date: Mon, 06 May 2024 15:46:34 +1000
Message-id: <171497439414.9775.6998904788791406674@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,kernel.org,paul-moore.com,redhat.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Fri, 03 May 2024, Stephen Smalley wrote:
> When security labeling is enabled, the client can pass a file security
> label as part of a create operation for the new file, similar to mode
> and other attributes. At present, the security label is received by nfsd
> and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
> called and therefore the label is never set on the new file. This bug
> may have been introduced on or around commit d6a97d3f589a ("NFSD:
> add security label to struct nfsd_attrs"). Looking at nfsd_setattr()
> I am uncertain as to whether the same issue presents for
> file ACLs and therefore requires a similar fix for those.
>=20
> An alternative approach would be to introduce a new LSM hook to set the
> "create SID" of the current task prior to the actual file creation, which
> would atomically label the new inode at creation time. This would be better
> for SELinux and a similar approach has been used previously
> (see security_dentry_create_files_as) but perhaps not usable by other LSMs.
>=20
> Reproducer:
> 1. Install a Linux distro with SELinux - Fedora is easiest
> 2. git clone https://github.com/SELinuxProject/selinux-testsuite
> 3. Install the requisite dependencies per selinux-testsuite/README.md
> 4. Run something like the following script:
> MOUNT=3D$HOME/selinux-testsuite
> sudo systemctl start nfs-server
> sudo exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
> sudo mkdir -p /mnt/selinux-testsuite
> sudo mount -t nfs -o vers=3D4.2 localhost:$MOUNT /mnt/selinux-testsuite
> pushd /mnt/selinux-testsuite/
> sudo make -C policy load
> pushd tests/filesystem
> sudo runcon -t test_filesystem_t ./create_file -f trans_test_file \
> 	-e test_filesystem_filetranscon_t -v
> sudo rm -f trans_test_file
> popd
> sudo make -C policy unload
> popd
> sudo umount /mnt/selinux-testsuite
> sudo exportfs -u localhost:$MOUNT
> sudo rmdir /mnt/selinux-testsuite
> sudo systemctl stop nfs-server
>=20
> Expected output:
> <eliding noise from commands run prior to or after the test itself>
> Process context:
> 	unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> Created file: trans_test_file
> File context: unconfined_u:object_r:test_filesystem_filetranscon_t:s0
> File context is correct
>=20
> Actual output:
> <eliding noise from commands run prior to or after the test itself>
> Process context:
> 	unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> Created file: trans_test_file
> File context: system_u:object_r:test_file_t:s0
> File context error, expected:
> 	test_filesystem_filetranscon_t
> got:
> 	test_file_t
>=20
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 removes the erroneous and unnecessary change to NFSv2 and updates the
> description to note the possible origin of the bug. I did not add a=20
> Fixes tag however as I have not yet tried confirming that.

I think this bug has always been present - since label support was
added.
Commit d6a97d3f589a ("NFSD: add security label to struct nfsd_attrs")
should have fixed it, but was missing the extra test that you provide.

So=20
Fixes: 0c71b7ed5de8 ("nfsd: introduce file_cache_mutex")
might be appropriate - it fixes the patch, though not a bug introduced
by the patch.

Thanks for this patch!
Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown



>=20
>  fs/nfsd/vfs.c | 2 +-
>  fs/nfsd/vfs.h | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2e41eb4c3cec..29b1f3613800 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1422,7 +1422,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  	 * Callers expect new file metadata to be committed even
>  	 * if the attributes have not changed.
>  	 */
> -	if (iap->ia_valid)
> +	if (nfsd_attrs_valid(attrs))
>  		status =3D nfsd_setattr(rqstp, resfhp, attrs, NULL);
>  	else
>  		status =3D nfserrno(commit_metadata(resfhp));
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index c60fdb6200fd..57cd70062048 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -60,6 +60,14 @@ static inline void nfsd_attrs_free(struct nfsd_attrs *at=
trs)
>  	posix_acl_release(attrs->na_dpacl);
>  }
> =20
> +static inline bool nfsd_attrs_valid(struct nfsd_attrs *attrs)
> +{
> +	struct iattr *iap =3D attrs->na_iattr;
> +
> +	return (iap->ia_valid || (attrs->na_seclabel &&
> +		attrs->na_seclabel->len));
> +}
> +
>  __be32		nfserrno (int errno);
>  int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
>  		                struct svc_export **expp);
> --=20
> 2.40.1
>=20
>=20


