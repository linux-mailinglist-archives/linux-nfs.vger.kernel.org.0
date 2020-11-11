Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D632AFD0E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 02:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgKLBcS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Nov 2020 20:32:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35090 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgKKXCb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Nov 2020 18:02:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ABMxr2R114597;
        Wed, 11 Nov 2020 23:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=C80kmffh8/rZ19K6dZStKVJBrddndTap0AxvrNDQbNA=;
 b=w5ygQPtvbJtYI8JeTkLxEMk/MjRpuTEY/JAcRn1YEL1gVdyFOlKQTIW22OAjgqOo0Ka4
 CgSfEp1zt3eDWxpsDcWWCfaRoIbrbmFUBkZ8+L5fIm2gRFonqFmgkfZgMzU7mPRJcZ6j
 P2P5qwSy7XiipJckS2BWwCthKNzPbnPI35rylMVhL2k3ZupdIODRdYL4Ykpyve+oq/h+
 +REQmTkg2uxwQzYXeXS9DnHyRk0rE+ObjKlTGr4OqUYHwyRZ+IfVDlxBRYKY86N70PUZ
 YsyFVthsjVfRz9258dp98AXNusZaNHUXj3bfFD0RsCxBIqRpJb6ZTpJ4UyAw1JxTXVD7 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhm2s5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 23:02:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ABN0DNo128477;
        Wed, 11 Nov 2020 23:02:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34rru1rj2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 23:02:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ABN2KmH003014;
        Wed, 11 Nov 2020 23:02:20 GMT
