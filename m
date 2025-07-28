Return-Path: <linux-nfs+bounces-13284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853EFB13BB9
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AD41662C6
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419B26A08D;
	Mon, 28 Jul 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Scn05CjN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242C268683
	for <linux-nfs@vger.kernel.org>; Mon, 28 Jul 2025 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710301; cv=none; b=STb9TdZ7jcLdmu4OwfVNKD4Y7GQxKET3gnC3ZLUXmdJsWdbfqMJuz9voeRbRCG9uqb+klfRf1tC/gTVsRqLN9B4MALSqK2ykPMRpOFNrNw0pLf8jW5B/k09WOm3tEIo4v2G9NQ0Hr1QWVGhycD844mQHqAIpwtF4GLmzIxj1WYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710301; c=relaxed/simple;
	bh=acgk+L6h8EHt4aZQwW3sh+fRB6357KRZ4b+5PIXFJx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1fWEZqiIVFCYJ/Y20uw3iWmBcg3EvfSCya3wsFw1foVDC2lT21vjYIOUJx3P/D5ncSqBScRSomIqWbAQ+s+mrhUCJreaWLv3zUA/s2Qg8oCjgPVsXz/2EY+AZrzrUE7avDedPSiG3171bnPHiWdQB+5v8B2eyuhStTjFJqinCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Scn05CjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AACCC4CEE7;
	Mon, 28 Jul 2025 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710301;
	bh=acgk+L6h8EHt4aZQwW3sh+fRB6357KRZ4b+5PIXFJx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Scn05CjN6B5buW3SQ2TR1/DYOIlcDQbhUuX1XAs0DyfFeVfvwhnG6q3v+LkH8J2Wv
	 z+6RE5sWaCbF0xWdWLHFqnHtrd25QfktyeNXxLlvxfnMCxLrbSDpAyd3DLt+9SGQaj
	 BqAFOtf84Mdmd5AxEc4mT72rU5MRVfXmrhxHIPx8rp3Ys4HAJFRSCnYgBcZsi5VyTS
	 QGRGVME9oCGyMY2sYh7cR1/r14wU+ztSyILX/Pe+mQ+U9O+7dCAkTSxHFlzAsX48Z2
	 fOtJWej8CLRT+PU7ir+QkzCZIBmw2ywCwP3SV9wrz7ydLQOjrvORY5+RiaGM4usxEX
	 HOEvTz/1fuU5A==
Date: Mon, 28 Jul 2025 09:44:59 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 00/13] NFSD DIRECT and NFS DIRECT
Message-ID: <aId-28yBUQ9dBt21@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
 <4db9d3dc-a2a3-4907-83bc-8bc07e38b265@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db9d3dc-a2a3-4907-83bc-8bc07e38b265@oracle.com>

On Sun, Jul 27, 2025 at 11:39:18AM -0400, Chuck Lever wrote:
> On 7/24/25 3:30 PM, Mike Snitzer wrote:
> > Hi,
> > 
> > Some workloads benefit from NFSD avoiding the page cache, particularly
> > those with a working set that is significantly larger than available
> > system memory.  This patchset introduces _optional_ support to
> > configure the use of O_DIRECT or DONTCACHE for NFSD's READ and WRITE
> > support.  The NFSD default to use page cache is left unchanged.
> > 
> > The performance win associated with using NFSD DIRECT was previously
> > summarized here:
> > https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> > This picture offers a nice summary of performance gains:
> > https://original.art/NFSD_direct_vs_buffered_IO.jpg
> > 
> > Similarly, NFS and LOCALIO in particular also benefit from avoiding
> > the page cache for workloads that have a working set that is
> > significantly larger than available system memory. Enter: NFS DIRECT,
> > which makes it possible to always enable LOCALIO to use O_DIRECT even
> > if the IO is not DIO-aligned.
> > 
> > For this v5 I've combined the NFSD and NFSD patchsets because the NFS
> > changes do depend on the the NFSD changes.  In addition, I think it
> > makes sense to review/test these changes together.
> 
> I'm ready to pull the six NFSD patches in this series into nfsd-testing.
> IMO we want regression and performance testing of NFSD, outside of the
> LOCALIO paths, before claiming merge readiness.

Makes sense, the NFSD changes are independent.  LOCALIO's access to
the dio alignment attrs in nfsd_file is a convenience.

Mike


