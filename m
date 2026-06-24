Return-Path: <linux-nfs+bounces-22823-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HA0uJZhFPGrplwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22823-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 23:01:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1900B6C1517
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 23:01:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Mh9uhHST;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22823-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22823-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D09C3301FD6B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C23E557E;
	Wed, 24 Jun 2026 21:01:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49453E5577
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 21:01:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334866; cv=none; b=G2f8RkOXsvVD9/0KB9LXfWYoXfWxKUCUmXJoHdqKgDGFcHDeo0FXsF1onL++kH54T5fgGjUz+9z9E88E+54PE1KSaMRQ0AaWip3GNmFfl0B3VrwD/6Pj+RQU/0FTBsaFduws7twsCujbfiMTutdZP31qYjKhmld4DXLXYgHRTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334866; c=relaxed/simple;
	bh=c5qjXaWLEyhLuNiOPCdDkmM8rNuxzbT6vfk0jSC7nfk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kuKKFYI7JeGUgjUx/tP88+zb1phM3Euvvzi8x7uJp9881Ew4oMXirOm5w4RcLPermpM92nV7ei52ZmMsHqQ6KPfIoWDUV4qIlb+VjN1kErLGhhY9otsDuxSC7It8V0OSxO67y/RDl5yq9A2ztvUTZP7ks9zvAbb/QjSRCWF8UbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh9uhHST; arc=none smtp.client-ip=209.85.222.180
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-922ff615c14so153871085a.3
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782334863; x=1782939663; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp9es+PbpOVzt6NQoYl+lTdhFn1wTpGBlO8nUPt+1No=;
        b=Mh9uhHSTk+GAe2sFSs13M3p5KUQe9sQrHN7dxxjpW8ptUsUzzQHS2LsbGHWvIOJF8F
         TkgbyeKspJgMBdkFkkr+9I+pEUpMeNqvdw2BUfrH1TOWU9Qjw4MeJiPY8fFBb/6nCKmp
         nrvbjcxf1plRGYptzbqkGvMihnWU/ZBKbFtyHpqyhCrytrl/ETktr6S9k5v/TDMiNyQ3
         T7h5Cnn+2RmGa6tAvpBDG8TNOwBJB2VzLog6vzykU6Jf1hUaMpz0h49S9/PFwr73Qh9P
         apFqjs3ip7SXG3miMaQVuhSlYAkq7z9/Aj+/fCZiGohfU+ZRsXkiQqzNIlb/GHos5YRO
         Mhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782334863; x=1782939663;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tp9es+PbpOVzt6NQoYl+lTdhFn1wTpGBlO8nUPt+1No=;
        b=Oh1NwKIbYYo3Ouwbw1R+mE3mMzwF/CJsdfOzcrFrsqqfCYJyLh+phPnESx7v9eEDc+
         6KtOzjgIzkbDIh+MplR/8KfHgsBfddQyNiJHbKzYckd3Og7bUiiCrjFAQO2mXAKCvSK4
         qPQszxrnTArlR30FXLXHPKOPpndiqkIGxmS+NxeoonrXZ70L/OoHxxb/OooxbEznFCq+
         o1A6+kAUpoDavSRUCZnOia4s8caiXpPSdIylm2SkeT/X0GK2vjQwZH2xvw512kZWkXJr
         m0B4JCO+MI7pLsQrj6KxnjBgq5eAloGXmdcW9zpmDI7ygxznEnHFMQm9kFymHZksW8pd
         iGIA==
X-Forwarded-Encrypted: i=1; AFNElJ/nRYAqvdQX0YXy+KnHncSczcZsDGzdv1OA7AU2L+ktTc4KETWAmr0MKOmJ23yxYKdsUNE7U3Fggeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SZo9LmsYuEZYtOHgxAnOZU+h+mLYPaWmtYsfzOUa951pxvwB
	eovBZiLdLA7r8rf2JdLJtkMbsTrviUbSvt6PlV/UQlSpJy9zDIgrPHuR
