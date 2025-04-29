Return-Path: <linux-nfs+bounces-11344-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23744AA0CF8
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 15:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9247B3C85
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Apr 2025 13:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB702D29BD;
	Tue, 29 Apr 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I9gNd578"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D32D29AB
	for <linux-nfs@vger.kernel.org>; Tue, 29 Apr 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931999; cv=none; b=GCcgBnk+jy3k80mP9mEvvdYzjQzTRt7iWY/W/cNq5prxUE64JnQWN0lBg/okHaTP6WGezLWiLm3fEGcptmObLIW7jGjPLh97SBAA6NXHXSux52nDa39uaYv3YJNpGBR+/izhVMyaXonLunHNPmGoI/6anY43WGJbIqfD0lEPzdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931999; c=relaxed/simple;
	bh=Q/vxq5UvCQQjyZxlYbt8QY1f9jAj3uSmlYeLS+pTtf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qS45YvQFm9NHsR0/+oEekn2vlEV5LodDZZ/GPHLbk7WD9X16ICJ8ZQ2SdIpwBK+GcAGP9gVkJS97U2lYZ3qeGL7aiPPDzrxHsR1+341MwD/UA8WVwBzt4XutDLLXm400lxolxbrZJn2gdcKl1LXbQP3FN7+95epnOlYbrUwyTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I9gNd578; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25bb4881-f83b-41c7-8924-d760aa63405b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745931984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiH2E925xmb9CRTaBpGq9AcGhppZqAVjkc8LbbV0lMo=;
	b=I9gNd5783QQoPAYQ4yL6AE7eQQGQPmvVwW0pzGOWEWN9j2Ud+149Lg0lMoGgRpa2S31yYK
	dwQrFyLIfppjvYoqt39zQBTnjeSMITJJa62BdZyt2kLAr59FqaGRCBQTp+IPLVhjG3ohXz
	Klrnl4P+Q0/1ofb9omrg8tCCvspYwLY=
Date: Tue, 29 Apr 2025 15:06:18 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 00/14] Allocate payload arrays dynamically
To: cel@kernel.org, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250428193702.5186-1-cel@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 28.04.25 21:36, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In order to make RPCSVC_MAXPAYLOAD larger (or variable in size), we
> need to do something clever with the payload arrays embedded in
> struct svc_rqst and elsewhere.
> 
> My preference is to keep these arrays allocated all the time because
> allocating them on demand increases the risk of a memory allocation
> failure during a large I/O. This is a quick-and-dirty approach that
> might be replaced once NFSD is converted to use large folios.
> 
> The downside of this design choice is that it pins a few pages per
> NFSD thread (and that's the current situation already). But note
> that because RPCSVC_MAXPAGES is 259, each array is just over a page
> in size, making the allocation waste quite a bit of memory beyond
> the end of the array due to power-of-2 allocator round up. This gets
> worse as the MAXPAGES value is doubled or quadrupled.
> 
> This series also addresses similar issues in the socket and RDMA
> transports.
> 
> v4 is "code complete", unless there are new code change requests.
> I'm not convinced that adding XDR pad alignment to svc_reserve()
> is good, but I'm willing to consider it further.
> 
> It turns out there is already a tuneable for the maximum read and
> write size in NFSD:
> 
>    /proc/fs/nfsd/max_block_size

Hi,

Based on the head commit ca91b9500108 Merge tag 
'v6.15-rc4-ksmbd-server-fixes' of git://git.samba.org/ksmbd, I applied 
this patch series.

When I built the kernel, the following error will pop out.
"
In file included from ./arch/x86/include/asm/bug.h:103,
                  from ./include/linux/bug.h:5,
                  from ./arch/x86/include/asm/paravirt.h:19,
                  from ./arch/x86/include/asm/irqflags.h:102,
                  from ./include/linux/irqflags.h:18,
                  from ./include/linux/spinlock.h:59,
                  from ./include/linux/fs_struct.h:6,
                  from fs/nfsd/nfs4proc.c:35:
fs/nfsd/nfs4proc.c: In function ‘nfsd4_write’:
./include/linux/array_size.h:11:38: warning: division ‘sizeof (struct 
kvec *) / sizeof (struct kvec)’ does not compute the number of array 
elements [-Wsizeof-pointer-div]
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       |                                      ^
./include/asm-generic/bug.h:111:32: note: in definition of macro 
‘WARN_ON_ONCE’
   111 |         int __ret_warn_on = !!(condition);                      \
       |                                ^~~~~~~~~
fs/nfsd/nfs4proc.c:1231:30: note: in expansion of macro ‘ARRAY_SIZE’
  1231 |         WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
       |                              ^~~~~~~~~~
./include/linux/compiler.h:197:62: error: static assertion failed: "must 
be array"
   197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
{_Static_assert(!(e), msg);}))
       | 
