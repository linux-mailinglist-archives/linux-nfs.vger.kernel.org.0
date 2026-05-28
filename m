Return-Path: <linux-nfs+bounces-22038-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ikvjL691GGpSkQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22038-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:04:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D65F5607
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89D5F304AB58
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD06A3F88A8;
	Thu, 28 May 2026 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="NaGhsXDT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CE3F86FA
	for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987234; cv=pass; b=HYCPt0s9vY8Gq6J2uQxTwW0OdPAMaIqQA94orud8Eqt+5GyR2/qhbr5zmlu/Ueq03EXLY2Miu6crHGdrqLznqLB4t7XknIk8CgPmccGPW7brFa8RvT02GoLjGKXIyioULLvFJ3vAkUVlVeezWVKGDkOHy0APQsDFhjPraljyI5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987234; c=relaxed/simple;
	bh=4GHTDPgbrpo+Yf6s7MYf+h2FmBUr6lbrIripbw371OU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IfuuQ6H4YgLottFfGUYVrgWzAe7tiFi18UF/QXyIsI32fKBixzC6RODB8seFRVbUTN2LufSgBRoR3PPxjguGoCWAw6JLZ9h+o5L0MDoH0FckOmZVexbgLCreV9WmlitNpfrMchP0m3MeLE+w4Jd28w8JqYH4Li9jCPRKUP7HUK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=NaGhsXDT; arc=pass smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7bf0b47d2f1so115976097b3.3
        for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 09:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779987232; cv=none;
        d=google.com; s=arc-20240605;
        b=MQ3TOjhkTPy/tgVKGNGoFiIwkVTAUx36vdZ9YXvNqsNysgPGwmagZfdHK708lDV/aF
         Y5LaDM6CfvTylnhtMxC7290reTQ32oQDEnaVFCCHZTvCXnZLgoImJ4ZWYELb26r5/HIv
         DFsmWal2onrmu/V/b66pppaOs2Ne9LVpxr5Ebi6cb6EZC40NLyEUwtXBv8OMYZnKphCq
         fLw5I16V0wEgRQ0uq8dyeAjeWEYGgaUNj/ro9quVwn49yme33wuq4/g3A87kL7/6OIrp
         4ckyaUMCFgFvJEYWN7gvl6baPR9AejPd8y1KgUKVd4wfToT5D2Vx67SCBJGHfzkUf+lt
         ktOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Ws5bpGHE5Ime2b6pfYVsUeynLJFhwDioZNstCv439lA=;
        fh=1CCNABhVWZI3jadvhByGli28HRthom04JTGPBAVmtv4=;
        b=Rly4uK6Zni6YhDDCZ+S9HVNHvB3fLcJXsEnua2fFBH9etvHXQAJzXaHgAAOpMBkGyX
         icDnLQqbqwodBeHPOemFK17zqD7EGejDYGLRi2BvK0EiWc5kjTr+dOntduOn5QuoOCta
         95fxj6wk2d1Y2CDf8BDi2ewNHGi48BV/P6d8UlG0YpusLmiUTtzS1J+H5ZH61BMjGFEU
         nQTQuo3Jo6wIgatxAo35R/CZRvjaMKxRh+ztaGaN5sY3C2Q3qdHkcWQHfZSVaT6leU7x
         xER/B6wOgbtLQM4KcNnAtmot1Kg0l1f5FjnNUBlNAq7gKJS4eg5EKvL3MKistdDgzZhE
         q8WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1779987232; x=1780592032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ws5bpGHE5Ime2b6pfYVsUeynLJFhwDioZNstCv439lA=;
        b=NaGhsXDTU2cq4tLRKS5AZrQsnt6OISIkdXrRuAt53oSSEJ+0h+cSygNpujPXcsxyJS
         S9HRmRQboYeFCWtsFrsePiqhaIXSOG+O+m9g5Q6PTEmB7GAIyYWifKjhMdOxq9cA3TwP
         cKp6lrfLgAPjl5b9hgVhgxOCYX5w/jmp7xErpf7K2w/PduLgRf0Ahp+eDMaYHs7qlHI3
         VhQ2H6L17Pk6Tkzk8kLJSJ3YI9ib+9FMCm+q2cSX9KYc5xQ7ytHfVCjszpffgUpWFx8x
         fZ1qSrJ8FPKYst+h6OwlBvDEpXrp0E/E7rEBiWAV6KQ1MEev2iof7PPZGqMJ3YY7Gz8F
         +Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779987232; x=1780592032;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws5bpGHE5Ime2b6pfYVsUeynLJFhwDioZNstCv439lA=;
        b=bHhQ2TNxYepq8cYOY+d4z8/dT18rtuvyoARY/XKhfq51sfowrYkCgiDiVa5Z0s7Go9
         IE6QbZ/eHq3HXo5sOadB0Gn1Oqx1DrTeWNeOm9bwb/Jm1BBEKS5w51zy0Jpu6nEcl+qh
         gOHskJMY6IP4WEToCtlbjHVhj0hgtoznKXjxzJpZh5sSEMyEm+gvm9YN6WwYoXpZhK9E
         Zbd6W5Ha09ebb9YKhxGa/RHohBUFJ0xso2eiGYF9r+SB7jv08N64r1pfYrPEQxSUse7F
         faxsWmNPVr/W4xlblFdUgV9l5TmfIrEF2sTaTN3yhf4lLy+GOEvuNIQ9ldaIEYtaWJgD
         q8Ag==
X-Forwarded-Encrypted: i=1; AFNElJ8lvUeRaiuVfpCLn0VZpNRzUvGbdBu0a2rH+IUKY83cNebLb3ZbMB8Gyer43JnxLo1j6k2xoJS6c7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws85aZTwB5C3LmpeRq+TQeWhDGZcSUeGz+4ncXJIC66mWiHbYr
	p6NImdC1Qk0mnzQctb03EHqEz7nsCaAaXjbivuNectb5Sv7xKp8XR/Zabt53gR6jGC+HXloz1tE
	sWyEyPk19IntsBBxg+zVWCkilZXMXTT4MCeSqrpGmnRvSu0oZDZnEZYqEigOs/A==
