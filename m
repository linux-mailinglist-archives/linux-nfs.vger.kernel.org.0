Return-Path: <linux-nfs+bounces-16590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FB3C716A4
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 00:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFF134E10A2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 23:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B331ED7A;
	Wed, 19 Nov 2025 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="htVSVFS1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="paF1GhZ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B721CFFD
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593619; cv=none; b=eIYnyBAcHpWD9c6x8wC0nGpzmGQmy5rT7DIsKYx1tqpQwFlMPhndIGeLH6k3kkIEf0oGCqx1bJfNM6bb5+Qktmy2fFV7EUqY+YO6DJOuG/9phBBeNFkOOs9RVIJiCrBSB8IhTUhgeWb5R/ygOK8Cjb9xp7A5bKrAqnlNBVUK4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593619; c=relaxed/simple;
	bh=uJzUV7LeubBZRXA9INwU/4qavbM4qTE3Ynee3V4XUU4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=H7dx8yZ8y81ixFMF/6kcd1dBVnvT6owGaJOVKPC7/hM8QH7nHID1+Ils8BW9J0t1v3lITz3o5Go2WP4tQ43pFsUjIt4RasZkKFFcDvej979dvjS559H7O76YAP5+s9OAzce5iCNR+OHbTYo+c4mI7Nx7cMGLf/oI67oRPyTirdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=htVSVFS1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=paF1GhZ1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F3547EC00EF;
	Wed, 19 Nov 2025 18:06:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 19 Nov 2025 18:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763593615; x=1763680015; bh=HqF9oL7d22JLC897QJbP2WemzvoaLsOg+w6
	6eYt2Gnk=; b=htVSVFS17lIXlY02epY8cD7Sxy0lKTLNeZTRessgQRzBjrD8gLH
	WAO19YFFUF09ThKMqGCO2f79SmBRWXUibs6+GHxDlRJJdljMerW30NpSLSZXnjAr
	1Jui2xFekRKQTrZbYwvQYVMoYe+HKQqjsKXkFDo5dqKga14Xh3hgRZxN0KgsS9vZ
	tx6guC7zW7qfxj6DvFJ+9qbd106kW2ZBaqrc9qfYqQwv+djOF2E73jJdAlIoOOpd
	Xd5Yc66byR5+F0r7FCjgkWJ2p/9JKE8iVFg07EJYyPZf7RKdiMwiYeF0zVxYekFl
	giTCgRU9rNOE+vL2kkoOI2lL5SKpgPJOFTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763593615; x=
	1763680015; bh=HqF9oL7d22JLC897QJbP2WemzvoaLsOg+w66eYt2Gnk=; b=p
	aF1GhZ1w+wyHexZ7j2Mc8fuz/zUUJBSw24y8eE7JF5mUw2GtoarHmtmV+ZnwDHqe
	86foqQTJBumZUi7iMccYLzM9VFvve6CpjsBypj/xpkXXP8iRxaYUQy0OCK2NBWr1
	H9eLNcdqLO6RXCyb0d3RAYdFfMhAvYT973rqSMhvLr3Mp3BKvabT+HiXaiv6z4iR
	P3d6JKylmNaXWYi+7lXgZ7G2HMBA9tZSzJ3/aavRCfDmHh+19wSRxw2iPPCszMAH
	BJ6dsPxfozTAGz2Ir7+9OD1KhpnKyBOtLU7DJa8nXXP9P/HtGUXaiooRLl41CnaS
	krwYSBrW50Lo735XSRMeQ==
X-ME-Sender: <xms:j00eaX8JpgFfRoanqtbdR4DJ0pLRM7-WwOAZSIJwvgcLJFtPuHZRmQ>
    <xme:j00eaXZmv7qPVs9zzzGOdndhInphHyZD2NDOvFawyuWyi4N_m-nbO1OqB_9LFQJsW
    rZ3DRCoMi2lrwcclQBxvMG5FYxejf2bJxddwLqcQc5eOsjzYqQ>
X-ME-Received: <xmr:j00eae3-F4vmM-BzJPfIg66hInMxMgI6KQXTq_8uWX83nVaMUvddcEAlJCm3wcdjUI-Q9lvouAcrvLOYr0IZQIQrFenrnUtw3dz28uXO-hb4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j00eaaboqTTo9c_S81du-ulFvqUSYPXeGsDi8007tKAnrBmv0lKU0g>
    <xmx:j00eaeIB2-ayAXcCKINWdPOnmiakFtI6xj8GmmoXSHrDRwata4o0FQ>
    <xmx:j00eaRH4eFYIB_dHW78q3NSfTyXAVEPidGSLxom_M4JSTBveFLpFLw>
    <xmx:j00eadtbFfxnjtKuMEUmrSnCxSzdm7hgd9mitf90vnAS1SX9dJJjiw>
    <xmx:j00eaVcPijJrncvN8_oFef1LHsh9qhtc7aXdosZ6qNAtrNEhU5dJswXF>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 18:06:53 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, jlayton@kernel.org,
 linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Subject: Re: [PATCH] lockd: fix vfs_lock_test() calls
