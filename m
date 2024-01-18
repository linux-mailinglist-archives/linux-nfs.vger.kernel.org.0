Return-Path: <linux-nfs+bounces-1198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6248314FD
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 09:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C7EB27280
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jan 2024 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7961F60B;
	Thu, 18 Jan 2024 08:42:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DFA1F5F7
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jan 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567379; cv=none; b=WuXEX65oKOjT3ihtrnTXCtQzvjYVKeguzZCd6aiTjj52GXXhbM7FTzjN+cihkbEm/di0ESnZdu4A6ALSisP1xh/aVCTZ1NaVxyqQ6o6h+QY5lhqxcHqeKQBE5VHgzPI1uUZPlLlMqPMeAalcdMuGLnaTmodLrACHuuysEf5REGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567379; c=relaxed/simple;
	bh=tMU0E1Q78JCelu6nEjfXAqzABJfq+Qqbl14OCc6pEoU=;
	h=Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-SA-Exim-Scanned:X-PTX-Original-Recipient; b=IARDK0S+z7xFJPPQcNbEKCi1+kkOWBeACpW65vSl8cb5kCg39qwaKjInr/Bj4g6JKoLiow1LTJKBs7CGna2Q6mAadJk/haurln/4eGPFOc9J4NODMx7E/+j5sLrDNFkHz6zIq7gZyYlGX2m7tVRTMiDj1tN2qlHDmfJiiL+jWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rQNz2-0006qB-Ev; Thu, 18 Jan 2024 09:42:44 +0100
Message-ID: <3b4b548b5d7ede4632a113304cab38002f4aa2e1.camel@pengutronix.de>
Subject: Re: [PATCH] SUNRPC: use request size to initialize bio_vec in
 svc_udp_sendto()
From: Lucas Stach <l.stach@pengutronix.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna
 Schumaker <anna@kernel.org>,  linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, kernel@pengutronix.de,  patchwork-lst@pengutronix.de
Date: Thu, 18 Jan 2024 09:42:42 +0100
In-Reply-To: <ZahOmmMZxHcK8Amn@tissot.1015granger.net>
References: <20240117210628.1534046-1-l.stach@pengutronix.de>
	 <ZahOmmMZxHcK8Amn@tissot.1015granger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nfs@vger.kernel.org

Am Mittwoch, dem 17.01.2024 um 17:03 -0500 schrieb Chuck Lever:
> On Wed, Jan 17, 2024 at 10:06:28PM +0100, Lucas Stach wrote:
> > Use the proper size when setting up the bio_vec, as otherwise only
> > zero-length UDP packets will be sent.
> >=20
> > Fixes: baabf59c2414 ("SUNRPC: Convert svc_udp_sendto() to use the per-s=
ocket bio_vec array")
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  net/sunrpc/svcsock.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > index 998687421fa6..e0ce4276274b 100644
> > --- a/net/sunrpc/svcsock.c
> > +++ b/net/sunrpc/svcsock.c
> > @@ -717,12 +717,12 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
> >  				ARRAY_SIZE(rqstp->rq_bvec), xdr);
> > =20
> >  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> > -		      count, 0);
> > +		      count, rqstp->rq_res.len);
> >  	err =3D sock_sendmsg(svsk->sk_sock, &msg);
> >  	if (err =3D=3D -ECONNREFUSED) {
> >  		/* ICMP error on earlier request. */
> >  		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> > -			      count, 0);
> > +			      count, rqstp->rq_res.len);
> >  		err =3D sock_sendmsg(svsk->sk_sock, &msg);
> >  	}
> > =20
> > --=20
> > 2.43.0
> >=20
>=20
> I can't fathom why I would have chosen zero for the @count argument.
>=20
> We currently have zero test coverage for UDP. I'll look into that.
>=20
> I've applied this to the nfsd-fixes branch. It should appear in
> v6.8-rc if I can get it tested.

Thanks. For what it is worth, this fix didn't come out of pure code
inspection, but fixes a real world setup for me. While I can't claim
that I have any kind of comprehensive testing, this fix has at least
shown to fix the issue introduced in the referenced commit in my setup.

Regards,
Lucas

