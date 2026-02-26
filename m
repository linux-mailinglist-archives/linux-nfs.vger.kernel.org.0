Return-Path: <linux-nfs+bounces-19278-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L5wE5hboGm3igQAu9opvQ
	(envelope-from <linux-nfs+bounces-19278-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:41:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EAF1A7C33
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C591F3112A26
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486F42D8793;
	Thu, 26 Feb 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HivFPQb0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C02D7DD1
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116594; cv=none; b=Zd2vYz/Aomn+hZxKfQmIxmaLCv0y5lyfi0hUR3BSTcuyf2vRhfFyBertrlH15uchGcyqpEzybtRvB3AUBIDjCIS6gI+IR+3FQ3isigu5gr1csufFZVj9SHuOnypP1TG098d7SFRDIL0zRJabhRNLPMiYDrLBqopf2zrpiLbbyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116594; c=relaxed/simple;
	bh=NPyMOq48k5//ZvvVCoX9vnqSBNo7Qm67jOLpYdS86Ig=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uID7ZdSLpCn2b3dgnTsE/jj8Quj/qMFC60XtNKkh98FTcmxv/5JjrJZqXkozE0jp6SsqCpQqmwq4EVZHzghGVg0EZChaFs6FUx66OizzIGtI2wchMy++EYhUHXLqgV7/DKotOKDjaHllcQxzafaxjPkX7Hv7Ur0aYwmOwbusn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HivFPQb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC9DC19422;
	Thu, 26 Feb 2026 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116593;
	bh=NPyMOq48k5//ZvvVCoX9vnqSBNo7Qm67jOLpYdS86Ig=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HivFPQb0StvZKUmBje22rONFNJexpvvqdjJEfqqfRpwL6ys85rDSAHPOfIkiRI+kC
	 HAIJt/jihooIig5kiw50qkfDjMRkLovIpbpV6ClnHy8D3s6ZMn/TkMfha+ktfxAjsP
	 vHkJZ6f7TlQ32jfgOgHU9CcPhkB3P58QLj/Ucw697GevRVEkExxiazo/m6gxZSx3GD
	 m4YK03dv2eNATlexwUY9TCwJTdgcjVKYaed4bmiHU40/2p9Yv5ek1NGBDm2YLMb5+p
	 zsh5hiAi+6Skov99M2J8DMUWWiblm3jDhgM7ZijF4Nwcc9p1FHnhb4apqZ4WXcxzqR
	 qD4e7yDvH2gIg==
Message-ID: <ba2e136d81fd9f4b822a1ae6ba98baba699078dd.camel@kernel.org>
Subject: Re: xfstest failures depending on delegated_attributes on/off
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker
	 <anna@kernel.org>
Date: Thu, 26 Feb 2026 09:36:31 -0500
In-Reply-To: <CAN-5tyH0t39mysTaRE=5Do6HOABQ8YdHjs2kxhadXcWcVhC8ag@mail.gmail.com>
References: 
	<CAN-5tyH0t39mysTaRE=5Do6HOABQ8YdHjs2kxhadXcWcVhC8ag@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: multipart/mixed; boundary="=-Nw7dULIWZE5/xaogbT3b"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	MIME_BAD_ATTACHMENT(1.60)[gz:application/x-pcapng];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19278-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ATTACHMENT(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0EAF1A7C33
X-Rspamd-Action: no action

--=-Nw7dULIWZE5/xaogbT3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-25 at 14:57 -0500, Olga Kornievskaia wrote:
> Hi Jeff,
>=20
> The list of failures I see, on the kernel build from the following
> kernel tree (Chuck's nfsd-testing branch) (on vers=3D4.2, sec=3Dsys):
> commit 17081b01a9b6f0e7a31342cef03102d91733f1c2 (HEAD ->
> 02252026-nfsd-testing, origin/nfsd-testing)
>=20
> generic/221, generic/407, generic/728 (fail if delegated attributes
> are turned on and succeed otherwise). Do you see any of them?
>=20
> I'm currently investigating generic/751 but I've yet to determine if
> delegated attributes help or hurt there (but toggle makes things run
> (and fail) differently). After that I was planning to take a look at
> the others.

(cc'ing Olga's bug report to a wider audience)

Thanks for the bug report, Olga!

I started by looking at generic/221, and I suspect that there may be a
bug here on the client-side. I could use other eyes on this though.
Here is the strace of the program that it's running:

9234  creat("file", 0600)               =3D 3
9234  fstat(3, {st_dev=3Dmakedev(0, 0x38), st_ino=3D115480,
st_mode=3DS_IFREG|0600, st_nlink=3D1, st_uid=3D0, st_gid=3D0,
st_blksize=3D1048576, st_blocks=3D0, st_size=3D0, st_atime=3D1000000000 /*
2001-09-08T21:46:40-0400 */, st_atime_nsec=3D0, st_mtime=3D1772114154 /*
2026-02-26T08:55:54.240765990-0500 */, st_mtime_nsec=3D240765990,
st_ctime=3D1772114154 /* 2026-02-26T08:55:54.240765990-0500 */,
st_ctime_nsec=3D240765990}) =3D 0
9234  clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D1, tv_nsec=3D0},
0x7ffff9da2e50) =3D 0
9234  utimensat(3, NULL, [{tv_sec=3D1000000000, tv_nsec=3D0} /* 2001-09-
08T21:46:40-0400 */, UTIME_OMIT], 0) =3D 0
9234  fstat(3, {st_dev=3Dmakedev(0, 0x38), st_ino=3D115480,
st_mode=3DS_IFREG|0600, st_nlink=3D1, st_uid=3D0, st_gid=3D0,
st_blksize=3D1048576, st_blocks=3D0, st_size=3D0, st_atime=3D1000000000 /*
2001-09-08T21:46:40-0400 */, st_atime_nsec=3D0, st_mtime=3D1772114154 /*
2026-02-26T08:55:54.240765990-0500 */, st_mtime_nsec=3D240765990,
st_ctime=3D1772114154 /* 2026-02-26T08:55:54.240765990-0500 */,
st_ctime_nsec=3D240765990}) =3D 0

...and then eventually it closes the file when the program exits. The
ctime should change due to the utimensat() call.

I attached the capture. The network trace of the relevant part looks
like this:

No.	Time	Source	Destination	Protocol	Length	Info
611	08:55:54.238880	192.168.122.158	192.168.122.12
9	NFS	334	V4 Call (Reply In 612) OPEN DH: 0xf31a816b/
612	08:55:54.242641	192.168.122.129	192.168.122.15
8	NFS	446	V4 Reply (Call In 611) OPEN StateID: 0xafa9
614	08:56:08.806830	192.168.122.158	192.168.122.12
9	NFS	194	V4 Call (Reply In 615) SEQUENCE
615	08:56:08.808234	192.168.122.129	192.168.122.15
8	NFS	150	V4 Reply (Call In 614) SEQUENCE
617	08:56:29.287004	192.168.122.158	192.168.122.12
9	NFS	194	V4 Call (Reply In 618) SEQUENCE
618	08:56:29.287994	192.168.122.129	192.168.122.15
8	NFS	150	V4 Reply (Call In 617) SEQUENCE
619	08:56:29.288038	192.168.122.158	192.168.122.12
9	NFS	346	V4 Call (Reply In 621) SETATTR FH: 0xf31a816b
| DELEGRETURN StateID: 0xc2cb
621	08:56:29.290851	192.168.122.129	192.168.122.15
8	NFS	254	V4 Reply (Call In 619) SETATTR | DELEGRETURN

The server grants a WRITE_ATTRS_DELEG delegation on the OPEN and then
the client sets the delegated attrs and returns the delegation.

In the capture, the server sends the client an mtime/ctime of
1772113983:668837149 in the initial GETATTR after the create, but the
first fstat() of the file after the creat() shows the ctime to be later
than that. So, I think that is likely a bug.

Those times then don't change after utimensat() like they should, which
makes the test fail.

ISTM that the client needs to do an on the wire SETATTR call to set the
atime in this case, even though it has a delegation, or else the ctime
won't end up being correct.

The new delegated attributes don't give us a way to tell the server to
only update the ctime and not the mtime, unfortunately, which is what
we'd need to do to handle utimensat() properly.

Trond, Anna, thoughts?
--=20
Jeff Layton <jlayton@kernel.org>

--=-Nw7dULIWZE5/xaogbT3b
Content-Type: application/x-pcapng; name="nfs-generic221.pcapng.gz"
Content-Disposition: attachment; filename="nfs-generic221.pcapng.gz"
Content-Transfer-Encoding: base64

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


--=-Nw7dULIWZE5/xaogbT3b--

