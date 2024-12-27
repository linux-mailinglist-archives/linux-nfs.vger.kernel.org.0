Return-Path: <linux-nfs+bounces-8801-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C889FD03B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 05:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67923A04B8
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 04:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0077BB1D;
	Fri, 27 Dec 2024 04:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N9PM/80V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tzfdd5SC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KsBUNgsX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s4bA7t6E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF6442F;
	Fri, 27 Dec 2024 04:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735274401; cv=none; b=FSEIz/WIG1RUfEP5fepHBNCVyZFElAbdUrrnrZMScTo47ZzNEzUmHXz6UMtYXENAGtw/ptmfmtvod9/UztfBzj3k8Pt3fDgpOlYVNwfcj5cct406cskm5r6QV+4+02OA+z5PNPvDyrKnOIkK+DlwvTQ40trltuGGWBXa6pdBPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735274401; c=relaxed/simple;
	bh=oXOC8w4LryNBWWZTFgZIBOy+Jd6ujNu1imLYi4l/Pio=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kgI/1VJGZu4E7PgOP0sfschvmXPuyg9F4U7dv9oAkdsYOTsORO7Gtjl/w6HYEqJ689uvHVj1qajX9gdnYV8+3GicAOdiWX1QoI+xPRHPTHsFFGBuf+Q2UoOkbujCbcY3toBzJOVPO3t4PCROHY1Qj6Erq7sY+BW8PjEmiEl3kzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N9PM/80V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tzfdd5SC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KsBUNgsX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s4bA7t6E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9FC135014;
	Fri, 27 Dec 2024 04:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735274396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btyJO4iJKTu2q6zHArKwx2WvQRD0da9qtbTG89osV6Y=;
	b=N9PM/80VLnU80fQkZ3+jdEZzvfAHjbzfSBaVYh0GMasF/mDiXbWvXJWDHL1TwbnBrhfclP
	gZCqjJ24+6S5IX+8dA0Z3vUUgefhxK0/4lYLFSCN7jk/KzEvwLBC4SoJJpsqrtUJTA5TcG
	MP1Z1C0vahcaKqm83d3sG66kRqoeL1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735274396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btyJO4iJKTu2q6zHArKwx2WvQRD0da9qtbTG89osV6Y=;
	b=Tzfdd5SC4IZZCQwJ/JhWYC33xVu1eijioW+tVReOXKR43yNsw5U8LCepQmoGinQGHteUJ5
	7qhy7/AkMCBLuRDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KsBUNgsX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s4bA7t6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735274395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btyJO4iJKTu2q6zHArKwx2WvQRD0da9qtbTG89osV6Y=;
	b=KsBUNgsX0lJOi+IVrQrR96z2Nrzva7I3QcIkq913iAeqdPFaTFASQMJJ8gpdCnksF+Sabk
	KWkxRIy+WOpadrBaodO25IWoDaMcjvcKp1eXTlLLHa2ozxWpADkenpXVcTT423aj0UbRCZ
	XcwLS3Z1OEel3YWG/90oM4378eAZy1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735274395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btyJO4iJKTu2q6zHArKwx2WvQRD0da9qtbTG89osV6Y=;
	b=s4bA7t6Ejhu4xJ1lL1ixCRk3WhqwDmfuPokfAtwlFoWBBAGI9FJ68QROcg8lrjr6PlRzXK
	8c94zJbOCM5nyJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50F4D13A30;
	Fri, 27 Dec 2024 04:39:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jH0BAZYvbmdRBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 27 Dec 2024 04:39:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "yangerkun" <yangerkun@huaweicloud.com>
