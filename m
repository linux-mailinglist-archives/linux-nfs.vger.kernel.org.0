Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6442AE23D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJV4S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:56:18 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51712 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJV4R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 16:56:17 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AALeEjj095482;
        Tue, 10 Nov 2020 21:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vU973NbIOXDnuWcIlCf4L9Z3WsD4Ec9Rms+7WxuNxg4=;
 b=r1XR+IJfQ1GehmebjLe7Qv4ECgOj5PNEZVPetP9X5hK7c60FhgAyOtdCHqp/+U+UYrak
 0mWk5uBlyWyBdSH/Qf8+V0YNR3dEr49rRgS39Jh+M3+A4+hpdFD4Jz+Nc/qtWOrJSJZH
 hfhQ7zInCB8V5A3Z07TyJ7zAtuHvzgqz+yHTBtxd2IsajS035EThocv1s+ggrFxylxDg
 KtpsnJqSqmdqh569u+gjgLChDsdzYtK+WYFTY5tB6Et5N6g18DfH/+sedjLj8hA35nhi
 IB4+/LB1lTr+sZWNGNZQ0wHBhxzLUldA3PrCDRt131KOHTiSWqOvquB3TTEkCaQUubv9 Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34nh3axcu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 21:56:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AALf5Ba084242;
        Tue, 10 Nov 2020 21:54:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34qgp7ev4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 21:54:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AALs41C032299;
        Tue, 10 Nov 2020 21:54:04 GMT
