Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF5B1F0CCE
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jun 2020 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgFGQKW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Jun 2020 12:10:22 -0400
Received: from chicago.messinet.com ([50.196.241.75]:43774 "EHLO
        chicago.messinet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgFGQKV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 7 Jun 2020 12:10:21 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jun 2020 12:10:21 EDT
Received: from localhost (localhost [127.0.0.1])
        by chicago.messinet.com (Postfix) with ESMTP id 83A77D257C;
        Sun,  7 Jun 2020 11:02:01 -0500 (CDT)
X-Virus-Scanned: amavisd-new at messinet.com
Received: from chicago.messinet.com ([127.0.0.1])
        by localhost (chicago.messinet.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id RV7ZdAYQQMGo; Sun,  7 Jun 2020 11:02:01 -0500 (CDT)
Received: from linux-ws1.messinet.com (linux-ws1.messinet.com [IPv6:2603:300a:134:50e0:85c6:1870:40ff:cc64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by chicago.messinet.com (Postfix) with ESMTPSA id 0B792D257B;
        Sun,  7 Jun 2020 11:02:01 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 chicago.messinet.com 0B792D257B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=messinet.com;
        s=20170806; t=1591545721;
        bh=T+BDAO3spfbr7xLWBCOQqEri/iR4yv/DuggsnNlFafU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OmIp0EOvNDvkskSuUXPL3W7wACoU3xGEUhmIjwkYdTb4WKHJljGC4VaE4dDOQ3+Uw
         DABO1lqkBch+iNx4hxjFw5r7X0RVEfB3W0X64A9t7stVdWErUz4Jpk4d1tnEYVdgoQ
         55XNqTD/tZmWRD7kEg9ONuVmy4KLDp4hfv672vkCfkd7sY/KqAtgxAxtRlw9ecbQl6
         3EbpXwhE3nf/dgkfmSwh4wHrMPQC/v8RXWbK5lecogIMuZkakfdk6ku4uv28ectey/
         tHv9SjcaucdalFvOtOZxojLexwRMzR+IriH4nroGC/tk675KNXGyrOJaBf8DZciEiM
         DVUVqATIiqA2w==
From:   Anthony Joseph Messina <amessina@messinet.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        Hans-Peter Jansen <hpj@urpla.net>
Subject: Re: general protection fault, probably for non-canonical address in nfsd
Date:   Sun, 07 Jun 2020 11:01:55 -0500
Message-ID: <11558085.O9o76ZdvQC@linux-ws1.messinet.com>
In-Reply-To: <15780697.tcFqIYE18H@xrated>
References: <15780697.tcFqIYE18H@xrated>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5383885.DvuYhMxLoT"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--nextPart5383885.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, June 7, 2020 10:32:44 AM CDT Hans-Peter Jansen wrote:
> Hi,
> 
> after upgrading the kernel from 5.6.11 to 5.6.14, we suffer from regular
> crashes of nfsd here:
> 
> 2020-06-07T01:32:43.600306+02:00 server rpc.mountd[2664]: authenticated
> mount request from 192.168.3.16:303 for /work (/work)
> 2020-06-07T01:32:43.602594+02:00 server rpc.mountd[2664]: authenticated
> mount request from 192.168.3.16:304 for /work/vmware (/work)
> 2020-06-07T01:32:43.602971+02:00 server rpc.mountd[2664]: authenticated
> mount request from 192.168.3.16:305 for /work/vSphere (/work)
> 2020-06-07T01:32:43.606276+02:00 server kernel: [51901.089211] general
> protection fault, probably for non-canonical address 0xb9159d506ba40000:
> 0000 [#1] SMP PTI 2020-06-07T01:32:43.606284+02:00 server kernel:
> [51901.089226] CPU: 1 PID: 3190 Comm: nfsd Tainted: G           O     
> 5.6.14-lp151.2-default #1 openSUSE Tumbleweed (unreleased)
> 2020-06-07T01:32:43.606286+02:00 server kernel: [51901.089234] Hardware
> name: System manufacturer System Product Name/P7F-E, BIOS 0906   
> 09/20/2010 2020-06-07T01:32:43.606287+02:00 server kernel: [51901.089247]
> RIP: 0010:cgroup_sk_free+0x26/0x80 2020-06-07T01:32:43.606288+02:00 server
> kernel: [51901.089257] Code: 00 00 00 00 66 66 66 66 90 53 48 8b 07 48 c7
> c3 30 72 07 b6 a8 01 75 07 48 85 c0 48 0f 45 d8 48 8b 83 18 09 00 00 a8 03
> 75 1a <65> 48 ff 08 f6 43 7c 01 74 02 5b c3 48 8b 43 18 a8 03 75 26 65 48
> 2020-06-07T01:32:43.606290+02:00 server kernel: [51901.089276] RSP:
> 0018:ffffb248c21e7e10 EFLAGS: 00010246 2020-06-07T01:32:43.606291+02:00
> server kernel: [51901.089280] RAX: b91603a504000000 RBX: ffff99ab141a0000
> RCX: 0000000000000021 2020-06-07T01:32:43.606292+02:00 server kernel:
> [51901.089284] RDX: ffffffffb6135ec4 RSI: 0000000000010080 RDI:
> ffff99a7159c1490 2020-06-07T01:32:43.606293+02:00 server kernel:
> [51901.089287] RBP: ffff99a7159c1200 R08: ffff99ab67a60c60 R09:
> 000000000002eb00 2020-06-07T01:32:43.606294+02:00 server kernel:
> [51901.089291] R10: ffffb248c0087dc0 R11: 00000000000000c6 R12:
> 0000000000000000 2020-06-07T01:32:43.606295+02:00 server kernel:
> [51901.089294] R13: 0000000000000103 R14: ffff99aae4934238 R15:
> ffff99ab31902000 2020-06-07T01:32:43.606296+02:00 server kernel:
> [51901.089299] FS:  0000000000000000(0000) GS:ffff99ab67a40000(0000)
> knlGS:0000000000000000 2020-06-07T01:32:43.606297+02:00 server kernel:
> [51901.089303] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2020-06-07T01:32:43.606303+02:00 server kernel: [51901.089305] CR2:
> 00000000008e0000 CR3: 00000004df60a000 CR4: 00000000000026e0
> 2020-06-07T01:32:43.606304+02:00 server kernel: [51901.089307] Call Trace:
> 2020-06-07T01:32:43.606305+02:00 server kernel: [51901.089315] 
> __sk_destruct+0x10d/0x1d0 2020-06-07T01:32:43.606306+02:00 server kernel:
> [51901.089319]  inet_release+0x34/0x60 2020-06-07T01:32:43.606307+02:00
> server kernel: [51901.089325]  __sock_release+0x81/0xb0
> 2020-06-07T01:32:43.606308+02:00 server kernel: [51901.089358] 
> svc_sock_free+0x38/0x60 [sunrpc] 2020-06-07T01:32:43.606308+02:00 server
> kernel: [51901.089374]  svc_xprt_put+0x99/0xe0 [sunrpc]
> 2020-06-07T01:32:43.606310+02:00 server kernel: [51901.089389] 
> svc_recv+0x9c0/0xa40 [sunrpc] 2020-06-07T01:32:43.606310+02:00 server
> kernel: [51901.089410]  ? nfsd_destroy+0x60/0x60 [nfsd]
> 2020-06-07T01:32:43.606311+02:00 server kernel: [51901.089417] 
> nfsd+0xd1/0x150 [nfsd] 2020-06-07T01:32:43.606312+02:00 server kernel:
> [51901.089420]  kthread+0x10d/0x130 2020-06-07T01:32:43.606313+02:00 server
> kernel: [51901.089423]  ? kthread_park+0x90/0x90
> 2020-06-07T01:32:43.606314+02:00 server kernel: [51901.089426] 
> ret_from_fork+0x35/0x40
> 
> A vSphere 5.5 host accesses this linux server with nfs v3 for backup
> purposes (a Veeam backup server want to store a new backup here).
> 
> The kernel is tainted due to vboxdrv. The OS is openSUSE Leap 15.1,
> with the kernel and Virtualbox replaced with uptodate versions from
> proper rpm packages (built on that very vSphere host in a OBS server
> VM..).
> 
> I used to be subscribed to this ML, but that subscription has been
> lost 04/09, thus I cannot reply properly to the general prot. fault
> thread, started 05/12 from syzbot with Bruce looking into it.
> 
> It seems somewhat related.
> 
> Interestingly, we're using a couple of NFS v4 mounts for subsets of
> home here, and mount /work and other shares from various
> Tumbleweed systems with NFS v4 here without any undesired effects.
> 
> Since the kernel upgrade, every time, this Veeam thing triggers these
> v3 mounts, the crash happens. I've disabled this backup target for now
> until the problem is resolved, because it effectively prevents further
> nfs accesses to this server, and blocks our desktops until the server
> is rebooted.
> 
> A cursory look into 5.6.{15,16} changelogs seems to imply, that this
> issue is still pending.
> 
> Let me know, if I can provide any further info's.
> 
> Thanks,
> Pete

I see similar issues in Fedora kernels 5.6.14 through 5.6.16
https://bugzilla.redhat.com/show_bug.cgi?id=1839287

On the client I mount /home with sec=krb5p, and /mnt/koji with sec=krb5

-- 
Anthony - https://messinet.com
F9B6 560E 68EA 037D 8C3D  D1C9 FF31 3BDB D9D8 99B6

--nextPart5383885.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE+bZWDmjqA32MPdHJ/zE729nYmbYFAl7dD3MACgkQ/zE729nY
mbYaShAAiOlYQ2Pg6TU+4U+V8IbstfMQix/m3SZGolaLfmLzjB1vNx+PT/Fv1Mwh
9aCZahxb8qbpyhCKzVR8tbsmsvwzw+qub8Al2daQrGtzZd0Qzr0uNTNXWP+xmcy4
VBn7/npilVc7fvL/LfXn8mzkigGsmnQ9v99CHoc8PFhAAWcH5BcznZRvCq7kJ7KT
GMzXduzHqBxkhTEbQ20zqkwYiTUHfaaGAtyJk3fap5IWdfFFF8fd0YDBI9sNVuSR
V/lS4JCYqR5VRDdTSqDh8bRw2eYd40jy8ytOmF+QQQT0L1f8Pdjkm9MXJ8ikHxwT
BbRBEPBAXxlqQ/a8sny/wE8SOq1nY2JIZG7sGn5DtM+WOjLYkYKn7AM8eq3RnkFF
T7wGOVcZAKKvk9qDGYA/spTSOCYZZzZIJsfXdPVXLK7Fy324mD05Q7V73ipACP5v
PnokbmR/BYjFHCbM6f0p78fyOSDzpGpesLTYsBOVrgSkgrqrPN6xd08uPnBLydhK
xpFGW2gUFa1rMuWlrPR3fQd89lyHMgClGPD8dyoNlepip8HFsBv1U66z5H5siTJW
N/jTC2iqy7bckil0FjJc+qsSHrBvcU3JaUTX4JHABDs3nEkyZmJDd6xShmJVtUPG
/A5iXv5/RdmkM3N4CbXjzMIo1Rl4Igg/kD2dnzI/3fbtsB2QGH0=
=IjVL
-----END PGP SIGNATURE-----

--nextPart5383885.DvuYhMxLoT--



