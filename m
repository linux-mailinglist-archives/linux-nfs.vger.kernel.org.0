Return-Path: <linux-nfs+bounces-16047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAF2C3609A
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 15:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82C3561105
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E370324B2D;
	Wed,  5 Nov 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQbE+YQw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3ED320A02
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352605; cv=none; b=Tiebrie+7a2C2XamDr9n/Po+peQGAIvpILKKEQ012a+sMDPGdS28+jBdu0DT2XFCpvXQULIG0p9xl/cxFPIbqvExnuUjoBboLCIru7akO9fg8/ONdLdnT4osX5R8Q5+lTYljCAu5i0n0qKOpYoLeor84P6N74qyterObYqWKhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352605; c=relaxed/simple;
	bh=LnGiJmFnnWFTtwx09lvZvOT1ouAK/6fiTl77LoXbVEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dK4jAkWSqm3T3mymE58lk4nbFowJUPAbJoE0gh9dsRm2xP+oHu+o+wINF2DRc3VkWfqQ0hwnGMoW0fbodjK1hk0x1uR1g24kqQ9D3GZWI/yrxJQZxzdnKeucreZHQJFpn2noAGMGn+legOUJaR+rAhE4jh03hP7j4emw/A7UyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQbE+YQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAB6C4CEF8;
	Wed,  5 Nov 2025 14:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762352605;
	bh=LnGiJmFnnWFTtwx09lvZvOT1ouAK/6fiTl77LoXbVEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pQbE+YQwI4zybJdLGL9Gz9aIWq4M/CsUxamC74F3S2cjBttrB+vbifHtk94OQRaKU
	 UExKiUGwhWytVEmc4HSBuT5+xn2H1PYRkia4RJqhgtREyPb0T443UtIdGPt2pbJOLX
	 91RAVaQhzl/QXluLP2of7szEj6g7pJXaNFnZAn8P8ZocopTpb1UmSpmigWYOmKCZOr
	 I9k3cMJxlAAjYCk6XiaHVrABs4QQeGeCl/M/GHZL+6GyUXFoeHiazBWIF3yzDxfnmT
	 DudVm4O7+Xr5bRpMUv8gLUgiTtBCspeN6SmQnVLuC5H2jOgENfGPIrD712aSs3SJJV
	 kfP7TFs9N+doA==
Message-ID: <44c9237b-db66-470c-a07a-c60afb7bf942@kernel.org>
Date: Wed, 5 Nov 2025 09:23:23 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Prevent a NULL pointer dereference in fh_getattr()
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 Christoph Hellwig <hch@lst.de>, NeilBrown <neil@brown.name>
References: <20251104160550.39212-1-cel@kernel.org>
 <176229107621.1793333.11409972513367324811@noble.neil.brown.name>
 <5907db3b-818a-470e-932a-db494dc15402@kernel.org>
 <176229517456.1793333.18248554635305336951@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <176229517456.1793333.18248554635305336951@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 5:26 PM, NeilBrown wrote:
> On Wed, 05 Nov 2025, Chuck Lever wrote:
>> On 11/4/25 4:17 PM, NeilBrown wrote:
>>> On Wed, 05 Nov 2025, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> In general, fh_getattr() can be called after the target dentry has
>>>> gone negative. For a negative dentry, d_inode(p.dentry) will return
>>>> NULL. S_ISREG() will dereference that pointer.
>>>
>>> That isn't correct.  While a reference to a dentry is held the inode
>>> cannot become NULL asynchronously.
>>> It can change from NULL to non-NULL if another thread "creates".
>>> It can become NULL if *this* thread calls unlink and no other thread has
>>> a reference.
>>> But it cannot suddenly become NULL.
>>>
>>> I like the patch as it avoids a dereference and so puts less pressure on
>>> the dcache, but it does not change correctness.
>>
>> I think the steps I'm worried about is if NFSD unlinks the file, and
>> then something subsequently invokes fh_getattr() assuming that is
>> safe to do.
> 
> nfsd never creates a svc_fh for the dentry is it about the unlink (or
> rmdir).
> A delete involves an fh for the 
> I'm guessing 
> Commit: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
> 
> is the problem.
> parent, and a name.  No fh for the child.
> 
>>
>> How should I update the patch description?
> 
> Maybe just drop the patch for now.  There is no regression and nothing
> to fix.  Maybe we can make the change latter as part of a cleanup.

OK, then. Anna, you can ignore this one and I will drop it from
nfsd-testing.


-- 
Chuck Lever

