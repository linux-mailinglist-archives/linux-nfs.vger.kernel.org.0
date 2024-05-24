Return-Path: <linux-nfs+bounces-3369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A98CE57A
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 14:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D5E2814A2
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA78614D;
	Fri, 24 May 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epqUt9Fz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4285926;
	Fri, 24 May 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554783; cv=none; b=vAK2gR2/i5kn/3H5jADo4vzghwUSyCwsTivu7Kor3IJt8LpTCSdQmopDYN0EkylvSCfRN7or27bPilPKgSK3Abt5fQAg5jUDuV9gJH3HyS/IKPAv3/t7W7MQVVN4BiB7NUylNGmVvB+I9KF+Csyzt3D8xu4m3OMFd2LAxBnEnQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554783; c=relaxed/simple;
	bh=1gi4lnGudCrcFgXh4eaVIF00UhXj/d1XqVRN9JQ/gws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eYZp3ufTEa8iM+Np85LFb9OVfHgyFp79drBgH3cqom9UYIAoBzzEVeFj1KyNnEHpVYIA5apC7GIFXOZHeD+7NPqoCA8MSQMxu0zIJCJtRJdMCtMQ97rMjlEjaqpMIMbKHtSDDj3Pie30+XuG0nbeinsBtjhCi63/adjg4+6IEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epqUt9Fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9F3C2BBFC;
	Fri, 24 May 2024 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716554783;
	bh=1gi4lnGudCrcFgXh4eaVIF00UhXj/d1XqVRN9JQ/gws=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=epqUt9FzPEsQ6w0RGC46GVHMLweQ0YHC0EbugGtcCIMAlc4yzrPLgyg/9iB0/jubg
	 05//wI0FOqkLr61X10fe6Nxr5bx4P8KGDD3JZuIrmaaOeqKUHo8KN/JqyMuBUcIT0g
	 dW4DiAAH/a8/TxgecFWdgzQVqG/rxz6p2au6MyZl9yQ6hysKSKxFNZMbiSdjqz1Mqk
	 uOtLcelMGPFzbj5NhscF+Md5oMIYAx1+PJUrsR4yRoKvlSkw7ngXmFzpiiC7z/QBKa
	 qGMQfIpXJ2YxpZtOqFfrPrhMjo8j9JnChaAE3tTOWUtb8akdiDV+WMvTakxD5d4lt8
	 kxSFKqzI7UcQg==
Message-ID: <8b52b6aa4376397cb2d71520e1c686318bcdecf9.camel@kernel.org>
Subject: Re: NFSD: Unable to initialize client recovery tracking! (-110)
From: Jeff Layton <jlayton@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Paul
 Menzel <pmenzel@molgen.mpg.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, it+linux-nfs@molgen.mpg.de, Linus Torvalds
	 <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 08:46:21 -0400
In-Reply-To: <90700421-4567-4e28-ae71-8541086b46e2@leemhuis.info>
References: <aaeae060-2be0-4b9f-818c-1b7d87e41a5f@molgen.mpg.de>
	 <e8ab863e-18a5-4c16-b0c8-a3ab6440a9f6@molgen.mpg.de>
	 <5096230634b5bab2e5094c0d52780ffe2fa75bb9.camel@kernel.org>
	 <90700421-4567-4e28-ae71-8541086b46e2@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 13:16 +0200, Linux regression tracking (Thorsten
Leemhuis) wrote:
> On 21.05.24 12:01, Jeff Layton wrote:
> > On Tue, 2024-05-21 at 11:55 +0200, Paul Menzel wrote:
> > > Am 19.04.24 um 18:50 schrieb Paul Menzel:
> > >=20
> > > > Since at least Linux 6.8-rc6, Linux logs the warning below:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 NFSD: Unable to initialize client recovery=
 tracking! (-
> > > > 110)
> > > >=20
> > > > I haven=E2=80=99t had time to bisect yet, so if you have an idea,
> > > > that=E2=80=99d be great.
> > >=20
> > > 74fd48739d0488e39ae18b0168720f449a06690c is the first bad commit
> > > commit 74fd48739d0488e39ae18b0168720f449a06690c
> > > Author: Jeff Layton <jlayton@kernel.org>
> > > Date:=C2=A0=C2=A0 Fri Oct 13 09:03:53 2023 -0400
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 nfsd: new Kconfig option for legacy client t=
racking
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 We've had a number of attempts at different =
NFSv4 client
> > > tracking
> > > =C2=A0=C2=A0=C2=A0=C2=A0 methods over the years, but now nfsdcld has =
emerged as the
> > > clear winner
> > > =C2=A0=C2=A0=C2=A0=C2=A0 since the others (recoverydir and the usermo=
dehelper upcall)
> > > are
> > > =C2=A0=C2=A0=C2=A0=C2=A0 problematic.
> > [...]
> > It sounds like you need to enable nfsdcld in your environment. The
> > old
> > recovery tracking methods are deprecated. The only surviving one
> > requires the nfsdcld daemon to be running when recovery tracking is
> > started. Alternately, you can enable this option in your kernels if
> > you
> > want to keep using the deprecated methods in the interim.
>=20
> Hmm. Then why didn't this new config option default to "Y" for a
> while
> (say a year or two) before changing the default to off? That would
> have
> prevented people like Paul from running into the problem when running
> "olddefconfig". I think that is what Linus would have wanted in a
> case
> like this, but might be totally wrong there (I CCed him, in case he
> wants to share his opinion, but maybe he does not care much).
>=20
> But I guess that's too late now, unless we want to meddle with config
> option names. But I guess that might not be worth it after half a
> year
> for something that only causes a warning (aiui).
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
> hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>=20

We simply changed the default in the Kconfig. That does not constitute
a regression, IMO. Why on earth would we continue to default enable an
option that we intend to deprecate in the near future?
--=20
Jeff Layton <jlayton@kernel.org>

