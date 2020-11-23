Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75822C12F6
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 19:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgKWSQ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 13:16:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53388 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgKWSQ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 13:16:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANIET27165985;
        Mon, 23 Nov 2020 18:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iuf1imG4Rsjrz6757d6haCdBclA/AkVqhAXpv43lFtI=;
 b=bLhiU5eoyUn5atVbuibyzLJVSY2TXFeRtKzkAcnEyfxY1FjZtQViPsP7Og3qZrjTnrZb
 mEwl4m4jq7af+rxZvYaXFt9wIN4AloBmV0rBqv/NGmaevxIcw+eKB1BjrsYliwfN4OZn
 y5VI/7jcplDM/cnyQGaPbl3RwP1Xm95ppNgxwqh9L0OZHcWDOIw1oWiXFi86bAG/qglZ
 fyfcAUU6Z9zDOaNR7VvYUduv+t5jR/akwoKYVofmsFDBHpWwmsV7gjTva+VuoQttdNyj
 ptk1LomMaKIOVmq9T9lbtSCT3vOZesEvw9b3w+IFlTiAtc4jtIBBEU9bq8DXAIwqphzK zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34xtukxm6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 18:16:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANI5dkC119249;
        Mon, 23 Nov 2020 18:14:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34yx8hs83r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 18:14:54 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ANIEqgE029645;
        Mon, 23 Nov 2020 18:14:52 GMT
