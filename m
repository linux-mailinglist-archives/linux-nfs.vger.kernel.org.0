Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0B3DE481
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Aug 2021 04:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhHCCqg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Aug 2021 22:46:36 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36293 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233356AbhHCCqg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Aug 2021 22:46:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UhpfPBS_1627958784;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UhpfPBS_1627958784)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Aug 2021 10:46:24 +0800
Subject: Re: [PATCH] common/attr: fix the MAX_ATTRS and MAX_ATTRVAL_SIZE for
 nfs
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20210730124252.113071-1-haoxu@linux.alibaba.com>
 <20210730140134.GM60846@e18g06458.et15sqa>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <973941f3-a2c9-1e5d-a8bc-417a955d505e@linux.alibaba.com>
Date:   Tue, 3 Aug 2021 10:46:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210730140134.GM60846@e18g06458.et15sqa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

在 2021/7/30 下午10:01, Eryu Guan 写道:
> [cc linux-nfs for review]
> 
> On Fri, Jul 30, 2021 at 08:42:52PM +0800, Hao Xu wrote:
>> The block size of localfs for nfs may be much smaller than nfs itself.
>> So we'd better set MAX_ATTRS and MAX_ATTRVAL_SIZE to 4096 to avoid
>> 'no space' error when we test adding a bunch of xattrs to nfs.
>>
>> Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
> 
> Since the xattr support is relatively new (merged a year ago for
> NFSv4.2), I'd like nfs folks to take a look as well.
> 
>> ---
>>
>> It's better to set BLOCK_SIZE to `_get_block_size $variable`
>> here $variable is the localfs for nfs, since I'm not familiar with
>> xfstests, anyone tell what's the name of it.
> 
> fstests doesn't know the exported filesystem under NFS, so I don't think
> we could the block size of it.
> 
>>
>>   common/attr | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/attr b/common/attr
>> index 42ceab92335a..a833f00e0884 100644
>> --- a/common/attr
>> +++ b/common/attr
>> @@ -253,9 +253,13 @@ _getfattr()
>>   
>>   # set maximum total attr space based on fs type
>>   case "$FSTYP" in
>> -xfs|udf|pvfs2|9p|ceph|nfs)
>> +xfs|udf|pvfs2|9p|ceph)
>>   	MAX_ATTRS=1000
>>   	;;
>> +nfs)
>> +	BLOCK_SIZE=4096
>> +	let MAX_ATTRS=$BLOCK_SIZE/40
>> +	;;
>>   *)
>>   	# Assume max ~1 block of attrs
>>   	BLOCK_SIZE=`_get_block_size $TEST_DIR`
>> @@ -273,12 +277,15 @@ xfs|udf|btrfs)
>>   pvfs2)
>>   	MAX_ATTRVAL_SIZE=8192
>>   	;;
>> -9p|ceph|nfs)
>> +9p|ceph)
>>   	MAX_ATTRVAL_SIZE=65536
>>   	;;
>>   bcachefs)
>>   	MAX_ATTRVAL_SIZE=1024
>>   	;;
>> +nfs)
>> +	MAX_ATTRVAL_SIZE=3840
>> +	;;
> 
> Where does this value come from?
> 
3840 = 4096 - 256, which is like the case of *)
> Thanks,
> Eryu
> 
>>   *)
>>   	# Assume max ~1 block of attrs
>>   	BLOCK_SIZE=`_get_block_size $TEST_DIR`
>> -- 
>> 2.24.4

