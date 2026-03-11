Return-Path: <linux-nfs+bounces-20014-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEecM3D0sGlcpAIAu9opvQ
	(envelope-from <linux-nfs+bounces-20014-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 05:49:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDD125C0BE
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 05:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4F93100C9F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 04:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB7282F24;
	Wed, 11 Mar 2026 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="hwtIRhho"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA223ABA8;
	Wed, 11 Mar 2026 04:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773204585; cv=none; b=Zjvp2nLWcqKfs/TX/WDM94OYyswW+FDj4cxp4/vFk+l/mOD0QXilnpBLWPvsm9f5+wnxk3IjyTUouCa4rTL7x9oZINiOrH3Ewbc4iloftFsLx4wiInwOdzH8e9K2z/ZqCjEzyG81VONOKLZvZ9T7qnDX/Yu7+VJ2wnqSHbaArHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773204585; c=relaxed/simple;
	bh=luNAMKvhT3g6lZj4Bklpxcu5kotaBTWCH9qLtXuXCaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnwmYe85pn1HNnu89H9Fvq69Nc4LF9OQB8X87MS2x6qMbT0D4ctI+qm5Kx+EceOLDdSvJQIijM9mnR0LOvHdlUUJNoUzPfinNFr2w5K7ql9svynUBtTCGVawvhagAwj4bfNPV9WHdmOtCMWntU/9vHABiwBdgdh9rk92aK7vxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=hwtIRhho; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fVyvy3TbVz9v75;
	Wed, 11 Mar 2026 05:49:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1773204574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jack6TdkHfubMZXj3t4BiSmX904hWsygllpLop+Gf9w=;
	b=hwtIRhhoCxc2ZsNuUo0Icnvj7zQltMiaNclezRSyqc87wTc0wXe2NWtPTDDRE127dJXFTa
	MCvirHZh8IiINxf7jg7PTdJYtUuDmCcpUYG4NR+HXoSIAKzshND6dvUCboZ1QPiY129i0p
	vP6W/4Z8xKyvmGsmG0UVmuLtY8spR7CmaMu1rm8oyBUDj2N297M9U3vbYSmSuEgII2ps6v
	EoQvRCIKwWGE9t+rxwSll9E6aSdYeE3eYYrNzVXpC0e5YOEIKqsC4w1Amkj3lkkGAd7FSr
	N7xilzshuVk4hvo9TfDCZ4V5CdbP7DPW1inKdPlaPKLeY7uYE4a9QY7VVtwUug==
Date: Wed, 11 Mar 2026 13:48:47 +0900
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, 
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
Message-ID: <2026-03-11-regular-sore-census-shops-DqYcUT@cyphar.com>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com>
 <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
 <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bywgq3w2vtdgrqnx"
Content-Disposition: inline
In-Reply-To: <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
X-Rspamd-Queue-Id: 7BDD125C0BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20014-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amacapital.net,kernel.org,gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyphar.com:dkim,cyphar.com:url,cyphar.com:mid]
X-Rspamd-Action: no action


--bywgq3w2vtdgrqnx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
MIME-Version: 1.0

On 2026-03-09, Christian Brauner <brauner@kernel.org> wrote:
> > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > I think this needs more clarification as to what "regular" means,
> > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > >
> > > > Use-Case: this would be very useful to write secure programs that w=
ant
> > > > to avoid being tricked into opening device nodes with special
> > > > semantics while thinking they operate on regular files. This is
> > > > particularly relevant as many device nodes (or even FIFOs) come with
> > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I=
/O. Consider
> > > > implementation of a naive web browser which is pointed to
> > > > file://dev/zero, not expecting an endless amount of data to read.
> > > >
> > > > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > > > where that fd is a memfd?  What about files backed by non-"fast" di=
sk
> > > > I/O like something on a flaky USB stick or a network mount or FUSE?
> > > >
> > > > Are we concerned about blocking open?  (open blocks as a matter of
> > > > course.)  Are we concerned about open having strange side effects?
> > > > Are we concerned about write having strange side effects?  Are we
> > > > concerned about cases where opening the file as root results in
> > > > elevated privilege beyond merely gaining the ability to write to th=
at
> > > > specific path on an ordinary filesystem?
>=20
> I think this is opening up a barrage of question that I'm not sure are
> all that useful. The ability to only open regular file isn't intended to
> defend against hung FUSE or NFS servers or other random Linux
> special-sauce murder-suicide file descriptor traps. For a lot of those
> we have O_PATH which can easily function with the new extension. A lot
> of the other special-sauce files (most anonymous inode fds) cannot even
> be reopened via e.g., /proc.

Indeed, I see OPENAT2_REGULAR as a way of optimising the tedious checks
that userspace does using O_PATH+/proc/self/fd/$n re-opening when
dealing with regular files.

For the problem of stuck NFS handles and so on, an idea I've had on my
backlog for a long time was RESOLVE_NO_REMOTE that would block those
kinds of things. IMHO it doesn't make sense to block those things with
an O_* flag because (especially in the NFS example) directory components
can also cause the syscall to block indefinitely and so RESOLVE_* flags
make more sense for this anyway. But in my mind this is a separate
problem to OPENAT2_REGULAR.

--=20
Aleksa Sarai
https://www.cyphar.com/

--bywgq3w2vtdgrqnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCabD0LxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8NhAD+MfneuLAodU+abMZdkBr7
4vpiPGD5MeVFeZmtEvqdIWkBAJeNjed85hr2GgmqbPaY2CpOcPAXut4kYqaCB9lM
lHcK
=vDl9
-----END PGP SIGNATURE-----

--bywgq3w2vtdgrqnx--

