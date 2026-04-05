Return-Path: <linux-nfs+bounces-20663-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZyLOLKXe0mmjbwcAu9opvQ
	(envelope-from <linux-nfs+bounces-20663-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 00:13:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A4939FF63
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 00:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC6F3006941
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Apr 2026 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAE131985C;
	Sun,  5 Apr 2026 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BG238iIO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03901267AF2
	for <linux-nfs@vger.kernel.org>; Sun,  5 Apr 2026 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775427233; cv=none; b=Seh54UZcy+WdHShiH+wz4PCObdL4c17zXYSZ/LIGKfqgEgzsrhi4wKNr4NrFhasEdnUnVdoKG4dJakCwYhAqR42vOsnskWcI7huNxyZ+fJI9sDg25FYYISuWvZ279Yw/U4iAemzn3/kj1zzkyTypy5sBjwS1KZ65967ayCwRCiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775427233; c=relaxed/simple;
	bh=JTh3NZ+bOjmCm1H7bM92F79qSMuKzEJKov7Dsf8B93s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1Mi2AFG50FwlEBfZwuS2GL9l6NKt+T1uoaQtwtpkqjws3FR+iBD7sXrZ2gw21PNzf/uyV4JN68eoxnkQ7+n/kOUlKwGbS51uNYteBLM8y2jHmKKP4qkQDJIolLiESK8/2L5bKHn5YFMBIkKKP5iajDxJNXZTAkR2LQNHv5YDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BG238iIO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775427230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BU3f/AZPwGvBP0mm1UFLY8THFmNc+d+elhzxB6Nt/G8=;
	b=BG238iIO3UJV+XQySa8kde+qHGjcatrUZuoTwJSY0vWhA0A5umqxTka642tDDkOcWdlNk1
	LsFOVCuMbxlwvTlxdEZ9scpZ+9GxAJAepYSP0ZvNSPsO7iV9/CUhF57hQvnY0otrA6RPv7
	BWv0EM8pX6HQzLln8ncoMs/uQtSxdxw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-Ms_75eYbOnOoXAl2mkJNpw-1; Sun,
 05 Apr 2026 18:13:47 -0400
X-MC-Unique: Ms_75eYbOnOoXAl2mkJNpw-1
X-Mimecast-MFC-AGG-ID: Ms_75eYbOnOoXAl2mkJNpw_1775427225
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68D9C19560B2;
	Sun,  5 Apr 2026 22:13:45 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (unknown [10.22.88.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7684B180035F;
	Sun,  5 Apr 2026 22:13:44 +0000 (UTC)
Received: by smayhew-thinkpadp1gen4i.remote.csb (Postfix, from userid 13752)
	id CFFE844D8C8F; Sun, 05 Apr 2026 18:13:42 -0400 (EDT)
Date: Sun, 5 Apr 2026 18:13:42 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: fix file change detection in CB_GETATTR
Message-ID: <adLellU5iadfbYdX@smayhew-thinkpadp1gen4i.remote.csb>
References: <20260404005405.1565136-1-smayhew@redhat.com>
 <e03d3523-06e1-4414-b185-d349e7edbe54@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e03d3523-06e1-4414-b185-d349e7edbe54@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20663-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smayhew-thinkpadp1gen4i.remote.csb:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 05A4939FF63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 04 Apr 2026, Chuck Lever wrote:

> 
> 
> On Fri, Apr 3, 2026, at 8:54 PM, Scott Mayhew wrote:
> > RFC 8881, section 10.4.3 doesn't say anything about caching the file
> > size in the delegation record, nor does it say anything about comparing
> > a cached file size with the size reported by the client in the
> > CB_GETATTR reply for the purpose of determining if the client holds
> > modified data for the file.
> >
> > What section 10.4.3 of RFC 8881 does say is that the server should
> > compare the *current* file size with size reported by the client holding
> > the delegation in the CB_GETATTR reply, and if they differ to treat it
> > as a modification regardless of the change attribute retrieved via the
> > CB_GETATTR.
> >
> > Doing otherwise would cause the server to believe the client holding the
> > delegation has a modified version of the file, even if the client
> > flushed the modifications to the server prior to the CB_GETATTR.  This
> > would have the added side effect of subsequent CB_GETATTRs causing
> > updates to the mtime, ctime, and change attribute even if the client
> > holding the delegation makes no further updates to the file.
> >
> > Modify nfsd4_deleg_getattr_conflict() to obtain the current file size
> > via vfs_getattr().  Retain the ncf_cur_fsize field, since it's a
> > convenient way to return the file size back to nfsd4_encode_fattr4(),
> > but don't use it for the purpose of detecting file changes.
> >
> > Also, if we recall the delegation (because the client didn't respond to
> > the CB_GETATTR), then skip the logic that checks the nfs4_cb_fattr
> > fields.
> >
> > Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index fa657badf5f8..53d8e7e7d60b 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> 
> > @@ -9459,17 +9461,18 @@ static int cb_getattr_update_times(struct 
> > dentry *dentry, struct nfs4_delegation
> >   * caller must put the reference.
> >   */
> >  __be32
> > -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry 
> > *dentry,
> > -			     struct nfs4_delegation **pdp)
> > +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct path *path,
> > +			     struct kstat *stat, struct nfs4_delegation **pdp)
> 
> Passing the kstat struct in saves some stack just as I suggested,
> but it is an ugly API. The nfsd4_encode_fattr4() call stack is tall,
> though -- did you happen to measure how deep it gets after this patch
> is applied?
> 

I tried using the stack tracer:

# echo 1 >/proc/sys/kernel/stack_tracer_enabled
# echo vfs_getattr >/sys/kernel/debug/tracing/stack_trace_filter
# cat /sys/kernel/debug/tracing/stack_trace
        Depth    Size   Location    (18 entries)
        -----    ----   --------
  0)     1936      48   vfs_getattr+0x9/0x50
  1)     1888     552   nfsd4_encode_fattr4+0x1b2/0x7a0 [nfsd]
  2)     1336      80   nfsd4_encode_entry4_fattr+0xf8/0x210 [nfsd]
  3)     1256      96   nfsd4_encode_entry4+0x10b/0x2a0 [nfsd]
  4)     1160     144   nfsd_buffered_readdir+0x139/0x310 [nfsd]
  5)     1016      80   nfsd_readdir+0x9f/0x180 [nfsd]
  6)      936      80   nfsd4_encode_readdir+0xdf/0x1e0 [nfsd]
  7)      856      80   nfsd4_encode_operation+0xcf/0x3d0 [nfsd]
  8)      776      80   nfsd4_proc_compound+0x1d6/0x7a0 [nfsd]
  9)      696      80   nfsd_dispatch+0xd9/0x240 [nfsd]
 10)      616      80   svc_process_common+0x4cb/0x6b0 [sunrpc]
 11)      536      40   svc_process+0x150/0x240 [sunrpc]
 12)      496      72   svc_handle_xprt+0x4b0/0x5f0 [sunrpc]
 13)      424      56   svc_recv+0x1b2/0x3a0 [sunrpc]
 14)      368      80   nfsd+0x11c/0x3d0 [nfsd]
 15)      288      56   kthread+0xe3/0x120
 16)      232      40   ret_from_fork+0x1a1/0x270
 17)      192     192   ret_from_fork_asm+0x1a/0x30

