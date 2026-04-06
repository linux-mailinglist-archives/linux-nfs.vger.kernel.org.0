Return-Path: <linux-nfs+bounces-20671-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBI/LIW/02n6lQcAu9opvQ
	(envelope-from <linux-nfs+bounces-20671-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 16:13:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D73A3D0D
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF03D300CC08
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA12371D0D;
	Mon,  6 Apr 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au2m7eiz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F3296BD2
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484775; cv=none; b=YEFf5aqLiQJ30bZUWWbFq/WbixTMpOhHIQu0GvYqwK4a6vQ/oqGxbT+o+mW6/jG3AHUecp/ZLXgXdC7ZhUETYBO0njLavoiheLRPT/rYCKz3rmkY1BADqOEXN9ntwiCW4atOBIzYK1vE9Jh8y2zkZsvyz7gwxgfWs1WsuTvvRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484775; c=relaxed/simple;
	bh=BxoHZSGl9qiE5uSU/gpzPFFdOPwQokVy5zVbOw0oYGk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B7XkX3q9ejUkvQHFKXRno7dn5pIzEkwWJeiF66iv4JboCd2kUpm6GaLgiAIt3tp2p4GxA8Umqnvm4x8ZjuF0ZZpOCk5ZB0YScqMPTwJSkWoDj8KnX9/H8Ar2yXmZ/5TlObfA9Yrkli0cth/O091QHInvNCOfDCBNgv2jYOKZqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au2m7eiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CE5C4CEF7;
	Mon,  6 Apr 2026 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775484775;
	bh=BxoHZSGl9qiE5uSU/gpzPFFdOPwQokVy5zVbOw0oYGk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Au2m7eizfG0oJ72p/e2bVobt3caXIxtNkrN9QjiEuWHZ2I1c8Xcx5FrzZdORToljH
	 LSkH+KVRDvPtV8ipAHwlm70nD57Jp3qgPOtC9hQwGYRO5OUgI6RCKXh5saF8epvGCg
	 w2kUsJYDFPo4dN8xCPdqwkjOzWZ/R+7L2k0nGMPbjqBnEhs/SsakTs24LaQcyVE/xx
	 Z/2rLIZ5340z3xf4skSWerMZVjspy45ccBjmI0TFN0FphGjqoHSi5z8PG1uTxzSaeE
	 GQrhWssR1vTE0IBju6ZLhcVvTknNKMAOfJ0qmNcvKBHZ3z3IMj6VrYXMC+LLIJVf2B
	 /h05FIX038bRA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 261ADF4006E;
	Mon,  6 Apr 2026 10:12:54 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 06 Apr 2026 10:12:54 -0400
X-ME-Sender: <xms:Zr_TaeB2aU9IFaRUXqsy1a94q3Tkh4zfz2hOZkE-0vDRIwFiXDJFWg>
    <xme:Zr_TaTWxw0J0MfSj2BvOoUWIIrirNdlKDhZTjUNMLjXfIX4-QZAyDCrMXx_XnqYeN
    KJS_k-SvXqwhsshXlG0HLN5B8a3Zj1Lr0yHm4FI0hVB0-b2tYEgPXzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddujeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsmhgrhihh
    vgifsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomh
    dprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Zr_TaQXfTO-E1Kg8b3E73xhiUwFtsUsodIXL2YPhm6jGAd3OxRlxiA>
    <xmx:Zr_TaemQnlebMvaYmn_-cvgqSjJ5UwAcX7_VGUchmz0oOzoOUQGtmg>
    <xmx:Zr_TabCXv5HtsUs7HP9bOqlMpFpfA4z7W1iE0U6oIDFTG4rD460U2g>
    <xmx:Zr_Tadiz04cOzPDRzCMb0W4U3mz3dltUOsazFQzYExiAQoY6oqnpzA>
    <xmx:Zr_TaYzzmqbFfmL4ZaWMyB-irjf6LedhTIcirAt56hSYnzlUKMqJkvlt>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E815A780070; Mon,  6 Apr 2026 10:12:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMVA-RgOnKPZ
Date: Mon, 06 Apr 2026 10:12:33 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Scott Mayhew" <smayhew@redhat.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Message-Id: <fb00b2d1-e7be-4567-a077-9ec26a938a5c@app.fastmail.com>
In-Reply-To: <adLellU5iadfbYdX@smayhew-thinkpadp1gen4i.remote.csb>
References: <20260404005405.1565136-1-smayhew@redhat.com>
 <e03d3523-06e1-4414-b185-d349e7edbe54@app.fastmail.com>
 <adLellU5iadfbYdX@smayhew-thinkpadp1gen4i.remote.csb>
Subject: Re: [PATCH v2] nfsd: fix file change detection in CB_GETATTR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20671-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,peak-usage.bt:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 125D73A3D0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Sun, Apr 5, 2026, at 6:13 PM, Scott Mayhew wrote:
> On Sat, 04 Apr 2026, Chuck Lever wrote:
>> On Fri, Apr 3, 2026, at 8:54 PM, Scott Mayhew wrote:

>> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> > index fa657badf5f8..53d8e7e7d60b 100644
>> > --- a/fs/nfsd/nfs4state.c
>> > +++ b/fs/nfsd/nfs4state.c
>> 
>> > @@ -9459,17 +9461,18 @@ static int cb_getattr_update_times(struct 
>> > dentry *dentry, struct nfs4_delegation
>> >   * caller must put the reference.
>> >   */
>> >  __be32
>> > -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry 
>> > *dentry,
>> > -			     struct nfs4_delegation **pdp)
>> > +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct path *path,
>> > +			     struct kstat *stat, struct nfs4_delegation **pdp)
>> 
>> Passing the kstat struct in saves some stack just as I suggested,
>> but it is an ugly API. The nfsd4_encode_fattr4() call stack is tall,
>> though -- did you happen to measure how deep it gets after this patch
>> is applied?
>> 
>
> I tried using the stack tracer:
>
> # echo 1 >/proc/sys/kernel/stack_tracer_enabled
> # echo vfs_getattr >/sys/kernel/debug/tracing/stack_trace_filter
> # cat /sys/kernel/debug/tracing/stack_trace
>         Depth    Size   Location    (18 entries)
>         -----    ----   --------
>   0)     1936      48   vfs_getattr+0x9/0x50
>   1)     1888     552   nfsd4_encode_fattr4+0x1b2/0x7a0 [nfsd]
>   2)     1336      80   nfsd4_encode_entry4_fattr+0xf8/0x210 [nfsd]
>   3)     1256      96   nfsd4_encode_entry4+0x10b/0x2a0 [nfsd]
>   4)     1160     144   nfsd_buffered_readdir+0x139/0x310 [nfsd]
>   5)     1016      80   nfsd_readdir+0x9f/0x180 [nfsd]
>   6)      936      80   nfsd4_encode_readdir+0xdf/0x1e0 [nfsd]
>   7)      856      80   nfsd4_encode_operation+0xcf/0x3d0 [nfsd]
>   8)      776      80   nfsd4_proc_compound+0x1d6/0x7a0 [nfsd]
>   9)      696      80   nfsd_dispatch+0xd9/0x240 [nfsd]
>  10)      616      80   svc_process_common+0x4cb/0x6b0 [sunrpc]
>  11)      536      40   svc_process+0x150/0x240 [sunrpc]
>  12)      496      72   svc_handle_xprt+0x4b0/0x5f0 [sunrpc]
>  13)      424      56   svc_recv+0x1b2/0x3a0 [sunrpc]
>  14)      368      80   nfsd+0x11c/0x3d0 [nfsd]
>  15)      288      56   kthread+0xe3/0x120
>  16)      232      40   ret_from_fork+0x1a1/0x270
>  17)      192     192   ret_from_fork_asm+0x1a/0x30
>
> But that's capturing a vfs_getattr() call from encoding a readdir reply,
> rather than the vfs_getattr() call I added to nfsd4_deleg_getattr_conflict().
>
> Here's the stack depth for nfsd4_deleg_getattr_conflict():
>
> # echo nfsd4_deleg_getattr_conflict 
> >/sys/kernel/debug/tracing/stack_trace_filter
> # echo 0 >/sys/kernel/debug/tracing/stack_max_size 
> # cat /sys/kernel/debug/tracing/stack_trace
>         Depth    Size   Location    (14 entries)
>         -----    ----   --------
>   0)     1472      48   nfsd4_deleg_getattr_conflict+0x9/0x410 [nfsd]
>   1)     1424     552   nfsd4_encode_fattr4+0x191/0x7a0 [nfsd]
>   2)      872      16   nfsd4_encode_getattr+0x2c/0x40 [nfsd]
>   3)      856      80   nfsd4_encode_operation+0xcf/0x3d0 [nfsd]
>   4)      776      80   nfsd4_proc_compound+0x1d6/0x7a0 [nfsd]
>   5)      696      80   nfsd_dispatch+0xd9/0x240 [nfsd]
>   6)      616      80   svc_process_common+0x4cb/0x6b0 [sunrpc]
>   7)      536      40   svc_process+0x150/0x240 [sunrpc]
>   8)      496      72   svc_handle_xprt+0x4b0/0x5f0 [sunrpc]
>   9)      424      56   svc_recv+0x1b2/0x3a0 [sunrpc]
>  10)      368      80   nfsd+0x11c/0x3d0 [nfsd]
>  11)      288      56   kthread+0xe3/0x120
>  12)      232      40   ret_from_fork+0x1a1/0x270
>  13)      192     192   ret_from_fork_asm+0x1a/0x30
>
> Manually inspecting function graphs of vfs_getattr(), it looks like the deepest
> function (that we can trace) is avc_lookup(), so here's a bpftrace script that
> prints the stack depth from avc_lookup() via nfsd4_deleg_getattr_conflict()
> (I mostly punted to Gemini for this):
>
> # cat peak-usage.bt 
> kprobe:nfsd4_deleg_getattr_conflict {
>     @in_deleg_conflict[tid] = 1;
> }
>
> kprobe:avc_lookup /@in_deleg_conflict[tid]/ {
>     $stack_size = (uint64)16384; 
>     $sp = reg("sp");
>     $stack_base = $sp & ~($stack_size - 1);
>     $total_used = $stack_base + $stack_size - $sp;
>
>     if ($total_used > @max_depth_bytes) {
>         @max_depth_bytes = $total_used;
>         @deepest_stack = kstack;
>     }
> }
>
> kretprobe:nfsd4_deleg_getattr_conflict { delete(@in_deleg_conflict[tid]); }
>
> And finally the result:
>
> # bpftrace peak-usage.bt 
> Attached 3 probes
> ^C
>
> @deepest_stack: 
>         avc_lookup+1
>         avc_has_perm_noaudit+60
>         avc_has_perm+89
>         selinux_inode_getattr+203
>         security_inode_getattr+70
>         vfs_getattr+35
>         nfsd4_deleg_getattr_conflict+958
>         nfsd4_encode_fattr4+401
>         nfsd4_encode_getattr+44
>         nfsd4_encode_operation+207
>         nfsd4_proc_compound+470
>         nfsd_dispatch+217
>         svc_process_common+1227
>         svc_process+336
>         svc_handle_xprt+1200
>         svc_recv+434
>         nfsd+284
>         kthread+227
>         ret_from_fork+417
>         ret_from_fork_asm+26
>
> @max_depth_bytes: 1792

Since the new code only needs the file's size, perhaps you can get
away with

        if (i_size_read(inode) != ncf->ncf_cb_fsize)

rather than

        err = vfs_getattr(path, stat, STATX_SIZE, AT_STATX_SYNC_AS_STAT);
        if (err) {
                status = nfserrno(err);
                goto out_status;
        }
        if (stat->size != ncf->ncf_cb_fsize)

Then there's no longer a need for a struct kstat at all. The client is
holding a delegation, so I would expect the file size to be stable.


-- 
Chuck Lever

