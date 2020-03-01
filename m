Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875EC174EE0
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2020 19:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCASMa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 13:12:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43976 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCASMa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 13:12:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 021IAAeN004208;
        Sun, 1 Mar 2020 18:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ZZxiB4h1tWL5VBvR0EDV07M8QDEq5UmjiwyyYe8MlTY=;
 b=RK2eyc239vOlPYGJ3aANZNmA4yeb0OrNFfjPLAZuXN//pDxWv9arQpQ9CmHwQx/Wi3Dt
 w2tUg54eZ9DgqNcC990PR7HHf+nvseypWmhNw0wht40IY3D3ldtf2Bb5VtJ9NFBSpzwG
 bSXZuBA5bRfkgd8hMx9ZD/2IPp+2fzAyAkOhR6CXtMPukow1bP3OkYgDginAmqnCgw/C
 5r9gR1rLynfMm3fj2gZmaZyS7RX5NoE9XNgA5y9jm5Ge6g9u0nv0keEXoLChNBqx+Jtz
 PVDhf9hA4q4Id9TcI3lYi86inO7XNVLieAqxy0ho+tLawu8PMk5FhNvX5gfpSjqxtJjW dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yghn2r1kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Mar 2020 18:12:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 021ICRuo073095;
        Sun, 1 Mar 2020 18:12:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yg1ef11eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Mar 2020 18:12:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 021ICGv6007784;
        Sun, 1 Mar 2020 18:12:16 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Mar 2020 10:12:15 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 00/11] NFS/RDMA client side connection overhaul
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <3a891d0c-3192-6445-c4df-3725335e9d95@talpey.com>
Date:   Sun, 1 Mar 2020 13:12:14 -0500
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7D498F4-07BB-4F8A-A95D-B14A1217E73C@oracle.com>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
 <3a891d0c-3192-6445-c4df-3725335e9d95@talpey.com>
To:     Tom Talpey <tom@talpey.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=993 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003010143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003010142
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 1, 2020, at 1:09 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 2/21/2020 2:00 PM, Chuck Lever wrote:
>> Howdy.
>> I've had reports (and personal experience) where the Linux NFS/RDMA
>> client waits for a very long time after a disruption of the network
>> or NFS server.
>> There is a disconnect time wait in the Connection Manager which
>> blocks the RPC/RDMA transport from tearing down a connection for a
>> few minutes when the remote cannot respond to DREQ messages.
>=20
> This seems really unfortunate. Why such a long wait in the RDMA layer?
> I can see a backoff, to prevent connection attempt flooding, but a
> constant "few minute" pause is a very blunt instrument.

The last clause here is the operative conundrum: "when the remote
cannot respond". That should be pretty rare, but it's frequent
enough to be bothersome in some environments.

As to why the time wait is so long, I don't know the answer to that.


>> An RPC/RDMA transport has only one slot for connection state, so the
>> transport is prevented from establishing a fresh connection until
>> the time wait completes.
>> This patch series refactors the connection end point data structures
>> to enable one active and multiple zombie connections. Now, while a
>> defunct connection is waiting to die, it is separated from the
>> transport, clearing the way for the immediate creation of a new
>> connection. Clean-up of the old connection's data structures and
>> resources then completes in the background.
>=20
> This is a good idea in any case. It separates the layers, and leads
> to better connection establishment throughput.
>=20
> Does the RPCRDMA layer ensure it backs off, if connection retries
> fail? Or are you depending on the NFS upper layer for this.

There is a complicated back-off scheme that is modeled on the TCP
connection back-off logic.


> Tom.
>=20
>> Well, that's the idea, anyway. Review and comments welcome. Hoping
>> this can be merged in v5.7.
>> ---
>> Chuck Lever (11):
>>       xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
>>       xprtrdma: Refactor frwr_init_mr()
>>       xprtrdma: Clean up the post_send path
>>       xprtrdma: Refactor rpcrdma_ep_connect() and =
rpcrdma_ep_disconnect()
>>       xprtrdma: Allocate Protection Domain in rpcrdma_ep_create()
>>       xprtrdma: Invoke rpcrdma_ia_open in the connect worker
>>       xprtrdma: Remove rpcrdma_ia::ri_flags
>>       xprtrdma: Disconnect on flushed completion
>>       xprtrdma: Merge struct rpcrdma_ia into struct rpcrdma_ep
>>       xprtrdma: Extract sockaddr from struct rdma_cm_id
>>       xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt
>>  include/trace/events/rpcrdma.h    |   97 ++---
>>  net/sunrpc/xprtrdma/backchannel.c |    8
>>  net/sunrpc/xprtrdma/frwr_ops.c    |  152 ++++----
>>  net/sunrpc/xprtrdma/rpc_rdma.c    |   32 +-
>>  net/sunrpc/xprtrdma/transport.c   |   72 +---
>>  net/sunrpc/xprtrdma/verbs.c       |  681 =
++++++++++++++-----------------------
>>  net/sunrpc/xprtrdma/xprt_rdma.h   |   89 ++---
>>  7 files changed, 445 insertions(+), 686 deletions(-)
>> --
>> Chuck Lever

--
Chuck Lever



