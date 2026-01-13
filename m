Return-Path: <linux-nfs+bounces-17821-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00530D1B565
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 22:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57A2E3035F75
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 21:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301724A05D;
	Tue, 13 Jan 2026 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4z8pNuL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DF21ABAC
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338194; cv=none; b=I2+rAU2azoBwil+jWXKcBPOP/EJu1ruXiWHx0metNWK1n4diJO7Cvmo9TT9MhvRgr8vgKlXcxoqY3IB78my99Fs7EGVufc+VgpCoLz55DSVKBLerf+0U4QSESNz+ziPvV3EHLGqnKU/Gh6a/HjOqNo7MWlvEfjwDZt8i/QCSS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338194; c=relaxed/simple;
	bh=eyQQF1bnLb/XPCrxRIkxNH4oXGzQT8Zlhwbzs+4YpqY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R8hLpmBp3X/IKHT+jttCa7PglFk2sxGHeDOcN36uRk4O8ziGGL/4xi6493nE8eZmP1065MqhpVEsYFAogRKpX3sPh/vJAXfYsqF+Xf/zGhIuLH0wD4TXwF/t8fPP57x1HZ83lo/g1KcUMvdZcVqY3St5uJphN7yy+v+ly4EortM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4z8pNuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C76FC116C6;
	Tue, 13 Jan 2026 21:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768338194;
	bh=eyQQF1bnLb/XPCrxRIkxNH4oXGzQT8Zlhwbzs+4YpqY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=W4z8pNuL3R4SOfNR/kCkB4EOV0qZm5BKS5WLWZJJtBVqYWbSUqNLm+083pwrilkFV
	 GvCI363PRN5paOwgAHR1Wqh+ObjTIF26S2fbUNJVEhtZHlcx+/ZP9fqSswVmcQn+ga
	 ps4+Tau+UzhtO4JmFp2yACIUQoYtBbysY7TLHTAULCTd6yqQ7I+F1Oa+OnfyEmuYq5
	 K7NNovx24N7VUPhldHdTkR9YB+N1n4JD/r2gsN80ExyIVrjd32MzNhQZyeUY4HOgdw
	 0wTpQfmaw4j9k18qXXnItphA2lRTQklORu5pM3KWTho1vnAiUwq93jxRPMfvI6vZiU
	 1K4plfCOqk3Nw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id EF367F4006B;
	Tue, 13 Jan 2026 16:03:12 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 13 Jan 2026 16:03:12 -0500
X-ME-Sender: <xms:ELNmaayATWi0eZE6uSK7lbGt8lyKqFFU6yVN1d6fYS3h5cuWxhhPXQ>
    <xme:ELNmaREluaydOY4D_qUU30jgHcGH4ckpk9tAz8thfnDdFFxIObQ-z8X5_4INjGsHA
    cYZw25cAL4UmlmpsZ4ysQtmV9RX61g5gtpboK1K10_auk9JdDhmgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegstghougguihhngh
    eshhgrmhhmvghrshhprggtvgdrtghomhdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtrhhonhgu
    mhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorh
    grtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:ELNmaZGq9Tb6vhJicfr3bOe97IoiSrhifwCKkPg7QchRyyF-JHHsfw>
    <xmx:ELNmaYUDbY73acI3P1nYsHyzqTjRZdwKw8J4MCzLwqiQyuY0EVOvTA>
    <xmx:ELNmaRyMblJwYe9opUdskDqFTWyWbHfvSt5YbpfbHXk_vxLPIBsi6A>
    <xmx:ELNmadTNer1Zb2joy2ZjRhT9n82LJpV77IB4ep_3H48P8iIEjNWIng>
    <xmx:ELNmadhraRz6kfJvjM0wHCZ00q72v-GWHDOSsbcd06_7v78doTUh0ECy>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CCD69780070; Tue, 13 Jan 2026 16:03:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhR4-OOkCaFZ
Date: Tue, 13 Jan 2026 16:02:06 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org
Message-Id: <e711e1cb-eb8a-4723-a9af-39ce7d9658dd@app.fastmail.com>
In-Reply-To: <86B6E978-C67B-4C78-9E5F-6F171FD62F3E@hammerspace.com>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
 <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
 <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
 <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
 <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
 <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
 <BCFA2167-C883-40C8-A718-10B481533943@hammerspace.com>
 <1c5569bd-fcac-4b55-8e84-3fbc096cdff3@kernel.org>
 <86B6E978-C67B-4C78-9E5F-6F171FD62F3E@hammerspace.com>
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Jan 13, 2026, at 2:54 PM, Benjamin Coddington wrote:
> On 13 Jan 2026, at 13:53, Chuck Lever wrote:
>
>> On 1/13/26 12:02 PM, Benjamin Coddington wrote:

>> But let's do some homework first. What exactly are you trying to protect
>> against? Let's hear some specific examples so we are all on the same
>> page.
>
> OK - I feel like I've done a lot of explaining already in my responses, but
> here goes I'll try again here and I think maybe I'll get better at this with
> repetition.

Can you provide some specific examples when you repost?

For instance, give a particular file system implementation and explain
exactly how a plaintext filehandle generated by the filesystem can be
used to game the server into accessing a file?


>> I'm asking because the folks on this mailing list you are presenting
>> this to for review were not present for the in-person discussion, or
>> more pertinently, might not know or care to know how NFS file handles
>> are utilized.
>
> Roger.  Do you want me doing that here or in a v2 (no linux-crypto here)..
> It seems like you have a pretty good idea of what I'm trying to accomplish,
> so maybe you can just give me a hint so I can start all this over in the
> right direction.  Discussion might be better on a fresh posting, I have
> fixed the nits in the RFC..

Let's reset and start over with a v2, and broaden the Cc's.


