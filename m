Return-Path: <linux-nfs+bounces-14980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3267BBB8F7D
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Oct 2025 17:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70A03A7A01
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Oct 2025 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEDA224225;
	Sat,  4 Oct 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyh1egiN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920120E023
	for <linux-nfs@vger.kernel.org>; Sat,  4 Oct 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759593117; cv=none; b=aJEsK7nhD/FkBBDyjm0binPCtzUJ6HjdWCsrxCU2w38ULK0nTVj1lzqP6nOpD6bjUCvTR8nub7eyzxlun310eqg46bKZLcd+VwRomElzb7Cb7mNctdFbDXN/NV1TageFLXytGE/NKRKaR2CVkfWyqR/kA/rxRssvfqpijQ6qwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759593117; c=relaxed/simple;
	bh=myAWSqv+qpyt0h+rcaGpSptSJEGCK+aSilsXGxgB40U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwQ/TtFcM6YxO5aXwTff7MbskzQI+brR6FyPX1zNCmEzV8Mf/DF4ev4lqHR2KuNLWWzyy6FHe7TEFTkhLEuqoF3K76CZK9qVCU2a1iqzAm7hsIQnTrI79DfkHbZFk9/H/l5NhRqxYn7uhPj2llG6zlZMMnWaDFU3QHT4v5J1GGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyh1egiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC1AC4CEF1;
	Sat,  4 Oct 2025 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759593116;
	bh=myAWSqv+qpyt0h+rcaGpSptSJEGCK+aSilsXGxgB40U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cyh1egiNos3r8c7w+bpZ8DUXjxxX3V+JzwwL26cVFYwMshdNkdkHYiQfQertr1BVm
	 MTIMcoqjawkuplZ9vWei/eMDEPe8UuDA8tOR2eheEwb8WFYgYAtfILe6gF83CvrY6j
	 YSP/Cpbh6WmrFn64w9q0cXGfbfrSeA5DaN8Cjayr40LKMmEuoyeVwwMamvmfeTsEzI
	 tcVWIl0id71o+JVckmeKrr53z2pKOIt2CxqwbGlGqVukpleNXa83/W/IRJzjRju0NW
	 ZDOoMV2KLw2tI9Yh+c4Gzclt4KjYHv2e8yVtSSxMCkpubyVCeZxDpaYkvlgzLUO0Yv
	 L66OzAF69+Pqw==
Message-ID: <4b075b4e-8c7f-4712-a2dd-864146e1db3f@kernel.org>
Date: Sat, 4 Oct 2025 11:51:55 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Fix crash in nfsd4_read_release()
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250930140520.2947-1-cel@kernel.org>
 <175928003792.1696783.17556773248679753110@noble.neil.brown.name>
 <57b7be9c-dcbb-477d-b453-736fa7ddcfe4@kernel.org>
 <175947529411.247319.1453292585395648663@noble.neil.brown.name>
 <2313f8b9-56ae-4b38-a419-1d5ab8582914@kernel.org>
 <175955965542.1793333.13223432830700758756@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175955965542.1793333.13223432830700758756@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/25 2:34 AM, NeilBrown wrote:
> On Fri, 03 Oct 2025, Chuck Lever wrote:
>> I was reminded of a release-related change that Jeff did recently, maybe
>> commit 15a8b55dbb1b ("nfsd: call op_release, even when op_func returns
>> an error")... might be relevant, might not.
> 
> Definitely relevant.  I think this is the commit to mention in the
> Fixes: tag.  Prior to this commit nfsd4_read_release wouldn't have been
> called if there was no filehandle, so the trace point was perfectly
> safe.

I'll replace the Fixes: tag with that one.


> I wonder if this fix by Jeff was the best fix for the problem.
> An alternative would be to require ->op_func to release any resources
> before returning an error..... except that wouldn't work for 
> OP_NONTRIVIAL_ERROR_ENCODE functions like OP_LOCK as the ->op_release
> frees the "deny" info which is needed to encode the reply....
> 
> But wait ...nfs4_encode_operation - which currently calls ->op_release -
> is also called from nfsd4_enc_sequence_replay().  The status is set to
> an error so ->op_release previously would not have been called, but now
> it is.  Could that mean nfsd4_lock_release() can get called there even
> tough nfsd4_lock wasn't called.  Could that be a problem?  It isn't
> clear to me that is *isn't* a problem, should maybe there is a subtlety
> that saves it.

One approach to getting experimental data would be to hack together a
pynfs test for this case. (If it proves useful, please contribute it).


> I'm beginning to think that we don't want an op_release at all.
> Anything allocated in ->op_func should either be freed in ->op_func when
> an error is detected, or in the corresponding nfsd4_enc_ops function
> after the allocated value is used for encoding.
> 
> Looking further...
>  ->op_get_currentstateid is only called immediately before the one time
>  that ->op_func is called.  So ->op_func could do that
>  get_currentstateid work.
>  and ->op_set_currentstateid looks like it could be folded in to
>  ->op_func as well.
> 
> Does anyone have any thoughts about that?

Careful review needed, I think. We are getting ready for a week of
bake-a-thon next week... that might delay any deep thinking on my
part for a few days.


-- 
Chuck Lever

