Return-Path: <linux-nfs+bounces-13224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B44B0FDD4
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 01:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17577167A51
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 23:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F16271442;
	Wed, 23 Jul 2025 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM1tXo+Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D3259CA1
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315128; cv=none; b=A2hogr1j/yEJnrD2I8r8i4Mh1py94bG/lTn21F2nymnLqqBSbqW82t9LAHdrqoyfdq7UYr7yiHXJSk4xijkgmmzdvsNdRCE4DAxAN8id2oMIM516Lo7Ev9KrcCQYT17r+qz6wKt2zs2lcV9tTphBzB/CypSc6rC/jqFRX83t3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315128; c=relaxed/simple;
	bh=tKxq6lozR5XZxwZE1ALZ3K61XVXIEQyCZYStFP2TTXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSkFjE1yE+sPAsmP42z/F6Xma9B+O9Sq2xuDjf7d916PBni7ri+RYTq48HtFLeT/+sWNBx0CUdTgnjVwDMSU739ry8nKwoRFXLfsjLjySFEC1oq3QQo6ok8HMU9gS6XQygC5AMm3S0S5kn96EKIW0fffs56jQxELhAqn4PFpmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM1tXo+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B70BC4CEE7;
	Wed, 23 Jul 2025 23:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753315128;
	bh=tKxq6lozR5XZxwZE1ALZ3K61XVXIEQyCZYStFP2TTXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GM1tXo+Qd+8+M8ZDQaLknVeO4pTbUasMza8lRFRn+07BT4LSHCIDktEDVBNyJmubg
	 bXC74F4i7qVo6FD3LVIeyR0eySyXU/viPhuxvWS0o0cQe+7hc7i9X66bnXHb40Azhr
	 RE7sHoQHIcXu3Uen5Waoah7hiBbkduFdfmV94ksbjOvL6B5VZzjowkYNoZaPPYMYaR
	 1jEMguOnx+tByI7xtHOJZuDMrU8d2cCGOxdEY84TbCtyAIQX3qC5fWWSAFsvGVrXLD
	 i5Pk1jQ9zQEup7g8x7W+gGoqOErhjMWFvs8qGyxZR8vhcSxT97n2pRMTN0VQLBZoZA
	 jcEPeMfCtqQOA==
Date: Wed, 23 Jul 2025 19:58:47 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 0/7] NFS DIRECT: handle misaligned READ and WRITE for
 LOCALIO
Message-ID: <aIF3NzVPy1kj66K5@kernel.org>
References: <20250722024924.49877-1-snitzer@kernel.org>
 <aIEskxZEnEq1qK80@kernel.org>
 <db121b40-f3da-4ecc-9e07-e3c3c8979b91@oracle.com>
 <aIF14KpfHWI2239c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIF14KpfHWI2239c@kernel.org>

On Wed, Jul 23, 2025 at 07:53:04PM -0400, Mike Snitzer wrote:
> On Wed, Jul 23, 2025 at 02:42:56PM -0400, Chuck Lever wrote:
> > On 7/23/25 2:40 PM, Mike Snitzer wrote:
> > > On Mon, Jul 21, 2025 at 10:49:17PM -0400, Mike Snitzer wrote:
> > >> Hi,
> > >>
> > >> This "NFS DIRECT" series depends on the "NFSD DIRECT" series here:
> > >> https://lore.kernel.org/linux-nfs/20250714224216.14329-1-snitzer@kernel.org/
> > >> (for the benefit of nfsd_file_dio_alignment patch in this series)
> > >>
> > >> The first patch was posted as part of a LOCALIO revert series I posted
> > >> a week or so ago, thankfully that series isn't needed thanks to Trond
> > >> and Neil's efforts.  BUT the first patch is needed, has Reviewed-by
> > >> from Jeff and Neil and is marked for stable@.
> > >>
> > >> The biggest change in v2 is the introduction of O_DIRECT misaligned
> > >> READ and WRITE handling for the benefit of LOCALIO. Please see patches
> > >> 6 and 7 for more details.
> > > 
> > > Turns out that these NFS client (fs/nfs/direct.c) changes that focused
> > > on benefiting LOCALIO actually also benefit NFSD if/when it is
> > > configured to use O_DIRECT [0].
> > > 
> > > Such that the NFS client's O_DIRECT code will split any misaligned
> > > WRITE IO and NFSD will then happily issue the DIO-aligned "middle" of
> > > a given misaligned WRITE IO down to the underlying filesystem.
> > > 
> > > Same goes for READ, NFS client will expand the front of any misaligned
> > > READ such that the bulk of the IO becomes DIO-aligned (only the final
> > > partial tail page is misaligned).
> > > 
> > > So with the NFS client changes in this series we actually don't _need_
> > > NFSD to have the same type of misaligned IO analysis and handling to
> > > expand READs or split WRITEs to be DIO-aligned.  Which reduces work
> > > that NFSD needs to do by leaning on the NFS client having the
> > > capability.
> > 
> > I'm not quite following. Does that apply to non-Linux NFS clients too?
> 
> No, old Linux clients without these changes or non-Linux clients
> wouldn't have the capabilities offered (extending READs, splitting
> WRITEs to be DIO-aligned).  The question is: do we care?  Long-term:
> probably.
> 
> I'd be fine with the NFSD DIRECT's misaligned IO support (READ already
> implemented/posted [0], WRITE partially implemented but not posted) to 
> be land upstream so that we have the benefit of making the most of
> NFSD's O_DIRECT support even if the client doesn't take steps to issue
> IO that is DIO-aligned.
> 
> Whichever way we go, it is potentially convenient that the less
> "involved" NFSD DIRECT patch 5 [0] could be withheld initially.

I meant to say: the _more_ involved NFSD DIRECT patch 5 ;)

(that said, that really patch isn't so bad... but I do recall you
hoping it cleaner, and that it'd need refinement in the future). 

> [0]: https://lore.kernel.org/linux-nfs/20250723154351.59042-6-snitzer@kernel.org/

