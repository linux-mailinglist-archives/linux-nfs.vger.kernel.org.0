Return-Path: <linux-nfs+bounces-17014-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8BACB1460
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 23:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7242A309CC69
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Dec 2025 22:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4042DE6E6;
	Tue,  9 Dec 2025 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPD3DG2T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C92C236B
	for <linux-nfs@vger.kernel.org>; Tue,  9 Dec 2025 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765318410; cv=none; b=Rm45TgtkLAlcDRqR/n0BO/y8ssZE2jrM0q6CNBQVoCZUoFIf4ZB/NffQJiTit+Uo+AEn764mtmViwWU6NjnxjPIJAXCjowYuUae+fP2d6p0nvwmeESBqQB4Y4Cd8Mkdpz5jXjBbZ7kMuI7gQ7Zk0NmZj1XuWzoxkYbri5o/L384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765318410; c=relaxed/simple;
	bh=32CwDaSSNY3yEqJHWH6Gbvu4JHMll2ZaNlqX4fOJtTk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=W/sbTLO8zlZG99No0oQWKRdzz8TtBxaANotpLvWgAw/5qM/9rDs9mYqBJOGUwz3ra8LURsOZXQwsPL+KVORol/63yhrhmFpb8ylKpNNAQ/l7lKGMkO1JLCSNUf6C0SSRVVEj9lqlgpm3SUbngaPnQqPaCZH5QT44dhILUwjizFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPD3DG2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F92C4AF0B;
	Tue,  9 Dec 2025 22:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765318410;
	bh=32CwDaSSNY3yEqJHWH6Gbvu4JHMll2ZaNlqX4fOJtTk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FPD3DG2TiI8AHj5Sl7hUNX+AuRY1/ZpppJzKsdbDLEKtO063tLxJVxCtQTPKs1Dvg
	 RwHAQewNm7bdV3R9NqLZ6eco0xhnsDIX+8JKcp7S56/J7nOkWFE1rvnNh2ABRBsFY+
	 3KhBM8iJbjvAg7q5lPWhdJytcl5X3/BJFaZ3JhF21WYgXGVOHgdoJf3jU9ZTh47gZH
	 mcUTRH29s78cqJXz91KdkffwwxZL2ohaWCjTiEWdddD8vtJMWep8Ah+VnJFP8P6Crn
	 5Q74OqsycGLrz1ouQkmPWgwIIBgrx+8MerEhuCqt0cEXTXkHIhyGkIaLmcMNJ2twuN
	 MsgSr3ljuQiTA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4B51FF40070;
	Tue,  9 Dec 2025 17:13:29 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 09 Dec 2025 17:13:29 -0500
X-ME-Sender: <xms:CZ84adxlVlmttRbRn2vTWjue2bklcMNjHXPLiy9ULJ01ug6n0QQDlw>
    <xme:CZ84aYHaqzMkBkL-Kk6VObT6SrlHWgfcBX8j1w3pHyhNX2vYH-q3suPvCFKAhN060
    RbcgP2F3FUKikaNAlcsNIcVlflOr_9njWX1oWBlVZFxxw4PxDVScK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
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
X-ME-Proxy: <xmx:CZ84acH2af2U07_iD1PFUgGTFq8pxBCeYQ7t2nQ-bmSDy-LxvA87Fw>
    <xmx:CZ84afWTpGZiwHic6nsOHF7o_qEtfQAsP29UaUWnLqTLnbodTMJq3A>
    <xmx:CZ84acyrG5U17hj_9izMZSPkmIn13bV_oR4za9uTLTH-stcLDKbuHw>
    <xmx:CZ84acRr6YEuDiHdWp6OQHodIQ3-MbKObShLknogsfBj2GSMobRGhg>
    <xmx:CZ84aQhLqNqP33zcjNZGPtj9HRn7bS2j51s-pBVO4J2PcQz5sFKcTwJR>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 28A31780054; Tue,  9 Dec 2025 17:13:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A76hygnRXIHN
Date: Tue, 09 Dec 2025 17:13:08 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Thomas Haynes" <loghyr@hammerspace.com>
Message-Id: <d6640c19-5849-4e52-94be-ff5ce81756c8@app.fastmail.com>
In-Reply-To: <176531654526.16766.8587255373456590272@noble.neil.brown.name>
References: <20251208194428.174229-1-cel@kernel.org>
 <176522973244.16766.13514511634601889702@noble.neil.brown.name>
 <ce9714c8-1558-4201-b3a5-bf73567282be@app.fastmail.com>
 <176523482003.16766.5991961928943612885@noble.neil.brown.name>
 <1510f19f-6bfa-47c4-a7fb-0f6fa8f723a1@app.fastmail.com>
 <88a43961-144f-4e11-ab35-2957f00067e8@app.fastmail.com>
 <176531654526.16766.8587255373456590272@noble.neil.brown.name>
