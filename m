Return-Path: <linux-nfs+bounces-4681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A60D9293B6
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EED1C20D60
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBC9200CB;
	Sat,  6 Jul 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqlP/p/z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B214C79
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720271566; cv=none; b=g8VTXP5mM9epubN6o94Y4LivXB2Be+X74++pGcOz9LdVPY1KVA4C9zgRzM9HIhjV11Ia7oTtP95WUbFD214PBm5/BMzKLnxXtw3W7V33ecLYpXz1ueRh0JDmDvAQcObxWtCm4XHSDRc88mFnRB1l0yai7/nK8DQ4WXMEnHCze5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720271566; c=relaxed/simple;
	bh=nmMDWuq/pX7MdLlKv91JlaT8sUAWcbKYJjWcLSyPmeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgBPYgcoDRaf2B/JGJ0+IzyiZl2bdJ4E+oQo9i1dzNyOYE/g/Fx76+C9QZp6ecKZYBfuXyBGjC+Ks3GJ7tqOmdFkJZ7KlZj7Dq50iq/+GjYxjZn14uIvwNgWDdt083UC4xqosyHKE7CIxZD4Kc5cyhoYS7quTetdE+vrjKp8Gjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqlP/p/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB73C2BD10;
	Sat,  6 Jul 2024 13:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720271566;
	bh=nmMDWuq/pX7MdLlKv91JlaT8sUAWcbKYJjWcLSyPmeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqlP/p/zGXZQg5NZoZp3AghfiuUTwMYsVzxz803625BEyb+0IbzTMr27QI+8Bphxv
	 9kBbrRt7AbZOE2Klr+7VtOA2LqJlbPWLKqH2MGwMgz7Rft1BZzgsdW6Qjm2JNiuejd
	 /eM9gHqGSAR0kUFAae64pF0IjYzSOJJNGaaCHgbwFaAHAFkrfBLPX4rI/BXtGFB5dr
	 ElG7MuK3kpjdrJw3H0AlS8G9SQZDlwEG3ZBPSaOgNvd8ZNhfAH5Qb+ClrPp2WBs9Bv
	 Q5oamwbLFSq1ZQCcdW3K35yqQ0Jf3j69ODMPLoGK8iN0FLn+valBmK2BDO8SLBPlCl
	 7Fv4VJNBvdU1g==
Date: Sat, 6 Jul 2024 09:12:44 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZolCzHWhJN-R4Kvg@kernel.org>
References: <ZoY6e-BmRJFLkziG@infradead.org>
 <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
 <ZogAEqYvJaYLVyKj@kernel.org>
 <ZogAtVfeqXv3jgAv@infradead.org>
 <ZogFBqv0z7Rnh4_p@kernel.org>
 <990C712E-99B0-4227-B67D-0DBAA2B2B72E@oracle.com>
 <ZojBAC3XYIee9wN2@kernel.org>
 <Zojc-v8C2ChEOMjq@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zojc-v8C2ChEOMjq@infradead.org>

On Fri, Jul 05, 2024 at 10:58:18PM -0700, Christoph Hellwig wrote:
> On Fri, Jul 05, 2024 at 11:58:56PM -0400, Mike Snitzer wrote:
> > I'm out-gunned with this good-cop/bad-cop dynamic.  I was replying to
> > Christoph.  Who has taken to feign incapable of understanding localio
> > yet is perfectly OK with flexing like he is an authority on the topic.
> 
> Hi Mike,
> 
> please take a few days off and relax, and then write an actual use case
> and requirements document.  I'm out of this thread for now, but I'd
> appreciate if you'd just restart, assuming no one is activing in bad
> faith and try to explain what you are doing and why without getting
> upset.

If you'd like reasonable people to not get upset with you, you might
try treating them with respect rather than gaslighting them.

