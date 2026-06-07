Return-Path: <linux-nfs+bounces-22340-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V//vF6zUJGq6AQIAu9opvQ
	(envelope-from <linux-nfs+bounces-22340-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 04:17:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D8A64EADC
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 04:17:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fUfgKYTc;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22340-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22340-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B393D3017259
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jun 2026 02:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E591A6819;
	Sun,  7 Jun 2026 02:17:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45C175A92
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jun 2026 02:17:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780798633; cv=none; b=X96H+bAQxBLHzVZOEuXephwQIOJE1270Qt7K9XtnCj6vifh1Qwou36j+Xf3LzcoWuRwiXiezPXV5whqhaeQsZmKMVgdu9XpmyN1rnFy7zKx6wzHZHYaEOfcjWMke5mRMeCH7Eh16G4J3y6dt8Z2z+25QJZghu+i1mL+CRzCWiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780798633; c=relaxed/simple;
	bh=QmQj8pn1BszsydvtP6xCa24DN4fl+NL/AwBtOqHlzzQ=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=oFzZovQlADApptaSSuFqt2jdXZ5+jqOPTmGORmTfVT4Ine2LDLXtPuBIE97PQgyd1arlsggEGTNZQ8YYSc7ELrQgj16vJC0btqo++6kjcDUZynRRn9iohyJGWOcV4uF+cG7NKN+ywVKic/+7v7wwSyyiiPrecE0eQCOwjRIf+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUfgKYTc; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91550dfc11fso345452985a.1
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jun 2026 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780798630; x=1781403430; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyzTkYCGGMBYiZr90+zq7gb1XnJwNW0EoAweHvtNSjY=;
        b=fUfgKYTcvZmSDcKPfcg+bGzBr7h9j6wwh4JqSjHdHCwnjAjLegZ3dZIRiiut0fXIHg
         0Cr7jc/FTiFY3hdJx5nW0I3WIMX5LOvZj8hLx2vzGU6vgXwY7qUaqzxSKT6GH2qbfpq7
         o9WHGAb3DZZURTCOhk7FRmEOZ9cDjoj2tHSMFxAY90yauCkqqgrHbP5YdlaAuuvOSCxa
         V96LOGJ1PlGybEnpQo16oCUSs8M2TMDsIgniUbjLogEnbl5V5SccgAnSDA7EPyO5Z4OR
         qnAnBg5UFQASsb2+QqMU5Q7qB0leImXn9dMJcHBRkt6lqEStoJYX96WZbi3vZvK2NkWZ
         oahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780798630; x=1781403430;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HyzTkYCGGMBYiZr90+zq7gb1XnJwNW0EoAweHvtNSjY=;
        b=TyCVAk8G09abhu8AkjapKTFlWJJLl3D5m4nZxA2guExt6SzWXhp7WZ9+ZG7ZgRNhtH
         NYEJjYfT3kiaOJdvNFyjX3h8iTGTGaNWqIHOrtbdev/JkRHE1p9y4alF5TNiXs2eXvp8
         aSJ7Io4sZEbg/QmCaD0fMDt07X4w3BNFI6otWptCyhUxtOko71rqlzfiJEZQsxVbG3QP
         orlkMkThSzcWEUR38CrVjP1ImrKo3k3lnsu3q4NegH8DY/JrYtYgHJ7xrVrLHaqJMSUB
         MPHgY8+Jc5NtkTqA0W7uOFA9kjfinSoAwoTRPBvU4QVfO+kE7ku4OR1xIoqnJ7LiucGp
         MF8w==
X-Gm-Message-State: AOJu0YxVhsD5zHhfe0ammqNqGP9uMplfTobrsvcQCu8dCkKHqx5t9IwY
	hcAvwhXY4wNsQeR3Q5PJ/NiqK2i7s5LGEykzDr8lLyL5EwVxA0ndCNTaW3r7rD7J
X-Gm-Gg: Acq92OHF2OOXxrVWTiXKjWbgPASRN5CxhCjRJrm1OAGwpeBicMp8iwPJ/QjEhrsq6ou
	Em4bAsd4vwHHYnDR95vqSa+qo6rkYaw08bN1EvL2y6uVBnFmqXZZKm6SInGwzsx9Rr8faN1nk9G
	HBnr3QCqv9CR8vOu7wlEsHvzEGG7ZSTszQI9D+s+VBlFqh7G+WAb/AZHgMvXuL7lUCnsklpNWOv
	k5KcIA1vuCRe2FWU0t/n0vnXJP4yCwwVBpnbxFV9y+Cg1JtCezhENxcm0jDVBQ0MYl00ULNdRTq
	Ru28UFVJ7BbhACFgFo08RuPP+WRrsbFkaa93lnBpP8NOfAMlxHCXkqvxV5VlxhBodlFBxqBL8lL
	IeilbGcth28rIJAeQIvfBJXelkKqrC+WY2HR8nLPig2SiPWEoX4iwBA2HQ4b1GsYy4s+TqFSurI
	QAjfI+BMNr4qF+sb+bHn2PoHxulIJgeYzlS+XjCKjoOK4bh24DA795kGZeZxYpV8QN5h+ISLWJV
	oU=
X-Received: by 2002:a05:620a:448d:b0:915:351b:3ae5 with SMTP id af79cd13be357-915a9daec07mr1693851685a.41.1780798630474;
        Sat, 06 Jun 2026 19:17:10 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:fceb:48b4:c445:f78d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37bae6sm1320986085a.31.2026.06.06.19.17.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2026 19:17:09 -0700 (PDT)
From: Shuangpeng <shuangpeng.kernel@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [BUG] KASAN: slab-use-after-free in xprt_put
Message-Id: <4EB31731-B511-44E6-9019-760EED0A2BD1@gmail.com>
Date: Sat, 6 Jun 2026 22:16:38 -0400
Cc: linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: trondmy@kernel.org,
 anna@kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22340-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shuangpengkernel@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4D8A64EADC

Hi Kernel Maintainers,

I hit the following KASAN report while testing current upstream kernel:

KASAN: slab-use-after-free in xprt_put

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

To help trigger the bug more reliably, we applied a minimal diagnostic =
patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/98a27c1e3c0dc5489f117efa7c254593

I=E2=80=99m happy to test debug patches or provide additional =
information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>


[  170.638952][   T24] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  170.641053][   T24] BUG: KASAN: slab-use-after-free in xprt_put =
(./include/linux/instrumented.h:112 =
./include/linux/atomic/atomic-instrumented.h:400 =
./include/linux/refcount.h:389 ./include/linux/refcount.h:432 =
./include/linux/refcount.h:450 ./include/linux/kref.h:64 =
net/sunrpc/xprt.c:2195)
[  170.643027][   T24] Write of size 4 at addr ffff8881092e1000 by task =
kworker/1:0/24
[  170.645020][   T24]
[  170.645344][   T24] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  170.645349][   T24] Workqueue: events rpc_free_client_work
[  170.645375][   T24] Call Trace:
[  170.645390][   T24]  <TASK>
[  170.645394][   T24]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
[  170.645451][   T24]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
[  170.645514][   T24]  kasan_report (mm/kasan/report.c:595)
[  170.645525][   T24]  kasan_check_range (mm/kasan/generic.c:? =
mm/kasan/generic.c:200)
[  170.645530][   T24]  xprt_put (./include/linux/instrumented.h:112 =
./include/linux/atomic/atomic-instrumented.h:400 =
./include/linux/refcount.h:389 ./include/linux/refcount.h:432 =
./include/linux/refcount.h:450 ./include/linux/kref.h:64 =
net/sunrpc/xprt.c:2195)
[  170.645535][   T24]  rpc_free_client_work (net/sunrpc/clnt.c:991)
[  170.645541][   T24]  process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[  170.645557][   T24]  worker_thread (kernel/workqueue.c:3478)
[  170.645577][   T24]  kthread (kernel/kthread.c:436)
[  170.645590][   T24]  ret_from_fork (arch/x86/kernel/process.c:158)
[  170.645624][   T24]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[  170.645631][   T24]  </TASK>
[  170.645633][   T24]
[  170.657540][   T24] Freed by task 0 on cpu 1 at 165.626544s:
[  170.657945][   T24]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
[  170.658274][   T24]  kasan_save_free_info (mm/kasan/generic.c:584)
[  170.658632][   T24]  __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
[  170.658965][   T24]  __rcu_free_sheaf_prepare =
(./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:2940)
[  170.659363][   T24]  rcu_free_sheaf (mm/slub.c:5850)
[  170.659693][   T24]  rcu_core (kernel/rcu/tree.c:2617 =
kernel/rcu/tree.c:2869)
[  170.659997][   T24]  handle_softirqs (kernel/softirq.c:622)
[  170.660335][   T24]  __irq_exit_rcu (kernel/softirq.c:656 =
kernel/softirq.c:496 kernel/softirq.c:735)
[  170.660657][   T24]  sysvec_apic_timer_interrupt =
(arch/x86/kernel/apic/apic.c:1061 arch/x86/kernel/apic/apic.c:1061)
[  170.661058][   T24]  asm_sysvec_apic_timer_interrupt =
(./arch/x86/include/asm/idtentry.h:697)
[  170.661480][   T24]
[  170.661645][   T24] The buggy address belongs to the object at =
ffff8881092e1000
[  170.661645][   T24]  which belongs to the cache kmalloc-2k of size =
2048
[  170.662610][   T24] The buggy address is located 0 bytes inside of
[  170.662610][   T24]  freed 2048-byte region [ffff8881092e1000, =
ffff8881092e1800)

Best,
Shuangpeng


