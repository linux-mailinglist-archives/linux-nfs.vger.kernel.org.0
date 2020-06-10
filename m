Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987021F58EC
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2020 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgFJQVd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jun 2020 12:21:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44948 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgFJQVc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Jun 2020 12:21:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AGCIbK174969;
        Wed, 10 Jun 2020 16:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=+kuzMvPWVsHsSgU1fb8l5WFeGAnXNUle51VEh1pjfBQ=;
 b=inmnFK0b0RHK3WkCdnp/fnaKpnng5al6u6bZkhNrKsZFULINDZ/Bkg44UD63Yv8xIC3i
 Q2h4fv5JnL3MfubdgLk6b7oHsdk4uIzbc+VIhREbwb5GikoK/bP1dC1v5NWo9coYB2xC
 pLxpSOEy7qfWFjOtOCKlXKD4I9/M1pwCIKLhC7/EAjf0hK2ziYUWxkXpyeZJ5vsWzbCe
 Gsr3tQL5Z7Z8Vd0xrRjO/UObv/AOLZwc0413zqZ2nQ7FJ/XbMClfOvMAx50lZKzaTWwM
 sctfdatMe8af5E+C8ujQ0g2SfbTF/jXnBx+urEY8a1cSnWi+NtJhj60ZlPW0rdbMdHpC xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31g2jrbc2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 16:21:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AGCRpJ167741;
        Wed, 10 Jun 2020 16:19:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31gn29dtae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 16:19:24 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05AGJLGd006101;
        Wed, 10 Jun 2020 16:19:21 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 09:19:20 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: NFSv4.0: client stuck looping on RENEW + NFSERR_STALE_CLIENTID
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0aee01d63d91$1f104300$5d30c900$@gmail.com>
Date:   Wed, 10 Jun 2020 12:19:20 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        James Pearson <jcpearson@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E441550-FCCF-492E-BACB-271A42D4A6C4@oracle.com>
References: <0aee01d63d91$1f104300$5d30c900$@gmail.com>
To:     Robert Milkowski <rmilkowski@gmail.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=2
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100123
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 8, 2020, at 8:34 AM, Robert Milkowski <rmilkowski@gmail.com> =
wrote:
>=20
> Hi,
>=20
> We see random nfsv4.0 Linux clients ending stuck on accessing an nfs =
server
> which was just failover. Specifically this happens with NetApps during =
ONTAP
> upgrades.
> An affected client has all i/o stuck against the specific nfs server, =
while
> accessing other nfs servers is fine. Rebooting the client fixes the =
issue.
>=20
>=20
> This weekend, it happened again and I managed to do some debugging.
>=20
> btw: I anonymized/changed some data below (hostnames, IP addresses, =
etc.)
>=20
> The affected client was sending RENEW operation against NetApp which =
was
> updated, getting NFS4ERR_STALE_CLIENTID in response, but then the =
client
> was not trying to recover (setclientid, etc.) instead it just sent =
another
> RENEW op, and that continued like this in a loop:
>=20
> [root@client root]# tshark -Y nfs host BADnfssrv1
> Running as user "root" and group "root". This could be dangerous.
> Capturing on 'eth0'
>  1 0.000000000 10.100.139.63 -> 10.200.0.10  NFS 230 V4 Call RENEW =
CID:
> 0xddb4
>  2 0.074544014  10.200.0.10 -> 10.100.139.63 NFS 182 V4 Reply (Call In =
1)
> RENEW Status: NFS4ERR_STALE_CLIENTID
>  5 5.087870527 10.100.139.63 -> 10.200.0.10  NFS 230 V4 Call RENEW =
CID:
> 0xddb4
>  6 5.162370462  10.200.0.10 -> 10.100.139.63 NFS 182 V4 Reply (Call In =
5)
> RENEW Status: NFS4ERR_STALE_CLIENTID
>  9 10.175844705 10.100.139.63 -> 10.200.0.10  NFS 230 V4 Call RENEW =
CID:
> 0xddb4
> 10 10.250376101  10.200.0.10 -> 10.100.139.63 NFS 182 V4 Reply (Call =
In 9)
> RENEW Status: NFS4ERR_STALE_CLIENTID
> 13 15.263984093 10.100.139.63 -> 10.200.0.10  NFS 230 V4 Call RENEW =
CID:
> 0xddb4
> 14 15.338614422  10.200.0.10 -> 10.100.139.63 NFS 182 V4 Reply (Call =
In 13)
> RENEW Status: NFS4ERR_STALE_CLIENTID
> ...
>=20
> Traffic to other nfs servers on the same client were working fine.
>=20
> There was a similar thread back in March reported here by James =
Pearson, see
> thread with subject "Stuck NFSv4 mounts of Isilon filer with repeated
> NFS4ERR_STALE_CLIENTID errors". I've managed to gather more data =
though, so
> hopefully this is going to be useful.
>=20
>=20
> This specific client is running:
>=20
> [root@client ~]$ cat /etc/redhat-release
> CentOS Linux release 7.3.1611 (Core)
>=20
> [root@client ~]$ uname -a
> Linux client.company.domain 3.10.0-693.11.6.el7.x86_64 #1 SMP Thu Jan =
4
> 01:06:37 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

