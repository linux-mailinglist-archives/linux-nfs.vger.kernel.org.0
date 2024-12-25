Return-Path: <linux-nfs+bounces-8768-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2359FC328
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 02:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199DB18826E9
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 01:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7856B8BE8;
	Wed, 25 Dec 2024 01:33:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD1A41;
	Wed, 25 Dec 2024 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735090411; cv=none; b=ewG8y14KrYomFHVhZSmDj/yRDo3dek1bxjopRrmYwPLIsYcFps3rpI8U8IzRjHlxm+bpDQlSyhkWre8KcX6b+D5PpHUFDpdoEA7O9fnczbDeidBRcN0UZ6HRaBbFQIQA6eDYqkaSCEiS/Gd+az2qcnByqu9+4EC5nTXmSbJexio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735090411; c=relaxed/simple;
	bh=iO3KjTNyOTHXeSojKi/vXYUrZmcdxZnrolpcKNNfSwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I17vvHRFyOQ0bqlOf5FaRKYrxkcz/b4wFpb30v8p9f2d/5KW9hmVj4NfEGr5VEgz4ca0dpqqzLTBFJEdh+GZJ8jTCQuQ33Y3h0qjorYEWSaqTLQow8+pnwpowL2le6sI42MeyUs+C/g84fa4glEDuouMpMMPLYLmiKR8MtSH21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YHvQq72vXz4f3jqq;
	Wed, 25 Dec 2024 09:33:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 979091A018D;
	Wed, 25 Dec 2024 09:33:22 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4fgYGtnVV46Fg--.22008S3;
	Wed, 25 Dec 2024 09:33:22 +0800 (CST)
Message-ID: <19f1211e-01fe-f2c4-ca3b-c4231e11508c@huaweicloud.com>
Date: Wed, 25 Dec 2024 09:33:20 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 0/5] nfsd/sunrpc: cleanup resource with sync mode
To: NeilBrown <neilb@suse.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, yangerkun@huawei.com,
 yi.zhang@huawei.com
References: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
 <173508083549.11072.301112272697956815@noble.neil.brown.name>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <173508083549.11072.301112272697956815@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4fgYGtnVV46Fg--.22008S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4fKF15Aw4xuFy3ZF1xuFg_yoW8ZF4rpF
	WIvFZrKw4kJFyIkw4vvayUXa4rKr9YyryxA3WrXw42y34rWrn7W3s0yF4qg34qqrn5Gay2
	vry0va45CF1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/12/25 6:53, NeilBrown 写道:
> On Tue, 17 Dec 2024, Yang Erkun wrote:
>> From: Yang Erkun <yangerkun@huawei.com>
>>
>> After f8c989a0c89a ("nfsd: release svc_expkey/svc_export with
>> rcu_work"), svc_export_put/expkey_put will call path_put with async
>> mode. This can lead some unexpected failure:
>>
>> mkdir /mnt/sda
>> mkfs.xfs -f /dev/sda
>> echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
>> echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
>> exportfs -ra
>> service nfs-server start
>> mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
>> mount /dev/sda /mnt/sda
>> touch /mnt1/sda/file
>> exportfs -r
>> umount /mnt/sda # failed unexcepted
>>
>> The touch above will finally call nfsd_cross_mnt, add refcount to mount,
>> and then add cache_head. Before this commit, exportfs -r will call
>> cache_flush to cleanup all cache_head, and path_put in
>> svc_export_put/expkey_put will be finished with sync mode. So, the
>> latter umount will always success. However, after this commit, path_put
>> will be called with async mode, the latter umount may failed, and if we
>> add some delay, umount will success too. Personally I think this bug and
>> should be fixed. We first revert before bugfix patch, and then fix the
>> original bug with a different way.
> 
> Thanks for these patches.  I think they are certainly a better approach
> to fixing the problem - well done.
> 
> My only thought was that instead of changing how cache_check() works, we
> could introduce cache_check_rcu() which doesn't drop the ref.
> cache_check() would then just call that then optionally drop the ref.
> I'm not convinced that is better, so I'm just mentioning it in case
> anyone else wants to agree.  I'm happy for the patch set to be applied
> as-is.
> 
>   Reviewed-By: NeilBrown <neilb@suse.de>
> 

Thanks a lot for your review!

Yeah, keep cache_check and give a separate function cache_check_rcu will 
make code more clean. Thanks for your advise!

> Thanks,
> NeilBrown


