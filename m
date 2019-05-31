Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B031054
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEaOew (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 May 2019 10:34:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54676 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfEaOew (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 May 2019 10:34:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VEXlM0105352;
        Fri, 31 May 2019 14:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=vzLZGemaFjvXHnQ/Zx0FcK23a4/e/5VYAFocn3ujbDE=;
 b=0ET2Xo8hMu2anmLQiEc+NiOU/73kfvgqBh5lg/enSAAkO9VfP0IUUK9iHlqLxnFfC1MR
 PRExcgrxTeONbXDdZZ0NXwfpbX/vNlFxgijZHjTVG9unO+GEtUFYzmwmaxk4h/XQilCT
 HGToF4bSOgQb6wJlgPkmg0k7xDiUnQiU7UWqU551H0Xc6l8ge8raJDKqOA/xeIxzes8v
 oCfIwGt30otvnKkRF8DEXupieJhnfvufupPmQy11oY/qPOTZom//X6rbzpjvQn+A2KSo
 LKaVReOGdYxmhC8VuLWpGzmdWeFqxKXCwu43YR+BQXe/ujhDH8r6/C9JbHIQdqpZrkwJ lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4txnx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 14:34:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VEXSvb040256;
        Fri, 31 May 2019 14:34:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ss1fpnr09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 14:34:49 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4VEYmh2025039;
        Fri, 31 May 2019 14:34:49 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 May 2019 07:34:48 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC 00/12] for-5.3 NFS/RDMA patches for review
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ef371698-5b2f-40c2-8fcc-b3a3c57cd158@intel.com>
Date:   Fri, 31 May 2019 10:34:47 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE9BE961-6555-46FF-A9ED-601468D5DBD7@oracle.com>
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
 <ef371698-5b2f-40c2-8fcc-b3a3c57cd158@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=737
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=768 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310092
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 31, 2019, at 10:32 AM, Dennis Dalessandro =
<dennis.dalessandro@intel.com> wrote:
>=20
> On 5/28/2019 2:20 PM, Chuck Lever wrote:
>> This is a series of fixes and architectural changes that should
>> improve robustness and result in better scalability of NFS/RDMA.
>> I'm sure one or two of these could be broken down a little more,
>> comments welcome.
>> The fundamental observation is that the RPC work queues are BOUND,
>> thus rescheduling work in the Receive completion handler to one of
>> these work queues just forces it to run later on the same CPU. So
>> try to do more work right in the Receive completion handler to
>> reduce context switch overhead.
>> A secondary concern is that the average amount of wall-clock time
>> it takes to handle a single Receive completion caps the IOPS rate
>> (both per-xprt and per-NIC). In this patch series I've taken a few
>> steps to reduce that latency, and I'm looking into a few others.
>> This series can be fetched from:
>>   git://git.linux-nfs.org/projects/cel/cel-2.6.git
>> in topic branch "nfs-for-5.3".
>> ---
>> Chuck Lever (12):
>>       xprtrdma: Fix use-after-free in rpcrdma_post_recvs
>>       xprtrdma: Replace use of xdr_stream_pos in rpcrdma_marshal_req
>>       xprtrdma: Fix occasional transport deadlock
>>       xprtrdma: Remove the RPCRDMA_REQ_F_PENDING flag
>>       xprtrdma: Remove fr_state
>>       xprtrdma: Add mechanism to place MRs back on the free list
>>       xprtrdma: Reduce context switching due to Local Invalidation
>>       xprtrdma: Wake RPCs directly in rpcrdma_wc_send path
>>       xprtrdma: Simplify rpcrdma_rep_create
>>       xprtrdma: Streamline rpcrdma_post_recvs
>>       xprtrdma: Refactor chunk encoding
>>       xprtrdma: Remove rpcrdma_req::rl_buffer
>>  include/trace/events/rpcrdma.h  |   47 ++++--
>>  net/sunrpc/xprtrdma/frwr_ops.c  |  330 =
++++++++++++++++++++++++++-------------
>>  net/sunrpc/xprtrdma/rpc_rdma.c  |  146 +++++++----------
>>  net/sunrpc/xprtrdma/transport.c |   16 +-
>>  net/sunrpc/xprtrdma/verbs.c     |  115 ++++++--------
>>  net/sunrpc/xprtrdma/xprt_rdma.h |   43 +----
>>  6 files changed, 384 insertions(+), 313 deletions(-)
>=20
> For hfi1:
> Tested-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

Thanks!

--
Chuck Lever



