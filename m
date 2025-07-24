Return-Path: <linux-nfs+bounces-13243-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBEDB111D5
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 21:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2785AC845C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979622AE5D;
	Thu, 24 Jul 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlw2ryUD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532621422B
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385951; cv=none; b=RWw4dhaU+2cfX1S8iX8c9JQnCIR+6fOrB24VUZtGw532EOPgG7UuMtc2RvlwNlBka7QoeunPAZlEgep8iW2XPc8S3HFioxXC2vfd8Nq6Shyhb/q7LsN/ZlEPpCAd/5NwZi1zYN6QlD1DofPlYSEmIJ6+WI1FLAEzCWy6ig5pDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385951; c=relaxed/simple;
	bh=ss5iqmi4HhXIlCzsbNF35U6aM/q8S9KBA95FTOrUNTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzhjLOA82AFcbuJ8T2+vmhIUN/eejKV8d8bhfITv0OK++iXjnKndJaLJTRsCFJWdoBuwXXn8eAuTNZomh56QCnoyiJo8vLQXJu+hbGy0/V/hbwZbrByi3f5BJHeypfTWOvuMbUYpO/ILCFhlyzW+ENhAFEHfBIrTveSWy0f6NVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlw2ryUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28673C4CEED;
	Thu, 24 Jul 2025 19:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385951;
	bh=ss5iqmi4HhXIlCzsbNF35U6aM/q8S9KBA95FTOrUNTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hlw2ryUDs97Mlnc4BhqHdnyu0zUvrSzkSifCghV1pmQua+6SFPc6lbloJNii+4itg
	 9EtbAsp6hCFi2e5EMOzNa6vrag62xzaJGCH9p0RZ6t/RWkJQ0Yu4jW9SBYnskuUASS
	 bNwxFBZ/KUrFNPeX+97SmlrE/XyCIhV2U//Iz77YB7H4HxYCVE/uqArqb3quQwFjUu
	 uHkohVuVR5qChBTGSUcrIuLwYV6CjHk0sHu9otMWwznmGrof2c+iihQZ3csYwDjrQf
	 RdOaEcg5pgym3A8Kt6B7B+mHlbTrLKxab6Ozn0B8OZFGJAsUwGbR/mo1Wcz+/uSW5Q
	 9DvWOKxCXwoqQ==
Date: Thu, 24 Jul 2025 15:39:10 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 0/7] NFS DIRECT: handle misaligned READ and WRITE for
 LOCALIO
Message-ID: <aIKL3vzTZ5W27crD@kernel.org>
References: <20250722024924.49877-1-snitzer@kernel.org>
 <aIEskxZEnEq1qK80@kernel.org>
 <db121b40-f3da-4ecc-9e07-e3c3c8979b91@oracle.com>
 <aIF14KpfHWI2239c@kernel.org>
 <558b51b6-6f0d-434d-ac3c-a7989453017f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558b51b6-6f0d-434d-ac3c-a7989453017f@oracle.com>

On Thu, Jul 24, 2025 at 09:28:39AM -0400, Chuck Lever wrote:
> On 7/23/25 7:53 PM, Mike Snitzer wrote:
> > On Wed, Jul 23, 2025 at 02:42:56PM -0400, Chuck Lever wrote:
> >> On 7/23/25 2:40 PM, Mike Snitzer wrote:
> >>> On Mon, Jul 21, 2025 at 10:49:17PM -0400, Mike Snitzer wrote:
> >>>> Hi,
> >>>>
> >>>> This "NFS DIRECT" series depends on the "NFSD DIRECT" series here:
> >>>> https://lore.kernel.org/linux-nfs/20250714224216.14329-1-snitzer@kernel.org/
> >>>> (for the benefit of nfsd_file_dio_alignment patch in this series)
> >>>>
> >>>> The first patch was posted as part of a LOCALIO revert series I posted
> >>>> a week or so ago, thankfully that series isn't needed thanks to Trond
> >>>> and Neil's efforts.  BUT the first patch is needed, has Reviewed-by
> >>>> from Jeff and Neil and is marked for stable@.
> >>>>
> >>>> The biggest change in v2 is the introduction of O_DIRECT misaligned
> >>>> READ and WRITE handling for the benefit of LOCALIO. Please see patches
> >>>> 6 and 7 for more details.
> >>>
> >>> Turns out that these NFS client (fs/nfs/direct.c) changes that focused
> >>> on benefiting LOCALIO actually also benefit NFSD if/when it is
> >>> configured to use O_DIRECT [0].
> >>>
> >>> Such that the NFS client's O_DIRECT code will split any misaligned
> >>> WRITE IO and NFSD will then happily issue the DIO-aligned "middle" of
> >>> a given misaligned WRITE IO down to the underlying filesystem.
> >>>
> >>> Same goes for READ, NFS client will expand the front of any misaligned
> >>> READ such that the bulk of the IO becomes DIO-aligned (only the final
> >>> partial tail page is misaligned).
> >>>
> >>> So with the NFS client changes in this series we actually don't _need_
> >>> NFSD to have the same type of misaligned IO analysis and handling to
> >>> expand READs or split WRITEs to be DIO-aligned.  Which reduces work
> >>> that NFSD needs to do by leaning on the NFS client having the
> >>> capability.
> >>
> >> I'm not quite following. Does that apply to non-Linux NFS clients too?
> > 
> > No, old Linux clients without these changes or non-Linux clients
> > wouldn't have the capabilities offered (extending READs, splitting
> > WRITEs to be DIO-aligned).  The question is: do we care?  Long-term:
> > probably.
> 
> It sounds like we can't rely on clients to align the payload for NFSD.
> So I'd say "we care".

Not old or non-Linux clients, no...

> Maybe NFSD could recognize when the content is already properly aligned
> and take a shorter code path? I'm not familiar enough with your patches
> yet to make a guess.

Its pretty well optimized as-is, yes.  So that isn't a major concern.

I've just posted a rolled up v5 that keeps the NFSD capability, thanks
for your guidance.

Mike

