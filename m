Return-Path: <linux-nfs+bounces-16795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 673EFC9431F
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 17:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A86C34E4268
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37821D590;
	Sat, 29 Nov 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf47+Pkj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607CB13A3ED
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432638; cv=none; b=NEuXRr/swB+bSBZP/tAHRpekZgg2E3f7zTk4poIcERqHLo+6OGaaZ3kcYnh+PliEyxr9Fpis2qrNyZrYjeRH0Y02A0rVQ3aBfIhA6qFUkPoiYGOd5mx7Kx4G1FBdYKBE6y78Nk6c230NtYgPesN82ETWxikK7af0LF+kc9f+vik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432638; c=relaxed/simple;
	bh=EYmq+Ombevs/STAqtX8au75mJ6f4c/Cynh9eO629cno=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YxpnYvlT7BnrWHQBTCyxB+HlCBvMWxuKIbWuSPuyWmO1zbCPN7R0N/ZvKuaetHrOJcwRpYA2mTkw65HbUZu7g4+gwpcrPQJSprN3aSRWifL5CveH6uJOU766Xe2oT1vVrNK/NMG1f1ytCmnOnrHmYIQNiV8heJBxv4r7VmTk4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf47+Pkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEF3C4CEF7;
	Sat, 29 Nov 2025 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764432638;
	bh=EYmq+Ombevs/STAqtX8au75mJ6f4c/Cynh9eO629cno=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=Bf47+Pkj4LII1zMM4phL0lRhbGwdt2uhDsR9HZLwv04hQlkjVtTPkXNqWVF+1Aggz
	 R1aUeRnxyMezBmwkYIvZq3BDVtpcFtoOpPeVhlkOhK/vmdN6mo9jW5He1ablpAqDby
	 iH9rqEVlMsAHSMAKIE/5v6Y512WlZ5RyuaY0nxDF5X/WhgdOfvGNqHZ+SwjhH6Xq7I
	 eWf/p0Zu/GwIQbnAnaB9vO6XouvxCxWBIqKb/V1mHGZVn+UcR/BTQgeIje8WBpHANd
	 sd9KBXLfmrZ/RnmYu8OsewcVFGiJsnKLB0rZ8tXTgPTdZv4mRM3OHZVLorC8YMLjXk
	 juPmPKCnXjQ6w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id AD50FF40082;
	Sat, 29 Nov 2025 11:10:36 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 29 Nov 2025 11:10:36 -0500
X-ME-Sender: <xms:_BoraV6aufXNkCaQLOPGlVeBRQDx8XDctxO4xRCsjWUYA7XlzoSiSw>
    <xme:_BoradsB7g4MdLcCPV8dYExLf8CjkknXanbSrdqfEOuJPoHHkqbc075ZQ7m9QlUFn
    rqq10lFf__mOBPsD3WMY2NQWGnH_QsLoPsgH7kR5XTl7pEY3rOCu0-3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epfedvheeftdefleethfffudduvdfhfeehffelffekveelheduhfegleekhfejleeknecu
    ffhomhgrihhnpeifihhkihhpvgguihgrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtg
    gvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegruhhrvghlihgvnhdrtg
    houhguvghrtgdvtddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhn
    fhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_BoraQlVNwW8YtgiMhxo3J--f20G27VsA8XA7ohFIAsuVng5HxuIcQ>
    <xmx:_BoradyTG0mrldfRgIkYg1tBdK1rFVfZIUCDp9mhAQpLhsXk5m3dwQ>
    <xmx:_BoraWMaLOjfd3S8Z3JxmUoT6pXOpNi-DztsHsMoTyGXIvXJWJSDvQ>
    <xmx:_BoraZQZWEX-qeN2QXp8jnsthDwcIWiSkStUnbF5w-6jN3xung8lCg>
    <xmx:_BoracaOgnXyUhd2GRcq4_Oe3GfBuuz_NIGfCQY_SQfY3w5M6myNlrU3>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6694A780054; Sat, 29 Nov 2025 11:10:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwX2CI0UG88J
Date: Sat, 29 Nov 2025 11:09:30 -0500
From: "Chuck Lever" <cel@kernel.org>
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>,
 linux-nfs@vger.kernel.org
Message-Id: <b4291551-4ce2-4305-86a1-85d307cc58e8@app.fastmail.com>
In-Reply-To: 
 <CA+1jF5pSBNUK7GBMcRqzfOB=NfWuVOQs8bxWsTV4_qxb18_3mA@mail.gmail.com>
References: <20251119005119.5147-1-cel@kernel.org>
 <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
 <aSMsb350kJgqysbz@morisot.1015granger.net>
 <CA+1jF5o5tiYfvqPKnf7_teMNOnOwig38epUywfsFLXsXVm=NmQ@mail.gmail.com>
 <49f3ae79-bbe1-470c-a247-68c942fc2f7d@app.fastmail.com>
 <CA+1jF5pSBNUK7GBMcRqzfOB=NfWuVOQs8bxWsTV4_qxb18_3mA@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, Nov 29, 2025, at 2:55 AM, Aur=C3=A9lien Couderc wrote:
