Return-Path: <linux-nfs+bounces-16048-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B6BC36115
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 15:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CD184E6FC4
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5CA326D61;
	Wed,  5 Nov 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2+dLoza"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E5315D3F
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352975; cv=none; b=DJMnRimBG58xC/5/T/CtL1Pp6oOSCYp4Z0rkNOM/scUUUeMWD96YoHhoFpljmKztrN0hd64VC4zWf/E6kWAl/JTqkbJp0ce+1hdJTlmzetm+89rxbQm3b0Eqix9HaYIQVeiFmyabw0EvOR+KVPmJUkV2J2tCtkep9W7Xh54yDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352975; c=relaxed/simple;
	bh=T6MA5qn0JTS5Xiap4PMuqZECAFtMDJxKTGl1/oFlTxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f9pUm1GvPBg7Na0pDrtei5LLpxx4b6qc8znNRZ5CfzLwWZIR99m+oJ3Bkt6/FpnYe76Vkv1051qOVZVG0Ehm4556weYOOczeIHZpJP5yAphw8Bo/6AAh/c2ESDZ8rLfl0Q5Cyzx0M8D0hqfvaPIjlswkw1ERtuoNxhxFDlu9EZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2+dLoza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD99C4CEF8;
	Wed,  5 Nov 2025 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762352974;
	bh=T6MA5qn0JTS5Xiap4PMuqZECAFtMDJxKTGl1/oFlTxw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=L2+dLozaRsXU4XBLVKQBDmCFKLiyxnSkHJDH/WBTbl2U2fzE4sNqo+IjERsWVeIPt
	 LMpoEgGc30gAfchIAiIujviyuvtAahNfuLWW0RhDtrxEkdaCFNTJjxVF2MDQFwouA1
	 uIb8odDQvrMZyd9KuaAW6vTDRASIQU9nX6M5fDEyTuZ3JCA/C01POVcjUSnJexC2TG
	 ZI8PyRY99kCCqpcWxm87YKt+uXletJSsuud418UIM2zPmRPN6qeQj4hBxh3UGcrXZW
	 DLlpWjh5+9+10pfcAU5EVHBNWj4o6FWJSRkIEIiXIPJIGwt3gksmWBLBKlAuU/9NDv
	 3XQ0QfjnV6JWg==
Message-ID: <ab235dbe-7949-4208-a21a-2cdd50347152@kernel.org>
Date: Wed, 5 Nov 2025 09:29:33 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
To: Mike-SPC via Bugspray Bot <bugbot@kernel.org>, linux-nfs@vger.kernel.org,
 trondmy@kernel.org, neilb@brown.name, anna@kernel.org, neilb@ownmail.net,
 jlayton@kernel.org
References: <20251104-b220745c0-91170b3b3642@bugzilla.kernel.org>
 <20251105-b220745c4-f9376314d23f@bugzilla.kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20251105-b220745c4-f9376314d23f@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 7:25 AM, Mike-SPC via Bugspray Bot wrote:
> Mike-SPC writes via Kernel.org Bugzilla:
> 
>> Have you found a 6.1.y kernel for which the build doesn't fail?
> 
> Yes. Compiling Version 6.1.155 works without problems.
> Versions >= 6.1.156 aren't.

My analysis yesterday suggests that, because the nfs4state.c code hasn't
changed, it's probably something elsewhere that introduced this problem.
As we can't reproduce the issue, can you use "git bisect" between
v6.1.155 and v6.1.156 to find the culprit commit?


-- 
Chuck Lever

