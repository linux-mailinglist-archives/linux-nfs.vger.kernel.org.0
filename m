Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF76278B05
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 16:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgIYOgr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 10:36:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41930 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgIYOgr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 10:36:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEXLAm053720;
        Fri, 25 Sep 2020 14:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Q6Nxsffpj1uwwGLBIn9A5M4v3mtPVHiOX5lyXL4WgIo=;
 b=nc6+IVAC5riaAu7ci5c4XX2Wupk+sY0Qd/WQEaGqEyVhaevGuoRhsq8Gd2KfVdMcTUHM
 DS3ms32J5MMytYi/UgWLD9txQugMe1IC7a2/1CvaCmLHEaDkaIE+Q1UkUCr19hP5lyWf
 g4Fi94UWVj+IgwF6SewGLuIiQXxSzyPIeyb3juCeY92Dg0Jymac6a6sGHD07cdwRG7qZ
 ayo/Ake51xI3eRzXZKUqLMD9yaY1i+4cr1vlIFCNI/QfiEKIXkrLij+WNHyvWiflTfb7
 NffBfH2+2Pse4NRQBz9MkfNA/KwPzaIOxFWMjbJvVZ1BtAFiE0t76JfeKL0Rjx3OCrtA Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33q5rgvcvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 14:36:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEZWYE162588;
        Fri, 25 Sep 2020 14:36:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33nux4hqhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 14:36:44 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08PEaiLQ018916;
        Fri, 25 Sep 2020 14:36:44 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 07:36:43 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2 00/27] NFSD operation monitoring tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200925143218.GD1096@fieldses.org>
Date:   Fri, 25 Sep 2020 10:36:42 -0400
Cc:     Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <23DF63F3-44AC-4DDE-AAB9-E178F4B68103@oracle.com>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
 <20200924213617.GA12407@fieldses.org>
 <945A7DE6-909D-4177-852F-F80EF7DFE6B3@oracle.com>
 <20200925143218.GD1096@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=830 phishscore=0 suspectscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=2 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=843 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250104
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2020, at 10:32 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Fri, Sep 25, 2020 at 09:59:51AM -0400, Chuck Lever wrote:
>> Thanks Bruce, for your time, attention, and comments!
>>=20
>>> On Sep 24, 2020, at 5:36 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Mon, Sep 21, 2020 at 02:10:49PM -0400, Chuck Lever wrote:
>>>> As I've been working on various server bugs, I've been adding
>>>> tracepoints that record NFS operation arguments. Here's an updated
>>>> snapshot of this work for your review and comment.
>>>>=20
>>>> The idea here is to provide a degree of NFS traffic observability
>>>> without needing network capture. Tracepoints are generally lighter-
>>>> weight than full network capture, allowing effective capture-time
>>>> data reduction:
>>>=20
>>> I do wonder when tracepoints seem to duplicate information you could =
get
>>> from network traces, so thanks for taking the time to explain this.  =
It
>>> makes sense to me.
>>>=20
>>> The patches look fine.  The only one I'm I'm on the fence about is =
the
>>> last with the split up of the dispatch functions.  I'll ask some
>>> questions there....
>>=20
>> To be clear to everyone, this series is still "preview". I expect
>> more churn in these patches, thus I don't consider the series ready
>> to be merged by any stretch.
>=20
> OK!
>=20
> One thing I was wondering about: how would you limit tracing to a =
single
> client, say if you wanted to see all DELEGRETURNs from a single =
client?
> I guess you'd probably turn on a tracepoint in the receive code, look
> for your client's IP address, then mask the task id to match later
> nfs-level tracepoints.  Is there enough information in those =
tracepoints
> (including network namespace) to uniquely identify a client?

Client IP address information is in the RPC layer trace data. The
DELEGRETURN trace record includes client ID. So maybe not as
straightforward as it could be.


