Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15F2ACFF1
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 07:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgKJGqY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 01:46:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50448 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKJGqY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 01:46:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AA6jbt5096875;
        Tue, 10 Nov 2020 06:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HaO194SQOxZlL1pM8UiUtYoosT76QuodL+S6Y3dk7fA=;
 b=Kj0/94T3WMb7ltxPeyOaXWVp1BjKbQcygBZkHh2G+q+jfKhIaz+InAd72AQCfOkdIsio
 SZB6EpXgFV7b/E3GDMqQJ43QfHWA4AYootZC2G/brxWjCzOGqUL5Dw5WoAKwH7br2m1V
 c9h7z3p/DksiIpLoXtuBaRnhoGASVzpZAVi5EN6k+U5UGn7xr2qqb+9Ydjt8jDCCFqNP
 mtzCnk7ZNSuUnd5C9ca/uOSPmiTT56GQP461GDaAtDvd5fXXoxqhFBvwKmafWUpkMTkS
 0NajCABv34dMLjk4UYCYw59Sx8ijUuDoAz5E5RRCb/mO9mDMZS63yfzS+6O1NZ6bqDun NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72eg1r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 06:46:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AA6k6RN049878;
        Tue, 10 Nov 2020 06:46:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34p5gwd9cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 06:46:14 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AA6kDg4026711;
        Tue, 10 Nov 2020 06:46:14 GMT
Received: from dhcp-10-154-143-59.vpn.oracle.com (/10.154.143.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 22:46:13 -0800
Subject: Re: [PATCH v4 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter
 server copy
From:   Dai Ngo <dai.ngo@oracle.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <20201019034249.27990-1-dai.ngo@oracle.com>
 <20201020170114.GF1133@fieldses.org>
 <fb514565-cd47-9180-2adc-f3ba4459202b@oracle.com>
 <20201109183054.GD11144@fieldses.org>
 <eeafd9e2-5d04-848e-d330-670e2185098d@oracle.com>
 <20201109204206.GA20261@fieldses.org>
 <7a18452a-3120-ea5b-f676-9d7e18a65446@oracle.com>
Message-ID: <470b690f-c919-2c48-95b7-18cc75f71f70@oracle.com>
Date:   Mon, 9 Nov 2020 22:46:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <7a18452a-3120-ea5b-f676-9d7e18a65446@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=3 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100046
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11/9/20 2:26 PM, Dai Ngo wrote:
>
> On 11/9/20 12:42 PM, J. Bruce Fields wrote:
>> On Mon, Nov 09, 2020 at 11:34:08AM -0800, Dai Ngo wrote:
>>> On 11/9/20 10:30 AM, J. Bruce Fields wrote:
>>>> On Tue, Oct 20, 2020 at 11:34:35AM -0700, Dai Ngo wrote:
>>>>> On 10/20/20 10:01 AM, J. Bruce Fields wrote:
>>>>>> On Sun, Oct 18, 2020 at 11:42:49PM -0400, Dai Ngo wrote:
>>>>>>> NFS_FS=y as dependency of CONFIG_NFSD_V4_2_INTER_SSC still have
>>>>>>> build errors and some configs with NFSD=m to get NFS4ERR_STALE
>>>>>>> error when doing inter server copy.
>>>>>>>
>>>>>>> Added ops table in nfs_common for knfsd to access NFS client 
>>>>>>> modules.
>>>>>> OK, looks reasonable to me, applying.  Does this resolve all the
>>>>>> problems you've seen, or is there any bad case left?
>>>>> Thanks Bruce.
>>>>>
>>>>> With this patch, I no longer see the NFS4ERR_STALE in any config.
>>>>>
>>>>> The problem with NFS4ERR_STALE was because of a bug in 
>>>>> nfs42_ssc_open.
>>>>> When CONFIG_NFSD_V4_2_INTER_SSC is not defined, nfs42_ssc_open
>>>>> returns NULL which is incorrect allowing the operation to continue
>>>>> until nfsd4_putfh which does not have the code to handle 
>>>>> nfserr_stale.
>>>>>
>>>>> With this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not defined the
>>>>> new nfs42_ssc_open returns ERR_PTR(-EIO) which causes the NFS client
>>>>> to switch over to the split copying (read src and write to dst).
>>>> That sounds reasonable, but I don't see any of the patches you've sent
>>>> changing that error return.  Did I overlook something, or did you mean
>>>> to append a patch to this message?
>>> Since with the patch, I did not run into the condition where 
>>> NFS4ERR_STALE
>>> is returned so I did not fix this return error code. Do you want me to
>>> submit another patch to change the returned error code from 
>>> NFS4ERR_STALE
>>> to NFS4ERR_NOTSUPP if it ever runs into that condition?
>> That would be great, thanks.  (I mean, it is still possible to hit that
>> case, right?  You just didn't test with !CONFIG_NFSD_V4_2_INTER_SSC ?)
>
> will do. I did tested with (!CONFIG_NFSD_V4_2_INTER_SSC) but did not hit
> this case. 

I need to qualify this, the copy_file_range syscall did not return
ESTALE in the test.

> Because with this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not
> defined the new nfs42_ssc_open returns ERR_PTR(-EIO), instead of NULL in
> the old code, which causes the NFS client to switch over to the split
> copying (read src and write to dst).

This is not the reason why the client switches to generic_copy_file_range.

> Returning NULL in the old nfs42_ssc_open is not correct, it allows the 
> copy
> operation to proceed and hits the NFS4ERR_STALE case in the COPY 
> operation.

I retested with (!CONFIG_NFSD_V4_2_INTER_SSC) and saw NFS4ERR_STALE
returned for the PUTFH of the SRC in the COPY compound. However on the
client nfs42_proc_copy (with commit 7e350197a1c10) replaced the ESTALE
with EOPNOTSUPP causing nfs4_copy_file_range to use generic_copy_file_range
to do the copy.

The ESTALE error is only returned by copy_file_range if the client
does not have commit 7e350197a1c10. So I think there is no need to
make any change on the source server for the NFS4ERR_STALE error.

-Dai

>
>
> -Dai
>
>>
>> --b.
