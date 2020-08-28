Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D22552F7
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Aug 2020 04:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgH1CXL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Aug 2020 22:23:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54002 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbgH1CXI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 27 Aug 2020 22:23:08 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 116884CC1E4883298965;
        Fri, 28 Aug 2020 10:23:06 +0800 (CST)
Received: from [10.174.177.167] (10.174.177.167) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 28 Aug 2020 10:23:02 +0800
Subject: Re: [PATCH] nfsd: don't call trace_nfsd_deleg_none() if read
 delegation is given
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20200827070237.19942-1-houtao1@huawei.com>
 <6F61F417-95DA-4CD7-A81A-FA8C6299CF40@oracle.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <af7f4b4a-f44d-398e-76c3-e41e1b31fea7@huawei.com>
Date:   Fri, 28 Aug 2020 10:23:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6F61F417-95DA-4CD7-A81A-FA8C6299CF40@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.167]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On 2020/8/27 22:43, Chuck Lever wrote:
> Hello!
> 
>> On Aug 27, 2020, at 3:02 AM, Hou Tao <houtao1@huawei.com> wrote:
>>
>> Don't call trace_nfsd_deleg_none() if read delegation is given,
>> else two exclusive traces will be printed:
>>
>>    nfsd_deleg_open: client 5f45b854:e6058001 stateid 00000030:00000001
>>    nfsd_deleg_none: client 5f45b854:e6058001 stateid 0000002f:00000001
> 
> These are reporting two different state IDs: the first is a delegation
> state ID, and the second is an open state ID.
> 
> So in the "no delegation" case, we want to see just the open state ID.
> In the "delegation" case, we do want to see both.
> 
Thanks for your explanation.

> You could argue (successfully) that the names of the tracepoints are
> pretty lousy. Maybe better to rename:
> 
>   nfsd_deleg_open -> nfsd_deleg_read
>   nfsd_deleg_none -> nfsd_open
> 
> What do you think?
> 
After the renaming, the trace looks clearer. I will do it in v2.

Thanks

>> Fix it by calling trace_nfsd_deleg_none() directly in appropriate
>> places instead of calling it by checking the value of op_delegate_type.
>>
>> Also remove the unnecessary assignment "status = nfs_ok", because
>> we can ensure status will be nfs_ok after the call of
>> nfs4_inc_and_copy_stateid().
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>> fs/nfsd/nfs4state.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index c09a2a4281ec9..2e6376af701ff 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5131,6 +5131,8 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
>> 	nfs4_put_stid(&dp->dl_stid);
>> 	return;
>> out_no_deleg:
>> +	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
>> +
>> 	open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE;
>> 	if (open->op_claim_type == NFS4_OPEN_CLAIM_PREVIOUS &&
>> 	    open->op_delegate_type != NFS4_OPEN_DELEGATE_NONE) {
>> @@ -5232,7 +5234,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>> 		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
>> 			open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE_EXT;
>> 			open->op_why_no_deleg = WND4_NOT_WANTED;
>> -			goto nodeleg;
>> +			trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
>> +			goto out;
>> 		}
>> 	}
>>
>> @@ -5241,9 +5244,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>> 	* OPEN succeeds even if we fail.
>> 	*/
>> 	nfs4_open_delegation(current_fh, open, stp);
>> -nodeleg:
>> -	status = nfs_ok;
>> -	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
>> out:
>> 	/* 4.1 client trying to upgrade/downgrade delegation? */
>> 	if (open->op_delegate_type == NFS4_OPEN_DELEGATE_NONE && dp &&
>> -- 
>> 2.25.0.4.g0ad7144999
>>
> 
> --
> Chuck Lever
> 
> 
> 
> .
> 
