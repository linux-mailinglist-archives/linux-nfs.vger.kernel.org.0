Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81A51DC1A3
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 23:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgETVy0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 17:54:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48288 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgETVyZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 May 2020 17:54:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KLpux9149930;
        Wed, 20 May 2020 21:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=woVXosAKyqdx6tSDTZHQ3wqU8phfpf5uBnb6I2SqBFE=;
 b=vv1FmPXWvONc4mtZomIRcmhHwhFNUbaPT0KF7S1J3Xf1Gbt7Fqy+MKbYQArai6arRax/
 hWeaxakE4kGtZXw2t/ujCd+3kFYhrhGxW6CL2A5ZhMBzLwP9g0dIfIDAnd7slmtKG0eV
 JPtOTrvbU7dmiAqq0JlVvMHoAfkwOMJ11OiVj4VBeEIdLjGKD7HAICAu+JhWALwKb8Aj
 6A4nZq/BoYYivAGV2kyRv+qtN8m1A+mG/hHaLUeTClPvfwnBX2Mxvb/UdKhc8XFLZvwj
 YGW8sWQ9CS6jfb0iUTzladuF6JdgevKQIjMpJfclFENgYEKSVYXOCokzpZoYIbNou+gz 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31501rc3fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 21:54:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KLrDTx073434;
        Wed, 20 May 2020 21:54:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 315021405g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 21:54:20 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KLsJUh011393;
        Wed, 20 May 2020 21:54:19 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 14:54:19 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: kernel oops in rdma in 5.7-rc5
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyFSmvHEi9tBz=fvXGcbNhNU4Ogfrff2JnTxHZD88369dA@mail.gmail.com>
Date:   Wed, 20 May 2020 17:54:18 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF17E460-454C-4481-9D62-3FA6CDC5AE4B@oracle.com>
References: <CAN-5tyH=QiviyLQcmzBJpcejNTyXUKPenu3-rUeHOLLut9fX2A@mail.gmail.com>
 <4A13A8B1-C8DC-434F-936E-627D38DFA86E@oracle.com>
 <CAN-5tyFSmvHEi9tBz=fvXGcbNhNU4Ogfrff2JnTxHZD88369dA@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200171
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 20, 2020, at 1:33 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Wed, May 20, 2020 at 11:29 AM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On May 20, 2020, at 11:19 AM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>=20
>>> Hi Chuck,
>>>=20
>>> I was running some tests on latest in Trond's origin/testing and got
>>> the following oops. Is this known?
>>=20
>> It is a known issue, but it's been difficult to reproduce. I think it
>> can happen when the server disconnects unexpectedly. I have some =
rather
>> fresh patches that might prevent this crash. But because it's so
>> intermittent it's not yet clear they are 100% effective. Thus I'd =
like
>> to let them marinate for a while longer.
>>=20
>> Do you encounter this crash frequently? If it's a true and royal pain
>> I can push what I have to a topic branch on linux-git.
>=20
> Disclaimer I haven't tested rdma on softroce (or hardware for that
> matter) in a long time so I'm not sure if it's a recent problem.
>=20
> If you are not ready to push out the patches, can I get a tar from you
> (again not sure I really need it)?

I pushed some patches into the cel-testing topic branch here:

   git://git.linux-nfs.org/projects/cel/cel-2.6.git

