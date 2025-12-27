Return-Path: <linux-nfs+bounces-17317-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE16CDFD2D
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 15:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EDC9300C2A5
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 14:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC4772621;
	Sat, 27 Dec 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBtJSiey"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4754329408
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766845097; cv=none; b=FE1847Y3j3QQuSrBAGggxZt3GKnQe2aQBxeE6ubtAoIUEIYR42f/HA9Aqm5GpVc9d9fGEFRIBxdUPd1Kd92QKlY/6wU8IzpsZFCs4O4/8fc4Xf2+ZRGyzWNvMD8XlhvlmYKjXOdhhumNboOky6WmtyLwf19gu4grSvoZOD/Z2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766845097; c=relaxed/simple;
	bh=cVqPyy1Wlgi+dIQRekeFfiU4pzV/9i/mdbjFGPdgve8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VxhzH/rPb6T6WeXzap8NJdvMXIGNPRWCPb/DV8ms4pj1hgXJYGWRBS7ixUBKVtJHDySwKRUG+3w4t7Wo8NIayOxAp2vfvYuVOxbnOkqcIahW7ILSQUv6lE+bU/o5zVXYjeH6Y4hzyJerKbwAmwBel0q6T13P2WGKYtKW32oNDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBtJSiey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CEEC4AF09;
	Sat, 27 Dec 2025 14:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766845095;
	bh=cVqPyy1Wlgi+dIQRekeFfiU4pzV/9i/mdbjFGPdgve8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RBtJSiey1R52oTcjhv7SBrwzNpFTf8D4HAlNveY4UrrqoowKaIoUY3VhSRrcZ7E00
	 2cUdQbFTUIqaKt2BYtX3OxyKQ4EUPxP+8T031KLt+pB5WCBOChNmloT4evFNolMooU
	 l8OSJaGIm1iUrr1TCTAYLJs3K01m85od7kOz9f43hCU1XiOAuq597ReBvsA9n2uqci
	 XQTpX1l/Z25Fz9aVZG+yKxZ5lxq93w+4bVKr6ZNnz11nf0t9qBVf8DNJcOAL5LyJsl
	 wwBbpWV2Kd0DMuzMa86JDdDbNHz7GnFrgLKHpaAw76UFZFcPKxYLWZqBy6qNvPJq45
	 qsYLb7QTxfZ1g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 81C6DF40068;
	Sat, 27 Dec 2025 09:18:14 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 27 Dec 2025 09:18:14 -0500
X-ME-Sender: <xms:pupPaR6XfuEdRcN4Eqq5k1awauG34z7KkW4fgBl3t72doQetKzw91g>
    <xme:pupPaZsf4u0mwd_bOKNArECsLPAxgrDhZn1r-XQF9JABRNGvaBU1nBtbu4IhcyCnr
    PlxtcKdBmV42iGda9MXLgkH_Tco_mh3VXhi8VCErZPHRCIk66yS0six>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:pupPaXxPvoXJGtzsjPE6iVkGYAWnV-9hTI3HLFtakIC92otUgMMxDA>
    <xmx:pupPaf-tcEpcVjSQa1WrbFznBPjubkndTAyA9NHsanVmNG5HReE0ZQ>
    <xmx:pupPafgDFr_v2TAf43GFmEViRujZojTxt1D8u2PzQkEqU-jM8jIYrQ>
    <xmx:pupPaWHg3S59KRhqBP40VTlNz0ci8zf0T_kyJ2BEC-Off9Bv1ycLZg>
    <xmx:pupPae8KVreLNlPL8zBBN9GBhigEKsVqRYcAcG6I9gt-dl53i3fcCa0i>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 61F6C780054; Sat, 27 Dec 2025 09:18:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApgjDf8eaP8-
Date: Sat, 27 Dec 2025 09:17:54 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <45fe648f-6399-439f-afbe-83541133386b@app.fastmail.com>
In-Reply-To: <176679268968.16766.17613591475642801974@noble.neil.brown.name>
References: <20251226151935.441045-1-cel@kernel.org>
 <20251226151935.441045-4-cel@kernel.org>
 <176679268968.16766.17613591475642801974@noble.neil.brown.name>
Subject: Re: [PATCH 3/3] xdrgen: Add enum value validation to generated decoders
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Dec 26, 2025, at 6:44 PM, NeilBrown wrote:
> On Sat, 27 Dec 2025, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> XDR enum decoders generated by xdrgen do not verify that incoming
>> values are valid members of the enum. Incoming out-of-range values
>> from malicious or buggy peers propagate through the system
>> unchecked.
>> 
>> Add validation logic to generated enum decoders using a switch
>> statement that explicitly lists valid enumerator values. The
>> compiler optimizes this to a simple range check when enum values
>> are dense (contiguous), while correctly rejecting invalid values
>> for sparse enums with gaps in their value ranges.
>> 
>> The --no-enum-validation option on the source subcommand disables
>> this validation when not needed.
>> 
>> The minimum and maximum fields in _XdrEnum, which were previously
>> unused placeholders for a range-based validation approach, have
>> been removed since the switch-based validation handles both dense
>> and sparse enums correctly.
>
> This patch doesn't only update the code generation in xdrgen, it also
> runs xdrgen and updates the nfs4xdr_gen.[ch] files.  This results in
> changes to those files which I wasn't expecting to see based on the
> above - specifically the removal of semicolons, presumably due to a
> recent fix to xdrgen.
>
> I wonder if updates to generated files should also be separate patches?

It's an interesting review policy question.

The precedent I'm following here is that typically folks prefer that
when a new function is introduced, at least one call site is added,
in the same patch, that makes use of it.

So, when an xdrgen change is made, if it results in substantive
changes to the generated code, all code is regenerated and those
changes are committed in the same patch.


> Or at least the commit message could mention that xdrgen was not only
> changed, but it was run as well?

I will add some beef to the commit message before applying the
patch to nfsd-testing.


> In any case the changes look good and valuable.
>
> Reviewed-by: NeilBrown <neil@brown.name>
>
> Thanks,
> NeilBrown

-- 
Chuck Lever

