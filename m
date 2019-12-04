Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702D3113479
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 19:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfLDSCA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 13:02:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbfLDSB7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 13:01:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4HxTet052670;
        Wed, 4 Dec 2019 18:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=kQRIOsiKQx4tPa0Vo3LlOb2sD5nOiLoyevklJvCJfQk=;
 b=gRkxhEmz3kjo/7uU69ZWug75++b6TR8KHG5VriVy30Yi8CnXXcKWUfkrGb5sSv7xksLr
 p03eBd2HDlEBRbxBdAdep1bINi19F6Po8Z2ArjvtqXaKRDz1eChmgoobaeWUSIxzbESo
 rnmBh72dvFDfVPairHOsoSa3MIRLhEOVHqKGV84xCFhyXhhR1XNM8Vk02fDHlM3j/5w+
 V3Ye0Kch52q64GvSj/LyfgnlXV1fV/oY5C6az7eK0DsWyGc3QNn01sKMNxNLp7rBVcYM
 EzyXrQY+IyBSDoXgAw1Zbg/qqTx8y0kB9Awy1BAytkNmred+CwBKtDs4P6PhrzX6qN4i nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wkgcqg143-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 18:01:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4Hxen2138802;
        Wed, 4 Dec 2019 18:01:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wp20d210d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 18:01:52 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB4I1qwY004495;
        Wed, 4 Dec 2019 18:01:52 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 10:01:52 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: rdma compile error
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyHR8RKtsVNdg6vrSN50Sf9x9XWn-VX0pXBPetAY4Mj7nA@mail.gmail.com>
Date:   Wed, 4 Dec 2019 13:01:50 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <5E198AD1-41F7-4211-83CA-85680D8FB115@oracle.com>
References: <CAN-5tyHR8RKtsVNdg6vrSN50Sf9x9XWn-VX0pXBPetAY4Mj7nA@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040144
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga-

> On Dec 4, 2019, at 11:15 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> 
> Hi Chuck,
> 
> I git cloned your origin/cel-testing, it's on the following commit.
> commit 37e235c0128566e9d97741ad1e546b44f324f108
> Author: Chuck Lever <chuck.lever@oracle.com>
> Date:   Fri Nov 29 12:06:00 2019 -0500
> 
>    xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
> 
> And I'm getting the following compile error.
> 
>  CC [M]  drivers/infiniband/core/cma_trace.o
> In file included from drivers/infiniband/core/cma_trace.h:302:0,
>                 from drivers/infiniband/core/cma_trace.c:16:
> ./include/trace/define_trace.h:95:43: fatal error: ./cma_trace.h: No
> such file or directory
> #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>                                           ^
> Is this known?

I haven't had any complaints from lkp.

f73179592745 ("RDMA/cma: Add trace points in RDMA Connection Manager")

should have added drivers/infiniband/core/cma_trace.h .


--
Chuck Lever



