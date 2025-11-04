Return-Path: <linux-nfs+bounces-16000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42945C3176A
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 15:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F97B1895047
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A2C32C944;
	Tue,  4 Nov 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u65a0PLc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4A32C93A
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265654; cv=none; b=E7zBgMqyiA+XS0FQ9aB/+8jVSC/Qhy6tFIRsee8tdRYJOSlofeTd9P+6VGwccrB82uDzL5i/tpj3f36YhcvCfURoUZTvjH+PxrEMuKOcLwl939UhFH5S+uFQ18pPCydeNCPJEbBO2qkvhATuem6aG/nQ6wGTTLcZcuTfPn68DCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265654; c=relaxed/simple;
	bh=CQT6skr33iDTXAfxsXB7VqbRRIBPIkbDmOGujfjTixc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvmKD4Tscl/Tf0AbnnwXcy2fSu0jGqXkmhakIsDwioN43H58AXQySNPwNesc2XhKRHqVcWUTnMsQHUIYm+beAIfVI7U2uud6tYfC5ERX1BEhg8h0lxF9AmP9H1cWjFu8kzqXglya1Wdu63ihdAIK2DdsxB163S6HreDUdCQWW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u65a0PLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79371C116B1;
	Tue,  4 Nov 2025 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265651;
	bh=CQT6skr33iDTXAfxsXB7VqbRRIBPIkbDmOGujfjTixc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u65a0PLcC421AEqSdkkUiCqsarpOvjoLeO6uKZtbJg/akweNcRyQ77RYSVbdnf1x6
	 gQVaZ06Fq/L0L0Vpu3Nxw0nHklKNf9Z13ZHEhAwGUDvu96wy8g8OcIatX7UYVYWc8l
	 w782lPhN8VhnS4RXlwwdItPxlh8yqbbsxuNDDih4x4uL/0YxAcKzF2rSajoeSnaOI8
	 sj9VErfGRFA8JuqXFIZKaozzfKsNKXslzeH2ehyDYsht4nxgIy9+suFDR7a8Fth/u9
	 iMYI/W8lfgijjTq5aok1YF9JykyZwh19/ED2pgt2auRka1LRQaPY0GV6xyqtNHN6Q3
	 JGe76ZQ1QAzpg==
Message-ID: <35ddc8b0-2727-453e-b970-07b493e21f93@kernel.org>
Date: Tue, 4 Nov 2025 09:14:09 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/12] NFSD: Remove alignment size checking
To: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-6-cel@kernel.org>
 <176220902556.1793333.10293656800242618512@noble.neil.brown.name>
 <aQnpB4mYMwW9IGM0@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQnpB4mYMwW9IGM0@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 6:52 AM, Christoph Hellwig wrote:
> On Tue, Nov 04, 2025 at 09:30:25AM +1100, NeilBrown wrote:
>> On Tue, 04 Nov 2025, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> Noted that the NFS client's LOCALIO code still retains this check.
>>
>> It might be good to capture here *why* the check is removed.
>> Is it because alignments never exceed PAGE_SIZE, or because the code is
>> quite capable of handling larger alignments
>> (I haven't been following the conversation closely..)
> 
> I'm still trying to understand why it was added in the first place :)

I'm trying to understand what action you'd like me to take. Should I
drop this patch?


> But I'm also completely lost in the maze of fixup patches.
Several people have asked me to collapse the fix-ups into a single
patch. We would lose some history and attributions doing that. Does
anyone have other thoughts?

-- 
Chuck Lever