Hi Robert-

The usual course of action for bugs in distributor kernels is to work
directly with the distributor. Upstream developers don't generally have
access to or expertise with those code bases. 7.3 is an older kernel,
and it's possible that upstream has addressed this issue and CentOS
has pulled that fix into a newer release.

The troubleshooting below is common to this class of bugs. To get to
the root cause, you will need to observe the very beginning of the
loop, to see what condition triggers it.


> Although we hit the issue before on more recent centos versions as =
well.
>=20
> All nfs filesystems are mounted as with vers=3D4.0,sec=3Dkrb5
>=20
>=20
> An example process hanging, in this case df (collected via sysrq/t):
>=20
>=20
> Jun  6 19:31:35 client kernel: [10658517.222819] df              D
> ffff8802173d1fa0     0 20131  19284 0x00000086
> Jun  6 19:31:35 client kernel: [10658517.222837] Call Trace:
> Jun  6 19:31:35 client kernel: [10658517.222868]  [<ffffffff816ab6d9>]
> schedule+0x29/0x70
> Jun  6 19:31:35 client kernel: [10658517.222879]  [<ffffffffc03367f8>]
> gss_cred_init+0x2b8/0x3f0 [auth_rpcgss]
> Jun  6 19:31:35 client kernel: [10658517.222885]  [<ffffffff810b34b0>] =
?
> wake_up_atomic_t+0x30/0x30
> Jun  6 19:31:35 client kernel: [10658517.222924]  [<ffffffffc02eebe9>]
> rpcauth_lookup_credcache+0x219/0x2b0 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.222989]  [<ffffffffc0334623>]
> gss_lookup_cred+0x13/0x20 [auth_rpcgss]
> Jun  6 19:31:35 client kernel: [10658517.223150]  [<ffffffffc02ee2db>]
> rpcauth_lookupcred+0x8b/0xd0 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.223232]  [<ffffffffc02ef0dd>]
> rpcauth_refreshcred+0x14d/0x1d0 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.223285]  [<ffffffffc02e299a>] =
?
> xprt_lock_and_alloc_slot+0x6a/0x80 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.223420]  [<ffffffffc02dddf0>] =
?
> call_bc_transmit+0x1b0/0x1b0 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.223558]  [<ffffffffc02dddf0>] =
?
> call_bc_transmit+0x1b0/0x1b0 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.223627]  [<ffffffffc02de320>] =
?
> call_retry_reserve+0x60/0x60 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.223721]  [<ffffffffc02de320>] =
?
> call_retry_reserve+0x60/0x60 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.223779]  [<ffffffffc02de35c>]
> call_refresh+0x3c/0x60 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.223821]  [<ffffffffc02ec017>]
> __rpc_execute+0x97/0x410 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.223827]  [<ffffffff810b3475>] =
?
> wake_up_bit+0x25/0x30
> Jun  6 19:31:35 client kernel: [10658517.223867]  [<ffffffffc02ed7b8>]
> rpc_execute+0x68/0xb0 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.223945]  [<ffffffffc02dd776>]
> rpc_run_task+0xf6/0x150 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.224029]  [<ffffffffc04d28c3>]
> nfs4_call_sync_sequence+0x63/0xa0 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.224181]  [<ffffffffc04d394c>]
> _nfs4_proc_getattr+0xcc/0xf0 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.224238]  [<ffffffffc04df8f2>]
> nfs4_proc_getattr+0x72/0xf0 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.224305]  [<ffffffffc049c43f>]
> __nfs_revalidate_inode+0xbf/0x310 [nfs]
> Jun  6 19:31:35 client kernel: [10658517.224350]  [<ffffffffc049ca55>]
> nfs_getattr+0x95/0x250 [nfs]
> Jun  6 19:31:35 client kernel: [10658517.224356]  [<ffffffff8120872f>] =
?
> cp_new_stat+0x14f/0x180
> Jun  6 19:31:35 client kernel: [10658517.224363]  [<ffffffff81208106>]
> vfs_getattr+0x46/0x80
> Jun  6 19:31:35 client kernel: [10658517.224369]  [<ffffffff81208235>]
> vfs_fstatat+0x75/0xc0
> Jun  6 19:31:35 client kernel: [10658517.224375]  [<ffffffff8120878e>]
> SYSC_newstat+0x2e/0x60
> Jun  6 19:31:35 client kernel: [10658517.224381]  [<ffffffff811212c6>] =
?
> __audit_syscall_exit+0x1e6/0x280
> Jun  6 19:31:35 client kernel: [10658517.224387]  [<ffffffff81208a6e>]
> SyS_newstat+0xe/0x10
> Jun  6 19:31:35 client kernel: [10658517.224393]  [<ffffffff816b89fd>]
> system_call_fastpath+0x16/0x1b
>=20
>=20
> Same stack for the process 90 minutes later:
>=20
>=20
> Jun  6 20:58:01 client kernel: [10663703.685238] df              D
> ffff8802173d1fa0     0 20131  19284 0x00000086
> Jun  6 20:58:01 client kernel: [10663703.685242] Call Trace:
> Jun  6 20:58:01 client kernel: [10663703.685247]  [<ffffffff816ab6d9>]
> schedule+0x29/0x70
> Jun  6 20:58:01 client kernel: [10663703.685257]  [<ffffffffc03367f8>]
> gss_cred_init+0x2b8/0x3f0 [auth_rpcgss]
> Jun  6 20:58:01 client kernel: [10663703.685262]  [<ffffffff810b34b0>] =
?
> wake_up_atomic_t+0x30/0x30
> Jun  6 20:58:01 client kernel: [10663703.685297]  [<ffffffffc02eebe9>]
> rpcauth_lookup_credcache+0x219/0x2b0 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.685391]  [<ffffffffc0334623>]
> gss_lookup_cred+0x13/0x20 [auth_rpcgss]
> Jun  6 20:58:01 client kernel: [10663703.685560]  [<ffffffffc02ee2db>]
> rpcauth_lookupcred+0x8b/0xd0 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.685597]  [<ffffffffc02ef0dd>]
> rpcauth_refreshcred+0x14d/0x1d0 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.685836]  [<ffffffffc02e299a>] =
?
> xprt_lock_and_alloc_slot+0x6a/0x80 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.685888]  [<ffffffffc02dddf0>] =
?
> call_bc_transmit+0x1b0/0x1b0 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.685997]  [<ffffffffc02dddf0>] =
?
> call_bc_transmit+0x1b0/0x1b0 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.686179]  [<ffffffffc02de320>] =
?
> call_retry_reserve+0x60/0x60 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.686227]  [<ffffffffc02de320>] =
?
> call_retry_reserve+0x60/0x60 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.686415]  [<ffffffffc02de35c>]
> call_refresh+0x3c/0x60 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.686514]  [<ffffffffc02ec017>]
> __rpc_execute+0x97/0x410 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.686519]  [<ffffffff810b3475>] =
?
> wake_up_bit+0x25/0x30
> Jun  6 20:58:01 client kernel: [10663703.686556]  [<ffffffffc02ed7b8>]
> rpc_execute+0x68/0xb0 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.686712]  [<ffffffffc02dd776>]
> rpc_run_task+0xf6/0x150 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.686852]  [<ffffffffc04d28c3>]
> nfs4_call_sync_sequence+0x63/0xa0 [nfsv4]
> Jun  6 20:58:01 client kernel: [10663703.686887]  [<ffffffffc04d394c>]
> _nfs4_proc_getattr+0xcc/0xf0 [nfsv4]
> Jun  6 20:58:01 client kernel: [10663703.687127]  [<ffffffffc04df8f2>]
> nfs4_proc_getattr+0x72/0xf0 [nfsv4]
> Jun  6 20:58:01 client kernel: [10663703.687153]  [<ffffffffc049c43f>]
> __nfs_revalidate_inode+0xbf/0x310 [nfs]
> Jun  6 20:58:01 client kernel: [10663703.687403]  [<ffffffffc049ca55>]
> nfs_getattr+0x95/0x250 [nfs]
> Jun  6 20:58:01 client kernel: [10663703.687409]  [<ffffffff8120872f>] =
?
> cp_new_stat+0x14f/0x180
> Jun  6 20:58:01 client kernel: [10663703.687414]  [<ffffffff81208106>]
> vfs_getattr+0x46/0x80
> Jun  6 20:58:01 client kernel: [10663703.687419]  [<ffffffff81208235>]
> vfs_fstatat+0x75/0xc0
> Jun  6 20:58:01 client kernel: [10663703.687425]  [<ffffffff8120878e>]
> SYSC_newstat+0x2e/0x60
> Jun  6 20:58:01 client kernel: [10663703.687430]  [<ffffffff811212c6>] =
?
> __audit_syscall_exit+0x1e6/0x280
> Jun  6 20:58:01 client kernel: [10663703.687436]  [<ffffffff81208a6e>]
> SyS_newstat+0xe/0x10
> Jun  6 20:58:01 client kernel: [10663703.687440]  [<ffffffff816b89fd>]
> system_call_fastpath+0x16/0x1b
>=20
>=20
>=20
>=20
>=20
> The client doesn't call nfs4_recovery_handle_error():
>=20
>=20
> [root@client root]# stap -e 'probe
> =
module("nfsv4").function("nfs4_recovery_handle_error"){print_backtrace()}'=

