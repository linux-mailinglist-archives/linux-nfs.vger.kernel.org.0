Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE0B1912B8
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2020 15:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgCXOS7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 10:18:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34126 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgCXOS7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Mar 2020 10:18:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OEDV1N143623;
        Tue, 24 Mar 2020 14:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=w10uA8lh5GRv0xqk889Rg5tDi4BRfrrlqfxHaf5SWw4=;
 b=JLMLpEBklXe3YjEwHP99JNv9CMSTtTSnE/dM8246SjmgaTxrObfCq6hGd59VvjyDA9Lz
 PPSbWY5X/JBjMUvLt8ykSEvdWHxFy4wuDv6AqIIpc3Bu9qa3b8/9vElqLCoXMBpHvasU
 /p+3jD78D6hSaTa9ggI3ku14rDyTLmsUgXSChl7HU2hMkr4VXbJAeFipThDy3Aay3sug
 WZvusHbwjHgBvhGlORWZwT4ZIhh2EmGKC5+QVei5T+w74sT1neYbDAm+/pF5EhCOORuS
 SeY6j5AMzpT4q8KDsENvjzE9W48rT7ab7UQzHVGBKpJhdJVC/cBECfCMhdcbwqv/va9A +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ywavm4hta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 14:18:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OEHbrB123466;
        Tue, 24 Mar 2020 14:18:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yxw6msras-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 14:18:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02OEIgqY028561;
        Tue, 24 Mar 2020 14:18:42 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Mar 2020 07:18:42 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: fix race between cache_clean and cache_purge
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
Date:   Tue, 24 Mar 2020 10:18:41 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <91F74983-D681-4CD3-92FF-8CDB8DB7CD8D@oracle.com>
References: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=2 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240076
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 24, 2020, at 5:49 AM, Yihao Wu <wuyihao@linux.alibaba.com> =
wrote:
>=20
> cache_purge should hold cache_list_lock as cache_clean does. Otherwise =
a cache
> can be cache_put twice, which leads to a use-after-free bug.
>=20
> To reproduce, run ltp. It happens rarely.  /opt/ltp/runltp run -f =
net.nfs
>=20
> [14454.137661] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [14454.138863] BUG: KASAN: use-after-free in cache_purge+0xce/0x160 =
[sunrpc]
> [14454.139822] Read of size 4 at addr ffff8883d484d560 by task =
nfsd/31993
> [14454.140746]
> [14454.140995] CPU: 1 PID: 31993 Comm: nfsd Kdump: loaded Not tainted =
4.19.91-0.229.git.87bac30.al7.x86_64.debug #1
> [14454.141002] Call Trace:
> [14454.141014]  dump_stack+0xaf/0xfb[14454.141027]  =
print_address_description+0x6a/0x2a0
> [14454.141037]  kasan_report+0x166/0x2b0[14454.141057]  ? =
cache_purge+0xce/0x160 [sunrpc]
> [14454.141079]  cache_purge+0xce/0x160 [sunrpc]
> [14454.141099]  nfsd_last_thread+0x267/0x270 [nfsd][14454.141109]  ? =
nfsd_last_thread+0x5/0x270 [nfsd]
> [14454.141130]  nfsd_destroy+0xcb/0x180 [nfsd]
> [14454.141140]  ? nfsd_destroy+0x5/0x180 [nfsd]
> [14454.141153]  nfsd+0x1e4/0x2b0 [nfsd]
> [14454.141163]  ? nfsd+0x5/0x2b0 [nfsd]
> [14454.141173]  kthread+0x114/0x150
> [14454.141183]  ? nfsd_destroy+0x180/0x180 [nfsd]
> [14454.141187]  ? kthread_park+0xb0/0xb0
> [14454.141197]  ret_from_fork+0x3a/0x50
> [14454.141224]
> [14454.141475] Allocated by task 20918:
> [14454.142011]  kmem_cache_alloc_trace+0x9f/0x2e0
> [14454.142027]  sunrpc_cache_lookup+0xca/0x2f0 [sunrpc]
> [14454.142037]  svc_export_parse+0x1e7/0x930 [nfsd]
> [14454.142051]  cache_do_downcall+0x5a/0x80 [sunrpc]
> [14454.142064]  cache_downcall+0x78/0x180 [sunrpc]
> [14454.142078]  cache_write_procfs+0x57/0x80 [sunrpc]
> [14454.142083]  proc_reg_write+0x90/0xd0
> [14454.142088]  vfs_write+0xc2/0x1c0
> [14454.142092]  ksys_write+0x4d/0xd0
> [14454.142098]  do_syscall_64+0x60/0x250
> [14454.142103]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [14454.142106]
> [14454.142344] Freed by task 19165:
> [14454.142804]  kfree+0x114/0x300
> [14454.142819]  cache_clean+0x2a4/0x2e0 [sunrpc]
> [14454.142833]  cache_flush+0x24/0x60 [sunrpc]
> [14454.142845]  write_flush.isra.19+0xbe/0x100 [sunrpc]
> [14454.142849]  proc_reg_write+0x90/0xd0
> [14454.142853]  vfs_write+0xc2/0x1c0
> [14454.142856]  ksys_write+0x4d/0xd0
> [14454.142860]  do_syscall_64+0x60/0x250
> [14454.142865]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [14454.142867]
> [14454.143095] The buggy address belongs to the object at =
ffff8883d484d540 which belongs to the cache kmalloc-256 of size 256
> [14454.144842] The buggy address is located 32 bytes inside of  =
256-byte region [ffff8883d484d540, ffff8883d484d640)
> [14454.146463] The buggy address belongs to the page:
> [14454.147155] page:ffffea000f521300 count:1 mapcount:0 =
mapping:ffff888107c02e00 index:0xffff8883d484da40 compound_map count: 0
> [14454.148712] flags: 0x17fffc00010200(slab|head)
> [14454.149356] raw: 0017fffc00010200 ffffea000f4baf00 0000000200000002 =
ffff888107c02e00
> [14454.150453] raw: ffff8883d484da40 0000000080190001 00000001ffffffff =
0000000000000000
> [14454.151557] page dumped because: kasan: bad access detected
> [14454.152364]
> [14454.152606] Memory state around the buggy address:
> [14454.153300]  ffff8883d484d400: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
> [14454.154319]  ffff8883d484d480: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
> [14454.155324] >ffff8883d484d500: fc fc fc fc fc fc fc fc fb fb fb fb =
fb fb fb fb
> [14454.156334]                                                        =
^
> [14454.157237]  ffff8883d484d580: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
> [14454.158262]  ffff8883d484d600: fb fb fb fb fb fb fb fb fc fc fc fc =
fc fc fc fc
> [14454.159282] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [14454.160224] Disabling lock debugging due to kernel taint
>=20
> Fixes: 471a930ad7d1(SUNRPC: Drop all entries from cache_detail when =
cache_purge())
> Cc: stable@vger.kernel.org #v4.11+

Yihao, I couldn't get this patch to apply to kernels before v5.0.

I don't think we need both a Fixes tag and a Cc: stable, because
stable maintainers will try to apply this patch to any kernel that
has 471a930, and ignore the failures.

So if I apply your fix, I'm going to drop the Cc: stable tag.


> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
> ---
> net/sunrpc/cache.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index bd843a81afa0..3e523eefc47f 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -524,9 +524,11 @@ void cache_purge(struct cache_detail *detail)
> 	struct hlist_node *tmp =3D NULL;
> 	int i =3D 0;
>=20
> +	spin_lock(&cache_list_lock);
> 	spin_lock(&detail->hash_lock);
> 	if (!detail->entries) {
> 		spin_unlock(&detail->hash_lock);
> +		spin_unlock(&cache_list_lock);
> 		return;
> 	}
>=20
> @@ -541,6 +543,7 @@ void cache_purge(struct cache_detail *detail)
> 		}
> 	}
> 	spin_unlock(&detail->hash_lock);
> +	spin_unlock(&cache_list_lock);
> }
> EXPORT_SYMBOL_GPL(cache_purge);
>=20
> --=20
> 2.20.1.2432.ga663e714
>=20

--
Chuck Lever



