Return-Path: <linux-nfs+bounces-21740-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBbEJgjyDWrA4wUAu9opvQ
	(envelope-from <linux-nfs+bounces-21740-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 19:40:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8880F5943DD
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 19:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71C7230C659A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B2B3DA7C6;
	Wed, 20 May 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWTGBYDv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724BD3A4526;
	Wed, 20 May 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297101; cv=none; b=T1QmHbarIKjV1XUrMOXEBYR+zvYDvyurc6N4u7xkGJim7Hm3/28aWArSCNkriZXAKHMvxPCnk6xRn2R0Oa6mhFq/lfB24JKEQxHQxBasN9szEqDdU3hJ/IpySOgDFoMAewAUefCJ+ROVIp5FyTgjynIhM/Gd7oapf3RElZVGoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297101; c=relaxed/simple;
	bh=O39Zt+/o25NInUTLPnA7MwAek+VGYIDTKbUnfn6XGAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bphyJpLLKndVG8LRMB0+YAk2nmBbNkH99vgNG6WpRiomNFgo1lI9011F/wyr6gIRpU/DqegKJXJcysbkfJn9bFLZcMbCRmDzox7CHXOD5w4J1PZ0gIF20g9+H0zjaeqvSaxse/uwsP//6hAHPhkf7V9LVJ+veiIGXgLqXm7mi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWTGBYDv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBD61F00893;
	Wed, 20 May 2026 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779297100;
	bh=nJlxEr28p9Wrfysl46M6wxmwbXDBzLidj8JAZWRJLZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VWTGBYDvx8dsrBdS7lq52/gOILFGnDV58m3XW1Q+mCYG+6Y/8FxRytZtar5qPxeY1
	 L7CkoB/m0HcvUyZqystgSu3ejRQHzlf6FBNJUSoAXSAc2UB4z/C/i1FyAPCmuyttq4
	 Gqapls6L2zXkkW6DBFuOjsLZ5xUUBTJSJH9yYyXZHyqidt29cfIy9ORcBBfh6OQCSW
	 fgRoiQ/AQPXO14Knyiq0Ye+EmqtYGfP5t1Tu7RNtdmi3NRO1OK0p6VvzEGBXbmJ1mj
	 e3ZbvKmeCLypR/EKw0FpHpXU1SXR0EcTcTUvrSp5V45EYolbGjuOcJJNWhNUWW9YRq
	 Sd/JI/+GCcThg==
Date: Wed, 20 May 2026 18:11:31 +0100
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
Message-ID: <cdeaab82-06bf-47c1-8f6c-4e40dbec2344@sirena.org.uk>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
 <20260507-case-sensitivity-v14-3-e62cc8200435@oracle.com>
 <dc69224d-9926-4414-8c6e-4c15ae98705b@sirena.org.uk>
 <04302551-3628-4036-9a3f-596cb782f5b7@app.fastmail.com>
 <a366645c-364d-4588-8a15-4cd446f64366@sirena.org.uk>
 <8b750b3f-4d73-41f3-84fb-6e387fd24168@app.fastmail.com>
 <3a347b64-f91b-450f-b27d-26ea6810b960@sirena.org.uk>
 <858d7233-1d9c-48f4-aa4f-c5a9f6e1f5dc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tQln6iCYcf5rHuVo"
Content-Disposition: inline
In-Reply-To: <858d7233-1d9c-48f4-aa4f-c5a9f6e1f5dc@app.fastmail.com>
X-Cookie: Natural laws have no pity.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21740-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8880F5943DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--tQln6iCYcf5rHuVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2026 at 12:58:22PM -0400, Chuck Lever wrote:
> On Wed, May 20, 2026, at 11:19 AM, Mark Brown wrote:

> > Yes, it's the only one showing as failing - there are four failures
> > correspoding to the four tests done for vfat.

> 03/15 adds .fileattr_get = fat_fileattr_get for both
> fat_file_inode_operations and vfat_dir_inode_operations. LTP
> opens a directory (SAFE_OPEN(TESTDIR, O_RDONLY|O_DIRECTORY)),
> so FS_IOC_GETFLAGS on the dir now succeeds, and statx04
> proceeds where it was previously skipped.

> AFAICS, 03/15 did not change pre-existing kernel behavior of
> stx_attributes_mask on vfat. It merely converted a "skipped"
> LTP outcome into an "executed but failed" outcome.

Ah, that's an interesting issue with the way the test reports.  LTP
could use nested reports a la TAP here so we're not just seeing the top
level failure from the test case in automation.

> Fix options:

> * fat_getattr() could call generic_fill_statx_attr(inode, stat),
>   which advertises KSTAT_ATTR_VFS_FLAGS (IMMUTABLE + APPEND).
>   That clears 2 of 4 TFAILs but not COMPRESSED/NODUMP, which
>   FAT genuinely does not back.

...

> * Admit the LTP statx04 test needs to be updated.
>   FS_IOC_GETFLAGS succeeding does not logically imply all four
>   FS_IOC_FLAGS-mapped STATX_ATTR_* bits are supported. The
>   test's gate is too coarse for filesystems that gained a
>   narrowly-scoped fileattr_get (just casefold/immutable). The
>   test's tag list pins it to filesystems that do support the
>   full set, but vfat was tacitly excluded by the prior ENOTTY.

I think this is needed, it's hardly the first LTP test to make
unwarranted assumptions about the kernel APIs.  I'll try to look into
it.

> The first option is the narrowest kernel-side change, and
> matches what other minimal-fileattr filesystems do.

That sounds like a good idea regardless of what we do with the test?

Thanks for looking into this so quickly and thoroughly.

--tQln6iCYcf5rHuVo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoN60IACgkQJNaLcl1U
h9CRlAf/RMdeVyBWIjD0QRVGjs6tYvEJEKs335pQHCWWjb8FC3Vy8ne6rai11oqb
qw3/Wa/DWeIpW9MohgelAnKgTWOV8FEvkOlbxIvB6XfmUDjSZynj+zXg/N32H/yP
22NwSpZdTC5HrvEOmH1/Kkiy/b0BBiUp5uUilSt9ZELtuG0OOp7QJuZ56owy+wAm
nBP+frSPGJ6AVK9zNGyGv2fAq9g+cZcCwx1mtjCkMcLPW6DJPjxu4N/AYFPIV9cN
yCnVDs2+7k84oDrHVUHURQyh6FykW/LQ69gUEWe+bfIicS+6/o/AhjA9UAW3x7Nc
duMMi6oG+fXnqrV6pqGDUSQPf5A47A==
=8ivj
-----END PGP SIGNATURE-----

--tQln6iCYcf5rHuVo--

