Return-Path: <linux-nfs+bounces-18425-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EECAJUJIdGkc4QAAu9opvQ
	(envelope-from <linux-nfs+bounces-18425-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 05:19:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6CD7C765
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 05:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56ADE3019501
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 04:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA01A9FBA;
	Sat, 24 Jan 2026 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MsLhl8U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009D17A316
	for <linux-nfs@vger.kernel.org>; Sat, 24 Jan 2026 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769228349; cv=none; b=GhuxHukhEo2Mlvxq70EGXUZAfEj5qdvpPcj1B5dy1uymXWEo+noIk2aEow7vTSX92GP5YvhOn/v2snTQ6EM7zmDTbmc21Xh/X0Y2LpmZIhMC2BELVAVoaouAWdjiotPUpV2BRdOh9OoVaVJ5WSKvA/5Lx6BERL7jOwZ7MRGUsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769228349; c=relaxed/simple;
	bh=mxPVOOCt+XALSs4dZPAWsHzzRjVVnnu2GZnHZoKIrzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cs+9hPew1Pr3x+sHV0YMzQIb9DsQz5KOzWQL5f7I2bW07YLaT56gdkNKYNvWUzUX4/QAAXZMlJZSgSpRmeHi7gWC4kS7YnJJv3sLukfgY7bZty2vjX9ThFAO3oduhsk2jnYeJjL9VO6/iBT/lVDwO99zXDc8HczyU7ErkhR7bd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MsLhl8U; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34ec823527eso4548428a91.2
        for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 20:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769228347; x=1769833147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BjCzIiFzbJG9QYE1ZY4CUeieZUPscwOiz5BiraiuwM8=;
        b=0MsLhl8U/kU/USFKiXCZEO7Jecte7uvdj4iLULDZlEFCLV/niKVVqFwgQ4X7oynqS3
         q935pC1nBe6gdU2U+c0W4bx250ThBtPyAQkWnn4n3gp+I5yIxNYhTPwnT14RxoXiRsDq
         I0/vtKY2nowhMwKeAgxpM9lTuZNCcpNf8J/moJnOKzTBsIyTkC2E4St6z3gldUaxnth4
         UJ5mlxrObJosdkDBFm8Gp/JcpnfbTp2tDRbZGLkjz90VmnM20xEujRHl03SJ5WIM7jXH
         +Q8StX9zUYQCqbQIiKbstrKx5RP9RlwpWYeAF+ocu5jqKsm3+7vMt1tn9R3FPQLMfXGt
         uq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769228347; x=1769833147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjCzIiFzbJG9QYE1ZY4CUeieZUPscwOiz5BiraiuwM8=;
        b=XDEw5CDdSBOqDENRtDWvGihS16tFykaIRFe+jhwpFwLqJ0Mqam1/D+3uSlZXXg88s3
         9xyQIp16r8Na3IGeZnFbogMvMhOqRtb5SKq+9TyXweu65/vnPwUYesLLSZ7Kk0p/b83Q
         7wkFBdqP4Ly7yRrMzN2gqhS9Or1Ny6EAIhVBjwsESIuqP23QN565OOAW12JngEcBAQ8f
         SpROXgL6+rPIEl8jKinbL2Up21eRI476aBK9mMAH6VxT+gvGXQveOdpGsQLKScNAoZ8a
         D7Bx2Wt9vmkAh2dy8MwAE5U6bNhNi6yjzhF+J/8f0j7SfW0WffE/7X7DU8FW5zMflUCv
         VKAw==
X-Forwarded-Encrypted: i=1; AJvYcCXOAst8+ie1/4JnH+InvR59kt9wn0itoPp+/5Lyv6Wf8L4GB12Ne8iGfYPodAXuEVa56hCf9QFj6h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1HPxFTBZ2soTHRPU8xfjNrqa+HO2LkGC/+vOJo3Qp6R8YU7UW
	wMMbRwOhYj5HBn+VWivO99GWo66Ku4vsj3ywJpQ+tdkkLkklxwqV2mgpmsOwNWeOEABnS2gY+el
	0CnZwVw==
X-Received: from plbmo12.prod.google.com ([2002:a17:903:a8c:b0:267:d862:5f13])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:246:b0:2a7:95d1:3c0
 with SMTP id d9443c01a7336-2a7fe57f24cmr47885185ad.23.1769228347062; Fri, 23
 Jan 2026 20:19:07 -0800 (PST)
Date: Sat, 24 Jan 2026 04:18:40 +0000
In-Reply-To: <20260124041902.548904-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260124041902.548904-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260124041902.548904-2-kuniyu@google.com>
Subject: [PATCH v1 1/2] nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-nfs@vger.kernel.org, 
	syzbot+dd3b43aa0204089217ee@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[brown.name,redhat.com,oracle.com,talpey.com,kernel.org,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18425-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs,dd3b43aa0204089217ee];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: BD6CD7C765
X-Rspamd-Action: no action

syzbot reported memory leak of struct cred. [0]

nfsd_nl_threads_set_doit() passes get_current_cred() to
nfsd_svc(), but put_cred() is not called after that.

The cred is finally passed down to _svc_xprt_create(),
which calls get_cred() with the cred for struct svc_xprt.

The ownership of the refcount by get_current_cred() is not
transferred to anywhere and is just leaked.

nfsd_svc() is also called from write_threads(), but it does
not bump file->f_cred there.

nfsd_nl_threads_set_doit() is called from sendmsg() and
current->cred does not go away.

Let's use current_cred() in nfsd_nl_threads_set_doit().

[0]:
BUG: memory leak
unreferenced object 0xffff888108b89480 (size 184):
  comm "syz-executor", pid 5994, jiffies 4294943386
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 369454a7):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x412/0x580 mm/slub.c:5270
    prepare_creds+0x22/0x600 kernel/cred.c:185
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x7a7/0x2870 kernel/fork.c:2086
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2792
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 924f4fb003ba ("NFSD: convert write_threads to netlink command")
Reported-by: syzbot+dd3b43aa0204089217ee@syzkaller.appspotmail.com
Tested-by: syzbot+dd3b43aa0204089217ee@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69744674.a00a0220.33ccc7.0000.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 fs/nfsd/nfsctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 084fc517e9e1..ec9782fd4a36 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1642,7 +1642,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			scope = nla_data(attr);
 	}
 
-	ret = nfsd_svc(nrpools, nthreads, net, get_current_cred(), scope);
+	ret = nfsd_svc(nrpools, nthreads, net, current_cred(), scope);
 	if (ret > 0)
 		ret = 0;
 out_unlock:
-- 
2.52.0.457.g6b5491de43-goog


