Return-Path: <linux-nfs+bounces-11589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F78AAE80D
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 19:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A5F1C4274A
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 17:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C6E28D837;
	Wed,  7 May 2025 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuLeYnz5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066B28D832;
	Wed,  7 May 2025 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639680; cv=none; b=aO5QeGwyelqlkCIyCKwgylIKCRoIeuYbvUfD47El65tnB7Isi6+dDa4Qf7XBWluSBJ8joveVrtRgTOv/5+QXuylAt8x5rIXS6xQUwaA35qgZXb5HCERi0P39Sai048sPMaDyxV14y7gX4ZchP1jpGRqUHmsMNHH1wb9r0ar/yIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639680; c=relaxed/simple;
	bh=3LQTGdNoqr3Q9SxnNq89u3ihVfysGpiY0Jp+7E60hcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imfa86fKBzN/P/n+Xh4PFcak661Tn65IBKvCmP6Xw9/xC8npNpyfU/sCniu4D1O3LGHTfcUGAlg5A4QkGzgiWe5LzE+JTwkh3e1QYOPdU3ktD4YcNxpOcU1Z25jSS9WEqovDLkwZWSHh3l7wCbnfii6FpPDBxAMyrsnh+dhNVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuLeYnz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC295C4CEE2;
	Wed,  7 May 2025 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746639679;
	bh=3LQTGdNoqr3Q9SxnNq89u3ihVfysGpiY0Jp+7E60hcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tuLeYnz5eOp7/1vFmO06w4hZmarYT0CVCb+irOQke8LbEQAcHphJVRQ1diLXoQQSP
	 PTcJOJ6rJcn7G13YBQtwBiRE6CmzL5SAcm5g41r6mPji/GuRKYfyF1pBQ925xmrYaB
	 sXw2l+6Umr47MqYonD1zzhuyWupuLaLPi8eCVhYJf9P4jjBJKIDQghoOu2Pb9ln006
	 yjJVowcM6qC09mpQxMJ3lHbsrhYe1XczWqrgBgiNxz8oSvruIFgQoQRffCV+iS8hTf
	 uxP+4FdD1LdndOJHr25siBw206Wqs4cvMiTg0BOmNLhYrLmZes90htOoewntNuLTRl
	 tP69sIlBvwWHA==
Message-ID: <974a6289-802d-4cd8-b67c-26584af89810@kernel.org>
Date: Wed, 7 May 2025 13:41:17 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Roland Mainz <roland.mainz@nrubsig.org>,
 Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org
References: <20250507144515.6864-1-cel@kernel.org>
 <b73ee4d1184e91b540edaeb22d939fea852d482e.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <b73ee4d1184e91b540edaeb22d939fea852d482e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 11:34 AM, Jeff Layton wrote:
> On Wed, 2025-05-07 at 10:45 -0400, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> RFC 7862 states that if an NFS server implements a CLONE operation,
>> it MUST also implement FATTR4_CLONE_BLKSIZE. NFSD implements CLONE,
>> but does not implement FATTR4_CLONE_BLKSIZE.
>>
>> Note that in Section 12.2, RFC 7862 claims that
>> FATTR4_CLONE_BLKSIZE is RECOMMENDED, not REQUIRED. Likely this is
>> because a minor version is not permitted to add a REQUIRED
>> attribute. Confusing.
> 
> Isn't CLONE itself an optional operation? It wouldn't make sense to
> REQUIRE this attribute on servers that don't support CLONE, so I think
> it makes sense that it should be optional. Anyway, I'm just being
> pedantic.

My take:

It's problematic that one part of the specification states that
FATTR4_CLONE_BLKSIZE is mandatory-to-implement (with a MUST), and
another categorizes the attribute as RECOMMENDED.

I understand the reasons why this might be necessary, but IMO
implementers who do not read the whole document might see one or the
other of these (because they are in widely separated sections) and then
do the wrong thing.

Section 12.2 needs to provide an explicit explanation to make it clear.


-- 
Chuck Lever

