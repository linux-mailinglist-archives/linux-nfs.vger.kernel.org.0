Return-Path: <linux-nfs+bounces-7361-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D98A69AB0FA
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 16:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D5BB23B5C
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9E1A08CB;
	Tue, 22 Oct 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=s7mon@web.de header.b="fffrprqZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB71A0BEC
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607793; cv=none; b=c6hELcqAIGRBFDqH59aY7l4t4mu1jr5hWkTpTRP+YYWsfOCl2xc3bISF+kcTPkUwKzNaC4P7Jg3Li2vu8ksTdQ0pO/4oGtKK9ja5x2ukWmZMU5ll+Y6jazb6F8IjgCoS0xkM5V9diWis9wheNZ7HS05xllcYu2UzL8yrZBXP1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607793; c=relaxed/simple;
	bh=uNoWm2bkb2tdAQEpad79gnuaGvpaNJ+0hq0eVprze/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANjU/nU9F93Btt+dQcNfHqFq5LE0qzbKNoKOfiIro6J/5Rg0bv5q4OndY8FUrPTIXraX3sCM1t0XLVsc9ZK4IV58u7M/+jvdT5vHYaYQVzM8/1qwKT+Wb7NmgAgX0hR2v3Cbpyzwq3es6RxUkPeXMwTujDj/QPAbQ6xLKgljFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=s7mon@web.de header.b=fffrprqZ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729607781; x=1730212581; i=s7mon@web.de;
	bh=9lAPq7dzapP9CmeDqBb066DwhWxqMVQV9dqJWCNNN6w=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fffrprqZXY1o7en/b1hLxTUN1Oj/kd2pAgBHUQ5suLwWjWlhCzqefDtu7SD554sA
	 jRj1Ea9+KVL5CZ+Rd4nmmesUhMfQF0NXBLl5xz96N1ogHAzYxXFquMqdnNpP7J3PF
	 +OFXH4LFEEdm1cMRHHUVo+dGxuFuOeUOQZIqn0NscWjfKNhcfhNS+XIgHff5dRh4J
	 kgDQp5y0Hm2RgRTxAg8L2Th8CrFLeQ1dPJqd8t2DeI4DKSCqhR041Ksr0x4iqStAQ
	 m/xEAiBFYymu2AXK3FgeByao4c6LvP+nBTr6GQ4hbZ8C6HtvlFTsgPstqWBJHzEJt
	 23VS78PulcSzWxQfwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from jen ([217.86.124.131]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbTGt-1teEdo3Tk9-00bojY; Tue, 22
 Oct 2024 16:36:21 +0200
Date: Tue, 22 Oct 2024 16:36:21 +0200
From: "Patrick M." <s7mon@web.de>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs xprtsec conflicting with squashing
Message-ID: <20241022163621.29890b64@jen>
In-Reply-To: <1294ABC2-CFCB-4984-B286-A973627E70EB@oracle.com>
References: <20241022155047.0b73b6b3@jen>
	<1294ABC2-CFCB-4984-B286-A973627E70EB@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OLpjN7DtfW/Wo17R6QpRdqm6Sm96MPAvHZn5DdvXHOK2phiiRV9
 CrJdckum+AIfCb0sNzsD3C6dcy4CLps9rRcaRgHnTgw9doQI7puSvLiUFrZOr8HIbrvGA34
 uj4UGU1KkcIvyv3ACEL+JHOWLocBMtomr0as4KhiCwAPYXwo5uemyV518OMN0Q0KCbRmbD2
 PSbvV+EW9F1U6L4MomNNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N9owj6lgE4o=;2IEbFrS7WEGrg8EUBFvTjNjv6bT
 LayvQ71wi/q3/0QVwRn1MdG4285vZ1SRKNUZ078NBLjqNNLw+nnNwVeeb+Ep6kT77PVTb/QWl
 Gx5PWux+ZEpBd5Ku84p810av2yAYc97tvc3d4JqhMs4Hxe0cyujOje3p52bTgnEeVYcsqI2OO
 wbXhnzII6SgSjjHbn1pZ3DKQXPG4hhpFsq4WlhVNDzwzGQ/SyrF6SdVDVT0/IFlxMLQxWkuik
 HOr0V5Ez/4K0sZBR0LvbajOghJsuAUO82NBpcqy5TUyLBF6M0UlLSNkCrC9ISrIVxpXQfP5xG
 v/brcS4JvLRt6MVq3zryOriup3VyIJZpohWO85loLSD0JwI8kAIPAKXyUraWavkKM6WpkchYY
 NMfgCz0JtTAXcMgXm7kddKYT/R7GLxgX+tUAcxS0YCj0mh7EVPBkg8VKikAQpKv+bCyHy2QUB
 EAEgldKmkjWOq0ba/fnHlHnpoll5goqs9mVW4WUwjxqr07Uyf9bHvp/TPV14MEIPSm2FmcQmS
 CdEof7IPJi/g7Kq0cv86cR0skkFp70YAq3R7wTDnDhs09SfzuS9Y5s+mQpzCZ1Kmxf2nuunha
 qWnZOEeokVb7wY26b8nwA834M34OOqtQWmPBanvantd69Vy0SPSU7vbbBtcba49/nUuBdpHuz
 zW2ioZbXN2YKwyOxCraERGkA9/p/qAL3MPH2Y23CTh5e8iFkgFd0+4yfCztBopHuK9FWSNqCT
 zhCkzvdYxSCkw3L/UV10wC54F1dhK7/ZJBKVF/ywnyHn8ZnQdSzJ4wbkNUXWB1GUsfTWaZqrv
 5Q2ozhJ9Nqtu4uz5vSFn0kpw==

Hello,=20

will give it a try on 6.11 server side and raise a bug if it does not - wil=
l most likely not happen before tomorrow.
Thanks for the fast reply


On Tue, 22 Oct 2024 14:17:18 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > On Oct 22, 2024, at 9:50=E2=80=AFAM, Patrick M. <s7mon@web.de> wrote:
> >=20
> >=20
> > Hi there,
> >=20
> > tried switching to nfs with kernel TLS (mTLS to be specific).
> > Without xprtsec i was able to use the following options on exports
> >=20
> > "rw,async,all_squash,no_subtree_check,anonuid=3D1000,anongid=3D100,fsid=
=3D6,sec=3Dsys"
> >=20
> > but both the squashing/mapping-ids seems to conflict with TLS and i wan=
ted to understand if this is by intention or a bug. =20
>=20
> I don't expect breakage like this, so at least some further
> triage is needed. Can you open a bug on bugzilla.kernel.org
> under the Filesystem/NFSD component?
>=20
> You can also verify that this behavior recurs with a 6.11 (or
> later) kernel on your NFS server.
>=20
>=20
> > And if it is by intention of course why - because in my understanding a=
uth and encryption of the mount itself would not contradict with the mappin=
g functionality.
> >=20
> > I now use "rw,async,no_subtree_check,fsid=3D6,sec=3Dsys,xprtsec=3Dmtls"=
 and it is working. Using no_root_squash also seems to conflict.
> >=20
> > Keeping ID-Mapping i get this on client side
> >=20
> > mount.nfs: Operation not permitted for server:/mnt/target on /mnt/target
> >=20
> > And nothing i could relate as cause on server side (happy to provide sp=
ecific logs if needed, even with nfsd or rpc flags with rpcdump i could not=
 see a cause).
> > Tlshd showed also succes in both scenarios (handshake successfull) and =
i can use all options as well if i remove the xprtsec on server side.
> >=20
> > Client:
> > Linux 6.11.
> > nfs-utils-2.7.1
> >=20
> > Server:
> > Linux 6.5.52
> > nfs-utils-2.7.1
> >=20
> > Sorry if i missed this in documentation, if so i'd appreciate the hint =
where i should look in detail
> > and thanks for this feature!
> >=20
> >=20
> > --
> > best regards
> > Patrick M.
> >  =20
>=20
> --
> Chuck Lever
>=20
>=20



--=20
Patrick M=C3=BCnch <s7mon@web.de>