X-Gm-Gg: Acq92OGb+/RIoeksiD7YLghMypiDwuIzYAG2UqiJ+hl9TteJyMLCZHwMTHXSP8ev3mV
	3VEgT5PPA+ZDPh6drgvVhiGYdFXucEVoeKTkG7Pc85mUxOUCzBDyW+/k4c00vgyeH6UFR2uAI/h
	Pk5RTvscWJabyCttd19xTbTWOk/uWiHUkDkQd5KAK4aoMsU8+ur2HGiQ9ra25DbtYyRZn4j/ezw
	pnvRpSSvDSRSLE4SKiutffCsGd7Frf3o9vpnXnvoxyJyCGmarf439USQkCkZUoIxE76sDMRuccV
	BlloL15r0y6qioRJ31uD7So8Kwdo
X-Received: by 2002:a05:690c:a92:b0:7ba:154:87d1 with SMTP id
 00721157ae682-7d33a6655b5mr290208097b3.33.1779987230378; Thu, 28 May 2026
 09:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Thu, 28 May 2026 09:53:37 -0700
X-Gm-Features: AVHnY4JNhfQ2xIEcDILz5z5mvekzGb93i9jsfPzgsB7QrrenhcuDaWqnFM3k8qw
Message-ID: <CA+0ovCgab7F-y5ev3jz+4dDOv_e9XyVNb0GUJpWvVjOLiUeZPg@mail.gmail.com>
Subject: [BUG] sunrpc: cache_seq_start_rcu() slab-out-of-bounds (unpriv-userns reachable)
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000093e0e80652e39266"
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[berkeley.edu,reject];
	R_DKIM_ALLOW(-0.20)[berkeley.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22038-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[berkeley.edu:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[farhad.alemi@berkeley.edu,linux-nfs@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6D5D65F5607
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000093e0e80652e39266
Content-Type: text/plain; charset="UTF-8"

Hello Chuck and the linux-nfs team,

I am reporting a sunrpc cache slab-out-of-bounds read found by syzkaller.
Flagging up front because the read site is reachable from an unprivileged
user via unshare(CLONE_NEWUSER|CLONE_NEWNET) on distros that enable
unprivileged user-namespace creation by default.

Summary:
A read(2) on any sunrpc-cache seq_file (e.g. the nfsd virtual
filesystem's /exports, or /proc/net/rpc/<cache>/content) drives
cache_seq_start_rcu() -> __cache_seq_start() at net/sunrpc/cache.c:1351.
After the iterator walks all hash buckets, __cache_seq_start writes back
*pos = ((long long)cd->hash_size << 32) + 1 (the literal final-line
assignment in the function). The next read re-enters __cache_seq_start
with that *pos, decodes hash = cd->hash_size, and the very first
hlist_for_each_entry_rcu() walks &cd->hash_table[hash] one element past
the array end. The existing "while (!ch && ++hash < cd->hash_size)"
check only guards later iterations within the function, not the entry
hlist_for_each_entry_rcu().

The KASAN-reported 2K allocation is cd->hash_table allocated by
kzalloc_objs(struct hlist_head, cd->hash_size) in cache_create_net() at
net/sunrpc/cache.c:1733; struct cache_detail itself is a separate,
smaller kmemdup at line 1729. The 8-byte OOB read at the right edge of
the 2048-byte region reads hash_table[cd->hash_size] -- one struct
hlist_head past the end of the table.

Observed on:
- Linux v7.1-rc3-200-g70eda68668d1-dirty, x86_64, QEMU Q35
- KASAN enabled; panic_on_warn set
- The only local dirty file in my tree is drivers/tty/serial/serial_core.c,
  containing a local ttyS0 console guard for the fuzzing harness. It is
  unrelated to net/sunrpc/.
- __cache_seq_start() at net/sunrpc/cache.c:1351 still walks
  &cd->hash_table[hash] without bounding the decoded hash against
  cd->hash_size before the first iteration; bug remains reachable on
  current mainline.

Impact:
A user with CAP_SYS_ADMIN to mount(2) the nfsd virtual filesystem can
drive a slab-out-of-bounds read by performing a sequence of read(2)s on
/<mountpoint>/exports (or, by symmetry, on /proc/net/rpc/<cache>/content
for any sunrpc-cache populated in the netns) -- the seq_file iterator
exhausts the cache, *pos is rewritten to encode hash = cd->hash_size,
and the trailing read OOBs:

  BUG: KASAN: slab-out-of-bounds in __cache_seq_start
net/sunrpc/cache.c:1351 [inline]
  BUG: KASAN: slab-out-of-bounds in cache_seq_start_rcu+0x18d/0x3a0
net/sunrpc/cache.c:1399
  Read of size 8 at addr ffff88811ac34800 by task syz.2.17/3610

  The buggy address is located 0 bytes to the right of
  allocated 2048-byte region [ffff88811ac34000, ffff88811ac34800)

Allocator (cache_detail->hash_table birth):

  __kmalloc_noprof+0x361/0x760 mm/slub.c:5307
  kzalloc_noprof include/linux/slab.h:1188 [inline]
  cache_create_net+0x9d/0x230 net/sunrpc/cache.c:1733
  nfsd_export_init+0x5e/0x1f0 fs/nfsd/export.c:1536
  nfsd_net_init+0x55/0x4b0 fs/nfsd/nfsctl.c:2209
  ops_init+0x361/0x5d0 net/core/net_namespace.c:137
  setup_net+0x11d/0x350 net/core/net_namespace.c:446
  copy_net_ns+0x3e7/0x570 net/core/net_namespace.c:579
  create_new_namespaces+0x3ec/0x6a0 kernel/nsproxy.c:132
  unshare_nsproxy_namespaces+0x14e/0x1a0 kernel/nsproxy.c:234
  ksys_unshare+0x582/0x9f0 kernel/fork.c:3243
  __x64_sys_unshare+0x3d/0x50 kernel/fork.c:3315

Crash path (read on /proc/net/rpc/<cache>/content):

  __cache_seq_start net/sunrpc/cache.c:1351 [inline]
  cache_seq_start_rcu+0x18d/0x3a0 net/sunrpc/cache.c:1399
  seq_read_iter+0x3fc/0xe20 fs/seq_file.c:226
  seq_read+0x36c/0x490 fs/seq_file.c:163
  vfs_read+0x211/0xa70 fs/read_write.c:572
  ksys_read+0x155/0x270 fs/read_write.c:717

Expected behavior:
__cache_seq_start() should bound the decoded "hash" index against
cd->hash_size before the first hlist_for_each_entry_rcu(). Today the
function does `hash = n >> 32` then directly indexes &cd->hash_table[hash]
with no bounds check; clamping or rejecting hash >= cd->hash_size at the
entry of the function fixes the OOB.

Threat model:
On distros with default user.max_user_namespaces > 0, an unprivileged
user can unshare(CLONE_NEWUSER|CLONE_NEWNET) to enter a user namespace
where they hold CAP_SYS_ADMIN of the new netns. nfsd_net_init() runs for
the new netns and populates the sunrpc caches; the same mount(2) of
"nfsd" + read sequence then reaches the OOB without real CAP_SYS_ADMIN
on the initial namespace.

The attached reproducer takes the simpler initial-namespace path: it
mounts the nfsd virtual filesystem as root and reads /<mountpoint>/exports
through enough reads (lseek + readv + read in the syz-generated C) to
let the seq_file iterator advance *pos past the last hash bucket, after
which the trailing read trips the OOB. The reproducer does not
explicitly invoke unshare(). I am happy to rebuild a
CLONE_NEWUSER+CLONE_NEWNET-only variant if that demonstration would
help.

Reproducer:
I attached the generated C reproducer as reproducer.c. I also attached the
syzkaller program as reproducer.syz and the console report as
crash-report.txt.

Novelty check:
I searched syzbot dashboard data across upstream, fixed, invalid, stable,
and Android namespaces, and searched lore.kernel.org for
"cache_seq_start_rcu", "__cache_seq_start", and the broader
"slab-out-of-bounds" + "sunrpc". I did not find an exact match.
CVE-2023-52623 (sunrpc cache suspicious RCU usage) is a different bug.


I appreciate your time and consideration, and I'm grateful for your
work on this subsystem.

Regards,
Farhad

--00000000000093e0e80652e39266
Content-Type: text/plain; charset="US-ASCII"; name="crash-report.txt"
Content-Disposition: attachment; filename="crash-report.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mppq0ir80>
X-Attachment-Id: f_mppq0ir80

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CkJVRzogS0FTQU46IHNsYWItb3V0LW9mLWJvdW5kcyBpbiBfX2NhY2hlX3NlcV9z
dGFydCBuZXQvc3VucnBjL2NhY2hlLmM6MTM1MSBbaW5saW5lXQpCVUc6IEtBU0FOOiBzbGFiLW91
dC1vZi1ib3VuZHMgaW4gY2FjaGVfc2VxX3N0YXJ0X3JjdSsweDE4ZC8weDNhMCBuZXQvc3VucnBj
L2NhY2hlLmM6MTM5OQpSZWFkIG9mIHNpemUgOCBhdCBhZGRyIGZmZmY4ODgxMWFjMzQ4MDAgYnkg
dGFzayBzeXouMi4xNy8zNjEwCgpDUFU6IDEgVUlEOiAwIFBJRDogMzYxMCBDb21tOiBzeXouMi4x
NyBOb3QgdGFpbnRlZCA3LjEuMC1yYzMtMDAyMDAtZzcwZWRhNjg2NjhkMS1kaXJ0eSAjMSBQUkVF
TVBUKGZ1bGwpIApIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAy
MDA5KSwgQklPUyAxLjE2LjMtZGViaWFuLTEuMTYuMy0yIDA0LzAxLzIwMTQKQ2FsbCBUcmFjZToK
IDxUQVNLPgogZHVtcF9zdGFja19sdmwrMHhlOC8weDE1MCBsaWIvZHVtcF9zdGFjay5jOjEyMAog
cHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbisweDU1LzB4MWUwIG1tL2thc2FuL3JlcG9ydC5jOjM3
OAogcHJpbnRfcmVwb3J0KzB4NTgvMHg3MCBtbS9rYXNhbi9yZXBvcnQuYzo0ODIKIGthc2FuX3Jl
cG9ydCsweDExNy8weDE1MCBtbS9rYXNhbi9yZXBvcnQuYzo1OTUKIF9fY2FjaGVfc2VxX3N0YXJ0
IG5ldC9zdW5ycGMvY2FjaGUuYzoxMzUxIFtpbmxpbmVdCiBjYWNoZV9zZXFfc3RhcnRfcmN1KzB4
MThkLzB4M2EwIG5ldC9zdW5ycGMvY2FjaGUuYzoxMzk5CiBzZXFfcmVhZF9pdGVyKzB4M2ZjLzB4
ZTIwIGZzL3NlcV9maWxlLmM6MjI2CiBzZXFfcmVhZCsweDM2Yy8weDQ5MCBmcy9zZXFfZmlsZS5j
OjE2MwogdmZzX3JlYWQrMHgyMTEvMHhhNzAgZnMvcmVhZF93cml0ZS5jOjU3Mgoga3N5c19yZWFk
KzB4MTU1LzB4MjcwIGZzL3JlYWRfd3JpdGUuYzo3MTcKIGRvX3N5c2NhbGxfeDY0IGFyY2gveDg2
L2VudHJ5L3N5c2NhbGxfNjQuYzo2MyBbaW5saW5lXQogZG9fc3lzY2FsbF82NCsweDE1Zi8weDU2
MCBhcmNoL3g4Ni9lbnRyeS9zeXNjYWxsXzY0LmM6OTQKIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDc3LzB4N2YKUklQOiAwMDMzOjB4N2Y4OTIxOTk3NzhkCkNvZGU6IGZmIGMzIDY2
IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDkwIGYzIDBmIDFlIGZhIDQ4IDg5IGY4IDQ4IDg5
IGY3IDQ4IDg5IGQ2IDQ4IDg5IGNhIDRkIDg5IGMyIDRkIDg5IGM4IDRjIDhiIDRjIDI0IDA4IDBm
IDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggYzcgYzEgYjAgZmYgZmYgZmYgZjcg
ZDggNjQgODkgMDEgNDgKUlNQOiAwMDJiOjAwMDA3ZmZlOTQ4ODczMjggRUZMQUdTOiAwMDAwMDI0
NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAwMApSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAw
MDAwN2Y4OTIxYzI1ZmEwIFJDWDogMDAwMDdmODkyMTk5Nzc4ZApSRFg6IDAwMDAwMDAwMDAwMDIw
MjAgUlNJOiAwMDAwMjAwMDAwMDAzZjAwIFJESTogMDAwMDAwMDAwMDAwMDAwMwpSQlA6IDAwMDA3
Zjg5MjFhM2ViM2QgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApS
MTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDAw
MDAwMDAwMApSMTM6IDAwMDA3Zjg5MjFjMjVmYTAgUjE0OiAwMDAwN2Y4OTIxYzI1ZmEwIFIxNTog
MDAwMDAwMDAwMDAwMTRmZgogPC9UQVNLPgoKQWxsb2NhdGVkIGJ5IHRhc2sgMzI0NDoKIGthc2Fu
X3NhdmVfc3RhY2sgbW0va2FzYW4vY29tbW9uLmM6NTcgW2lubGluZV0KIGthc2FuX3NhdmVfdHJh
Y2srMHgzZS8weDgwIG1tL2thc2FuL2NvbW1vbi5jOjc4CiBwb2lzb25fa21hbGxvY19yZWR6b25l
IG1tL2thc2FuL2NvbW1vbi5jOjM5OCBbaW5saW5lXQogX19rYXNhbl9rbWFsbG9jKzB4OTMvMHhi
MCBtbS9rYXNhbi9jb21tb24uYzo0MTUKIGthc2FuX2ttYWxsb2MgaW5jbHVkZS9saW51eC9rYXNh
bi5oOjI2MyBbaW5saW5lXQogX19kb19rbWFsbG9jX25vZGUgbW0vc2x1Yi5jOjUyOTUgW2lubGlu
ZV0KIF9fa21hbGxvY19ub3Byb2YrMHgzNjEvMHg3NjAgbW0vc2x1Yi5jOjUzMDcKIGttYWxsb2Nf
bm9wcm9mIGluY2x1ZGUvbGludXgvc2xhYi5oOjk1NCBbaW5saW5lXQoga3phbGxvY19ub3Byb2Yg
aW5jbHVkZS9saW51eC9zbGFiLmg6MTE4OCBbaW5saW5lXQogY2FjaGVfY3JlYXRlX25ldCsweDlk
LzB4MjMwIG5ldC9zdW5ycGMvY2FjaGUuYzoxNzMzCiBuZnNkX2V4cG9ydF9pbml0KzB4NWUvMHgx
ZjAgZnMvbmZzZC9leHBvcnQuYzoxNTM2CiBuZnNkX25ldF9pbml0KzB4NTUvMHg0YjAgZnMvbmZz
ZC9uZnNjdGwuYzoyMjA5CiBvcHNfaW5pdCsweDM2MS8weDVkMCBuZXQvY29yZS9uZXRfbmFtZXNw
YWNlLmM6MTM3CiBzZXR1cF9uZXQrMHgxMWQvMHgzNTAgbmV0L2NvcmUvbmV0X25hbWVzcGFjZS5j
OjQ0NgogY29weV9uZXRfbnMrMHgzZTcvMHg1NzAgbmV0L2NvcmUvbmV0X25hbWVzcGFjZS5jOjU3
OQogY3JlYXRlX25ld19uYW1lc3BhY2VzKzB4M2VjLzB4NmEwIGtlcm5lbC9uc3Byb3h5LmM6MTMy
CiB1bnNoYXJlX25zcHJveHlfbmFtZXNwYWNlcysweDE0ZS8weDFhMCBrZXJuZWwvbnNwcm94eS5j
OjIzNAoga3N5c191bnNoYXJlKzB4NTgyLzB4OWYwIGtlcm5lbC9mb3JrLmM6MzI0MwogX19kb19z
eXNfdW5zaGFyZSBrZXJuZWwvZm9yay5jOjMzMTcgW2lubGluZV0KIF9fc2Vfc3lzX3Vuc2hhcmUg
a2VybmVsL2ZvcmsuYzozMzE1IFtpbmxpbmVdCiBfX3g2NF9zeXNfdW5zaGFyZSsweDNkLzB4NTAg
a2VybmVsL2ZvcmsuYzozMzE1CiBkb19zeXNjYWxsX3g2NCBhcmNoL3g4Ni9lbnRyeS9zeXNjYWxs
XzY0LmM6NjMgW2lubGluZV0KIGRvX3N5c2NhbGxfNjQrMHgxNWYvMHg1NjAgYXJjaC94ODYvZW50
cnkvc3lzY2FsbF82NC5jOjk0CiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ny8w
eDdmCgpUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBvYmplY3QgYXQgZmZmZjg4ODEx
YWMzNDAwMAogd2hpY2ggYmVsb25ncyB0byB0aGUgY2FjaGUga21hbGxvYy0yayBvZiBzaXplIDIw
NDgKVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9jYXRlZCAwIGJ5dGVzIHRvIHRoZSByaWdodCBvZgog
YWxsb2NhdGVkIDIwNDgtYnl0ZSByZWdpb24gW2ZmZmY4ODgxMWFjMzQwMDAsIGZmZmY4ODgxMWFj
MzQ4MDApCgpUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBwaHlzaWNhbCBwYWdlOgpw
YWdlOiByZWZjb3VudDowIG1hcGNvdW50OjAgbWFwcGluZzowMDAwMDAwMDAwMDAwMDAwIGluZGV4
OjB4MCBwZm46MHgxMWFjMzAKaGVhZDogb3JkZXI6MyBtYXBjb3VudDowIGVudGlyZV9tYXBjb3Vu
dDowIG5yX3BhZ2VzX21hcHBlZDowIHBpbmNvdW50OjAKZmxhZ3M6IDB4MjAwMDAwMDAwMDAwMDQw
KGhlYWR8bm9kZT0wfHpvbmU9MikKcGFnZV90eXBlOiBmNShzbGFiKQpyYXc6IDAyMDAwMDAwMDAw
MDAwNDAgZmZmZjg4ODEwMDA0MjAwMCBkZWFkMDAwMDAwMDAwMTAwIGRlYWQwMDAwMDAwMDAxMjIK
cmF3OiAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDA4MDAwODAwMDggMDAwMDAwMDBmNTAwMDAwMCAw
MDAwMDAwMDAwMDAwMDAwCmhlYWQ6IDAyMDAwMDAwMDAwMDAwNDAgZmZmZjg4ODEwMDA0MjAwMCBk
ZWFkMDAwMDAwMDAwMTAwIGRlYWQwMDAwMDAwMDAxMjIKaGVhZDogMDAwMDAwMDAwMDAwMDAwMCAw
MDAwMDAwODAwMDgwMDA4IDAwMDAwMDAwZjUwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMApoZWFkOiAw
MjAwMDAwMDAwMDAwMDAzIGZmZmZmZmZmZmZmZmZlMDEgMDAwMDAwMDBmZmZmZmZmZiAwMDAwMDAw
MGZmZmZmZmZmCmhlYWQ6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAw
MGZmZmZmZmZmIDAwMDAwMDAwMDAwMDAwMDgKcGFnZSBkdW1wZWQgYmVjYXVzZToga2FzYW46IGJh
ZCBhY2Nlc3MgZGV0ZWN0ZWQKcGFnZV9vd25lciB0cmFja3MgdGhlIHBhZ2UgYXMgYWxsb2NhdGVk
CnBhZ2UgbGFzdCBhbGxvY2F0ZWQgdmlhIG9yZGVyIDMsIG1pZ3JhdGV0eXBlIFVubW92YWJsZSwg
Z2ZwX21hc2sgMHhkMjBjMChfX0dGUF9JT3xfX0dGUF9GU3xfX0dGUF9OT1dBUk58X19HRlBfTk9S
RVRSWXxfX0dGUF9DT01QfF9fR0ZQX05PTUVNQUxMT0MpLCBwaWQgMzI0NCwgdGdpZCAzMjQ0IChz
eXotZXhlY3V0b3IpLCB0cyA2NDE2MjI4MjY5NCwgZnJlZV90cyA2NDA1Nzk0NTE4MAogc2V0X3Bh
Z2Vfb3duZXIgaW5jbHVkZS9saW51eC9wYWdlX293bmVyLmg6MzIgW2lubGluZV0KIHBvc3RfYWxs
b2NfaG9vaysweDIzMS8weDI4MCBtbS9wYWdlX2FsbG9jLmM6MTg1OAogcHJlcF9uZXdfcGFnZSBt
bS9wYWdlX2FsbG9jLmM6MTg2NiBbaW5saW5lXQogZ2V0X3BhZ2VfZnJvbV9mcmVlbGlzdCsweDIw
YzIvMHgyMWMwIG1tL3BhZ2VfYWxsb2MuYzozOTQ2CiBfX2FsbG9jX2Zyb3plbl9wYWdlc19ub3By
b2YrMHgxOTIvMHgzODAgbW0vcGFnZV9hbGxvYy5jOjUyMjYKIGFsbG9jX3NsYWJfcGFnZSBtbS9z
bHViLmM6MzI3OCBbaW5saW5lXQogYWxsb2NhdGVfc2xhYisweDdjLzB4NjYwIG1tL3NsdWIuYzoz
NDY3CiBuZXdfc2xhYiBtbS9zbHViLmM6MzUyNSBbaW5saW5lXQogcmVmaWxsX29iamVjdHMrMHgz
M2UvMHgzZDAgbW0vc2x1Yi5jOjcyNTUKIHJlZmlsbF9zaGVhZiBtbS9zbHViLmM6MjgxNiBbaW5s
aW5lXQogX19wY3NfcmVwbGFjZV9lbXB0eV9tYWluKzB4MzI2LzB4NzMwIG1tL3NsdWIuYzo0NjUx
CiBhbGxvY19mcm9tX3BjcyBtbS9zbHViLmM6NDc0OSBbaW5saW5lXQogc2xhYl9hbGxvY19ub2Rl
IG1tL3NsdWIuYzo0ODgzIFtpbmxpbmVdCiBfX2RvX2ttYWxsb2Nfbm9kZSBtbS9zbHViLmM6NTI5
NCBbaW5saW5lXQogX19rbWFsbG9jX25vcHJvZisweDQ3OS8weDc2MCBtbS9zbHViLmM6NTMwNwog
a21hbGxvY19ub3Byb2YgaW5jbHVkZS9saW51eC9zbGFiLmg6OTU0IFtpbmxpbmVdCiBza19wcm90
X2FsbG9jKzB4ZWMvMHgyMjAgbmV0L2NvcmUvc29jay5jOjIyNDcKIHNrX2FsbG9jKzB4M2YvMHgz
OTAgbmV0L2NvcmUvc29jay5jOjIzMDMKIF9fbmV0bGlua19jcmVhdGUrMHg2YS8weDI3MCBuZXQv
bmV0bGluay9hZl9uZXRsaW5rLmM6NjI2CiBfX25ldGxpbmtfa2VybmVsX2NyZWF0ZSsweDE0Mi8w
eDcyMCBuZXQvbmV0bGluay9hZl9uZXRsaW5rLmM6MjAxOAogbmV0bGlua19rZXJuZWxfY3JlYXRl
IGluY2x1ZGUvbGludXgvbmV0bGluay5oOjYyIFtpbmxpbmVdCiBhdWRpdF9uZXRfaW5pdCsweGNk
LzB4MjAwIGtlcm5lbC9hdWRpdC5jOjE3MDMKIG9wc19pbml0KzB4MzYxLzB4NWQwIG5ldC9jb3Jl
L25ldF9uYW1lc3BhY2UuYzoxMzcKIHNldHVwX25ldCsweDExZC8weDM1MCBuZXQvY29yZS9uZXRf
bmFtZXNwYWNlLmM6NDQ2CiBjb3B5X25ldF9ucysweDNlNy8weDU3MCBuZXQvY29yZS9uZXRfbmFt
ZXNwYWNlLmM6NTc5CiBjcmVhdGVfbmV3X25hbWVzcGFjZXMrMHgzZWMvMHg2YTAga2VybmVsL25z
cHJveHkuYzoxMzIKcGFnZSBsYXN0IGZyZWUgcGlkIDMyNTAgdGdpZCAzMjUwIHN0YWNrIHRyYWNl
OgogcmVzZXRfcGFnZV9vd25lciBpbmNsdWRlL2xpbnV4L3BhZ2Vfb3duZXIuaDoyNSBbaW5saW5l
XQogX19mcmVlX3BhZ2VzX3ByZXBhcmUgbW0vcGFnZV9hbGxvYy5jOjE0MDIgW2lubGluZV0KIF9f
ZnJlZV9mcm96ZW5fcGFnZXMrMHhiNGMvMHhjYTAgbW0vcGFnZV9hbGxvYy5jOjI5NDMKIF9fc2xh
Yl9mcmVlKzB4Mjc5LzB4MmMwIG1tL3NsdWIuYzo1NjEyCiBxbGlua19mcmVlIG1tL2thc2FuL3F1
YXJhbnRpbmUuYzoxNjMgW2lubGluZV0KIHFsaXN0X2ZyZWVfYWxsKzB4OTkvMHgxMDAgbW0va2Fz
YW4vcXVhcmFudGluZS5jOjE3OQoga2FzYW5fcXVhcmFudGluZV9yZWR1Y2UrMHgxNDgvMHgxNjAg
bW0va2FzYW4vcXVhcmFudGluZS5jOjI4NgogX19rYXNhbl9zbGFiX2FsbG9jKzB4MjIvMHg4MCBt
bS9rYXNhbi9jb21tb24uYzozNTAKIGthc2FuX3NsYWJfYWxsb2MgaW5jbHVkZS9saW51eC9rYXNh
bi5oOjI1MyBbaW5saW5lXQogc2xhYl9wb3N0X2FsbG9jX2hvb2sgbW0vc2x1Yi5jOjQ1NjkgW2lu
bGluZV0KIHNsYWJfYWxsb2Nfbm9kZSBtbS9zbHViLmM6NDg5OCBbaW5saW5lXQogX19kb19rbWFs
bG9jX25vZGUgbW0vc2x1Yi5jOjUyOTQgW2lubGluZV0KIF9fa21hbGxvY19ub3Byb2YrMHgzMWIv
MHg3NjAgbW0vc2x1Yi5jOjUzMDcKIGttYWxsb2Nfbm9wcm9mIGluY2x1ZGUvbGludXgvc2xhYi5o
Ojk1NCBbaW5saW5lXQogdG9tb3lvX3JlYWxwYXRoX2Zyb21fcGF0aCsweGU4LzB4NWUwIHNlY3Vy
aXR5L3RvbW95by9yZWFscGF0aC5jOjI1MQogdG9tb3lvX2dldF9yZWFscGF0aCBzZWN1cml0eS90
b21veW8vZmlsZS5jOjE1MSBbaW5saW5lXQogdG9tb3lvX3BhdGhfcGVybSsweDI4OC8weDU3MCBz
ZWN1cml0eS90b21veW8vZmlsZS5jOjgyNwogc2VjdXJpdHlfaW5vZGVfZ2V0YXR0cisweDExOS8w
eDI5MCBzZWN1cml0eS9zZWN1cml0eS5jOjE4OTUKIHZmc19nZXRhdHRyIGZzL3N0YXQuYzoyNTkg
W2lubGluZV0KIHZmc19mc3RhdCBmcy9zdGF0LmM6MjgxIFtpbmxpbmVdCiBfX2RvX3N5c19uZXdm
c3RhdCBmcy9zdGF0LmM6NTUxIFtpbmxpbmVdCiBfX3NlX3N5c19uZXdmc3RhdCBmcy9zdGF0LmM6
NTQ2IFtpbmxpbmVdCiBfX3g2NF9zeXNfbmV3ZnN0YXQrMHgxNDAvMHgyNzAgZnMvc3RhdC5jOjU0
NgogZG9fc3lzY2FsbF94NjQgYXJjaC94ODYvZW50cnkvc3lzY2FsbF82NC5jOjYzIFtpbmxpbmVd
CiBkb19zeXNjYWxsXzY0KzB4MTVmLzB4NTYwIGFyY2gveDg2L2VudHJ5L3N5c2NhbGxfNjQuYzo5
NAogZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3ZgoKTWVtb3J5IHN0YXRl
IGFyb3VuZCB0aGUgYnVnZ3kgYWRkcmVzczoKIGZmZmY4ODgxMWFjMzQ3MDA6IDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCiBmZmZmODg4MTFhYzM0NzgwOiAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo+ZmZmZjg4ODEx
YWMzNDgwMDogZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMK
ICAgICAgICAgICAgICAgICAgIF4KIGZmZmY4ODgxMWFjMzQ4ODA6IGZjIGZjIGZjIGZjIGZjIGZj
IGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjCiBmZmZmODg4MTFhYzM0OTAwOiBmYyBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
--00000000000093e0e80652e39266
Content-Type: application/octet-stream; name="reproducer.syz"
Content-Disposition: attachment; filename="reproducer.syz"
Content-Transfer-Encoding: base64
Content-ID: <f_mppq0irs2>
X-Attachment-Id: f_mppq0irs2

IyB7VGhyZWFkZWQ6ZmFsc2UgUmVwZWF0OmZhbHNlIFJlcGVhdFRpbWVzOjAgUHJvY3M6MSBTbG93
ZG93bjoxIFNhbmRib3g6IFNhbmRib3hBcmc6MCBMZWFrOmZhbHNlIE5ldEluamVjdGlvbjpmYWxz
ZSBOZXREZXZpY2VzOmZhbHNlIE5ldFJlc2V0OmZhbHNlIENncm91cHM6ZmFsc2UgQmluZm10TWlz
YzpmYWxzZSBDbG9zZUZEczpmYWxzZSBLQ1NBTjpmYWxzZSBEZXZsaW5rUENJOmZhbHNlIE5pY1ZG
OmZhbHNlIFVTQjpmYWxzZSBWaGNpSW5qZWN0aW9uOmZhbHNlIFdpZmk6ZmFsc2UgSUVFRTgwMjE1
NDpmYWxzZSBTeXNjdGw6ZmFsc2UgU3dhcDpmYWxzZSBVc2VUbXBEaXI6ZmFsc2UgSGFuZGxlU2Vn
djpmYWxzZSBUcmFjZTpmYWxzZSBDYWxsQ29tbWVudHM6dHJ1ZSBMZWdhY3lPcHRpb25zOntDb2xs
aWRlOmZhbHNlIEZhdWx0OmZhbHNlIEZhdWx0Q2FsbDowIEZhdWx0TnRoOjB9fQpta2RpcigmKDB4
N2YwMDAwMDAwMDQwKT0nLi9wbTA0NTdceDAwJywgMHgxZmYpCm1vdW50KDB4MCwgJigweDdmMDAw
MDAwMDA4MCk9Jy4vcG0wNDU3XHgwMCcsICYoMHg3ZjAwMDAwMDAwYzApPSduZnNkXHgwMCcsIDB4
MCwgMHgwKQpyMCA9IG9wZW5hdCgweGZmZmZmZmZmZmZmZmZmOWMsICYoMHg3ZjAwMDAwMDAxMDAp
PScuL3BtMDQ1Ny9leHBvcnRzXHgwMCcsIDB4MCwgMHgwKQpsc2VlayhyMCwgMHgxLCAweDApCnJl
YWR2KHIwLCAmKDB4N2YwMDAwMDAwMTQwKT1beyYoMHg3ZjAwMDAwMDAxODApPSIiLzY0LCAweDQw
fSwgezB4MH1dLCAweDIpCnJlYWQkRlVTRShyMCwgJigweDdmMDAwMDAwM2YwMCk9ezB4MjAyMH0s
IDB4MjAyMCkK
--00000000000093e0e80652e39266
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mppq0irk1>
X-Attachment-Id: f_mppq0irk1

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGVuZGlhbi5oPgojaW5j
bHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNp
bmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9tb3VudC5oPgojaW5jbHVkZSA8c3lzL3N5
c2NhbGwuaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+Cgp1aW50
NjRfdCByWzFdID0gezB4ZmZmZmZmZmZmZmZmZmZmZn07CgppbnQgbWFpbih2b2lkKQp7CiAgc3lz
Y2FsbChfX05SX21tYXAsIC8qYWRkcj0qLzB4MWZmZmZmZmZmMDAwdWwsIC8qbGVuPSovMHgxMDAw
dWwsIC8qcHJvdD0qLzB1bCwKICAgICAgICAgIC8qZmxhZ3M9TUFQX0ZJWEVEfE1BUF9BTk9OWU1P
VVN8TUFQX1BSSVZBVEUqLyAweDMydWwsCiAgICAgICAgICAvKmZkPSovKGludHB0cl90KS0xLCAv
Km9mZnNldD0qLzB1bCk7CiAgc3lzY2FsbChfX05SX21tYXAsIC8qYWRkcj0qLzB4MjAwMDAwMDAw
MDAwdWwsIC8qbGVuPSovMHgxMDAwMDAwdWwsCiAgICAgICAgICAvKnByb3Q9UFJPVF9XUklURXxQ
Uk9UX1JFQUR8UFJPVF9FWEVDKi8gN3VsLAogICAgICAgICAgLypmbGFncz1NQVBfRklYRUR8TUFQ
X0FOT05ZTU9VU3xNQVBfUFJJVkFURSovIDB4MzJ1bCwKICAgICAgICAgIC8qZmQ9Ki8oaW50cHRy
X3QpLTEsIC8qb2Zmc2V0PSovMHVsKTsKICBzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgy
MDAwMDEwMDAwMDB1bCwgLypsZW49Ki8weDEwMDB1bCwgLypwcm90PSovMHVsLAogICAgICAgICAg
LypmbGFncz1NQVBfRklYRUR8TUFQX0FOT05ZTU9VU3xNQVBfUFJJVkFURSovIDB4MzJ1bCwKICAg
ICAgICAgIC8qZmQ9Ki8oaW50cHRyX3QpLTEsIC8qb2Zmc2V0PSovMHVsKTsKICBjb25zdCBjaGFy
KiByZWFzb247CiAgKHZvaWQpcmVhc29uOwogIGludHB0cl90IHJlcyA9IDA7CiAgaWYgKHdyaXRl
KDEsICJleGVjdXRpbmcgcHJvZ3JhbVxuIiwgc2l6ZW9mKCJleGVjdXRpbmcgcHJvZ3JhbVxuIikg
LSAxKSkgewogIH0KICAvLyAgbWtkaXIgYXJndW1lbnRzOiBbCiAgLy8gICAgcGF0aDogcHRyW2lu
LCBidWZmZXJdIHsKICAvLyAgICAgIGJ1ZmZlcjogezJlIDJmIDcwIDZkIDMwIDM0IDM1IDM3IDAw
fSAobGVuZ3RoIDB4OSkKICAvLyAgICB9CiAgLy8gICAgbW9kZTogb3Blbl9tb2RlID0gMHgxZmYg
KDggYnl0ZXMpCiAgLy8gIF0KICBtZW1jcHkoKHZvaWQqKTB4MjAwMDAwMDAwMDQwLCAiLi9wbTA0
NTdcMDAwIiwgOSk7CiAgc3lzY2FsbCgKICAgICAgX19OUl9ta2RpciwgLypwYXRoPSovMHgyMDAw
MDAwMDAwNDB1bCwKICAgICAgLyptb2RlPVNfSVhPVEh8U19JV09USHxTX0lST1RIfFNfSVhHUlB8
U19JV0dSUHxTX0lSR1JQfFNfSVhVU1J8U19JV1VTUnwweDEwMCovCiAgICAgIDB4MWZmdWwpOwog
IC8vICBtb3VudCBhcmd1bWVudHM6IFsKICAvLyAgICBzcmM6IG5pbAogIC8vICAgIGRzdDogcHRy
W2luLCBidWZmZXJdIHsKICAvLyAgICAgIGJ1ZmZlcjogezJlIDJmIDcwIDZkIDMwIDM0IDM1IDM3
IDAwfSAobGVuZ3RoIDB4OSkKICAvLyAgICB9CiAgLy8gICAgdHlwZTogcHRyW2luLCBidWZmZXJd
IHsKICAvLyAgICAgIGJ1ZmZlcjogezZlIDY2IDczIDY0IDAwfSAobGVuZ3RoIDB4NSkKICAvLyAg
ICB9CiAgLy8gICAgZmxhZ3M6IG1vdW50X2ZsYWdzID0gMHgwICg4IGJ5dGVzKQogIC8vICAgIGRh
dGE6IG5pbAogIC8vICBdCiAgbWVtY3B5KCh2b2lkKikweDIwMDAwMDAwMDA4MCwgIi4vcG0wNDU3
XDAwMCIsIDkpOwogIG1lbWNweSgodm9pZCopMHgyMDAwMDAwMDAwYzAsICJuZnNkXDAwMCIsIDUp
OwogIHN5c2NhbGwoX19OUl9tb3VudCwgLypzcmM9Ki8wdWwsIC8qZHN0PSovMHgyMDAwMDAwMDAw
ODB1bCwKICAgICAgICAgIC8qdHlwZT0qLzB4MjAwMDAwMDAwMGMwdWwsIC8qZmxhZ3M9Ki8wdWws
IC8qZGF0YT0qLzB1bCk7CiAgLy8gIG9wZW5hdCBhcmd1bWVudHM6IFsKICAvLyAgICBmZDogZmRf
ZGlyIChyZXNvdXJjZSkKICAvLyAgICBmaWxlOiBwdHJbaW4sIGJ1ZmZlcl0gewogIC8vICAgICAg
YnVmZmVyOiB7MmUgMmYgNzAgNmQgMzAgMzQgMzUgMzcgMmYgNjUgNzggNzAgNmYgNzIgNzQgNzMg
MDB9IChsZW5ndGgKICAvLyAgICAgIDB4MTEpCiAgLy8gICAgfQogIC8vICAgIGZsYWdzOiBvcGVu
X2ZsYWdzID0gMHgwICg0IGJ5dGVzKQogIC8vICAgIG1vZGU6IG9wZW5fbW9kZSA9IDB4MCAoMiBi
eXRlcykKICAvLyAgXQogIC8vICByZXR1cm5zIGZkCiAgbWVtY3B5KCh2b2lkKikweDIwMDAwMDAw
MDEwMCwgIi4vcG0wNDU3L2V4cG9ydHNcMDAwIiwgMTcpOwogIHJlcyA9IHN5c2NhbGwoX19OUl9v
cGVuYXQsIC8qZmQ9Ki8weGZmZmZmZjljLCAvKmZpbGU9Ki8weDIwMDAwMDAwMDEwMHVsLAogICAg
ICAgICAgICAgICAgLypmbGFncz0qLzAsIC8qbW9kZT0qLzApOwogIGlmIChyZXMgIT0gLTEpCiAg
ICByWzBdID0gcmVzOwogIC8vICBsc2VlayBhcmd1bWVudHM6IFsKICAvLyAgICBmZDogZmQgKHJl
c291cmNlKQogIC8vICAgIG9mZnNldDogaW50cHRyID0gMHgxICg4IGJ5dGVzKQogIC8vICAgIHdo
ZW5jZTogc2Vla193aGVuY2UgPSAweDAgKDggYnl0ZXMpCiAgLy8gIF0KICBzeXNjYWxsKF9fTlJf
bHNlZWssIC8qZmQ9Ki9yWzBdLCAvKm9mZnNldD0qLzF1bCwgLyp3aGVuY2U9Ki8wdWwpOwogIC8v
ICByZWFkdiBhcmd1bWVudHM6IFsKICAvLyAgICBmZDogZmQgKHJlc291cmNlKQogIC8vICAgIHZl
YzogcHRyW2luLCBhcnJheVtpb3ZlY1tvdXQsIGFycmF5W2ludDhdXV1dIHsKICAvLyAgICAgIGFy
cmF5W2lvdmVjW291dCwgYXJyYXlbaW50OF1dXSB7CiAgLy8gICAgICAgIGlvdmVjW291dCwgYXJy
YXlbaW50OF1dIHsKICAvLyAgICAgICAgICBhZGRyOiBwdHJbb3V0LCBidWZmZXJdIHsKICAvLyAg
ICAgICAgICAgIGJ1ZmZlcjogKERpck91dCkKICAvLyAgICAgICAgICB9CiAgLy8gICAgICAgICAg
bGVuOiBsZW4gPSAweDQwICg4IGJ5dGVzKQogIC8vICAgICAgICB9CiAgLy8gICAgICAgIGlvdmVj
W291dCwgYXJyYXlbaW50OF1dIHsKICAvLyAgICAgICAgICBhZGRyOiBuaWwKICAvLyAgICAgICAg
ICBsZW46IGxlbiA9IDB4MCAoOCBieXRlcykKICAvLyAgICAgICAgfQogIC8vICAgICAgfQogIC8v
ICAgIH0KICAvLyAgICB2bGVuOiBsZW4gPSAweDIgKDggYnl0ZXMpCiAgLy8gIF0KICAqKHVpbnQ2
NF90KikweDIwMDAwMDAwMDE0MCA9IDB4MjAwMDAwMDAwMTgwOwogICoodWludDY0X3QqKTB4MjAw
MDAwMDAwMTQ4ID0gMHg0MDsKICAqKHVpbnQ2NF90KikweDIwMDAwMDAwMDE1MCA9IDA7CiAgKih1
aW50NjRfdCopMHgyMDAwMDAwMDAxNTggPSAwOwogIHN5c2NhbGwoX19OUl9yZWFkdiwgLypmZD0q
L3JbMF0sIC8qdmVjPSovMHgyMDAwMDAwMDAxNDB1bCwgLyp2bGVuPSovMnVsKTsKICAvLyAgcmVh
ZCRGVVNFIGFyZ3VtZW50czogWwogIC8vICAgIGZkOiBmZF9mdXNlIChyZXNvdXJjZSkKICAvLyAg
ICBidWY6IHB0cltvdXQsIGZ1c2VfaW5bcmVhZF9idWZmZXJdXSB7CiAgLy8gICAgICBmdXNlX2lu
W3JlYWRfYnVmZmVyXSB7CiAgLy8gICAgICAgIGxlbjogbGVuID0gMHgyMDIwICg0IGJ5dGVzKQog
IC8vICAgICAgICBvcGNvZGU6IGludDMyID0gMHgwICg0IGJ5dGVzKQogIC8vICAgICAgICB1bmlx
dWU6IGZ1c2VfdW5pcXVlIChyZXNvdXJjZSkKICAvLyAgICAgICAgdWlkOiB1aWQgKHJlc291cmNl
KQogIC8vICAgICAgICBnaWQ6IGdpZCAocmVzb3VyY2UpCiAgLy8gICAgICAgIHBpZDogcGlkIChy
ZXNvdXJjZSkKICAvLyAgICAgICAgcGFkZGluZzogaW50MzIgPSAweDAgKDQgYnl0ZXMpCiAgLy8g
ICAgICAgIHBheWxvYWQ6IGJ1ZmZlcjogKERpck91dCkKICAvLyAgICAgIH0KICAvLyAgICB9CiAg
Ly8gICAgbGVuOiBieXRlc2l6ZSA9IDB4MjAyMCAoOCBieXRlcykKICAvLyAgXQogIHN5c2NhbGwo
X19OUl9yZWFkLCAvKmZkPSovclswXSwgLypidWY9Ki8weDIwMDAwMDAwM2YwMHVsLCAvKmxlbj0q
LzB4MjAyMHVsKTsKICByZXR1cm4gMDsKfQo=
--00000000000093e0e80652e39266--

