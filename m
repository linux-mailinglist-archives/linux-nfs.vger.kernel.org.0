Return-Path: <linux-nfs+bounces-3395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8638CF889
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 06:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8123C1C210FF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 04:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC44D512;
	Mon, 27 May 2024 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YUaJ7g88";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jGD4+v8J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MV1fqNgG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5LHvDK8m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71CD50F
	for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785424; cv=none; b=d9fl+cRaMQFxMzIE3OEHJYEB5P/UIh6huj7w+4HDVLiRY8eXVlgcVcV5dFsC5rT+Q/kPddXFLtqdg5nJJapo04/XISjZyBj6kjBPBOlrq6DBmrpMUNH0ip3Wfj/1LBfHU81IRhgwXL8TuMQegGJb9S9Sb+x9tkMXjNg0E1BK8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785424; c=relaxed/simple;
	bh=qimbW9Mc1AQ5Hn+LUOKA2MqOn1jU1S3x5H/q9sfIahU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Bv40R9BkquCeCakIU50F1pSI/WqR9NJhzAXRI5t6yI3D59m7SgoIbhMX+k8KVKLabJXNqKOkvmHkhGDvsLW6a17NaeH3MtauKVUu98EfmzRl5jk97g2H7HYwK4dyO+Ogf5p6zSCJmrW/ZPXDAhDkoFqcFn/meXvX5PqLsdGEzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YUaJ7g88; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jGD4+v8J; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MV1fqNgG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5LHvDK8m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C87421C18;
	Mon, 27 May 2024 04:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716785420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB2zXpspf+7lsVA02dFuDWSk/9YYkCX0+RGKnpga/Yw=;
	b=YUaJ7g88rZ30cLwfedkdKGlzXfj3VfxqjiQztRBQ7LRyrSy9Kr90rook9k8Lh+69/xquNn
	JVuPW8hIUjD2+5c0zO5SA9RgbH4oMR91Kaxvj4G85QXiLYQoYSIuC6usLe7cZYyflzePeW
	1pBZHdsAwdBpqODcRXIy4VutJRbbybQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716785420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB2zXpspf+7lsVA02dFuDWSk/9YYkCX0+RGKnpga/Yw=;
	b=jGD4+v8J+991XZehqUdJLPbAz8xMuzrWFCN2FAsMPeTZVdHc90zdYqHQaca8IgJ1G+EOiq
	3RMonYWjqxkj8JDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716785419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB2zXpspf+7lsVA02dFuDWSk/9YYkCX0+RGKnpga/Yw=;
	b=MV1fqNgG6EvAtremghHgIkjHGdEUtlR6SEfnEHBOb88fDihW97OY2dzboOHhrc5dfsQkeh
	YeOgFClxD1VfjNdGCyOxfu0xP5PZ0TFNLjvYnbNgExWCT+DOhh7VL2irljxux0YtXt9T3H
	bgYuCvLat6cksxTAwYwM/rE8i+2uJxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716785419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB2zXpspf+7lsVA02dFuDWSk/9YYkCX0+RGKnpga/Yw=;
	b=5LHvDK8mh8JI7/yTNIIeWcTKNDw3otYskFX6zOxtWG2CI0lccpdkEd77U2Z08sdm4TEQtj
	WXr6ouWGj/NaJJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9EA913A6B;
	Mon, 27 May 2024 04:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ne9NFwkRVGZhCgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 May 2024 04:50:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Richard Kojedzinszky" <richard@kojedz.in>
Cc: "Richard Kojedzinszky" <richard+debian+bugreport@kojedz.in>,
 linux-nfs@vger.kernel.org, 1071501@bugs.debian.org
Subject: Re: Linux NFS client hangs in nfs4_lookup_revalidate
In-reply-to: <EB269D8D-03FF-4ED1-B64C-E41B111B4AF8@kojedz.in>
References: <>, <EB269D8D-03FF-4ED1-B64C-E41B111B4AF8@kojedz.in>
Date: Mon, 27 May 2024 14:50:08 +1000
Message-id: <171678540815.27191.15492517697816891799@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[debian,bugreport];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Mon, 27 May 2024, Richard Kojedzinszky wrote:
> Dear Neil,
>=20
> I was running it on arm64, may that be the reason?

That could certainly explain it.  I know x86_64 almost never needs
barriers, though I have seen cases where they matter.  ppc64 is very
sensitive.  A quick search suggests that arm64 does need barriers some
times.
I don't have arm64 hardware to test on but I'm happy with your
test results.

Thanks,
NeilBrown


