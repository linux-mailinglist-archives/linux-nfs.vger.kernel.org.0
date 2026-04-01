Return-Path: <linux-nfs+bounces-20592-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GERMGyVczWkRcQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20592-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 19:55:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F2137EE66
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 19:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5407302735D
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A94F3F0A91;
	Wed,  1 Apr 2026 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdlNq0gl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3342FD1AA
	for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2026 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066061; cv=none; b=JDLjWEl2o9ZA8VaElrACtDROpf+ZYt2rKSLAFOyAIyLYzDsf7GYpXyL9kc+N1wH+TlxIpkVYb7ikAIWMqFytYPH99Jbjjb28iGOhdzgLBMDT3b5/2SVtd0GV/FzUU4rxNQtTjmM5i40Ma0//lrImXXo8TK83T8KwQwp6lpMV8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066061; c=relaxed/simple;
	bh=1VlEL/xXzyrJJvx7yEhwTan9HP+wmq6OZnejImKjpAE=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To; b=UUEMNe9BwBJcE7vs8VjiFX+m1hXp/NkxZS2C2OlR6dvNx6icB+r45Y1sG6U/Jhuvx3LYmJGgiUhWCa0eHTcfiP9XMc+AHF+qwhEcibm6210i/8B1zvG0kA7JKxnAwHDIpWCuT7krMvaAnEkCuZeIE1rxcmTCIP1kh1o8Pui2NuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdlNq0gl; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2c500750dso100239e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 01 Apr 2026 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775066057; x=1775670857; darn=vger.kernel.org;
        h=content-language:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce/ZvDRqNZw7GdAZ/3d5FlhIqA+xX3hk0+RuGoOBMbk=;
        b=kdlNq0glAVjMH0THzw07a6MIIx1b4yFNftryQMpUzf637rZGDfCB3xMNVC5JNssVVV
         X06oy6ndDVIdlFWplt3Ty8EdDh7WNlwUisOpuvZ+1YG/RirEVFOS/HoOGURKAIVl4ApP
         27WaL07LPSZsYcHtmRjbxHR5Qo7qkEY1eKwK/XAgff6J93Brjs2bkP6vxF/dZM83Z4bj
         EgDz6+XLgc8RJxvWXG0mELd8IKwJwGsPx/bqjguNKI4olNkAxcCOrWOtU8jY0fs+5FR0
         /NA53DH8moybn5XQxpms1BCCJdOEmJsCj0mrZeiVCokqdehjE8qIe1zPb8KKo0SBZIJ7
         aibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775066057; x=1775670857;
        h=content-language:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce/ZvDRqNZw7GdAZ/3d5FlhIqA+xX3hk0+RuGoOBMbk=;
        b=pwvkgX3dmZlUEtwa1G+bVOggYKhHCbbPF1gHgTWyMvqwbgBRVMXowFPyaAjffaMfki
         D/E4UwqCfSGKZoeBJnAcwudKl3briN95buqsL39KKI0YSWipeVmE37luGfQPmip6BV+u
         OGRR1ox1SlmzSLzC5klJtRzlkOVU1CL80EpLgz3tEBpqmYPTiO/f6pjxbvHBJ7nM/Yw1
         08hwW83SxNOPU6ByEv0tW5kNJmks5NduD9W7YOFT+MsCQkI/1QhJ19M6IccnPPscDKxI
         f/IsR6pSRd/rg2oS1VRES/A/4VfI1WGUL0e23gfWhR1U3VNseh6wb258oCArq+cRTm9W
         kV9w==
X-Gm-Message-State: AOJu0YwUgBqRDBS7oCu6O2qTuEceT2SNEJKmg/yvwzThuKHUuLI++jJV
	Mvs3nWjNvz7tN/uT85u03y5OpQYt9Zpw5HBEx1cmimmmeGSIU46wUe/EF2AWbkHg
X-Gm-Gg: ATEYQzzwLLXAipdD+8HM3aWoFQd5DJo6vZ82JQXAwcoFFJQNvsuD/UHk76wFiqzPPYW
	JdmNUw0B7jYxAksesmkIA6esVBiiAUWNM7zhLY2JYkD5q+dwTSMsgFo6w3oL3cYy463uHLD4h87
	8svjzW6Fx8GAsg44dqU+HFJuJ1Goa6HahVWfuytzLYdnBsxscggl3vt4BZrQa1QFnUvdxLeqxwg
	80jVtyhinMIX6mY8GN7FxQe07+9HxD76mxnQDSaFEy70oCnefAH7hfGWlFTRTw8CdpOR/yycfyw
	Tqf8x3WjCXfpXIPl3wX+iwkZqm3FupZ1j0WFnIem7E10PtRA5M9cZ4vZiOW++G5JWIeClfHWx2b
	5fPsThnGKHUUVAtOw0jQw+7E/Gti4x4Fyxnb4c+r6vPQ003RvkFP5766hx4QzoetxEsdN4HE3v2
	M3BjRiObIW/y223L5HCuvZA5IHHubsPN1cEDcGQWJ4bpuArnKQdqWc/O5yGrqJfvqPDLBqUVc4i
	g9WjX7HiVc=
X-Received: by 2002:a05:6512:3042:b0:5a1:3bfd:b87b with SMTP id 2adb3069b0e04-5a2c1f221b8mr1646591e87.30.1775066057088;
        Wed, 01 Apr 2026 10:54:17 -0700 (PDT)
