Return-Path: <linux-nfs+bounces-3289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D288C9CDE
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 14:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFAF1F22546
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC26B2E417;
	Mon, 20 May 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sBLm7mdR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662B20311
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207127; cv=none; b=TmIDwQb/zr/sW3ZvddcOcwitsVnonHf/ahLJx1G/bzU/phP+0nKZkeVH7e/VAmJB4LEhLPMi54lZEFiH/JcaarwQBMJIzTGMzQ0DOiRB46UbdsSb4Wkhg4aHtE135sfgafwEKccZOp9RDTBKSa+ZH2z7UAs0gztTCAOe6pt8ZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207127; c=relaxed/simple;
	bh=okuFoxjDbEa/Cy9d9p0Re6q5eyCYWX8r0NPfeekia2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajkWWbzIhhvpc4kpPAakyorA75LPs81zI3OitfOv/pEk17eu49ry+m59ieatXv7KTuvFKSCPN0Zp0Um6ifjPGpPW2iic7DX7swRD3/3qtub5mBVJdPcdfX5rgjJGJEvnDL4Pf3+x2tfCJx26dU7kCaF71o31G1vzM4KxOAd8vXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sBLm7mdR; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rankincj@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716207122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZEhd+Lq/HrYnXQtgq10qzlROqeXWQEKzo6+4KpOd74=;
	b=sBLm7mdRxTx7rSSVoekMcAGYDBpr+LVF/v9ora4XOh+FrBAkz6uBhdpM75PzXGLR9Xjjbl
	Jh6SIbv2+Q2+abvn4NmHavHQshyBUmX9vrzZy1w7qS7wkNQFDUZ3IDK5BvXaySf9x31LjK
	cBANGx65bN+vDWo5flLT6WlE0+OFEr4=
X-Envelope-To: jlayton@kernel.org
X-Envelope-To: chuck.lever@oracle.com
X-Envelope-To: linux-nfs@vger.kernel.org
Message-ID: <aa0fec0b-b12a-b0b6-2d28-bad69f6034cb@linux.dev>
Date: Mon, 20 May 2024 20:11:52 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] Linux 6.8.10 NPE
Content-Language: en-US
To: Chris Rankin <rankincj@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
References: <CAK2bqVJoT3yy2m0OmTnqH9EAKkj6O1iTk42EyyMtvvxKh6YDKg@mail.gmail.com>
 <CAK2bqV+FA-bcBXeOAT93Y=-6fyXOP38yoYgH_4O+waygWLbnEg@mail.gmail.com>
 <CAK2bqVJ+GgWtjvy4wGzGqAvwoCrH2Hmo6W5oT6wu_0LXzUV3VA@mail.gmail.com>
 <0309145a87db46a4e56b83d64d2f5273990a08d7.camel@kernel.org>
 <CAK2bqVLaki4Jqq67jWcW+fedDYJRk5xrsgNZq5TH4iBTu8AvMg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAK2bqVLaki4Jqq67jWcW+fedDYJRk5xrsgNZq5TH4iBTu8AvMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/19/24 23:51, Chris Rankin wrote:
> nfsd_show+0x39/0x18e:
>
> net_generic at /home/chris/LINUX/linux-6.8/include/net/netns/generic.h:47
>   42         struct net_generic *ng;
>   43         void *ptr;
>   44
>   45         rcu_read_lock();
>   46         ng = rcu_dereference(net->gen);
>> 47<        ptr = ng->ptr[id];
>   48         rcu_read_unlock();
>   49
>   50         return ptr;
>   51     }
>   52     #endif
>
> (inlined by) nfsd_show at /home/chris/LINUX/linux-6.8/fs/nfsd/stats.c:38
>   33     };
>   34
>   35     static int nfsd_show(struct seq_file *seq, void *v)
>   36     {
>   37         struct net *net = pde_data(file_inode(seq->file));

The implementation of pde_data is depend on CONFIG_PROC_FS, maybe nfsd_show
need to check the dependency too just like write_gssp.

>> 38<        struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>   39         int i;
>   40
>   41         seq_printf(seq, "rc %lld %lld %lld\nfh %lld 0 0 0 0\nio
> %lld %lld\n",
>   42
> percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_HITS]),
>   43
> percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_MISSES]),

Thanks,
Guoqing