But that's capturing a vfs_getattr() call from encoding a readdir reply,
rather than the vfs_getattr() call I added to nfsd4_deleg_getattr_conflict().

Here's the stack depth for nfsd4_deleg_getattr_conflict():

# echo nfsd4_deleg_getattr_conflict >/sys/kernel/debug/tracing/stack_trace_filter
# echo 0 >/sys/kernel/debug/tracing/stack_max_size 
# cat /sys/kernel/debug/tracing/stack_trace
        Depth    Size   Location    (14 entries)
        -----    ----   --------
  0)     1472      48   nfsd4_deleg_getattr_conflict+0x9/0x410 [nfsd]
  1)     1424     552   nfsd4_encode_fattr4+0x191/0x7a0 [nfsd]
  2)      872      16   nfsd4_encode_getattr+0x2c/0x40 [nfsd]
  3)      856      80   nfsd4_encode_operation+0xcf/0x3d0 [nfsd]
  4)      776      80   nfsd4_proc_compound+0x1d6/0x7a0 [nfsd]
  5)      696      80   nfsd_dispatch+0xd9/0x240 [nfsd]
  6)      616      80   svc_process_common+0x4cb/0x6b0 [sunrpc]
  7)      536      40   svc_process+0x150/0x240 [sunrpc]
  8)      496      72   svc_handle_xprt+0x4b0/0x5f0 [sunrpc]
  9)      424      56   svc_recv+0x1b2/0x3a0 [sunrpc]
 10)      368      80   nfsd+0x11c/0x3d0 [nfsd]
 11)      288      56   kthread+0xe3/0x120
 12)      232      40   ret_from_fork+0x1a1/0x270
 13)      192     192   ret_from_fork_asm+0x1a/0x30

Manually inspecting function graphs of vfs_getattr(), it looks like the deepest
function (that we can trace) is avc_lookup(), so here's a bpftrace script that
prints the stack depth from avc_lookup() via nfsd4_deleg_getattr_conflict()
(I mostly punted to Gemini for this):

# cat peak-usage.bt 
kprobe:nfsd4_deleg_getattr_conflict {
    @in_deleg_conflict[tid] = 1;
}

kprobe:avc_lookup /@in_deleg_conflict[tid]/ {
    $stack_size = (uint64)16384; 
    $sp = reg("sp");
    $stack_base = $sp & ~($stack_size - 1);
    $total_used = $stack_base + $stack_size - $sp;

    if ($total_used > @max_depth_bytes) {
        @max_depth_bytes = $total_used;
        @deepest_stack = kstack;
    }
}

kretprobe:nfsd4_deleg_getattr_conflict { delete(@in_deleg_conflict[tid]); }

And finally the result:

# bpftrace peak-usage.bt 
Attached 3 probes
^C

@deepest_stack: 
        avc_lookup+1
        avc_has_perm_noaudit+60
        avc_has_perm+89
        selinux_inode_getattr+203
        security_inode_getattr+70
        vfs_getattr+35
        nfsd4_deleg_getattr_conflict+958
        nfsd4_encode_fattr4+401
        nfsd4_encode_getattr+44
        nfsd4_encode_operation+207
        nfsd4_proc_compound+470
        nfsd_dispatch+217
        svc_process_common+1227
        svc_process+336
        svc_handle_xprt+1200
        svc_recv+434
        nfsd+284
        kthread+227
        ret_from_fork+417
        ret_from_fork_asm+26

@max_depth_bytes: 1792

> 
> >  {
> >  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> >  	struct nfsd_thread_local_info *ntli = rqstp->rq_private;
> > +	struct inode *inode = d_inode(path->dentry);
> >  	struct file_lock_context *ctx;
> >  	struct nfs4_delegation *dp = NULL;
> >  	struct file_lease *fl;
> >  	struct nfs4_cb_fattr *ncf;
> > -	struct inode *inode = d_inode(dentry);
> >  	__be32 status;
> > +	int err;
> > 
> >  	ctx = locks_inode_context(inode);
> >  	if (!ctx)
> 
> -- 
> Chuck Lever
> 


