Return-Path: <linux-nfs+bounces-21737-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJQ7Cy3VDWrW3wUAu9opvQ
	(envelope-from <linux-nfs+bounces-21737-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 17:37:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEED591084
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 17:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B389325B57B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C2A3F1656;
	Wed, 20 May 2026 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mStm48ZA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2303EFD09;
	Wed, 20 May 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290384; cv=none; b=EaVNvaaTFpLj6ySfdFWM7dkfhHvTF4VowyYQLKOTnvYV4VJdls7ECvjeNgO4BJ0e+3+/mGATY0XXp5fOwK9KRu0e3oRfv4CTRZxXuPS2ZyOAoIdbZNbZDB/Y6wFqoISS4dbzcAJO6CgOUDKCsn07bncswlVvPXH3gxX3vmL+ePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290384; c=relaxed/simple;
	bh=QbuHurJolm40SuhjKrQAoi1a0uHqKuCsWPkHXuRnzPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdbzzDI8PV6hepqj2G8EoqzmN4Pr1UT0EQNYExdrBMizravIVPEv/mNsmnEdbXEhrjPaQkm6QIj3toc5/E51LAeZSCXkjz+Cl+6l1UeQraB0ddKtKZEOxbAlY78H8K2pPUqYEzKivAIVGY/7T7WhC5+VGYvlsjzZZEPIxCUVgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mStm48ZA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B321F000E9;
	Wed, 20 May 2026 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290382;
	bh=SKlLMnJ6XwZt3J6bJSmk/KyrbFYsgZiHdqRy1LhGZy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mStm48ZA64TFmlBGgFUGASuP7rDGZSKzDqQ6oQMXNgYQKasznjw/TByE7Skt6v6ez
	 zMrUga1CQ9Ty3BNho/H0Hf5UGpRibLwObbh4f8rZAP5PH1Oknh/FR3Q4Png0aWlAUy
	 EHiVC8/86tiAVIyBYTzriOjOhw5utrJuvqaFg4vwupOE4WZ4++vi+mgbUIhGJeW0eF
	 HMiaCDS53uhjDub/wP8Fe4xGeaknBgWuG9mORkfsEksqb8/1bzfTSaKAso2+dgr+uL
	 +87FCquvPzEcHoqC/vN7no9H2Ytt8lvUD2/loMb9/vhomI1pwv2uKyQODY3K8Ae1sO
	 kBEntIue4/qWw==
Date: Wed, 20 May 2026 16:19:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	almaz.alexandrovich@paragon-software.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	frank.li@vivo.com, Theodore Tso <tytso@mit.edu>,
	adilger.kernel@dilger.ca, Carlos Maiolino <cem@kernel.org>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Hans de Goede <hansg@kernel.org>,
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: Re: [PATCH v14 03/15] fat: Implement fileattr_get for case
 sensitivity
Message-ID: <3a347b64-f91b-450f-b27d-26ea6810b960@sirena.org.uk>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
 <dc69224d-9926-4414-8c6e-4c15ae98705b@sirena.org.uk>
 <04302551-3628-4036-9a3f-596cb782f5b7@app.fastmail.com>
 <a366645c-364d-4588-8a15-4cd446f64366@sirena.org.uk>
 <8b750b3f-4d73-41f3-84fb-6e387fd24168@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u+vRDf5FOkNGBGm6"
Content-Disposition: inline
In-Reply-To: <8b750b3f-4d73-41f3-84fb-6e387fd24168@app.fastmail.com>
X-Cookie: Natural laws have no pity.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21737-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:url,sirena.org.uk:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2DEED591084
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--u+vRDf5FOkNGBGm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2026 at 11:12:51AM -0400, Chuck Lever wrote:
> On Wed, May 20, 2026, at 10:54 AM, Mark Brown wrote:

> > It's not testing tmpfs (well, it does but that passed), as the log above
> > shows it is making a vfat filesystem on a loop device backed by a file
> > that happens to be in a tmpfs and then testing that.  There's a bunch of
> > filesystems covered in this manner:

> OK. Is vfat the only failure in LTP statx04 ?

Yes, it's the only one showing as failing - there are four failures
correspoding to the four tests done for vfat.  It's only testing a
subset of filesystems (a combination of what the test knows about and
what's available at runtime with the kernel and rootfs.

Like I say there's a full log available at:

   https://lava.sirena.org.uk/scheduler/job/2778994#L6373

--u+vRDf5FOkNGBGm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoN0QUACgkQJNaLcl1U
h9AIUAf+LgplRZNkPtgBXXq2+Th5ZmpxAYp/cSjKVJT9Qz01BRcFXnVFnX85kJcz
h6LWts+TMPUOmwpWVFdLuJaglygNIiRS2+Q75Uj7B9Q5xSXddf5lIKzTxlH+XG7h
q+UEv3v2udkS83mi7e5HbtIcB4QH+8gY1f+M/Ck2G5Mx7eILoIDnnt6EkFA5XzmG
Jl0vQp4hcOKLPMOLgvSoRdoGP9a6EiGC74i62zqy49XP3OJsqXLsR0Bl6BWwjaf0
s+eYdBjT+4vTBvCI51HeLe6+k+D1tYOwpGoq6y+hG6NcMZ5Q/VOlpAzeNX0kYAMg
5VHI//a9dwjAaOsriq8CKDgEBolnqQ==
=CkZi
-----END PGP SIGNATURE-----

--u+vRDf5FOkNGBGm6--