X-Gm-Gg: AfdE7cn5Tl93MT8/5vRnk7P2lLgq4pA5bmdSn97ubc8z4xQfuFIr7vXRM9RiWArujn0
	UXLZFBDDCS3iZPXe4+gUzMVI33trhe5tuHLj0p4jfCwAYQ4njXHTEEOHG+wUwegjT03naUA/6VL
	fr5VSlPaNUxl5+5N/B4IZea/beC5Cnz8ZOmbM8VBrMKhqQB4yj3euO7cLY068KuA7MRZfMC6VTe
	FKdL7mqpF8z4+vliqxW6tffIEoNkCUmiPPq6f0bbvvMxIExfPCL1JALOPh9ApyGQXP8rOjQaQBq
	pkbHZ+nWHPU+kS23c6oexKRvw7KFcZmz2fsiH5bbf4+lC3mxyhnseAoqRDlHKGmnkrR0EFAy+xL
	LFyTiHx9+Sfe4oDLiHkqrCERp1aOh+ieBZVVLXaBk0RlkVZ2uy9mSsKNaSpbaUUSGNiydDHowq3
	xtE4BPHg3RyBQrchxMCBpZXfclrtORqfabYghshqS2R658WzsEbvp4cw==
X-Received: by 2002:a05:620a:171e:b0:915:9e84:85df with SMTP id af79cd13be357-9277c6c3e9fmr825894985a.17.1782334848182;
        Wed, 24 Jun 2026 14:00:48 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:b155:68a5:8cf5:d9e8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926005a18bfsm636729285a.37.2026.06.24.14.00.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2026 14:00:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] KASAN: slab-use-after-free in xprt_put
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <cfbe2028-c317-4d43-bc87-6004224be128@app.fastmail.com>
Date: Wed, 24 Jun 2026 17:00:16 -0400
Cc: Trond Myklebust <trondmy@kernel.org>,
 linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB32E924-DCE7-49F8-A558-5CD77574074E@gmail.com>
References: <4EB31731-B511-44E6-9019-760EED0A2BD1@gmail.com>
 <cfbe2028-c317-4d43-bc87-6004224be128@app.fastmail.com>
To: Anna Schumaker <anna@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22823-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[shuangpengkernel@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1900B6C1517

On Jun 24, 2026, at 13:40, Anna Schumaker <anna@kernel.org> wrote:
>=20
> Hi Shuangpeng,
>=20
> On Sat, Jun 6, 2026, at 10:16 PM, Shuangpeng wrote:
>> Hi Kernel Maintainers,
>>=20
>> I hit the following KASAN report while testing current upstream =
kernel:
>>=20
>> KASAN: slab-use-after-free in xprt_put
>>=20
>> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
>>=20
>> To help trigger the bug more reliably, we applied a minimal =
diagnostic patch
>> that only adds delays and print statements.
>>=20
>> The reproducer and .config files are here.
>> =
https://gist.github.com/shuangpengbai/98a27c1e3c0dc5489f117efa7c254593
>>=20
>> I=E2=80=99m happy to test debug patches or provide additional =
information.
>>=20
>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>=20
> There have been a handful of fixes in this area that were just merged
> upstream. Any chance you can check if the problem is still there with
> Linus's current tree (or with -rc1 when it releases after the =
weekend)?
>=20

Hi Anna,

