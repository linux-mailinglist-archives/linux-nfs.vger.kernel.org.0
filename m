Return-Path: <linux-nfs+bounces-20857-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDnVKvLL4GkdmAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20857-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 13:45:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5763E40D9CB
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 13:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8555E30AFB0B
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903D3AF67A;
	Thu, 16 Apr 2026 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Efx22gDg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF82399345;
	Thu, 16 Apr 2026 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339727; cv=none; b=lWXfl1iRl/zo47RoV1YDVJ87FVMzxVfdiG+cGOBtA+AfCulkUud5hG1NFYl6q0IwDlWPH1dzYp6OoRiBmHS9nqFESGbBnbrzzlqRGk9IAeURNcSyUnGGwYP6qzIdj9miDeMQUiUkk6tTs6Li0XVWHyN/6PQapTnm4UfafmcOe6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339727; c=relaxed/simple;
	bh=q3t+BJxkXr+ZxgM2h5B9CO/tSr/WWi4WVN5HEqQFxqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5HEB6lQ7gl1BQXQEaqKxoypOXkLHkQLugnkGz5Zt0UcZ68osx5jNvXoi+sgHtXcD/fC/bjv9chZdqhYYSjrdskHQeHO06V4CKCQ9QlVZhIFwzKqTFUQBthu4CDkpGAq/Pun3+2ijjj+MwwITYSJhxS3DM8RIQqTdf3vUD/CLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Efx22gDg; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fxGLy35gqz9tyP;
	Thu, 16 Apr 2026 13:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1776339706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocUUntbXmmQloQOXTxlmrYLQwvM7r/1WClhRvHiQMzY=;
	b=Efx22gDgWgUgExobnRTIo2/TOPPsFYpyR/DVqOSJxLXMmaecgjnJzVRQNXGvXflS3JlEh0
	J90GgNUiRvKnF4cZBjoNRpEbwkr7AjObQbuAcNa2tUava0LpXKgBmZValW7dKFaNdpntBw
	jNN+VKwK6FopkuwCTKzWQ6wcbQ4XreY1j0dwRo4pm/P49DLtWqX0wQ3ml0rbjC3bXl2ixi
	rz5fSaMDElFxmYbgJf1Dc2jznngbuD8ooYL/bjprO8mI/xIbL7I2Yp0+F0OBRq2gXweuSD
	D/RwW2sT9gDXafGYsS1HSCmdvWMAMAbxv1QuMhgEY6ffcE+0a1qiS9KpgjWBLA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 16 Apr 2026 21:41:12 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, 
	idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
Message-ID: <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y4sat5dvbvjuuxwb"
Content-Disposition: inline
In-Reply-To: <20260328172314.45807-2-dorjoychy111@gmail.com>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20857-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amutable.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cyphar.com:mid,cyphar.com:dkim,cyphar.com:url,uapi-group.org:url]
X-Rspamd-Queue-Id: 5763E40D9CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--y4sat5dvbvjuuxwb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
MIME-Version: 1.0

On 2026-03-28, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being
> tricked into opening device nodes with special semantics while thinking
> they operate on regular files. This is a requested feature from the
> uapi-group[1].
>=20
> A corresponding error code EFTYPE has been introduced. For example, if
> openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> like FreeBSD, macOS.
>=20
> When used in combination with O_CREAT, either the regular file is
> created, or if the path already exists, it is opened if it's a regular
> file. Otherwise, -EFTYPE is returned.
>=20
> When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> as it doesn't make sense to open a path that is both a directory and a
> regular file.
>=20
> [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regular=
-files
>=20
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---

Aside from the nit below, feel free to take a

Reviewed-by: Aleksa Sarai <aleksa@amutable.com>

> diff --git a/fs/open.c b/fs/open.c
> index 681d405bc61e..a6f445f72181 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -960,7 +960,7 @@ static int do_dentry_open(struct file *f,
>  	if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
>  		f->f_mode |=3D FMODE_CAN_ODIRECT;
> =20
> -	f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> +	f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2_REGUL=
AR);

It's not clear to me why you dropped this, I didn't see a review
mentioning it either. (General note: Ideally the cover letter changelog
would mention who suggested a change in brackets after the changelog
line so it's easier to track where a change might've come from.)

I would personally keep it since O_DIRECTORY is not dropped (I do find
it interesting that O_EXCL is dropped too -- you could imagine a
userspace program wanting to know that the file was opened with O_EXCL,
though it provides you very little information).

--=20
Aleksa Sarai
https://www.cyphar.com/

--y4sat5dvbvjuuxwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaeDK2BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG+0aQEAmwzPPQPnvabbHhUf0fph
pJ6P46S5QXpATvNGjZyCr+8BAJ6lJf8lp5gf9hbdzip1EZghre/B+AfvsiTxQSXn
uF4A
=Z/uP
-----END PGP SIGNATURE-----

--y4sat5dvbvjuuxwb--

