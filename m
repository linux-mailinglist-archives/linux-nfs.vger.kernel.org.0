Return-Path: <linux-nfs+bounces-22262-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b5ROF/YXIWpr/AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22262-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 08:15:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B1D63D30B
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 08:15:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YZdzENTk;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22262-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22262-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7709F3014279
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 06:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9CC3D6CA4;
	Thu,  4 Jun 2026 06:15:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E93D6664;
	Thu,  4 Jun 2026 06:15:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553711; cv=none; b=YwpXpRyac0zMKTITkcSG77j+ivcxA+XdcmJM6vh80QbElxM1ys/n/OL38V0JQNIphAyAYpIoCVFDrTm3kxyrRhb2/jMFghlVIHWqTOEv4dsxbF8I0TCBLVsRPzxkafNHF6dkq5XaiEo3dsVJ9UVC8Vz1w3icQmXrzvNislspcyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553711; c=relaxed/simple;
	bh=atVSAfHhDYBovprcHMCjWAChHvgsN9Zly/q2GkqZTdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsSXpO8srZ6x0paQBdomoVZac5qJ6y8fWyb9dHJTenYOQFkVehtDnMX04uyoKLwHGpT2uJJrwW3hzPQrhqDUbDALnitmkVsRlkUQ9BaRzSk8foi4mvbjn3oorBLKxDi0zuYB0BArUChRHx43RBAzMJPbdQ4NG6cB3SlU9PwucbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZdzENTk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6611F00893;
	Thu,  4 Jun 2026 06:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780553709;
	bh=maKYg38a30VxIX8QCcSBujTuAdCuRyvh3rWBPMbaTa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YZdzENTkOazs5XSTumSTfKjNe97Bx1gIjbWPEe0rEOYizlJ+PG3Skn0hS26Ux74Jl
	 AXCvUF5ahoFRq9So4PlOjS3IWyCIq5NTGNUoudm5MMRDdJhNBKN1LdgBDErw0LtVFd
	 jzKhcofKN8uPI1V71amXjFQlau+IKLTXzAiqIsn/g+sTxSoMC/LouWT+HEHb+idjuI
	 8F/5ZnoIZWEz4pT/Oim/JLh5w98h2ycR5nXmcdy58o4NERbYl1r+Hpa7rpblTquRvP
	 owmPxKztmOlhAuoaO/iNyxsWnpCrb8pm0xA6MdS2Qr/cnlFMvHA1Yq1Qntrgg1OIwG
	 JJVS4xnu2W56g==
Date: Thu, 4 Jun 2026 09:14:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/17] jbd2: replace __get_free_pages() with kmalloc()
Message-ID: <aiEX4UTxEnBTjVKo@kernel.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-10-275e36a83f0e@kernel.org>
 <yfzx3jgzwesernofl7mzixa2mhjfii5v3o7yapghtmozixrpfu@6bsh7iixyiov>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yfzx3jgzwesernofl7mzixa2mhjfii5v3o7yapghtmozixrpfu@6bsh7iixyiov>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22262-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tytso@mit.edu,m:jack@suse.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:konishi.ryusuke@gmail.com,m:slava@dubeyko.com,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:shaggy@kernel.org,m:miklos@szeredi.hu,m:a.hindborg@kernel.org,m:leitao@debian.org,m:kees@kernel.org,m:aivazian.tigran@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:ocfs2-devel@lists.linux.dev,m:linux-nilfs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jfs-discussion@lists.sourceforge.net,m:linux-ext4@vger.kernel.org,m:linux-mm@kvack.org,m:konishiryusuke@gmail.com,m:aivaziantigran@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,szeredi.hu,debian.org,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59B1D63D30B

Hi Ted,

On Wed, Jun 03, 2026 at 09:50:15AM -0400, Theodore Tso wrote:
> On Sat, May 23, 2026 at 08:54:22PM +0300, Mike Rapoport (Microsoft) wrote:
> > jbd2_alloc() falls back from kmem_cache_alloc() to __get_free_pages() for
> > allocations larger than PAGE_SIZE.
> > But kmalloc() can handle such cases with essentially the same fallback.
> > 
> > Replace use of __get_free_pages() with kmalloc() and simplify
> > jbd2_free() as both kmem_cache_alloc() and kmalloc() allocations can be
> > freed with kfree().
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> So historically __get_free_pages() was more efficient than kmalloc
> since previously the kmalloc overhead meant that a single 4k
> allocation would take two pages instead of one.  I'm guessing that has
> since changed?

Today there's no memory overhead for kmalloc(PAGE_SIZE). Cache refill takes
more pages of course, but they will be handed over to the next
kmalloc(PAGE_SIZE).
 
> Can you explain to someone who hasn't been tracking the changes in
> kmalloc over time:
> 
>   * How does the efficiency of kmalloc compare to __get_free_page when
>     order == 1?  What is the overhead in terms of memory overhead?
>     I'm a bit less concerned about CPU overhead, but it would be good
>     to know that?

There's no memory overhead when order == 1.
As for the CPU overhead, the difference for the fast path allocations is
not measurable and for the slow path it is anyway determined by the amount
of reclaim involved rather than by what allocator is used.
 
>   * What does kmalloc() do when a size > PAGE_SIZE is passed?  Will it
>     return contiguous memory, or return an error or worse, BUG?  And
>     same question as above; what is the overhead of kmalloc() when
>     size is 2*PAGE_SIZE?  8*PAGE_SIZE?

For size >= PAGE_SIZE kmalloc() always returns contiguous page aligned
memory.

Larger allocations (> PAGE_SIZE * 2) go straight to the page allocator. 

> Thanks,
> 
> 						- Ted

-- 
Sincerely yours,
Mike.