> On Fri, Nov 28, 2025 at 4:44=E2=80=AFPM Chuck Lever <cel@kernel.org> w=
rote:
>>
>>
>>
>> On Thu, Nov 27, 2025, at 4:12 PM, Aur=C3=A9lien Couderc wrote:
>> > On Sun, Nov 23, 2025 at 4:46=E2=80=AFPM Chuck Lever <cel@kernel.org=
> wrote:
>> >>
>> >> On Sun, Nov 23, 2025 at 03:54:48PM +0100, Aur=C3=A9lien Couderc wr=
ote:
>> >> > On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.=
org> wrote:
>> >> > >
>> >> > > From: Chuck Lever <chuck.lever@oracle.com>
>> >> > >
>> >> > > An NFSv4 client that sets an ACL with a named principal during=
 file
>> >> > > creation retrieves the ACL afterwards, and finds that it is on=
ly a
>> >> > > default ACL (based on the mode bits) and not the ACL that was
>> >> > > requested during file creation. This violates RFC 8881 section
>> >> > > 6.4.1.3: "the ACL attribute is set as given".
>> >> > >
>> >> > > The issue occurs in nfsd_create_setattr(), which calls
>> >> > > nfsd_attrs_valid() to determine whether to call nfsd_setattr().
>> >> > > However, nfsd_attrs_valid() checks only for iattr changes and
>> >> > > security labels, but not POSIX ACLs. When only an ACL is prese=
nt,
>> >> > > the function returns false, nfsd_setattr() is skipped, and the
>> >> > > POSIX ACL is never applied to the inode.
>> >> > >
>> >> > > Subsequently, when the client retrieves the ACL, the server fi=
nds
>> >> > > no POSIX ACL on the inode and returns one generated from the f=
ile's
>> >> > > mode bits rather than returning the originally-specified ACL.
>> >> > >
>> >> > > Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail=
.com>
>> >> > > Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attr=
s")
>> >> > > Cc: Roland Mainz <roland.mainz@nrubsig.org>
>> >> > > X-Cc: stable@vger.kernel.org
>> >> > > Signed-off-by: Chuck Lever <cel@kernel.org>
>> >> >
>> >> > As said the patch works, but are there any tests in the Linux NFS
>> >> > testsuite which cover ACLs with multiple users and groups, at OP=
EN and
>> >> > SETATTR time?
>> >>
>> >> I developed several new pynfs [1] tests while troubleshooting this
>> >> issue. I'll post them soon.
>> >
>> > Thank you
>> >
>> > My point however was if pynfs can take a list of users@domain,
>> > groups@domain as input parameters, which are then used for
>> > FATTR4_OWNER, FATTR4_OWNER_GROUP, FATTR4_ACL and FATTR4_DACL tests.
>>
>> pynfs tests are not parametrized, but we can choose specific
>> combinations of arguments to exercise, and then add a new test
>> for each of those cases.
>
> OK. But this is a SEVERE and gaping black hole in the test coverage,
> because it prevents pynfs from properly testing FATTR4_OWNER,
> FATTR4_OWNER_GROUP, FATTR4_ACL and FATTR4_DACL.

Keep in mind that pynfs is a unit test suite meant to exercise
/basic/ NFS protocol behavior. Each unit test is typically just
as simple as it can be written. [1]

If we want parametrized tests that exercise the more advanced
features of ACLs, then IMHO that is not "unit testing", and
therefore it lies outside the scope of pynfs.

Generally large deployments build their own test suites that
target the specific features they need. There is nothing
stopping you from creating a suite of tests specific to NFSv4
ACLs <nudge nudge>.=20

Above, I see that you have included FATTR4_OWNER and
FATTR4_GROUP. What kind of interactions with ACL/DACL are you
thinking need to be explored?


> I think there should be parameters like that, and defaults such as
> pynfsuser1, pynfsuser2, pynfsgroup1 and pynfsgroup2

The new tests I've written (but haven't posted yet) use values
very much like your example defaults.


>> > Some of the ACL issues only happen for specific ACL combinations, t=
hus
>> > such two lists with parameter input would be useful.
>>
>> I have additional pynfs tests which aren't quite ready yet that
>> exercise the relationship between OWNER@, GROUP@, and named
>> principals.
>>
>> There are some complications with the NFSv4 <-> POSIX translation
>> adding a DENY ACE when it doesn't recognize that a named principal
>> is the same as OWNER@ or GROUP@. In that specific case a user can
>> set an ACL that locks the file owner out of the file unintentionally.
>
> Shouldn't OWNER@, GROUP@ priorise going into the uid and gid fields?

Can you elaborate on that?


--=20
Chuck Lever

[1] https://en.wikipedia.org/wiki/Unit_testing#Unit

