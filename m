Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D404278A44
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgIYOB4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 10:01:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33366 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgIYOB4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 10:01:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PDxJpY179266;
        Fri, 25 Sep 2020 14:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=OP4zlzxTaclddHnnMchV4FmyqlBomTtuF5gSG1jMMaQ=;
 b=fCUPtVaPABvJsJPIwLKBUEvVmLejwTzG4BCjKooUwasR0BZIgl0krlECa29JhNZzzrj0
 VvzNbYXBraG98YHJYwItrjT2QKDQZxOJR9iI6KRK2UG5LNJzF/E71D2+Lkc6BOHOsDOx
 Qa3DY7Jk95x/CPVuHqGkEK5RY89qPPUznORnON1Q2+oJpS0jE+X5nTJK3exJiCHkvlLP
 0iFkyhEqXXcqJ/QEjB6Kw2e1JKuDJxp32CGBvycMvm+fTGD70zejk43N+9+KXiYDRM6M
 kMGhRDPwGfc6mgwpTEDJVYAHdYN4l6dOQdkMOrEF8hK+kbARL7NmyPBtyC0rl2bJt1jz sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33q5rgv74s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 14:01:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PDxXh2001958;
        Fri, 25 Sep 2020 13:59:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33nux4g3tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 13:59:53 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PDxqdZ013608;
        Fri, 25 Sep 2020 13:59:52 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 06:59:52 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2 00/27] NFSD operation monitoring tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200924213617.GA12407@fieldses.org>
Date:   Fri, 25 Sep 2020 09:59:51 -0400
Cc:     Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <945A7DE6-909D-4177-852F-F80EF7DFE6B3@oracle.com>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
 <20200924213617.GA12407@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=949 phishscore=0 suspectscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=2 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=963 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250099
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Bruce, for your time, attention, and comments!

> On Sep 24, 2020, at 5:36 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Mon, Sep 21, 2020 at 02:10:49PM -0400, Chuck Lever wrote:
>> As I've been working on various server bugs, I've been adding
>> tracepoints that record NFS operation arguments. Here's an updated
>> snapshot of this work for your review and comment.
>>=20
>> The idea here is to provide a degree of NFS traffic observability
>> without needing network capture. Tracepoints are generally lighter-
>> weight than full network capture, allowing effective capture-time
>> data reduction:
>=20
> I do wonder when tracepoints seem to duplicate information you could =
get
> from network traces, so thanks for taking the time to explain this.  =
It
> makes sense to me.
>=20
> The patches look fine.  The only one I'm I'm on the fence about is the
> last with the split up of the dispatch functions.  I'll ask some
> questions there....

To be clear to everyone, this series is still "preview". I expect
more churn in these patches, thus I don't consider the series ready
to be merged by any stretch.


