Return-Path: <linux-nfs+bounces-20676-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL1+KpHr02nInwcAu9opvQ
	(envelope-from <linux-nfs+bounces-20676-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 19:21:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 303533A5A47
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 19:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66A643017FB0
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 17:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0738E5D7;
	Mon,  6 Apr 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK92kGaK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2455321445
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496057; cv=none; b=GLvlUMAegbl+P5Pc+tfyOF/eAGI0TGn7BXmBTgpNF7rKp/MqNLeAQhCYUG5O6m5TBm77vTL+/YYoJbQv81Rl6MZkm+UQXRj/Q1MSkFfyjqXdKUeTWM7sCs5mmuoHq6pjRupQI3gucpq26cWcCdoE1MDcci1hCNAyy0zaId4HHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496057; c=relaxed/simple;
	bh=pD/BT8ZRj6IH0lMiu/aVMqWY/EwD7Xfhhmq0E0Vvn4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnE9GCpu3Tyxpl8RUYxoRVIJEN6JO3STHM6rAZDl0Gvm8rqO3BDwYg6KKBjZ+oYbIv39EiIuR4Yf9ZaCavOZv9zxYRRv4K/w8bEFHjVDF++XqZZKI9VLPydNlRcG5hz0W2evQcDfjpSqbf5KzJoZUGvz3uCPE8LTAh4i/Jypc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VK92kGaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775496054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwCDBIwSsjlzoh8dQF7WlgMJYQC3LaLPsqsfJ5Upoc4=;
	b=VK92kGaK4VTWm8TQoy9ohUMFX8Jr29bPBUvjYhP2l0hRboDYGy2z2zJuZRZgGMEeHPQo3D
	PsBc7ePIS9ZXBWfww8pB6cyFUYNHq11m34NoHe+i0nrHi3ZY785DYxtGAUZSIDRQ9YMikc
	qy8e552g1PSsIP3vZ14rijxRLAtk65E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-dSj05vtWNEa_8uPd1RiYyg-1; Mon,
 06 Apr 2026 13:20:51 -0400
X-MC-Unique: dSj05vtWNEa_8uPd1RiYyg-1
X-Mimecast-MFC-AGG-ID: dSj05vtWNEa_8uPd1RiYyg_1775496050
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2931195609E;
	Mon,  6 Apr 2026 17:20:49 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.134])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C1AD18001FE;
	Mon,  6 Apr 2026 17:20:49 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 51C2274BD6F; Mon, 06 Apr 2026 13:20:47 -0400 (EDT)
Date: Mon, 6 Apr 2026 13:20:47 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: fix file change detection in CB_GETATTR
Message-ID: <adPrbw7adrsXGWVq@aion>
References: <20260404005405.1565136-1-smayhew@redhat.com>
 <e03d3523-06e1-4414-b185-d349e7edbe54@app.fastmail.com>
 <adLellU5iadfbYdX@smayhew-thinkpadp1gen4i.remote.csb>
 <fb00b2d1-e7be-4567-a077-9ec26a938a5c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb00b2d1-e7be-4567-a077-9ec26a938a5c@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20676-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 303533A5A47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 06 Apr 2026, Chuck Lever wrote:

