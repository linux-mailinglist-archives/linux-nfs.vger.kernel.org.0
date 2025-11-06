Return-Path: <linux-nfs+bounces-16135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F742C3C2EF
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 16:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990094EFB97
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4F132AAD8;
	Thu,  6 Nov 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSzrFJ/x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CA12E6116
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444355; cv=none; b=nnL7a8/JsX7NoeX4d94PzI7UvY1agSkAOZ3+ui5xNulkMnZVmpOJ39ffYpz8UdKSyWXQr8TmKbhTutuGS0fn3M/CUrNs1xjyknmsVU9exbuiFzJmt3wnj6IoQVfzfebShy9YI0Tbbh3gBRlhrukkNR2p3Hq80RTnUhDg4ukSFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444355; c=relaxed/simple;
	bh=JkCckHMras07fsd5JJwt2KkTEHjpc4QLi524XdjlqXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjZ+NgPXFWt840ghI4fkI3WEX4sReZ2Tv4UWvK2ERuqqccnsTuIOrXDqHHbz0RnWwvkGoXUkN/B85DSILDIAoPFCvPNZ1qP+CezzCWfZ5m0z6xNymatVyzZ64LVlFDvsSYpZ/ExSRLjTqIGd0JGY57FdwXHh66MZmQWZzAxjQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSzrFJ/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2BFC16AAE;
	Thu,  6 Nov 2025 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762444354;
	bh=JkCckHMras07fsd5JJwt2KkTEHjpc4QLi524XdjlqXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CSzrFJ/xssqlq7oobw64AnQ7zMHehDCIZP+kBwU7kjx84RCtGOZMJ60OETVRGPbL1
	 359Ker99UenhKZGCcREwCguhocCn/EuFGqbajZ3FKoRPqdDEAzHh/kreoTH86WgC4v
	 dyHMb+xK13ZZeIcesvMTm+z8ty8U3xgiL+QdJle3l9zGyKItSXUlhH3XyoP/aPKK3Y
	 MnAVueu1rEjAd8QjpUMqU2oIKqFiOPNUUqpudq98LBynNxU1ulXezP9uOAmvcpS1xk
	 ggWRN6FBBxC+Zsp9J/octMTe5DHuTayVpZXyWNuI31CbPAGfpSc5yVOP2S9INOsc1e
	 bi8YVH/F/NLbw==
Message-ID: <9705aa01-eec8-471f-b18b-41017dbd7440@kernel.org>
Date: Thu, 6 Nov 2025 10:52:33 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/5] NFSD: add
 Documentation/filesystems/nfs/nfsd-io-modes.rst
To: Mike Snitzer <snitzer@kernel.org>, NeilBrown <neilb@ownmail.net>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-6-cel@kernel.org>
 <176242464673.634289.9740740689934261321@noble.neil.brown.name>
 <aQzC85evu-w3-apF@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQzC85evu-w3-apF@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 10:46 AM, Mike Snitzer wrote:
