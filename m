Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A544113492
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfLDSZR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 13:25:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36294 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfLDSZQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 13:25:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4IONjY073240;
        Wed, 4 Dec 2019 18:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Mb3NN3Hqpjxb/0vGUuESZFitvtqH6DXw9U54/HR3d/c=;
 b=eThyBKeeXIj0pOshh7s62KqW0WAqOOTvFNUW2x0deyEmPo8kZeNSj3dxlw9A+9MUWxxH
 dMZpSICouvdmIRVtsDMaA7mxJlRH8Rx22uR84UKGeV3P/hmXFihFFVHeCrSAxmDdIjyb
 0cuPG8k1aJrUY1iHkDc0KciEdQWIVxFrudB6fWHMO7d5p0uxtcgK4E8wkjgsLvekk/QG
 D06ACXqRd1Fv46YKAN5k2n8OFeNWthEX5goFXGxM++yyrHQFe7RwnyfdtUW6yTB6bjir
 PgJyeGPYGVHISUTYDzoYSDZBkUonXLHkuV20VZOq82nSd1w8NGorAhJVAXCpLma/6pZy 7w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wkgcqg522-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 18:25:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4IOLc4085075;
        Wed, 4 Dec 2019 18:25:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wnvr0gncx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 18:25:04 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB4IP3IG014432;
        Wed, 4 Dec 2019 18:25:03 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 10:25:03 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: rdma compile error
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyEPhcE6NBktsqRKySyAUi6EeC_saWFH8A7tKFZ+Sb0jMg@mail.gmail.com>
Date:   Wed, 4 Dec 2019 13:25:01 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7D6BD48C-E6B3-43D4-8A31-99F0B387EF77@oracle.com>
References: <CAN-5tyHR8RKtsVNdg6vrSN50Sf9x9XWn-VX0pXBPetAY4Mj7nA@mail.gmail.com>
 <5E198AD1-41F7-4211-83CA-85680D8FB115@oracle.com>
 <CAN-5tyEPhcE6NBktsqRKySyAUi6EeC_saWFH8A7tKFZ+Sb0jMg@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040148
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 4, 2019, at 1:12 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> 
> On Wed, Dec 4, 2019 at 1:02 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>> 
>> Hi Olga-
>> 
>>> On Dec 4, 2019, at 11:15 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>> 
>>> Hi Chuck,
>>> 
>>> I git cloned your origin/cel-testing, it's on the following commit.
>>> commit 37e235c0128566e9d97741ad1e546b44f324f108
>>> Author: Chuck Lever <chuck.lever@oracle.com>
>>> Date:   Fri Nov 29 12:06:00 2019 -0500
>>> 
>>>   xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
>>> 
>>> And I'm getting the following compile error.
>>> 
>>> CC [M]  drivers/infiniband/core/cma_trace.o
>>> In file included from drivers/infiniband/core/cma_trace.h:302:0,
>>>                from drivers/infiniband/core/cma_trace.c:16:
>>> ./include/trace/define_trace.h:95:43: fatal error: ./cma_trace.h: No
>>> such file or directory
>>> #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>>>                                          ^
>>> Is this known?
>> 
>> I haven't had any complaints from lkp.
>> 
>> f73179592745 ("RDMA/cma: Add trace points in RDMA Connection Manager")
>> 
>> should have added drivers/infiniband/core/cma_trace.h .
>> 
> 
> The file "cma_trace.h" is there in the "core" directory. But for some
> reason my compile expects it to be in include/trace directory (if I
> were to copy it there I can compile).

The end of cma_trace.h should have:

#undef TRACE_INCLUDE_PATH
#define TRACE_INCLUDE_PATH .
#define TRACE_INCLUDE_FILE cma_trace

That is supposed to steer the compiler to the cma_trace.h in core/ .

Does a "make mrproper; git clean -d -f -x" help? Feels like there's
a stale generated file somewhere that's breaking things.


--
Chuck Lever