Subject: Re: [PATCH v1] NFSD: Use struct knfsd_fh in struct pnfs_ff_layout
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Dec 9, 2025, at 4:42 PM, NeilBrown wrote:
> On Tue, 09 Dec 2025, Chuck Lever wrote:
>> 
>> On Mon, Dec 8, 2025, at 6:13 PM, Chuck Lever wrote:
>> > On Mon, Dec 8, 2025, at 6:00 PM, NeilBrown wrote:
>> >> On Tue, 09 Dec 2025, Chuck Lever wrote:
>> >>> On Mon, Dec 8, 2025, at 4:35 PM, NeilBrown wrote:
>> >>> > Now that "struct knfsd_fh" doesn't encode info about the fh format that
>> >>> > knfsd uses, would it instead make sense to discard it and use "struct
>> >>> > nfs_fh" throughout NFSD?
>> >>> 
>> >>> Based on the effort I've already put into dealing with just ssc, I
>> >>> think that would be a monumental change, and I'm not convinced it's
>> >>> worth the cost.
>> >>> 
>> >>> What's more, it would move in the wrong direction. Stapling the client
>> >>> and server implementations together by using the same headers makes
>> >>> the code more difficult to modify without touching both trees in a
>> >>> rather invasive way.
>> 
>> OK. If we want to go the other way (replace knfsd_fh with nfs_fh
>> throughout NFSD) then I'd rather keep only the struct and the
>> CRC hash function in a single header to avoid pulling in a lot
>> of junk that only a few consumers need.
>
> This thing that I keep thinking of the is "enum nfs_stat".  I don't
> think we want two copies of that in the kernel.  It is currently in
> uapi/nfs.h and so in nfs.h

Yes, and fs/nfsd/nfsd.h defines a bunch of little-endian
equivalents too. There are already multiple copies. Eventually
there should be Only One (tm), and I'd like that one to be
defined directly by the protocol specification.


>> However there is still the problem of how large to make the
>> structure's data field. Right now it's NFS4_FHSIZE, but that means
>> you have to somehow include the header that defines NFS4_FHSIZE,
>> and that pulls in a lot more stuff than we really need or want.
>> It's difficult to separate the file handle structure from the rest
>> of the protocol.
>
> "128".
> I don't think this *needs* to be NFS4_FHSIZE (though it will have the
> same value).
>
> #define NFS_MAXFHSIZE		128
>
> works for me.

Note that lockd uses "struct nfs_fh" as well, but in this case, the
128 bytes is overkill because NLM uses NFSv2 and NFSv3 file handles
only, which are 64 bytes at most.

I might be inclined to define an nlm_fh for this purpose.


>> NFS3_FHSIZE, for instance, would be defined in both linux/nfs3.h
>> and include/linux/sunrpc/xdrgen/nfs3.h .
>
> Ok, I think this might be getting close to a central issue.
> I think you want the .x file to become the source for all the various
> constants and types with the generated .h files included where needed
> and, significantly, any existing .h files which define the same name NOT
> included in those places.
>
> That sounds like a good long-term goal, but it isn't clear to me that we
> want to jump straight there.
>
> In the first instance, I think the main value of generating code from
> xdr is the code - not the declarations.

I don't agree with that. The .h files contain:

- Protocol definitions, using the same names as the RFC
- Function declarations for encoder and decoder functions
- Size constants for each on-the-wire data item for buffer
  length computations

IMO the .h files add critical value to the generated code. It's
boilerplate code that is straightforward to machine-generate in
either a C flavor or a Rust flavor, and human coders can get these
wrong.


> What barriers are there to NOT using the .h files generated by xdrgen?

A significant portion of what is in the human-generated .h files
would be dead code. We still need to include .h files that define
the XDR arguments and results structs, and they would need to be
based on the human-generated protocol headers.

That seems pretty messy.


>  linux/nfs3.h includes
>> uapi/linux/nfs3.h. And fs/nfsd/nfsd.h includes linux/nfs.h,
>> linux/nfs3.h, and linux/nfs4.h, so there's no escape from the
>> uapi headers. (I'm not sure why NFS uapi headers have the
>> protocol bits in them; shouldn't they have only the admin UI
>> APIs?).
>> 
>> I don't think any of this would be terribly obvious to reviewers
>> even if the series had more patches. You basically have to go
>> spelunking to discover it.
>> 
>> A different way to slice this would be to make the subsystem-
>> agnostic NFS file handle merely a size and pointer to a buffer
>> (like struct xdr_netobj). Then both the client and server
>> implementations can use either static arrays or dynamically
>> allocated buffers, and they can get their maximum size
>> constants from wherever they like.
>
> I don't think the extra indirection of using the xdr_netobj approach for
> filehandle is a good idea.

I'm talking about only the places where the client and server need
to communicate via local procedure call, like fs/nfs_common/nfs_ssc.c
or lockd. This would leave both sides to use their preferred storage
and internal API structures.

We have the same problem with nfs4_stateid versus stateid_t, and it
is also pretty convenient to shove those into an xdr_netobj to make
a function call between the client and server.


-- 
Chuck Lever

