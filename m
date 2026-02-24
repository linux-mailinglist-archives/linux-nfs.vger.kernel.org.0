Return-Path: <linux-nfs+bounces-19209-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBUUEiIfnml+TgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19209-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 22:58:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B376D18CFC3
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 22:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 736EB3017534
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 21:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB12DB7BF;
	Tue, 24 Feb 2026 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNiIfxtl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A222C11DD
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970335; cv=none; b=oKG2ZGFDBqdoUva5iZejvZGf+jrPi9oOpwuHMN3QVQdj7wO3jqfkm6IH+oqQ3PZBI6w0+gXrI5GKR+QKVy2vAuqsM0j9wgKZTNLUrmcl1Zi3UqsFmQQ0zR9lTi1dVYLHvXXAtlmSo/+o2acYn33g/N+/r0B6I8esJNAjfp8vLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970335; c=relaxed/simple;
	bh=EPjykBNHI9mEIoPFAI4tIOB0vcTEVhYmj1LaQVbOwRQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IF+Nk058SNEQoVPpmM3CQgn4tcEN5vEWukrKs/bZbn7QRxrL4wbs/WdcymVwfUBlelPVSZLuGMQCmu7jl5Z0LVG0US7Kho2xN4+sqOnD9k5VJeU3tgCDlf3RVK8+3fztx6kJavl/GiX+wjz7ghPLSjr2encya8PXCbuG1ONhsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNiIfxtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E088DC19423;
	Tue, 24 Feb 2026 21:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771970335;
	bh=EPjykBNHI9mEIoPFAI4tIOB0vcTEVhYmj1LaQVbOwRQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NNiIfxtlwC9Qw6d4zEdeM+KSqTF3jzNCayeT4XHwT906qHuoZBJDY2Me35NZzXAZA
	 FTwJ+BZT7TnN8a0wZU+iV3CFSmVu+rwqG/6rrLFIjdxH5v5gDkQTJXoHprw8xBmhhN
	 xLX1ZJJBxFDSk2XPkRIYNWMNZ8ydO6qaPYLjtvd0SAQEWIGrguQeMWXsJvdROVkZqn
	 kvy5LGryVlAyR0Rz9juXWDV9AsFAQgHbWBLIz8WvTXf0XY8M2h2LBq1yFUyTnmJnkT
	 w2J+rFcYKUPvtN+jdcf6ZKjfOBh4F1fRmPvHJKJ86u79PUjaHeQLgXbTXA8i3E3g2a
	 v0Mt6q8N+HmzA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CAF0DF40072;
	Tue, 24 Feb 2026 16:58:53 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 24 Feb 2026 16:58:53 -0500
X-ME-Sender: <xms:HR-eaa6ba3GnmYDaKlm3bNupObsOfo71vwFTQszJDEa6txIvGKS_bw>
    <xme:HR-eaetwpjxI9yn2A6yQ-5vgk-x1d1vcuZwwEqLcLCGqWlhWAzadnVoIqFSS0UMX1
    OJnp70wCW9TRD0PHaXylARtnXel7I2wKNt8towJMewIDwnzA9wqxM23>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepthhrohhnugdrmhihkhhlvggsuhhstheshhgrmhhmvghrshhprggtvgdrtghomh
    dprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    nhhithiivghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgdrshgthhhumh
    grkhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhes
    ohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HR-eaSkXfmX0Eje5DzG5TuJ72qs-PsmakXeDkAaAhOriopBXa5odtw>
    <xmx:HR-eaTIiOEtvmFZrYzKv119GSnRH8Mv580eBWyv0fb3vaSjnWnl0oQ>
    <xmx:HR-eaX5KLb6DkUnImDAb5ZFsOlIFY8jxcBBO5qOhazotT0osFCztvg>
    <xmx:HR-eaX0KjikfDA9jtiIuxd-7vOKO3BR6f1obhfEPPU9NO2ElEAHJfQ>
    <xmx:HR-eadc7K2569rSx8aALPBX-JuDgEPBkkFFXmEtef5qn3iAZH3ss8VjH>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A7B54780070; Tue, 24 Feb 2026 16:58:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aa1mxY0eGpf7
