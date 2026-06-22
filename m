Return-Path: <linux-nfs+bounces-22771-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1nL5KKCjOWqNvwcAu9opvQ
	(envelope-from <linux-nfs+bounces-22771-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 23:05:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F446B2667
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 23:05:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I64pIvCw;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22771-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22771-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC09D300D964
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7253546E4;
	Mon, 22 Jun 2026 21:05:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58530F95C;
	Mon, 22 Jun 2026 21:05:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162334; cv=none; b=ZDtwP8zTTiegcPYtSMDwy8sqcmdvH1IqKWhImMs78+u+zkyS85eDJK/TuuWSBchFbtU+SnHNMQwf3vu5PZJHcpb6LLfXAgOr8KRrxFMv0ACBf/OQmOQZZ3arMLR9xaZdcNdw6ysNocvIs/NGIiZf7NLKlKzU5OgGoM19Bx7WF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162334; c=relaxed/simple;
	bh=I/qhOJ1X8HjPLRGYA99RgWO9vBmTJd6q/eXiHkunPdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbwPSPu2bvAz9EmQXVh624RTJGKwZdAjGuvN9UIE/BX3RpUvFcfatxow0aYdPGpEI64yyD/kHxyxlNRR7ZdTFTvBTRZG9PvHglVKuMtMR4eE5rknPlNjIfSJXwx4EEjyn1Bnd0zGZ4sbHxH+6iBRMiBoIP7CtI9RWEk6pAcCyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I64pIvCw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F851F000E9;
	Mon, 22 Jun 2026 21:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782162332;
	bh=hhf9Y265QiDCC7NNSucM+WKQWEr1odpnfDgWbh8jyt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I64pIvCwnakV9LifQMqxSQDoD6vEWomq8qg7t4Gpvf7QWo5crh5kzGc1LtWdlWJVB
	 butRXzJUOKnEnJX5DmYJ1J44QAzCzgFZ4BU9YlXMeDuCvfp1IAGb6hlMjxLYlDm7/2
	 +8LPthxJwlfci6Tze8kWjHs8VszR/DCo0Pxo1X58jYiF8v9IXquOcMWJ4JA2/V9YoG
	 QjVWuYBk2TCrG9AxZYM4omNF7yo7ZgW3JxnApG5O2sF7/hEe1Mx/QfAPov3D+lW2PW
	 Kkcf7Ozi3Xx/+vjtPI5FkPxHaAUWSR/wFhJF9TSUgIQ0pUFZ+MsX7jItzKFnjHBoiW
	 2kd5d4dWDI49Q==
Date: Mon, 22 Jun 2026 22:05:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/4] nfs: store the full NFS fileid in inode->i_ino
Message-ID: <0750912a-f8dc-4714-ae11-4592d2e8eca7@sirena.org.uk>
References: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
 <20260512-nfsino-v1-1-284720522f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TCs6laKQWpzo+XSI"
Content-Disposition: inline
In-Reply-To: <20260512-nfsino-v1-1-284720522f4c@kernel.org>
X-Cookie: To make an enemy, do someone a favor.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22771-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gitlab.freedesktop.org:url,sirena.org.uk:url,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2F446B2667


--TCs6laKQWpzo+XSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 12:12:42PM -0400, Jeff Layton wrote:
> Now that inode->i_ino is a 64-bit value, store the full NFS fileid in
> it directly instead of an XOR-folded hash. This makes NFS_FILEID() and
> set_nfs_fileid() operate on inode->i_ino rather than the separate
> nfsi->fileid field.

This patch is in -next now and is triggering a failure for in the LTP
ioctl10.c test for me on arm:

tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:2047: TINFO: LTP version: 20260130
tst_test.c:2050: TINFO: Tested kernel: 7.1.0-next-20260622 #1 SMP @1782128788 armv7l

...

ioctl10.c:111: TFAIL: q->inode (11493907226) != entry.vm_inode (4294967295)

arm64 seems unaffected, I didn't really investigate but I'll note that
unsigned long is 32 bit on arm.

Full log:

   https://lava.sirena.org.uk/scheduler/job/2904745#L3852

bisect log with more test job links:

