Return-Path: <linux-nfs+bounces-20612-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPvzBvhOzmmjmgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20612-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 13:11:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF83388250
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 13:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ED9E30632A9
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467593BED6A;
	Thu,  2 Apr 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODT7rdkt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05D3AD538
	for <linux-nfs@vger.kernel.org>; Thu,  2 Apr 2026 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127956; cv=none; b=StVCo3UwWHFaBhAdCZS6SEKSzEcsp1UjfnyVMOt3GLtrDZmK1CNo0JcZXAroxJrs6Q+dn97ff+mQxuCgMJTMbbvC2OBc5oG6HVCHsAA3IBSTX6/H/V8XO8v407dLwvG7L7wWtVbbHkD9KUMNXEpw5XlsvM0dfLv3UHS/jyvTdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127956; c=relaxed/simple;
	bh=me4IS2HU9d50hW4txNic1PwqFwNHztWZ10tpmfpy8fY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=OmjpahwhR6+lnA6nSTWWeq+MTt20FU76dyuNp4X+J9Tqdq/GgELbRz1cflmyHPPId44rgpQPi1+jcWCmfUbodHQMitK7BvBnkEvcXKRnWy6VG1R7Y8aoYxW7GXfnPjf2cCb9LXm0XCn9oehicNudyWhfYcxe8psMLzSbKte0HHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODT7rdkt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0c8362d93so4500445ad.3
        for <linux-nfs@vger.kernel.org>; Thu, 02 Apr 2026 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775127952; x=1775732752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lMTGGW/lVlEowo2cXhN6MlBnR14oyO4BAH8bNM9mfG8=;
        b=ODT7rdktaiA/HlBbMY6ejlRcVWq6wLOnkJgJr88/Wl3DewEGjSODmZjZh6Fgsr3PXk
         KKQT0P53PqgdEQiV0St8SwqPQ+ekZQenLs0z+2dTVPAtCWMhTbE2PlCYI60hhBV3EHtm
         0yl3pLQh2xQ9zba58i5U6pTu6RilJwJZFdfj+hF/0PUwd0YMPfuUlWm8pmxzq/NAR0TD
         vLo1pbOnEvhG0pTn8PXd2jIPVmOlwW+mPVRkVIFIKksqA191IV/tJD/Mj0nWVEPhX6l0
         iW3pCo6gi1aUe8uUjjCFUSLePt4zxN/KdzXvmCYUSKBKOZ6WjSlNKJZBEqVZlDXA8Y19
         KW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775127952; x=1775732752;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMTGGW/lVlEowo2cXhN6MlBnR14oyO4BAH8bNM9mfG8=;
        b=Fz++qixMZqR5ohZhwuc6pJ/Uvi4qkLsBO1efIiZiIsMMU47Xgb+A7ndZTg3y2h+I7z
         7XuZNeX95a4XWo5IO1B9AO4sp8wGs6b8SylyIbucHsjtd90z5nb4RlxAqdChygdv3MN0
         /HcaUV5KYf22gyck1CbgE5hF0xigBd5y0TCAZmvxqc1pGZcV7ksI5kTLkf2VlYAx6/go
         aezUboW8Hrgb7LnUeX3NdoZOfWSNV0ojmP6jk7uoaG/OucX+IB0igUIP733cKrH5QNTL
         t2RUb6wVLEMtqbbVwbpdzefCGDdljNG+CyJ9CDoR7R4Gj3VQ7Q8r+IouO+uxOghFQfJI
         R0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbygNkH2xmbDsho3xIcS4/YHrPYJTTFSoO3935azCszIWWGllclMS9TOr3CsgYHkxK4v+Fkr7pwWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4dv0vN1EZYb5PfIzROLKVNbxrDYoiWhya7JkXPmIV+MVKcua
	eMUnpGXqVRrpSiqzi3yGP5cT8ed1TsIGFqXFVdKxG0BcUDDF8PEV407S
X-Gm-Gg: AeBDies5MXHLprhzPIJPcHPgmH2cnT84zYyfnxHVldS78uFVOaLhXczMwKJvrh50BEL
	TkYHOsZ36LSPL8Wf1zSBpmH+ow68m2oItejGjxH0A7VwB9HQxUtOzWVSr/9UpqtG5MNczxlK39b
	aXLhC/9wL+pc+WKSIq89JtC1K6c2xLztNFFn1Up5Mi4Y8KyE+UBzG5YpTtxRd2/D5v9kAOuSczK
	5ZEe4ASICaigsXfKsfidZYH1CCsWZRD9EXzYYXsmSFfZRqvFYqRw59oybXWGd788WhJp2FfG2s9
	rYZc0CIo4GpPgA0JV099FwS3WNbZiJMq/8sdDmPSpLIOQpATuhY/RGzVUS558MhrNhKpUX/Tepm
	AMNpboSigKWsTgIuC8AY5uFvsl7cj/7srAS8qw6VLWFcDAKgkRqEQQnyzZOuCiKJvDFXLOsm1VO
	oBHc+nS9XTreYhRQ6Y9o0=
