Return-Path: <linux-nfs+bounces-7743-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46A9C13B5
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 02:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31631F21393
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 01:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3085E208A9;
	Fri,  8 Nov 2024 01:35:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481C17BBF
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029701; cv=none; b=QvGt4DM5IX9rQ47oGADRVd0COsGBPf9OgTbVfhj5gogmBlViNjHni1tqwSsR19aICdLFzr9slHmJodZy6xnWsYuG6TAl1xBaC6bsjj9FaOZaeTCamMqusKWlODbit2PfQ1mzqT4xJ2bfwb5CkDD13f1jMudU5v08GqknRAfzauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029701; c=relaxed/simple;
	bh=/uyclyW+GjVUeNJnoiCNBWHhyP7DtmIIxSsiOs870S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHSGzJhlcPK4IgzFfYbzUuthOAEnpK7WJItojO9G1+/dxuY5MJNn7+HnwYLJCTkpcVaoqa9lH1r6+/tKKkmcy4j6A0g5wyk3VbMlwl519Z+fxJ4E6h/I3imLF4U6xuSBkUNPJLXk9SVLdIq+iNc8VIFoy/0KzgLfvTZgycal9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xl1hF0YC9z4f3mHZ
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 09:34:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 005631A018D
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 09:34:55 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCHYoa+ai1nmUilBA--.26277S3;
	Fri, 08 Nov 2024 09:34:55 +0800 (CST)
Message-ID: <9d0d20cd-ec92-cf35-04f6-3162c481add9@huaweicloud.com>
Date: Fri, 8 Nov 2024 09:34:54 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3] nfsd: fix nfs4_openowner leak when concurrent
 nfsd4_open occur
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
 linux-nfs@vger.kernel.org, yi.zhang@huawei.com
References: <20241105110314.2122967-1-yangerkun@huaweicloud.com>
 <Zytwhv08T2lKhGwv@tissot.1015granger.net>
 <101f5657-99d7-1813-05d4-7829c48f9865@huaweicloud.com>
 <ZyzPdsmYTMx+iT48@tissot.1015granger.net>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <ZyzPdsmYTMx+iT48@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYoa+ai1nmUilBA--.26277S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww18uF1Duw1xuFy7Ww1UGFg_yoW8AF4kpF
	Z3Kas8CF1ktr1Skwn2g3W0ka4Yy39FyryrWwn5XrW3AFZ093Wa9w12grWY9ryqqrykKF48
	Zr12qry3X3ykZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/11/7 22:32, Chuck Lever 写道:
> On Thu, Nov 07, 2024 at 09:22:39AM +0800, yangerkun wrote:
>>
>>
>> 在 2024/11/6 21:35, Chuck Lever 写道:
>>> On Tue, Nov 05, 2024 at 07:03:14PM +0800, Yang Erkun wrote:
>>>> From: Yang Erkun <yangerkun@huawei.com>
> 
>>>> Add nfs4_openowner_unhashed to help found unhashed nfs4_openowner, and
>>>> break nfsd4_open process to fix this problem.
>>>>
>>>> Cc: stable@vger.kernel.org # 2.6
>>>
>>> Hi -
>>>
>>> Questions about the "stable@" tag:
>>>
>>>    - You refer above to a leak of nfsd_file objects, but the nfsd_file
>>>      cache was added in v5.4. Any thoughts about what might be leaked,
>>>      if anything, in kernels earlier than v5.4?
>>
>>  From the above analysis, actually openowner is leaked, and all object
>> associated with it has been leaked too, include nfsd_file, and openowner
>> seems already been there since 2.6....
> 
> Before v5.4, openowners are leaked. After, openowners and nfsd_file
> objects are leaked. Got it.

Yes

> 
> 
>>>    - Have you tried applying this patch to LTS kernels?
>>
>> I have not try to apply this to LTS, what I think is all kernel after 2.6
>> has this bug...
> 
> Understood.
> 
> Is "2.6" a guess, or do you know of a specific kernel version where
> this problem started to appear? Generally if a problem goes back far
> enough or there isn't sufficient evidence about where the problem
> started, we don't want a "# xx.yy" annotation.

Thanks for pointing that out! Yes, 2.6 is just a guess, and it's really 
not appropriate to say that 2.6 is involved in the beginning.

> 
> I expect the stable folks will pull this fix into LTS kernels
> automatically, and I have nightly CI running on all of those. That
> can catch problems with applying recent fixes to old code bases, but
> it ain't perfect.
> 
> 


