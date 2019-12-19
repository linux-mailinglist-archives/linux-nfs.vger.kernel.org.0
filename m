Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5305126641
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 16:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfLSP5q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 10:57:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40038 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLSP5q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Dec 2019 10:57:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJFsPaI108018;
        Thu, 19 Dec 2019 15:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=0Tn4RwMUXuttgoq9WDh6XDeDmvjSL2Xov8ZCho9FKg8=;
 b=FZPiibEDHk2Dcz05Hc9XAwkaSNHbSFUUFcyVTve7SzvE1nc1mjxOVKdhUo7taQX6q8+C
 sKi1M9nJFl9qRrUIR3eowj3jBHOsOa3xfzdIgqwS/RJVYUCkGFeiPN+ZD+pZlcyWq+JH
 f6OUfSpKQp/VJPATKGAO+HyS6yKors3nmtANI0FWREEzuAl3As8WLYalwx1W5mvqB4lH
 oizqQxSdGvuDK4d0Q8vymz21EZx3Ay7V6Fc9PaGny6n1VKu7s4jcN+VCE5ETLWBysQjs
 skrW2HGhPFh+4YWOX7RzqmUTSQx3AHLXU4+0M86xyRFOsMnY0zTVJhKJGfM6QogLVMDc pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2x01knkqdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 15:57:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJFrV13171921;
        Thu, 19 Dec 2019 15:57:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wyxqhw23j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 15:57:40 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJFvcdS005718;
        Thu, 19 Dec 2019 15:57:38 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 07:57:38 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: rdma compile error
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyHmqs2ZWZHKBbockHX_kEcXbnqB=kAfVqtkv-BLhpZHTg@mail.gmail.com>
Date:   Thu, 19 Dec 2019 10:57:36 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <44C74BBB-3181-4F00-BFD8-784555C80F23@oracle.com>
References: <CAN-5tyHR8RKtsVNdg6vrSN50Sf9x9XWn-VX0pXBPetAY4Mj7nA@mail.gmail.com>
 <5E198AD1-41F7-4211-83CA-85680D8FB115@oracle.com>
 <CAN-5tyEPhcE6NBktsqRKySyAUi6EeC_saWFH8A7tKFZ+Sb0jMg@mail.gmail.com>
 <7D6BD48C-E6B3-43D4-8A31-99F0B387EF77@oracle.com>
 <CAN-5tyHmqs2ZWZHKBbockHX_kEcXbnqB=kAfVqtkv-BLhpZHTg@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190132
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 4, 2019, at 2:09 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Wed, Dec 4, 2019 at 1:25 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Dec 4, 2019, at 1:12 PM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>=20
>>> On Wed, Dec 4, 2019 at 1:02 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>>=20
>>>> Hi Olga-
>>>>=20
>>>>> On Dec 4, 2019, at 11:15 AM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>>>=20
>>>>> Hi Chuck,
>>>>>=20
>>>>> I git cloned your origin/cel-testing, it's on the following =
commit.
>>>>> commit 37e235c0128566e9d97741ad1e546b44f324f108
>>>>> Author: Chuck Lever <chuck.lever@oracle.com>
>>>>> Date:   Fri Nov 29 12:06:00 2019 -0500
>>>>>=20
>>>>>  xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
>>>>>=20
>>>>> And I'm getting the following compile error.
>>>>>=20
>>>>> CC [M]  drivers/infiniband/core/cma_trace.o
>>>>> In file included from drivers/infiniband/core/cma_trace.h:302:0,
>>>>>               from drivers/infiniband/core/cma_trace.c:16:
>>>>> ./include/trace/define_trace.h:95:43: fatal error: ./cma_trace.h: =
No
>>>>> such file or directory
>>>>> #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>>>>>                                         ^
>>>>> Is this known?
>>>>=20
>>>> I haven't had any complaints from lkp.
>>>>=20
>>>> f73179592745 ("RDMA/cma: Add trace points in RDMA Connection =
Manager")
>>>>=20
>>>> should have added drivers/infiniband/core/cma_trace.h .
>>>>=20
>>>=20
>>> The file "cma_trace.h" is there in the "core" directory. But for =
some
>>> reason my compile expects it to be in include/trace directory (if I
>>> were to copy it there I can compile).
>>=20
>> The end of cma_trace.h should have:
>>=20
>> #undef TRACE_INCLUDE_PATH
>> #define TRACE_INCLUDE_PATH .
>> #define TRACE_INCLUDE_FILE cma_trace
>=20
> It does have it.
>=20
>> That is supposed to steer the compiler to the cma_trace.h in core/ .
>>=20
>> Does a "make mrproper; git clean -d -f -x" help? Feels like there's
>> a stale generated file somewhere that's breaking things.
>=20
> I probably do have something uncleaned. I have tried what you
> suggested but it's not helping. This build is a tar of a git clone
> tree then copied into an internal lab (with rdma hardware).

I found a very similar compile issue yesterday. The fix is in the
current cel-testing topic branch, if you are interested.


--
Chuck Lever



