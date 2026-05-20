Return-Path: <linux-nfs+bounces-21734-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPkJNFXUDWrA3wUAu9opvQ
	(envelope-from <linux-nfs+bounces-21734-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 17:33:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7105B590F59
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 17:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1873A32603D6
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADBA3F0A9F;
	Wed, 20 May 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7BUquWM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B433EEAFC;
	Wed, 20 May 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288869; cv=none; b=DJF/yK+KwfC5m70AKXmeow85hMCdI2Ch4BNw5zhAHLLZSnWIEkvB9VeSPgJqAqcQ7UNvAZdQbKNOzengmaAHpVxF8MydFw+30c2Zs8DuUsMyR2YoOrNf0Jek92ZfVO2Kw7cKFFXBTgPDeOXq5NDVbg5f7IjGcrzxF70xBoVkdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288869; c=relaxed/simple;
	bh=0WleoVsSF6DIQ4jURo//cebjzvzH0LIBjYk+UIV2ExU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrE5zFNBDNNCnh8/w5H2XgwlcXfs0MSlIqdeqFnPacWtU37MjPciA96U/SUaWUHCxoLSf3tEw/9DSsVGa7kp0AyKtiWXqgQCyEbyCF5rlkw7lwtmMe286XZqi/F72oYA+DyP333M2rpl8yYBI6+mkOqXYtxO4BKrRvRzV2HXWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7BUquWM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB7C1F000E9;
	Wed, 20 May 2026 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779288868;
	bh=EF/z1JMTovCoIkUK08MjfWLNJEF3oJnTiZ8s4BwI6WM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i7BUquWM+GzT5Loj4HImvGnslZN5O8M76hxF3P2O8VdMkBcjjYYsc9lxCiB32ChOY
	 QTiXALcqjDaCzvkzU/TWUOt3ohN9IsADHPmSsfwrWoFYzew+zdoaogT9fcWPNJ4J0t
	 eQG2BymH3ar4vNyD7Gc10sgJd3MCnoDXgE9K+EwvALN9IJ4NfcMR6P51pVJKqWJfTi
	 YhUBFq7+6R6pmhANAI984Nq0GT5/gNr7d7kwojANpWIRN+qBGa9+lXENqEColGqqpe
	 SG9mMiVgXdhV4lrnhixs3HZXMU4xqXQjnPs9tBfxcYfBLdfakIuU4msHVIp3V5N/mI
	 ZIxBIGAwC8SUw==
Date: Wed, 20 May 2026 15:54:19 +0100
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
Message-ID: <a366645c-364d-4588-8a15-4cd446f64366@sirena.org.uk>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
 <dc69224d-9926-4414-8c6e-4c15ae98705b@sirena.org.uk>
 <04302551-3628-4036-9a3f-596cb782f5b7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pU7PWqZY3LH4C5oJ"
Content-Disposition: inline
In-Reply-To: <04302551-3628-4036-9a3f-596cb782f5b7@app.fastmail.com>
X-Cookie: Natural laws have no pity.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21734-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 7105B590F59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--pU7PWqZY3LH4C5oJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 10:39:16AM -0400, Chuck Lever wrote:
> On Wed, May 20, 2026, at 10:31 AM, Mark Brown wrote:
> > On Thu, May 07, 2026 at 04:52:56AM -0400, Chuck Lever wrote:

> > I'm seeing a regression in -next with the LTP statx04 test which bisects
> > to this commit:

> > tst_tmpdir.c:316: TINFO: Using /tmp/LTP_sta8hUyB4 as tmpdir (tmpfs=20
> > filesystem)
> > tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> > tst_test.c:2047: TINFO: LTP version: 20260130
> > tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc4-next-20260520 #1 SMP=
=20
> > PREEMPT @1779279361 aarch64

> > ...

> > tst_test.c:1985: TINFO: =3D=3D=3D Testing on vfat =3D=3D=3D
> > tst_test.c:1290: TINFO: Formatting /dev/loop0 with vfat opts=3D'' extra=
=20
> > opts=3D''
> > tst_test.c:1302: TINFO: Mounting /dev/loop0 to=20
> > /tmp/LTP_sta8hUyB4/mntpoint fstyp=3Dvfat flags=3D0
> > statx04.c:121: TFAIL: STATX_ATTR_COMPRESSED not supported
> > statx04.c:121: TFAIL: STATX_ATTR_APPEND not supported
> > statx04.c:121: TFAIL: STATX_ATTR_IMMUTABLE not supported
> > statx04.c:121: TFAIL: STATX_ATTR_NODUMP not supported

> At first blush, that does not seem like a plausible bisect
> result. This commit shouldn't affect the behavior of tmpfs
> in any way.

It's not testing tmpfs (well, it does but that passed), as the log above
shows it is making a vfat filesystem on a loop device backed by a file
that happens to be in a tmpfs and then testing that.  There's a bunch of
filesystems covered in this manner:

tst_test.c:1985: TINFO: =3D=3D=3D Testing on ext2 =3D=3D=3D
tst_test.c:1985: TINFO: =3D=3D=3D Testing on ext3 =3D=3D=3D
tst_test.c:1985: TINFO: =3D=3D=3D Testing on ext4 =3D=3D=3D
tst_test.c:1985: TINFO: =3D=3D=3D Testing on btrfs =3D=3D=3D
tst_test.c:1985: TINFO: =3D=3D=3D Testing on vfat =3D=3D=3D
tst_test.c:1985: TINFO: =3D=3D=3D Testing on tmpfs =3D=3D=3D

--pU7PWqZY3LH4C5oJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoNyxoACgkQJNaLcl1U
h9Bf5Af+J1m8FmGWQ4pg6JZgINs95lrmSIR+IAB+cWXhFfdVSNEDGOAuLHfZv+MG
SaPG/eW8tXyaC89iw3nCRtUSa8YdsvqtsHSfSjaMKADpqQWTNJXPDhuDUEVdnpHv
uSomYh27BJ3pHYuyjntZzSmA1ivMxF7WlODibQ4x+I51sFeOdBzk12V52swZUEpI
fFKR5JU6/v/dswn9lBdjXZ16wA+O1xgaEPJrsVA+KqNWwMawWAFloGsFbr7KNQIX
M87fQWJHn7S4o29asvaYlNpPIFdhYA3n9xKJln1PCGEDzBv1ICL6pHWifp4XRRlt
MTWwdW7SI6ptcJI5ML0CRUOPLAwWSA==
=dGWS
-----END PGP SIGNATURE-----

--pU7PWqZY3LH4C5oJ--

