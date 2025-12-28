Return-Path: <linux-nfs+bounces-17339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9BACE5363
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 18:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F2E3009ABD
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 17:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3710F1D86FF;
	Sun, 28 Dec 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmUxHpKH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B01C8616
	for <linux-nfs@vger.kernel.org>; Sun, 28 Dec 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941777; cv=none; b=FvesTxvdOteJZG2XVxZyA+06iBQhislfBkonTn9F6TyeG+xdNBw58OG8LS4IioSEUnzQBdadqsZ7/hJtj+PbtfAMdtUFDl2n++m5H+nfszs5H974OowIpcCdMtOoYiA4NuBLoLZXf8fe27iAbORF5H+F9hM/hKVRXG1L1ozEqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941777; c=relaxed/simple;
	bh=0Q1/cON8sQI5W2fqxNkehpViDnPejvjNhvkajtorNcI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mqipQ6s2WrjzRfZ/g1yGzYdE5W1vRp8kTt3lme6qup6nRbOL5uQ1nrsN5GEVLmEDxkk/EEAcGU5/KEPh1w+y9wM0UUCAb8lX4PSjXs8HRioYTP9XdAz5usBBImyTehkwa+LW3ii7Oh9jZbzlR8kwsCq3Fyc+XKeDShPm/AD6jEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmUxHpKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742E7C4CEFB;
	Sun, 28 Dec 2025 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766941776;
	bh=0Q1/cON8sQI5W2fqxNkehpViDnPejvjNhvkajtorNcI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GmUxHpKHGajW0D9iFcY5HsijTw0RvqbL1tMbmL76yPE8QCoTsTLrvCY1qvkhVn5ab
	 +xoMW5KOGWEIhBTg9Uyddnf+Xl5/l07TCwzDfswpW8QPmb4C4i3+9cXV+syF98402w
	 q184rq9mby2ZNJ/l7ghKDc9LDvIT0k2n2QMPmDzV8TuIZ7qUbDUOgzj2yAoh4zYyvs
	 MIGDmsR6YU7nthvStyvKzMYLJNXv5580LfJY4DxL4yy9LgC6yoi8jsfpXMI056eU6W
	 UZO55UNjzGgJ9lDrADTdMcANtp/yI2tr60x+VaXBmY3mADnt201VzlHiKu51c31fnW
	 0kz6R0HTLpDvA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7D3C6F40082;
	Sun, 28 Dec 2025 12:09:35 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 28 Dec 2025 12:09:35 -0500
X-ME-Sender: <xms:T2RRacunvN3UIgtlRyqH0xuQsEQedcZnvPNYZ3ZeQIU4GMJssBiJXQ>
    <xme:T2RRaUSnxnwHAdtSTm0kcDmfSzMly9Sa6YeEamUyWqn2ektPcPrLC2KXHE05y7C3Z
    BwZrQL4ESheJdwgxjlLhHXdtBGrmi4uAhpjZ99RuCyy6dtlPfNnHpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejgeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgeehudeiieevveehleehleeugefhhfdttdehlefhuddttdehieelteekleevtdejnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpe
    epkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrg
    hmvgdprhgtphhtthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomhdp
    rhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:T2RRaeH8O9Dsc4ToD-NZOR8vBS82q_YVm9KrEaURmkvxwOULynW-zw>
    <xmx:T2RRaQBA2Fq-qRN3bELw-oe5A9R8EclMy9Dh17xWpkUF451eGSYhdA>
    <xmx:T2RRaWUUSD8Kg0RKl2mzhonJGrcKjIe7j8rN0SBzlFmD41oeNM9hgw>
    <xmx:T2RRacrMbGlud4FMkAYN_0tlB-a8pOMgvMIQv7FSEdSCH5y914zvnw>
    <xmx:T2RRaaQJYw12UUAxUEjzTRi2m0my59DbeeLKGiHtWTYtCq1E_KpjCPPX>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 58A64780054; Sun, 28 Dec 2025 12:09:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhR4-OOkCaFZ