In-reply-to: <d1bc454f-bb51-4892-a8ae-bcef9bf23aa1@oracle.com>
References: <176351137459.634289.99556130353777712@noble.neil.brown.name>,
 <d1bc454f-bb51-4892-a8ae-bcef9bf23aa1@oracle.com>
Date: Thu, 20 Nov 2025 10:06:51 +1100
Message-id: <176359361186.634289.6568838479730641723@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 20 Nov 2025, Chuck Lever wrote:
> On 11/18/25 7:16 PM, NeilBrown wrote:
> > Usage of vfs_lock_test() is somewhat confused.  Documentation suggests
> > it is given a "lock" but this is not the case.  It is given a struct
> > file_lock which contains some details of the sort of lock it should be
> > looking for.
> >=20
> > In particular passing a "file_lock" containing fl_lmops or fl_ops is
> > meaningless and possibly confusing.
> >=20
> > This is particularly problematic in lockd.  nlmsvc_testlock() receives
> > an initialised "file_lock" from xdr-decode, including manager ops etc.
> > It them mistakenly passes this to vfs_test_lock() which might replace
>=20
> s/them/then
>=20
>=20
> > the owner and the ops.  This can lead to confusion when freeing the
> > lock.
> >=20
> > The primary role of the 'struct file_lock' is to report a conflicting
> > lock that was found, so it makes more sense for nlmsvc_testlock() to
> > pass "conflock", which it used for returning the conflicting lock.
>=20
> s/it/is
>=20
>=20
> > With this change, freeing of the lock is not confused and code in
> > __nlm4svc_proc_test() and __nlmsvc_proc_test() can be simplified.
> >=20
> > Documentation for vfs_test_lock() is improved to reflect its real
> > purpose, and a WARN_ON_ONCE() is added to avoid a similar problem in the
> > future.
>=20
>=20
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index a31dc9588eb8..381b837a8c18 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -627,7 +627,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_f=
ile *file,
> >  	}
> > =20
> >  	mode =3D lock_to_openmode(&lock->fl);
> > -	error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
> > +	locks_init_lock(&conflock->fl);
> > +	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
> > +	conflock->fl.c.flc_file =3D lock->fl.c.flc_file;
> > +	conflock->fl.fl_start =3D lock->fl.fl_start;
> > +	conflock->fl.fl_end =3D lock->fl.fl_end;
> > +	conflock->fl.c.flc_owner =3D lock->fl.c.flc_owner;
> > +	error =3D vfs_test_lock(file->f_file[mode], &conflock->fl);
> >  	if (error) {
> >  		/* We can't currently deal with deferred test requests */
> >  		if (error =3D=3D FILE_LOCK_DEFERRED)
>=20
>                         WARN_ON_ONCE(1);
>=20
>                 ret =3D nlm_lck_denied_nolocks;
>                 goto out;
>         }
>=20
>         if (lock->fl.c.flc_type =3D=3D F_UNLCK) {
> 	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                 ret =3D nlm_granted;
>                 goto out;
>         }
>=20
> Since vfs_test_lock() modifies conflock->fl.c.flc_type to contain an
> actual lock, should this check also be modifed to look at the returned
> lock (that is, conflock->fl.c.flc_type) instead of lock->fl.c.flc_type?

Yes, it should.  The following dprintk() should also reference
conflock rather than lock.


>=20
>=20
> > diff --git a/fs/locks.c b/fs/locks.c
> > index 04a3f0e20724..14dad411ef88 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -2185,13 +2185,18 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned=
 int, cmd)
> >  /**
> >   * vfs_test_lock - test file byte range lock
> >   * @filp: The file to test lock for
> > - * @fl: The lock to test; also used to hold result
> > + * @fl: The byte-range in the file to test; also used to hold result
> >   *
> > + * On entry, @fl does not contain a lock, but identifies a range (fl_sta=
rt, fl_end)
> > + * in the file (c.flc_file), and an owner (c.flc_owner) for whom existin=
g locks
> > + * should be ignored.  c.flc_type and c.flc_types are ignored.
> > + * Both fl_lmops and fl_ops in @fl must be NULL.
>=20
> I can't find a definition of the flc_types field referenced in this
> comment.

That is because I meant to type "flc_flags" and failed to proof read.

Thanks for the careful review!

NeilBrown