Received: from [192.168.0.125] (cdmjno2.plus.com. [31.125.38.23])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd217ba60sm1146111fa.38.2026.04.01.10.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 10:54:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------5tTvaaAnR050Px7Fm80EnnAT"
Message-ID: <3820f743-ef30-4ace-bad0-fea2f97398fc@gmail.com>
Date: Wed, 1 Apr 2026 18:54:15 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mike Owen <mjnowen@gmail.com>
Subject: WARNING in nfs_free_request: PG_WB_END stale during NFS read
 completion with FS-Cache
To: linux-nfs@vger.kernel.org, netfs@lists.linux.dev
Content-Language: en-US
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20592-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjnowen@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8F2137EE66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------5tTvaaAnR050Px7Fm80EnnAT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I am running a fleet of KNFSD NFS re-export proxy instances with kernel 6.19.4 (vanilla stable, compiled from source with no custom patches). Under production
NFS read load, 13 of 16 instances hit a `WARN_ON_ONCE` in `nfs_free_request()` at `fs/nfs/pagelist.c:587`. The WARNING fires in the NFS read completion path and indicates that the `PG_WB_END` page-group synchronisation flag is unexpectedly still set when an `nfs_page` request is being freed.

The WARNING does not cause a crash or data corruption, but it reproduces consistently across the majority of instances under load.

I have written up the detailed issue, per attached: "nfs-free-request-warning-report.md", including reproducer steps.

WARNING: fs/nfs/pagelist.c:587 at nfs_free_request+0x175/0x1e0 [nfs], CPU#10: kworker/u96:47/131414
Modules linked in: tls tcp_diag udp_diag inet_diag nfsd auth_rpcgss nfsv3 nfs_acl nfs lockd grace cachefiles netfs xfs raid0 ...
CPU: 10 UID: 0 PID: 131414 Comm: kworker/u96:47 Tainted: G           OE       6.19.4-knfsd #1 VOLUNTARY
Hardware name: Amazon EC2 i3en.6xlarge/, BIOS 1.0 10/16/2017
Workqueue: nfsiod rpc_async_release [sunrpc]
RIP: 0010:nfs_free_request+0x175/0x1e0 [nfs]
Code: 48 8b 43 38 84 c0 0f 89 ce fe ff ff 0f 0b 48 8b 43 38 f6 c4 01 0f 84 cc fe ff ff 0f 0b 48 8b 43 38 f6 c4 02 0f 84 ca fe ff ff <0f> 0b 48 8b 43 38 f6 c4 04 0f 84 c8 fe ff ff 0f 0b 48 8b 43 38 f6
RSP: 0018:ffffd1de8a523d18 EFLAGS: 00010202
RAX: 0000000000000204 RBX: ffff8aa811146180 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8aa811146180
RBP: ffffd1de8a523d28 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8aa811146180
R13: ffff8aa811146180 R14: 0000000000000001 R15: ffff8ac45ab8a298
FS:  0000000000000000(0000) GS:ffff8ad5a4b3c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007339078ee200 CR3: 000000015b244005 CR4: 00000000007706f0
PKRU: 55555554
Call Trace:
 <TASK>
 nfs_page_group_destroy+0x65/0xc0 [nfs]
 nfs_page_group_destroy+0x9f/0xc0 [nfs]
 nfs_release_request+0x36/0x60 [nfs]
 nfs_readpage_release.isra.0+0x37/0x80 [nfs]
 nfs_read_completion+0x80/0x170 [nfs]
 nfs_pgio_release+0x16/0x20 [nfs]
 rpc_free_task+0x3f/0x80 [sunrpc]
 rpc_async_release+0x33/0x50 [sunrpc]
 process_one_work+0x182/0x350
 worker_thread+0x19a/0x320
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xf9/0x210
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x25c/0x290
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
---[ end trace 0000000000000000 ]---

Questions:

1. Is this a known issue in the NFS page-group synchronisation code
   when FS-Cache/cachefiles is active?

2. Could the netfs/cachefiles write-back path (writing read data to
   the cache) inadvertently set `PG_WB_END` on `nfs_page` structures
   during a read operation?

3. Is this specific to the re-export (nfsd + NFS client on same host)
   configuration, or could it affect any NFS client with FS-Cache
   enabled?

Any guidance or patches to address this would be greatly appreciated.

Thank you for reading.
-Mike

--------------5tTvaaAnR050Px7Fm80EnnAT
Content-Type: text/markdown; charset=UTF-8;
 name="nfs-free-request-warning-report.md"
Content-Disposition: attachment; filename="nfs-free-request-warning-report.md"
Content-Transfer-Encoding: base64

