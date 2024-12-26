Return-Path: <linux-nfs+bounces-8796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9549FCF1A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 00:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCBF1626A3
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Dec 2024 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727E1684B4;
	Thu, 26 Dec 2024 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FdJtVIDP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F6zLdIny";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FdJtVIDP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F6zLdIny"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF613D893;
	Thu, 26 Dec 2024 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735254927; cv=none; b=DfkTl5jqo+ZHmbqnXEqbXn9HN3TWfjaQKeJ9Ngt54f2Iw0Zv2SeUQheNXECjPuquiJFx426r8YLumSyEvM7sur9gFxZ7xlmFX24bA4Ffwvyf6G9Ao3r0bhIM0WzVi+S7RbYBx/N3JnULb7nrtAnJhnsPqbcjPCHFQ6aVmtdyX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735254927; c=relaxed/simple;
	bh=Vg67eyNzHcCGKRWjI65uIV6Vg/VMsjWn2LyaPMpbY5w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kTpodJ541sgVW6k/uS5oN5QbTNOY+64GKv56mFWaJxcYkSa+wdPDxbBX8Q6bFV+Yf6JYRq9fjgLtrl0hd9wk2b54TRrTVJcFMSjL6coggyb2n2xD+r6X2nIsPVuxZZtnC9C/J2eUTAPLvno3D0FE1yW21I4aPxUMhmj37LdgwI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FdJtVIDP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F6zLdIny; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FdJtVIDP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F6zLdIny; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BD61337B3;
	Thu, 26 Dec 2024 23:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735254923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssQ1HAGCvoPKQRFEfOf4wrDlDMGZ60HHjbt1BaV4xS4=;
	b=FdJtVIDPVRzdvecnJPJOOf2J1Oj26UOc20T0CiHuwvzYg5+BaoBizL1dbt91N1Yp3tAAR6
	FiKjyQT9aQy59079EerJHfP5Arp60A2XIQRlu/DNvV4OfKDOZJFcm5pUT3p8+0cfUyPKe0
	WNGFusaGS2HfrWkqG0H3PJshA6Cleok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735254923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssQ1HAGCvoPKQRFEfOf4wrDlDMGZ60HHjbt1BaV4xS4=;
	b=F6zLdInyJTJFsgdT1x6JJPDHN6gx9AhIGeoF4UdP+AqTY0la/Sx9DupDDwzua3zW7ag88G
	r7iKtVxoiiQQ+KDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735254923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssQ1HAGCvoPKQRFEfOf4wrDlDMGZ60HHjbt1BaV4xS4=;
	b=FdJtVIDPVRzdvecnJPJOOf2J1Oj26UOc20T0CiHuwvzYg5+BaoBizL1dbt91N1Yp3tAAR6
	FiKjyQT9aQy59079EerJHfP5Arp60A2XIQRlu/DNvV4OfKDOZJFcm5pUT3p8+0cfUyPKe0
	WNGFusaGS2HfrWkqG0H3PJshA6Cleok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735254923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssQ1HAGCvoPKQRFEfOf4wrDlDMGZ60HHjbt1BaV4xS4=;
	b=F6zLdInyJTJFsgdT1x6JJPDHN6gx9AhIGeoF4UdP+AqTY0la/Sx9DupDDwzua3zW7ag88G
	r7iKtVxoiiQQ+KDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5A5E1351A;
	Thu, 26 Dec 2024 23:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SNLnJYXjbWeKPgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 26 Dec 2024 23:15:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Yang Erkun" <yangerkun@huawei.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 yangerkun@huawei.com, yangerkun@huaweicloud.com, liumingrui@huawei.com
Subject: Re: [PATCH v2 4/4] nfsd: fix UAF when access ex_uuid or ex_stats
In-reply-to: <20241225065908.1547645-5-yangerkun@huawei.com>
References: <20241225065908.1547645-1-yangerkun@huawei.com>,
 <20241225065908.1547645-5-yangerkun@huawei.com>
