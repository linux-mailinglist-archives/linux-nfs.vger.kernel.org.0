Return-Path: <linux-nfs+bounces-3639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA4C902BCE
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 00:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16041B21809
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 22:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D2415099A;
	Mon, 10 Jun 2024 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY3xYXnb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239D15098A
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059081; cv=none; b=odqvJOJ6y0lcPgLclwLguehLrGpsUDBCbpQfiItdk/RSv6vjQtmXaX1O9RE6j4A/uw9AnoxZExjbOdiqiAbMDlCS/4A353mzfrzfi6UfZN4fsTMLywfQmTIPlrXxz5nshUM6HqR+Rv2NqPK8Akc+xy6ga84z70NHNM7sswxQf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059081; c=relaxed/simple;
	bh=1nkIysZWfRlHY9guRh4p8B21nF+r5VNHvTVTBJ6Dun4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foiN2bCTWSfLsr9DBSa2yOILGz2Oi1jAZvdPqtkxyFbCc6ZeuK3bJiGsf8p4+Ve5R9BieTof8qPLwoLihOQ4ByfI7hpH68spZGH/HG6U5nQE7qm0EuRLINz1eLo5aEA5f/s1PGtBn3Nb1/JRyxYzJYRK1DViWXdFJ5LA7cGy0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY3xYXnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EBCC2BBFC;
	Mon, 10 Jun 2024 22:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718059081;
	bh=1nkIysZWfRlHY9guRh4p8B21nF+r5VNHvTVTBJ6Dun4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZY3xYXnbXjcPLt9DF0FRTJa1M/eFNRRXs6WuuDnN5CN3qIKhKDfZBumhXm8pR31oa
	 4tZSYgWwfLKQV+Dt9umHskWq1sQqjC+u+FTlwm6Ub4r8ql0WwSu2uVqwF6upJYXZnJ
	 frCsDI2vELAJh8T3hKxfFpTSc82k3ShawTfZlf3929qG0GtaI9a4Lngqx/wrKXvtHi
	 kmrCex2467WuIsmjuveYlDzRZA9RV+7zM31Qiz5Dwv6M5Jhdyc5CSNvsJwFU7HMZzX
	 6aYZPn3l9X4/BHkOB4WobXQJJDCdn7gmWBU1c91WQK1Wbz7PRsogtx+pXTrSKXG8Uq
	 qA3/pWxvEL5/A==
Date: Mon, 10 Jun 2024 18:37:59 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 30/29] nfs/nfsd: ensure localio server always
 uses its network namespace
Message-ID: <ZmeAR-y1PzOTyV6j@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
 <ZmNMCejlYlDgfA1Q@kernel.org>
 <ZmXN2/e5FmRXsvIG@tissot.1015granger.net>
 <Zmcux5OZbspwpXRo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmcux5OZbspwpXRo@kernel.org>

On Mon, Jun 10, 2024 at 12:50:15PM -0400, Mike Snitzer wrote:
> On Sun, Jun 09, 2024 at 11:44:27AM -0400, Chuck Lever wrote:
> > 
> > For some reason, I received only patch 30/29.
> > 
> > -- 
> > Chuck Lever
> 
> Odd, I did send 30/29 after as a follow-up (in reply to 00/29).  But
> linux-nfs definitely got the 29 other patches.
> 
> I'll be sure to cc you for v2!

Looking closer, I don't think linux-nfs allowed the initial patchset.

So I just fixed my mail config so that I'm properly using smtp.kernel.org

It'll go smoother when I post v2 ;)

Mike

