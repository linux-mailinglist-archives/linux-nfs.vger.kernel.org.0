Return-Path: <linux-nfs+bounces-17003-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E32CAE639
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 00:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 220F230133FF
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 23:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4F2D3EDE;
	Mon,  8 Dec 2025 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piBwp/83"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014EC217F31
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765235610; cv=none; b=LgRlwyO0R6nTXQUP+HI6zewg/q86mT9YlnZPSflofxGAL0Agk0Jq29abEQmJUJiR0fXan3Krn0RF+4l524Ab//if7d3pyiEvVQShHBh1Jee57EEXsAaqe0cxkgvtWyiw54lhokh9NFvBOLHRdXXi9hBNC4+6ipJcIE+1HCSLvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765235610; c=relaxed/simple;
	bh=0gyZOQd1ute22IE/oLLyleeo6G6kwWzKV4QBUFlxQFk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OwGORGElmtQp6qeHS4pHgkeve3zbdYGADjTBR++Swor080t3jzH6wLHH+uBqLoyBpH1JUqVl9WJuqj+T/qYuug1QpWb214GA/RrmUU4NCzRzie5Wb+RySIXhsMvU90qUFP+WMyurIKIxgYF4H6rsNVw3PjMSfyHWbxtKznNrROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piBwp/83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FDEC113D0;
	Mon,  8 Dec 2025 23:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765235609;
	bh=0gyZOQd1ute22IE/oLLyleeo6G6kwWzKV4QBUFlxQFk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=piBwp/83C15M8I+ZpMHWI3GwxWSSH5RoeegplsRa/0SfXamYZL0BR/0l89/7OmDPA
	 B7XyIF5NRiYqlE7YQzj3/xP4WGM4i/S3gpClAMo5VcEBS7RNh+0VZdcvlwR446O96g
	 dF9AmNQwvUNemM8kd6serJBn2FJcTacUpdQwNKHdQF2z3iLluF1jO4mcyfRl98qDbz
	 dhtOQ9gDxO+BLFIBb2kBAgxf6NaqvPNnyUMYfau+eD0MR3KCJVnTcQLNWYth90fRck
	 wqwex/VHauxXfFHAbJehKtVYKNEYaZ/7bdnyjvRtYfvKYuLrw3EPaqU/bH69b+VHif
	 Ud+2dc1QCD/tQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5F517F40084;
	Mon,  8 Dec 2025 18:13:28 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 08 Dec 2025 18:13:28 -0500
X-ME-Sender: <xms:mFs3aVnK8we8tPzJTfUe7zlV3W-L50qOiqXWuCXw2PjIriba1VKy8A>
    <xme:mFs3abrxM_5KREfT1chRriAYMjQaXSaeUvgkhrM8p-a0guVuKHLJE7yBq2km98cfV
    gd-VsEjxi2nd6__VyPukTdWU2wEreH4utyULt2CEcrabpbpFYQ4_bs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgffhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheplhhoghhhhihrsehhrg
    hmmhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohhk
    ohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhi
    drtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:mFs3ac69rOp4_PRR0YpAKA3CkfPqxq5Iuw-KAsNu852BVPvxYq9rpg>
    <xmx:mFs3aX4C5TAsW65XUcL7wZ_SJEB98c9wHy9_9X_jNGAIaf2YIgp7ZA>
    <xmx:mFs3aSHSJUrxHBXXpRJI4g08YaLMVSpSK8wzXfDaUHBli0ZypOPBuQ>
    <xmx:mFs3afUbCMKLk3ESyruekhqcqiF5sKWcf4uWbm7NpoxBGxQ2bcEXYQ>
    <xmx:mFs3aeVVMaWtgmGfLkGCHf5FvpNqiXys3snwI6sPJn0Oaf3kcpPOQONA>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3F68678006C; Mon,  8 Dec 2025 18:13:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A76hygnRXIHN
Date: Mon, 08 Dec 2025 18:13:03 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Thomas Haynes" <loghyr@hammerspace.com>
Message-Id: <1510f19f-6bfa-47c4-a7fb-0f6fa8f723a1@app.fastmail.com>
In-Reply-To: <176523482003.16766.5991961928943612885@noble.neil.brown.name>
References: <20251208194428.174229-1-cel@kernel.org>
 <176522973244.16766.13514511634601889702@noble.neil.brown.name>
 <ce9714c8-1558-4201-b3a5-bf73567282be@app.fastmail.com>
 <176523482003.16766.5991961928943612885@noble.neil.brown.name>
