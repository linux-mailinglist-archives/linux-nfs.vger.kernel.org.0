Return-Path: <linux-nfs+bounces-15615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712CC0784B
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 19:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79AAC4E371F
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3417322768;
	Fri, 24 Oct 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3ZYA9fQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70B31CA7F
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326434; cv=none; b=RmbFLTLKskxFPgS0lHPa3YrPgGXBpUK1VAQMhdp1j79iNCo8AgbCxyTaS8JEz9KJ7fupNsLQf/+MKAfWu5NrBnIC0z5i8DjY8LJrfv/zo0lYI+Pi/fb3KLUDP0T/U0mBo3O1pNopYPkFijyXkqJqE6w2QQzJ8l2yhZry+Sbfsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326434; c=relaxed/simple;
	bh=rVpWJE7Br8EcDsLFh+MqlsFmZr3QkFOQWJLLEKXyhSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/Z1ua2K4SgaS5zksRq9C4DgKvcqUcQrkRojxzi6RpALHjqC3nZ3QmB/QjF74tKxZ4kPS7bmko17sdyWnyJyAwLJDqrAoRnzHBA5Z4TAz1fBQPvXg0rX2YdQptwmzLeqIPrXUXGuT4tokCM0cBvtfSU8EiU58kJaPlwcTMV9Y74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3ZYA9fQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A07C4CEF7;
	Fri, 24 Oct 2025 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761326434;
	bh=rVpWJE7Br8EcDsLFh+MqlsFmZr3QkFOQWJLLEKXyhSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3ZYA9fQuHUtCg4zxArT11ReYVWtvIiwjlDCS6Xw5E3B+l2lFxyYHVKP6HTu4NDAv
	 SLkdRtw8OUcBTLKMmkR+KtUHETJBPPEPKdCA7Jo92wCUh09qm6rjQH0xkaRe1mYtoa
	 5pCOt8S3oBo8bpA4UEjds73gSyWg4bX7KO3hnXYf5D6YKkwkCFdW9jqQGcxNzhe2kT
	 0KEkOUwM77mBMvSboCIrDSGFUHiN/SBII/pjr/JOsitr6e2iNydrkEkjavMBu2nyaB
	 c47Q0PXyUl/fc/baLKiFeI+0fbj5Jjx58wcgdIEH6TKRq5K92ON6o8dh5gruwZkstK
	 ogIhZIoWKOOgg==
Date: Fri, 24 Oct 2025 13:20:32 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 11/14] NFSD: Clean up struct nfsd_write_dio
Message-ID: <aPu1YPupahsyRnfD@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-12-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024144306.35652-12-cel@kernel.org>

On Fri, Oct 24, 2025 at 10:43:03AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Prepare for moving more common arguments into the shared per-request
> structure.
> 
> First step is to move the target nfsd_file into that structure, as
> it needs to be available in several functions.
> 
> As a clean-up, adopt the common naming of a structure that carries
> the arguments for a number of functions.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