Date: Tue, 24 Feb 2026 16:58:10 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Mike Snitzer" <snitzer@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Message-Id: <3251bc70-6efd-4cc7-9060-28853f047d53@app.fastmail.com>
In-Reply-To: <20260224192438.25351-1-snitzer@kernel.org>
References: <20260224192438.25351-1-snitzer@kernel.org>
Subject: Re: [RFC PATCH v2 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4 reexport
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19209-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B376D18CFC3
X-Rspamd-Action: no action


On Tue, Feb 24, 2026, at 2:24 PM, Mike Snitzer wrote:
> Hi,
>
> This patchset aims to enable NFS v4.1 ACLs to be fully supported from
> an NFS v4.1 client to an NFSD v4.1 export that reexports NFS v4.2
> filesystem which has full support for NFS v4.1 ACLs (DACL and SACL).
>
> The first 6 patches focus on nfs4_acl passthru enablement (primarily
> for NFSD), patch 7 adds 4.1 nfs4_acl passthru support (DACL and SACL),
> patch 8 optimizes particular nfs4_acl passthru implementation in NFSD
> to skip memcpy if nfs4_acl passthru isn't needed, patches 9-11 offer
> the corresponding required NFSv4 client changes.
>
> This work is based on the nfsd-testing branch (commit 22f4955340fc).
>
> This patchset is marked as RFC because I expect there will be
> suggestions for possible NFSD implementation improvements.
>
> All review appreciated, thanks.
> Mike
>
> v2: rebased v1 ontop of nfsd-testing commit 22f4955340fc
>
> Mike Snitzer (11):
>   exportfs: add ability to advertise NFSv4 ACL passthru support
>   NFSD: factor out nfsd_supports_nfs4_acl() to nfsd/acl.h
>   NFS/NFSD: data structure enablement for nfs4_acl passthru support
>   NFSD: prepare to support SETACL nfs4_acl passthru
>   NFSD: add NFS4 reexport support for SETACL nfs4_acl passthru
>   NFSD: add NFS4 reexport support for GETACL nfs4_acl passthru
>   NFSD: add NFS4ACL_DACL and NFS4ACL_SACL passthru support
>   NFSD: avoid extra nfs4_acl passthru work unless needed
>   NFSv4: add reexport support for SETACL nfs4_acl passthru
>   NFSv4: add reexport support for GETACL nfs4_acl passthru
>   NFSv4: set EXPORT_OP_NFSV4_ACL_PASSTHRU flag
>
>  fs/nfs/export.c          |  23 ++++-
>  fs/nfs/nfs4proc.c        | 112 +++++++++++++++-------
>  fs/nfs/nfs4xdr.c         |   2 +-
>  fs/nfsd/acl.h            |  11 ++-
>  fs/nfsd/nfs4acl.c        |  69 +++++++++++++-
>  fs/nfsd/nfs4proc.c       |  32 +++++--
>  fs/nfsd/nfs4xdr.c        | 194 +++++++++++++++++++++++++++++++++------
>  fs/nfsd/nfsd.h           |   5 +-
>  fs/nfsd/xdr4.h           |   2 +
>  include/linux/exportfs.h |  22 +++++
>  include/linux/nfs4.h     |  23 ++++-
>  include/linux/nfs_xdr.h  |  11 +--
>  include/linux/nfsacl.h   |   7 ++
>  13 files changed, 431 insertions(+), 82 deletions(-)
>
> -- 
> 2.44.0

So what you want is indeed pass-through, it's not support for
local file systems with NFSv4 ACL. NFSD is not only leaving the
ACEs alone, but it is also not doing any idmapping... and the
NFS client currently has nothing at all that deals with NFSv4
ACLs. So that explains the raw byte pass-through design.

Passing pages of raw wire data between client and server is
awkward, however, and has resulted in correctness bugs and
architectural issues (found during review). It would be faster
for us to start with proper support in NFSD for:

6.2.2.  Attribute 58: dacl

   The dacl attribute is like the acl attribute, but dacl allows just
   ALLOW and DENY ACEs.  The dacl attribute supports automatic
   inheritance (see Section 6.4.3.2).

6.2.3.  Attribute 59: sacl

   The sacl attribute is like the acl attribute, but sacl allows just
   AUDIT and ALARM ACEs.  The sacl attribute supports automatic
   inheritance (see Section 6.4.3.2).

This subfeature can get worked out and merged while we sort through
the API contract issues with ACL pass-through.

Current NFSD support for DACL/SACL:

- FATTR4_DACL (bit 58) and FATTR4_SACL (bit 59) are defined in
  `include/uapi/linux/nfs4.h` but not in any supported attrs mask
- Dispatch table (`fs/nfsd/nfs4xdr.c`):
      [FATTR4_DACL] = nfsd4_encode_fattr4__noop,
      [FATTR4_SACL] = nfsd4_encode_fattr4__noop,
- Not decoded in nfsd4_decode_fattr4()
- Not in NFSD_WRITEABLE_ATTRS_WORD1 (`fs/nfsd/nfsd.h`)

Patch sequence might look something like:

 1. NFSD: add acl_flags to struct nfs4_acl for nfsacl41
 2. NFSD: add DACL/SACL decode at correct fattr4 bit position
 3. NFSD: handle nfsacl41 wire format (aclflag4 + aces) in decode
 4. NFSD: add nfsacl41 encode for DACL/SACL responses
 5. NFSD: clear ACL, DACL, and SACL together in supported_attrs
 6. NFSD: add DACL/SACL to supported and writable attribute masks


For the API between NFSD and the local NFS client, I might favor an
alternative to new export operations: NFSD can set "system.nfs4_acl"
xattrs on NFS client inodes. The only issue there is it limits the
total number of bytes to 64K. But we can worry about that once the
DACL/SACL attributes are implemented.

-- 
Chuck Lever

