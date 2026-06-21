Return-Path: <linux-nfs+bounces-22739-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SdSzAhzGN2qsSwcAu9opvQ
	(envelope-from <linux-nfs+bounces-22739-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 13:08:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A06AAA32
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 13:08:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=aZkRnzDd;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22739-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22739-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A7763001879
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 11:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F01258EFF;
	Sun, 21 Jun 2026 11:08:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B661B4223
	for <linux-nfs@vger.kernel.org>; Sun, 21 Jun 2026 11:08:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782040083; cv=none; b=A5u9WE8KpSoyMFupnhZCP4zJa9E03wVFb9P8WQ0Atrxcx71zRiIaoov3n28+tDXWVps6dnbe7flsmnvHK1UkFMHMd1VIUDeUabIhUBXbvdkpunibGeMPcgX9Nho+PL6u2H91v73L6bNwKGe8Exj7GLlQyg1hVy6MQrgY0hLyBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782040083; c=relaxed/simple;
	bh=wQkY7Ijq+XfY+3Qp92kQkGFCps/T7vh1Eb5Fe3/3pbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZVjvmXvb8QEpy+yHq59EH2ZbeUOEKYQHI4Pc9N5s/mLPO0PwlXKQMNEoFentHhFbBBMUH+VXGZweoaIskXTafEneaJ7JuLkWAHUJV0IP8XkX/teWxaotvoTmmcLqoQQSOIstwjie3KJ5wtqU0Jh845zKQjxhTRWBYJESasL/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aZkRnzDd; arc=none smtp.client-ip=203.205.221.202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782040072; bh=SIzBWfCGvZZ506+bVmddWKFp8q2yW+3HA55xMUGvWq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aZkRnzDdHL/pgDJbUybuKbIp5Gt7XU4v3ht3R2000tiaDbTtbaYAaJILlPp77S4oU
	 7ajRVdFI6l9po2ETLo2PcTXAQwEH4yUPwFiFkfXmf2IyRUkehxbWKKZXBUnZGcPnL6
	 2yI9UEpEEGYRHs8ETaIWKRqVecYb5tazH9+lu2O4=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 1F18C6E9; Sun, 21 Jun 2026 19:07:49 +0800
X-QQ-mid: xmsmtpt1782040069trko198w1
Message-ID: <tencent_7C446FB89D462E14FD321DDEB9E47B640A07@qq.com>
X-QQ-XMAILINFO: M3jS6eb8GJX6HqaTpA0JUjK3ATmUtm77/uXmUYS+Qo1vnfHXEHjlzOv/ph/rTz
	 QgqcIsDg2aWSHpHg3f5MZrWxWLIoYE250EQDj97cTMO3sKFcVsxco4rm5tfQIaHZxyZmkYzzeTVo
	 x9vlv4NpPmxkoZ8m0bolbEfb8ytfHAAFZqiJMULBQN04GuCi9m3Jwtzourb9aXjTQ+pbs7ks42Nv
	 8Wm7Ouqv6MU6ZfJzrTvXCrRWo+tKTQihzkfuH9suwDraVIMMyG8Rwl1Pz/H5B+RXUN3zShHgPu19
	 HxOksYsHL9M6Q8cZeMKb3fcXWb3e0JJg1rdJXR4q67SLNzo+hcZSbEErJzTXe9zKuq30ljda6JMo
	 1FBLo8d2AsVakSJwbZpseyaMxySrp1nx4DE6cz5k8nc9Q/Ckxc+wNg/btP71Lem75EChkl1/2FDz
	 T6JFovvfzK0U/TsZKf0e3DyIDk2X+L0hpfWjx9c0DzSX5wuHpbiZQQ79FGbr+7VvtRWGnU+1g/Og
	 YvtBoYfvYrRm2QvlF8JnXDanszcbV41PrawhBNs91Hq5UwSHYLKTfwSEEiObxxshMuoQOQKypjN+
	 aMGJxBSw3eBotKrnApjd+mxu9jvJBqrN0cIlXBjiMklyyYbSyNT0SnOD6MUTRRSt1l9qxuqx+u1m
	 WxUzART0Y5PAUWnWOLrbSPc/FhFoWOGy65Tzsbe8JvwbTcFhPGf1Aqft3rDVS2GIF7+rHWAnTE3i
	 DFCBOyKdFc4+iyltT9nhfUG/DILiPy6DUBgBkKLPmpqhigCDHmJ6Cy9SgrvLPyFILp3S/8J1EogP
	 YoemZgGZOV8y7bibSBdgP3l8Ys6PbhLJSy2ds/WDdKbW49TbebKnqfDa4bRk0NdnBLjLnuCA83+Y
	 /Cozlu5st5FaCwEG9s4Vz6/vm39nLL0+/3TQ1t80ClJPX1wGe+1uhueXdxpt3vdx9xKgj+C5USmS
	 9R3Z/BEjpOcoQE+MTx8jQl6taJvA262WxdVn20u47HFfm3jUwsle5e18aN4/I54gGcU4kShx1sD6
	 Ksv6FaCLBN7gjqLOVHUXbo6HzkQYWpQW9Q2xds11UMM8N52ckeqCJbkJNz9TPAFfAnhR98Jcrwm1
	 1FWXWmoUys7IYtDukrrDjrvQy33V4/WNHOWe0yycmYynLSHPAE9rthKoyFvA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-OQ-MSGID: <587f7c95-4c6b-4d42-b73b-f008afb3fa22@qq.com>
Date: Sun, 21 Jun 2026 19:07:47 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] NFSD: Prevent post-shutdown use-after-free in
 unlock_filesystem
