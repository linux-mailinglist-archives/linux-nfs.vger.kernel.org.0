Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA54C1F1FED
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 21:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFHT3w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jun 2020 15:29:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60666 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgFHT3v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jun 2020 15:29:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058JMrKf159500;
        Mon, 8 Jun 2020 19:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=9fPWjqa0TY9+4ktlkCjuNl1JLIRWD7i/Y0JzbbbHTR4=;
 b=KYwZc1PhDsJ4fqb8Hqd2qstqhb6UJ+zAZlV9y2mzJaFWDXIHGEU7xxZlsW/XU+sYmNSg
 3hAtA+P6bx8x7P8yYHws+4gv6GA/uzqHQKfeBPMHA1TyaWiLFJ0hmFJFKUDfh/2c32ma
 TPlcl1TVb8TxLwpjBSDKkkE2vE378/w+/Md3Piu7cFs8DOtzK3fbkV/ZyOesLo0fbGeA
 oup7qYnJ42W1uiWXBrG3f58ULmezNdDtlfm4cRt9pOuok8Nn9Gv3k7kY4UmFk3LmEUCe
 nTcXhdbALt1bxC8kpHYo9SJXe26xJ/fuO6hiuntJDzvnO0DHT7sYcWnrCgfYl+LqKX5l gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31g33m0n2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 19:29:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058JNcRm066754;
        Mon, 8 Jun 2020 19:27:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31gn2vmtrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 19:27:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 058JRi3H000521;
        Mon, 8 Jun 2020 19:27:44 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 12:27:44 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: general protection fault, probably for non-canonical address in
 nfsd
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <15780697.tcFqIYE18H@xrated>
Date:   Mon, 8 Jun 2020 15:27:43 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <74D35C3C-1DF5-4418-99E1-563C9B28AD88@oracle.com>
References: <15780697.tcFqIYE18H@xrated>
To:     Hans-Peter Jansen <hpj@urpla.net>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080136
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 7, 2020, at 11:32 AM, Hans-Peter Jansen <hpj@urpla.net> wrote:
>=20
> Hi,
>=20
> after upgrading the kernel from 5.6.11 to 5.6.14, we suffer from =
regular=20
> crashes of nfsd here:
>=20
> 2020-06-07T01:32:43.600306+02:00 server rpc.mountd[2664]: =
authenticated mount request from 192.168.3.16:303 for /work (/work)
> 2020-06-07T01:32:43.602594+02:00 server rpc.mountd[2664]: =
authenticated mount request from 192.168.3.16:304 for /work/vmware =
(/work)
> 2020-06-07T01:32:43.602971+02:00 server rpc.mountd[2664]: =
authenticated mount request from 192.168.3.16:305 for /work/vSphere =
(/work)
> 2020-06-07T01:32:43.606276+02:00 server kernel: [51901.089211] general =
protection fault, probably for non-canonical address 0xb9159d506ba40000: =
0000 [#1] SMP PTI
> 2020-06-07T01:32:43.606284+02:00 server kernel: [51901.089226] CPU: 1 =
PID: 3190 Comm: nfsd Tainted: G           O      5.6.14-lp151.2-default =
#1 openSUSE Tumbleweed (unreleased)
> 2020-06-07T01:32:43.606286+02:00 server kernel: [51901.089234] =
Hardware name: System manufacturer System Product Name/P7F-E, BIOS 0906  =
  09/20/2010
> 2020-06-07T01:32:43.606287+02:00 server kernel: [51901.089247] RIP: =
0010:cgroup_sk_free+0x26/0x80
> 2020-06-07T01:32:43.606288+02:00 server kernel: [51901.089257] Code: =
00 00 00 00 66 66 66 66 90 53 48 8b 07 48 c7 c3 30 72 07 b6 a8 01 75 07 =
48 85 c0 48 0f 45 d8 48 8b 83 18 09 00 00 a8 03=20
> 75 1a <65> 48 ff 08 f6 43 7c 01 74 02 5b c3 48 8b 43 18 a8 03 75 26 65 =
48
> 2020-06-07T01:32:43.606290+02:00 server kernel: [51901.089276] RSP: =
0018:ffffb248c21e7e10 EFLAGS: 00010246
> 2020-06-07T01:32:43.606291+02:00 server kernel: [51901.089280] RAX: =
b91603a504000000 RBX: ffff99ab141a0000 RCX: 0000000000000021
> 2020-06-07T01:32:43.606292+02:00 server kernel: [51901.089284] RDX: =
ffffffffb6135ec4 RSI: 0000000000010080 RDI: ffff99a7159c1490
> 2020-06-07T01:32:43.606293+02:00 server kernel: [51901.089287] RBP: =
ffff99a7159c1200 R08: ffff99ab67a60c60 R09: 000000000002eb00
> 2020-06-07T01:32:43.606294+02:00 server kernel: [51901.089291] R10: =
ffffb248c0087dc0 R11: 00000000000000c6 R12: 0000000000000000
> 2020-06-07T01:32:43.606295+02:00 server kernel: [51901.089294] R13: =
0000000000000103 R14: ffff99aae4934238 R15: ffff99ab31902000
> 2020-06-07T01:32:43.606296+02:00 server kernel: [51901.089299] FS:  =
0000000000000000(0000) GS:ffff99ab67a40000(0000) knlGS:0000000000000000
> 2020-06-07T01:32:43.606297+02:00 server kernel: [51901.089303] CS:  =
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2020-06-07T01:32:43.606303+02:00 server kernel: [51901.089305] CR2: =
00000000008e0000 CR3: 00000004df60a000 CR4: 00000000000026e0
> 2020-06-07T01:32:43.606304+02:00 server kernel: [51901.089307] Call =
Trace:
> 2020-06-07T01:32:43.606305+02:00 server kernel: [51901.089315]  =
__sk_destruct+0x10d/0x1d0
> 2020-06-07T01:32:43.606306+02:00 server kernel: [51901.089319]  =
inet_release+0x34/0x60
> 2020-06-07T01:32:43.606307+02:00 server kernel: [51901.089325]  =
__sock_release+0x81/0xb0
> 2020-06-07T01:32:43.606308+02:00 server kernel: [51901.089358]  =
svc_sock_free+0x38/0x60 [sunrpc]
> 2020-06-07T01:32:43.606308+02:00 server kernel: [51901.089374]  =
svc_xprt_put+0x99/0xe0 [sunrpc]
> 2020-06-07T01:32:43.606310+02:00 server kernel: [51901.089389]  =
svc_recv+0x9c0/0xa40 [sunrpc]
> 2020-06-07T01:32:43.606310+02:00 server kernel: [51901.089410]  ? =
nfsd_destroy+0x60/0x60 [nfsd]
> 2020-06-07T01:32:43.606311+02:00 server kernel: [51901.089417]  =
nfsd+0xd1/0x150 [nfsd]
> 2020-06-07T01:32:43.606312+02:00 server kernel: [51901.089420]  =
kthread+0x10d/0x130
> 2020-06-07T01:32:43.606313+02:00 server kernel: [51901.089423]  ? =
kthread_park+0x90/0x90
> 2020-06-07T01:32:43.606314+02:00 server kernel: [51901.089426]  =
ret_from_fork+0x35/0x40
>=20
> A vSphere 5.5 host accesses this linux server with nfs v3 for backup
> purposes (a Veeam backup server want to store a new backup here).=20
>=20
> The kernel is tainted due to vboxdrv. The OS is openSUSE Leap 15.1,
> with the kernel and Virtualbox replaced with uptodate versions from=20
> proper rpm packages (built on that very vSphere host in a OBS server
> VM..).
>=20
> I used to be subscribed to this ML, but that subscription has been=20
> lost 04/09, thus I cannot reply properly to the general prot. fault
> thread, started 05/12 from syzbot with Bruce looking into it.
>=20
> It seems somewhat related.

Your backtrace doesn't look anything like the syzbot crashes Bruce
is looking at, and there are no fs/nfsd/ changes between v5.6.11 and
v5.6.14. His crashes appear to be related entirely to the order of
destruction of net namespaces and NFS server data structures --
nothing at the socket layer.

The net/sunrpc/ changes in that commit range have nothing to do with
socket allocation. However, this:

   [51901.089247] RIP: 0010:cgroup_sk_free+0x26/0x80

suggests something else. There is a cgroup/sk related change in that
commit range:

e2d928d5ee43 ("netprio_cgroup: Fix unlimited memory leak of v2 cgroups")

I'm not sure how to help you further, since you are not available to
test this theory for a few weeks. The best I can suggest for others is
to stick with v5.6.11-based kernels until someone with a reproducer
can bisect between .11 and .14 to confirm the theory.


> Interestingly, we're using a couple of NFS v4 mounts for subsets of
> home here, and mount /work and other shares from various=20
> Tumbleweed systems with NFS v4 here without any undesired effects.=20
>=20
> Since the kernel upgrade, every time, this Veeam thing triggers these=20=

> v3 mounts, the crash happens. I've disabled this backup target for now=20=

> until the problem is resolved, because it effectively prevents further=20=

> nfs accesses to this server, and blocks our desktops until the server=20=

> is rebooted.
>=20
> A cursory look into 5.6.{15,16} changelogs seems to imply, that this
> issue is still pending.=20
>=20
> Let me know, if I can provide any further info's.

--
Chuck Lever