Date: Sun, 28 Dec 2025 12:09:04 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Message-Id: <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
In-Reply-To: <cover.1766848778.git.bcodding@hammerspace.com>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ben -

Thanks for getting this started.

I tried to pull in the kernel patches as follows:

cel@morisot:~/src/linux/for-korg$ b4 am https://lore.kernel.org/linux-nf=
s/176690096534.16766.12693781635285919555@noble.neil.brown.name/T/#u
Grabbing thread from lore.kernel.org/all/176690096534.16766.126937816352=
85919555@noble.neil.brown.name/t.mbox.gz
Analyzing 19 messages in the thread
WARNING: duplicate messages found at index 2
   Subject 1: exportfs: Add support for export option encrypt_fh
   Subject 2: nfsd: Add a symmetric-key cipher for encrypted filehandles
  2 is not a reply... assume additional patch
WARNING: duplicate messages found at index 1
   Subject 1: nfsdctl: Add support for passing encrypted filehandle key
   Subject 2: nfsd: Convert export flags to use BIT() macro
  2 is not a reply... assume additional patch
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH v1 1/2] nfsdctl: Add support for passing encrypted fi=
lehandle key
    =E2=9C=93 Signed: DKIM/hammerspace.com
  =E2=9C=93 [PATCH v1 1/7] nfsd: Convert export flags to use BIT() macro
    =E2=9C=93 Signed: DKIM/hammerspace.com
  =E2=9C=93 [PATCH v1 2/7] nfsd: Add a symmetric-key cipher for encrypte=
d filehandles
    =E2=9C=93 Signed: DKIM/hammerspace.com
  =E2=9C=93 [PATCH v1 4/7] NFSD: Add a per-knfsd reusable encfh_buf
    =E2=9C=93 Signed: DKIM/hammerspace.com
  =E2=9C=93 [PATCH v1 5/7] NFSD/export: Add encrypt_fh export option
    =E2=9C=93 Signed: DKIM/hammerspace.com
  =E2=9C=93 [PATCH v1 6/7] NFSD: Add filehandle crypto functions and hel=
pers
    =E2=9C=93 Signed: DKIM/hammerspace.com
  =E2=9C=93 [PATCH v1 7/7] NFSD: Enable filehandle encryption
    =E2=9C=93 Signed: DKIM/hammerspace.com
  ERROR: missing [8/2]!
  ERROR: missing [9/2]!


Whatever you did to post these seems to badly confuse b4. I recommend
posting nfs-utils and kernel patches as entirely separate threads.

Also, the cover letters for both series should mention the base commit
for your series. Typically for NFSD patches, base your series on the cel
nfsd-testing branch. But any base is workable as long as you mention the
base commit in the cover letter.

More below.


On Sat, Dec 27, 2025, at 12:04 PM, Benjamin Coddington wrote:
> In order to harden kNFSD against various filehandle manipulation techn=
iques
> the following patches implement a method of reversibly encrypting file=
handle
> contents.

"various filehandle manipulation techniques" is pretty vague. Reviewers
will need to know which specific attack vectors you are guarding against
in order to evaluate whether your proposal addresses those attacks.

Also, next posting should copy both linux-crypto and probably linux-fsde=
vel
too, as the FUSE and exportfs folks hang out there and might be interest=
ed
in this work. There are other consumers of filehandles in the kernel.


> Using the kernel's skcipher AES-CBC, filehandles are encrypted by firs=
tly
> hashing the fileid using the fsid as a salt, then using the hashed fil=
eid as
> the first block to finally hash the fsid.

Is the FSID possibly exposed on the wire via NFSv3 FSINFO and certain
NFSv4 GETATTR operations? It's not clear to me from this description
whether these values are otherwise unknown to network systems.

