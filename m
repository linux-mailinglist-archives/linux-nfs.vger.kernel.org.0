Return-Path: <linux-nfs+bounces-6330-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0369709B5
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 22:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4448DB211FA
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 20:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F8417AE1D;
	Sun,  8 Sep 2024 20:26:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F30179204
	for <linux-nfs@vger.kernel.org>; Sun,  8 Sep 2024 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725827177; cv=none; b=f2BIUK/lM467tezMPdm6np7izE6DRN25UQWXaBY3Ftw6aW/tgjDDd2rVr1lGHcrAUJIo7IcsckjIRDWGEqLWjDXZWwGDW4Kkmi2J4luK6oIjzGi8tD+GFyyqFbfqQnlz7iGCe3VS7JG5jb9f60EKEDHoSPW5jBBT6uauWn1PH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725827177; c=relaxed/simple;
	bh=sRVdJsmKaxJWCGmzVM6Y7AGWnjzept4H4UQhjAJCzww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hmPYFc4lDNUP0f9v6dOaCu9sQi2Xe2OZ5EoRXhuG816NLpXqJ9F1T6TE93ZyuBhWcnw3KoimSNba+8SGQ/XO21H9R/Q1sWTxb75XCVTyT0DsCCRlYgfMDwWcd7dex6PfcHQfG79LIV8od0vohnXVtPhQBfs4vBUjh7v+SQwQf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-104-tt6BonG2PZGqiqmfEPaGSw-1; Sun, 08 Sep 2024 21:26:06 +0100
X-MC-Unique: tt6BonG2PZGqiqmfEPaGSw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 8 Sep
 2024 21:25:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 8 Sep 2024 21:25:15 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Scott Mayhew' <smayhew@redhat.com>, Li Lingfeng <lilingfeng3@huawei.com>
CC: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>, "okorniev@redhat.com"
	<okorniev@redhat.com>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"tom@talpey.com" <tom@talpey.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yukuai1@huaweicloud.com"
	<yukuai1@huaweicloud.com>, "houtao1@huawei.com" <houtao1@huawei.com>,
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>, "yangerkun@huawei.com"
	<yangerkun@huawei.com>, "lilingfeng@huaweicloud.com"
	<lilingfeng@huaweicloud.com>
Subject: RE: [PATCH] nfsd: return -EINVAL when namelen is 0
Thread-Topic: [PATCH] nfsd: return -EINVAL when namelen is 0
Thread-Index: AQHa/tltH5fpypZKDEqICq9omYVD5rJOXHzA
Date: Sun, 8 Sep 2024 20:25:15 +0000
Message-ID: <cccdc13066204448af7f0fd550f34586@AcuMS.aculab.com>
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
 <ZthzJiKF6TY0Nv32@aion>
In-Reply-To: <ZthzJiKF6TY0Nv32@aion>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Scott Mayhew=20
> Sent: 04 September 2024 15:48
>=20
> On Tue, 03 Sep 2024, Li Lingfeng wrote:
>=20
> > When we have a corrupted main.sqlite in /var/lib/nfs/nfsdcld/, it may
> > result in namelen being 0, which will cause memdup_user() to return
> > ZERO_SIZE_PTR.
> > When we access the name.data that has been assigned the value of
> > ZERO_SIZE_PTR in nfs4_client_to_reclaim(), null pointer dereference is
> > triggered.
> >
> > [ T1205] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [ T1205] BUG: KASAN: null-ptr-deref in nfs4_client_to_reclaim+0xe9/0x26=
0
> > [ T1205] Read of size 1 at addr 0000000000000010 by task nfsdcld/1205
> > [ T1205]
> > [ T1205] CPU: 11 PID: 1205 Comm: nfsdcld Not tainted 5.10.0-00003-g2c14=
23731b8d #406
> > [ T1205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-=
20190727_073836-buildvm-
> ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
> > [ T1205] Call Trace:
> > [ T1205]  dump_stack+0x9a/0xd0
> > [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205]  __kasan_report.cold+0x34/0x84
> > [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205]  kasan_report+0x3a/0x50
> > [ T1205]  nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205]  ? nfsd4_release_lockowner+0x410/0x410
> > [ T1205]  cld_pipe_downcall+0x5ca/0x760
> > [ T1205]  ? nfsd4_cld_tracking_exit+0x1d0/0x1d0
> > [ T1205]  ? down_write_killable_nested+0x170/0x170
> > [ T1205]  ? avc_policy_seqno+0x28/0x40
> > [ T1205]  ? selinux_file_permission+0x1b4/0x1e0
> > [ T1205]  rpc_pipe_write+0x84/0xb0
> > [ T1205]  vfs_write+0x143/0x520
> > [ T1205]  ksys_write+0xc9/0x170
> > [ T1205]  ? __ia32_sys_read+0x50/0x50
> > [ T1205]  ? ktime_get_coarse_real_ts64+0xfe/0x110
> > [ T1205]  ? ktime_get_coarse_real_ts64+0xa2/0x110
> > [ T1205]  do_syscall_64+0x33/0x40
> > [ T1205]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> > [ T1205] RIP: 0033:0x7fdbdb761bc7
> > [ T1205] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00=
 f3 0f 1e fa 64 8b 04 25 18
> 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 514
> > [ T1205] RSP: 002b:00007fff8c4b7248 EFLAGS: 00000246 ORIG_RAX: 00000000=
00000001
> > [ T1205] RAX: ffffffffffffffda RBX: 000000000000042b RCX: 00007fdbdb761=
bc7
> > [ T1205] RDX: 000000000000042b RSI: 00007fff8c4b75f0 RDI: 0000000000000=
008
> > [ T1205] RBP: 00007fdbdb761bb0 R08: 0000000000000000 R09: 0000000000000=
001
> > [ T1205] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000=
42b
> > [ T1205] R13: 0000000000000008 R14: 00007fff8c4b75f0 R15: 0000000000000=
000
> > [ T1205] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fix it by checking namelen.
> >
> > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > ---
> >  fs/nfsd/nfs4recover.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index 67d8673a9391..69a3a84e159e 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cld_ms=
g_v2 __user *cmsg,
> >  =09=09=09ci =3D &cmsg->cm_u.cm_clntinfo;
> >  =09=09=09if (get_user(namelen, &ci->cc_name.cn_len))
> >  =09=09=09=09return -EFAULT;
> > +=09=09=09if (!namelen) {
> > +=09=09=09=09dprintk("%s: namelen should not be zero", __func__);
> > +=09=09=09=09return -EINVAL;
> > +=09=09=09}
> >  =09=09=09name.data =3D memdup_user(&ci->cc_name.cn_id, namelen);

Don't you also want an upper bound sanity check?
(or is cn_len only 8 bit?)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


