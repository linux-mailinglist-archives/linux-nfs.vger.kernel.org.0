Return-Path: <linux-nfs+bounces-3471-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA38D3742
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 15:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821FA1F26822
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BD8E554;
	Wed, 29 May 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrN3eAo2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10095E542;
	Wed, 29 May 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988393; cv=none; b=OZgyNl5AswxnnwYxZyHQJEbfpYciStO6/I4Vs8f+tuA0Sa+CBtpcfgiyi6PnpY4WOfXeEAJA4vQ96WxPc/K3EDdznZZwooSNbXSc3+Sdq1CYqFUzqq4TAZLOAr9QxhCHlFMfUlRoN56MJZQa9DdO9Dn/2ui/J41VHrEzIOYfKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988393; c=relaxed/simple;
	bh=xvP+e8ct7DB37Hd+URoIjzPOHp6idykpf6CzoqVlzPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uG/oJOAyzLbqUzZZCzBJQuMq9SgLAhw9JQ4G6omHCy8GMNT7bVI+MT9FX+0hxjklfrDEP3xJceAOlTj2gUr5llpVtZra0Y/zwX+PRVPGI8iRBO1hlPuNgjjoW4uK6evP5ZFc5Tu4CfT4N9PFzituidfDidvNhKgT0q2FEUHcTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrN3eAo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23BBC2BD10;
	Wed, 29 May 2024 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716988392;
	bh=xvP+e8ct7DB37Hd+URoIjzPOHp6idykpf6CzoqVlzPs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GrN3eAo28PdRhOdrw1melL9Qml1N1Dgo27L34n/a1nOjWNb8fYWSD6CWwIwUKgs2l
	 Q2MRiK4Sd4fO2T6cSqccGrriohOOkXZWfNXH/jD9r8sdgAlzAzKTwycOtfXMPpSa/+
	 nQZdbYn5OpDvsXngDuYcszJVljKwMZYMWThxOrUHrSuvbe3ROqdCN7vlxN0bGRIt+P
	 1XmXL4TsqLGJmA2ea030bUBXaaMQtp3oRFVl5UPo+Ut1Mnt7cb0Nor3/egG7GBHfBk
	 U4RVyD7szPsnNdEKOZu9T37URkq5LRU43PvyNndHOh7p9DzL8qSlE2pY/XIzAXaKPM
	 VqPeTp9b4uq4A==
Message-ID: <fcec2a033773a2129e0271c870d1116681feccfb.camel@kernel.org>
Subject: Re: NFSD: Unable to initialize client recovery tracking! (-110)
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, "it+linux-nfs@molgen.mpg.de"
 <it+linux-nfs@molgen.mpg.de>, Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 May 2024 09:13:10 -0400
In-Reply-To: <5360A648-8236-466C-A9D8-82F2BBE6F059@oracle.com>
References: <aaeae060-2be0-4b9f-818c-1b7d87e41a5f@molgen.mpg.de>
	 <e8ab863e-18a5-4c16-b0c8-a3ab6440a9f6@molgen.mpg.de>
	 <5096230634b5bab2e5094c0d52780ffe2fa75bb9.camel@kernel.org>
	 <90700421-4567-4e28-ae71-8541086b46e2@leemhuis.info>
	 <5360A648-8236-466C-A9D8-82F2BBE6F059@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 16:09 +0000, Chuck Lever III wrote:
>=20
>=20
> > On May 24, 2024, at 7:16=E2=80=AFAM, Linux regression tracking (Thorste=
n
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >=20
> > On 21.05.24 12:01, Jeff Layton wrote:
> > > On Tue, 2024-05-21 at 11:55 +0200, Paul Menzel wrote:
> > > > Am 19.04.24 um 18:50 schrieb Paul Menzel:
> > > >=20
> > > > > Since at least Linux 6.8-rc6, Linux logs the warning below:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 NFSD: Unable to initialize client recovery tra=
cking! (-
> > > > > 110)
> > > > >=20
> > > > > I haven=E2=80=99t had time to bisect yet, so if you have an idea,
> > > > > that=E2=80=99d be great.
> > > >=20
> > > > 74fd48739d0488e39ae18b0168720f449a06690c is the first bad
> > > > commit
> > > > commit 74fd48739d0488e39ae18b0168720f449a06690c
> > > > Author: Jeff Layton <jlayton@kernel.org>
> > > > Date:=C2=A0=C2=A0 Fri Oct 13 09:03:53 2023 -0400
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 nfsd: new Kconfig option for legacy client track=
ing
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 We've had a number of attempts at different NFSv=
4 client
> > > > tracking
> > > > =C2=A0=C2=A0=C2=A0 methods over the years, but now nfsdcld has emer=
ged as the
> > > > clear winner
> > > > =C2=A0=C2=A0=C2=A0 since the others (recoverydir and the usermodehe=
lper
> > > > upcall) are
> > > > =C2=A0=C2=A0=C2=A0 problematic.
> > > [...]
> > > It sounds like you need to enable nfsdcld in your environment.
> > > The old
> > > recovery tracking methods are deprecated. The only surviving one
> > > requires the nfsdcld daemon to be running when recovery tracking
> > > is
> > > started. Alternately, you can enable this option in your kernels
> > > if you
> > > want to keep using the deprecated methods in the interim.
> >=20
> > Hmm. Then why didn't this new config option default to "Y" for a
> > while
> > (say a year or two) before changing the default to off? That would
> > have
> > prevented people like Paul from running into the problem when
> > running
> > "olddefconfig". I think that is what Linus would have wanted in a
> > case
> > like this, but might be totally wrong there (I CCed him, in case he
> > wants to share his opinion, but maybe he does not care much).
>=20
> That's fair. I recall we believed at the time that very few people
> if anyone currently use a legacy recovery tracking mechanism, and
> the workaround, if they do, is easy.
>=20
>=20
> > But I guess that's too late now, unless we want to meddle with
> > config
> > option names. But I guess that might not be worth it after half a
> > year
> > for something that only causes a warning (aiui).
>=20
> In Paul's case, the default behavior might prevent proper NFSv4
> state recovery, which is a little more hazardous than a mere
> warning, IIUC.
>=20
> To my surprise, it often takes quite some time for changes like
> this to matriculate into mainstream usage, so half a year isn't
> that long. We might want to change to a more traditional
> deprecation path (default Y with warning, wait, default N, wait,
> redact the old code).
>=20

I've no objection if you want to do that.

I'm more concerned about Paul's setup though. Paul, what distro are you
running that starts nfsd (and presumably, mountd, etc.), but doesn't
bother starting nfsdcld?

Reenabling this for now is an OK workaround, but we need to understand
where these setups are coming from, and probably do some sort of
outreach to get them working properly.
--=20
Jeff Layton <jlayton@kernel.org>