> --b.
>=20
>>=20
>> - One or a handful of these can be enabled at a time
>> - Each tracepoint records much less data per operation than capture
>> - Extra capture-time filtering can reduce data amount even further
>> - Some of these operations are infrequent enough that their
>> tracepoint could be enabled persistently without a significant
>> performance impact (for example, for security auditing)
>>=20
>> The topic branch has been updated as well:
>>=20
>> git://git.linux-nfs.org/projects/cel/cel-2.6.git =
nfsd-more-tracepoints
>>=20
>>=20
>> Changes since RFC:
>> * s/SPDK/SPDX and corrected the spelling of Christoph's surname
>> * Fixed a build error noticed by <lkp@intel.com>
>> * Introduced generic headers for VFS and NFS protocol display macros
>> * nfsd4_compoundstatus now displays NFS4ERR codes symbolically
>> * The svc_process tracepoint now displays the RPC procedure =
symbolically
>> * NFSD dispatcher now displays procedure names and status codes =
symbolically
>> * fh_verify tracepoint tentatively included; it adds a lot of noise, =
but perhaps not much value
>> * Cleaned up the remaining PROC() macros in the server code
>> * Removed trace_printk's that were introduced during the RFC series
>> * Removed redundant nfsd4_close tracepoint
>>=20
>> ---
>>=20
>> Chuck Lever (27):
>>      NFS: Move generic FS show macros to global header
>>      NFS: Move NFS protocol display macros to global header
>>      NFSD: Add SPDX header for fs/nfsd/trace.c
>>      SUNRPC: Move the svc_xdr_recvfrom() tracepoint
>>      SUNRPC: Add svc_xdr_authenticate tracepoint
>>      lockd: Replace PROC() macro with open code
>>      NFSACL: Replace PROC() macro with open code
>>      SUNRPC: Make trace_svc_process() display the RPC procedure =
symbolically
>>      NFSD: Clean up the show_nf_may macro
>>      NFSD: Remove extra "0x" in tracepoint format specifier
>>      NFSD: Constify @fh argument of knfsd_fh_hash()
>>      NFSD: Add tracepoint in nfsd_setattr()
>>      NFSD: Add tracepoint for nfsd_access()
>>      NFSD: nfsd_compound_status tracepoint should record XID
>>      NFSD: Add client ID lifetime tracepoints
>>      NFSD: Add tracepoints to report NFSv4 session state
>>      NFSD: Add a tracepoint to report the current filehandle
>>      NFSD: Add GETATTR tracepoint
>>      NFSD: Add tracepoint in nfsd4_stateid_preprocess()
>>      NFSD: Add tracepoint to report arguments to NFSv4 OPEN
>>      NFSD: Add a tracepoint for DELEGRETURN
>>      NFSD: Add a lookup tracepoint
>>      NFSD: Add lock and locku tracepoints
>>      NFSD: Add tracepoints to record the result of TEST_STATEID and =
FREE_STATEID
>>      NFSD: Rename nfsd_ tracepoints to nfsd4_
>>      NFSD: Add tracepoints in the NFS dispatcher
>>      NFSD: Replace dprintk callsites in fs/nfsd/nfsfh.c
>>=20
>>=20
>> fs/lockd/svc4proc.c           | 263 +++++++++--
>> fs/lockd/svcproc.c            | 265 +++++++++--
>> fs/nfs/callback_xdr.c         |   2 +
>> fs/nfs/nfs4trace.h            | 387 ++--------------
>> fs/nfs/nfstrace.h             | 113 +----
>> fs/nfs/pnfs.h                 |   4 -
>> fs/nfsd/nfs2acl.c             |  79 +++-
>> fs/nfsd/nfs3acl.c             |  54 ++-
>> fs/nfsd/nfs3proc.c            |  25 +
>> fs/nfsd/nfs4callback.c        |  28 +-
>> fs/nfsd/nfs4layouts.c         |  16 +-
>> fs/nfsd/nfs4proc.c            |  43 +-
>> fs/nfsd/nfs4state.c           | 100 ++--
>> fs/nfsd/nfsd.h                |   1 +
>> fs/nfsd/nfsfh.c               |  36 +-
>> fs/nfsd/nfsfh.h               |   7 +-
>> fs/nfsd/nfsproc.c             |  21 +
>> fs/nfsd/nfssvc.c              | 198 +++++---
>> fs/nfsd/trace.c               |   1 +
>> fs/nfsd/trace.h               | 844 =
++++++++++++++++++++++++++++++----
>> fs/nfsd/vfs.c                 |  18 +-
>> fs/nfsd/xdr4.h                |   3 +-
>> include/linux/nfs4.h          |   4 +
>> include/linux/sunrpc/svc.h    |   1 +
>> include/trace/events/fs.h     |  30 ++
>> include/trace/events/nfs.h    | 511 ++++++++++++++++++++
>> include/trace/events/sunrpc.h |  33 +-
>> include/uapi/linux/nfsacl.h   |   2 +
>> net/sunrpc/svc_xprt.c         |   4 +-
>> net/sunrpc/svcauth.c          |   5 +-
>> 30 files changed, 2187 insertions(+), 911 deletions(-)
>> create mode 100644 include/trace/events/nfs.h
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



