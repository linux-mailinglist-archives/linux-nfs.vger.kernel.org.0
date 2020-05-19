Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C991D9C2A
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2020 18:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgESQOa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 May 2020 12:14:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46448 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgESQOa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 May 2020 12:14:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JGDND2192381;
        Tue, 19 May 2020 16:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=dNwq7+/anFf/qlMqjwlfCb9Zq98wVtpsmS+NuBQU2sE=;
 b=azNbBfJCYsTWIu5hPZUWMFARyifBzPHJc0JPaVzyERtMEt7gEOmmuhewr2dHgETK10sY
 pO1iN65Pnqk7TC8yyXKYpfSPfCTYaoNIDHX5rvB5H0TBqcDZGhyQI46PrYccdITEqTFp
 SrHGSKY2rIKvHo9v6t0aERy/+c4lIICB45hAIcpg9XWCHhGEcvPHu2NSUbmwBZDgOEbQ
 ESJogs/AFwtZE++xJ8c6w0UxQHpENjuLyTL4vKy6zOigHCdjuzg3pL+HLYgTbPaIw6XH
 H49ihm3bMXc9UYWvjQ5FLKYhgoOueKbdXZugct27kSzcBHROlTIWlOxBLixrYkUaoBpB 2g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3128tne9gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 16:14:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JGEOI9143861;
        Tue, 19 May 2020 16:14:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 314gm58r3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 16:14:27 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04JGEPKP017060;
        Tue, 19 May 2020 16:14:25 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 09:14:25 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 00/29] Possible NFSD patches for v5.8
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200519161108.GD25858@fieldses.org>
Date:   Tue, 19 May 2020 12:14:22 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <81E97D7E-7B8D-4C64-844A-18EF0346C49C@oracle.com>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
 <20200519161108.GD25858@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 cotscore=-2147483648 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190137
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 19, 2020, at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> I'm getting a repeatable timeout failure on python 4.0 test WRT15.  In
> pynfs, run:=20
>=20
> 	./nfs4.0/testserver.py server:/export/path --rundeps --maketree =
WRT15
>=20
> Looks like it sends WRITE+GETATTR(FATTR4_SIZE) compounds with write
> offset 0 and write length taking on every value from 0 to 8192.
>=20
> Probably an xdr decoding bug of some kind?

My first thought is to bisect, but I don't see a particular change in my
v5.8 series that would plausibly introduce this class of problem.


> I don't see anything in the server logs.
>=20
> --b.
>=20
> On Tue, May 12, 2020 at 05:22:04PM -0400, Chuck Lever wrote:
>> Available to view:
>>  =
https://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dshortlog;h=3Drefs/heads=
/nfsd-5.8
>>=20
>> Pull from:
>>  git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-5.8
>>=20
>> Highlights of this series:
>> * Remove serialization of sending RPC/RDMA Replies
>> * Convert the TCP socket send path to use xdr_buf::bvecs =
(pre-requisite for RPC-on-TLS)
>> * Fix svcrdma backchannel sendto return code
>> * Convert a number of dprintk call sites to use tracepoints
>> * Fix the "suggest braces around empty body in an =E2=80=98else=E2=80=99=
 statement" warning
>>=20
>> Changes since v1:
>> * Rebased on v5.7-rc5+
>> * Re-organized the series so changes interesting to linux-rdma appear =
together
>> * Addressed sparse warnings found by the kbuild test robot
>> * Included an additional minor clean-up: removal of the unused =
SVCRDMA_DEBUG macro
>> * Clarified several patch descriptions
>>=20
>> ---
>>=20
>> Chuck Lever (29):
>>      SUNRPC: Move xpt_mutex into socket xpo_sendto methods
>>      svcrdma: Clean up the tracing for rw_ctx_init errors
>>      svcrdma: Clean up handling of get_rw_ctx errors
>>      svcrdma: Trace page overruns when constructing RDMA Reads
>>      svcrdma: trace undersized Write chunks
>>      svcrdma: Fix backchannel return code
>>      svcrdma: Remove backchannel dprintk call sites
>>      svcrdma: Rename tracepoints that record header decoding errors
>>      svcrdma: Remove the SVCRDMA_DEBUG macro
>>      svcrdma: Displayed remote IP address should match stored address
>>      svcrdma: Add tracepoints to report ->xpo_accept failures
>>      SUNRPC: Remove kernel memory address from svc_xprt tracepoints
>>      SUNRPC: Tracepoint to record errors in svc_xpo_create()
>>      SUNRPC: Trace a few more generic svc_xprt events
>>      SUNRPC: Remove "#include <trace/events/skb.h>"
>>      SUNRPC: Add more svcsock tracepoints
>>      SUNRPC: Replace dprintk call sites in TCP state change callouts
>>      SUNRPC: Trace server-side rpcbind registration events
>>      SUNRPC: Rename svc_sock::sk_reclen
>>      SUNRPC: Restructure svc_tcp_recv_record()
>>      SUNRPC: Refactor svc_recvfrom()
>>      SUNRPC: Restructure svc_udp_recvfrom()
>>      SUNRPC: svc_show_status() macro should have enum definitions
>>      NFSD: Add tracepoints to NFSD's duplicate reply cache
>>      NFSD: Add tracepoints to the NFSD state management code
>>      NFSD: Add tracepoints for monitoring NFSD callbacks
>>      SUNRPC: Clean up request deferral tracepoints
>>      NFSD: Squash an annoying compiler warning
>>      NFSD: Fix improperly-formatted Doxygen comments
>>=20
>>=20
>> fs/nfsd/nfs4callback.c                     |  37 +-
>> fs/nfsd/nfs4proc.c                         |   7 +-
>> fs/nfsd/nfs4state.c                        |  63 ++--
>> fs/nfsd/nfscache.c                         |  57 +--
>> fs/nfsd/nfsctl.c                           |  26 +-
>> fs/nfsd/state.h                            |   7 -
>> fs/nfsd/trace.h                            | 345 ++++++++++++++++++
>> include/linux/sunrpc/svc.h                 |   1 +
>> include/linux/sunrpc/svc_rdma.h            |   6 +-
>> include/linux/sunrpc/svcsock.h             |   6 +-
>> include/trace/events/rpcrdma.h             | 142 ++++++--
>> include/trace/events/sunrpc.h              | 387 ++++++++++++++++++--
>> net/sunrpc/svc.c                           |  19 +-
>> net/sunrpc/svc_xprt.c                      |  41 +--
>> net/sunrpc/svcsock.c                       | 393 =
++++++++++-----------
>> net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  86 +----
>> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  21 +-
>> net/sunrpc/xprtrdma/svc_rdma_rw.c          |  92 ++---
>> net/sunrpc/xprtrdma/svc_rdma_transport.c   |  55 ++-
>> 19 files changed, 1221 insertions(+), 570 deletions(-)
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