IyBXQVJOSU5HIGluIG5mc19mcmVlX3JlcXVlc3Q6IFBHX1dCX0VORCBzdGFsZSBpbiBORlMg
cmVhZCBjb21wbGV0aW9uIHBhdGgKCiMjIFN1bW1hcnkKCkkgYW0gcnVubmluZyBhIGZsZWV0
IG9mIEtORlNEIE5GUyByZS1leHBvcnQgcHJveHkgaW5zdGFuY2VzIHdpdGgga2VybmVsIDYu
MTkuNCAodmFuaWxsYQpzdGFibGUsIGNvbXBpbGVkIGZyb20gc291cmNlIHdpdGggbm8gY3Vz
dG9tIHBhdGNoZXMpLiBVbmRlciBwcm9kdWN0aW9uCk5GUyByZWFkIGxvYWQsIDEzIG9mIDE2
IGluc3RhbmNlcyBoaXQgYSBgV0FSTl9PTl9PTkNFYCBpbgpgbmZzX2ZyZWVfcmVxdWVzdCgp
YCBhdCBgZnMvbmZzL3BhZ2VsaXN0LmM6NTg3YC4gVGhlIFdBUk5JTkcgZmlyZXMgaW4KdGhl
IE5GUyByZWFkIGNvbXBsZXRpb24gcGF0aCBhbmQgaW5kaWNhdGVzIHRoYXQgdGhlIGBQR19X
Ql9FTkRgCnBhZ2UtZ3JvdXAgc3luY2hyb25pc2F0aW9uIGZsYWcgaXMgdW5leHBlY3RlZGx5
IHN0aWxsIHNldCB3aGVuIGFuCmBuZnNfcGFnZWAgcmVxdWVzdCBpcyBiZWluZyBmcmVlZC4K
ClRoZSBXQVJOSU5HIGRvZXMgbm90IGNhdXNlIGEgY3Jhc2ggb3IgZGF0YSBjb3JydXB0aW9u
LCBidXQgaXQKcmVwcm9kdWNlcyBjb25zaXN0ZW50bHkgYWNyb3NzIHRoZSBtYWpvcml0eSBv
ZiBpbnN0YW5jZXMgdW5kZXIgbG9hZC4KCiMjIEVudmlyb25tZW50CgotICoqS2VybmVsKio6
IDYuMTkuNCAodmFuaWxsYSBzdGFibGUgZnJvbSBrZXJuZWwub3JnLCBubyBjdXN0b20gcGF0
Y2hlcykKLSAqKkhhcmR3YXJlKio6IEFtYXpvbiBFQzIgaTNlbi42eGxhcmdlIChJbnRlbCBY
ZW9uIDgyNTlDTCwgMjQgdkNQVXMsIDE5MkdCIFJBTSwgMsOXIDcuNVRCIE5WTWUgaW5zdGFu
Y2Ugc3RvcmUpCi0gKipBcmNoaXRlY3R1cmUqKjogTkZTIHJlLWV4cG9ydCBwcm94eSAoc2Vl
IGRpYWdyYW0gYmVsb3cpCi0gKipGUy1DYWNoZSoqOiBFbmFibGVkIHZpYSBgY2FjaGVmaWxl
c2Agb24gWEZTLWZvcm1hdHRlZCBSQUlEMCBvZiBsb2NhbCBOVk1lIChtb3VudGVkIGF0IGAv
dmFyL2NhY2hlL2ZzY2FjaGVgKQoKIyMjIE5GUyBSZS1FeHBvcnQgUHJveHkgQXJjaGl0ZWN0
dXJlCgpUaGUgS05GU0QgcHJveHkgc2l0cyBiZXR3ZWVuIE5GUyBjbGllbnRzIGFuZCBhIHNv
dXJjZSBORlMgZmlsZXIuIEl0IHJlLWV4cG9ydHMgTkZTIG1vdW50cyB3aXRoCkZTLUNhY2hl
IGVuYWJsZWQgdG8gYWNjZWxlcmF0ZSByZXBlYXRlZCByZWFkczoKCmBgYHRleHQKTkZTIENs
aWVudHMg4pSA4pSATkZTdjPilIDilIA+IEtORlNEIFByb3h5IChuZnNkICsgTkZTIGNsaWVu
dCArIGNhY2hlZmlsZXMpIOKUgOKUgE5GU3Yz4pSA4pSAPiBTb3VyY2UgRmlsZXIKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAg4pSCCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIOKUnOKUgOKUgCBuZnNkIHNlcnZlcyBkb3duc3RyZWFtIGNsaWVudHMKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAg4pSc4pSA4pSAIE5GUyBjbGllbnQgbW91bnRzIHNvdXJj
ZSBmaWxlciB3aXRoIGZzYyAoRlMtQ2FjaGUpCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIOKUnOKUgOKUgCBjYWNoZWZpbGVzL25ldGZzIHdyaXRlcyByZWFkIGRhdGEgdG8gbG9j
YWwgWEZTIGNhY2hlCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUlOKUgOKUgCBu
ZnNkIHJlLXJlYWRzIGZyb20gY2FjaGUgb24gc3Vic2VxdWVudCBjbGllbnQgcmVxdWVzdHMK
YGBgCgpUaGlzIG1lYW5zIHRoZSBwcm94eSBydW5zIGJvdGggbmZzZCAoc2VydmVyKSBhbmQg
dGhlIE5GUyBjbGllbnQKc2ltdWx0YW5lb3VzbHksIHdpdGggdGhlIGNhY2hlZmlsZXMvbmV0
ZnMgbGF5ZXIgcGVyZm9ybWluZyB3cml0ZS1iYWNrCm9mIHJlYWQgZGF0YSB0byB0aGUgbG9j
YWwgWEZTLWJhY2tlZCBjYWNoZSB2b2x1bWUuCgojIyBSQ0EKCldoYXQgZm9sbG93cyBpcyBh
IEdlbkFJIGFuYWx5c2lzIG9mIHRoZSBwb3NzaWJsZSByb290IGNhdXNlIG9mIHRoZSBpc3N1
ZS4KCiMjIFN0YWNrIFRyYWNlCgpGcm9tIGluc3RhbmNlIGBpLTBmZDU3NTIxOTI1M2U0Mzg4
YCAocmVwcmVzZW50YXRpdmUgb2YgYWxsIDEzIGFmZmVjdGVkCmluc3RhbmNlcyk6CgpgYGB0
ZXh0CldBUk5JTkc6IGZzL25mcy9wYWdlbGlzdC5jOjU4NyBhdCBuZnNfZnJlZV9yZXF1ZXN0
KzB4MTc1LzB4MWUwIFtuZnNdLCBDUFUjMTA6IGt3b3JrZXIvdTk2OjQ3LzEzMTQxNApNb2R1
bGVzIGxpbmtlZCBpbjogdGxzIHRjcF9kaWFnIHVkcF9kaWFnIGluZXRfZGlhZyBuZnNkIGF1
dGhfcnBjZ3NzIG5mc3YzIG5mc19hY2wgbmZzIGxvY2tkIGdyYWNlIGNhY2hlZmlsZXMgbmV0
ZnMgeGZzIHJhaWQwIC4uLgpDUFU6IDEwIFVJRDogMCBQSUQ6IDEzMTQxNCBDb21tOiBrd29y
a2VyL3U5Njo0NyBUYWludGVkOiBHICAgICAgICAgICBPRSAgICAgICA2LjE5LjQta25mc2Qg
IzEgVk9MVU5UQVJZCkhhcmR3YXJlIG5hbWU6IEFtYXpvbiBFQzIgaTNlbi42eGxhcmdlLywg
QklPUyAxLjAgMTAvMTYvMjAxNwpXb3JrcXVldWU6IG5mc2lvZCBycGNfYXN5bmNfcmVsZWFz
ZSBbc3VucnBjXQpSSVA6IDAwMTA6bmZzX2ZyZWVfcmVxdWVzdCsweDE3NS8weDFlMCBbbmZz
XQpDb2RlOiA0OCA4YiA0MyAzOCA4NCBjMCAwZiA4OSBjZSBmZSBmZiBmZiAwZiAwYiA0OCA4
YiA0MyAzOCBmNiBjNCAwMSAwZiA4NCBjYyBmZSBmZiBmZiAwZiAwYiA0OCA4YiA0MyAzOCBm
NiBjNCAwMiAwZiA4NCBjYSBmZSBmZiBmZiA8MGY+IDBiIDQ4IDhiIDQzIDM4IGY2IGM0IDA0
IDBmIDg0IGM4IGZlIGZmIGZmIDBmIDBiIDQ4IDhiIDQzIDM4IGY2ClJTUDogMDAxODpmZmZm
ZDFkZThhNTIzZDE4IEVGTEFHUzogMDAwMTAyMDIKUkFYOiAwMDAwMDAwMDAwMDAwMjA0IFJC
WDogZmZmZjhhYTgxMTE0NjE4MCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDAKUkRYOiAwMDAwMDAw
MDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IGZmZmY4YWE4MTExNDYxODAK
UkJQOiBmZmZmZDFkZThhNTIzZDI4IFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDAw
MDAwMDAwMDAwMDAKUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDAw
MCBSMTI6IGZmZmY4YWE4MTExNDYxODAKUjEzOiBmZmZmOGFhODExMTQ2MTgwIFIxNDogMDAw
MDAwMDAwMDAwMDAwMSBSMTU6IGZmZmY4YWM0NWFiOGEyOTgKRlM6ICAwMDAwMDAwMDAwMDAw
MDAwKDAwMDApIEdTOmZmZmY4YWQ1YTRiM2MwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAw
MDAwMApDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMz
CkNSMjogMDAwMDczMzkwNzhlZTIwMCBDUjM6IDAwMDAwMDAxNWIyNDQwMDUgQ1I0OiAwMDAw
MDAwMDAwNzcwNmYwClBLUlU6IDU1NTU1NTU0CkNhbGwgVHJhY2U6CiA8VEFTSz4KIG5mc19w
YWdlX2dyb3VwX2Rlc3Ryb3krMHg2NS8weGMwIFtuZnNdCiBuZnNfcGFnZV9ncm91cF9kZXN0
cm95KzB4OWYvMHhjMCBbbmZzXQogbmZzX3JlbGVhc2VfcmVxdWVzdCsweDM2LzB4NjAgW25m
c10KIG5mc19yZWFkcGFnZV9yZWxlYXNlLmlzcmEuMCsweDM3LzB4ODAgW25mc10KIG5mc19y
ZWFkX2NvbXBsZXRpb24rMHg4MC8weDE3MCBbbmZzXQogbmZzX3BnaW9fcmVsZWFzZSsweDE2
LzB4MjAgW25mc10KIHJwY19mcmVlX3Rhc2srMHgzZi8weDgwIFtzdW5ycGNdCiBycGNfYXN5
bmNfcmVsZWFzZSsweDMzLzB4NTAgW3N1bnJwY10KIHByb2Nlc3Nfb25lX3dvcmsrMHgxODIv
MHgzNTAKIHdvcmtlcl90aHJlYWQrMHgxOWEvMHgzMjAKID8gX19wZnhfd29ya2VyX3RocmVh
ZCsweDEwLzB4MTAKIGt0aHJlYWQrMHhmOS8weDIxMAogPyBfX3BmeF9rdGhyZWFkKzB4MTAv
MHgxMAogcmV0X2Zyb21fZm9yaysweDI1Yy8weDI5MAogPyBfX3BmeF9rdGhyZWFkKzB4MTAv
MHgxMAogcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwCiA8L1RBU0s+Ci0tLVsgZW5kIHRy
YWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQpgYGAKCiMjIEFuYWx5c2lzCgojIyMgQ2FsbCBw
YXRoCgpUaGUgV0FSTklORyBvY2N1cnMgaW4gdGhlIE5GUyAqKnJlYWQqKiBjb21wbGV0aW9u
IHBhdGgsIHJ1bm5pbmcgaW4gdGhlCmBuZnNpb2RgIHdvcmtxdWV1ZToKCmBgYHRleHQKcnBj
X2FzeW5jX3JlbGVhc2UKICDihpIgcnBjX2ZyZWVfdGFzawogICAg4oaSIG5mc19wZ2lvX3Jl
bGVhc2UKICAgICAg4oaSIG5mc19yZWFkX2NvbXBsZXRpb24KICAgICAgICDihpIgbmZzX3Jl
YWRwYWdlX3JlbGVhc2UKICAgICAgICAgIOKGkiBuZnNfcmVsZWFzZV9yZXF1ZXN0CiAgICAg
ICAgICAgIOKGkiBrcmVmX3B1dCDihpIgbmZzX3BhZ2VfZ3JvdXBfZGVzdHJveQogICAgICAg
ICAgICAgIOKGkiBuZnNfZnJlZV9yZXF1ZXN0ICAgICAgICDihpAgV0FSTklORyBmaXJlcyBo
ZXJlCmBgYAoKVGhlIGRvdWJsZSBgbmZzX3BhZ2VfZ3JvdXBfZGVzdHJveWAgZW50cnkgaW4g
dGhlIGNhbGwgdHJhY2UgaW5kaWNhdGVzIGEKbXVsdGktbWVtYmVyIHBhZ2UgZ3JvdXA6IGEg
c3VicmVxdWVzdCByZWxlYXNlcyBpdHMgcmVmZXJlbmNlIG9uIHRoZSBoZWFkCnJlcXVlc3Qs
IHRyaWdnZXJpbmcgdGhlIGhlYWQncyBncm91cCBkZXN0cnVjdGlvbiwgd2hpY2ggdGhlbiBj
YWxscwpgbmZzX2ZyZWVfcmVxdWVzdCgpYCBmb3IgZWFjaCBtZW1iZXIgaW4gdGhlIGRvLi53
aGlsZSBsb29wLgoKIyMjIFdoaWNoIFdBUk4gZmlyZXMKClRoZSBgbmZzX2ZyZWVfcmVxdWVz
dCgpYCBmdW5jdGlvbiBjb250YWlucyBzZXZlcmFsIGBXQVJOX09OX09OQ0VgIGRlYnVnCmNo
ZWNrcyB0aGF0IHZlcmlmeSBhbGwgcGFnZS1ncm91cCBzeW5jaHJvbmlzYXRpb24gZmxhZ3Mg
YXJlIGNsZWFyZWQKYmVmb3JlIGZyZWVpbmcgYW4gYG5mc19wYWdlYDoKCmBgYGMKdm9pZCBu
ZnNfZnJlZV9yZXF1ZXN0KHN0cnVjdCBuZnNfcGFnZSAqcmVxKQp7CiAgICBXQVJOX09OX09O
Q0UocmVxLT53Yl90aGlzX3BhZ2UgIT0gcmVxKTsKICAgIFdBUk5fT05fT05DRSh0ZXN0X2Jp
dChQR19URUFSRE9XTiwgJnJlcS0+d2JfZmxhZ3MpKTsKICAgIFdBUk5fT05fT05DRSh0ZXN0
X2JpdChQR19VTkxPQ0tQQUdFLCAmcmVxLT53Yl9mbGFncykpOwogICAgV0FSTl9PTl9PTkNF
KHRlc3RfYml0KFBHX1VQVE9EQVRFLCAmcmVxLT53Yl9mbGFncykpOwogICAgV0FSTl9PTl9P
TkNFKHRlc3RfYml0KFBHX1dCX0VORCwgJnJlcS0+d2JfZmxhZ3MpKTsgICAgIC8qIOKGkCB0
aGlzIG9uZSAqLwogICAgV0FSTl9PTl9PTkNFKHRlc3RfYml0KFBHX1JFTU9WRSwgJnJlcS0+
d2JfZmxhZ3MpKTsKICAgIC4uLgp9CmBgYAoKRGlzYXNzZW1ibHkgb2YgdGhlIGBDb2RlOmAg
ZHVtcCBjb25maXJtcyB0aGUgZmF1bHRpbmcgYDwwZj4gMGJgICh1ZDIpCmNvcnJlc3BvbmRz
IHRvIHRoZSBgdGVzdCBhaCwgMHgwMmAgaW5zdHJ1Y3Rpb24sIHdoaWNoIHRlc3RzIGJpdCA5
IG9mCmB3Yl9mbGFnc2Ag4oCUIGkuZS4gYFBHX1dCX0VORGAuCgojIyMgVGhlIHN0YWxlIGZs
YWcKClJBWCBjb250YWlucyBgd2JfZmxhZ3NgIGF0IHRoZSBwb2ludCBvZiB0aGUgV0FSTi4g
QWNyb3NzIHRoZSAxMwphZmZlY3RlZCBpbnN0YW5jZXMsIHR3byB2YWx1ZXMgYXJlIG9ic2Vy
dmVkOgoKLSBgUkFYPTB4MjA0YCDihpIgYFBHX0NMRUFOKDIpYCArIGBQR19XQl9FTkQoOSlg
IOKAlCBvYnNlcnZlZCBvbiAxMCBpbnN0YW5jZXMKLSBgUkFYPTB4MjA1YCDihpIgYFBHX0JV
U1koMClgICsgYFBHX0NMRUFOKDIpYCArIGBQR19XQl9FTkQoOSlgIOKAlCBvYnNlcnZlZCBv
biAzIGluc3RhbmNlcwoKQm90aCB2YWx1ZXMgaGF2ZSBgUEdfV0JfRU5EYCAoYml0IDkpIHNl
dC4gVGhlIGRpZmZlcmVuY2UgaXMgd2hldGhlcgpgUEdfQlVTWWAgKHRoZSByZXF1ZXN0IGxv
Y2sgYml0KSBoYXMgYmVlbiBjbGVhcmVkIHlldCDigJQgcmVmbGVjdGluZyB0d28Kc2xpZ2h0
bHkgZGlmZmVyZW50IHRpbWluZyBzbmFwc2hvdHMgb2YgdGhlIHNhbWUgcmFjZS4KCiMjIyBX
aHkgUEdfV0JfRU5EIHNob3VsZCBub3QgYmUgc2V0IGhlcmU/CgpgUEdfV0JfRU5EYCBpcyBh
IHBhZ2UtZ3JvdXAgc3luY2hyb25pc2F0aW9uIGZsYWcgdXNlZCB2aWEKYG5mc19wYWdlX2dy
b3VwX3N5bmNfb25fYml0KHJlcSwgUEdfV0JfRU5EKWAgaW4gYG5mc193cml0ZV9jb21wbGV0
aW9uKClgCih0aGUgd3JpdGUgcGF0aCkuIEluIHRoZSBub3JtYWwgcmVhZCBwYXRoLCBgUEdf
V0JfRU5EYCBzaG91bGQgbmV2ZXIgYmUKc2V0LiBUaGUgcmVhZCBwYXRoIHVzZXMgYFBHX1VQ
VE9EQVRFYCAodmlhIGBuZnNfcGFnZV9ncm91cF9zZXRfdXB0b2RhdGUoKWApCmFuZCBgUEdf
VU5MT0NLUEFHRWAgKHZpYSBgbmZzX3JlYWRwYWdlX3JlbGVhc2UoKWApLCBidXQgbm90IGBQ
R19XQl9FTkRgLgoKSSBzdXNwZWN0IHRoZSBjYWNoZWZpbGVzL25ldGZzIGludGVncmF0aW9u
IG1heSBiZSBpbnZvbHZlZD8gSW4gdGhlCnJlLWV4cG9ydCBwcm94eSBjb25maWd1cmF0aW9u
LCB3aGVuIHRoZSBORlMgY2xpZW50IHJlYWRzIGZyb20gdGhlIHNvdXJjZQpmaWxlciB3aXRo
IEZTLUNhY2hlIGVuYWJsZWQsIHRoZSBuZXRmcyBsYXllciBhbHNvIHdyaXRlcyB0aGUgcmVh
ZCBkYXRhCnRvIHRoZSBjYWNoZWZpbGVzIGJhY2tpbmcgc3RvcmUuIFRoaXMgY3JlYXRlcyBh
IGh5YnJpZCByZWFkK3dyaXRlCmxpZmVjeWNsZSBmb3IgdGhlIHBhZ2VzIGludm9sdmVkLiBJ
dCBpcyBwb3NzaWJsZSB0aGF0IHRoZSBjYWNoZQp3cml0ZS1iYWNrIHBhdGggc2V0cyBgUEdf
V0JfRU5EYCBvbiBwYWdlIGdyb3VwIG1lbWJlcnMgZHVyaW5nIHdoYXQgdGhlCk5GUyBjbGll
bnQgY29uc2lkZXJzIGEgcmVhZCBvcGVyYXRpb24sIGFuZCB0aGUgZmxhZyBpcyBub3QgcHJv
cGVybHkKY2xlYXJlZCBiZWZvcmUgdGhlIHJlYWQgY29tcGxldGlvbiB0ZWFycyBkb3duIHRo
ZSBwYWdlIGdyb3VwLgoKIyMgUGF0dGVybiBBY3Jvc3MgSW5zdGFuY2VzCgojIyMgSGl0IHJh
dGUKCjEzIG9mIDE2IGluc3RhbmNlcyAoODElKSBoaXQgdGhlIFdBUk5JTkcuIEFsbCBpbnN0
YW5jZXMgcnVuIHRoZSBzYW1lCmtlcm5lbCwgc2FtZSBjb25maWd1cmF0aW9uLCBhbmQgc2Vy
dmUgdGhlIHNhbWUgdHlwZSBvZiBORlMgcmUtZXhwb3J0Cndvcmtsb2FkLgoKIyMjIFRpbWlu
ZwoKVGhlIDEzIHdhcm5pbmdzIGFyZSBzcHJlYWQgb3ZlciBhcHByb3hpbWF0ZWx5IDUuNSBo
b3VycyBvbiB0aGUgc2FtZSBkYXksCndpdGggbm8gdHdvIGluc3RhbmNlcyBmaXJpbmcgYXQg
dGhlIHNhbWUgdGltZS4gVGhpcyBpcyBjb25zaXN0ZW50IHdpdGgKYSByYWNlIGNvbmRpdGlv
biB0aGF0IHRyaWdnZXJzIGluZGVwZW5kZW50bHkgdW5kZXIgbG9hZDoKCmBgYHRleHQKMTI6
MDgg4oCUIGktMGQ5ZGIyMjJjNTZiMTQ4ZDEKMTM6MjEg4oCUIGktMDU2MWUxODlhMDZjNWEy
ODgKMTM6Mzkg4oCUIGktMGM3ZGNhYWU0MDBjMjM5MmMKMTM6NTIg4oCUIGktMDRjNDI4ZTQw
YWZkNjRjYTMKMTU6MTMg4oCUIGktMGYwMzI3NDcxMzQ2MDNlN2IKMTU6Mjgg4oCUIGktMGU5
ZDc5MDk2ODk1NzkzMzIKMTU6MzIg4oCUIGktMDRkMmUxNTcyYTAzYjQ3MWIKMTY6MDEg4oCU
IGktMGUzZTkzYTNjODM2N2MyN2QKMTY6Mjkg4oCUIGktMGZkNTc1MjE5MjUzZTQzODgKMTY6
NTgg4oCUIGktMDFiMWVkNDRhYmZkNTJjZjUKMTc6MTIg4oCUIGktMDJlZjg3ODA2MmQ0ZjVm
ODYKMTc6MTgg4oCUIGktMGVjY2IyNjRjYzkwZWI3MzcKMTc6MzYg4oCUIGktMDY0YzY0OWVh
YWYxOTZhZTcKYGBgCgojIyMgQ2FsbCB0cmFjZSB2YXJpYW50cwoKVHdvIHZhcmlhbnRzIGFy
ZSBvYnNlcnZlZDoKCioqVmFyaWFudCBBKiogKDggaW5zdGFuY2VzKSDigJQgcmVjdXJzaXZl
IHBhZ2UgZ3JvdXAgZGVzdHJveSAobXVsdGktbWVtYmVyCnBhZ2UgZ3JvdXAgd2hlcmUgc3Vi
cmVxdWVzdCByZWxlYXNlcyB0aGUgaGVhZCk6CgpgYGB0ZXh0Cm5mc19wYWdlX2dyb3VwX2Rl
c3Ryb3krMHg2NS8weGMwICAg4oaQIG5mc19mcmVlX3JlcXVlc3QodG1wKSBpbiBkby4ud2hp
bGUKbmZzX3BhZ2VfZ3JvdXBfZGVzdHJveSsweDlmLzB4YzAgICDihpAgbmZzX3JlbGVhc2Vf
cmVxdWVzdChoZWFkKSBhdCBlbmQKbmZzX3JlbGVhc2VfcmVxdWVzdCsweDM2LzB4NjAKbmZz
X3JlYWRwYWdlX3JlbGVhc2UKYGBgCgoqKlZhcmlhbnQgQioqICg1IGluc3RhbmNlcykg4oCU
IGRpcmVjdCwgbm9uLXJlY3Vyc2l2ZSAoc2luZ2xlLW1lbWJlciBwYWdlCmdyb3VwIG9yIGhl
YWQgaXMgdGhlIG9ubHkgcmVtYWluaW5nIG1lbWJlcik6CgpgYGB0ZXh0Cm5mc19wYWdlX2dy
b3VwX2Rlc3Ryb3krMHg2NS8weGMwICAg4oaQIG5mc19mcmVlX3JlcXVlc3QodG1wKQpuZnNf
cmVsZWFzZV9yZXF1ZXN0KzB4MzYvMHg2MApuZnNfcmVhZHBhZ2VfcmVsZWFzZQpgYGAKCkJv
dGggdmFyaWFudHMgZW5kIGF0IHRoZSBzYW1lIGBuZnNfZnJlZV9yZXF1ZXN0YCB3aXRoIGBQ
R19XQl9FTkRgIHNldC4KCiMjIFJlcHJvZHVjdGlvbgoKVGhpcyBpcyByZXByb2R1Y2libGUg
dW5kZXIgc3VzdGFpbmVkIE5GUyByZWFkIGxvYWQgdGhyb3VnaCB0aGUgcHJveHkKd2l0aCBG
Uy1DYWNoZSAoY2FjaGVmaWxlcykgZW5hYmxlZC4gVGhlIHdvcmtsb2FkIGludm9sdmVzIG11
bHRpcGxlIE5GUwpjbGllbnRzIHBlcmZvcm1pbmcgY29uY3VycmVudCByZWFkcyB0aHJvdWdo
IHRoZSBLTkZTRCByZS1leHBvcnQgcHJveHksCnRyaWdnZXJpbmcgY29sZC1jYWNoZSBmaWxs
cyB3aGVyZSB0aGUgTkZTIGNsaWVudCByZWFkcyBmcm9tIHRoZSBzb3VyY2UKZmlsZXIgYW5k
IGNhY2hlZmlsZXMgd3JpdGVzIHRoZSBkYXRhIHRvIHRoZSBsb2NhbCBYRlMgY2FjaGUuCgpT
aW5jZSBgV0FSTl9PTl9PTkNFYCBvbmx5IGZpcmVzIG9uY2UgcGVyIGJvb3QsIHRoZSBhY3R1
YWwgZnJlcXVlbmN5IG9mCnRoZSByYWNlIGNvbmRpdGlvbiBpcyBsaWtlbHkgaGlnaGVyIHRo
YW4gd2hhdCB0aGUgbG9ncyBzaG93LgoKIyMgUmVwcm9kdWNlcgoKU29tZXdoYXQgZXhjZXNz
aXZlLCBidXQgdXNpbmcgMiBGSU8gam9icywgcnVubmluZyBvbiAxMCB4IG1hY2hpbmVzLCBt
b3VudGluZyBhIHNpbmdsZSBLTkZTRCBwcm94eSBpbnN0YW5jZSwgd2hpY2loIGluLXR1cm4g
bW91bnRzIGEgc2luZ2xlLCBzb3VyY2UgTkZTIGZpbGVyLCBJIGNhbiAxMDAlIHJlcHJvZHVj
ZSB0aGUgaXNzdWUsIHVzaW5nIGBzdHJlc3MtbmdgIHRvIHNpbXVsYXRlIHByb2R1Y3Rpb24g
bG9hZC4gMXN0IEZJTyBqb2IgY3JlYXRlcyB0aGUgZmlsZXMsIDJuZCBGSU8gam9iIHJlYWRz
IHRoZSBmaWxlcy4gU291cmNlIGRhdGEgaXMgNi40VEIgb2YgcmFuZG9tIGRhdGEuIFRoZSBG
SU8gMm5kIGpvYiBydW5zIGZvciA2MCBtaW51dGVzLCBidXQgdGhpcyBpc3N1ZSB3aWxsIHN1
cmZhY2UgbXVjaCBzb29uZXIuCgoqKkZJTyBqb2IgMToqKgoKYGBgdGV4dApbd2FybmluZy1s
b2ctbWVzc2FnZV0KaW9lbmdpbmU9c3luYwpkaXJlY3Q9MApydz13cml0ZQpkaXJlY3Rvcnk9
L21udC9kYXRhCnVuaXF1ZV9maWxlbmFtZT0wCmJzPTFNCnNpemU9MTBHCm51bWpvYnM9NjQK
YGBgCgoqKkZJTyBqb2IgMjoqKgoKYGBgdGV4dApbd2FybmluZy1sb2ctbWVzc2FnZV0KaW9l
bmdpbmU9cG9zaXhhaW8KZGlyZWN0PTAKdGltZV9iYXNlZAphbGxvd19maWxlX2NyZWF0ZT0w
CmRpcmVjdG9yeT0vbW50L2RhdGEKdW5pcXVlX2ZpbGVuYW1lPTAKYnM9MU0Kcnc9cmFuZHJl
YWQKc2l6ZT0xMEcKbnVtam9icz02NApydW50aW1lPTYwbQpub3JhbmRvbW1hcApgYGAKCkFk
ZGl0aW9uYWxseSwgcnVuIHRoaXMgY29tbWFuZCBvbiBhIEtORlNEIHByb3h5IGluc3RhbmNl
IHdoaWxzdCB0aGUgMm5kIEZJTyBqb2IgaXMgcnVubmluZyB0byBzdHJhaW4gdGhlIHN5c3Rl
bSBtZW1vcnk6CgpgYGBiYXNoCnN1ZG8gc3RyZXNzLW5nIC0tdm0gOCAtLXZtLWJ5dGVzIDk1
JSAtLXZtLW1ldGhvZCBhbGwgLS10aW1lb3V0IDYwbSAtLW9vbS1hdm9pZApgYGAKCiMjIFF1
ZXN0aW9ucwoKMS4gSXMgdGhpcyBhIGtub3duIGlzc3VlIGluIHRoZSBORlMgcGFnZS1ncm91
cCBzeW5jaHJvbmlzYXRpb24gY29kZQogICB3aGVuIEZTLUNhY2hlL2NhY2hlZmlsZXMgaXMg
YWN0aXZlPwoKMi4gQ291bGQgdGhlIG5ldGZzL2NhY2hlZmlsZXMgd3JpdGUtYmFjayBwYXRo
ICh3cml0aW5nIHJlYWQgZGF0YSB0bwogICB0aGUgY2FjaGUpIGluYWR2ZXJ0ZW50bHkgc2V0
IGBQR19XQl9FTkRgIG9uIGBuZnNfcGFnZWAgc3RydWN0dXJlcwogICBkdXJpbmcgYSByZWFk
IG9wZXJhdGlvbj8KCjMuIElzIHRoaXMgc3BlY2lmaWMgdG8gdGhlIHJlLWV4cG9ydCAobmZz
ZCArIE5GUyBjbGllbnQgb24gc2FtZSBob3N0KQogICBjb25maWd1cmF0aW9uLCBvciBjb3Vs
ZCBpdCBhZmZlY3QgYW55IE5GUyBjbGllbnQgd2l0aCBGUy1DYWNoZQogICBlbmFibGVkPwoK
QW55IGd1aWRhbmNlIG9yIHBhdGNoZXMgdG8gYWRkcmVzcyB0aGlzIHdvdWxkIGJlIGdyZWF0
bHkgYXBwcmVjaWF0ZWQuCgpUaGFuayB5b3UgZm9yIHJlYWRpbmcuCg==

--------------5tTvaaAnR050Px7Fm80EnnAT--

