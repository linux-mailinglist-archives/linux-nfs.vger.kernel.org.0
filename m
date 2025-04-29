Return-Path: <linux-nfs+bounces-11346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2DCAA0D9E
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4160F467C58
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B42D029B;
	Tue, 29 Apr 2025 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THf3bN8K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA3211A0B;
	Tue, 29 Apr 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934102; cv=none; b=AIKdQWOtDlGhi+sqq4d7sm2fQLGORuugaVK5IuRg9GEGG4TTWWCTLP0WrXn2ckf/87IvQP0MZTUmnjcB2UKcbCL4j5l6DXQj64o33+nDcCyRCd6lK+6wWbWyd03Sn0snXV/Lvb/j9ktOL6rni8uhBvWGCq1jRM2aUEdmY1rBlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934102; c=relaxed/simple;
	bh=PcqXcEJ0ZDxDV7ymGlZUBXZpHIOmqxFidgh9uSohAEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNWVomhz3wj6/hQeeAK5j+MJ9+/uh7W7Dis195nGwtBfHRHFtxFYD/SLkH9C4kQ0wuFXlFVze1w9PCjfP3iYdjp1b7paBLec8it12nE84kpWCGJi/aPGjQ5SIVYhs1XiwqkqOAXrJBmnAln5Bk/4aNuW6UHBnvlceOzh7eZylU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THf3bN8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B504C4CEEB;
	Tue, 29 Apr 2025 13:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745934101;
	bh=PcqXcEJ0ZDxDV7ymGlZUBXZpHIOmqxFidgh9uSohAEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=THf3bN8KGHPC7TKiXj0zPr3dPjzTQR2WzxCS638AgKzqSbbaDUKwnOx8PPeEERXYq
	 q7iL2cOciLDvVY3NsNFoUM8c+q4vLv6MtcBRB5nX02pTgfZox0jekEVg4UHHTcLb7X
	 IK2idQ98Cz60+7faaeWTb2E89cnNKAhlH2+YXW9vYqQNNdeykgaEO3odFwpCv9XzcQ
	 pGCg8sG6jcZQuIpMHMi32Bx4fb5syLFrzM4R7XCFEvow/4wWTQMD1fExEoRLKNtTxp
	 z21jwGKRYLB5jMOZHexuP4O7t//8Lo7xTAitdvEIdDB1yh/IAN+n+q0cs5Kzw72cF7
	 sG1WRhhB66kOQ==
Message-ID: <dd92aff7-06b0-4eb9-8644-002563cc522b@kernel.org>
Date: Tue, 29 Apr 2025 09:41:39 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Allocate payload arrays dynamically
To: Zhu Yanjun <yanjun.zhu@linux.dev>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250428193702.5186-1-cel@kernel.org>
 <25bb4881-f83b-41c7-8924-d760aa63405b@linux.dev>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <25bb4881-f83b-41c7-8924-d760aa63405b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/29/25 9:06 AM, Zhu Yanjun wrote:
> On 28.04.25 21:36, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> In order to make RPCSVC_MAXPAYLOAD larger (or variable in size), we
>> need to do something clever with the payload arrays embedded in
>> struct svc_rqst and elsewhere.
>>
>> My preference is to keep these arrays allocated all the time because
>> allocating them on demand increases the risk of a memory allocation
>> failure during a large I/O. This is a quick-and-dirty approach that
>> might be replaced once NFSD is converted to use large folios.
>>
>> The downside of this design choice is that it pins a few pages per
>> NFSD thread (and that's the current situation already). But note
>> that because RPCSVC_MAXPAGES is 259, each array is just over a page
>> in size, making the allocation waste quite a bit of memory beyond
>> the end of the array due to power-of-2 allocator round up. This gets
>> worse as the MAXPAGES value is doubled or quadrupled.
>>
>> This series also addresses similar issues in the socket and RDMA
>> transports.
>>
>> v4 is "code complete", unless there are new code change requests.
>> I'm not convinced that adding XDR pad alignment to svc_reserve()
>> is good, but I'm willing to consider it further.
>>
>> It turns out there is already a tuneable for the maximum read and
>> write size in NFSD:
>>
>>    /proc/fs/nfsd/max_block_size
> 
> Hi,
> 
> Based on the head commit ca91b9500108 Merge tag 'v6.15-rc4-ksmbd-server-
> fixes' of git://git.samba.org/ksmbd, I applied this patch series.
> 
> When I built the kernel, the following error will pop out.
> "
> In file included from ./arch/x86/include/asm/bug.h:103,
>                  from ./include/linux/bug.h:5,
>                  from ./arch/x86/include/asm/paravirt.h:19,
>                  from ./arch/x86/include/asm/irqflags.h:102,
>                  from ./include/linux/irqflags.h:18,
>                  from ./include/linux/spinlock.h:59,
>                  from ./include/linux/fs_struct.h:6,
>                  from fs/nfsd/nfs4proc.c:35:
> fs/nfsd/nfs4proc.c: In function ‘nfsd4_write’:
> ./include/linux/array_size.h:11:38: warning: division ‘sizeof (struct
> kvec *) / sizeof (struct kvec)’ does not compute the number of array
> elements [-Wsizeof-pointer-div]
>    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +
> __must_be_array(arr))
>       |                                      ^
> ./include/asm-generic/bug.h:111:32: note: in definition of macro
> ‘WARN_ON_ONCE’
>   111 |         int __ret_warn_on = !!(condition);                      \
>       |                                ^~~~~~~~~
> fs/nfsd/nfs4proc.c:1231:30: note: in expansion of macro ‘ARRAY_SIZE’
>  1231 |         WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
>       |                              ^~~~~~~~~~
> ./include/linux/compiler.h:197:62: error: static assertion failed: "must
> be array"
>   197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct
> {_Static_assert(!(e), msg);}))
>       | ^~~~~~~~~~~~~~
> ./include/asm-generic/bug.h:111:32: note: in definition of macro
> ‘WARN_ON_ONCE’
>   111 |         int __ret_warn_on = !!(condition);                      \
>       |                                ^~~~~~~~~
> ./include/linux/compiler.h:202:33: note: in expansion of macro
> ‘__BUILD_BUG_ON_ZERO_MSG’
>   202 | #define __must_be_array(a) __BUILD_BUG_ON_ZERO_MSG(!
> __is_array(a), \
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/array_size.h:11:59: note: in expansion of macro
> ‘__must_be_array’
>    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +
> __must_be_array(arr))
>       | ^~~~~~~~~~~~~~~
> fs/nfsd/nfs4proc.c:1231:30: note: in expansion of macro ‘ARRAY_SIZE’
>  1231 |         WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
>       |                              ^~~~~~~~~~
> make[4]: *** [scripts/Makefile.build:203: fs/nfsd/nfs4proc.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:461: fs/nfsd] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:461: fs] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/home/zyanjun/Development/github-linux/Makefile:2011: .]
> Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> "