>> Is the issue an artifact of the design of the NFS protocol?
>
> No, it's in the nature of a filehandle.
>
> As you know, a client that has a filehandle can access a file without
> needing to walk the directory tree to the file's location.  That walk might
> have permissions set on parent directories above the file that restrict the
> walk to the file from that user.  We'd normally expect those permissions to
> keep those files from being accessed or looked up, but when filehandles are
> not completely opaque - its trivial to guess them and bypass the security
> that might exist on a directory walk to the file.

Then the answer is YES, it's in the nature of the NFS protocol and
how NFS LOOKUP works.

And I think that means that every NFS server implementation out there
has the same exposure. And wouldn't open_by_filehandle() have the
same exposure?

I guess this hasn't been a problem until now because the Hammerspace
pNFS Flexfile implementation has not been in the picture? What will
HS do for customers that use non-Linux NFS servers, in particular if
those server implementations are no longer being updated?


>> Is it a problem specific to certain export options? (I think I heard a
>> yes in there somewhere)
>
> Yes - specifically its a problem when a server exports the same filesystem
> to different clients using root_squash for some, and then those clients are
> arranged in a way that one of the clients acts as a broker to "hand out"
> filehandles to authorized non-root-squash clients.  This is the flexfiles
> scenario that I am interested in.  I am happy to go into much more detail
> about this.

We need you to do that, please. I'm still finding your answers a bit
too hand-wavy (that's intended only as polite feedback).

The mention of pNFS Flexfiles here suggests that this issue is really
/only/ a problem for the way Hammerspace uses it's DSes in this strange
root_squash arrangement. It would help if we could identify a second
frequently-deployed case that would be improved by filehandle encryption.

Is this only an issue when root_squash is in use?


>> Why precisely do you believe obscuring file handle information is more
>> beneficial than simply signing it?
>
>  - the client doesn't need the Message (M in MAC), so it doesn't need to
>    verify the message or decode it - which is the normal use case for a MAC.

True, the client doesn't use the content of filehandles at all. It's
the server that needs the M -- "does this file handle belong to me?" --
when the client presents a filehandle to it.


>    Adding 8 bytes to every filehandle may be an unnecessary overhead on a
>    wire protocol.  Balance this with the fact that using AES-CBC will need
>    to pad out a filehandle to 16 byte boundary.  With all the different fsid
>    and filed lengths, depending on the filesystem, I think this argument is
>    a wash really.
>
>  - If using a MAC, the more filehandles a client has, the easier it may be
>    to guess the secret.  Of course, that can still be practically
>    impossible, but the scale of work to break a completely encrypted
>    filehandle is far higher since the client does not have the original data
>    used to create the hash.

Someone (ie, a cryptographer) needs to do the math on this one.

- Filehandles are public and live as long as a file on a filesystem instance.
  This means (I /think/) that the signing/encryption key cannot be rotated.

- Individual filehandles are small, on the order of 32- or 64-bytes

- But there are a lot of filehandles, perhaps billions, that would
  be encrypted or signed by the same key

- The filehandle plaintext is predictable


>  - A non-obscured filehandle can still reveal information about the
>    filesystem that the NFS server does not intend.  NFS doesn't control the
>    data in the filehandle.  This information is probably better kept
>    unrevealed to a client, as the information itself is outside the control
>    of kNFSD.

Here's where I would love to see a specific example based on one
or more of the file system implementations in the Linux kernel.


>> Why do you want to protect file handles, in specific, without using in-
>> transit transport encryption like krb5p or TLS, or without protecting
>> other XDR data elements?
>
> Because I can have different non-root users on the same client that share a
> krb5p or TLS wire encryption transport, but not want those users to use

Each RPC message protected by krb5p is wrapped by a specific user's
Kerberos credentials, so generally speaking another user cannot
decrypt that message.

Multiple users can share a single TLS session, but generally one
session is considered to be a security domain that should be
shared only by users that are mutually trustworthy. You can open
multiple TLS sessions, one for each such domain.

So far it still feels like either krb5p or TLS could be used to
effectively address the filehandle exposure.


> open-by-filehandle to attack an export and gain access to files below a
> directory they are not actually allowed to walk into.
>
>> How much work do you think an attacker might be willing to do to
>> crack this protection? This goes to selection of algorithm and key
>> size, and decisions about whether one key protects all of a server's
>> exports, or each export gets its own key.
>
> It depends on how valuable the data might be to the attacker.  I hope we're
> making products that banks and governments and nations can depend on.

Usually this requirement is specified by resources at hand and how
much time is needed to crack the encryption/hash.

The US government will require FIPS 140-3 compliance.


>> What are your performance goals and how do you plan to measure them?
>
> I need the feature to not significantly slow down operations at
> datacenter latencies.  I'm expecting a small performance hit, but I
> really don't want to wait for things like memory reclaim.

There are plenty of other kmalloc / alloc_page call sites in the
request path, and the server is designed around permitting synchronous
waits for memory allocated with GFP_KERNEL. If you don't want to wait
for memory reclaim, use GFP_NOFS or even GFP_ATOMIC but for such small
allocations, it's highly unlikely that an allocation request will fail.

So in a buffer-per-svc thread design, the buffer is passed from user to
user as a thread handles each RPC request. Using a kmalloc/kfree_sensitive
pair is the best way to ensure that the buffer content is not leaked
between buffer uses.


> Chuck - I hope you can simply tell me to use MAC or AES on v2, and we can
> shoot it full of holes on the next posting.  Can we do that on fresh version
> -- can you pick a direction you'd like to go?

I'm taking a stab: If you want to prototype something quickly, please
use siphash for v2. We need to understand if signing is enough, if
encryption is actually required, or if even that isn't sufficient.


-- 
Chuck Lever

