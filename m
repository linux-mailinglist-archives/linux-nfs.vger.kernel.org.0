Return-Path: <linux-nfs+bounces-19286-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPIdFGFjoGk0jAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19286-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 16:14:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B68E1A85FF
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 16:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09E4530297B2
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481423A1D13;
	Thu, 26 Feb 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV7liq61"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24028395D8A
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118343; cv=none; b=EO7y6L6GphV0m9S0Yq5wB8sUndrxae7oORZVRerUWKNYlo17aS776viin4Ge3g07T9nZn3SH490C2Cav6dDOFctPxN+jdYYJsx5IFe8JsRxxi5rvWBwayONlqk3DBRxuGg7nFmlxWoGoU1D8NtFTn6s6ctYETq1uv3qUFTwt5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118343; c=relaxed/simple;
	bh=US6jgr2qyg8B+/IXbkDBn3lX7u+pCZnRt66ZhC2Km2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rpdwURuwecHTKVYIzi1aQgws3tmZw2haRWJTis3MrHnhcmjQHB504MjXAUF41WCR0AFJDD9XKb87O5X4pn/eKllhMv8KfLoQVo0OKrdgvtsHurQRMDzbxe5onHkGyG8KUD5MvbdaY6puAbJq8DdfIGQgKJAJ0mwXqtnMZBhPxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV7liq61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50443C116C6;
	Thu, 26 Feb 2026 15:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772118342;
	bh=US6jgr2qyg8B+/IXbkDBn3lX7u+pCZnRt66ZhC2Km2Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kV7liq61Il7iz6qbyqsN0DBnABM4McF776BREr0SPQdl2TIDmEYoaCmNS7sZhsdVv
	 PdWLOSsodjCDJao6QfqaEyL9+En9YYCXKmFeBo83O2yQzJHSfplCPx6dNKISmTipGd
	 9gdkG4tP2rVtsBN+DjG34ue5NXeJ7IfQKQPO2+74qhZnVxfyZSMfoQx/jgN0Mz8+x5
	 oAElRNSy3eBpFr2QywskHokvTmnVhWNoZlcpP0pm7Vbsa5z4DwwO/YNbBPMmr6SHko
	 wGMnU+c8Xf4VqlP22VCL7rEyeH7FtYVF1o46Z53/1emueOUJ3aUDire7/2StmM6lSF
	 2vS6ytE8N378w==
Message-ID: <ce051694987719b387563ae2a91ab0f3a32a1e66.camel@kernel.org>
Subject: Re: xfstest failures depending on delegated_attributes on/off
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker
	 <anna@kernel.org>
Date: Thu, 26 Feb 2026 10:05:39 -0500
In-Reply-To: <CAN-5tyH0t39mysTaRE=5Do6HOABQ8YdHjs2kxhadXcWcVhC8ag@mail.gmail.com>
References:
	 	<CAN-5tyH0t39mysTaRE=5Do6HOABQ8YdHjs2kxhadXcWcVhC8ag@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19286-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B68E1A85FF
X-Rspamd-Action: no action

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

Sorry, meant to follow up on the others:

generic/407 passes for me with delegated timestamps. Can you look into
that one a bit more? generic/751 fails for me though. I suspect this is
a client-side bug too:

The REMOVEXATTR compound doesn't contain a GETATTR, so the client
doesn't update its timestamps after issuing one. The SETXATTR compound
does contain one, so one probably just needs to be added:

