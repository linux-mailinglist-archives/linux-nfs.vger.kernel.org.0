Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE8819C56F
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2020 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbgDBPFU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 11:05:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52722 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbgDBPFU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Apr 2020 11:05:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032Edv6F125155;
        Thu, 2 Apr 2020 15:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=NJTKP2CCheKY0ZVhOg2a3MogjKX0FW168asyqoTU9gc=;
 b=cYKgtjUaLoISZYqGsMuadycI+A2xq+NOZd65azOZj0Kq94AW18b09YmMCg6Xh924S6D3
 3Izi0081GwHXZ2CrAOd4jxvcpTaZwqg1KpBc3Y4Vzxh7fUNogeNGfNe2WJVFH8+k1nXK
 a1mdT9Md1WUhUYUCGoKjNVZIntc8mLiHpEHH9ZM7y5+Q2gB59tFT5gYZkojLsQdQQGq8
 V5Tzio1jp6iWijez7AEkJf2FO2TXKSnpgQI1uK0sn61WiBpHrKkzi1nh0JKxCp85UomL
 T8FWoSiOlgaslDmzf0S3Q2bZTxs8GhgJ6zP09bFKlGjMlw80/C+FH2DDWujvN/UHkq++ Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 303cevc11h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 15:05:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032EcIX6072477;
        Thu, 2 Apr 2020 15:05:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 302ga2kd7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 15:05:14 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 032F5BUo019748;
        Thu, 2 Apr 2020 15:05:14 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 08:05:11 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC] sunrpc: Ensure signalled RPC tasks exit
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6d1e88145119587069a0077df8b31c9b80656d68.camel@hammerspace.com>
Date:   Thu, 2 Apr 2020 11:05:10 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6F2FDD0-FFC3-4874-9F5E-B232F36F3373@oracle.com>
References: <20200401193559.6487.55107.stgit@manet.1015granger.net>
 <6d1e88145119587069a0077df8b31c9b80656d68.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 1, 2020, at 5:55 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Wed, 2020-04-01 at 15:37 -0400, Chuck Lever wrote:
>> If an RPC task is signaled while it is running and the transport is
>> not connected, it will never sleep and never be terminated. This can
>> happen when a RPC transport is shut down: the remaining tasks are
>> signalled, but the transport is disconnected.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/sched.c |   14 ++++++--------
>> 1 file changed, 6 insertions(+), 8 deletions(-)
>>=20
>> Interested in comments and suggestions.
>>=20
>> Nearly every time my NFS/RDMA client unmounts when using krb5, the
>> umount hangs (killably). I tracked it down to an NFSv3 NULL request
>> that is signalled but loops and does not exit.
>>=20
>>=20
>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>> index 55e900255b0c..905c31f75593 100644
>> --- a/net/sunrpc/sched.c
>> +++ b/net/sunrpc/sched.c
>> @@ -905,6 +905,12 @@ static void __rpc_execute(struct rpc_task *task)
>> 		trace_rpc_task_run_action(task, do_action);
>> 		do_action(task);
>>=20
>> +		if (RPC_SIGNALLED(task)) {
>> +			task->tk_rpc_status =3D -ERESTARTSYS;
>> +			rpc_exit(task, -ERESTARTSYS);
>> +			break;
>> +		}
>> +
>=20
> Hmm... I'd really prefer to avoid this kind of check in the tight =
loop.

Certainly performance is a concern, but compared to the indirect
function call directly preceding this check, it is small potatoes.
Adding an "unlikely()" to the RPC_SIGNALLED() macro might help
mitigate the execution pipeline bubble it would cause.


> Why is this NULL request looping?

Here's an ftrace log I captured a couple of days ago.

      umount.nfs-7540  [004]   938.823064: rpc_task_begin:       =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT runstate=3DACTIVE status=3D0 =
action=3D(nil)s
   kworker/u25:0-6092  [000]   938.823073: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT runstate=3DRUNNING|ACTIVE =
status=3D0 action=3Dcall_start
   kworker/u25:0-6092  [000]   938.823075: rpc_request:          =
task:18647@1 nfsv3 NULL (async)
   kworker/u25:0-6092  [000]   938.823076: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT runstate=3DRUNNING|ACTIVE =
status=3D0 action=3Dcall_reserve
   kworker/u25:0-6092  [000]   938.823078: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT runstate=3DRUNNING|ACTIVE =
status=3D0 action=3Dcall_reserveresult
   kworker/u25:0-6092  [000]   938.823079: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT runstate=3DRUNNING|ACTIVE =
status=3D0 action=3Dcall_refresh
   kworker/u25:0-6092  [000]   938.823080: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT runstate=3DRUNNING|ACTIVE =
status=3D0 action=3Dcall_refreshresult
   kworker/u25:0-6092  [000]   938.823081: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT runstate=3DRUNNING|ACTIVE =