The patches actually are to be applied to nfsd-testing, which has a
patch that removes the errant WARN_ON_ONCE.

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=a356997303fbea4914bfbdad9645c61d88b28c4d

If you apply that one-liner first, then this series, it should compile
properly.


> The building host is as below:
> 
> $ cat /etc/issue.net
> Ubuntu 22.04.5 LTS
> 
> $ gcc --version
> gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> Copyright (C) 2021 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> $ uname -a
> Linux lb03055 6.8.0-58-generic #60~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
> Fri Mar 28 16:09:21 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> 
> 
> Zhu Yanjun
> 
>>
>> Since there is an existing user space API for this, my initial
>> arguments against adding a tuneable are moot. max_block_size should
>> be adequate for this purpose, and enabling it to be set to larger
>> values should not impact the kernel-user space API in any way.
>>
>> Changes since v3:
>> * Improved the rdma_rw context count estimate
>> * Dropped "NFSD: Remove NFSSVC_MAXBLKSIZE from .pc_xdrressize"
>> * Cleaned up the max size macros a bit
>> * Completed the implementation of adjustable max_block_size
>>
>> Changes since v2:
>> * Address Jeff's review comments
>> * Address Neil's review comments
>> * Start removing a few uses of NFSSVC_MAXBLKSIZE
>>
>> Chuck Lever (14):
>>    svcrdma: Reduce the number of rdma_rw contexts per-QP
>>    sunrpc: Add a helper to derive maxpages from sv_max_mesg
>>    sunrpc: Remove backchannel check in svc_init_buffer()
>>    sunrpc: Replace the rq_pages array with dynamically-allocated memory
>>    sunrpc: Replace the rq_vec array with dynamically-allocated memory
>>    sunrpc: Replace the rq_bvec array with dynamically-allocated memory
>>    sunrpc: Adjust size of socket's receive page array dynamically
>>    svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
>>    svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
>>    sunrpc: Remove the RPCSVC_MAXPAGES macro
>>    NFSD: Remove NFSD_BUFSIZE
>>    NFSD: Remove NFSSVC_MAXBLKSIZE_V2 macro
>>    NFSD: Add a "default" block size
>>    SUNRPC: Bump the maximum payload size for the server
>>
>>   fs/nfsd/nfs4proc.c                       |  2 +-
>>   fs/nfsd/nfs4state.c                      |  2 +-
>>   fs/nfsd/nfs4xdr.c                        |  2 +-
>>   fs/nfsd/nfsd.h                           | 24 ++++-------
>>   fs/nfsd/nfsproc.c                        |  4 +-
>>   fs/nfsd/nfssvc.c                         |  2 +-
>>   fs/nfsd/nfsxdr.c                         |  4 +-
>>   fs/nfsd/vfs.c                            |  2 +-
>>   include/linux/sunrpc/svc.h               | 45 +++++++++++++--------
>>   include/linux/sunrpc/svc_rdma.h          |  6 ++-
>>   include/linux/sunrpc/svcsock.h           |  4 +-
>>   net/sunrpc/svc.c                         | 51 +++++++++++++++---------
>>   net/sunrpc/svc_xprt.c                    | 10 +----
>>   net/sunrpc/svcsock.c                     | 15 ++++---
>>   net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  8 +++-
>>   net/sunrpc/xprtrdma/svc_rdma_rw.c        |  2 +-
>>   net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 16 ++++++--
>>   net/sunrpc/xprtrdma/svc_rdma_transport.c | 14 ++++---
>>   18 files changed, 122 insertions(+), 91 deletions(-)
>>
> 


-- 
Chuck Lever

