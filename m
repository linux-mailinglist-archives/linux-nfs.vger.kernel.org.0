Return-Path: <linux-nfs+bounces-6953-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1767D995733
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 20:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3ADE2820FD
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDBC212D3C;
	Tue,  8 Oct 2024 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAOlpNRA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A62940F;
	Tue,  8 Oct 2024 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413647; cv=none; b=MRrnlULtKvzvcVg6YvEaX3fAUp2nEXEi8vEzXZk6YWaT3ooKmcmfzHAsB2JcU1DsrZpRzQI+x43Al+++dcRVpIt/dmgXJVyPNvNZ9Iyuf11RvNFpC/ew/Zi8uYfwLtGBErALt9ROuUqjiu+5U5YMXOL9HwjaYtjbkamHTk2B+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413647; c=relaxed/simple;
	bh=h5XNHyLM5x5mf5OV0VbyisufQLtBjHA4YCB/OczQTBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnYrTB5Y4ke/b481WD9OmhMFL/Wc3aHrznYUZ73DGjWSeV4YMzG55V/pgXr4whBPziASnP+2eGj7F3eBvORkcTxER7ijhhaqwdf+TL2Iru6rWEnAum+YCL7u4PSmfvto937S9pnXuhcyyKWNicML5XeZ1shz+rf7g2DvHXiETbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAOlpNRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC1C4CEC7;
	Tue,  8 Oct 2024 18:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728413647;
	bh=h5XNHyLM5x5mf5OV0VbyisufQLtBjHA4YCB/OczQTBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAOlpNRA7ia5PouXs1+Nmn31Uu/BWU76H9AwNLYk99zif5OJnVCRdyeinFBKqerTY
	 fpRabns0T32mX5ZbeHpQCRa5wghqeaQLZbMmsLBCSgFFwr19/hKBe/6iFcAZ+o/ZZ4
	 iMNkb3VuAwKTV5ECw2AIA8SgwXsrxu0Wy9zbKjGPbExsi+/XIKM4EJFVPB8Ozk61Hm
	 2vFKjXr4duYJEFX1nw+nxnUD8htUFz5SiNYjPNaT59vBlfERIz3a9RBXh71zZjEmE7
	 W3M/Anmpws3XNlt8TiBW4Ifq/fE1i/kq4p6gA1TLQfrxsK87ZFQQ1tQhLL8KjGdfmp
	 zEYgJEprDNL7g==
Received: by pali.im (Postfix)
	id 8544F82D; Tue,  8 Oct 2024 20:54:00 +0200 (CEST)
Date: Tue, 8 Oct 2024 20:54:00 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Message-ID: <20241008185400.qahsedto7iukiumk@pali>
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
> is required.  So there is no value in giving non-tls clients access to
> xprtsec=mtls exports so they can discover that for themselves.  The
> client needs to explicitly mount with tls, or possibly the client can
> opportunistically try TLS in every case, and call back.
> 
> So the original patch is OK.

So if the original patch is also OK, you can choose which one you like
more. Original V1 restrict bypass to only GSS. V2 allows bypass for any
non-null/unix methods.

Let me know if something more is needed for this change.

