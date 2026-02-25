Return-Path: <linux-nfs+bounces-19247-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N4vCA4qn2kOZQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19247-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 17:57:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6E519B125
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 17:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60D2B30182BC
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5BB3D3481;
	Wed, 25 Feb 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbL6nZKM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AB281341
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038415; cv=none; b=MnvhTRQBdCkm/gQTWAo2ShC71wUH6Xq0kkrht80e9/YdBlZ0sCr2Z07uHHP/DcW+1YPvWiTELWqpicbY26SOjYx2G/I1U+P8Xq61iWXqSTkhgSs3SRWdTI6JjxO5z/pEFtLrPIAUbcBr3h1sspRXgEKzUp8Smt3m/dS3MZSlASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038415; c=relaxed/simple;
	bh=mshLL1otvqiQC8dgBWXkXUFB8qGwjKmxyeKx8AaHH74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA15JUfcnt/R//rechxtv40IYum3ftojjJ3/y9qd8XaMRXpca7leXNgHsbDmOlt/B6HXmbZJAfezNOyPpTq0jvI+bfh4ffps6bOQvWpckanGhAQm5Jd56S2l/yRrf9ZYIvLgX4TSXaqtYJwJgyRMhyWS/KfzwpKs8v2GmZBVX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbL6nZKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25E9C116D0;
	Wed, 25 Feb 2026 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772038415;
	bh=mshLL1otvqiQC8dgBWXkXUFB8qGwjKmxyeKx8AaHH74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbL6nZKM3HPsjwYnhG7qw3ZiIon/sBK+Nl0RYGYdTQrMnFApbAcI0ihQx2eyaVFm/
	 Zm8e1nc+XSVQJ2JNtqpfHw1HwdDgJ+jaoAW0qlICO38XuJ1nuTEBCqZK/yi1+xAB8Z
	 b7jKgquCaYzpj0SZAuJm/eY1u6R32xK7BtGRrV2WDAhkDPfSLfi862xlue9ArchqB9
	 0B6GJ2hUGjfAvfDejjhQMyhIofjO5x9KO8hH5CwabtR5J8h6VS3WliHiGOkQ8PPr/o
	 KELAmSyEo70vDFe6/NOitNaiMb6AUv3HGSY5UN+cLi0oWGWaurWkJheehfRSW/iOov
	 r9yadJFnApPdQ==
Date: Wed, 25 Feb 2026 11:53:33 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4
 reexport
Message-ID: <aZ8pDX2LWU5Qgxku@kernel.org>
References: <20260224192438.25351-1-snitzer@kernel.org>
 <3251bc70-6efd-4cc7-9060-28853f047d53@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3251bc70-6efd-4cc7-9060-28853f047d53@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19247-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C6E519B125
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 04:58:10PM -0500, Chuck Lever wrote:
> 
> On Tue, Feb 24, 2026, at 2:24 PM, Mike Snitzer wrote:
> > Hi,
> >
> > This patchset aims to enable NFS v4.1 ACLs to be fully supported from
> > an NFS v4.1 client to an NFSD v4.1 export that reexports NFS v4.2
> > filesystem which has full support for NFS v4.1 ACLs (DACL and SACL).
> >
> > The first 6 patches focus on nfs4_acl passthru enablement (primarily
> > for NFSD), patch 7 adds 4.1 nfs4_acl passthru support (DACL and SACL),
> > patch 8 optimizes particular nfs4_acl passthru implementation in NFSD
> > to skip memcpy if nfs4_acl passthru isn't needed, patches 9-11 offer
> > the corresponding required NFSv4 client changes.
> >
> > This work is based on the nfsd-testing branch (commit 22f4955340fc).
> >
> > This patchset is marked as RFC because I expect there will be
> > suggestions for possible NFSD implementation improvements.
> >
> > All review appreciated, thanks.
> > Mike
> >
> > v2: rebased v1 ontop of nfsd-testing commit 22f4955340fc
> >
> > Mike Snitzer (11):
> >   exportfs: add ability to advertise NFSv4 ACL passthru support
> >   NFSD: factor out nfsd_supports_nfs4_acl() to nfsd/acl.h
> >   NFS/NFSD: data structure enablement for nfs4_acl passthru support
> >   NFSD: prepare to support SETACL nfs4_acl passthru
> >   NFSD: add NFS4 reexport support for SETACL nfs4_acl passthru
> >   NFSD: add NFS4 reexport support for GETACL nfs4_acl passthru
> >   NFSD: add NFS4ACL_DACL and NFS4ACL_SACL passthru support
> >   NFSD: avoid extra nfs4_acl passthru work unless needed
> >   NFSv4: add reexport support for SETACL nfs4_acl passthru
> >   NFSv4: add reexport support for GETACL nfs4_acl passthru
> >   NFSv4: set EXPORT_OP_NFSV4_ACL_PASSTHRU flag
> >
> >  fs/nfs/export.c          |  23 ++++-
> >  fs/nfs/nfs4proc.c        | 112 +++++++++++++++-------
> >  fs/nfs/nfs4xdr.c         |   2 +-
> >  fs/nfsd/acl.h            |  11 ++-
> >  fs/nfsd/nfs4acl.c        |  69 +++++++++++++-
> >  fs/nfsd/nfs4proc.c       |  32 +++++--
> >  fs/nfsd/nfs4xdr.c        | 194 +++++++++++++++++++++++++++++++++------
> >  fs/nfsd/nfsd.h           |   5 +-
> >  fs/nfsd/xdr4.h           |   2 +
> >  include/linux/exportfs.h |  22 +++++
> >  include/linux/nfs4.h     |  23 ++++-
> >  include/linux/nfs_xdr.h  |  11 +--
> >  include/linux/nfsacl.h   |   7 ++
> >  13 files changed, 431 insertions(+), 82 deletions(-)
> >
> > -- 
> > 2.44.0
> 
> So what you want is indeed pass-through, it's not support for
> local file systems with NFSv4 ACL. NFSD is not only leaving the
> ACEs alone, but it is also not doing any idmapping... and the
> NFS client currently has nothing at all that deals with NFSv4
> ACLs. So that explains the raw byte pass-through design.