Date: Fri, 27 Dec 2024 10:15:14 +1100
Message-id: <173525491450.11072.2429748630003567820@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 25 Dec 2024, Yang Erkun wrote:
> We can access exp->ex_stats or exp->ex_uuid in rcu context(c_show and
> e_show). All these resources should be released using kfree_rcu. Fix this
> by using call_rcu, clean them all after a rcu grace period.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in svc_export_show+0x362/0x430 [nfsd]
> Read of size 1 at addr ff11000010fdc120 by task cat/870
>=20
> CPU: 1 UID: 0 PID: 870 Comm: cat Not tainted 6.12.0-rc3+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x53/0x70
>  print_address_description.constprop.0+0x2c/0x3a0
>  print_report+0xb9/0x280
>  kasan_report+0xae/0xe0
>  svc_export_show+0x362/0x430 [nfsd]
>  c_show+0x161/0x390 [sunrpc]
>  seq_read_iter+0x589/0x770
>  seq_read+0x1e5/0x270
>  proc_reg_read+0xe1/0x140
>  vfs_read+0x125/0x530
>  ksys_read+0xc1/0x160
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> Allocated by task 830:
>  kasan_save_stack+0x20/0x40
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0x8f/0xa0
>  __kmalloc_node_track_caller_noprof+0x1bc/0x400
>  kmemdup_noprof+0x22/0x50
>  svc_export_parse+0x8a9/0xb80 [nfsd]
>  cache_do_downcall+0x71/0xa0 [sunrpc]
>  cache_write_procfs+0x8e/0xd0 [sunrpc]
>  proc_reg_write+0xe1/0x140
>  vfs_write+0x1a5/0x6d0
>  ksys_write+0xc1/0x160
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> Freed by task 868:
>  kasan_save_stack+0x20/0x40
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x37/0x50
>  kfree+0xf3/0x3e0
>  svc_export_put+0x87/0xb0 [nfsd]
>  cache_purge+0x17f/0x1f0 [sunrpc]
>  nfsd_destroy_serv+0x226/0x2d0 [nfsd]
>  nfsd_svc+0x125/0x1e0 [nfsd]
>  write_threads+0x16a/0x2a0 [nfsd]
>  nfsctl_transaction_write+0x74/0xa0 [nfsd]
>  vfs_write+0x1a5/0x6d0
>  ksys_write+0xc1/0x160
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> Fixes: ae74136b4bb6 ("SUNRPC: Allow cache lookups to use RCU protection rat=
her than the r/w spinlock")
> Reviewed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>  fs/nfsd/export.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index c6168bccfb6c..0363720280d4 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -355,16 +355,25 @@ static void export_stats_destroy(struct export_stats =
*stats)
>  					    EXP_STATS_COUNTERS_NUM);
>  }
> =20
> -static void svc_export_put(struct kref *ref)
> +static void svc_export_release(struct rcu_head *rcu_head)
>  {
> -	struct svc_export *exp =3D container_of(ref, struct svc_export, h.ref);
> -	path_put(&exp->ex_path);
> -	auth_domain_put(exp->ex_client);
> +	struct svc_export *exp =3D container_of(rcu_head, struct svc_export,
> +			ex_rcu);
> +
>  	nfsd4_fslocs_free(&exp->ex_fslocs);
>  	export_stats_destroy(exp->ex_stats);
>  	kfree(exp->ex_stats);
>  	kfree(exp->ex_uuid);
> -	kfree_rcu(exp, ex_rcu);
> +	kfree(exp);
> +}
> +
> +static void svc_export_put(struct kref *ref)
> +{
> +	struct svc_export *exp =3D container_of(ref, struct svc_export, h.ref);
> +
> +	path_put(&exp->ex_path);
> +	auth_domain_put(exp->ex_client);
> +	call_rcu(&exp->ex_rcu, svc_export_release);
>  }
> =20

I think that ip_map_put() needs to be fixed for the same reason that
svc_export_put() needed to be fixed.

ip_map_put() calls auth_domain_put() in ->im_client immediately, but
ip_map_show() accesses ->im_client.
So ip_map_put() needs to delay the auth_domain_put() using rcu.

These two fixes should really be *before* patch 3/4 as without these
fixes 3/4 introduces a bug.

Thanks,
NeilBrown

Thanks,=20

