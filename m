Return-Path: <linux-nfs+bounces-6901-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB3F992218
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 00:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D441F21534
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE1A18A952;
	Sun,  6 Oct 2024 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfUXcX8V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68393611B;
	Sun,  6 Oct 2024 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728253766; cv=none; b=RO8VSLeVDoaFtFM/6eTH1wtOXPwwSwjbCROU6D3HLI4LXAn9AlzLbZJSH/H6Wr0NKN/c9Bylh749S3Rg6OYPbCsjGv2JgdwA1+RdIXi+ZbaBBQ7+heKKHyAR2Pla/xgxQ4pZY9q9BSYmsF/kobUj0NoowPIbrmGQSi543fwzePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728253766; c=relaxed/simple;
	bh=xhNZwKjxVVqjrgRf1qSRKkSvaDWrHNe0hyTZV4FEKdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USxUBg4Tn1oqecK8K14pyH7hl0hFne3lfYb2p83y0JjlIUDkiVTglYNc97Cj8Zycb+gWWuNhJg+BJ3B5QoRonFvH1GxduCuQBxk7yhJGqy22Bc4YgkEYBB5i5by1fL+6V50JjZe2o35GJnK+A7F06/zhnegedseRZYHfFsc5a3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfUXcX8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8D7C4CEC5;
	Sun,  6 Oct 2024 22:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728253765;
	bh=xhNZwKjxVVqjrgRf1qSRKkSvaDWrHNe0hyTZV4FEKdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfUXcX8VHHMuxs16zdHdZ6MmhEr+zcjmgTLvo4udh/wUXtvWwNuRf3c2kqJRZxBr7
	 5Oqxhlrsi4Uef1JsGJyYI/u6bzBqHIKVkVRYwNff+n3sLYMYzR2gY0uhxvFirfJNdC
	 FX48wVS9aESuHtwL2qOrIbWX5UIVpUCV+iKUoCTin8sBdFlt5XeJ2eR/ndksIXz2o0
	 ihQdo9fc+RzzEe7fnBAZ7fnBh19SgoVaWs/27R/hybbNo04wuzEwmtswEfRpDFc0VV
	 6j3zB0/cNFhTabUcpnCPiFwfO7I0FZe/xekskRAfMUZbrbxaBEbWLcgZzQx64VvUW5
	 y9ZGOJtcZwtfw==
Received: by pali.im (Postfix)
	id C373881A; Mon,  7 Oct 2024 00:29:18 +0200 (CEST)
Date: Mon, 7 Oct 2024 00:29:18 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Message-ID: <20241006222918.jnf4odeoyq6u7l5m@pali>
References: <>
 <ZwLN6RtYwVIkUfaL@tissot.1015granger.net>
 <172825279728.1692160.16291277027217742776@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172825279728.1692160.16291277027217742776@noble.neil.brown.name>
User-Agent: NeoMutt/20180716

On Monday 07 October 2024 09:13:17 NeilBrown wrote:
> On Mon, 07 Oct 2024, Chuck Lever wrote:
> > On Fri, Sep 13, 2024 at 08:52:20AM +1000, NeilBrown wrote:
> > > On Fri, 13 Sep 2024, Pali Rohár wrote:
> > > > Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do not bypass
> > > > only GSS, but bypass any authentication method. This is problem specially
> > > > for NFS3 AUTH_NULL-only exports.
> > > > 
> > > > The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 2623,
> > > > section 2.3.2, to allow mounting NFS2/3 GSS-only export without
> > > > authentication. So few procedures which do not expose security risk used
> > > > during mount time can be called also with AUTH_NONE or AUTH_SYS, to allow
> > > > client mount operation to finish successfully.
> > > > 
> > > > The problem with current implementation is that for AUTH_NULL-only exports,
> > > > the NFSD_MAY_BYPASS_GSS_ON_ROOT is active also for NFS3 AUTH_UNIX mount
> > > > attempts which confuse NFS3 clients, and make them think that AUTH_UNIX is
> > > > enabled and is working. Linux NFS3 client never switches from AUTH_UNIX to
> > > > AUTH_NONE on active mount, which makes the mount inaccessible.
> > > > 
> > > > Fix the NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT implementation
> > > > and really allow to bypass only exports which have some GSS auth flavor
> > > > enabled.
> > > > 
> > > > The result would be: For AUTH_NULL-only export if client attempts to do
> > > > mount with AUTH_UNIX flavor then it will receive access errors, which
> > > > instruct client that AUTH_UNIX flavor is not usable and will either try
> > > > other auth flavor (AUTH_NULL if enabled) or fails mount procedure.
> > > > 
> > > > This should fix problems with AUTH_NULL-only or AUTH_UNIX-only exports if
> > > > client attempts to mount it with other auth flavor (e.g. with AUTH_NULL for
> > > > AUTH_UNIX-only export, or with AUTH_UNIX for AUTH_NULL-only export).
> > > 
> > > The MAY_BYPASS_GSS flag currently also bypasses TLS restrictions.  With
> > > your change it doesn't.  I don't think we want to make that change.
> > 
> > Neil, I'm not seeing this, I must be missing something.
> > 
> > RPC_AUTH_TLS is used only on NULL procedures.
> > 
> > The export's xprtsec= setting determines whether a TLS session must
> > be present to access the files on the export. If the TLS session
> > meets the xprtsec= policy, then the normal user authentication
> > settings apply. In other words, I don't think execution gets close
> > to check_nfsd_access() unless the xprtsec policy setting is met.
> 
> check_nfsd_access() is literally the ONLY place that ->ex_xprtsec_modes
> is tested and that seems to be where xprtsec= export settings are stored.
> 
> > 
> > I'm not convinced check_nfsd_access() needs to care about
> > RPC_AUTH_TLS. Can you expand a little on your concern?
> 
> Probably it doesn't care about RPC_AUTH_TLS which as you say is only
> used on NULL procedures when setting up the TLS connection.
> 
> But it *does* care about NFS_XPRTSEC_MTLS etc.
> 
> But I now see that RPC_AUTH_TLS is never reported by OP_SECINFO as an
> acceptable flavour, so the client cannot dynamically determine that TLS
> is required.

Why is not RPC_AUTH_TLS announced in NFS4 OP_SECINFO? Should not NFS4
OP_SECINFO report all possible auth methods for particular filehandle?

> So there is no value in giving non-tls clients access to
> xprtsec=mtls exports so they can discover that for themselves.  The
> client needs to explicitly mount with tls, or possibly the client can
> opportunistically try TLS in every case, and call back.
> 
> So the original patch is OK.
> 
> NeilBrown

