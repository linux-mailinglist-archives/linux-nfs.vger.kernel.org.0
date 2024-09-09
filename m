Return-Path: <linux-nfs+bounces-6336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B609716BF
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 13:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A955283FCA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB31B5EA4;
	Mon,  9 Sep 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xk7R8wx8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596CF1B3740
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881065; cv=none; b=VnkBC2gvefJMI5PwbpijzKBuO+7We2PBmZ3zy7hs5GwyhkAtI0sWtCWcicaPqhyhZUUxI9Mp+wsETcqXQ3e+KAxdel5XL8wcduhUTraS5qlbgbGLb0Y1U+sTqU4SsfV8XwBYTtweeo+mpQvXOF2kptub4iiIIFOZO3n+XW/QgUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881065; c=relaxed/simple;
	bh=wd6Nk7S+2T3/Atm+VQX4FwDBMc4gtF4Iy1UQRcnPkmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZx5Ff5ks/K0pvt5aSY8Z0J/jXcTTBwkW1NDXVCr1ANogYfnClWcHMfh3u+KCEZcmSt4RgE0zVRUcOB6lqTPUXlpkUUrk07aBlwUzXo0MDY31HUu/GYH7b4XIMIiuLye3lureYGkDyoyq8x6rqnOYLSrp6BJje9PvQP2eIEUdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xk7R8wx8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725881062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G7iY+WqYMudiSPSlxZTFwaK/Tqzc2dsg6fefulIkGrE=;
	b=Xk7R8wx8XNbldrF+jwGD9192wrKfD5Epb10udQOk+CrMf9mEPXLnu+2TSk6i5orWdnPlIS
	ES0A7J+fGie/3fq6oTranVe4Eas1xRpuOgxEdRxMr3Q5YKhlnRDwaon7Q6yNxob5a1RsOv
	E2fDA0F4+B0EEWUD//T79sEqx2Vsw9c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-IMh2R6-RNMirn25-ihum-Q-1; Mon,
 09 Sep 2024 07:24:16 -0400
X-MC-Unique: IMh2R6-RNMirn25-ihum-Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF9961956088;
	Mon,  9 Sep 2024 11:24:13 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.160])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8124A1956086;
	Mon,  9 Sep 2024 11:24:11 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 7EB011F1B27; Mon,  9 Sep 2024 07:24:09 -0400 (EDT)
Date: Mon, 9 Sep 2024 07:24:09 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: David Laight <David.Laight@aculab.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"neilb@suse.de" <neilb@suse.de>,
	"okorniev@redhat.com" <okorniev@redhat.com>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"tom@talpey.com" <tom@talpey.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
	"houtao1@huawei.com" <houtao1@huawei.com>,
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>,
	"lilingfeng@huaweicloud.com" <lilingfeng@huaweicloud.com>
Subject: Re: [PATCH] nfsd: return -EINVAL when namelen is 0
Message-ID: <Zt7a2XO-ze1aAM-d@aion>
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
 <ZthzJiKF6TY0Nv32@aion>
 <cccdc13066204448af7f0fd550f34586@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cccdc13066204448af7f0fd550f34586@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Sun, 08 Sep 2024, David Laight wrote:

> From: Scott Mayhew 
> > Sent: 04 September 2024 15:48
> > 
> > On Tue, 03 Sep 2024, Li Lingfeng wrote:
> > 
> > > When we have a corrupted main.sqlite in /var/lib/nfs/nfsdcld/, it may
> > > result in namelen being 0, which will cause memdup_user() to return
> > > ZERO_SIZE_PTR.
> > > When we access the name.data that has been assigned the value of
> > > ZERO_SIZE_PTR in nfs4_client_to_reclaim(), null pointer dereference is
> > > triggered.
> > >
> > > [ T1205] ==================================================================
> > > [ T1205] BUG: KASAN: null-ptr-deref in nfs4_client_to_reclaim+0xe9/0x260
> > > [ T1205] Read of size 1 at addr 0000000000000010 by task nfsdcld/1205
> > > [ T1205]
> > > [ T1205] CPU: 11 PID: 1205 Comm: nfsdcld Not tainted 5.10.0-00003-g2c1423731b8d #406
> > > [ T1205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-
> > ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
> > > [ T1205] Call Trace:
> > > [ T1205]  dump_stack+0x9a/0xd0
> > > [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> > > [ T1205]  __kasan_report.cold+0x34/0x84
> > > [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> > > [ T1205]  kasan_report+0x3a/0x50
> > > [ T1205]  nfs4_client_to_reclaim+0xe9/0x260
> > > [ T1205]  ? nfsd4_release_lockowner+0x410/0x410
> > > [ T1205]  cld_pipe_downcall+0x5ca/0x760
> > > [ T1205]  ? nfsd4_cld_tracking_exit+0x1d0/0x1d0
> > > [ T1205]  ? down_write_killable_nested+0x170/0x170
> > > [ T1205]  ? avc_policy_seqno+0x28/0x40
> > > [ T1205]  ? selinux_file_permission+0x1b4/0x1e0
> > > [ T1205]  rpc_pipe_write+0x84/0xb0
> > > [ T1205]  vfs_write+0x143/0x520
> > > [ T1205]  ksys_write+0xc9/0x170
> > > [ T1205]  ? __ia32_sys_read+0x50/0x50
> > > [ T1205]  ? ktime_get_coarse_real_ts64+0xfe/0x110
> > > [ T1205]  ? ktime_get_coarse_real_ts64+0xa2/0x110
> > > [ T1205]  do_syscall_64+0x33/0x40
> > > [ T1205]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> > > [ T1205] RIP: 0033:0x7fdbdb761bc7
> > > [ T1205] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18
> > 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 514
> > > [ T1205] RSP: 002b:00007fff8c4b7248 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > > [ T1205] RAX: ffffffffffffffda RBX: 000000000000042b RCX: 00007fdbdb761bc7
> > > [ T1205] RDX: 000000000000042b RSI: 00007fff8c4b75f0 RDI: 0000000000000008
> > > [ T1205] RBP: 00007fdbdb761bb0 R08: 0000000000000000 R09: 0000000000000001
> > > [ T1205] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000042b
> > > [ T1205] R13: 0000000000000008 R14: 00007fff8c4b75f0 R15: 0000000000000000
> > > [ T1205] ==================================================================
> > >
> > > Fix it by checking namelen.
> > >
> > > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > > ---
> > >  fs/nfsd/nfs4recover.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > > index 67d8673a9391..69a3a84e159e 100644
> > > --- a/fs/nfsd/nfs4recover.c
> > > +++ b/fs/nfsd/nfs4recover.c
> > > @@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
> > >  			ci = &cmsg->cm_u.cm_clntinfo;
> > >  			if (get_user(namelen, &ci->cc_name.cn_len))
> > >  				return -EFAULT;
> > > +			if (!namelen) {
> > > +				dprintk("%s: namelen should not be zero", __func__);
> > > +				return -EINVAL;
> > > +			}
> > >  			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
> 
> Don't you also want an upper bound sanity check?
> (or is cn_len only 8 bit?)

Yeah, actually it should probably be checking for namelen >
NFS4_OPAQUE_LIMIT.

-Scott
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 