In particular, commit 6a1c1cda9728 ("xprtrdma: Prevent dereferencing
r_xprt->rx_ep after it is freed") is probably the one that addresses
the crasher. But without a 100% reproducer it's tough to say for sure.


> I'm not sure how easily it's reproduced. My first oops was when
> running "nfstest_io", ever since I couldn't even mount and the client
> oops-ed every time until I rebooted the server.
> The set up is linux-to-linux (soft roce) running: ./nfstest_io -d
> /mnt/data -v all -s 1583972683450 -n 10 -r 3600 -e --createlog
> --logdir /home/aglo/logs/lock-eagain
>=20
> After rebooting the system, i can mount, start another nfstest_io run
> and it's been running ok for 40mins now (before I hit it in less than
> 30mins).
>=20
> My server is currently somewhat dated 5.5-rc5.
>=20
>>> [ 2116.066790] CPU: 1 PID: 429 Comm: kworker/u256:3 Not tainted =
5.7.0-rc5 #16
>>> [ 2116.070852] Hardware name: VMware, Inc. VMware Virtual
>>> Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
>>> [ 2116.077145] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>> [ 2116.080990] RIP: 0010:ib_drain_rq+0x7/0x80 [ib_core]
>>> [ 2116.084088] Code: c6 48 c7 c7 c8 b1 cf c0 31 c0 c6 05 57 85 04 00
>>> 01 e8 0d c9 3c e4 0f 0b e9 00 ff ff ff 66 0f 1f 44 00 00 0f 1f 44 00
>>> 00 55 53 <48> 8b 07 48 89 fb 48 8b 40 30 48 85 c0 74 53 e8 85 34 f3 =
e4
>>> 48 8b
>>> [ 2116.094874] RSP: 0018:ffffae1bc07e7d80 EFLAGS: 00010292
>>> [ 2116.098270] RAX: ffff99006ffdb800 RBX: ffff99006fff2c00 RCX: =
0000000000000000
>>> [ 2116.102803] RDX: 0000000000000000 RSI: 0000000000000207 RDI: =
0000000000000000
>>> [ 2116.107521] RBP: ffff990071110800 R08: 0000000000000000 R09: =
ffff990031b10000
>>> [ 2116.111567] R10: 0000000000000000 R11: 000000000000477d R12: =
ffff99006ffdb800
>>> [ 2116.115771] R13: ffff99006fff2c00 R14: ffff990071110e40 R15: =
0000000000000001
>>> [ 2116.119860] FS:  0000000000000000(0000) GS:ffff99007be40000(0000)
>>> knlGS:0000000000000000
>>> [ 2116.124401] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ 2116.127864] CR2: 0000000000000000 CR3: 00000000788a2003 CR4: =
00000000001606e0
>>> [ 2116.131983] Call Trace:
>>> [ 2116.136671]  rpcrdma_xprt_disconnect+0x52/0x2b0 [rpcrdma]
>>> [ 2116.140171]  ? call_transmit+0xa0/0xa0 [sunrpc]
>>> [ 2116.142819]  xprt_rdma_close+0x17/0x80 [rpcrdma]
>>> [ 2116.145496]  xprt_connect+0x17b/0x1e0 [sunrpc]
>>> [ 2116.148116]  ? call_transmit+0xa0/0xa0 [sunrpc]
>>> [ 2116.150834]  __rpc_execute+0x80/0x430 [sunrpc]
>>> [ 2116.153994]  ? try_to_wake_up+0x62/0x5e0
>>> [ 2116.156374]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>> [ 2116.159099]  process_one_work+0x172/0x380
>>> [ 2116.161591]  worker_thread+0x49/0x3f0
>>> [ 2116.163707]  kthread+0xf8/0x130
>>> [ 2116.165512]  ? max_active_store+0x80/0x80
>>> [ 2116.167892]  ? kthread_bind+0x10/0x10
>>> [ 2116.170231]  ret_from_fork+0x35/0x40
>>> [ 2116.172468] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
>>> dns_resolver nfs lockd grace fscache ib_isert iscsi_target_mod =
ib_srpt
>>> target_core_mod rpcrdma ib_srp ib_iser scsi_transport_srp libiscsi
>>> ib_ipoib scsi_transport_iscsi rdma_rxe ib_umad ip6_udp_tunnel
>>> udp_tunnel rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs ib_core tcp_lp
>>> nls_utf8 isofs rfcomm fuse xt_CHECKSUM xt_MASQUERADE tun bridge stp
>>> llc ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT =
nf_reject_ipv6
>>> xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute =
ip6table_nat
>>> ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat
>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle
>>> iptable_security iptable_raw ebtable_filter ebtables ip6table_filter
>>> ip6_tables iptable_filter vsock_loopback
>>> vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock =
bnep
>>> sunrpc snd_seq_midi snd_seq_midi_event intel_rapl_msr
>>> intel_rapl_common crc32_pclmul snd_ens1371 snd_ac97_codec
>>> ghash_clmulni_intel ac97_bus snd_rawmidi snd_seq
>>> [ 2116.172559]  btusb btrtl btbcm btintel bluetooth snd_seq_device
>>> uvcvideo snd_pcm videobuf2_vmalloc videobuf2_memops aesni_intel
>>> videobuf2_v4l2 vmw_balloon videobuf2_common videodev crypto_simd
>>> cryptd glue_helper snd_timer snd vmw_vmci mc joydev pcspkr
>>> ecdh_generic ecc rfkill sg soundcore i2c_piix4 ip_tables xfs =
libcrc32c
>>> sd_mod t10_pi sr_mod crc_t10dif cdrom crct10dif_generic ata_generic
>>> pata_acpi crct10dif_pclmul crct10dif_common vmwgfx crc32c_intel
>>> drm_kms_helper serio_raw syscopyarea sysfillrect sysimgblt =
fb_sys_fops
>>> ttm e1000 ata_piix drm libata mptspi scsi_transport_spi mptscsih
>>> mptbase dm_mirror dm_region_hash dm_log dm_mod
>>> [ 2116.259736] CR2: 0000000000000000
>>> [ 2116.266264] ---[ end trace f10e2bf40bcc51ad ]---
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