To: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Musaab Khan <musaab.khan@protonmail.com>, linux-nfs@vger.kernel.org
References: <20260613-unlock-filesystem-uaf-v1-0-462b9bec8c84@kernel.org>
 <20260613-unlock-filesystem-uaf-v1-1-462b9bec8c84@kernel.org>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260613-unlock-filesystem-uaf-v1-1-462b9bec8c84@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22739-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:musaab.khan@protonmail.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xiaowu.417@qq.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaowu.417@qq.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[protonmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qq.com:dkim,qq.com:mid,qq.com:from_mime,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B6A06AAA32

Hi Chuck,

I came across a Sashiko AI code review [1] that flagged a remaining
issue in `write_unlock_fs()` — the `nn->nfsd_serv` check is not
sufficient to guarantee that `nfsd_startup_net()` has run and
allocated the state tables.

I was able to trigger it in QEMU with KASAN: creating an NFSD listener
via portlist sets `nn->nfsd_serv`, but without starting any threads,
`nfsd_startup_net()` never runs.  Writing to unlock_filesystem then
calls `nfsd4_cancel_copy_by_sb()` which dereferences the uninitialized
`nfs4_client` hashtable → NULL pointer dereference.

On Tue, Jun 13, 2026 at 03:26:33PM -0400, Chuck Lever wrote:
 > Writing a filesystem path to /proc/fs/nfsd/unlock_filesystem runs
 > nfsd4_cancel_copy_by_sb() before nfsd_mutex is held. This commit moves
 > the async COPY cancel into the nfsd_mutex protected section after
 > checking nn->nfsd_serv to prevent a use-after-free.

This correctly protects against the post-shutdown UAF, but
`nn->nfsd_serv` can be non-NULL while `nfsd_startup_net()` has not
yet been called.  The sequence is:

   echo 2049 > /proc/fs/nfsd/portlist    # sets nn->nfsd_serv
   # threads are still 0 — nfsd_startup_net() never ran
   echo /mnt > /proc/fs/nfsd/unlock_filesystem  # passes nn->nfsd_serv check

`nfsd4_cancel_copy_by_sb()` then iterates `nn->nfs4_client_hashtbl`,
which was allocated by `nfsd_startup_net()` and is still NULL.

[Reproduction]

Create a listener without starting threads, then write to
unlock_filesystem:

   echo 2049 > /proc/fs/nfsd/portlist
   mount -t nfsd nfsd /proc/fs/nfsd
   echo /mnt > /proc/fs/nfsd/unlock_filesystem

[KASAN report — kernel 7.1.0-rc7-next-20260612, CONFIG_KASAN=y]

   Oops: general protection fault, probably for non-canonical address
   0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]

   RIP: 0010:nfsd4_cancel_copy_by_sb+0x184/0xa70
   Call Trace:
    <TASK>
    write_unlock_fs+0x3ab/0x4f0
    nfsctl_transaction_write+0xfd/0x180
    vfs_write+0x2a5/0x11b0
    ksys_write+0x12f/0x250
    do_syscall_64+0x129/0x880
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

The crash is at offset 0x184 inside `nfsd4_cancel_copy_by_sb()`,
dereferencing a NULL hashtable pointer (`RAX: 0x0000000000000000`).

[1] 
https://sashiko.dev/#/patchset/20260613-unlock-filesystem-uaf-v1-0-462b9bec8c84%40kernel.org
     (Sashiko AI code review — "Null Pointer Dereference", Severity: High)

Thanks,
XIAO



