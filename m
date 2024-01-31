Return-Path: <linux-nfs+bounces-1634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27426844849
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 20:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3D01C22895
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320793B189;
	Wed, 31 Jan 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+heruaL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243963E49D
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730702; cv=none; b=QzwZ0f3bjjSBG/UY8k1inS4C8PWopeWC/5H5wXOaPlDForX8Ygmco5K+3adR4ktCeWnu3qhk7Nnoh6ERrTivvLf9U8mer1s2wrRmO64ptlYp+4hcQVZM3CCuXe0i1iTvI+pFrQAepgNIYn9rgf0O0vqOgHXm1OYIn+htU1dN+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730702; c=relaxed/simple;
	bh=JOaQzzayA3mf2LzaqRE0f+/WHTL4kYe8UcidjkIJJrY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FJRO4k99VBYa8r32lFbWLGKbiySnl0c7Zr1zg7XXCw7mhip4aCUKIsoXT2vQNI5p2tMpUmrigC6Rl+9Db7W1Kh6oHF3dLCVLJE6gOHe70IlSBy1z5WW5iYYHs2w2VFDafhu1LgpwNBtzjb53raHyE4LfabE4YXU8SgMQH1oPxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+heruaL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706730698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CfQB6iGdylq75aVA2NL5ZI7JIQuhLFeRLqOfVSFVCE=;
	b=Z+heruaL/PD1fVEGIBVxBsNb4ASK0ZMzngtTBVC41idMO00goekjm/Zr7j28J/aHxJxDBo
	+Qz1SfeFbXunJ/VIXMunGutY7GXAXYrREE7Ra0kkpFnll2jKgUCJM7iA7/dXZtNzNg4hZx
	N/b6+Af99OqbXRhTUr8WkU9NnGds9/w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-e9iQpFJjO0GWuD5DHBr7HA-1; Wed,
 31 Jan 2024 14:51:35 -0500
X-MC-Unique: e9iQpFJjO0GWuD5DHBr7HA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1091B3C00085;
	Wed, 31 Jan 2024 19:51:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EFCFD492BE2;
	Wed, 31 Jan 2024 19:51:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240131161006.1475094-1-dwysocha@redhat.com>
References: <20240131161006.1475094-1-dwysocha@redhat.com>
To: Dave Wysochanski <dwysocha@redhat.com>
Cc: dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
    linux-cachefs@redhat.com
Subject: Re: [PATCH v2] NFS: Fix nfs_netfs_issue_read() xarray locking for writeback interrupt
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2259952.1706730693.1@warthog.procyon.org.uk>
Date: Wed, 31 Jan 2024 19:51:33 +0000
Message-ID: <2259953.1706730693@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Dave Wysochanski <dwysocha@redhat.com> wrote:

> The loop inside nfs_netfs_issue_read() currently does not disable
> interrupts while iterating through pages in the xarray to submit
> for NFS read.  This is not safe though since after taking xa_lock,
> another page in the mapping could be processed for writeback inside
> an interrupt, and deadlock can occur.  The fix is simple and clean
> if we use xa_for_each_range(), which handles the iteration with RCU
> while reducing code complexity.
> 
> The problem is easily reproduced with the following test:
>  mount -o vers=3,fsc 127.0.0.1:/export /mnt/nfs
>  dd if=/dev/zero of=/mnt/nfs/file1.bin bs=4096 count=1
>  echo 3 > /proc/sys/vm/drop_caches
>  dd if=/mnt/nfs/file1.bin of=/dev/null
>  umount /mnt/nfs
> 
> On the console with a lockdep-enabled kernel a message similar to
> the following will be seen:
> 
>  ================================
>  WARNING: inconsistent lock state
>  6.7.0-lockdbg+ #10 Not tainted
>  --------------------------------
>  inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>  test5/1708 [HC0[0]:SC0[0]:HE1:SE1] takes:
>  ffff888127baa598 (&xa->xa_lock#4){+.?.}-{3:3}, at:
> nfs_netfs_issue_read+0x1b2/0x4b0 [nfs]
>  {IN-SOFTIRQ-W} state was registered at:
>    lock_acquire+0x144/0x380
>    _raw_spin_lock_irqsave+0x4e/0xa0
>    __folio_end_writeback+0x17e/0x5c0
>    folio_end_writeback+0x93/0x1b0
>    iomap_finish_ioend+0xeb/0x6a0
>    blk_update_request+0x204/0x7f0
>    blk_mq_end_request+0x30/0x1c0
>    blk_complete_reqs+0x7e/0xa0
>    __do_softirq+0x113/0x544
>    __irq_exit_rcu+0xfe/0x120
>    irq_exit_rcu+0xe/0x20
>    sysvec_call_function_single+0x6f/0x90
>    asm_sysvec_call_function_single+0x1a/0x20
>    pv_native_safe_halt+0xf/0x20
>    default_idle+0x9/0x20
>    default_idle_call+0x67/0xa0
>    do_idle+0x2b5/0x300
>    cpu_startup_entry+0x34/0x40
>    start_secondary+0x19d/0x1c0
>    secondary_startup_64_no_verify+0x18f/0x19b
>  irq event stamp: 176891
>  hardirqs last  enabled at (176891): [<ffffffffa67a0be4>]
> _raw_spin_unlock_irqrestore+0x44/0x60
>  hardirqs last disabled at (176890): [<ffffffffa67a0899>]
> _raw_spin_lock_irqsave+0x79/0xa0
>  softirqs last  enabled at (176646): [<ffffffffa515d91e>]
> __irq_exit_rcu+0xfe/0x120
>  softirqs last disabled at (176633): [<ffffffffa515d91e>]
> __irq_exit_rcu+0xfe/0x120
> 
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&xa->xa_lock#4);
>    <Interrupt>
>      lock(&xa->xa_lock#4);
> 
>   *** DEADLOCK ***
> 
>  2 locks held by test5/1708:
>   #0: ffff888127baa498 (&sb->s_type->i_mutex_key#22){++++}-{4:4}, at:
>       nfs_start_io_read+0x28/0x90 [nfs]
>   #1: ffff888127baa650 (mapping.invalidate_lock#3){.+.+}-{4:4}, at:
>       page_cache_ra_unbounded+0xa4/0x280
> 
>  stack backtrace:
>  CPU: 6 PID: 1708 Comm: test5 Kdump: loaded Not tainted 6.7.0-lockdbg+
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39
> 04/01/2014
>  Call Trace:
>   dump_stack_lvl+0x5b/0x90
>   mark_lock+0xb3f/0xd20
>   __lock_acquire+0x77b/0x3360
>   _raw_spin_lock+0x34/0x80
>   nfs_netfs_issue_read+0x1b2/0x4b0 [nfs]
>   netfs_begin_read+0x77f/0x980 [netfs]
>   nfs_netfs_readahead+0x45/0x60 [nfs]
>   nfs_readahead+0x323/0x5a0 [nfs]
>   read_pages+0xf3/0x5c0
>   page_cache_ra_unbounded+0x1c8/0x280
>   filemap_get_pages+0x38c/0xae0
>   filemap_read+0x206/0x5e0
>   nfs_file_read+0xb7/0x140 [nfs]
>   vfs_read+0x2a9/0x460
>   ksys_read+0xb7/0x140
> 
> Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when
> fscache is enabled")
> Suggested-by: Jeff Layton <jlayton@redhat.com>
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>

Reviewed-by: David Howells <dhowells@redhat.com>


