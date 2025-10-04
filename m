Return-Path: <linux-nfs+bounces-14979-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A4BB8E51
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Oct 2025 15:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68FA189BC39
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Oct 2025 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A4482EB;
	Sat,  4 Oct 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="bBjOfHKa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBC3B1AB
	for <linux-nfs@vger.kernel.org>; Sat,  4 Oct 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759586002; cv=none; b=bHdjYLwQ03Ey27g0oJ2cp+ohNSNryIK+ExnqAf9XYFvxJZL77HL24AErEUGEwzyjd0CJ0dbkOeZpF1xWrXNt5K68a09h2fWRscoQjkGLheELTzm8aO2D4d9WDniAfLqrDf90kL0lvU2MQTww91dOBFbROcRu2M2kP4RUashDo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759586002; c=relaxed/simple;
	bh=9O9aOQuaJhfHerwH2ZH+Kn0J07528vk7nGmCJSbY0p0=;
	h=To:cc:From:Subject:Date:Message-ID; b=XVj1C1Tpaa3+QVRIHtJurnKQexN3NuKmVilqAU54lkyp59y2AUA4AXRxgcbKuEVox03T4Hl3lr7Mr1UWglqtZpGUU1UnaQkGHRdaznitZzjkC/yMX9DRtoKTEOgaiWb3aYeeP8xk8ZmC7C3HtGR0+d9rCiwYz620tkscyHz3Ci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=bBjOfHKa; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pazimtFuFuognJ5KCLaARHP1kI+8LL3d0ID+If8vEQc=; t=1759586000; x=1760450000; 
	b=bBjOfHKaSUxzoYoar6bFEnAIzoaYJehZdmGAnyIReXcm9DeTYwrR3qA09sOmabSVPaEzabrLQp0
	K15iEp3lkgOVSOxANmb7RHZCziaueLuTEos5IQHrN2t+GF3whcjC2WlO6d6Z1WxS/QOs8fTXdYOi9
	2VWZKsJwUP/D4yRI6JtKw6EvejDOx+uvbZ79o1KW6N8a9NoTQRHozz2097Uq/f5iTdKijq9LpdtFl
	hbTUGMYV/V4LlVWOHi+T6oN5JjcvYq79uO3uGP+pQpXZT4RRIF6WUWYBoU0tQbQwchbWm6gVoEKTd
	atS153RW9YcollypN7JuRorYg2jQ0RcAs00Q==;
Received: from [24.147.175.133] (helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1v52hB-005YbH-Kg;
	Sat, 04 Oct 2025 09:53:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id DA72C29EB348;
	Sat, 04 Oct 2025 09:53:08 -0400 (EDT)
To: Chuck Lever <chuck.lever@oracle.com>,
    Jeff Layton <jlayton@kernel.org>
cc: linux-nfs@vger.kernel.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: buffer overrun in nfsd4_store_cache_entry()
Date: Sat, 04 Oct 2025 09:53:08 -0400
Message-ID: <91299.1759585988@localhost>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

A client can cause nfsd4_store_cache_entry() to write beyond the end
of slot->sl_data[] here:

        base = resp->cstate.data_offset;
        slot->sl_datalen = buf->len - base;
        if (read_bytes_from_xdr_buf(buf, base, slot->sl_data, slot->sl_datalen))

The demo below does this by sending a CREATE_SESSION with

  maxresp_sz = 64
  maxresp_cached = 80

The result is that the next request that includes a SEQUENCE causes
nfsd4_encode_operation() to decide that the response will be too
large, and to return just an error response to the SEQUENCE. Then
nfsd4_store_cache_entry() decides to cache the result, because
nfsd4_cache_this() (really nfsd4_is_solo_sequence()) returns true. But
the maxresp_cached=80 caused nfsd4_alloc_slot() to allocate slots with
"size" of zero, so that slot->sl_data[] has no space. But
nfsd4_store_cache_entry() is not aware of the true size of sl_data[].

On my setup the problem is detected by the slub redzone debug mechanism
when I shut down nfsd, with rpc.nfsd 0.

# cat /etc/exports
/tmp 127.0.0.1(rw,subtree_check,pnfs)
# wget http://www.rtmrtm.org/rtm/nfsd185f.c
# cc nfsd185f.c
# ./a.out
...
[Right Redzone overwritten] 0xffff888103f65200-0xffff888103f65207 @offset=4608. First byte 0x0 instead of 0xcc
=============================================================================
BUG kmalloc-96 (Tainted: G        W          ): Object corrupt
-----------------------------------------------------------------------------
Allocated in 0x2700003500000001 age=12934 cpu=2 pid=1118
BUG: unable to handle page fault for address: ffff888105768000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 3801067 P4D 3801067 PUD 43f902067 PMD 43f8d6067 PTE 800ffffefa897020
Oops: Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
CPU: 11 UID: 0 PID: 1325 Comm: rpc.nfsd Tainted: G        W           6.17.0-09936-gcbf33b8e0b36-dirty #34 PREEMPT(voluntary)
Tainted: [W]=WARN
Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
RIP: 0010:stack_trace_print+0x23/0x60
Call Trace:
 <TASK>
 stack_depot_print+0x48/0x50
 print_track+0x42/0x70
 print_tracking+0x3e/0x70
 object_err+0x9a/0x2d0
 check_bytes_and_report+0x11a/0x140
 check_object+0x1b7/0x340
 free_to_partial_list+0x1c6/0x570
 ? free_session_slots+0x8a/0x140
 ? free_session_slots+0x8a/0x140
 __slab_free+0x21e/0x3c0
 ? __pfx_schedule_timeout+0x10/0x10
 ? free_session_slots+0x8a/0x140
 kfree+0x2b1/0x350
 free_session_slots+0x8a/0x140
 free_client+0x86/0x150
 __destroy_client+0x246/0x290
 nfs4_state_shutdown_net+0x1da/0x3c0
 nfsd_destroy_serv+0x11a/0x1b0
 nfsd_svc+0x1da/0x300
 write_threads+0xec/0x1b0
 ? __pfx_write_threads+0x10/0x10
 nfsctl_transaction_write+0x4a/0x80
 vfs_write+0xf8/0x470
 ? putname+0x5e/0x80
 ksys_write+0x70/0xf0
 __x64_sys_write+0x18/0x20
 x64_sys_call+0x7d/0x20f0
 do_syscall_64+0xa4/0x280
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Robert Morris
rtm@mit.edu