>=20
> I waited a couple of minutes - no output.
> Which is strange...
>=20
>=20
> The affected nfs server is BADnfssrv1 [10.100.139.63]
>=20
>=20
> [root@client root]# stap -e 'probe
> module("nfsv4").function("nfs4_renew_state") \
>                             { printf("%s %s least_time: %d =
secs_to_renew:
> %d server: %s\n", ctime(gettimeofday_s()), probefunc(),
> $clp->cl_lease_time/HZ(), (jiffies()-$clp->cl_last_renewal)/HZ(),
> kernel_string($clp->cl_hostname)) }'
>=20
>=20
> Sat Jun  6 14:03:07 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 20
> server: nfsserv1.company.domain
> Sat Jun  6 14:03:10 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 5826
> server: BADnfssrv1.company.domain
> Sat Jun  6 14:03:14 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 20
> server: nfsserv2.company.domain
> Sat Jun  6 14:03:15 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 5831
> server: BADnfssrv1.company.domain
> Sat Jun  6 14:03:20 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 20
> server: lovpesgfs1.company.domain
> Sat Jun  6 14:03:20 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 5836
> server: BADnfssrv1.company.domain
> Sat Jun  6 14:03:25 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 5841
> server: BADnfssrv1.company.domain
> Sat Jun  6 14:03:27 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 20
> server: nfsserv1.company.domain
> Sat Jun  6 14:03:31 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 5847
> server: BADnfssrv1.company.domain
> Sat Jun  6 14:03:34 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 20
> server: nfsserv2.company.domain
> Sat Jun  6 14:03:36 2020 nfs4_renew_state least_time: 30 =
secs_to_renew: 5852
> server: BADnfssrv1.company.domain
> ...
>=20
>=20
> Notice that the last time BADnfssrv1 renewed its lease was over 90 =
minutes
> ago. Other nfs servers are fine.
> The NetApp ONTAP upgrade (clustered) was executed about 90 minutes =
ago.
>=20
>=20
> [root@client root]# stap -e 'probe
> module("nfsv4").function("nfs4_proc_async_renew") \
>                             { printf("%s %s %d\n", =
ctime(gettimeofday_s()),
> kernel_string($clp->cl_hostname), $renew_flags) }'
> Sat Jun  6 14:13:05 2020 BADnfssrv1.company.domain 1
> Sat Jun  6 14:13:08 2020 nfsserv1.company.domain 1
> Sat Jun  6 14:13:11 2020 BADnfssrv1.company.domain 1
> ...
>=20
>=20
> The function nfs4_renew_done() in linux-3.10.0-693.11.6.el7 is:
>=20
> static void nfs4_renew_done(struct rpc_task *task, void *calldata)
> {
>        struct nfs4_renewdata *data =3D calldata;
>        struct nfs_client *clp =3D data->client;
>        unsigned long timestamp =3D data->timestamp;
>=20
>        trace_nfs4_renew_async(clp, task->tk_status);
>        switch (task->tk_status) {
>        case 0:
>                break;
>        case -NFS4ERR_LEASE_MOVED:
>                nfs4_schedule_lease_moved_recovery(clp);
>                break;
>        default:
>                /* Unless we're shutting down, schedule state recovery! =
*/
>                if (test_bit(NFS_CS_RENEWD, &clp->cl_res_state) =3D=3D =
0)
>                        return;
>                if (task->tk_status !=3D NFS4ERR_CB_PATH_DOWN) {
>                        nfs4_schedule_lease_recovery(clp);
>                        return;
>                }
>                nfs4_schedule_path_down_recovery(clp);
>        }
>        do_renew_lease(clp, timestamp);
> }
>=20
>=20
>=20
> [root@client root]# stap -e 'probe
> module("nfsv4").function("nfs4_renew_done") \
>                             {  clp=3D$data->client; printf("%s %s =
tk_status:
> %d\n", ctime(gettimeofday_s()), kernel_string(clp->cl_hostname),
> $task->tk_status) } \
>                             probe
> module("nfsv4").function("nfs4_schedule_lease_recovery") \
>                             { printf("%s =
nfs4_schedule_lease_recovery(): %s
> cl_state: %d\n", ctime(gettimeofday_s()), =
kernel_string($clp->cl_hostname),
> $clp->cl_state) }  \
>                             probe
> module("nfsv4").function("do_renew_lease")\
>                             { printf("%s do_renew_lease(): %s\n",
> ctime(gettimeofday_s()), kernel_string($clp->cl_hostname)) }'
>=20
> Sat Jun  6 14:42:06 2020 BADnfssrv1.company.domain tk_status: -10022
> Sat Jun  6 14:42:06 2020 nfs4_schedule_lease_recovery():
> BADnfssrv1.company.domain cl_state: 5
> Sat Jun  6 14:42:11 2020 nfsserv1.company.domain tk_status: 0
> Sat Jun  6 14:42:11 2020 do_renew_lease(): nfsserv1.company.domain
> Sat Jun  6 14:42:11 2020 BADnfssrv1.company.domain tk_status: -10022
> Sat Jun  6 14:42:11 2020 nfs4_schedule_lease_recovery():
> BADnfssrv1.company.domain cl_state: 5
> Sat Jun  6 14:42:16 2020 BADnfssrv1.company.domain tk_status: -10022
> Sat Jun  6 14:42:16 2020 nfs4_schedule_lease_recovery():
> BADnfssrv1.company.domain cl_state: 5
> Sat Jun  6 14:42:18 2020 nfsserv2.company.domain tk_status: 0
> Sat Jun  6 14:42:18 2020 do_renew_lease(): nfsserv2.company.domain
> Sat Jun  6 14:42:21 2020 BADnfssrv1.company.domain tk_status: -10022
> Sat Jun  6 14:42:21 2020 nfs4_schedule_lease_recovery():
> BADnfssrv1.company.domain cl_state: 5
> ^C
>=20
>=20
> The -10022 is NFS4ERR_STALE_CLIENTID as seen in network dump.
>=20
>=20
> The nfs4_schedule_lease_recovery() calls =
nfs4_schedule_state_manager():
>=20
>=20
> void nfs4_schedule_state_manager(struct nfs_client *clp)
> {
>        struct task_struct *task;
>        char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
>=20
>        if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) =
!=3D 0)
>                return;
> ...
>=20
>=20
> Where NFS4CLNT_MANAGER_RUNNING is bit 0, so given cl_state =3D=3D 5 =
the bit is
> set.
> Let's get stack for the 10.200.0.10-man(ager) kthread:
>=20
>=20
> [root@client root]# echo t >/proc/sysrq-trigger
> [root@client root]# less /var/log/messages
> ...
> Jun  6 19:31:35 client kernel: [10658517.225231] 10.200.0.10-man S
> ffff880229e7af70     0  5424      2 0x00000080
> Jun  6 19:31:35 client kernel: [10658517.225236] Call Trace:
> Jun  6 19:31:35 client kernel: [10658517.225277]  [<ffffffffc02dffb0>] =
?
> rpc_release_client+0x90/0xb0 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.225309]  [<ffffffff816ab6d9>]
> schedule+0x29/0x70
> Jun  6 19:31:35 client kernel: [10658517.225355]  [<ffffffff816a90e9>]
> schedule_timeout+0x239/0x2c0
> Jun  6 19:31:35 client kernel: [10658517.225386]  [<ffffffff811e0922>] =
?
> kmem_cache_free+0x1e2/0x200
> Jun  6 19:31:35 client kernel: [10658517.225437]  [<ffffffff81187177>] =
?
> mempool_free_slab+0x17/0x20
> Jun  6 19:31:35 client kernel: [10658517.225469]  [<ffffffff81187579>] =
?
> mempool_free+0x49/0x90
> Jun  6 19:31:35 client kernel: [10658517.225513]  [<ffffffff816ac441>]
> wait_for_completion_interruptible+0x131/0x1a0
> Jun  6 19:31:35 client kernel: [10658517.225543]  [<ffffffff810c6440>] =
?
> wake_up_state+0x20/0x20
> Jun  6 19:31:35 client kernel: [10658517.225590]  [<ffffffffc04f0a70>]
> nfs4_drain_slot_tbl+0x60/0x70 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.225650]  [<ffffffffc04f0a97>]
> nfs4_begin_drain_session.isra.11+0x17/0x40 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.225685]  [<ffffffffc04f137f>]
> nfs4_establish_lease+0x2f/0x80 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.225727]  [<ffffffffc04f2818>]
> nfs4_state_manager+0x1d8/0x8c0 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.225764]  [<ffffffffc04f2f00>] =
?
> nfs4_state_manager+0x8c0/0x8c0 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.225854]  [<ffffffffc04f2f1f>]
> nfs4_run_state_manager+0x1f/0x40 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.225912]  [<ffffffff810b252f>]
> kthread+0xcf/0xe0
> Jun  6 19:31:35 client kernel: [10658517.225976]  [<ffffffff810b2460>] =
?
> insert_kthread_work+0x40/0x40
> Jun  6 19:31:35 client kernel: [10658517.226000]  [<ffffffff816b8798>]
> ret_from_fork+0x58/0x90
> Jun  6 19:31:35 client kernel: [10658517.226045]  [<ffffffff810b2460>] =
?
> insert_kthread_work+0x40/0x40
>=20
> ...
>=20
>=20
> I sent the sysrq/t couple of minutes later and then again later and =
each
> time I get exactly same stack as above for the same pid (5424).
> Notice that the kthread name is server IP-man(ager) and the IP address
> matches the IP of the nfs server we are having issue with on this =
client.
>=20
>=20
> So if I'm reading it correctly what is happening is that client sends =
RENEW
> op, gets NFS4ERR_STALE_CLIENTID (-10022),
> schedules lease recovery which sets NFS4CLNT_CHECK_LEASE (in
> nfs4_schedule_lease_recovery() and tries to run
> nfs4_schedule_state_manager(),
> which ends up not doing anything as the kthread is already running and
> should deal with the NFS4CLNT_CHECK_LEASE bit set. However as the
> nfs4_state_manager() is stuck
> on draining slot it never processes the NFS4CLNT_CHECK_LEASE. This =
explains
> why network dump is showing the client looping on RENEW ops being =
send,
> getting the error and not recovering (not setting new client id, =
etc.). It
> also explains why other processes issuing any i/o to a file system =
served by
> the server are stuck.
>=20
>=20
> Given the stack, it is stuck here on =
wait_for_completion_interruptible()
> (also notice the rpc_release_client() at the top of the stack).
>=20
>=20
> static int nfs4_drain_slot_tbl(struct nfs4_slot_table *tbl)
> {
>        set_bit(NFS4_SLOT_TBL_DRAINING, &tbl->slot_tbl_state);
>        spin_lock(&tbl->slot_tbl_lock);
>        if (tbl->highest_used_slotid !=3D NFS4_NO_SLOT) {
>                INIT_COMPLETION(tbl->complete);
>                spin_unlock(&tbl->slot_tbl_lock);
>                return =
wait_for_completion_interruptible(&tbl->complete);
>        }
>        spin_unlock(&tbl->slot_tbl_lock);
>        return 0;
> }
>=20
>=20
>=20
> I run: kill -9  5424, which fixed the issue immediately.
> (as=20
>=20
> [root@client root]# tshark -Y nfs host BADnfssrv1
> Running as user "root" and group "root". This could be dangerous.
> Capturing on 'eth0'
>  2 19.842157633 10.100.139.63 -> 10.200.0.10  NFS 230 V4 Call RENEW =
CID:
> 0x6428
>  3 19.916744562  10.200.0.10 -> 10.100.139.63 NFS 182 V4 Reply (Call =
In 2)
> RENEW
>  6 39.874158462 10.100.139.63 -> 10.200.0.10  NFS 230 V4 Call RENEW =
CID:
> 0x6428
>  7 39.948760040  10.200.0.10 -> 10.100.139.63 NFS 182 V4 Reply (Call =
In 6)
> RENEW
> 10 59.906166646 10.100.139.63 -> 10.200.0.10  NFS 230 V4 Call RENEW =
CID:
> 0x6428
> 11 59.980762920  10.200.0.10 -> 10.100.139.63 NFS 182 V4 Reply (Call =
In 10)
> RENEW
> ...
>=20
>=20
> All stuck df processes, etc. resumed as well and new i/o is working =
fine
> against the file server.
>=20
> I wasn't sure if it didn't left something in undefined state though so
> scheduled the client reboot just in case, although it seemed to be =
working
> fine.
>=20
>=20
>=20
> There is another PID 26378 which I noticed in sysrq/t output, which =
might be
> the culprit here:
>=20
> Jun  6 19:31:35 client kernel: [10658517.214810] nfsv4.0-svc     S
> ffff880234b96eb0     0 26378      2 0x00000080
> Jun  6 19:31:35 client kernel: [10658517.214814] Call Trace:
> Jun  6 19:31:35 client kernel: [10658517.214820]  [<ffffffff8156afaf>] =
?
> sock_destroy_inode+0x2f/0x40
> Jun  6 19:31:35 client kernel: [10658517.214825]  [<ffffffff8121f5a8>] =
?
> destroy_inode+0x38/0x60
> Jun  6 19:31:35 client kernel: [10658517.214830]  [<ffffffff816ab6d9>]
> schedule+0x29/0x70
> Jun  6 19:31:35 client kernel: [10658517.214835]  [<ffffffff816a90e9>]
> schedule_timeout+0x239/0x2c0
> Jun  6 19:31:35 client kernel: [10658517.214880]  [<ffffffffc02ffd61>] =
?
> svc_xprt_free+0x71/0x90 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.214915]  [<ffffffffc03018d1>]
> svc_recv+0x971/0xb60 [sunrpc]
> Jun  6 19:31:35 client kernel: [10658517.214950]  [<ffffffffc04f7d40>] =
?
> nfs_callback_authenticate+0x60/0x60 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.214984]  [<ffffffffc04f7d40>] =
?
> nfs_callback_authenticate+0x60/0x60 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.215019]  [<ffffffffc04f7d73>]
> nfs4_callback_svc+0x33/0x60 [nfsv4]
> Jun  6 19:31:35 client kernel: [10658517.215024]  [<ffffffff810b252f>]
> kthread+0xcf/0xe0
> Jun  6 19:31:35 client kernel: [10658517.215030]  [<ffffffff810b2460>] =
?
> insert_kthread_work+0x40/0x40
> Jun  6 19:31:35 client kernel: [10658517.215035]  [<ffffffff816b8798>]
> ret_from_fork+0x58/0x90
> Jun  6 19:31:35 client kernel: [10658517.215041]  [<ffffffff810b2460>] =
?
> insert_kthread_work+0x40/0x40
>=20
>=20
> It is showing up, with the same stack, in every sysrq/t output =
collected,
> even almost 90 minutes later:
>=20
> Jun  6 20:58:01 client kernel: [10663703.676521] nfsv4.0-svc     S
> ffff880234b96eb0     0 26378      2 0x00000080
> Jun  6 20:58:01 client kernel: [10663703.676525] Call Trace:
> Jun  6 20:58:01 client kernel: [10663703.676531]  [<ffffffff8156afaf>] =
?
> sock_destroy_inode+0x2f/0x40
> Jun  6 20:58:01 client kernel: [10663703.676536]  [<ffffffff8121f5a8>] =
?
> destroy_inode+0x38/0x60
> Jun  6 20:58:01 client kernel: [10663703.676541]  [<ffffffff816ab6d9>]
> schedule+0x29/0x70
> Jun  6 20:58:01 client kernel: [10663703.676545]  [<ffffffff816a90e9>]
> schedule_timeout+0x239/0x2c0
> Jun  6 20:58:01 client kernel: [10663703.676550]  [<ffffffff811e0e03>] =
?
> kfree+0x103/0x140
> Jun  6 20:58:01 client kernel: [10663703.676595]  [<ffffffffc02ffd61>] =
?
> svc_xprt_free+0x71/0x90 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.676633]  [<ffffffffc03018d1>]
> svc_recv+0x971/0xb60 [sunrpc]
> Jun  6 20:58:01 client kernel: [10663703.676676]  [<ffffffffc04f7d40>] =
?
> nfs_callback_authenticate+0x60/0x60 [nfsv4]
> Jun  6 20:58:01 client kernel: [10663703.676709]  [<ffffffffc04f7d40>] =
?
> nfs_callback_authenticate+0x60/0x60 [nfsv4]
> Jun  6 20:58:01 client kernel: [10663703.676745]  [<ffffffffc04f7d73>]
> nfs4_callback_svc+0x33/0x60 [nfsv4]
> Jun  6 20:58:01 client kernel: [10663703.676750]  [<ffffffff810b252f>]
> kthread+0xcf/0xe0
> Jun  6 20:58:01 client kernel: [10663703.676756]  [<ffffffff810b2460>] =
?
> insert_kthread_work+0x40/0x40
> Jun  6 20:58:01 client kernel: [10663703.676761]  [<ffffffff816b8798>]
> ret_from_fork+0x58/0x90
> Jun  6 20:58:01 client kernel: [10663703.676766]  [<ffffffff810b2460>] =
?
> insert_kthread_work+0x40/0x40
>=20
>=20
>=20
>=20
> Looks like it is a deadlock which depends on timing during nfs server
> failovers.
>=20
> Hopefully the above will be useful for someone more familiar with the =
actual
> implementation.
> I'm happy to try to debug it more next time it happens - open to any =
ideas
> what to look for.
>=20
>=20
> I briefly went thru git changelog and maybe on of the below fixes =
might be
> addressing the issue.
>=20
>=20
> commit 6221f1d9b63fed6260273e59a2b89ab30537a811
> Author: Chuck Lever <chuck.lever@oracle.com>
> Date:   Fri Apr 17 12:40:31 2020 -0400
>=20
>    SUNRPC: Fix backchannel RPC soft lockups
> ...
>=20
> commit 67e7b52d44e3d539dfbfcd866c3d3d69da23a909
> Author: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date:   Wed Aug 7 07:31:27 2019 -0400
>=20
>    NFSv4: Ensure state recovery handles ETIMEDOUT correctly
>=20
> ...
>=20
> commit 76ee03540f316948c3bc89fc76ded86c88e887a5
> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
> Date:   Tue Jan 10 16:49:31 2017 -0500
>=20
>    NFS: Check if the slot table is draining from nfs4_setup_sequence()
> ...
>=20
>=20
> commit 6994cdd798568a0ddb8e0a85e2af24dbe655c341
> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
> Date:   Tue Jan 10 16:13:27 2017 -0500
>=20
>    NFS: Lock the slot table from a single place during setup sequence
>=20
>    Rather than implementing this twice for NFS v4.0 and v4.1
> ...
>=20
>=20
>=20
>=20
> --=20
> Robert Milkowski
>=20
>=20
>=20

--
Chuck Lever



