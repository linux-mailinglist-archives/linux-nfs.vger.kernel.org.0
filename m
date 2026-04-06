Return-Path: <linux-nfs+bounces-20682-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI1xD1Uw1GmUsAcAu9opvQ
	(envelope-from <linux-nfs+bounces-20682-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 00:14:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 904543A7C5D
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 00:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DB9A30179EE
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 22:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9662339D6F9;
	Mon,  6 Apr 2026 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA5rl5mY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56C38BF69
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775513682; cv=none; b=k0POt2qRy4TpmrTwQDRyKq8ssNIZk6kjMWMlH9InpwgVjOnI8sW51bz7XTTk/9UmDHjua7imwBdP7e1++lmYa5l0CrEX2zHjgJlGIGocphNN+3VcxFeiKbGF82DOfBH0RjzRc7uRCxHlU8I4ziXYMYG3Ja+EebFvyvYQiLqt+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775513682; c=relaxed/simple;
	bh=7xVc2YAE9F0BjltJC6Km3DWSm5nJEssnCL8KGyAHElY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GskmnQYM/LOhc1ab+rPhjlG1zRhvw92Dl86u9kBMrUBDZv4qihkfN6q/U3ETZKJdM2mmfCkyNKMfUyiVpBfVyQkwBNWTWBQ68bteDSs0s1MeuhrWO9uR/YfMSTx97Er1xxsa0r8DkDsBX3tm1NQE3aVWjFAiFQZtAiGItCbFynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UA5rl5mY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775513679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plLzqsyg3QNTPPIDciYJvQUxljnExoHuiXLIsn+JAHQ=;
	b=UA5rl5mYFP1uOVgu/BlMGrmZCWJnpcrz+wM/ZmG3lm2Lj7et3JvcKkJsZJJ/XiHHlbbp72
	wC33PanZFIyMIb4R34w5Wt4issY2vGir6z+PabREXA2RncxKG8U7SY1byl2jyZeqwJC5Om
	aVqyiQLanwH9MRYgN86ZmzMaQ5f2goY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-gUI-W5zdP6mg3ayH3eXpig-1; Mon,
 06 Apr 2026 18:14:36 -0400
X-MC-Unique: gUI-W5zdP6mg3ayH3eXpig-1
X-Mimecast-MFC-AGG-ID: gUI-W5zdP6mg3ayH3eXpig_1775513675
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E5191800345;
	Mon,  6 Apr 2026 22:14:35 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.134])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91EFD180036E;
	Mon,  6 Apr 2026 22:14:34 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 5773A74BDD6; Mon, 06 Apr 2026 18:14:33 -0400 (EDT)
Date: Mon, 6 Apr 2026 18:14:33 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: fix file change detection in CB_GETATTR
Message-ID: <adQwSTW7ABXvrovQ@aion>
References: <20260404005405.1565136-1-smayhew@redhat.com>
 <e03d3523-06e1-4414-b185-d349e7edbe54@app.fastmail.com>
 <adLellU5iadfbYdX@smayhew-thinkpadp1gen4i.remote.csb>
 <fb00b2d1-e7be-4567-a077-9ec26a938a5c@app.fastmail.com>
 <e812ca8b2caaf2cafaf94b7b5be487346fe07285.camel@kernel.org>
 <adPxsOl98imcKXeC@aion>
 <ca6076eba9248c39f8b95bed66cec5d907aa0ab7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca6076eba9248c39f8b95bed66cec5d907aa0ab7.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20682-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 904543A7C5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 06 Apr 2026, Jeff Layton wrote:

