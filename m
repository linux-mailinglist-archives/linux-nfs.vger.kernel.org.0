Return-Path: <linux-nfs+bounces-15105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44EABCA9F3
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 20:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB1E1A63D46
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5598421FF38;
	Thu,  9 Oct 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9sSzQ2T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5A21A95D
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036208; cv=none; b=OEi+YBXm8bcvxOzB1lzfLTAVARn5fWaUbuLtJ94/d1XuNDbfluQ4Q7sSvh5xhoH/akutf/7IadKjJTd258VBMLDiCMwt7guooh4jpb/ud6JfyeRi2RJjkX66fpN+k6cAgcc3u0KQAHtdEry7HssNOxbhUpHXlgQ9NhWundMmnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036208; c=relaxed/simple;
	bh=q/nn3g4pVpp6XQG2KGPdV6eJWPzJn0Q25kLoj/MNg+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npeJTWtI2HGav4HtxO1PHZHLqkE2vYaxcnYaRVn0k2HAN51xqZ2Qn+P8Bnj0ABlAwV7WquBX5axyOAZ1vqpZBlnrTXWCzGLC3hBSMsreAptJoqD9xcVyWZhkLwxkD2VJ85QHHazZspQZIv/Ihyv41ilZciSCGd3ViMDOR8jL/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9sSzQ2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A085BC4CEF8;
	Thu,  9 Oct 2025 18:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760036207;
	bh=q/nn3g4pVpp6XQG2KGPdV6eJWPzJn0Q25kLoj/MNg+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D9sSzQ2T1YQnnhOLr6iWn7AX4j4N7Oqq4BDn+DH1ufH72F29N/IY127CvgWh69+Ld
	 t2XzNBwGSTVnkh+btg2oD1prehkdbGx0YwyJmahd0gyMs86Am5EvbqfONDiu32ZKXG
	 GPkua90gwRNE0bEgKoMgi9xRI2ESVJMRXgTRzI4tPWx/rXowoRX6k61mKZz9msRH4r
	 awVR3ildXK99sS+MawJgV49LgXh/GKEfhguQV1T2kWYFFWXcolkyVQzH31IG1PVFGW
	 CkCj2qMAM4Bg++ElIzubWOOAylFQda6766TJpRFNfOuAXOcg1hp6MhXlwbXf4611pT
	 5zo1XBh0TTrfQ==
Message-ID: <d7a8abbc-6660-4b21-88a5-bf969c71a561@kernel.org>
Date: Thu, 9 Oct 2025 14:56:45 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from
 supported attributes
To: Olga Kornievskaia <aglo@umich.edu>
Cc: jlayton@kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 Dai.Ngo@oracle.com, tom@talpey.com, NeilBrown <neil@brown.name>
References: <20251009173835.83690-1-okorniev@redhat.com>
 <176003277769.4149.545859393892148978.b4-ty@oracle.com>
 <CAN-5tyG4-SybxVuGrixG04PRNEOAwdOYYdaWGNx72XfmMNtQiQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <CAN-5tyG4-SybxVuGrixG04PRNEOAwdOYYdaWGNx72XfmMNtQiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/9/25 2:18 PM, Olga Kornievskaia wrote:
> On Thu, Oct 9, 2025 at 2:07 PM Chuck Lever <cel@kernel.org> wrote:
>>
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> On Thu, 09 Oct 2025 13:38:35 -0400, Olga Kornievskaia wrote:
>>> RFC 7862 Section 4.1.2 says that if the server supports CLONE it MUST
>>> support clone_blksize attribute.
>>>
>>>
>>
>> Applied to nfsd-testing, thanks!
> 
> I just realized that NFSD4_2_SECURITY_ATTRS value is larger so
> FATTR4_WORD2_CLONE_BLKSIZE should be before that. Do you want me to do
> v3?

Yes, please send a v3.


>> [1/1] nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
>>       commit: fcc43f116744ac6d34f2bd77c1be34e8171d3d3c
>>
>> --
>> Chuck Lever <chuck.lever@oracle.com>
>>


-- 
Chuck Lever