Received: from dhcp-10-154-129-233.vpn.oracle.com (/10.154.129.233)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 13:54:04 -0800
Subject: Re: [PATCH v4 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter
 server copy
To:     Olga Kornievskaia <aglo@umich.edu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <20201019034249.27990-1-dai.ngo@oracle.com>
 <20201020170114.GF1133@fieldses.org>
 <fb514565-cd47-9180-2adc-f3ba4459202b@oracle.com>
 <20201109183054.GD11144@fieldses.org>
 <eeafd9e2-5d04-848e-d330-670e2185098d@oracle.com>
 <20201109204206.GA20261@fieldses.org>
 <7a18452a-3120-ea5b-f676-9d7e18a65446@oracle.com>
 <470b690f-c919-2c48-95b7-18cc75f71f70@oracle.com>
 <20201110201239.GA17755@fieldses.org>
 <CAN-5tyHEj_nNhN=wM3xkzsAp2RUqQw4pVau+DruFPXGT8j+kuw@mail.gmail.com>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <85d4157e-ca94-f716-042e-9ba29e2019cc@oracle.com>
Date:   Tue, 10 Nov 2020 13:54:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyHEj_nNhN=wM3xkzsAp2RUqQw4pVau+DruFPXGT8j+kuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=3 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=3
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100148
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11/10/20 1:07 PM, Olga Kornievskaia wrote:
> On Tue, Nov 10, 2020 at 3:14 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>> On Mon, Nov 09, 2020 at 10:46:12PM -0800, Dai Ngo wrote:
>>> On 11/9/20 2:26 PM, Dai Ngo wrote:
>>>> On 11/9/20 12:42 PM, J. Bruce Fields wrote:
>>>>> On Mon, Nov 09, 2020 at 11:34:08AM -0800, Dai Ngo wrote:
>>>>>> On 11/9/20 10:30 AM, J. Bruce Fields wrote:
>>>>>>> On Tue, Oct 20, 2020 at 11:34:35AM -0700, Dai Ngo wrote:
>>>>>>>> On 10/20/20 10:01 AM, J. Bruce Fields wrote:
>>>>>>>>> On Sun, Oct 18, 2020 at 11:42:49PM -0400, Dai Ngo wrote:
>>>>>>>>>> NFS_FS=y as dependency of CONFIG_NFSD_V4_2_INTER_SSC still have
>>>>>>>>>> build errors and some configs with NFSD=m to get NFS4ERR_STALE
>>>>>>>>>> error when doing inter server copy.
>>>>>>>>>>
>>>>>>>>>> Added ops table in nfs_common for knfsd to access NFS
>>>>>>>>>> client modules.
>>>>>>>>> OK, looks reasonable to me, applying.  Does this resolve all the
>>>>>>>>> problems you've seen, or is there any bad case left?
>>>>>>>> Thanks Bruce.
>>>>>>>>
>>>>>>>> With this patch, I no longer see the NFS4ERR_STALE in any config.
>>>>>>>>
>>>>>>>> The problem with NFS4ERR_STALE was because of a bug in
>>>>>>>> nfs42_ssc_open.
>>>>>>>> When CONFIG_NFSD_V4_2_INTER_SSC is not defined, nfs42_ssc_open
>>>>>>>> returns NULL which is incorrect allowing the operation to continue
>>>>>>>> until nfsd4_putfh which does not have the code to handle
>>>>>>>> nfserr_stale.
>>>>>>>>
>>>>>>>> With this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not defined the
>>>>>>>> new nfs42_ssc_open returns ERR_PTR(-EIO) which causes the NFS client
>>>>>>>> to switch over to the split copying (read src and write to dst).
>>>>>>> That sounds reasonable, but I don't see any of the patches you've sent
>>>>>>> changing that error return.  Did I overlook something, or did you mean
>>>>>>> to append a patch to this message?
>>>>>> Since with the patch, I did not run into the condition where
>>>>>> NFS4ERR_STALE
>>>>>> is returned so I did not fix this return error code. Do you want me to
>>>>>> submit another patch to change the returned error code from
>>>>>> NFS4ERR_STALE
>>>>>> to NFS4ERR_NOTSUPP if it ever runs into that condition?
>>>>> That would be great, thanks.  (I mean, it is still possible to hit that
>>>>> case, right?  You just didn't test with !CONFIG_NFSD_V4_2_INTER_SSC ?)
>>>> will do. I did tested with (!CONFIG_NFSD_V4_2_INTER_SSC) but did not hit
>>>> this case.
>>> I need to qualify this, the copy_file_range syscall did not return
>>> ESTALE in the test.
>>>
>>>> Because with this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not
>>>> defined the new nfs42_ssc_open returns ERR_PTR(-EIO), instead of NULL in
>>>> the old code, which causes the NFS client to switch over to the split
>>>> copying (read src and write to dst).
>>> This is not the reason why the client switches to generic_copy_file_range.
>>>
>>>> Returning NULL in the old nfs42_ssc_open is not correct, it allows
>>>> the copy
>>>> operation to proceed and hits the NFS4ERR_STALE case in the COPY
>>>> operation.
>>> I retested with (!CONFIG_NFSD_V4_2_INTER_SSC) and saw NFS4ERR_STALE
>>> returned for the PUTFH of the SRC in the COPY compound. However on the
>>> client nfs42_proc_copy (with commit 7e350197a1c10) replaced the ESTALE
>>> with EOPNOTSUPP causing nfs4_copy_file_range to use generic_copy_file_range
>>> to do the copy.
>>>
>>> The ESTALE error is only returned by copy_file_range if the client
>>> does not have commit 7e350197a1c10. So I think there is no need to
>>> make any change on the source server for the NFS4ERR_STALE error.
>> I don't believe NFS4ERR_STALE is the correct error for the server to
>> return.  It's nice that the client is able to do the right thing despite
>> the server returning the wrong error, but we should still try to get
>> this right on the server.

Hi Olga,

> Hi Bruce,
>
> ERR_STALE is the appropriate error to be returned by the server that
> gets a COPY compound when it doesn't support COPY. Since server can't
> understand the filehandle so it can't process it so we can't get to
> processing COPY opcode where the server could have returned
> EOPNOTSUPP. Thus a client side patch is needed and the server is doing
> everything it can in the situation.
>
> I'm confused about the title of this patch. I thought what it does is
> removes NFSD dependency on the NFS and instead loads the needed
> function dynamically.

Yes, the title of the patch is misleading. The main goal of the patch
is to add the ops table in nfs_common for knfsd to access NFS client
modules without calling these functions directly. This also prevents
build errors in config such as when NFSD=y and NFS_FS=m.

-Dai

>
> Honestly, I don't understand why that allows removal of the NFS_FS
> from the dependencies I don't understand. nfs4_ssc_open calls nfs
> client functions that are built when NFS_FS is compiled but I'm
> assuming will not be otherwise.
>
>
>> --b.