> On Mon, 2026-04-06 at 13:47 -0400, Scott Mayhew wrote:
> > On Mon, 06 Apr 2026, Jeff Layton wrote:
> > 
> > > On Mon, 2026-04-06 at 10:12 -0400, Chuck Lever wrote:
> > > > 
> > > > On Sun, Apr 5, 2026, at 6:13 PM, Scott Mayhew wrote:
> > > > > On Sat, 04 Apr 2026, Chuck Lever wrote:
> > > > > > On Fri, Apr 3, 2026, at 8:54 PM, Scott Mayhew wrote:
> > > > 
> > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > index fa657badf5f8..53d8e7e7d60b 100644
> > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > 
> > > > > > > @@ -9459,17 +9461,18 @@ static int cb_getattr_update_times(struct 
> > > > > > > dentry *dentry, struct nfs4_delegation
> > > > > > >   * caller must put the reference.
> > > > > > >   */
> > > > > > >  __be32
> > > > > > > -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry 
> > > > > > > *dentry,
> > > > > > > -			     struct nfs4_delegation **pdp)
> > > > > > > +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct path *path,
> > > > > > > +			     struct kstat *stat, struct nfs4_delegation **pdp)
> > > > > > 
> > > > > > Passing the kstat struct in saves some stack just as I suggested,
> > > > > > but it is an ugly API. The nfsd4_encode_fattr4() call stack is tall,
> > > > > > though -- did you happen to measure how deep it gets after this patch
> > > > > > is applied?
> > > > > > 
> > > > > 
> > > > > I tried using the stack tracer:
> > > > > 
> > > > > # echo 1 >/proc/sys/kernel/stack_tracer_enabled
> > > > > # echo vfs_getattr >/sys/kernel/debug/tracing/stack_trace_filter
> > > > > # cat /sys/kernel/debug/tracing/stack_trace
> > > > >         Depth    Size   Location    (18 entries)
> > > > >         -----    ----   --------
> > > > >   0)     1936      48   vfs_getattr+0x9/0x50
> > > > >   1)     1888     552   nfsd4_encode_fattr4+0x1b2/0x7a0 [nfsd]
> > > > >   2)     1336      80   nfsd4_encode_entry4_fattr+0xf8/0x210 [nfsd]
> > > > >   3)     1256      96   nfsd4_encode_entry4+0x10b/0x2a0 [nfsd]
> > > > >   4)     1160     144   nfsd_buffered_readdir+0x139/0x310 [nfsd]
> > > > >   5)     1016      80   nfsd_readdir+0x9f/0x180 [nfsd]
> > > > >   6)      936      80   nfsd4_encode_readdir+0xdf/0x1e0 [nfsd]
> > > > >   7)      856      80   nfsd4_encode_operation+0xcf/0x3d0 [nfsd]
> > > > >   8)      776      80   nfsd4_proc_compound+0x1d6/0x7a0 [nfsd]
> > > > >   9)      696      80   nfsd_dispatch+0xd9/0x240 [nfsd]
> > > > >  10)      616      80   svc_process_common+0x4cb/0x6b0 [sunrpc]
> > > > >  11)      536      40   svc_process+0x150/0x240 [sunrpc]
> > > > >  12)      496      72   svc_handle_xprt+0x4b0/0x5f0 [sunrpc]
> > > > >  13)      424      56   svc_recv+0x1b2/0x3a0 [sunrpc]
> > > > >  14)      368      80   nfsd+0x11c/0x3d0 [nfsd]
> > > > >  15)      288      56   kthread+0xe3/0x120
> > > > >  16)      232      40   ret_from_fork+0x1a1/0x270
> > > > >  17)      192     192   ret_from_fork_asm+0x1a/0x30
> > > > > 
> > > > > But that's capturing a vfs_getattr() call from encoding a readdir reply,
> > > > > rather than the vfs_getattr() call I added to nfsd4_deleg_getattr_conflict().
> > > > > 
> > > > > Here's the stack depth for nfsd4_deleg_getattr_conflict():
> > > > > 
> > > > > # echo nfsd4_deleg_getattr_conflict 
> > > > > > /sys/kernel/debug/tracing/stack_trace_filter
> > > > > # echo 0 >/sys/kernel/debug/tracing/stack_max_size 
> > > > > # cat /sys/kernel/debug/tracing/stack_trace
> > > > >         Depth    Size   Location    (14 entries)
> > > > >         -----    ----   --------
> > > > >   0)     1472      48   nfsd4_deleg_getattr_conflict+0x9/0x410 [nfsd]
> > > > >   1)     1424     552   nfsd4_encode_fattr4+0x191/0x7a0 [nfsd]
> > > > >   2)      872      16   nfsd4_encode_getattr+0x2c/0x40 [nfsd]
> > > > >   3)      856      80   nfsd4_encode_operation+0xcf/0x3d0 [nfsd]
> > > > >   4)      776      80   nfsd4_proc_compound+0x1d6/0x7a0 [nfsd]
> > > > >   5)      696      80   nfsd_dispatch+0xd9/0x240 [nfsd]
> > > > >   6)      616      80   svc_process_common+0x4cb/0x6b0 [sunrpc]
> > > > >   7)      536      40   svc_process+0x150/0x240 [sunrpc]
> > > > >   8)      496      72   svc_handle_xprt+0x4b0/0x5f0 [sunrpc]
> > > > >   9)      424      56   svc_recv+0x1b2/0x3a0 [sunrpc]
> > > > >  10)      368      80   nfsd+0x11c/0x3d0 [nfsd]
> > > > >  11)      288      56   kthread+0xe3/0x120
> > > > >  12)      232      40   ret_from_fork+0x1a1/0x270
> > > > >  13)      192     192   ret_from_fork_asm+0x1a/0x30
> > > > > 
> > > > > Manually inspecting function graphs of vfs_getattr(), it looks like the deepest
> > > > > function (that we can trace) is avc_lookup(), so here's a bpftrace script that
> > > > > prints the stack depth from avc_lookup() via nfsd4_deleg_getattr_conflict()
> > > > > (I mostly punted to Gemini for this):
> > > > > 
> > > > > # cat peak-usage.bt 
> > > > > kprobe:nfsd4_deleg_getattr_conflict {
> > > > >     @in_deleg_conflict[tid] = 1;
> > > > > }
> > > > > 
> > > > > kprobe:avc_lookup /@in_deleg_conflict[tid]/ {
> > > > >     $stack_size = (uint64)16384; 
> > > > >     $sp = reg("sp");
> > > > >     $stack_base = $sp & ~($stack_size - 1);
> > > > >     $total_used = $stack_base + $stack_size - $sp;
> > > > > 
> > > > >     if ($total_used > @max_depth_bytes) {
> > > > >         @max_depth_bytes = $total_used;
> > > > >         @deepest_stack = kstack;
> > > > >     }
> > > > > }
> > > > > 
> > > > > kretprobe:nfsd4_deleg_getattr_conflict { delete(@in_deleg_conflict[tid]); }
> > > > > 
> > > > > And finally the result:
> > > > > 
> > > > > # bpftrace peak-usage.bt 
> > > > > Attached 3 probes
> > > > > ^C
> > > > > 
> > > > > @deepest_stack: 
> > > > >         avc_lookup+1
> > > > >         avc_has_perm_noaudit+60
> > > > >         avc_has_perm+89
> > > > >         selinux_inode_getattr+203
> > > > >         security_inode_getattr+70
> > > > >         vfs_getattr+35
> > > > >         nfsd4_deleg_getattr_conflict+958
> > > > >         nfsd4_encode_fattr4+401
> > > > >         nfsd4_encode_getattr+44
> > > > >         nfsd4_encode_operation+207
> > > > >         nfsd4_proc_compound+470
> > > > >         nfsd_dispatch+217
> > > > >         svc_process_common+1227
> > > > >         svc_process+336
> > > > >         svc_handle_xprt+1200
> > > > >         svc_recv+434
> > > > >         nfsd+284
> > > > >         kthread+227
> > > > >         ret_from_fork+417
> > > > >         ret_from_fork_asm+26
> > > > > 
> > > > > @max_depth_bytes: 1792
> > > > 
> > > > Since the new code only needs the file's size, perhaps you can get
> > > > away with
> > > > 
> > > >         if (i_size_read(inode) != ncf->ncf_cb_fsize)
> > > > 
> > > > rather than
> > > > 
> > > >         err = vfs_getattr(path, stat, STATX_SIZE, AT_STATX_SYNC_AS_STAT);
> > > >         if (err) {
> > > >                 status = nfserrno(err);
> > > >                 goto out_status;
> > > >         }
> > > >         if (stat->size != ncf->ncf_cb_fsize)
> > > > 
> > > > Then there's no longer a need for a struct kstat at all. The client is
> > > > holding a delegation, so I would expect the file size to be stable.
> > > > 
> > > 
> > > I hate relying on the size for this, since it's not a reliable
> > > indicator of change, especially on something that has a fixed size (VM
> > > image, for instance).
> > 
> > You're right, it's not.  I dislike how the pseudocode in 10.4.3 is only
> > checking the change attribute to determine if the file has been modified
> > and then 2 paragraphs down it talks about checking the file size.
> > 
> > At any rate, the main point of this fix is to make sure we're comparing
> > the size from the cb_getattr reply to the current size, not a cached
> > value.  For example:
> > 
> > client 1 does open(O_RDWR|O_CREATE_O_TRUNC)
> > client 1 writes some data and flushes it to the server
> > client 2 does some operation that triggers a CB_GETATTR
> > 
> > At this point client 1 doesn't have any modified data, so it sends the
> > original change attribute and its current file size (which should match
> > the current file size on the server).  With the current code, the server
> > compares the size client 1 sent with the value it cached on the
> > delegation (in this case 0).  The server treats it as if the client is
> > has modified data, which it does not.  That's all this patch is aiming
> > to fix.
> > 
> > > 
> > > In fact, I wonder if this ought to be looking at the mtime too. If the
> > > mtime that the client reported is later than the mtime the server has,
> > > then we can probably infer that there are buffered writes out there.
> > 
> > But the spec doesn't say anything about comparing the mtime.  Plus, if
> > the client is sending the original change attribute but a different
> > mtime than what the server has, wouldn't that be a client bug?
> > 
> > Plus, wouldn't it sort of be crossing into delegated timestamps
> > territory if we started checking the mtime?
> > 
> > 
> 
> Should we be looking at extending the spec? Maybe we should add a "I
> have outstanding buffered data" attribute that the client could send to
> the server in a CB_GETATTR?

I guess I don't understand why the client's usage of the change
attribute doesn't already cover that.

If an application calls write() but not fsync(), close(), etc, and the
background flushers haven't kicked in yet, then the dirty pages/folios
will be tracked on the nfs_inode and the client will send the elevated
change attribute in the CB_GETATTR reply.

What am I missing?

> -- 
> Jeff Layton <jlayton@kernel.org>
> 