Yes, I'm using the NFSv4 ACL payload that is provided by the NFSv4
client. And then NFSD passes that through to the NFSv4 client it is
reexporting.
 
> Passing pages of raw wire data between client and server is
> awkward, however, and has resulted in correctness bugs and
> architectural issues (found during review).

The NFSv4 client goes out of its way to be a passthrough mechanism for
ACLs, because we don't want identity mapping, etc transforming the
payload.

So there is new NFSD code in this series to enable passthru of that
ACL payload from NFSD to NFSv4 client it is reeexporting (because
NFSD's existing limited ACE decode into a list of ACEs is not needed
or useful for passing through to NFSv4 client's existing ACL payload
handling).

> It would be faster for us to start with proper support in NFSD for:
> 
> 6.2.2.  Attribute 58: dacl
> 
>    The dacl attribute is like the acl attribute, but dacl allows just
>    ALLOW and DENY ACEs.  The dacl attribute supports automatic
>    inheritance (see Section 6.4.3.2).
> 
> 6.2.3.  Attribute 59: sacl
> 
>    The sacl attribute is like the acl attribute, but sacl allows just
>    AUDIT and ALARM ACEs.  The sacl attribute supports automatic
>    inheritance (see Section 6.4.3.2).
> 
> This subfeature can get worked out and merged while we sort through
> the API contract issues with ACL pass-through.

This would be useful for NFSD's benefit if native DACL and SACL
support were the goal. But I don't yet see how it helps the reexport
pass-through case my series is focused on. Given the way the NFSv4
client handles ACLs, any extra NFSD processing into intermediate ACLs
actively works against ACL support for the NFSv4 reexport usecase.

> Current NFSD support for DACL/SACL:
> 
> - FATTR4_DACL (bit 58) and FATTR4_SACL (bit 59) are defined in
>   `include/uapi/linux/nfs4.h` but not in any supported attrs mask
> - Dispatch table (`fs/nfsd/nfs4xdr.c`):
>       [FATTR4_DACL] = nfsd4_encode_fattr4__noop,
>       [FATTR4_SACL] = nfsd4_encode_fattr4__noop,
> - Not decoded in nfsd4_decode_fattr4()
> - Not in NFSD_WRITEABLE_ATTRS_WORD1 (`fs/nfsd/nfsd.h`)
> 
> Patch sequence might look something like:
> 
>  1. NFSD: add acl_flags to struct nfs4_acl for nfsacl41
>  2. NFSD: add DACL/SACL decode at correct fattr4 bit position
>  3. NFSD: handle nfsacl41 wire format (aclflag4 + aces) in decode
>  4. NFSD: add nfsacl41 encode for DACL/SACL responses
>  5. NFSD: clear ACL, DACL, and SACL together in supported_attrs
>  6. NFSD: add DACL/SACL to supported and writable attribute masks
> 
> 
> For the API between NFSD and the local NFS client, I might favor an
> alternative to new export operations: NFSD can set "system.nfs4_acl"
> xattrs on NFS client inodes. The only issue there is it limits the
> total number of bytes to 64K. But we can worry about that once the
> DACL/SACL attributes are implemented.

This line of work _seems_ outside the scope of what is needed, so I
won't be pursuing it unless you can help me better understand how this
stepping stone of NFSD having native support for DACL and SACL will
begin to offer more capable ACL pass-through support for NFS reexport.

Further review of the code provided in this series would be
appreciated. I do think I've captured the essence of what is needed.

Thanks,
Mike