Can you elaborate on why you selected AES-CBC? An enumeration of the
cryptography requirements would be great to see, either in the cover
letter or as a new file under Documentation/fs/nfs/ .

The use of a symmetric cipher is surprising. I thought there was going
to be a cache of file handles so that file handle decryption operations
for each I/O would not be necessary.


> The first attempts at this used stack-allocated buffers, but I ran int=
o many
> memory alignment problems on my arm64 machine that sent me back to usi=
ng
> GFP_KERNEL allocations (here's to you /include/linux/scatterlist.h:210=
).  In
> order to avoid constant allocation/freeing, the buffers are allocated =
once
> for every knfsd thread.  If anyone has suggestions for reducing the nu=
mber
> of buffers required and their memcpy() operations, I am all ears.

The required use of dynamically allocated buffers is a well-known
constraint of the crypto API. That would be another reason to consider
not using one of the kernel's crypto APIs.

I'd rather avoid hanging anything NFSD-related off of svc_rqst, which
is really an RPC layer object. I know we still have some NFSD-specific
fields in there, but those are really technical debt.


> Currently the code overloads filehandle's auth_type byte.  This seems
> appropriate for this purpose, but this implementation does not actually
> reject unencrypted filehandles on an export that is giving out encrypt=
ed
> ones.  I expect we'll want to tighten this up in a future version.

I recall one purported reason to encrypt file handles on the wire is to
mitigate file handle guessing attacks... so operations on an export that
uses encrypted file handles really should return NFSERR_STALE when a
non-encrypted FH is presented, from day-zero, unless I misunderstand.

Can you elaborate more on the size of an encrypted file handle? I assume
these are fixed in size. An NFSv3 on-the-wire file handle can be up to
64 octets, but NFSv4 file handles can be up to 128. Are both going to be
encrypted to the same size?

Can the cover letter or other documentation include a bit diagram that
graphically shows the proposed layout of an encrypted file handle on the
wire?


> Comments and critique welcome.
>
> Benjamin Coddington (7):
>   nfsd: Convert export flags to use BIT() macro
>   nfsd: Add a symmetric-key cipher for encrypted filehandles
>   nfsd/sunrpc: add per-thread crypto context pointer
>   NFSD: Add a per-knfsd reusable encfh_buf
>   NFSD/export: Add encrypt_fh export option
>   NFSD: Add filehandle crypto functions and helpers
>   NFSD: Enable filehandle encryption
>
>  Documentation/netlink/specs/nfsd.yaml |  12 ++
>  fs/nfsd/export.c                      |   7 +-
>  fs/nfsd/localio.c                     |   2 +-
>  fs/nfsd/lockd.c                       |   2 +-
>  fs/nfsd/netlink.c                     |  15 +++
>  fs/nfsd/netlink.h                     |   1 +
>  fs/nfsd/netns.h                       |   1 +
>  fs/nfsd/nfs3proc.c                    |  10 +-
>  fs/nfsd/nfs3xdr.c                     |  14 +-
>  fs/nfsd/nfs4proc.c                    |  10 +-
>  fs/nfsd/nfs4xdr.c                     |  14 +-
>  fs/nfsd/nfsctl.c                      |  40 +++++-
>  fs/nfsd/nfsfh.c                       | 179 +++++++++++++++++++++++++-
>  fs/nfsd/nfsfh.h                       |  26 +++-
>  fs/nfsd/nfsproc.c                     |   8 +-
>  fs/nfsd/trace.h                       |  19 +++
>  include/linux/sunrpc/svc.h            |  12 +-
>  include/uapi/linux/nfsd/export.h      |  36 +++---
>  include/uapi/linux/nfsd_netlink.h     |   2 +
>  net/sunrpc/svc.c                      |   1 +
>  20 files changed, 356 insertions(+), 55 deletions(-)
>
> --=20
> 2.50.1

--=20
Chuck Lever

