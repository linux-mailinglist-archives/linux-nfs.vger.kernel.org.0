Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0588A3DE480
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Aug 2021 04:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhHCCo2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Aug 2021 22:44:28 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38306 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233197AbhHCCo2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Aug 2021 22:44:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UhpoVy7_1627958655;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UhpoVy7_1627958655)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Aug 2021 10:44:16 +0800
Subject: Re: [PATCH] common/attr: fix the MAX_ATTRS and MAX_ATTRVAL_SIZE for
 nfs
To:     Frank van der Linden <fllinden@amazon.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Eryu Guan <eguan@linux.alibaba.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20210730124252.113071-1-haoxu@linux.alibaba.com>
 <20210730140134.GM60846@e18g06458.et15sqa>
 <B6E429FE-2D78-41D0-A55D-C7AA83D62877@hammerspace.com>
 <20210802155508.GA28568@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <2eea57f3-4eda-d3de-1b45-8469c775b044@linux.alibaba.com>
Date:   Tue, 3 Aug 2021 10:44:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210802155508.GA28568@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

在 2021/8/2 下午11:55, Frank van der Linden 写道:
> On Sat, Jul 31, 2021 at 10:07:13PM +0000, Trond Myklebust wrote:
>>
>>
>>> On Jul 30, 2021, at 10:01, Eryu Guan <eguan@linux.alibaba.com> wrote:
>>>
>>> [cc linux-nfs for review]
>>>
>>> On Fri, Jul 30, 2021 at 08:42:52PM +0800, Hao Xu wrote:
>>>> The block size of localfs for nfs may be much smaller than nfs itself.
>>>> So we'd better set MAX_ATTRS and MAX_ATTRVAL_SIZE to 4096 to avoid
>>>> 'no space' error when we test adding a bunch of xattrs to nfs.
>>>>
>>>> Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
>>>
>>> Since the xattr support is relatively new (merged a year ago for
>>> NFSv4.2), I'd like nfs folks to take a look as well.
>>>
>>>> ---
>>>>
>>>> It's better to set BLOCK_SIZE to `_get_block_size $variable`
>>>> here $variable is the localfs for nfs, since I'm not familiar with
>>>> xfstests, anyone tell what's the name of it.
>>>
>>> fstests doesn't know the exported filesystem under NFS, so I don't think
>>> we could the block size of it.
>>>
>>>>
>>>> common/attr | 11 +++++++++--
>>>> 1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/common/attr b/common/attr
>>>> index 42ceab92335a..a833f00e0884 100644
>>>> --- a/common/attr
>>>> +++ b/common/attr
>>>> @@ -253,9 +253,13 @@ _getfattr()
>>>>
>>>> # set maximum total attr space based on fs type
>>>> case "$FSTYP" in
>>>> -xfs|udf|pvfs2|9p|ceph|nfs)
>>>> +xfs|udf|pvfs2|9p|ceph)
>>>>       MAX_ATTRS=1000
>>>>       ;;
>>>> +nfs)
>>>> +    BLOCK_SIZE=4096
>>>> +    let MAX_ATTRS=$BLOCK_SIZE/40
>>>> +    ;;
>>>> *)
>>>>       # Assume max ~1 block of attrs
>>>>       BLOCK_SIZE=`_get_block_size $TEST_DIR`
>>>> @@ -273,12 +277,15 @@ xfs|udf|btrfs)
>>>> pvfs2)
>>>>       MAX_ATTRVAL_SIZE=8192
>>>>       ;;
>>>> -9p|ceph|nfs)
>>>> +9p|ceph)
>>>>       MAX_ATTRVAL_SIZE=65536
>>>>       ;;
>>>> bcachefs)
>>>>       MAX_ATTRVAL_SIZE=1024
>>>>       ;;
>>>> +nfs)
>>>> +    MAX_ATTRVAL_SIZE=3840
>>>> +    ;;
>>>
>>> Where does this value come from?
>>>
>>> Thanks,
>>> Eryu
>>>
>>>> *)
>>>>       # Assume max ~1 block of attrs
>>>>       BLOCK_SIZE=`_get_block_size $TEST_DIR`
>>>> --
>>>> 2.24.4
>>
>> The above hackery proves beyond a shadow of a doubt that this test is utterly broken. Filesystem block sizes have nothing at all to do with xattrs.
>>
>> Please move this test into the filesystem-specific categories or else remove it altogether. It definitely does not belong in ‘generic’.
> 
> I ran in to this basic problem when trying to add support for NFS xattr tests in fstests.
> 
> fstests wants to see if the xattr implementation of filesystems acts as expected when you hit the xattr size limits. But there is no interface to query those limits. So fstests resorts to special knowledge about the filesystem implementation to deduce these limits.
> 
> That, however, falls apart for NFS, which has no builtin limits (aside from the max RPC xfer size). The limit for NFS is just whatever the filesystem on the server side has, so there is no one-size-fits-all limit you can set here. What works against a server exporting XFS will not work against a server exporting ext4, etc. And then you might have a server running on a system that implements xattrs as a 'resource fork', so the size could be equal to the maximum filesystem size. You just don't know.
So I now believe that doing this test for NFS is kind of pointless. If a 
user want to test xattrs for NFS, the right way is to test the fs on the 
server side directly.
> 
> If you're on Linux, you  could try to deduce the limit by just trying to set an xattr with increasing size until you hit the limit. That's sort of doable because Linux has an upper limit (64k) enforced by the fs-independent code, so you don't have to go beyond that. But, you're trying to see if things behave correctly in the first place when hitting the limit, so that's kind of a chicken-and-egg problem.
> 
> It's messy, there is no clean solution here.
> 
> - Frank
> 

