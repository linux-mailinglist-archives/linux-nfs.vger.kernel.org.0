Return-Path: <linux-nfs+bounces-4297-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 981EB916D5E
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D1D1F21620
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ED416CD0A;
	Tue, 25 Jun 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGfY4+Fo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673432B9A9;
	Tue, 25 Jun 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330325; cv=none; b=SvGnDVl6zPYzyYBecQbj28ruEHlaqlW8arrccnM9tyhQ8hDih98ENTF+033igIY3qqxqklpa/pjPvzuvdq7lqwYPYV77JqIkGb+MLSNjKNfSr89D7zWDSXQUUewHu0RTxvELhL5TmyrRCqMJ8qyJ3vFeUmFzwFPCGx+ODw0A1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330325; c=relaxed/simple;
	bh=r+PRJWYLRDllectdaf+odPBtSiWRe1QMpN4EavcotQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=goQeRVJXIs0P77/P+CwqxcF/Y2hIhCW7OX7XWBLmnmpQQkIZccJ5XFqe7SBcEu4MaFCfvpajXarx8ENXh4PpjnLTL/HXl0qyuTZTZGTSWmc5lTtaYs3/kZo3MsG9OVmzNt1UgyLLzDuxVElxiTaRAAp+Vy6SsK0SwwmOkyD3TPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGfY4+Fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66A7C32786;
	Tue, 25 Jun 2024 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330324;
	bh=r+PRJWYLRDllectdaf+odPBtSiWRe1QMpN4EavcotQ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cGfY4+FoXqIA4FflNVh+ju8kaGymetI8fE6m+ky+14paDZ0yWrF21FTDL9O6WgD5r
	 1YNJWC/gaBOFQvw76e6wyI6lbW+PGBGoL7kOLwPaYU+yQwla8a5c7QtgaAweaoirl0
	 ETq7gxTbtExKx2S2bEWrrRuyznuqwTXMT3zpjofd7Zx0bdvFcxADCi9qwumnho3DGe
	 JpD9zDN4QRlsiigFpv5KRNep3lhf7XmCurp3DKIh64Eo0KfN1OdY9XYwUlr9sdCmM6
	 zu/EB/v1VXtc8tO22+bvC7hh7IixVJ0DLkPQsqcj5A8NEkccTiWhtY3kAiICUG13oT
	 INO+9mCOXdiFw==
Message-ID: <3afa32d75feeae84d894e7e71ce8e24372df78f3.camel@kernel.org>
Subject: Re: [PATCH 5.10 762/770] nfsd: separate nfsd_last_thread() from
 nfsd_put()
From: Jeff Layton <jlayton@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, NeilBrown
 <neilb@suse.de>,  Chuck Lever <chuck.lever@oracle.com>, Sasha Levin
 <sashal@kernel.org>, linux-nfs@vger.kernel.org
Date: Tue, 25 Jun 2024 11:45:22 -0400
In-Reply-To: <ZnjyrccU0LXAFrZe@codewreck.org>
References: <20240618123407.280171066@linuxfoundation.org>
	 <20240618123436.685336265@linuxfoundation.org>
	 <ZnjyrccU0LXAFrZe@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 13:14 +0900, Dominique Martinet wrote:
> Hi Greg,
>=20
> (+Jeff & linux-nfs in Ccs)
>=20
> Greg Kroah-Hartman wrote on Tue, Jun 18, 2024 at 02:40:15PM +0200:
> > [ Upstream commit 9f28a971ee9fdf1bf8ce8c88b103f483be610277 ]
>=20
> Playing with dyad in the 'vulns' repo, I noticed this commit got
> reverted in the 6.1 tree by pure chance as I just happened to test it
> on
> a related commit and wondered why the 6.1 kernel was listed twice:
> b2c545c39877 ("Revert "nfsd: separate nfsd_last_thread() from
> nfsd_put()"")
> db5f2f4db8b7 ("Revert "nfsd: call nfsd_last_thread() before final
> nfsd_put()"")
>=20
> See this thread for the discussion that caused that revert:
> https://lore.kernel.org/all/e341cb408b5663d8c91b8fa57b41bb984be43448.came=
l@kernel.org/
>=20
>=20
> What made me look is that they got in 5.10/15 (without revert):
>=20
> 5.10 tree (since v5.10.220)
> 838a602db75d ("nfsd: call nfsd_last_thread() before final
> nfsd_put()")
> d31cd25f5501 ("nfsd: separate nfsd_last_thread() from nfsd_put()")
>=20
> 5.15 tree (since v5.15.154)
> c52fee7a1f98 ("nfsd: call nfsd_last_thread() before final
> nfsd_put()")
> 56e5eeff6cfa ("nfsd: separate nfsd_last_thread() from nfsd_put()")
>=20
>=20
> I considered trying to revert them as well, but it looks like they've
> been fixed by this commit (upstream id):
> 64e6304169f1 ("nfsd: drop the nfsd_put helper")
> which wasn't in 6.1, so perhaps that's all there is to it and I'm
> worried too much?
>=20
> Jeff, you're the one who suggested reverting the two back then, sorry
> to
> dump it on you but do you remember the kind of problems you ran into?
> Is there any chance it would have gone unoticed in the 5.15 tree for
> 2.5 months? (5.15.154 was April 2024)
>=20

Sorry, I don't think I kept a record of that panic that I hit at the
time. I do think that I looked at the original bug report and it looked
like it was probably the same problem, but I don't remember the
details.

I think I just mentioned reverting them because I didn't see the
benefit in taking those into an old kernel. These are privileged
anyway, so even if they are bugs I don't seem them as particularly
critical.

> (Bonus question: if that is really all there is, would that make
> sense
> / should we take the commits back in 6.1 with that extra fix?)
>=20
>=20
>=20

Maybe? The problem is that someone has to do the testing for this.
These interfaces aren't currently part of any testsuite, so a lot of
that tends to be a manual effort.
=20
--=20
Jeff Layton <jlayton@kernel.org>