status=3D0 action=3Dcall_allocate
   kworker/u25:0-6092  [000]   938.823084: xprtrdma_op_allocate: =
task:18647@1 req=3D0xffff8884691ca000 (1624, 60)
   kworker/u25:0-6092  [000]   938.823085: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT runstate=3DRUNNING|ACTIVE =
status=3D0 action=3Dcall_encode
   kworker/u25:0-6092  [000]   938.823088: rpcgss_seqno:         =
task:18647@1 xid=3D0xfd7e5fb8 seqno=3D21981
   kworker/u25:0-6092  [000]   938.823117: xprt_enq_xmit:        =
task:18647@1 xid=3D0xfd7e5fb8 seqno=3D21981 stage=3D4
   kworker/u25:0-6092  [000]   938.823118: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 =
action=3Dcall_transmit
      umount.nfs-7540  [004]   938.823119: rpc_task_signalled:   =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 =
action=3Dcall_transmit_status
   kworker/u25:0-6092  [000]   938.823119: xprt_reserve_cong:    =
task:18647@1 snd_task:18647 cong=3D0 cwnd=3D16384
   kworker/u25:0-6092  [000]   938.823121: xprt_transmit:        =
task:18647@1 xid=3D0xfd7e5fb8 seqno=3D21981 status=3D-512
   kworker/u25:0-6092  [000]   938.823127: xprt_release_cong:    =
task:18647@1 snd_task:4294967295 cong=3D0 cwnd=3D16384
   kworker/u25:0-6092  [000]   938.823127: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D0 =
action=3Dcall_transmit_status
   kworker/u25:0-6092  [000]   938.823129: rpc_task_sleep:       =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D0 timeout=3D0 =
queue=3Dxprt_pending
   kworker/u25:0-6092  [000]   938.823132: rpc_task_wakeup:      =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|QUEUED|ACTIVE|NEED_RECV|SIGNALLED status=3D-107 =
timeout=3D60000 queue=3Dxprt_pending
   kworker/u25:0-6092  [000]   938.823133: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D-107 =
action=3Dxprt_timer
   kworker/u25:0-6092  [000]   938.823133: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D-107 =
action=3Dcall_status
   kworker/u25:0-6092  [000]   938.823136: rpc_call_status:      =
task:18647@1 status=3D-107
   kworker/u25:0-6092  [000]   938.823137: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D0 =
action=3Dcall_encode
   kworker/u25:0-6092  [000]   938.823138: rpcgss_seqno:         =
task:18647@1 xid=3D0xfd7e5fb8 seqno=3D21982
   kworker/u25:0-6092  [000]   938.823146: xprt_enq_xmit:        =
task:18647@1 xid=3D0xfd7e5fb8 seqno=3D21982 stage=3D4
   kworker/u25:0-6092  [000]   938.823147: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV|SIGNALLED status=3D0 =
action=3Dcall_transmit
   kworker/u25:0-6092  [000]   938.823147: xprt_reserve_cong:    =
task:18647@1 snd_task:18647 cong=3D0 cwnd=3D16384
   kworker/u25:0-6092  [000]   938.823148: xprt_transmit:        =
task:18647@1 xid=3D0xfd7e5fb8 seqno=3D21982 status=3D-512
   kworker/u25:0-6092  [000]   938.823149: xprt_release_cong:    =
task:18647@1 snd_task:4294967295 cong=3D0 cwnd=3D16384
   kworker/u25:0-6092  [000]   938.823149: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D0 =
action=3Dcall_transmit_status
   kworker/u25:0-6092  [000]   938.823150: rpc_task_sleep:       =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D0 timeout=3D0 =
queue=3Dxprt_pending
   kworker/u25:0-6092  [000]   938.823151: rpc_task_wakeup:      =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|QUEUED|ACTIVE|NEED_RECV|SIGNALLED status=3D-107 =
timeout=3D120000 queue=3Dxprt_pending
   kworker/u25:0-6092  [000]   938.823152: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D-107 =
action=3Dxprt_timer
   kworker/u25:0-6092  [000]   938.823152: rpc_task_run_action:  =
task:18647@1 flags=3DASYNC|DYNAMIC|SOFT =
runstate=3DRUNNING|ACTIVE|NEED_RECV|SIGNALLED status=3D-107 =
action=3Dcall_status
   kworker/u25:0-6092  [000]   938.823153: rpc_call_status:      =
task:18647@1 status=3D-107

And here, the looping continues.

My analysis is that the signal occurs while the task is running/active
in a section of code that continues to iterate on reconnecting without
checking for a signal. Note that the tail of xprt_transmit will not set
tk_status in this case, so it remains set to zero upon entry to
call_transmit_status.

I like the scheduler fix because I don't believe we can easily tell if
there might be other such critical sections in the client's state
machine where a loop might occur with no exit condition based on a
signal.

This fix closes the door on all such bugs.


--
Chuck Lever