Received: from dhcp-10-154-161-244.vpn.oracle.com (/10.154.161.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 10:14:52 -0800
Subject: Re: [PATCH v4 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter
 server copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>
References: <eeafd9e2-5d04-848e-d330-670e2185098d@oracle.com>
 <20201109204206.GA20261@fieldses.org>
 <7a18452a-3120-ea5b-f676-9d7e18a65446@oracle.com>
 <470b690f-c919-2c48-95b7-18cc75f71f70@oracle.com>
 <20201110201239.GA17755@fieldses.org>
 <CAN-5tyHEj_nNhN=wM3xkzsAp2RUqQw4pVau+DruFPXGT8j+kuw@mail.gmail.com>
 <20201110215157.GB17755@fieldses.org>
 <CAN-5tyEPvpQQVL+j=4vbfdcKmr96ZpYq3fsCQTZHyS5qWGJsvw@mail.gmail.com>
 <20201110222155.GC17755@fieldses.org>
 <5b395908-8cd4-f93d-421e-68608235b863@oracle.com>
 <20201123162514.GF32599@fieldses.org>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <05c6adaa-c998-36d3-c66d-da2968941fb8@oracle.com>
Date:   Mon, 23 Nov 2020 10:14:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123162514.GF32599@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=3
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1011 suspectscore=3 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230121
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/23/20 8:25 AM, J. Bruce Fields wrote:
> On Wed, Nov 11, 2020 at 03:02:19PM -0800, Dai Ngo wrote:
>> On 11/10/20 2:21 PM, J. Bruce Fields wrote:
>>> On Tue, Nov 10, 2020 at 05:08:59PM -0500, Olga Kornievskaia wrote:
>>>> On Tue, Nov 10, 2020 at 4:52 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>>>>> On Tue, Nov 10, 2020 at 04:07:41PM -0500, Olga Kornievskaia wrote:
>>>>>> On Tue, Nov 10, 2020 at 3:14 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>>>>>>> On Mon, Nov 09, 2020 at 10:46:12PM -0800, Dai Ngo wrote:
>>>>>>>> On 11/9/20 2:26 PM, Dai Ngo wrote:
>>>>>>>>> On 11/9/20 12:42 PM, J. Bruce Fields wrote:
>>>>>>>>>> On Mon, Nov 09, 2020 at 11:34:08AM -0800, Dai Ngo wrote:
>>>>>>>>>>> On 11/9/20 10:30 AM, J. Bruce Fields wrote:
>>>>>>>>>>>> On Tue, Oct 20, 2020 at 11:34:35AM -0700, Dai Ngo wrote:
>>>>>>>>>>>>> On 10/20/20 10:01 AM, J. Bruce Fields wrote:
>>>>>>>>>>>>>> On Sun, Oct 18, 2020 at 11:42:49PM -0400, Dai Ngo wrote:
>>>>>>>>>>>>>>> NFS_FS=y as dependency of CONFIG_NFSD_V4_2_INTER_SSC still have
>>>>>>>>>>>>>>> build errors and some configs with NFSD=m to get NFS4ERR_STALE
>>>>>>>>>>>>>>> error when doing inter server copy.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Added ops table in nfs_common for knfsd to access NFS
>>>>>>>>>>>>>>> client modules.
>>>>>>>>>>>>>> OK, looks reasonable to me, applying.  Does this resolve all the
>>>>>>>>>>>>>> problems you've seen, or is there any bad case left?
>>>>>>>>>>>>> Thanks Bruce.
>>>>>>>>>>>>>
>>>>>>>>>>>>> With this patch, I no longer see the NFS4ERR_STALE in any config.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The problem with NFS4ERR_STALE was because of a bug in
>>>>>>>>>>>>> nfs42_ssc_open.
>>>>>>>>>>>>> When CONFIG_NFSD_V4_2_INTER_SSC is not defined, nfs42_ssc_open
>>>>>>>>>>>>> returns NULL which is incorrect allowing the operation to continue
>>>>>>>>>>>>> until nfsd4_putfh which does not have the code to handle
>>>>>>>>>>>>> nfserr_stale.
>>>>>>>>>>>>>
>>>>>>>>>>>>> With this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not defined the
>>>>>>>>>>>>> new nfs42_ssc_open returns ERR_PTR(-EIO) which causes the NFS client
>>>>>>>>>>>>> to switch over to the split copying (read src and write to dst).
>>>>>>>>>>>> That sounds reasonable, but I don't see any of the patches you've sent
>>>>>>>>>>>> changing that error return.  Did I overlook something, or did you mean
>>>>>>>>>>>> to append a patch to this message?
>>>>>>>>>>> Since with the patch, I did not run into the condition where
>>>>>>>>>>> NFS4ERR_STALE
>>>>>>>>>>> is returned so I did not fix this return error code. Do you want me to
>>>>>>>>>>> submit another patch to change the returned error code from
>>>>>>>>>>> NFS4ERR_STALE
>>>>>>>>>>> to NFS4ERR_NOTSUPP if it ever runs into that condition?
>>>>>>>>>> That would be great, thanks.  (I mean, it is still possible to hit that
>>>>>>>>>> case, right?  You just didn't test with !CONFIG_NFSD_V4_2_INTER_SSC ?)
>>>>>>>>> will do. I did tested with (!CONFIG_NFSD_V4_2_INTER_SSC) but did not hit
>>>>>>>>> this case.
>>>>>>>> I need to qualify this, the copy_file_range syscall did not return
>>>>>>>> ESTALE in the test.
>>>>>>>>
>>>>>>>>> Because with this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not
>>>>>>>>> defined the new nfs42_ssc_open returns ERR_PTR(-EIO), instead of NULL in
>>>>>>>>> the old code, which causes the NFS client to switch over to the split
>>>>>>>>> copying (read src and write to dst).
>>>>>>>> This is not the reason why the client switches to generic_copy_file_range.
>>>>>>>>
>>>>>>>>> Returning NULL in the old nfs42_ssc_open is not correct, it allows
>>>>>>>>> the copy
>>>>>>>>> operation to proceed and hits the NFS4ERR_STALE case in the COPY
>>>>>>>>> operation.
>>>>>>>> I retested with (!CONFIG_NFSD_V4_2_INTER_SSC) and saw NFS4ERR_STALE
>>>>>>>> returned for the PUTFH of the SRC in the COPY compound. However on the
>>>>>>>> client nfs42_proc_copy (with commit 7e350197a1c10) replaced the ESTALE
>>>>>>>> with EOPNOTSUPP causing nfs4_copy_file_range to use generic_copy_file_range
>>>>>>>> to do the copy.
>>>>>>>>
>>>>>>>> The ESTALE error is only returned by copy_file_range if the client
>>>>>>>> does not have commit 7e350197a1c10. So I think there is no need to
>>>>>>>> make any change on the source server for the NFS4ERR_STALE error.
>>>>>>> I don't believe NFS4ERR_STALE is the correct error for the server to
>>>>>>> return.  It's nice that the client is able to do the right thing despite
>>>>>>> the server returning the wrong error, but we should still try to get
>>>>>>> this right on the server.
>>>>>> Hi Bruce,
>>>>>>
>>>>>> ERR_STALE is the appropriate error to be returned by the server that
>>>>>> gets a COPY compound when it doesn't support COPY. Since server can't
>>>>>> understand the filehandle so it can't process it so we can't get to
>>>>>> processing COPY opcode where the server could have returned
>>>>>> EOPNOTSUPP.
>>>>> The case we're discussing is the case where we support COPY but not
>>>>> server-to-server copy.
>>>> My point is still the same, that's an appropriate error for when
>>>> server-to-server copy is not supported.
>>> Uh, OK, if it backs up and returns it to the PUTFH, I guess?
>>>
>>> Was it really the intention of nfsd4_do_async_copy() that it return
>>> STALE in the case NFS42_ssc_open() returns NULL?  That's pretty
>>> confusing.
>> In this scenario, the COPY compound fails at the PUTFH op and
>> NFS4ERR_NOTSUPP is not a valid error code for PUTFH, NFS4ERR_STALE is.
> OK, makes sense.
>
> I've lost track of what's left to apply.

I think we're good with this issue.
There is still one inter server copy related patch waiting for
your review:

PATCH] NFSD: Fix 5 seconds delay when doing inter server copy

Thanks,
-Dai

>
> --b.
