Return-Path: <linux-nfs+bounces-7347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE59A953E
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 03:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A13E1F23234
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 01:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848992E822;
	Tue, 22 Oct 2024 01:06:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93444A35
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559190; cv=none; b=joN2Tu0G3xOtKduNNmU/Ba834T6EgtZ2SfHTYusdJ2xBVxaJkrN1pNESLSpYEwt9t48ZV6o7qcmT09TW/3mV2b++b5aalYlGKG7iaRDlVCwTOzmjucwKlktZUeWaj8Dwn7X6/C8CZPT+wULzx5UX2zMQC38Jt80SGLHsswTovbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559190; c=relaxed/simple;
	bh=zgcBSLgbsTUpGGaoDTjKgWIpWzladovIeZtje4ndhAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tG3oCj2/yGMTPhjuB2d7H55RESqdM7d8NdZPfQzASghFB6jwE8ScItj7xz+7YWQSXM/zRmxc0Buqqq/zS3WQs3S02eqd1H9ZQtcvvZPwsGGHZZFsiQwROOFZdQJSL4v37sQYywhBbeCoEgpmLLq5OClCJOTtJ1qFiY/EKb/P9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXYsB4pB4z4f3jJD
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 09:06:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0D9CA1A018D
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 09:06:24 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMmO+hZnLdQNEw--.30187S3;
	Tue, 22 Oct 2024 09:06:23 +0800 (CST)
Message-ID: <7eb2c989-0b78-9a6c-46d7-f3d47685adb1@huaweicloud.com>
Date: Tue, 22 Oct 2024 09:06:22 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] nfsd: cancel nfsd_shrinker_work using sync mode in
 nfs4_state_shutdown_net
To: Chuck Lever III <chuck.lever@oracle.com>, yangerkun <yangerkun@huawei.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>
References: <20241021082540.2885014-1-yangerkun@huaweicloud.com>
 <ZxZeZB51iwVgVZt6@tissot.1015granger.net>
 <2e5c039a-fde0-de3c-c15f-5405a5507c8b@huawei.com>
 <7FA40B59-C5FC-4393-82DD-BB8CE44F4AC0@oracle.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <7FA40B59-C5FC-4393-82DD-BB8CE44F4AC0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMmO+hZnLdQNEw--.30187S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF45Ww15uF48GFWftF43Jrb_yoW8Gr4xpF
	W3AFn0yw1vyrZFk3ZFqayUtFy3twsakw17ur95Zr48trZ093sxtr18KFWY9Fy8Xr4kWw1j
	qa1aga98X34DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



在 2024/10/21 22:25, Chuck Lever III 写道:
> 
> 
>> On Oct 21, 2024, at 10:18 AM, yangerkun <yangerkun@huawei.com> wrote:
>>
>>
>>
>> 在 2024/10/21 22:00, Chuck Lever 写道:
>>> On Mon, Oct 21, 2024 at 04:25:40PM +0800, Yang Erkun wrote:
>>>>
>>>> Fixes: 7746b32f467b ("NFSD: add shrinker to reap courtesy clients on low memory condition")
>>> I think like:
>>> Fixes: 7c24fa225081 ("NFSD: replace delayed_work with work_struct for nfsd_client_shrinker")
>>
>> Hi,
>>
>> Thanks a lot for your review! Before this, will this problem exist too
>> since the concurrently run between upper two threads can happen too?
> 
> Yes, the race can happen before 7c24fa, but your patch
> won't apply to kernels that don't have 7c24fa applied.
> 
> The automation should pull both of these into LTS correctly.
> If it doesn't happen as we expect, we can fix it up by hand.

Thanks for explaining. Agree with you.

> 
> I plan to apply this to nfsd-fixes (for v6.12-rc).

Thanks!

> 
> 
>>> a little better.
>>> I'm very curious how you stumbled across this one!
>>
>> Our excellent test team has recently performed a lot of fault injection
>> tests on nfs/nfsd, which helps us find many nfs/nfsd problems. This
>> problem is only one of them. There will be some bugfixes for other
>> problems later.
> 
> Excellent, looking forward to seeing those.
> 
> 
> --
> Chuck Lever
> 
> 


