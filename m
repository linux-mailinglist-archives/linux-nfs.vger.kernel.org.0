Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5123ACDA66
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2019 04:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfJGCR0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Oct 2019 22:17:26 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18817 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726772AbfJGCR0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Oct 2019 22:17:26 -0400
X-IronPort-AV: E=Sophos;i="5.67,265,1566835200"; 
   d="scan'208";a="76570175"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Oct 2019 10:17:22 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id EF5F94CE14F5;
        Mon,  7 Oct 2019 10:17:18 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 7 Oct 2019 10:17:21 +0800
Subject: Re: [PATCH] NFS: Fix O_DIRECT read problem when another write is
 going on
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1569834678-16117-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <d7fee2b94f4af266054c6e975cdfd4d9adbf841b.camel@hammerspace.com>
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
Message-ID: <c869daa9-cb66-6221-0a3b-c73fa9c39066@cn.fujitsu.com>
Date:   Mon, 7 Oct 2019 10:17:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d7fee2b94f4af266054c6e975cdfd4d9adbf841b.camel@hammerspace.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: EF5F94CE14F5.AC31E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


在 2019/10/1 2:06, Trond Myklebust 写道:
> Hi Su,
>
> On Mon, 2019-09-30 at 17:11 +0800, Su Yanjun wrote:
>> In xfstests generic/465 tests failed. Because O_DIRECT r/w use
>> async rpc calls, when r/w rpc calls are running concurrently we
>> may read partial data which is wrong.
>>
>> For example as follows.
>>   user buffer
>> /--------\
>>>     |XXXX|
>>   rpc0 rpc1
>>
>> When rpc0 runs it encounters eof so return 0, then another writes
>> something. When rpc1 runs it returns some data. The total data
>> buffer contains wrong data.
>>
>> In this patch we check eof mark for each direct request. If
>> encounters
>> eof then set eof mark in the request, when we meet it again report
>> -EAGAIN error. In nfs_direct_complete we convert -EAGAIN as if read
>> nothing. When the reader issue another read it will read ok.
>>
>> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
>> ---
>>   fs/nfs/direct.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
>> index 222d711..7f737a3 100644
>> --- a/fs/nfs/direct.c
>> +++ b/fs/nfs/direct.c
>> @@ -93,6 +93,7 @@ struct nfs_direct_req {
>>   				bytes_left,	/* bytes left to be
>> sent */
>>   				error;		/* any reported error
>> */
>>   	struct completion	completion;	/* wait for i/o completion */
>> +	int			eof;		/* eof mark in the
>> req */
>>   
>>   	/* commit state */
>>   	struct nfs_mds_commit_info mds_cinfo;	/* Storage for cinfo
>> */
>> @@ -380,6 +381,12 @@ static void nfs_direct_complete(struct
>> nfs_direct_req *dreq)
>>   {
>>   	struct inode *inode = dreq->inode;
>>   
>> +	/* read partial data just as read nothing */
>> +	if (dreq->error == -EAGAIN) {
>> +		dreq->count = 0;
>> +		dreq->error = 0;
>> +	}
>> +
>>   	inode_dio_end(inode);
>>   
>>   	if (dreq->iocb) {
>> @@ -413,8 +420,13 @@ static void nfs_direct_read_completion(struct
>> nfs_pgio_header *hdr)
>>   	if (hdr->good_bytes != 0)
>>   		nfs_direct_good_bytes(dreq, hdr);
>>   
>> -	if (test_bit(NFS_IOHDR_EOF, &hdr->flags))
>> +	if (dreq->eof)
>> +		dreq->error = -EAGAIN;
>> +
>> +	if (test_bit(NFS_IOHDR_EOF, &hdr->flags)) {
>>   		dreq->error = 0;
>> +		dreq->eof = 1;
>> +	}
>>   
>>   	spin_unlock(&dreq->lock);
>>   
> Thanks for looking into this issue. I agree with your analysis of what
> is going wrong in generic/465.
>
> However, I think the problem is greater than just EOF. I think we also
> need to look at the generic error handling, and ensure that it handles
> a truncated RPC call in the middle of a series of calls correctly.
>
> Please see the two patches I sent you just now and check if they fix
> the problem for you.

The patchset you sent works for generic/465.

Thanks a lot



