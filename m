Return-Path: <linux-nfs+bounces-11170-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D170FA93F7D
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 23:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC795171281
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 21:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06578F29;
	Fri, 18 Apr 2025 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFCD86Q6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735B70805
	for <linux-nfs@vger.kernel.org>; Fri, 18 Apr 2025 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745012088; cv=none; b=r3vTDbeV6O8EF2iqgPXChlK5God0hW2fpfarQv4+LVcY3B8Y1obeMl/AsNSPXUziZRbwLaDXzmjrZqrJMbDnlcNOQYKq0KHfp/UffYh2zwx7ta1+KgaIb9G8gDBE+ggGoMf7heNELl2t5/8eMR7Vw8yqtQCFSrP83FJqTxZ0TGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745012088; c=relaxed/simple;
	bh=Gf5OJhu9FHomtFfk6YuPMwrJKrCQ3fVRzg7ztb5gnbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCyyKatwvSeAmk+OcngOrxVlnWSybgy0NQKbypYysEN5bZ+R0U6KUXCKifOwn8XJtzqUqGNQsoV5Gse2Shsm9ymeV+CJMoYZwLCAfONmsNo2YDN6B231G0d/7dwNVP0njPPIqqR3JdunTquCMBkjZLw4qX9D6lny6f9B1iIESmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFCD86Q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5F9C4CEE2;
	Fri, 18 Apr 2025 21:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745012088;
	bh=Gf5OJhu9FHomtFfk6YuPMwrJKrCQ3fVRzg7ztb5gnbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFCD86Q6gZGtZ0MX5R/eR0fduifLKRVRcWisDW7KKm7noVspcyu8g58mVHzgBwGEU
	 CntD0jaX6WsEbu45XWGsxagMhd39XCnhDuOEJx8LZzjqKmAxjp7cZ+6sTM+1bs4Mka
	 OcdJ9mOhfXE0KDmG4PjaHbZzg0tyOpQ8qoKkaauRxQMBxb97Tdue2kDHuU680doCy4
	 K5wmLFv0sacwwkYZxFspmfJ5bxU4Zs1jmYBKtoj49ppJZofIhyElnyB8tyAhI3dPgQ
	 j+SSZ6k4XHSSZLBEN4gjJKyS1EG1xvWxJVtS8vsK5a6+ERWx0Bwa2SNouhLGE1wrh3
	 2Va6uSop2j9jg==
Date: Fri, 18 Apr 2025 17:34:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	linux-nfs@vger.kernel.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
Message-ID: <aALFdnEGTxF03uQd@kernel.org>
References: <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali>
 <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
 <3911d932-5ad3-4cc9-98c9-408818cdb4cf@wanadoo.fr>
 <Z_coQbSdvMWD92IA@kernel.org>
 <738e994b-1601-4ae0-a9a2-f74a6b797f23@wanadoo.fr>
 <425a2e7c-6d42-451b-b8f8-7c923ac0ed03@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <425a2e7c-6d42-451b-b8f8-7c923ac0ed03@oracle.com>

On Wed, Apr 16, 2025 at 09:31:55AM -0400, Chuck Lever wrote:
> On 4/15/25 10:41 PM, Vincent Mailhol wrote:
> > +CC: Neil Brown
> > +CC: Olga Kornievskaia
> > +CC: Dai Ngo
> > +CC: Tom Talpey
> > +CC: Trond Myklebust
> > +CC: Anna Schumaker
> > 
> > (just to make sure that anyone listed in
> > 
> >   ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c
> > 
> > get copied).
> > 
> > Here is the link to the full thread:
> > 
> >   https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/
> > 
> > 
> > On 10/04/2025 at 11:09, Mike Snitzer:
> >> Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
> >> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. Otherwise
> >> RCU code (rcu_dereference and rcu_access_pointer) will dereference
> >> what should just be an opaque pointer (by using typeof(*ptr)).
> >>
> >> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> >> Cc: stable@vger.kernel.org
> >> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> >> Tested-by: Pali Rohár <pali@kernel.org>
> >> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > 
> > Hi everyone,
> > 
> > The build has been broken for several weeks already. Does anyone have
> > intention to pick-up this patch?
> > 
> > (please ignore if someone already picked it up and if it is already on
> > its way to Linus's tree).
> 
> I assumed that, like all LOCALIO-related changes, this fix would go
> in through the NFS client tree. Let me know if it needs to go via NFSD.

Since we haven't heard from Trond or Anna about it, I think you'd be
perfectly fine to pick it up.  It is a compiler fixup associated with
nfd_file being kept opaque to the client -- but given it is "struct
nfsd_file" that gives you full license to grab it (IMO).

I'm also unaware of any conflicting changes in the NFS client tree.