> On Thu, Nov 06, 2025 at 09:24:06PM +1100, NeilBrown wrote:
>> On Thu, 06 Nov 2025, Chuck Lever wrote:
>>> From: Mike Snitzer <snitzer@kernel.org>
>>>
>>> This document details the NFSD IO modes that are configurable using
>>> NFSD's experimental debugfs interfaces:
>>>
>>>   /sys/kernel/debug/nfsd/io_cache_read
>>>   /sys/kernel/debug/nfsd/io_cache_write
>>>
>>> This document will evolve as NFSD's interfaces do (e.g. if/when NFSD's
>>> debugfs interfaces are replaced with per-export controls).
>>>
>>> Future updates will provide more specific guidance and howto
>>> information to help others use and evaluate NFSD's IO modes:
>>> BUFFERED, DONTCACHE and DIRECT.
>>>
>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>  .../filesystems/nfs/nfsd-io-modes.rst         | 150 ++++++++++++++++++
>>>  1 file changed, 150 insertions(+)
>>>  create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst
>>>
>>> diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentation/filesystems/nfs/nfsd-io-modes.rst
>>> new file mode 100644
>>> index 000000000000..29b84c9c9e25
>>> --- /dev/null
>>> +++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
>>> @@ -0,0 +1,150 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +=============
>>> +NFSD IO MODES
>>> +=============
>>> +
>>> +Overview
>>> +========
>>> +
>>> +NFSD has historically always used buffered IO when servicing READ and
>>> +WRITE operations. BUFFERED is NFSD's default IO mode, but it is possible
>>> +to override that default to use either DONTCACHE or DIRECT IO modes.
>>> +
>>> +Experimental NFSD debugfs interfaces are available to allow the NFSD IO
>>> +mode used for READ and WRITE to be configured independently. See both:
>>> +- /sys/kernel/debug/nfsd/io_cache_read
>>> +- /sys/kernel/debug/nfsd/io_cache_write
>>> +
>>> +The default value for both io_cache_read and io_cache_write reflects
>>> +NFSD's default IO mode (which is NFSD_IO_BUFFERED=0).
>>> +
>>> +Based on the configured settings, NFSD's IO will either be:
>>> +- cached using page cache (NFSD_IO_BUFFERED=0)
>>> +- cached but removed from page cache on completion (NFSD_IO_DONTCACHE=1)
>>> +- not cached stable_how=NFS_UNSTABLE (NFSD_IO_DIRECT=2)
>>> +- not cached stable_how=NFS_DATA_SYNC (NFSD_IO_DIRECT_WRITE_DATA_SYNC=3)
>>> +- not cached stable_how=NFS_FILE_SYNC (NFSD_IO_DIRECT_WRITE_FILE_SYNC=4)
>>> +
>>> +To set an NFSD IO mode, write a supported value (0 - 4) to the
>>> +corresponding IO operation's debugfs interface, e.g.:
>>> +  echo 2 > /sys/kernel/debug/nfsd/io_cache_read
>>> +  echo 4 > /sys/kernel/debug/nfsd/io_cache_write
>>> +
>>> +To check which IO mode NFSD is using for READ or WRITE, simply read the
>>> +corresponding IO operation's debugfs interface, e.g.:
>>> +  cat /sys/kernel/debug/nfsd/io_cache_read
>>> +  cat /sys/kernel/debug/nfsd/io_cache_write
>>> +
>>> +NFSD DONTCACHE
>>> +==============
>>> +
>>> +DONTCACHE offers a hybrid approach to servicing IO that aims to offer
>>> +the benefits of using DIRECT IO without any of the strict alignment
>>> +requirements that DIRECT IO imposes. To achieve this buffered IO is used
>>> +but the IO is flagged to "drop behind" (meaning associated pages are
>>> +dropped from the page cache) when IO completes.
>>> +
>>> +DONTCACHE aims to avoid what has proven to be a fairly significant
>>> +limition of Linux's memory management subsystem if/when large amounts of
>>> +data is infrequently accessed (e.g. read once _or_ written once but not
>>> +read until much later). Such use-cases are particularly problematic
>>> +because the page cache will eventually become a bottleneck to servicing
>>> +new IO requests.
>>> +
>>> +For more context on DONTCACHE, please see these Linux commit headers:
>>> +- Overview:  9ad6344568cc3 ("mm/filemap: change filemap_create_folio()
>>> +  to take a struct kiocb")
>>> +- for READ:  8026e49bff9b1 ("mm/filemap: add read support for
>>> +  RWF_DONTCACHE")
>>> +- for WRITE: 974c5e6139db3 ("xfs: flag as supporting FOP_DONTCACHE")
>>> +
>>> +If NFSD_IO_DONTCACHE is specified by writing 1 to NFSD's debugfs
>>> +interfaces, FOP_DONTCACHE must be advertised as supported by the
>>> +underlying filesystem (e.g. XFS), otherwise all IO flagged with
>>> +RWF_DONTCACHE will fail with -EOPNOTSUPP.
>>
>> If FOP_DONTCACHE isn't advertised, nfsd doesn't even try RWF_DONTCACHE,
>> so error don't occur.
>>
>> Maybe:
>>
>>   "NFSD_IO_DONTCACHE will fall back to NFSD_IO_BUFFERED if the
>>   underlying filesystem doesn't indicaate support by setting
>>   FOP_DONTCACHE."
>>
>>> +
>>> +NFSD DIRECT
>>> +===========
>>> +
>>> +DIRECT IO doesn't make use of the page cache, as such it is able to
>>> +avoid the Linux memory management's page reclaim scalability problems
>>> +without resorting to the hybrid use of page cache that DONTCACHE does.
>>> +
>>> +Some workloads benefit from NFSD avoiding the page cache, particularly
>>> +those with a working set that is significantly larger than available
>>> +system memory. The pathological worst-case workload that NFSD DIRECT has
>>> +proven to help most is: NFS client issuing large sequential IO to a file
>>> +that is 2-3 times larger than the NFS server's available system memory.
>>> +The reason for such improvement is NFSD DIRECT eliminates a lot of work
>>> +that the memory management subsystem would otherwise be required to
>>> +perform (e.g. page allocation, dirty writeback, page reclaim). When
>>> +using NFSD DIRECT, kswapd and kcompactd are no longer commanding CPU
>>> +time trying to find adequate free pages so that forward IO progress can
>>> +be made.
>>> +
>>> +The performance win associated with using NFSD DIRECT was previously
>>> +discussed on linux-nfs, see:
>>> +https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
>>> +But in summary:
>>> +- NFSD DIRECT can significantly reduce memory requirements
>>> +- NFSD DIRECT can reduce CPU load by avoiding costly page reclaim work
>>> +- NFSD DIRECT can offer more deterministic IO performance
>>> +
>>> +As always, your mileage may vary and so it is important to carefully
>>> +consider if/when it is beneficial to make use of NFSD DIRECT. When
>>> +assessing comparative performance of your workload please be sure to log
>>> +relevant performance metrics during testing (e.g. memory usage, cpu
>>> +usage, IO performance). Using perf to collect perf data that may be used
>>> +to generate a "flamegraph" for work Linux must perform on behalf of your
>>> +test is a really meaningful way to compare the relative health of the
>>> +system and how switching NFSD's IO mode changes what is observed.
>>> +
>>> +If NFSD_IO_DIRECT is specified by writing 2 (or 3 and 4 for WRITE) to
>>> +NFSD's debugfs interfaces, ideally the IO will be aligned relative to
>>> +the underlying block device's logical_block_size. Also the memory buffer
>>> +used to store the READ or WRITE payload must be aligned relative to the
>>> +underlying block device's dma_alignment.
>>> +
>>> +But NFSD DIRECT does handle misaligned IO in terms of O_DIRECT as best
>>> +it can:
>>> +
>>> +Misaligned READ:
>>> +    If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
>>> +    DIO-aligned block (on either end of the READ). The expanded READ is
>>> +    verified to have proper offset/len (logical_block_size) and
>>> +    dma_alignment checking.
>>> +
>>> +    Any misaligned READ that is less than 32K won't be expanded to be
>>> +    DIO-aligned (this heuristic just avoids excess work, like allocating
>>> +    start_extra_page, for smaller IO that can generally already perform
>>> +    well using buffered IO).
>>
>> I couldn't find this 32K in the code.
>>
>> Do we want to say something like:
>>
>>   If you experiment with this on a recent kernel have have interesting
>>   results, please report them to linux-nfs@vger.kernel.org
>>
>> Thanks,
>> NeilBrown
>>
> 
> Thanks for the review, I clearly missed some clean up.  Chuck, please
> consider applying this incremental patch which should address Neil's
> feedback and remove some stable_how related changes that aren't
> relevant without my corresponding patch:
> 
> diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentation/filesystems/nfs/nfsd-io-modes.rst
> index 29b84c9c9e25..e3a522d09766 100644
> --- a/Documentation/filesystems/nfs/nfsd-io-modes.rst
> +++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
> @@ -23,19 +23,20 @@ Based on the configured settings, NFSD's IO will either be:
>  - cached using page cache (NFSD_IO_BUFFERED=0)
>  - cached but removed from page cache on completion (NFSD_IO_DONTCACHE=1)
>  - not cached stable_how=NFS_UNSTABLE (NFSD_IO_DIRECT=2)
> -- not cached stable_how=NFS_DATA_SYNC (NFSD_IO_DIRECT_WRITE_DATA_SYNC=3)
> -- not cached stable_how=NFS_FILE_SYNC (NFSD_IO_DIRECT_WRITE_FILE_SYNC=4)
>  
> -To set an NFSD IO mode, write a supported value (0 - 4) to the
> +To set an NFSD IO mode, write a supported value (0 - 2) to the
>  corresponding IO operation's debugfs interface, e.g.:
>    echo 2 > /sys/kernel/debug/nfsd/io_cache_read
> -  echo 4 > /sys/kernel/debug/nfsd/io_cache_write
> +  echo 2 > /sys/kernel/debug/nfsd/io_cache_write
>  
>  To check which IO mode NFSD is using for READ or WRITE, simply read the
>  corresponding IO operation's debugfs interface, e.g.:
>    cat /sys/kernel/debug/nfsd/io_cache_read
>    cat /sys/kernel/debug/nfsd/io_cache_write
>  
> +If you experiment with NFSD's IO modes on a recent kernel and have
> +interesting results, please report them to linux-nfs@vger.kernel.org
> +
>  NFSD DONTCACHE
>  ==============
>  
> @@ -59,10 +60,8 @@ For more context on DONTCACHE, please see these Linux commit headers:
>    RWF_DONTCACHE")
>  - for WRITE: 974c5e6139db3 ("xfs: flag as supporting FOP_DONTCACHE")
>  
> -If NFSD_IO_DONTCACHE is specified by writing 1 to NFSD's debugfs
> -interfaces, FOP_DONTCACHE must be advertised as supported by the
> -underlying filesystem (e.g. XFS), otherwise all IO flagged with
> -RWF_DONTCACHE will fail with -EOPNOTSUPP.
> +NFSD_IO_DONTCACHE will fall back to NFSD_IO_BUFFERED if the underlying
> +filesystem doesn't indicate support by setting FOP_DONTCACHE.
>  
>  NFSD DIRECT
>  ===========
> @@ -115,11 +114,6 @@ Misaligned READ:
>      verified to have proper offset/len (logical_block_size) and
>      dma_alignment checking.
>  
> -    Any misaligned READ that is less than 32K won't be expanded to be
> -    DIO-aligned (this heuristic just avoids excess work, like allocating
> -    start_extra_page, for smaller IO that can generally already perform
> -    well using buffered IO).
> -
>  Misaligned WRITE:
>      If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
>      middle and end as needed. The large middle segment is DIO-aligned

Thanks, that saves me some time!


-- 
Chuck Lever