> 
> 
> On Sun, Apr 5, 2026, at 6:13 PM, Scott Mayhew wrote:
> > On Sat, 04 Apr 2026, Chuck Lever wrote:
> >> On Fri, Apr 3, 2026, at 8:54 PM, Scott Mayhew wrote:
> 
> >> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >> > index fa657badf5f8..53d8e7e7d60b 100644
> >> > --- a/fs/nfsd/nfs4state.c
> >> > +++ b/fs/nfsd/nfs4state.c
> >> 
> >> > @@ -9459,17 +9461,18 @@ static int cb_getattr_update_times(struct 
> >> > dentry *dentry, struct nfs4_delegation
> >> >   * caller must put the reference.
> >> >   */
> >> >  __be32
> >> > -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry 
> >> > *dentry,
> >> > -			     struct nfs4_delegation **pdp)
> >> > +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct path *path,
> >> > +			     struct kstat *stat, struct nfs4_delegation **pdp)
> >> 
> >> Passing the kstat struct in saves some stack just as I suggested,
> >> but it is an ugly API. The nfsd4_encode_fattr4() call stack is tall,
> >> though -- did you happen to measure how deep it gets after this patch
> >> is applied?
> >> 
> >
> > I tried using the stack tracer:
> >
> > # echo 1 >/proc/sys/kernel/stack_tracer_enabled
> > # echo vfs_getattr >/sys/kernel/debug/tracing/stack_trace_filter
> > # cat /sys/kernel/debug/tracing/stack_trace
> >         Depth    Size   Location    (18 entries)
> >         -----    ----   --------
> >   0)     1936      48   vfs_getattr+0x9/0x50
> >   1)     1888     552   nfsd4_encode_fattr4+0x1b2/0x7a0 [nfsd]
> >   2)     1336      80   nfsd4_encode_entry4_fattr+0xf8/0x210 [nfsd]
> >   3)     1256      96   nfsd4_encode_entry4+0x10b/0x2a0 [nfsd]
> >   4)     1160     144   nfsd_buffered_readdir+0x139/0x310 [nfsd]
> >   5)     1016      80   nfsd_readdir+0x9f/0x180 [nfsd]
> >   6)      936      80   nfsd4_encode_readdir+0xdf/0x1e0 [nfsd]
> >   7)      856      80   nfsd4_encode_operation+0xcf/0x3d0 [nfsd]
> >   8)      776      80   nfsd4_proc_compound+0x1d6/0x7a0 [nfsd]
> >   9)      696      80   nfsd_dispatch+0xd9/0x240 [nfsd]
> >  10)      616      80   svc_process_common+0x4cb/0x6b0 [sunrpc]
> >  11)      536      40   svc_process+0x150/0x240 [sunrpc]
> >  12)      496      72   svc_handle_xprt+0x4b0/0x5f0 [sunrpc]
> >  13)      424      56   svc_recv+0x1b2/0x3a0 [sunrpc]
> >  14)      368      80   nfsd+0x11c/0x3d0 [nfsd]
> >  15)      288      56   kthread+0xe3/0x120
> >  16)      232      40   ret_from_fork+0x1a1/0x270
> >  17)      192     192   ret_from_fork_asm+0x1a/0x30
> >
> > But that's capturing a vfs_getattr() call from encoding a readdir reply,
> > rather than the vfs_getattr() call I added to nfsd4_deleg_getattr_conflict().
> >
> > Here's the stack depth for nfsd4_deleg_getattr_conflict():
> >
> > # echo nfsd4_deleg_getattr_conflict 
> > >/sys/kernel/debug/tracing/stack_trace_filter
> > # echo 0 >/sys/kernel/debug/tracing/stack_max_size 
> > # cat /sys/kernel/debug/tracing/stack_trace
> >         Depth    Size   Location    (14 entries)
> >         -----    ----   --------
> >   0)     1472      48   nfsd4_deleg_getattr_conflict+0x9/0x410 [nfsd]
> >   1)     1424     552   nfsd4_encode_fattr4+0x191/0x7a0 [nfsd]
> >   2)      872      16   nfsd4_encode_getattr+0x2c/0x40 [nfsd]
> >   3)      856      80   nfsd4_encode_operation+0xcf/0x3d0 [nfsd]
> >   4)      776      80   nfsd4_proc_compound+0x1d6/0x7a0 [nfsd]
> >   5)      696      80   nfsd_dispatch+0xd9/0x240 [nfsd]
> >   6)      616      80   svc_process_common+0x4cb/0x6b0 [sunrpc]
> >   7)      536      40   svc_process+0x150/0x240 [sunrpc]
> >   8)      496      72   svc_handle_xprt+0x4b0/0x5f0 [sunrpc]
> >   9)      424      56   svc_recv+0x1b2/0x3a0 [sunrpc]
> >  10)      368      80   nfsd+0x11c/0x3d0 [nfsd]
> >  11)      288      56   kthread+0xe3/0x120
> >  12)      232      40   ret_from_fork+0x1a1/0x270
> >  13)      192     192   ret_from_fork_asm+0x1a/0x30
> >
> > Manually inspecting function graphs of vfs_getattr(), it looks like the deepest
> > function (that we can trace) is avc_lookup(), so here's a bpftrace script that
> > prints the stack depth from avc_lookup() via nfsd4_deleg_getattr_conflict()
> > (I mostly punted to Gemini for this):
> >
> > # cat peak-usage.bt 
> > kprobe:nfsd4_deleg_getattr_conflict {
> >     @in_deleg_conflict[tid] = 1;
> > }
> >
> > kprobe:avc_lookup /@in_deleg_conflict[tid]/ {
> >     $stack_size = (uint64)16384; 
> >     $sp = reg("sp");
> >     $stack_base = $sp & ~($stack_size - 1);
> >     $total_used = $stack_base + $stack_size - $sp;
> >
> >     if ($total_used > @max_depth_bytes) {
> >         @max_depth_bytes = $total_used;
> >         @deepest_stack = kstack;
> >     }
> > }
> >
> > kretprobe:nfsd4_deleg_getattr_conflict { delete(@in_deleg_conflict[tid]); }
> >
> > And finally the result:
> >
> > # bpftrace peak-usage.bt 
> > Attached 3 probes
> > ^C
> >
> > @deepest_stack: 
> >         avc_lookup+1
> >         avc_has_perm_noaudit+60
> >         avc_has_perm+89
> >         selinux_inode_getattr+203
> >         security_inode_getattr+70
> >         vfs_getattr+35
> >         nfsd4_deleg_getattr_conflict+958
> >         nfsd4_encode_fattr4+401
> >         nfsd4_encode_getattr+44
> >         nfsd4_encode_operation+207
> >         nfsd4_proc_compound+470
> >         nfsd_dispatch+217
> >         svc_process_common+1227
> >         svc_process+336
> >         svc_handle_xprt+1200
> >         svc_recv+434
> >         nfsd+284
> >         kthread+227
> >         ret_from_fork+417
> >         ret_from_fork_asm+26
> >
> > @max_depth_bytes: 1792
> 
> Since the new code only needs the file's size, perhaps you can get
> away with
> 
>         if (i_size_read(inode) != ncf->ncf_cb_fsize)
> 
> rather than
> 
>         err = vfs_getattr(path, stat, STATX_SIZE, AT_STATX_SYNC_AS_STAT);
>         if (err) {
>                 status = nfserrno(err);
>                 goto out_status;
>         }
>         if (stat->size != ncf->ncf_cb_fsize)

Definitely.  I'll send a v3 in a bit.
> 
> Then there's no longer a need for a struct kstat at all. The client is
> holding a delegation, so I would expect the file size to be stable.
> 
> 
> -- 
> Chuck Lever
> 


