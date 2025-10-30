Return-Path: <linux-nfs+bounces-15800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44EC21078
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 16:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 926F64EDA9B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BFE2773F0;
	Thu, 30 Oct 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZexz1TV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B521823B60A
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839237; cv=none; b=Ou2Qi+7YNbLW6h52V+DT3g6asUTbMvAA1i1KLlAEPkbegpkz9OkwZB2auvwq5LsweFYAZYXcyejyoa6AcUCBknTApOvXOWeOUoP5MXcyPVmCdLDU2hpTMw8iIj+IyS1k6hadhzb+Q/QwA5v0CCqXRbLowwXfGQZQ3I5O5UC7JzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839237; c=relaxed/simple;
	bh=wOKMOXDDr095IhcPu30VfusA3Xmfl11UEO3G6vtIVEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwNRjNNWOWsRZHGt8nSk2Fn5/nnYBqUsEuewEQh8TJhVhQjNYVxvlJNQU0PP7MYc1nG49ZZ3pJknwWL4/4d6/zzg/Z5dig5d7h/pRA62AQ8P18Gnk6YohIdoWUBTJ0lKvR1AmFX+RuH9t5Rx0Siqqe8S69do5/k+U3eUFDofa/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZexz1TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE010C4CEF1;
	Thu, 30 Oct 2025 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761839237;
	bh=wOKMOXDDr095IhcPu30VfusA3Xmfl11UEO3G6vtIVEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kZexz1TV8833mSNETsL5dKK/qD0bFwlSiSckh4hPcAd0VarsrhrRMUYoauSUyBo2H
	 yJi2jJvE7V7eGiFceflNQeM/fbW5qws+ZOIiu+KyZvIQG81UzO0zEwB4s7ifuR8eYm
	 XMutuyYMgi6wsEAhd+KjioIuC2CidOHbhDGqwj2RADWoulYiPXWdSzT7pcicC51z1D
	 jcZvBVuRP+pOsD3mQRwixSFoUhwAC06T8Q6Yp/94a9xOBNaoPPpJNRxpa24JDLXGnG
	 cA/3RJU+RZuiwRnsTYFZslB7O5DIP6aXZTyADXMkQ6N5IFIESmlgQBaP3HXAmro73Y
	 j/povcA1FAo9w==
Message-ID: <d046ee5e-4944-43aa-b859-21d85eb55dd6@kernel.org>
Date: Thu, 30 Oct 2025 11:47:15 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Add a "file_sync" export option
To: Mike Snitzer <snitzer@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251030125638.128306-1-cel@kernel.org>
 <aQN0Er33HIVmhBWh@infradead.org> <aQOFLMJzUZuwj_K7@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQOFLMJzUZuwj_K7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 11:33 AM, Mike Snitzer wrote:
>>> This patch is a year old, so won't apply to current kernels. But
>>> the idea is similar to Mike's suggestion that NFSD_IO_DIRECT
>>> should promote all NFS WRITEs to durable writes, but is much
>>> simpler in execution. Any interest in revisiting this approach?
>> This is a much better approach than overloading direct I/O with
>> these semantics.  I'd still love to see actual use cases for which
>> we see benefits before merging it.

And the reason it hasn't been merged yet is because I couldn't find any
such workloads. Even tmpfs was a little slower without the COMMITs,
to my surprise.


> Yes.  Also thinking that a "data_sync" export option would be
> appropriate too (that way to have the ability to try all stable_how
> variants).  Chuck?  If something like that sounds OK in theory I can
> rebase your patch (still attributed to you) and then create a separate
> to add "data_sync" and then work to get the permutations tested.

If you want to experiment, feel free.

As always, I'm not enthusiastic about exposing a bunch of tuning knobs
like this without a clear understanding of how it benefits users and
what documentation might look like explaining how to use it. So for the
moment, this patch is, as labeled in the Subject: field, an RFC, and not
a firm/official proposal for an API change. (Note that IIRC, adding the
new export option was an idea we had /before/ we had
/sys/kernel/debug/nfsd available to us).

Or to put it differently, just because I proposed this patch does not
mean it's automatically "Chuck approved". I'm interested in experimental
results first. I'm thinking you have access to big iron on which to try
it.

But, in the bigger picture, I think comparison between this approach
and NFSD_IO_DIRECT might be illustrative.


-- 
Chuck Lever

