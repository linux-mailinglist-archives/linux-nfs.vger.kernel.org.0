Return-Path: <linux-nfs+bounces-20849-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHakHxPL32nVYwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20849-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 19:29:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F75406CE9
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 19:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD7C6300C274
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B93EB7FD;
	Wed, 15 Apr 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b="agvhUOCC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.fmap.me (fmap.me [51.75.121.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1883EB819
	for <linux-nfs@vger.kernel.org>; Wed, 15 Apr 2026 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.121.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274172; cv=none; b=D8OaxOOoIi48wpLl6fv9Me8rv9/5j6aEXWB2oR1vICvg9kpQWsjfiVk2jpCycr20LnZk6EW7CiPPImD1QbANKcX6KJCtev3UcomjUF6GRAuqLMIj7U2AJWJ19mCThL70LyBq1sQBS0wgbjSuZHoKOr+wo49MwxJAISVuIdUjCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274172; c=relaxed/simple;
	bh=ccNXdbIBme74ELw3kTxzEVZVlsTXk4qHEJFaTaYwo9w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=mhX6sNUZPfXsinoaNnkcv3V7Hcvw0UdrRBz23S8Lanur6JVPZyEXzfi4N2pHH+idLxTUNV3r+YiCfPHmgmsLdgeieWNyNXS3M9j57T5hxl1YsjdP2J44X+6mMmDGKvh9qyGYtnjncqrJrP+/BgOB4VnDFjQkEDkwgQvjQw+cwy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me; spf=pass smtp.mailfrom=fmap.me; dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b=agvhUOCC; arc=none smtp.client-ip=51.75.121.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmap.me
Message-ID: <42bcb43b-5782-4353-b3f7-6e68d919f3c6@fmap.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmap.me; s=mail;
	t=1776273853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BCcNlIEvoT98eWlE0IYBtVxEwYga/avaTXckitPr3w4=;
	b=agvhUOCCgpaZIMXkdlzbXPKZizK4mkpPkquJO3suRnFvsWc/yBrw/nWWNhfWT3MFrcZUWD
	cZLiSP8be/bPMU3P6WCUBWIgjGUrHgETE0KJ5orEVSx8c40OeS1ZRDTGBV5KTmrPksR/P9
	VNMzf2b7aqfPSKHDM0mi6EmTa9wlPPg=
Date: Thu, 16 Apr 2026 00:24:09 +0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nikolay Amiantov <ab@fmap.me>
Subject: Help tracking down a possible race
To: linux-nfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fmap.me,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fmap.me:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20849-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[fmap.me:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ab@fmap.me,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fmap.me:dkim,fmap.me:mid]
X-Rspamd-Queue-Id: E8F75406CE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

tl;dr: weird test results in 
https://github.com/abbradar/nfs_stale_cache_test possibly showing a race 
in NFS, or that I'm stupid :)

Disclaimer: I'm usually not using NFS at all, and I'm now in a rabbit 
hole while researching a bug in a network FS using FUSE (JuiceFS 
[1]). Since I'm way over my head here (my first time with VFS/FUSE/NFS 
kernel subsystems, some prior experience with kernelspace) I may not be 
understanding what I'm talking about at all, so feel free to send me 
away if I'm missing something obvious.

The race I'm talking about goes like this:
* On a host A, a writer appends to a file. In the MRE I have it just 
writes 0xAA one byte at a time;
* On a host B, we simultaneously:
   + Read the file, also a byte at a time, possibly from multiple 
processes/threads simultaneously;
   + At the same time, hammer the same file with stat() calls.

In this case you may randomly read a zero byte instead of the byte you 
are expecting to read.

After hunting this bug in JuiceFS, I went down to the FUSE level and 
managed to implement an MRE [2]. The setup is similar, only instead of a 
writer there is a FUSE FS presenting a slowly growing file.

After much (disclosure: LLM-assisted) research of the kernel code, the 
race, as I understand it, is actually relevant to *any* network FS when 
updates may happen bypassing the cache layer. I tried checking if it 
happens with NFS, and indeed, I can randomly observe zero bytes: 
https://github.com/abbradar/nfs_stale_cache_test . I'm repeating my 
understanding of the issue here for convenience:

------

When a file grows remotely, the page before the old EOF in the read 
cache contains zero-fill beyond the old size. Those zeroes are valid 
while new size <= old size (they are beyond EOF), but become stale once 
the new size is updated to reflect the remote growth: the remote host 
wrote real data there, but the local cache still has the old zero-fill.

In filemap_read() (mm/filemap.c) we have:

```
do {
     ...
     error = filemap_get_pages(iocb, ...);  // (1) get cached folios
     ...
     isize = i_size_read(inode);            // (2) get file size
     ...
     // (3) copy from folio to user, capped at isize
} while (...);
```

If we grow the inode size in-between (1) and (2), the race happens; the 
old page gets capped at the new size, so the userspace reads zeroes 
where there should be actual data.

To trigger this bug, something must change the inode size in parallel 
with a read and not come from a user's `write()` since writes are 
coherent with reads via the cache layer. In a network FS this may happen 
on getattr when we discover that the remote file has grown, and update 
the inode's size. When this happens we need to mark the cache pages as 
stale, but there is no way to "lock" the page and the inode size 
simultaneously, so the race cannot be fixed just by stalling the cache 
in getattr.

NFS does stall the cache already — it sets NFS_INO_INVALID_DATA, then 
before we read invalidates the cache as needed. However the window 
between (1) and (2) is still there.

------

Apart from the patches introducing NFS_INO_INVALIDATING I can't find any 
prior discussion of this issue for FUSE-based, NFS, CIFS or any other 
network FS.

I'd be glad for any help denying or confirming my findings, or 
generally pointing me in the right direction.

Cheers,
Nikolay.

1: https://github.com/juicedata/juicefs/issues/5038
2: https://github.com/abbradar/fuse_growtest


