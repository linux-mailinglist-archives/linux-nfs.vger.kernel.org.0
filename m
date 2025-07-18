Return-Path: <linux-nfs+bounces-13155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57889B0A65A
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388403A3452
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5CA2DAFCC;
	Fri, 18 Jul 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq6MHBp2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE6199931
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848825; cv=none; b=QdMrcgT4v+Tb1MxUid6EE7OLiqR2+T/qSgcQDQ+XuAt1+YfI6Gk7xqyHr7V7ghCxgVDeJwdXr7fdOG21rAneQUDn6YqLnRUjJoAR7elXgJGNZvpsxumcoX355cBtWl7kIypn4eig1+/DWZjFZuovG7bcnK3/er8ewb/cPhj1d0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848825; c=relaxed/simple;
	bh=uzrfb/xBki3Sc/tHIp3XnZRAC+0h5ojk60Va0GNcWec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0WiDFrI1GeVgy0EqRIr4zCS8NZzp4ODOAJxloA/sgH+9ikTtoDfSQoMs/Dv7ACaUFM3SOYVLCDVcdgeMgC6RB5fQqrBEYFE7CSNd0d+AMVNjA8RGX66t/m746FyjKzONEW6dw6OTZmAYJa2mf1Sq8AREh50ZIdes3JlHQIN9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq6MHBp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB913C4CEEB;
	Fri, 18 Jul 2025 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752848825;
	bh=uzrfb/xBki3Sc/tHIp3XnZRAC+0h5ojk60Va0GNcWec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eq6MHBp2S+RqMHDzr0vy8+TAvnw0ssYonyDjwyk+YrjPSsmZ2Fums8qEG+QDYLHzs
	 3ify+GlkdQFIpcaUlpjqpbvmPMFQYhuJdyMBbcUrE3t7EAEAvekFCFHCoG/0q4BkHN
	 0sWnmJHwt/gZnaqBw+AZK8V24zYOTTVpm2eJMlUer+G639IhjO+yKoWZ/2ZxrSb4kr
	 KvgFehbPWk95Zy4dj2N+aq8FVqCPVTFTvltREwXjBPaMXSbIeJmhm7/BSom1mNQj7M
	 Xti/sJPMrRib5orU2jV6HzY/r7NDuYyuJBcrBzoVCG6TKdJOMBlOnTMoN5oAJCVR19
	 pLMMPyesQdMXg==
Date: Fri, 18 Jul 2025 10:27:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2 RFT] nfsd: fix another problem with recent localio
 changes
Message-ID: <aHpZt4U38tcc5X89@kernel.org>
References: <20250718012831.2187613-1-neil@brown.name>
 <175284851548.1668994.14828037670346771563.b4-ty@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175284851548.1668994.14828037670346771563.b4-ty@oracle.com>

On Fri, Jul 18, 2025 at 10:25:26AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> On Fri, 18 Jul 2025 11:26:13 +1000, NeilBrown wrote:
> > Mike reports ongoing problem with leakage of refcounts for the net in
> > nfsd when localio is used.  I believe the first patch fixes one possible
> > cause.  The second patch removes some related dead code.
> > 
> > Mike: thanks for your testing so far.  Hopefully you could find time to
> > test this one too?
> > 
> > [...]
> 
> Applied to nfsd-testing, thanks!
> 
> I assume 1/2 should be expedited? If so, I can add a Cc: stable and
> get it into v6.17-rc.

Yes, it should be expedited.

Thanks,
Mike

> 
> [1/2] nfsd: avoid ref leak in nfsd_open_local_fh()
>       commit: 3ae40032ec9e2a829fb5ab1ebaa92d5d2b1fae89
> [2/2] nfsd: discard nfsd_file_get_local()
>       commit: 470c6ae5e920028abc2ef0044a05023977c4058c
> 
> --
> Chuck Lever
> 