git bisect start
# status: waiting for both good and bad commits
# good: [7f5d1580a3723e4ea89001a67a24d9f350e15c01] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good 7f5d1580a3723e4ea89001a67a24d9f350e15c01
# status: waiting for bad commit, 1 good commit known
# bad: [948efecf22e49aa4bf55bb73ec79a0ddcfd38571] Add linux-next specific files for 20260622
git bisect bad 948efecf22e49aa4bf55bb73ec79a0ddcfd38571
# test job: [3c54940fe511142cfe574022c3b703271982d64c] https://lava.sirena.org.uk/scheduler/job/2905311
# bad: [3c54940fe511142cfe574022c3b703271982d64c] Merge branch 'drm-next' of https://gitlab.freedesktop.org/drm/kernel.git
git bisect bad 3c54940fe511142cfe574022c3b703271982d64c
# test job: [80895ca480e9a42f961914ae5c947a66c130b344] https://lava.sirena.org.uk/scheduler/job/2905400
# good: [80895ca480e9a42f961914ae5c947a66c130b344] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
git bisect good 80895ca480e9a42f961914ae5c947a66c130b344
# test job: [2b8c085b832b07b3f7f3b7b7d06388920daf2a54] https://lava.sirena.org.uk/scheduler/job/2905436
# bad: [2b8c085b832b07b3f7f3b7b7d06388920daf2a54] Merge branch 'fs-next' of linux-next
git bisect bad 2b8c085b832b07b3f7f3b7b7d06388920daf2a54
# test job: [034e46edded1d4fc91f53c16c53f82b1c5908ca5] https://lava.sirena.org.uk/scheduler/job/2905486
# bad: [034e46edded1d4fc91f53c16c53f82b1c5908ca5] Merge branch 'linux-next' of git://git.linux-nfs.org/projects/anna/linux-nfs.git
git bisect bad 034e46edded1d4fc91f53c16c53f82b1c5908ca5
# test job: [5f03612db546bdffbcc1ebd343d055612948317c] https://lava.sirena.org.uk/scheduler/job/2905541
# good: [5f03612db546bdffbcc1ebd343d055612948317c] Merge branch 'for_next' of https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
git bisect good 5f03612db546bdffbcc1ebd343d055612948317c
# test job: [eb3dd8eb882bf0d1daacd0debc0f3e946a3ee1b8] https://lava.sirena.org.uk/scheduler/job/2905673
# good: [eb3dd8eb882bf0d1daacd0debc0f3e946a3ee1b8] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
git bisect good eb3dd8eb882bf0d1daacd0debc0f3e946a3ee1b8
# test job: [b1819a4e1d531b4b1d06405fbe73e5e20c402b53] https://lava.sirena.org.uk/scheduler/job/2905815
# good: [b1819a4e1d531b4b1d06405fbe73e5e20c402b53] ksmbd: sleep interruptibly in the durable handle scavenger
git bisect good b1819a4e1d531b4b1d06405fbe73e5e20c402b53
# test job: [17d90b68c3a3d7d7e95b49e1fe9381a723f637a8] https://lava.sirena.org.uk/scheduler/job/2906138
# bad: [17d90b68c3a3d7d7e95b49e1fe9381a723f637a8] sunrpc: fix uninitialized xprt_create_args structure
git bisect bad 17d90b68c3a3d7d7e95b49e1fe9381a723f637a8
# test job: [35168eb947f230aaa35fd8416a30563ef89f5421] https://lava.sirena.org.uk/scheduler/job/2906213
# bad: [35168eb947f230aaa35fd8416a30563ef89f5421] NFS: fix eof updates after NFSv4.2 fallocate/zero-range
git bisect bad 35168eb947f230aaa35fd8416a30563ef89f5421
# test job: [37957478be021b92981aa4c99b69f308d3b784d0] https://lava.sirena.org.uk/scheduler/job/2863766
# bad: [37957478be021b92981aa4c99b69f308d3b784d0] sunrpc: Fix error handling in rpc_sysfs_xprt_switch_add_xprt_store()
git bisect bad 37957478be021b92981aa4c99b69f308d3b784d0
# test job: [0e06a884f5ba6226829441bfc656ff9f5e9e90ac] https://lava.sirena.org.uk/scheduler/job/2863828
# bad: [0e06a884f5ba6226829441bfc656ff9f5e9e90ac] nfs: remove nfs_compat_user_ino64() and deprecate enable_ino64
git bisect bad 0e06a884f5ba6226829441bfc656ff9f5e9e90ac
# test job: [0cad7630425f4c9ee0dfa376ff8bf60c88ff2566] https://lava.sirena.org.uk/scheduler/job/2864357
# bad: [0cad7630425f4c9ee0dfa376ff8bf60c88ff2566] nfs: store the full NFS fileid in inode->i_ino
git bisect bad 0cad7630425f4c9ee0dfa376ff8bf60c88ff2566
# first bad commit: [0cad7630425f4c9ee0dfa376ff8bf60c88ff2566] nfs: store the full NFS fileid in inode->i_ino

--TCs6laKQWpzo+XSI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo5o5YACgkQJNaLcl1U
h9CHbgf9FMNNotRp41ZncwBjvptxlA7FxE/nC2tUeSu5VwfCC6KxshUtHeoMucaY
FMcIZRrfX7b77KrQ6dpZ7YxTlbEfQewqeRWe2VY5QLsr228Zg1t1ExtIOUsEfxkK
pXezP55kEmLAaxNk6AatRSZqaLPH5iYlrLzVquZCoUjFPXLWjX5s6Pku8FSteo7k
W04dHjdzU0br9R7PKo9A1ejIjx07LV8toIUbdJlANEnFdGWb+VFKZ57H7ELDMge3
FwFjW9qWaLBiuNXxjorhnoZZhQKLbykJvkJsy0HrdlX0DiiNPC8jQQaiBakUdtwa
TE12s06QN7CCZEZU6+FzmzpbuYOg0A==
=Su67
-----END PGP SIGNATURE-----

--TCs6laKQWpzo+XSI--