Cc: "Yang Erkun" <yangerkun@huawei.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, liumingrui@huawei.com
Subject: Re: [PATCH v2 4/4] nfsd: fix UAF when access ex_uuid or ex_stats
In-reply-to: <3edb6771-9b61-2efc-1295-48d962af7acc@huaweicloud.com>
References: <>, <3edb6771-9b61-2efc-1295-48d962af7acc@huaweicloud.com>
Date: Fri, 27 Dec 2024 15:39:46 +1100
Message-id: <173527438676.22054.1191932613540665112@noble.neil.brown.name>
X-Rspamd-Queue-Id: C9FC135014
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 27 Dec 2024, yangerkun wrote:
>=20
> =E5=9C=A8 2024/12/27 7:15, NeilBrown =E5=86=99=E9=81=93:
> > On Wed, 25 Dec 2024, Yang Erkun wrote:
> >> We can access exp->ex_stats or exp->ex_uuid in rcu context(c_show and
> >> e_show). All these resources should be released using kfree_rcu. Fix this
> >> by using call_rcu, clean them all after a rcu grace period.
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> BUG: KASAN: slab-use-after-free in svc_export_show+0x362/0x430 [nfsd]
> >> Read of size 1 at addr ff11000010fdc120 by task cat/870
> >>
> >> CPU: 1 UID: 0 PID: 870 Comm: cat Not tainted 6.12.0-rc3+ #1
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >> 1.16.1-2.fc37 04/01/2014
> >> Call Trace:
> >>   <TASK>
> >>   dump_stack_lvl+0x53/0x70
> >>   print_address_description.constprop.0+0x2c/0x3a0
> >>   print_report+0xb9/0x280
> >>   kasan_report+0xae/0xe0
> >>   svc_export_show+0x362/0x430 [nfsd]
> >>   c_show+0x161/0x390 [sunrpc]
> >>   seq_read_iter+0x589/0x770
> >>   seq_read+0x1e5/0x270
> >>   proc_reg_read+0xe1/0x140
> >>   vfs_read+0x125/0x530
> >>   ksys_read+0xc1/0x160
> >>   do_syscall_64+0x5f/0x170
> >>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>
> >> Allocated by task 830:
> >>   kasan_save_stack+0x20/0x40
> >>   kasan_save_track+0x14/0x30
> >>   __kasan_kmalloc+0x8f/0xa0
> >>   __kmalloc_node_track_caller_noprof+0x1bc/0x400
> >>   kmemdup_noprof+0x22/0x50
> >>   svc_export_parse+0x8a9/0xb80 [nfsd]
> >>   cache_do_downcall+0x71/0xa0 [sunrpc]
> >>   cache_write_procfs+0x8e/0xd0 [sunrpc]
> >>   proc_reg_write+0xe1/0x140
> >>   vfs_write+0x1a5/0x6d0
> >>   ksys_write+0xc1/0x160
> >>   do_syscall_64+0x5f/0x170
> >>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>
> >> Freed by task 868:
> >>   kasan_save_stack+0x20/0x40
> >>   kasan_save_track+0x14/0x30
> >>   kasan_save_free_info+0x3b/0x60
> >>   __kasan_slab_free+0x37/0x50
> >>   kfree+0xf3/0x3e0
> >>   svc_export_put+0x87/0xb0 [nfsd]
> >>   cache_purge+0x17f/0x1f0 [sunrpc]
> >>   nfsd_destroy_serv+0x226/0x2d0 [nfsd]
> >>   nfsd_svc+0x125/0x1e0 [nfsd]
> >>   write_threads+0x16a/0x2a0 [nfsd]
> >>   nfsctl_transaction_write+0x74/0xa0 [nfsd]
> >>   vfs_write+0x1a5/0x6d0
> >>   ksys_write+0xc1/0x160
> >>   do_syscall_64+0x5f/0x170
> >>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>
> >> Fixes: ae74136b4bb6 ("SUNRPC: Allow cache lookups to use RCU protection =
rather than the r/w spinlock")
> >> Reviewed-by: NeilBrown <neilb@suse.de>
> >> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> >> ---
> >>   fs/nfsd/export.c | 19 ++++++++++++++-----
> >>   1 file changed, 14 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> >> index c6168bccfb6c..0363720280d4 100644
> >> --- a/fs/nfsd/export.c
> >> +++ b/fs/nfsd/export.c
> >> @@ -355,16 +355,25 @@ static void export_stats_destroy(struct export_sta=
ts *stats)
> >>   					    EXP_STATS_COUNTERS_NUM);
> >>   }
> >>  =20
> >> -static void svc_export_put(struct kref *ref)
> >> +static void svc_export_release(struct rcu_head *rcu_head)
> >>   {
> >> -	struct svc_export *exp =3D container_of(ref, struct svc_export, h.ref);
> >> -	path_put(&exp->ex_path);
> >> -	auth_domain_put(exp->ex_client);
> >> +	struct svc_export *exp =3D container_of(rcu_head, struct svc_export,
> >> +			ex_rcu);
> >> +
> >>   	nfsd4_fslocs_free(&exp->ex_fslocs);
> >>   	export_stats_destroy(exp->ex_stats);
> >>   	kfree(exp->ex_stats);
> >>   	kfree(exp->ex_uuid);
> >> -	kfree_rcu(exp, ex_rcu);
> >> +	kfree(exp);
> >> +}
> >> +
> >> +static void svc_export_put(struct kref *ref)
> >> +{
> >> +	struct svc_export *exp =3D container_of(ref, struct svc_export, h.ref);
> >> +
> >> +	path_put(&exp->ex_path);
> >> +	auth_domain_put(exp->ex_client);
> >> +	call_rcu(&exp->ex_rcu, svc_export_release);
> >>   }
> >>  =20
> >=20
> > I think that ip_map_put() needs to be fixed for the same reason that
> > svc_export_put() needed to be fixed.
> >=20
> > ip_map_put() calls auth_domain_put() in ->im_client immediately, but
> > ip_map_show() accesses ->im_client.
> > So ip_map_put() needs to delay the auth_domain_put() using rcu.
>=20
> Thanks for your detail review!
>=20
> auth_domain_put will eventually call auth_domain_release, which all
> .domain_release will call call_rcu to free auth_domain. Maybe it is safe
> now?

Yes, that makes sense.  As you say, no change is needed for
ip_map_put().

Thanks,
NeilBrown

