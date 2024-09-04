Return-Path: <linux-nfs+bounces-6189-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F045D96C124
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 16:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C19285FA7
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5A01DC07E;
	Wed,  4 Sep 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeD9II57"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C31DB53B
	for <linux-nfs@vger.kernel.org>; Wed,  4 Sep 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461300; cv=none; b=h8YfnFujbkmmoBWSvpycNbIzShPMrXD+myUr5sdZe37KD/l/aiNvQS5ssi92MUDD7xh2Tk0pN06p/xmIydyuCDClHyDteT8HqaoBZJDvgqVkHedLPtvJ64IOcBvCRfs+evxiHAftDV6J5s20PbHThgBiiQA1g1wXkWhoP6EWAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461300; c=relaxed/simple;
	bh=ASt9jbIyWwV6i2ebItQ5KaiCVPsSoXK4DeeVNfKUyyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGHzcAmDf/RxC2VLhquWmRL7T4j2DkXDmRu2xnU3ZbzUVYGSTPKD0dGFJJxdlPNidKxAb3hFfP33chbc9bGS9AdSHmIzxb33EaopfLwwlLV/vS6I/XavKm033AUT5JGxUkpUF+nVjSyZOlUiG+z0tSzJEMs5NFgl99Z46Lkmyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeD9II57; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725461297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKaab9EIatY62QXjXNrl4SWNK0XdrySiFqkXkhteJcY=;
	b=NeD9II57iYchlO6XDInR+7nQF752kpzecG8ZlP1w7tlNDAIBoHKAyNgzMzjtc2yL4Zpoo9
	1a2W7XIYG8cXPdmv441cjsKtdRijMR64d26Ldhta7nLi4WSk8r4Nnuq10ziNRkOP6T2/lx
	kJ0RRMcO74Gpi6GvTWSC0GJIUtvcI1I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-eRW0Mxt6Nse5P5JukIh5Fg-1; Wed,
 04 Sep 2024 10:48:12 -0400
X-MC-Unique: eRW0Mxt6Nse5P5JukIh5Fg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FC5B1955D57;
	Wed,  4 Sep 2024 14:48:09 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.9.161])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CEE3300019A;
	Wed,  4 Sep 2024 14:48:08 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 862FC1F14A4; Wed,  4 Sep 2024 10:48:06 -0400 (EDT)
Date: Wed, 4 Sep 2024 10:48:06 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: return -EINVAL when namelen is 0
Message-ID: <ZthzJiKF6TY0Nv32@aion>
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903111446.659884-1-lilingfeng3@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, 03 Sep 2024, Li Lingfeng wrote:

> When we have a corrupted main.sqlite in /var/lib/nfs/nfsdcld/, it may
> result in namelen being 0, which will cause memdup_user() to return
> ZERO_SIZE_PTR.
> When we access the name.data that has been assigned the value of
> ZERO_SIZE_PTR in nfs4_client_to_reclaim(), null pointer dereference is
> triggered.
> 
> [ T1205] ==================================================================
> [ T1205] BUG: KASAN: null-ptr-deref in nfs4_client_to_reclaim+0xe9/0x260
> [ T1205] Read of size 1 at addr 0000000000000010 by task nfsdcld/1205
> [ T1205]
> [ T1205] CPU: 11 PID: 1205 Comm: nfsdcld Not tainted 5.10.0-00003-g2c1423731b8d #406
> [ T1205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
> [ T1205] Call Trace:
> [ T1205]  dump_stack+0x9a/0xd0
> [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> [ T1205]  __kasan_report.cold+0x34/0x84
> [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> [ T1205]  kasan_report+0x3a/0x50
> [ T1205]  nfs4_client_to_reclaim+0xe9/0x260
> [ T1205]  ? nfsd4_release_lockowner+0x410/0x410
> [ T1205]  cld_pipe_downcall+0x5ca/0x760
> [ T1205]  ? nfsd4_cld_tracking_exit+0x1d0/0x1d0
> [ T1205]  ? down_write_killable_nested+0x170/0x170
> [ T1205]  ? avc_policy_seqno+0x28/0x40
> [ T1205]  ? selinux_file_permission+0x1b4/0x1e0
> [ T1205]  rpc_pipe_write+0x84/0xb0
> [ T1205]  vfs_write+0x143/0x520
> [ T1205]  ksys_write+0xc9/0x170
> [ T1205]  ? __ia32_sys_read+0x50/0x50
> [ T1205]  ? ktime_get_coarse_real_ts64+0xfe/0x110
> [ T1205]  ? ktime_get_coarse_real_ts64+0xa2/0x110
> [ T1205]  do_syscall_64+0x33/0x40
> [ T1205]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> [ T1205] RIP: 0033:0x7fdbdb761bc7
> [ T1205] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 514
> [ T1205] RSP: 002b:00007fff8c4b7248 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ T1205] RAX: ffffffffffffffda RBX: 000000000000042b RCX: 00007fdbdb761bc7
> [ T1205] RDX: 000000000000042b RSI: 00007fff8c4b75f0 RDI: 0000000000000008
> [ T1205] RBP: 00007fdbdb761bb0 R08: 0000000000000000 R09: 0000000000000001
> [ T1205] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000042b
> [ T1205] R13: 0000000000000008 R14: 00007fff8c4b75f0 R15: 0000000000000000
> [ T1205] ==================================================================
> 
> Fix it by checking namelen.
> 
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>  fs/nfsd/nfs4recover.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 67d8673a9391..69a3a84e159e 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>  			ci = &cmsg->cm_u.cm_clntinfo;
>  			if (get_user(namelen, &ci->cc_name.cn_len))
>  				return -EFAULT;
> +			if (!namelen) {
> +				dprintk("%s: namelen should not be zero", __func__);
> +				return -EINVAL;
> +			}
>  			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
>  			if (IS_ERR(name.data))
>  				return PTR_ERR(name.data);
> @@ -831,6 +835,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>  			cnm = &cmsg->cm_u.cm_name;
>  			if (get_user(namelen, &cnm->cn_len))
>  				return -EFAULT;
> +			if (!namelen) {
> +				dprintk("%s: namelen should not be zero", __func__);
> +				return -EINVAL;
> +			}
>  			name.data = memdup_user(&cnm->cn_id, namelen);
>  			if (IS_ERR(name.data))
>  				return PTR_ERR(name.data);
> -- 
> 2.31.1

Huh, so that would mean sqlite allows null in a primary key.  Any idea
how the corruption occurs in the first place?

Reviewed-and-tested-by: Scott Mayhew <smayhew@redhat.com>

-Scott
> 
> 