Received: from dhcp-10-154-129-47.vpn.oracle.com (/10.154.129.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Nov 2020 15:02:20 -0800
Subject: Re: [PATCH v4 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter
 server copy
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <fb514565-cd47-9180-2adc-f3ba4459202b@oracle.com>
 <20201109183054.GD11144@fieldses.org>
 <eeafd9e2-5d04-848e-d330-670e2185098d@oracle.com>
 <20201109204206.GA20261@fieldses.org>
 <7a18452a-3120-ea5b-f676-9d7e18a65446@oracle.com>
 <470b690f-c919-2c48-95b7-18cc75f71f70@oracle.com>
 <20201110201239.GA17755@fieldses.org>
 <CAN-5tyHEj_nNhN=wM3xkzsAp2RUqQw4pVau+DruFPXGT8j+kuw@mail.gmail.com>
 <20201110215157.GB17755@fieldses.org>
 <CAN-5tyEPvpQQVL+j=4vbfdcKmr96ZpYq3fsCQTZHyS5qWGJsvw@mail.gmail.com>
 <20201110222155.GC17755@fieldses.org>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <5b395908-8cd4-f93d-421e-68608235b863@oracle.com>
Date:   Wed, 11 Nov 2020 15:02:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201110222155.GC17755@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=3 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=3 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110133
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/10/20 2:21 PM, J. Bruce Fields wrote:
> On Tue, Nov 10, 2020 at 05:08:59PM -0500, Olga Kornievskaia wrote:
>> On Tue, Nov 10, 2020 at 4:52 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>>> On Tue, Nov 10, 2020 at 04:07:41PM -0500, Olga Kornievskaia wrote:
>>>> On Tue, Nov 10, 2020 at 3:14 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>>>>> On Mon, Nov 09, 2020 at 10:46:12PM -0800, Dai Ngo wrote:
>>>>>> On 11/9/20 2:26 PM, Dai Ngo wrote:
>>>>>>> On 11/9/20 12:42 PM, J. Bruce Fields wrote:
>>>>>>>> On Mon, Nov 09, 2020 at 11:34:08AM -0800, Dai Ngo wrote:
>>>>>>>>> On 11/9/20 10:30 AM, J. Bruce Fields wrote:
>>>>>>>>>> On Tue, Oct 20, 2020 at 11:34:35AM -0700, Dai Ngo wrote:
>>>>>>>>>>> On 10/20/20 10:01 AM, J. Bruce Fields wrote:
>>>>>>>>>>>> On Sun, Oct 18, 2020 at 11:42:49PM -0400, Dai Ngo wrote:
>>>>>>>>>>>>> NFS_FS=y as dependency of CONFIG_NFSD_V4_2_INTER_SSC still have
>>>>>>>>>>>>> build errors and some configs with NFSD=m to get NFS4ERR_STALE
>>>>>>>>>>>>> error when doing inter server copy.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Added ops table in nfs_common for knfsd to access NFS
>>>>>>>>>>>>> client modules.
>>>>>>>>>>>> OK, looks reasonable to me, applying.  Does this resolve all the
>>>>>>>>>>>> problems you've seen, or is there any bad case left?
>>>>>>>>>>> Thanks Bruce.
>>>>>>>>>>>
>>>>>>>>>>> With this patch, I no longer see the NFS4ERR_STALE in any config.
>>>>>>>>>>>
>>>>>>>>>>> The problem with NFS4ERR_STALE was because of a bug in
>>>>>>>>>>> nfs42_ssc_open.
>>>>>>>>>>> When CONFIG_NFSD_V4_2_INTER_SSC is not defined, nfs42_ssc_open
>>>>>>>>>>> returns NULL which is incorrect allowing the operation to continue
>>>>>>>>>>> until nfsd4_putfh which does not have the code to handle
>>>>>>>>>>> nfserr_stale.
>>>>>>>>>>>
>>>>>>>>>>> With this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not defined the
>>>>>>>>>>> new nfs42_ssc_open returns ERR_PTR(-EIO) which causes the NFS client
>>>>>>>>>>> to switch over to the split copying (read src and write to dst).
>>>>>>>>>> That sounds reasonable, but I don't see any of the patches you've sent
>>>>>>>>>> changing that error return.  Did I overlook something, or did you mean
>>>>>>>>>> to append a patch to this message?
>>>>>>>>> Since with the patch, I did not run into the condition where
>>>>>>>>> NFS4ERR_STALE
>>>>>>>>> is returned so I did not fix this return error code. Do you want me to
>>>>>>>>> submit another patch to change the returned error code from
>>>>>>>>> NFS4ERR_STALE
>>>>>>>>> to NFS4ERR_NOTSUPP if it ever runs into that condition?
>>>>>>>> That would be great, thanks.  (I mean, it is still possible to hit that
>>>>>>>> case, right?  You just didn't test with !CONFIG_NFSD_V4_2_INTER_SSC ?)
>>>>>>> will do. I did tested with (!CONFIG_NFSD_V4_2_INTER_SSC) but did not hit
>>>>>>> this case.
>>>>>> I need to qualify this, the copy_file_range syscall did not return
>>>>>> ESTALE in the test.
>>>>>>
>>>>>>> Because with this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not
>>>>>>> defined the new nfs42_ssc_open returns ERR_PTR(-EIO), instead of NULL in
>>>>>>> the old code, which causes the NFS client to switch over to the split
>>>>>>> copying (read src and write to dst).
>>>>>> This is not the reason why the client switches to generic_copy_file_range.
>>>>>>
>>>>>>> Returning NULL in the old nfs42_ssc_open is not correct, it allows
>>>>>>> the copy
>>>>>>> operation to proceed and hits the NFS4ERR_STALE case in the COPY
>>>>>>> operation.
>>>>>> I retested with (!CONFIG_NFSD_V4_2_INTER_SSC) and saw NFS4ERR_STALE
>>>>>> returned for the PUTFH of the SRC in the COPY compound. However on the
>>>>>> client nfs42_proc_copy (with commit 7e350197a1c10) replaced the ESTALE
>>>>>> with EOPNOTSUPP causing nfs4_copy_file_range to use generic_copy_file_range
>>>>>> to do the copy.
>>>>>>
>>>>>> The ESTALE error is only returned by copy_file_range if the client
>>>>>> does not have commit 7e350197a1c10. So I think there is no need to
>>>>>> make any change on the source server for the NFS4ERR_STALE error.
>>>>> I don't believe NFS4ERR_STALE is the correct error for the server to
>>>>> return.  It's nice that the client is able to do the right thing despite
>>>>> the server returning the wrong error, but we should still try to get
>>>>> this right on the server.
>>>> Hi Bruce,
>>>>
>>>> ERR_STALE is the appropriate error to be returned by the server that
>>>> gets a COPY compound when it doesn't support COPY. Since server can't
>>>> understand the filehandle so it can't process it so we can't get to
>>>> processing COPY opcode where the server could have returned
>>>> EOPNOTSUPP.
>>> The case we're discussing is the case where we support COPY but not
>>> server-to-server copy.
>> My point is still the same, that's an appropriate error for when
>> server-to-server copy is not supported.
> Uh, OK, if it backs up and returns it to the PUTFH, I guess?
>
> Was it really the intention of nfsd4_do_async_copy() that it return
> STALE in the case NFS42_ssc_open() returns NULL?  That's pretty
> confusing.

In this scenario, the COPY compound fails at the PUTFH op and
NFS4ERR_NOTSUPP is not a valid error code for PUTFH, NFS4ERR_STALE is.

 From section 15.2 of RFC 8881:

>       | PUTFH                | NFS4ERR_BADHANDLE, NFS4ERR_BADXDR,     |
>       |                      | NFS4ERR_DEADSESSION, NFS4ERR_DELAY,    |
>       |                      | NFS4ERR_MOVED,                         |
>       |                      | NFS4ERR_OP_NOT_IN_SESSION,             |
>       |                      | NFS4ERR_REP_TOO_BIG,                   |
>       |                      | NFS4ERR_REP_TOO_BIG_TO_CACHE,          |
>       |                      | NFS4ERR_REQ_TOO_BIG,                   |
>       |                      | NFS4ERR_RETRY_UNCACHED_REP,            |
>       |                      | NFS4ERR_SERVERFAULT, NFS4ERR_STALE,    |
>       |                      | NFS4ERR_TOO_MANY_OPS, NFS4ERR_WRONGSEC |

Regarding fh_verify returns NFS4ERR_STALE, I think the code works as the spec
describes in 15.23 of RFC 7862:
>     If the request is for an inter-server copy, the source-fh is a
>     filehandle from the source server and the COMPOUND procedure is being
>     executed on the destination server.  In this case, the source-fh is a
>     foreign filehandle on the server receiving the COPY request.  If
>     either PUTFH or SAVEFH checked the validity of the filehandle, the
>     operation would likely fail and return NFS4ERR_STALE.

-Dai

>
> --b.
>
>>> --b.
>>>
>>>> Thus a client side patch is needed and the server is doing
>>>> everything it can in the situation.
>>>>
>>>> I'm confused about the title of this patch. I thought what it does is
>>>> removes NFSD dependency on the NFS and instead loads the needed
>>>> function dynamically.
>>>>
>>>> Honestly, I don't understand why that allows removal of the NFS_FS
>>>> from the dependencies I don't understand. nfs4_ssc_open calls nfs
>>>> client functions that are built when NFS_FS is compiled but I'm
>>>> assuming will not be otherwise.
