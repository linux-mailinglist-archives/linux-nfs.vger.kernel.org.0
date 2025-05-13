Return-Path: <linux-nfs+bounces-11679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8323CAB5457
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B87B2218
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 12:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A828428DB5B;
	Tue, 13 May 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp/BTNsQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59828DB52;
	Tue, 13 May 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138128; cv=none; b=XJbog3vOwwNmdDR6B3BnuGwzbAMLAbtHE1Ot5uIARPtvYRbqPEJ3wIETvXWeJH7eerROm0CEisNmjoJgEiTYXjzwvsE9+4TvHNZOaYXzZF2bx/ajz3Uu7peenwv9wj7UG6KiroccV1bxVX46/hzPeer+NZ0YPCGmaUTVmmC+41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138128; c=relaxed/simple;
	bh=+gG1y3Sw7LHwPQA6iYUTGnAJfQQI2+PpZHgVSsm6SWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvcXnXFpsMwJMu6MqlGH7xpIOWF4eA5EO/f8RwMxg+jhpcgjSOJZ6o0dyj7pWlSKrqKm8KOvsYb5Lk1TbRHon8N5YF7D1+UTYT7fP/VnuIUnvqevxC+5F7HQCOwcjpPCpiGtE/vw6VcGY0o//RAClYz7GU+xs7s4AMEw6a7wDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp/BTNsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B852C4CEE4;
	Tue, 13 May 2025 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747138128;
	bh=+gG1y3Sw7LHwPQA6iYUTGnAJfQQI2+PpZHgVSsm6SWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gp/BTNsQde89QRPv1/Ox8lvlz3Mg75VP6dTW8Nbeia2SwrLolY9iA5J7A0c1Rsi1h
	 ybPiJ529e5VA7QeuVhGmSZXUjb8T/pzUZEOuaBXzY1jvR2CHqNRLI+WcZKdmw11DLY
	 LJam/Uh+QOu/b55NEStC0ZM0eBzYHmum1hnu6D1FXzPD2Rr33fymhAOPLby7TDcTMQ
	 mBzydp79usGCDZ+TaL630BhqdA47sEnlaSCPjMjnvzK+9DisGRT8gY4sUoq3DvWHNJ
	 HqeLU/qAdSzXcakF7vjc47+XJylbxUOdJIOMJay9U//z6oU87CHMN7xvj0/2OtNPzL
	 Hj4iScwAU+n4g==
Message-ID: <0cda91fc-27fe-48ad-954f-60e88f10ac1d@kernel.org>
Date: Tue, 13 May 2025 08:08:46 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/19] SUNRPC: Bump the maximum payload size for the
 server
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250509190354.5393-1-cel@kernel.org>
 <20250509190354.5393-20-cel@kernel.org>
 <CA+1jF5pLds8XYfsBqVsJOmr4b+YaXPdHzUNWmtx8aQLec6UKZQ@mail.gmail.com>
 <8179372a-1d5a-42b7-b84d-72a8dcefbdd1@kernel.org>
 <CA+1jF5rpxD8NSMxzURWEF+RsgwhVXsr5pmDs_zDYe5nfJk0V2g@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <CA+1jF5rpxD8NSMxzURWEF+RsgwhVXsr5pmDs_zDYe5nfJk0V2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/13/25 4:42 AM, Aurélien Couderc wrote:
> On Mon, May 12, 2025 at 8:09 PM Chuck Lever <cel@kernel.org> wrote:
>>
>> On 5/12/25 12:44 PM, Aurélien Couderc wrote:
>>> Could this patch series - minus the change to the default of 1MB - be
>>> promoted to Linux 6.6 LongTermSupport, please?
>>
>> It has to be merged upstream first.
>>
>> But, new features are generally not backported to stable. At this time,
>> this feature is intended only for future kernels.

To be utterly clear, I don't set the rules about what goes into the LTS
kernels.


> 1. I could argue that this patch series - minus the change to the
> default of 1MB - is a "necessary cleanup", removing half broken buffer
> size limits
> 2. The patch series makes  /proc/fs/nfsd/max_block_size usable
> 
> IMO this qualifies the patch series for stable@

I'm not aware of any misbehavior in this area that qualifies as a
security issue, a crasher, or a performance regression. Those are
the kind of issues that would qualify this series for backport.


-- 
Chuck Lever

