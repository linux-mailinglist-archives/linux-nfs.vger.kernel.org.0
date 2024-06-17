Return-Path: <linux-nfs+bounces-3912-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159B090B44E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BAB1F276BE
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96E823B8;
	Mon, 17 Jun 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiMWeM6R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1955888;
	Mon, 17 Jun 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636440; cv=none; b=uawHQR3WNn5zUhroGoXZ4CUl7OucGo1aVuwyDAXEOkK2bbk4s1WRRC41wbPUe303BcJwbmNimy7SCgNagAAe30hI+r1M9VPVO+zUjX/5Zg02OLnfbLKXeFVDebPOT7fv48tO0B9bEylKnuwOEP3kyMEMP2L4ILePg/xvQcwDysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636440; c=relaxed/simple;
	bh=Aywd7px/c7iLV+UjorcRxEokFy5E5NP0tyd5xjHuLaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q44gakQTEg2faU7yE7Epu4sBzQw/Y99Tfcw6MAiWaYbCmFUrgUCmi3TuPegSA4jm7+K01GVkhmoHblVHZfEGq6egHQZcxPIhhsqqsgYJAw1VS3fbx7mxd9eSN1E7BTNTue8UL1B3Tqap9oTuj0xWZUAzMl4hepB2Pho4KPxUIvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiMWeM6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D72C2BD10;
	Mon, 17 Jun 2024 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718636439;
	bh=Aywd7px/c7iLV+UjorcRxEokFy5E5NP0tyd5xjHuLaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiMWeM6R2BBcTUjjxXjvxs/r5qOHWCfBPT8wFtoUBaSF6LstI5g88bcG1hRL1RMea
	 BR61Xw9NVTK9i1WUhF/e7BgP+a1Q75HN8AnM92lKg6srStzDOwlDy4mpv5ytu5rTrS
	 yBPw5BYGaspjUht0MV7+/aiSaMZHORU+9qljHeLTz2wWUJOJ3zNo/WDQuyswErNUQ2
	 kbJO+KLhm65mwnTQwiF7/4OkKdbqmsPbmaZePTisrToQSkY42vVTuhvjlFdhhT4HeV
	 YKfSTFoui5yTLGGCg2zxgmsMBJfDGp9EAzr1avsOFQdPMEDe8wgquP+3JJZNeC3EcW
	 lhpKZ2SRZWGwQ==
Date: Mon, 17 Jun 2024 17:00:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	syzbot <syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com>,
	Dai.Ngo@oracle.com, chuck.lever@oracle.com, kolga@netapp.com,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	neilb@suse.de, syzkaller-bugs@googlegroups.com, tom@talpey.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_get_doit
Message-ID: <ZnBPlMOpkLQghYR6@lore-desk>
References: <000000000000322bec061aeb58a3@google.com>
 <1e36e3c4e4ee1243716f0da5f451ea15993a7e82.camel@kernel.org>
 <20240617075129.7cb9ad1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1ty3sXepCl6puRsh"
Content-Disposition: inline
In-Reply-To: <20240617075129.7cb9ad1d@kernel.org>


--1ty3sXepCl6puRsh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 17 Jun 2024 06:15:25 -0400 Jeff Layton wrote:
> > We've had number of these reports recently. I think I understand what's
> > happening but I'm not sure how to fix it. The problem manifests as a
> > stuck nfsd_mutex:
> >=20
> > nfsd_nl_rpc_status_get_start takes the nfsd_mutex, and it's released in
> > nfsd_nl_rpc_status_get_done. These are the ->start and ->done
> > operations for the rpc_status_get dumpit routine.
> >=20
> > I think syzbot is triggering one of the two "goto errout_skb"
> > conditions in netlink_dump (not sure which). In those cases we end up
> > returning from that function without calling ->done, which would lead
> > to the hung mutex like we see here.
> >=20
> > Is this a bug in the netlink code, or is the rpc_status_get dumpit
> > routine not using ->start and ->done correctly?
>=20
> Dumps are spread over multiple recvmsg() calls, even if we error out
> the next recvmsg() will dump again, until ->done() is called. And we'll
> call ->done() if socket is closed without reaching the end.
>=20
> But the multi-syscall nature puts us at the mercy of the user meaning
> that holding locks ->start() to ->done() is a bit of a no-no.
> Many of the dumps dump contents of an Xarray, so its easy to remember
> an index and continue dumping from where we left off.

I guess we can grab the nfsd_mutex lock in nfsd_nl_rpc_status_get_dumpit() =
and get
rid of nfsd_nl_rpc_status_get_start() and nfsd_nl_rpc_status_get_done()
completely. We will just verify the nfs server is running each time the dum=
pit
callback is executed. What do you think?

Regards,
Lorenzo

--1ty3sXepCl6puRsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnBPkwAKCRA6cBh0uS2t
rJU6AP4/qoTvKK4+rSDICXPns833GyvFLUPcaq7cyWMdZnH+qwEA2+mR14t9GcuO
mgG+NgxPrwcR5HKnlYakyOKLOtZHYAk=
=e1pX
-----END PGP SIGNATURE-----

--1ty3sXepCl6puRsh--

