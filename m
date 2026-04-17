Return-Path: <linux-nfs+bounces-20934-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLVGJefp4WmKzgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20934-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 10:05:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B9418619
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 10:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9D97308F064
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74EB3644D7;
	Fri, 17 Apr 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="wPO++JDk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2135DA52;
	Fri, 17 Apr 2026 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412734; cv=none; b=jUPam5nRIj6j9P0oXaH7SUYgkiR6VTqbRRr+/K6FXMTbs2aCAVq2Dc6Dy4PosR5OhsBpu++gsk4VXBQsqY+GnFxxsabhX15eHO8IOGbZMitnFcFsrbpR8b4kJZyasCQtW1OApgWKfnwpPkOmgKPjD8Bjqv2A7ygSqbnpUGop+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412734; c=relaxed/simple;
	bh=+A3VbckpOauq+yf7Ht+j7a+htmE685QM/RkahOX/pPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QddcRU5gbG8J7OocRDNe/Nq45yRIuCnAr8HBZeaHe62KVVWYDrfhDn3EJxbhirE20uXQdERi4hnj0of4Gaf7woExxZhcYSJfqKFbWOqk+5egA5vJ1jtTpnmfeZVl/jsqyMOKADzS6YBjplKlKl4TdML1Qtd80+9JNakmJ/uxuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=wPO++JDk; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fxnM43MYJz9vGr;
	Fri, 17 Apr 2026 09:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1776412720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+A3VbckpOauq+yf7Ht+j7a+htmE685QM/RkahOX/pPc=;
	b=wPO++JDkumEjlJT6NVA2Zuozsgd6C/RaFOUA4n59AC65YNHm6jFsN4af7bkrm2Qt6LI9ax
	NUTNB1PTeboTZ8sJvJPlbDjZUaaoE1eOiK7kbmmWkyD8om8mu8LoX70mh3XYD1yXqV9srF
	L4a6du7QZPATHJhVZLVGgdBvXzoMGrgPCvt8DV+TNyRhUrsSDWhOKTKZVScuytQMcHU8G4
	afypCdndFrIMNPG78c4/p6J553TUDIViN6/0/GkDjyJy/Pmu6ZcM07uswNad0l6S1mNb7O
	rphOmEmrluFzWmwASk6n0rq2ZdxcwysatTB5s89TCPa/+kZWjueb6jEEHAgXHA==
Date: Fri, 17 Apr 2026 17:58:07 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, 
	anna@kernel.org, sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, shuah@kernel.org, 
	miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
Message-ID: <2026-04-17-boiled-crisp-fiddles-router-N2oV0E@cyphar.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com>
 <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
 <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
 <2026-04-16-upstate-capable-deacon-petals-0l25lH@cyphar.com>
 <2059025134.378522.1776375762839@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="whhi6iyos3qbufli"
Content-Disposition: inline
In-Reply-To: <2059025134.378522.1776375762839@kpc.webmail.kpnmail.nl>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20934-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cyphar.com:mid,cyphar.com:email,cyphar.com:dkim,cyphar.com:url]
X-Rspamd-Queue-Id: 2A2B9418619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--whhi6iyos3qbufli
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
MIME-Version: 1.0

On 2026-04-16, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
>=20
> > Op 16-04-2026 17:15 CEST schreef Aleksa Sarai <cyphar@cyphar.com>:
> >=20
> >=20
> > Oh, I didn't notice that this wasn't mentioned here, we had a separate
> > discussion about it in a thread with Jori and I must've assumed we
> > discussed it in both. (My brain is also really not wired up to read
> > large octal values easily.)
> >=20
> > While it is hard to add new O_* flags (hence OPENAT2_REGULAR), it's not
> > /impossible/ (Jori has a patch for OPENAT2_EMPTY_PATH that is safe to
> > add to O_* flags because of some fun historical coincidences).
>=20
> But it would change userspace, at least in theory, right? If anyone for
> some reason decided to set whatever the bit will be for O_EMPTYPATH
> in a call to openat(), and pass an empty string, relying on this to fail,
> that will no longer be the case. But that is just really silly. Or are you
> hinting on something else?

Yes, such a program would break, but it is a fairly safe bet that no
such program actually exists in the wild. There is a limit to "never
break userspace" -- it actually needs to break a real userspace program
for it to matter.

Even then there are limits -- in theory someone could write a program
that would error out if any new flag is added to any syscall that
returns -EINVAL for invalid flags (in fact, we have selftests for
openat2(2) that would break because we test the error path) but it
wouldn't make sense to not add features to any syscall because such a
program could theoretically exist.

We change uAPI all the time, the trick is doing it so that userspace
doesn't notice.

For O_EMPTYPATH the logic is that programs that pass regular paths would
work the same way as they do now (i.e., LOOKUP_EMPTY semantics) and
programs that used to pass "" would previously get ENOENT -- it seems
quite unlikely anyone would depend on this for anything (they could
check if the string was empty themselves, after all) and it seems
astronomically unlikely that that they would pass garbage *and* depend
on it for anything.

(It is a little funky that open("", O_EMPTYPATH) would give you an fd to
"." but that makes more sense than the alternatives so let's just keep
it consistent.)

--=20
Aleksa Sarai
https://www.cyphar.com/

--whhi6iyos3qbufli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaeHoDxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG89LAEAr08pO6m6Ib2HnJibULb/
Rv4N2OOwlZeozJWh0YfxRXEA/2cqcMReUPBPAOSMYEzEGgQ/wpeH+YPOtfdsUCTX
gk8P
=Hooz
-----END PGP SIGNATURE-----

--whhi6iyos3qbufli--