>=20
> Regards,
> Richard
>=20
>=20
> On May 27, 2024 4:02:32 AM GMT+02:00, NeilBrown <neilb@suse.de> wrote:
>=20
>     On Sun, 26 May 2024, Richard Kojedzinszky wrote:
>         Dear Neil,
>        =20
>         According to my quick tests, your patch seems to fix this bug. Coul=
d you=20
>         also manage to try my attached code, could you also reproduce the b=
ug?
>    =20
>     Thanks for testing.
>    =20
>     I can run your test code but it isn't triggering the bug (90 minutes so
>     far).  Possibly a different compiler used for the kernel, possibly
>     hardware differences (I'm running under qemu).  Bugs related to barriers
>     (which this one seems to be) need just the right circumstances to
>     trigger so they can be hard to reproduce on a different system.
>    =20
>     I've made some cosmetic improvements to the patch and will post it to
>     the NFS maintainers.
>    =20
>     Thanks again,
>     NeilBrown
>    =20
>    =20
>        =20
>         Thanks,
>         Richard
>        =20
>         2024-05-24 07:29 id=C5=91pontban Richard Kojedzinszky ezt =C3=ADrta:
>             Dear Neil,
>            =20
>             I've applied your patch, and since then there are no lockups. B=
efore=20
>             that my application reported a lockup in a minute or two, now i=
t has=20
>             been running for half an hour, and still running.
>            =20
>             Thanks,
>             Richard
>            =20
>             2024-05-24 01:31 id=C5=91pontban NeilBrown ezt =C3=ADrta:
>                 On Fri, 24 May 2024, Richard Kojedzinszky wrote:
>                     Dear devs,
>                    =20
>                     I am attaching a stripped down version of the little pr=
ogram which
>                     triggers the bug very quickly, in a few minutes in my t=
est lab. It
>                     turned out that a single NFS mountpoint is enough. Just=
 start the
>                     program giving it the NFS mount as first argument. It w=
ill chdir=20
>                     there,
>                     and do file operations, which will trigger a lockup in =
a few minutes.
>                =20
>                 I couldn't get the go code to run.  But then it is a long t=
ime since I
>                 played with go and I didn't try very hard.
>                 If you could provide simple instructions and a list of pack=
age
>                 dependencies that I need to install (on Debian), I can give=
 it a try.
>                =20
>                 Or you could try this patch.  It might help, but I don't ha=
ve high
>                 hopes.  It adds some memory barriers and fixes a bug which =
would cause=20
>                 a
>                 problem if memory allocation failed (but memory allocation =
never=20
>                 fails).
>                =20
>                 NeilBrown
>                =20
>                 diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>                 index ac505671efbd..5bcc0d14d519 100644
>                 --- a/fs/nfs/dir.c
>                 +++ b/fs/nfs/dir.c
>                 @@ -1804,7 +1804,7 @@ __nfs_lookup_revalidate(struct dentry=
 *dentry,=20
>                 unsigned int flags,
>                         } else {
>                                 /* Wait for unlink to complete */
>                                 wait_var_event(&dentry->d_fsdata,
>                 -                              dentry->d_fsdata !=3D NFS_FS=
DATA_BLOCKED);
>                 +                              smp_load_acquire(&dentry->d_=
fsdata) !=3D NFS_FSDATA_BLOCKED);
>                                 parent =3D dget_parent(dentry);
>                                 ret =3D reval(d_inode(parent), dentry, flag=
s);
>                                 dput(parent);
>                 @@ -2508,7 +2508,7 @@ int nfs_unlink(struct inode *dir, str=
uct dentry=20
>                 *dentry)
>                         spin_unlock(&dentry->d_lock);
>                         error =3D nfs_safe_remove(dentry);
>                         nfs_dentry_remove_handle_error(dir, dentry, error);
>                 -       dentry->d_fsdata =3D NULL;
>                 +       smp_store_release(&dentry->d_fsdata, NULL);
>                         wake_up_var(&dentry->d_fsdata);
>                  out:
>                         trace_nfs_unlink_exit(dir, dentry, error);
>                 @@ -2616,7 +2616,7 @@ nfs_unblock_rename(struct rpc_task *t=
ask, struct=20
>                 nfs_renamedata *data)
>                  {
>                         struct dentry *new_dentry =3D data->new_dentry;
>                =20
>                 -       new_dentry->d_fsdata =3D NULL;
>                 +       smp_store_release(&new_dentry->d_fsdata, NULL);
>                         wake_up_var(&new_dentry->d_fsdata);
>                  }
>                =20
>                 @@ -2717,6 +2717,10 @@ int nfs_rename(struct mnt_idmap *idm=
ap, struct=20
>                 inode *old_dir,
>                         task =3D nfs_async_rename(old_dir, new_dir, old_den=
try, new_dentry,
>                                                 must_unblock ? nfs_unblock_=
rename : NULL);
>                         if (IS_ERR(task)) {
>                 +               if (must_unlock) {
>                 +                       smp_store_release(&new_dentry->d_fs=
data, NULL);
>                 +                       wake_up_var(&new_dentry->d_fsdata);
>                 +               }
>                                 error =3D PTR_ERR(task);
>                                 goto out;
>                         }
>        =20
>    =20
>    =20
>=20
>=20
>=20