> --b.
>=20
>>>> - One or a handful of these can be enabled at a time
>>>> - Each tracepoint records much less data per operation than capture
>>>> - Extra capture-time filtering can reduce data amount even further
>>>> - Some of these operations are infrequent enough that their
>>>> tracepoint could be enabled persistently without a significant
>>>> performance impact (for example, for security auditing)
>>>>=20
>>>> The topic branch has been updated as well:
>>>>=20
>>>> git://git.linux-nfs.org/projects/cel/cel-2.6.git =
nfsd-more-tracepoints
>>>>=20
>>>>=20
>>>> Changes since RFC:
>>>> * s/SPDK/SPDX and corrected the spelling of Christoph's surname
>>>> * Fixed a build error noticed by <lkp@intel.com>
>>>> * Introduced generic headers for VFS and NFS protocol display =
macros
>>>> * nfsd4_compoundstatus now displays NFS4ERR codes symbolically
>>>> * The svc_process tracepoint now displays the RPC procedure =
symbolically
>>>> * NFSD dispatcher now displays procedure names and status codes =
symbolically
>>>> * fh_verify tracepoint tentatively included; it adds a lot of =
noise, but perhaps not much value
>>>> * Cleaned up the remaining PROC() macros in the server code
>>>> * Removed trace_printk's that were introduced during the RFC series
>>>> * Removed redundant nfsd4_close tracepoint
>>>>=20
>>>> ---
>>>>=20
>>>> Chuck Lever (27):
>>>>     NFS: Move generic FS show macros to global header
>>>>     NFS: Move NFS protocol display macros to global header
>>>>     NFSD: Add SPDX header for fs/nfsd/trace.c
>>>>     SUNRPC: Move the svc_xdr_recvfrom() tracepoint
>>>>     SUNRPC: Add svc_xdr_authenticate tracepoint
>>>>     lockd: Replace PROC() macro with open code
>>>>     NFSACL: Replace PROC() macro with open code
>>>>     SUNRPC: Make trace_svc_process() display the RPC procedure =
symbolically
>>>>     NFSD: Clean up the show_nf_may macro
>>>>     NFSD: Remove extra "0x" in tracepoint format specifier
>>>>     NFSD: Constify @fh argument of knfsd_fh_hash()
>>>>     NFSD: Add tracepoint in nfsd_setattr()
>>>>     NFSD: Add tracepoint for nfsd_access()
>>>>     NFSD: nfsd_compound_status tracepoint should record XID
>>>>     NFSD: Add client ID lifetime tracepoints
>>>>     NFSD: Add tracepoints to report NFSv4 session state
>>>>     NFSD: Add a tracepoint to report the current filehandle
>>>>     NFSD: Add GETATTR tracepoint
>>>>     NFSD: Add tracepoint in nfsd4_stateid_preprocess()
>>>>     NFSD: Add tracepoint to report arguments to NFSv4 OPEN
>>>>     NFSD: Add a tracepoint for DELEGRETURN
>>>>     NFSD: Add a lookup tracepoint
>>>>     NFSD: Add lock and locku tracepoints
>>>>     NFSD: Add tracepoints to record the result of TEST_STATEID and =
FREE_STATEID
>>>>     NFSD: Rename nfsd_ tracepoints to nfsd4_
>>>>     NFSD: Add tracepoints in the NFS dispatcher
>>>>     NFSD: Replace dprintk callsites in fs/nfsd/nfsfh.c
>>>>=20
>>>>=20
>>>> fs/lockd/svc4proc.c           | 263 +++++++++--
>>>> fs/lockd/svcproc.c            | 265 +++++++++--
>>>> fs/nfs/callback_xdr.c         |   2 +
>>>> fs/nfs/nfs4trace.h            | 387 ++--------------
>>>> fs/nfs/nfstrace.h             | 113 +----
>>>> fs/nfs/pnfs.h                 |   4 -
>>>> fs/nfsd/nfs2acl.c             |  79 +++-
>>>> fs/nfsd/nfs3acl.c             |  54 ++-
>>>> fs/nfsd/nfs3proc.c            |  25 +
>>>> fs/nfsd/nfs4callback.c        |  28 +-
>>>> fs/nfsd/nfs4layouts.c         |  16 +-
>>>> fs/nfsd/nfs4proc.c            |  43 +-
>>>> fs/nfsd/nfs4state.c           | 100 ++--
>>>> fs/nfsd/nfsd.h                |   1 +
>>>> fs/nfsd/nfsfh.c               |  36 +-
>>>> fs/nfsd/nfsfh.h               |   7 +-
>>>> fs/nfsd/nfsproc.c             |  21 +
>>>> fs/nfsd/nfssvc.c              | 198 +++++---
>>>> fs/nfsd/trace.c               |   1 +
>>>> fs/nfsd/trace.h               | 844 =
++++++++++++++++++++++++++++++----
>>>> fs/nfsd/vfs.c                 |  18 +-
>>>> fs/nfsd/xdr4.h                |   3 +-
>>>> include/linux/nfs4.h          |   4 +
>>>> include/linux/sunrpc/svc.h    |   1 +
>>>> include/trace/events/fs.h     |  30 ++
>>>> include/trace/events/nfs.h    | 511 ++++++++++++++++++++
>>>> include/trace/events/sunrpc.h |  33 +-
>>>> include/uapi/linux/nfsacl.h   |   2 +
>>>> net/sunrpc/svc_xprt.c         |   4 +-
>>>> net/sunrpc/svcauth.c          |   5 +-
>>>> 30 files changed, 2187 insertions(+), 911 deletions(-)
>>>> create mode 100644 include/trace/events/nfs.h
>>>>=20
>>>> --
>>>> Chuck Lever
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



