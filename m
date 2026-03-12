Return-Path: <linux-nfs+bounces-20054-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHU8LeCJsml4NQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20054-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 10:39:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE3326FB85
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 10:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26B9B304E7F7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 09:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989413BAD89;
	Thu, 12 Mar 2026 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="nEv3gFay"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA553B9DA5;
	Thu, 12 Mar 2026 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308298; cv=none; b=mYQ2MGCKJdaZsC3w9o14Jc63vPbjv66YGXOOgswutDFt2XM7bP8xG7P/Gcu+g4YsjYzQ92E28MBhOQ4PKcl7bb0rMV0zEqe17652F7nANTZVXUOT1MFr8PtIkPmq0N78QQvE5T535r5Bb5bxOopb5r+5yNxK+ix7DYHyHLJrpCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308298; c=relaxed/simple;
	bh=yFvK4TL7xsQGtUZ3aYppmkhAkjRmfVgtLz+/kUGSF4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoTDjW+2b/6M+rLWtnoBASnq/C+QZInu9NhP/L7NamTOriDy0Bre16+Nhui4zTqJ1RopJkYeKmmbuidc+FsAUMyl2FxYQ/KVqNT5ApVLbzHm7XkGek6r765DToEWGwK3plP0PShagDFtS1JlRF5ZwoB3dF5QkpW44Yhc5LCdnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=nEv3gFay; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fWjGL4f51z9tQg;
	Thu, 12 Mar 2026 10:38:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1773308282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4nPgKWUxbLSsXAZ7xnpvCJoD9xpuvM/yonZzi7ZuXE=;
	b=nEv3gFayAZ9w4Dp1cWiq1UcmZbr+AVxZWSDwTVJzyq2a7dTgA8EWt3TPcSPeAw3jej6OXW
	Pcy6WVyRafrQdwLnMhWua8km15WTIsPP2Egxk8ctZ2kwiHp04CE+ci72MIAnUbB2X3uFr2
	m9TbgCaTUcnFmJKSHe98mj5hqI3Qzay9DRe0Umfx2oh7eNC/jG4i1DJ1cS6QrP9wELYs37
	/9UaaXlTa5JuDMVGuxNl72vYPCySNn0PNn4gl11j4ufYX2X3WGume6qmtDEr6kyiwR0x9C
	cxiPW6KyqQRJuzfkOfZeC+MVhuRec3d3eJIEUNq8AGc2z7YeAIhaADmP9uHRBQ==
Date: Thu, 12 Mar 2026 18:37:10 +0900
From: Aleksa Sarai <cyphar@cyphar.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, 
	idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
Message-ID: <2026-03-12-naughty-cyan-tower-bats-CiRzU7@cyphar.com>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com>
 <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
 <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
 <2026-03-11-regular-sore-census-shops-DqYcUT@cyphar.com>
 <CALCETrVMF3VBr0cuEYOg-M_u+hX77Jfdujv3ZMtLGCzHgOcsGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i7hwymh2jbrl5osk"
Content-Disposition: inline
In-Reply-To: <CALCETrVMF3VBr0cuEYOg-M_u+hX77Jfdujv3ZMtLGCzHgOcsGA@mail.gmail.com>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20054-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amacapital.net:email]
X-Rspamd-Queue-Id: 6CE3326FB85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--i7hwymh2jbrl5osk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
MIME-Version: 1.0

On 2026-03-11, Andy Lutomirski <luto@amacapital.net> wrote:
> On Tue, Mar 10, 2026 at 9:49=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> >
> > On 2026-03-09, Christian Brauner <brauner@kernel.org> wrote:
> > > > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > > > I think this needs more clarification as to what "regular" mean=
s,
> > > > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > > > >
> > > > > > Use-Case: this would be very useful to write secure programs th=
at want
> > > > > > to avoid being tricked into opening device nodes with special
> > > > > > semantics while thinking they operate on regular files. This is
> > > > > > particularly relevant as many device nodes (or even FIFOs) come=
 with
> > > > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > > > expected from regular files backed by =E2=80=9Cfast=E2=80=9D di=
sk I/O. Consider
> > > > > > implementation of a naive web browser which is pointed to
> > > > > > file://dev/zero, not expecting an endless amount of data to rea=
d.
> > > > > >
> > > > > > What about procfs?  What about sysfs?  What about /proc/self/fd=
/17
> > > > > > where that fd is a memfd?  What about files backed by non-"fast=
" disk
> > > > > > I/O like something on a flaky USB stick or a network mount or F=
USE?
> > > > > >
> > > > > > Are we concerned about blocking open?  (open blocks as a matter=
 of
> > > > > > course.)  Are we concerned about open having strange side effec=
ts?
> > > > > > Are we concerned about write having strange side effects?  Are =
we
> > > > > > concerned about cases where opening the file as root results in
> > > > > > elevated privilege beyond merely gaining the ability to write t=
o that
> > > > > > specific path on an ordinary filesystem?
> > >
> > > I think this is opening up a barrage of question that I'm not sure are
> > > all that useful. The ability to only open regular file isn't intended=
 to
> > > defend against hung FUSE or NFS servers or other random Linux
> > > special-sauce murder-suicide file descriptor traps. For a lot of those
> > > we have O_PATH which can easily function with the new extension. A lot
> > > of the other special-sauce files (most anonymous inode fds) cannot ev=
en
> > > be reopened via e.g., /proc.
> >
> > Indeed, I see OPENAT2_REGULAR as a way of optimising the tedious checks
> > that userspace does using O_PATH+/proc/self/fd/$n re-opening when
> > dealing with regular files.
>=20
> Can you give a brief decription or a link to what these checks are and
> what problem they solve?

There are a few variations, but in this particular case they are just
doing fstat() and then checking whether the file is a regular file
(i.e., S_IFREG) or not.

A container rootfs can contain arbitrary files (because container images
are just tar archives, usually with no restrictions on inodes -- a fair
few container runtimes assume that the devices cgroup is sufficient to
protect against the container overwriting your rootfs). The S_IFREG
check avoids an administrative process from being tricked into opening a
block device or an endlessly-streaming FIFO -- if you also use
RESOLVE_NO_XDEV you can also make sure that you don't land on procfs or
sysfs by accident.

I will say that in a previous version of this patchset I said that I
would prefer this be done with an allow-bitmask of S_IFMT rather than a
single O_REGULAR toggle -- this would allow for usecases such as "only
open a regular file or directory" (inode_type_can_chattr() from systemd
is a practical example of this kind of usage) or "anything except for
block/char devices", but the definition of S_IFBLK (S_IFCHR|S_IFDIR)
makes this a little too ugly. :/

--=20
Aleksa Sarai
https://www.cyphar.com/

--i7hwymh2jbrl5osk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCabKJRRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+vawEA1WxGEhn5Rc+wid/VGVxs
yznMgHiA2Xe1m0YMiUy78u4BAJfditiWc61238EqwnDAWlH4X0xzDBvmXWOUuex3
vw0K
=3QVZ
-----END PGP SIGNATURE-----

--i7hwymh2jbrl5osk--