X-Received: by 2002:a17:902:f54a:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2b2756da9d4mr28597045ad.0.1775127951769;
        Thu, 02 Apr 2026 04:05:51 -0700 (PDT)
Received: from localhost ([137.132.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478b658sm27219935ad.31.2026.04.02.04.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:05:51 -0700 (PDT)
Message-ID: <69ce4d8f.170a0220.1c5378.9cf5@mx.google.com>
From: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
To: Tom Talpey <tom@talpey.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <okorniev@redhat.com>,
        NeilBrown <neil@brown.name>,
        Dai Ngo <Dai.Ngo@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [BUG] Linux Kernel NFS Server refcount_t Underflow in nfs3svc_release_getacl (S→C)
Date: Thu, 02 Apr 2026 19:05:49 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: KernelStackFuzz send_email.sh
X-Spamd-Result: default: False [-1.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_NEEDS_ENCODING(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20612-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ven0mkernelfuzzer@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.957];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BF83388250
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Linux Kernel NFS Server refcount_t Underflow in nfs3svc_release_getacl (S→C)

  1. Vulnerability Title

Linux Kernel NFS Server (nfsd) refcount_t Underflow via Malicious GETACL Request with Corrupted File Handle

  2. High-Level Overview

This report describes a refcount_t underflow vulnerability in the Linux kernel NFS server (nfsd) triggered when a MITM attacker corrupts the file handle in an NFSv3 GETACL request. When `fh_verify()` or `fh_copy()` fails due to the corrupted handle, `resp->fh` is left in an inconsistent refcount state. The subsequent `fh_put()` call in `nfs3svc_release_getacl()` decrements a refcount that was never properly incremented, causing an underflow that constitutes a potential use-after-free condition.

The kernel's `refcount_warn_saturate()` protection clamps the value at zero, preventing actual exploitation. However, the underlying logic error remains — on kernels compiled without `CONFIG_REFCOUNT_FULL` (or older kernels without saturating refcount), this could lead to a real use-after-free.

This vulnerability was discovered using ven0mfuzzer, our custom-designed MITM-based network filesystem fuzzer developed by our team.

  Attack Model

The attack direction is Client → Server (C→S) via MITM:

1. MITM injection: An attacker with network access between an NFS client and server intercepts NFSv3 traffic and corrupts the file handle field in GETACL requests. The nfsd server processes the corrupted request, triggering the refcount underflow in the release path.

2. Malicious NFS client: A rogue NFS client sends crafted GETACL requests with invalid file handles directly to the NFS server, triggering the same code path.

  3. Affected Product and Version Information

Product: Linux Kernel (upstream mainline)
Affected Component: `fs/nfsd/nfs3acl.c` — `nfs3svc_release_getacl()`
Supporting Components:
- `fs/nfsd/nfsfh.c` — `fh_verify()`, `fh_put()`
- `fs/nfsd/nfs3acl.c` — `nfsd3_proc_getacl()`

  Tested Versions (confirmed vulnerable)
- Linux kernel 6.19.0 (mainline, commit `44331bd6a610`, gcc 11.4.0, built with KASAN + LOCKDEP + KFENCE)

  Affected Version Range
All kernels with `CONFIG_NFSD_V3_ACL` enabled (NFSv3 ACL extension support) are believed affected.

  Affected Distributions and Products

 |  Vendor / Product  |  Notes  | 
 | --- | --- | 
 |  Red Hat Enterprise Linux (RHEL 8.x, 9.x)  |  Ships nfsd with NFSv3 ACL support by default  | 
 |  Ubuntu Server (20.04 LTS, 22.04 LTS, 24.04 LTS)  |  NFS server packages include ACL support  | 
 |  SUSE Linux Enterprise Server (SLES 15 SP5+)  |  NFS server with ACL enabled  | 
 |  Debian (Bookworm, Trixie)  |  nfs-kernel-server includes ACL support  | 
 |  Amazon Linux 2023  |  Kernel 6.1 LTS with nfsd  | 
 |  Google ChromeOS / COS  |  NOT AFFECTED — CONFIG_NFSD not enabled  | 

  4. Root Cause Analysis

  4.a. Detailed Description

In `fs/nfsd/nfs3acl.c`, the GETACL procedure (`nfsd3_proc_getacl`) handles two code paths:

Success path: `fh_verify()` succeeds, `fh_copy()` properly initializes `resp->fh` with correct refcount. `nfs3svc_release_getacl()` later calls `fh_put(&resp->fh)` which decrements the refcount normally.

Failure path (triggered by corrupted file handle): `fh_verify()` fails because the file handle is invalid. At this point `resp->fh` may be partially initialized — the `fh_copy()` or `fh_compose()` call either did not execute or left the refcount in an inconsistent state. However, `nfs3svc_release_getacl()` is always called by `svc_process()` as the release function, regardless of whether the procedure succeeded. When it calls `fh_put(&resp->fh)`, it decrements a refcount that was never incremented, causing underflow.

The `refcount_warn_saturate()` call in the kernel's refcount infrastructure detects this underflow and clamps the value, printing a warning. On kernels without saturating refcount protection, this would be a genuine use-after-free condition.

The bug was triggered independently twice across different fuzzing sessions, confirming it is reliably reproducible.

  4.b. Code Flow

---
svc_process()                                [net/sunrpc/svc.c]
  nfsd3_proc_getacl()                        [fs/nfsd/nfs3acl.c]
    fh_verify(&argp->fh, ...)                ← FAILS (corrupted file handle from MITM)
    resp->fh is left in inconsistent state    ← refcount never properly incremented
    → returns nfserr_*
  nfs3svc_release_getacl()                   [fs/nfsd/nfs3acl.c]  (always called by svc_process)
    fh_put(&resp->fh)                        ← decrements refcount that was never incremented
    → refcount underflow!
    → refcount_warn_saturate() triggered
---

  4.c. Crash Trace

This vulnerability was discovered by ven0mfuzzer. The following kernel trace is submitted following syzkaller's common practice of providing the raw crash trace as the primary reproduction evidence:

---
refcount_t: underflow; use-after-free.

Call Trace:
 <TASK>
 refcount_warn_saturate+0xe0/0x120
 nfs3svc_release_getacl+0x149/0x1c0
 svc_process+0x6c1/0xb20
 svc_recv+0x2191/0x2e60
 nfsd+0x284/0xd60
 kthread+0x378/0x490
 ret_from_fork+0x676/0xac0
 </TASK>
---

Key observations:
- Trigger: nfsd kernel thread processing GETACL request with corrupted file handle
- Underflow detected at: `nfs3svc_release_getacl+0x149` — the `fh_put()` call
- Protection active: `refcount_warn_saturate()` clamps the value, preventing actual UAF
- Reproduced independently twice (crash-0-1773578276 at uptime 2568s, crash-0-1773606962 at uptime 15073s)

  4.d. Suggested Fix

Ensure `resp->fh` is properly initialized before the release function is called. Add a check in `nfs3svc_release_getacl()` to verify the file handle was actually set up:

---
static void nfs3svc_release_getacl(struct svc_rqst *rqstp)
{
    struct nfsd3_getaclres *resp = rqstp->rq_resp;
+   / Only put the file handle if it was properly initialized /
+   if (resp->fh.fh_dentry)
        fh_put(&resp->fh);
    posix_acl_release(resp->acl_access);
    posix_acl_release(resp->acl_default);
}
---

Alternatively, ensure `nfsd3_proc_getacl()` explicitly calls `fh_init()` on `resp->fh` at the start of the procedure to guarantee a clean initial state, so that `fh_put()` on an unused handle is a safe no-op.

  5. Discovery Method and Reproduction

  5.a. Discovery

This vulnerability was discovered using ven0mfuzzer, a custom-designed MITM-based network filesystem fuzzer developed by our team. The fuzzer operates by positioning an AF_PACKET/TCP transparent proxy between a Linux kernel filesystem client (VM-A) and its server (VM-B), then mutating network protocol messages in-flight. We designed ven0mfuzzer specifically for this class of network filesystem vulnerabilities.

Following the common syzkaller practice, we submit the kernel crash trace as the primary reproduction artifact.

  5.b. Reproduction Setup

---
VM-A (NFS client) ──NFS──► Host (MITM proxy) ──TCP──► VM-B (nfsd server)
---

Trigger condition: MITM corrupts the file handle field in an NFSv3 GETACL request, causing `fh_verify()` to fail while `nfs3svc_release_getacl()` still calls `fh_put()` on the improperly initialized handle.

Reproduction steps:
1. Build kernel 6.19.0 (commit `44331bd6a610`) with KASAN, LOCKDEP, and KFENCE enabled
2. Start VM-B running nfsd server with NFSv3 ACL support (`CONFIG_NFSD_V3_ACL=y`)
3. Start MITM proxy on host, configured to corrupt file handle bytes in GETACL requests
4. Mount NFS share in VM-A through the MITM proxy
5. Execute filesystem operations that trigger GETACL (e.g., `getfacl` on mounted files)

---
Reported-by: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
Link: https://github.com/KernelStackFuzz/KernelStackFuzz