^~~~~~~~~~~~~~
./include/asm-generic/bug.h:111:32: note: in definition of macro 
‘WARN_ON_ONCE’
   111 |         int __ret_warn_on = !!(condition);                      \
       |                                ^~~~~~~~~
./include/linux/compiler.h:202:33: note: in expansion of macro 
‘__BUILD_BUG_ON_ZERO_MSG’
   202 | #define __must_be_array(a) 
__BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
       |                                 ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/array_size.h:11:59: note: in expansion of macro 
‘__must_be_array’
    11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))
       | 
^~~~~~~~~~~~~~~
fs/nfsd/nfs4proc.c:1231:30: note: in expansion of macro ‘ARRAY_SIZE’
  1231 |         WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
       |                              ^~~~~~~~~~
make[4]: *** [scripts/Makefile.build:203: fs/nfsd/nfs4proc.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:461: fs/nfsd] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:461: fs] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/zyanjun/Development/github-linux/Makefile:2011: .] 
Error 2
make: *** [Makefile:248: __sub-make] Error 2
"

The building host is as below:

$ cat /etc/issue.net
Ubuntu 22.04.5 LTS

$ gcc --version
gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ uname -a
Linux lb03055 6.8.0-58-generic #60~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC 
Fri Mar 28 16:09:21 UTC 2 x86_64 x86_64 x86_64 GNU/Linux


Zhu Yanjun

> 
> Since there is an existing user space API for this, my initial
> arguments against adding a tuneable are moot. max_block_size should
> be adequate for this purpose, and enabling it to be set to larger
> values should not impact the kernel-user space API in any way.
> 
> Changes since v3:
> * Improved the rdma_rw context count estimate
> * Dropped "NFSD: Remove NFSSVC_MAXBLKSIZE from .pc_xdrressize"
> * Cleaned up the max size macros a bit
> * Completed the implementation of adjustable max_block_size
> 
> Changes since v2:
> * Address Jeff's review comments
> * Address Neil's review comments
> * Start removing a few uses of NFSSVC_MAXBLKSIZE
> 
> Chuck Lever (14):
>    svcrdma: Reduce the number of rdma_rw contexts per-QP
>    sunrpc: Add a helper to derive maxpages from sv_max_mesg
>    sunrpc: Remove backchannel check in svc_init_buffer()
>    sunrpc: Replace the rq_pages array with dynamically-allocated memory
>    sunrpc: Replace the rq_vec array with dynamically-allocated memory
>    sunrpc: Replace the rq_bvec array with dynamically-allocated memory
>    sunrpc: Adjust size of socket's receive page array dynamically
>    svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
>    svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
>    sunrpc: Remove the RPCSVC_MAXPAGES macro
>    NFSD: Remove NFSD_BUFSIZE
>    NFSD: Remove NFSSVC_MAXBLKSIZE_V2 macro
>    NFSD: Add a "default" block size
>    SUNRPC: Bump the maximum payload size for the server
> 
>   fs/nfsd/nfs4proc.c                       |  2 +-
>   fs/nfsd/nfs4state.c                      |  2 +-
>   fs/nfsd/nfs4xdr.c                        |  2 +-
>   fs/nfsd/nfsd.h                           | 24 ++++-------
>   fs/nfsd/nfsproc.c                        |  4 +-
>   fs/nfsd/nfssvc.c                         |  2 +-
>   fs/nfsd/nfsxdr.c                         |  4 +-
>   fs/nfsd/vfs.c                            |  2 +-
>   include/linux/sunrpc/svc.h               | 45 +++++++++++++--------
>   include/linux/sunrpc/svc_rdma.h          |  6 ++-
>   include/linux/sunrpc/svcsock.h           |  4 +-
>   net/sunrpc/svc.c                         | 51 +++++++++++++++---------
>   net/sunrpc/svc_xprt.c                    | 10 +----
>   net/sunrpc/svcsock.c                     | 15 ++++---
>   net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  8 +++-
>   net/sunrpc/xprtrdma/svc_rdma_rw.c        |  2 +-
>   net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 16 ++++++--
>   net/sunrpc/xprtrdma/svc_rdma_transport.c | 14 ++++---
>   18 files changed, 122 insertions(+), 91 deletions(-)
> 