I retested this on current Linus tree, f0e6f20cb52b ("Merge tag =
'ntfs3_for_7.2'"),
and it still reproduces.

The stack trace is essentially unchanged from the original report, aside =
from
expected address and line-number shifts in the newer tree:

BUG: KASAN: slab-use-after-free in xprt_put+0x13/0x50
Write of size 4 at addr ffff8881046bd000 by task kworker/1:3/8075
Workqueue: events rpc_free_client_work

Call Trace:
  xprt_put+0x13/0x50
  rpc_free_client_work+0x152/0x250
  process_scheduled_works+0x797/0xf10
  worker_thread+0x804/0xbb0
  kthread+0x2f2/0x3c0
  ret_from_fork+0x27d/0x670
  ret_from_fork_asm+0x1a/0x30

Freed by task 0 on cpu 1 at 249.878823s:
  __rcu_free_sheaf_prepare
  rcu_free_sheaf
  rcu_core
  handle_softirqs
  __irq_exit_rcu
  sysvec_apic_timer_interrupt

Thanks,
Shuangpeng


> Thanks,
> Anna
>=20
>>=20
>>=20
>> [  170.638952][   T24]=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [  170.641053][   T24] BUG: KASAN: slab-use-after-free in xprt_put=20
>> (./include/linux/instrumented.h:112=20
>> ./include/linux/atomic/atomic-instrumented.h:400=20
>> ./include/linux/refcount.h:389 ./include/linux/refcount.h:432=20
>> ./include/linux/refcount.h:450 ./include/linux/kref.h:64=20
>> net/sunrpc/xprt.c:2195)
>> [  170.643027][   T24] Write of size 4 at addr ffff8881092e1000 by =
task=20
>> kworker/1:0/24
>> [  170.645020][   T24]
>> [  170.645344][   T24] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX =
+=20
>> PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [  170.645349][   T24] Workqueue: events rpc_free_client_work
>> [  170.645375][   T24] Call Trace:
>> [  170.645390][   T24]  <TASK>
>> [  170.645394][   T24]  dump_stack_lvl (lib/dump_stack.c:94=20
>> lib/dump_stack.c:120)
>> [  170.645451][   T24]  print_report (mm/kasan/report.c:378=20
>> mm/kasan/report.c:482)
>> [  170.645514][   T24]  kasan_report (mm/kasan/report.c:595)
>> [  170.645525][   T24]  kasan_check_range (mm/kasan/generic.c:?=20
>> mm/kasan/generic.c:200)
>> [  170.645530][   T24]  xprt_put (./include/linux/instrumented.h:112=20=

>> ./include/linux/atomic/atomic-instrumented.h:400=20
>> ./include/linux/refcount.h:389 ./include/linux/refcount.h:432=20
>> ./include/linux/refcount.h:450 ./include/linux/kref.h:64=20
>> net/sunrpc/xprt.c:2195)
>> [  170.645535][   T24]  rpc_free_client_work (net/sunrpc/clnt.c:991)
>> [  170.645541][   T24]  process_scheduled_works=20
>> (kernel/workqueue.c:3314 kernel/workqueue.c:3397)
>> [  170.645557][   T24]  worker_thread (kernel/workqueue.c:3478)
>> [  170.645577][   T24]  kthread (kernel/kthread.c:436)
>> [  170.645590][   T24]  ret_from_fork (arch/x86/kernel/process.c:158)
>> [  170.645624][   T24]  ret_from_fork_asm=20
>> (arch/x86/entry/entry_64.S:245)
>> [  170.645631][   T24]  </TASK>
>> [  170.645633][   T24]
>> [  170.657540][   T24] Freed by task 0 on cpu 1 at 165.626544s:
>> [  170.657945][   T24]  kasan_save_track (mm/kasan/common.c:57=20
>> mm/kasan/common.c:78)
>> [  170.658274][   T24]  kasan_save_free_info (mm/kasan/generic.c:584)
>> [  170.658632][   T24]  __kasan_slab_free (mm/kasan/common.c:253=20
>> mm/kasan/common.c:285)
>> [  170.658965][   T24]  __rcu_free_sheaf_prepare=20
>> (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:2940)
>> [  170.659363][   T24]  rcu_free_sheaf (mm/slub.c:5850)
>> [  170.659693][   T24]  rcu_core (kernel/rcu/tree.c:2617=20
>> kernel/rcu/tree.c:2869)
>> [  170.659997][   T24]  handle_softirqs (kernel/softirq.c:622)
>> [  170.660335][   T24]  __irq_exit_rcu (kernel/softirq.c:656=20
>> kernel/softirq.c:496 kernel/softirq.c:735)
>> [  170.660657][   T24]  sysvec_apic_timer_interrupt=20
>> (arch/x86/kernel/apic/apic.c:1061 arch/x86/kernel/apic/apic.c:1061)
>> [  170.661058][   T24]  asm_sysvec_apic_timer_interrupt=20
>> (./arch/x86/include/asm/idtentry.h:697)
>> [  170.661480][   T24]
>> [  170.661645][   T24] The buggy address belongs to the object at=20
>> ffff8881092e1000
>> [  170.661645][   T24]  which belongs to the cache kmalloc-2k of size=20=

>> 2048
>> [  170.662610][   T24] The buggy address is located 0 bytes inside of
>> [  170.662610][   T24]  freed 2048-byte region [ffff8881092e1000,=20
>> ffff8881092e1800)
>>=20
>> Best,
>> Shuangpeng