No.	Time	Source	Destination	Protocol	Length	Info
35	09:45:20.287193	192.168.122.158	192.168.122.129	NFS	362	V4 Call (Reply I=
n 36) OPEN DH: 0x60a9c780/testfile
36	09:45:20.292964	192.168.122.129	192.168.122.158	NFS	506	V4 Reply (Call I=
n 35) OPEN StateID: 0xafa9
38	09:45:22.387717	192.168.122.158	192.168.122.129	NFS	290	V4 Call (Reply I=
n 39) SETXATTR
39	09:45:22.390218	192.168.122.129	192.168.122.158	NFS	250	V4 Reply (Call I=
n 38) SETXATTR
41	09:45:24.518285	192.168.122.158	192.168.122.129	NFS	262	V4 Call (Reply I=
n 42) REMOVEXATTR
42	09:45:24.520337	192.168.122.129	192.168.122.158	NFS	186	V4 Reply (Call I=
n 41) REMOVEXATTR
44	09:45:44.550896	192.168.122.158	192.168.122.129	NFS	194	V4 Call (Reply I=
n 45) SEQUENCE
45	09:45:44.551913	192.168.122.129	192.168.122.158	NFS	150	V4 Reply (Call I=
n 44) SEQUENCE
46	09:45:44.552221	192.168.122.158	192.168.122.129	NFS	346	V4 Call (Reply I=
n 51) SETATTR FH: 0x559aaf9c | DELEGRETURN StateID: 0x33d9
48	09:45:44.553823	192.168.122.158	192.168.122.129	NFS	346	V4 Call (Reply I=
n 50) SETATTR FH: 0xc275dd69 | DELEGRETURN StateID: 0x674c

It looks like without delegated timestamps, the client does an on-the-wire =
GETATTR after the REMOVEXATTR:

No.	Time	Source	Destination	Protocol	Length	Info
197	09:58:19.129157	192.168.122.158	192.168.122.129	NFS	362	V4 Call (Reply =
In 198) OPEN DH: 0x60a9c780/testfile
198	09:58:19.133943	192.168.122.129	192.168.122.158	NFS	506	V4 Reply (Call =
In 197) OPEN StateID: 0xafa9
199	09:58:19.135941	192.168.122.158	192.168.122.129	NFS	306	V4 Call (Reply =
In 200) SETATTR FH: 0xb007cc80
200	09:58:19.138457	192.168.122.129	192.168.122.158	NFS	294	V4 Reply (Call =
In 199) SETATTR
202	09:58:21.233187	192.168.122.158	192.168.122.129	NFS	290	V4 Call (Reply =
In 203) SETXATTR
203	09:58:21.235414	192.168.122.129	192.168.122.158	NFS	250	V4 Reply (Call =
In 202) SETXATTR
205	09:58:23.367791	192.168.122.158	192.168.122.129	NFS	262	V4 Call (Reply =
In 206) REMOVEXATTR
206	09:58:23.369903	192.168.122.129	192.168.122.158	NFS	186	V4 Reply (Call =
In 205) REMOVEXATTR
208	09:58:23.406309	192.168.122.158	192.168.122.129	NFS	262	V4 Call (Reply =
In 209) GETATTR FH: 0xb007cc80
209	09:58:23.407822	192.168.122.129	192.168.122.158	NFS	266	V4 Reply (Call =
In 208) GETATTR
211	09:58:42.791073	192.168.122.158	192.168.122.129	NFS	194	V4 Call (Reply =
In 212) SEQUENCE
212	09:58:42.792068	192.168.122.129	192.168.122.158	NFS	150	V4 Reply (Call =
In 211) SEQUENCE
213	09:58:42.792464	192.168.122.158	192.168.122.129	NFS	282	V4 Call (Reply =
In 215) DELEGRETURN StateID: 0x2cd6
215	09:58:42.794509	192.168.122.129	192.168.122.158	NFS	230	V4 Reply (Call =
In 213) DELEGRETURN
217	09:59:03.270925	192.168.122.158	192.168.122.129	NFS	194	V4 Call (Reply =
In 218) SEQUENCE
218	09:59:03.272006	192.168.122.129	192.168.122.158	NFS	150	V4 Reply (Call =
In 217) SEQUENCE
220	09:59:03.273179	192.168.122.158	192.168.122.129	NFS	282	V4 Call (Reply =
In 221) DELEGRETURN StateID: 0xbbe2
221	09:59:03.275087	192.168.122.129	192.168.122.158	NFS	230	V4 Reply (Call =
In 220) DELEGRETURN

--=20
Jeff Layton <jlayton@kernel.org>

