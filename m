Return-Path: <linux-nfs+bounces-14080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81806B46289
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 20:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CAD5E0294
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A5305967;
	Fri,  5 Sep 2025 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMoO2jEg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A0290F
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097939; cv=none; b=vEGtfLfv7ssEdOurxgQ2irziraYPwY17mKBUCJruyZLc5U4BKHs5A/phCFC9dSSkTDYOjYw7udsvCxnbuZx38w49altrqqOcLFROFxgraGLSUBFKCJzi7cDedMrvPMPb6/EoiNGH0JG2M2nmEH+9CCVnK1OiL6xrg86OycD88XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097939; c=relaxed/simple;
	bh=6HqpV11SGjBCJV0SO6fV9bbi7yQKzvKJkq9jFom/1D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZTS2PPLR2ZUYDRBdHqPw3mdSN7fSTCabAx4R2+2OLXpUrIzIQWpiFUS2Rtc2D/56Xlrz3jykOO4hzFeEU5aLb9cCPPOOqMq9iL/iHVvkeizXg457V4cUoIgBFwCk+FkerL/S0BSAv165dCFDt808bVXE6yTxgI7W/x3zOcVMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMoO2jEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB03C4CEF1;
	Fri,  5 Sep 2025 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757097938;
	bh=6HqpV11SGjBCJV0SO6fV9bbi7yQKzvKJkq9jFom/1D0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aMoO2jEgLQk35DvTI5RnjoloJ249n7QPRElCQIrRtL+BFTNNv47PeVS8ZEee1uTya
	 3StX8ItsfCTGNcuUTYqa+LwhcRs7RFMexOUCxJ/oSg1en9LJAEQBfzlNLKTE5q59SO
	 zJhzAPtOUsRL+ssv41JbeQaJpIk3wiLjPXMfOMAUe8GHy25sqwcG98FZNOWpJWIDML
	 Wtiv5i2DMBlMXlVh2Wagbc03ryasxl9Jomtc/m6tiuNpdbAE9dLp8d8xM/LQiuikY8
	 ZFPiJMt9OYgZCqzKY7QpVVS0LIPcAE+jHit7U3boBAXm/zv6nUyAKi/8/9LM1Ql+ZA
	 C/pdgj2QprNEA==
Message-ID: <4a24c9a1-a56d-46db-90f9-b626c05f027c@kernel.org>
Date: Fri, 5 Sep 2025 14:45:37 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD: Add io_cache_{read,write} controls to debugfs
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250905145509.8678-1-cel@kernel.org>
 <aLseneIE3Mubr5uV@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aLseneIE3Mubr5uV@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 1:32 PM, Mike Snitzer wrote:
> On Fri, Sep 05, 2025 at 10:55:09AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Aside from attribution, which I suspect you didn't intend to switch
> these changes from being attributed to me, this looks good (one small
> nit below).

I didn't intend to change the attribution, you're right. My tool
chain's squashing always changes the patch authorship and I don't
always remember to catch it.

I will fix that up.


>> Add 'io_cache_read' to NFSD's debugfs interface so that any data
>> read by NFSD will either be:
>> - cached using page cache (NFSD_IO_BUFFERED=0)
>> - cached but removed from the page cache upon completion
>>   (NFSD_IO_DONTCACHE=1).
>>
>> io_cache_read may be set by writing to:
>>   /sys/kernel/debug/nfsd/io_cache_read
>>
>> Add 'io_cache_write' to NFSD's debugfs interface so that any data
>> written by NFSD will either be:
>> - cached using page cache (NFSD_IO_BUFFERED=0)
>> - cached but removed from the page cache upon completion
>>   (NFSD_IO_DONTCACHE=1).
>>
>> io_cache_write may be set by writing to:
>>   /sys/kernel/debug/nfsd/io_cache_write
>>
>> The default value for both settings is NFSD_IO_BUFFERED, which is
>> NFSD's existing behavior for both read and write. Changes to these
>> settings take immediate effect for all exports and NFS versions.
>>
>> If NFSD_IO_DONTCACHE is specified, all exported filesystems must
>> implement FOP_DONTCACHE, otherwise IO flagged with RWF_DONTCACHE
>> will fail with -EOPNOTSUPP.

Btw, I'd like NFSD to fall back to buffered I/O if the file system's
FOP_DONTCACHE flag is not set. Do you have an objection to that?


>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/debugfs.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++
>>  fs/nfsd/nfsd.h    |  9 +++++
>>  fs/nfsd/vfs.c     | 19 ++++++++++
>>  3 files changed, 121 insertions(+)
>>
>> Changes from Mike's v9:
>> - Squashed the "io controls" patches together
>> - Removed NFSD_IO_DIRECT for the moment
>> - Addressed a few more checkpatch.pl nits
>>
>> This gives a cleaner platform on which to build the direct I/O code
>> paths, and does not expose partially implemented I/O modes to users.
>>
>> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
>> index 84b0c8b559dc..2b1bb716b608 100644
>> --- a/fs/nfsd/debugfs.c
>> +++ b/fs/nfsd/debugfs.c
>> @@ -44,4 +131,10 @@ void nfsd_debugfs_init(void)
>>  
>>  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
>>  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
>> +
>> +	debugfs_create_file("io_cache_read", 0644, nfsd_top_dir, NULL,
>> +			    &nfsd_io_cache_read_fops);
>> +
>> +	debugfs_create_file("io_cache_write", 0644, nfsd_top_dir, NULL,
>> +			    &nfsd_io_cache_write_fops);
>>  }
> 
> Relative to checkpatch warnings, this ^ code is what I'm aware of.
> For consistency I stuck with "S_IWUSR | S_IRUG", whereas you honored
> checkpatch's suggestion to use 0644.
> 
> Maybe update disable-splice-read to also use 0644 too? But your call!

Still debating that myself. It's a change that is not related to the
purpose of this patch, so I probably should do that kind of clean-up
separately.

-- 
Chuck Lever