Subject: Re: [PATCH v1] NFSD: Use struct knfsd_fh in struct pnfs_ff_layout
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Dec 8, 2025, at 6:00 PM, NeilBrown wrote:
> On Tue, 09 Dec 2025, Chuck Lever wrote:
>>=20
>> On Mon, Dec 8, 2025, at 4:35 PM, NeilBrown wrote:
>> > On Tue, 09 Dec 2025, Chuck Lever wrote:
>> >> From: Chuck Lever <chuck.lever@oracle.com>
>> >>=20
>> >> In NFSD's pNFS flexfile layout implementation, struct pnfs_ff_layo=
ut
>> >> defines a struct nfs_fh field. This comes from <linux/nfs.h> :
>> >>=20
>> >> > /*
>> >> >  * This is the kernel NFS client file handle representation
>> >> >  */
>> >> > #define NFS_MAXFHSIZE           128
>> >> > struct nfs_fh {
>> >> >         unsigned short          size;
>> >> >         unsigned char           data[NFS_MAXFHSIZE];
>> >> > };
>> >>=20
>> >> But NFSD has an equivalent struct, knfsd_fh.
>> >>=20
>> >> To reduce cross-subsystem header dependencies, avoid using a struct
>> >> defined by the kernel's NFS client implementation in NFSD's flexfi=
le
>> >> layout implementation.
>> >
>> > linux/nfs.h appears to be mostly generic-nfs stuff, rather than bei=
ng
>> > client specific.
>> > If this change allowed us to remove "#include <linux/nfs.h>" from n=
fsd
>> > code, then it would be a good change, but I don't see that it does.
>>=20
>> This change is part of a longer series I'm working on that enables
>> the removal of linux/nfs.h from parts of the NFSD code base. The
>> other two spots that need attention are localio and server-to-server
>> copy. I'm not planning to do anything to localio.
>
> So why separate this patch out from the series?

Because the next part of the series focuses on improvements to the nfs_s=
sc.c
shim, and are thus quite independent from this simple change. I really d=
idn=E2=80=99t
want to post a long string of patches, and breaking this work up a bit m=
akes it
easier for folks to get their minds around.


>> > Now that "struct knfsd_fh" doesn't encode info about the fh format =
that
>> > knfsd uses, would it instead make sense to discard it and use "stru=
ct
>> > nfs_fh" throughout NFSD?
>>=20
>> Based on the effort I've already put into dealing with just ssc, I
>> think that would be a monumental change, and I'm not convinced it's
>> worth the cost.
>>=20
>> What's more, it would move in the wrong direction. Stapling the client
>> and server implementations together by using the same headers makes
>> the code more difficult to modify without touching both trees in a
>> rather invasive way.
>
> Are we planning to get rid of nfs2.h nfs3.h nfs4.h too?

Probably. The most troublesome header is uapi/linux/nfs.h, which
is included by fs/nfsd/nfsd.h. But the other three will conflict to
various degrees with the xdrgen-generated headers.


>> What I'm trying to do right at the moment is convert NFSD's NFSv2 and
>> NFSv3 implementations over to use xdrgen. Getting rid of linux/nfs.h
>> and other such dependencies is a firm pre-requisite for that.
>
> This might be useful content to put in the commit message, though not =
as
> useful as providing the whole series (once it is ready) - then we could
> see *why* there is that firm pre-requisite.

You=E2=80=99re overthinking this. There=E2=80=99s no reason not to make =
this change,
no matter the underlying rationale; but the patch description does
mention the header rat=E2=80=99s nest that motivated it.


> I think this current patch could only stand on its own if it removed t=
he
> #include of nfs.h from nfsd.h and added it just the those .c files whi=
ch
> still needed it.  That would make it more clear that progress was being
> made.

That=E2=80=99s something that could be done in a separate patch. This one
focuses on one simple change, as patches are supposed to do.


--=20
Chuck Lever

