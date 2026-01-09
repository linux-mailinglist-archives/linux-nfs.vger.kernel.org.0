Return-Path: <linux-nfs+bounces-17713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C839D0C5C8
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 22:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C584D300EBA8
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A828462;
	Fri,  9 Jan 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTHlBy3+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F48F49
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767995161; cv=none; b=Rq4WHmtTNWzMS1Ck+6JwZZk4YesO2bcFZcj/foD7vgoeNDfuHET2l73xRS+44tA9AXUf1NvTTDX67RCheNkp+4N582wX0NKlS2reALJ6bMOJueIt7J4mBm22rIXBY4RGK4yR5YCxKmdn0msSDumZDTqjB8WRjgxeL8IRLYS30mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767995161; c=relaxed/simple;
	bh=mbbQ4o9RmPpPn92iORj5QP4seNMsZQDrG6oEfU1i52g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5Vx3BHS2E90VDVRRb8aSyr8VZmw456X+Sa3wV7a3kE0W3qWc3IcdvvXJm1GjMGPoWiGTwkPRzgBEAeeKI6/JrG4tq1ebD6pMEsnfrinWe9ODHnoF6XTdXEo/YGmfy5g0iErVnOEmnf+LGiQMXJ2GJraW87+Oneb8nHHEEULpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTHlBy3+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso50077011cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 09 Jan 2026 13:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767995158; x=1768599958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rL++8pWq6jIlaqD3oJhmNjEvgxeeRpcKtDmQV18E4Kc=;
        b=QTHlBy3+5LU5Yt/QJ+0dZ49u21TSX+D4zHYCz93qm6EFx5MDpqAn/aJsrVY+ymoLl3
         hjdSd3aSlhwuurOYtIa2r2ftcM77Q91kscSAUHomj6W/kMBn3bbwUdCe9ypoUvUoEu94
         Ug4XF78ZFHwWRupsGRFR83A+TwpocQaYZQPRW91y/A3w/AT1O4AS6O9lLoxwOE/3xGBs
         wP0RFmhwdtBmN8MEa3ZgK8/92ATMWcc+IFVaF76X857Dy4UcE+dyjri7c/+5VZ2E/eq2
         qJdAnHB0yjVAd8im0zv6PCO6eo7yZ0uGpDzsoTF3RIZjVjrVPW/kCy8XFGAj7XQRvm0e
         6CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767995158; x=1768599958;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL++8pWq6jIlaqD3oJhmNjEvgxeeRpcKtDmQV18E4Kc=;
        b=Kk8VzLl/m6BkJsVWXJyJJZMaLyy9W4l59TO98sQuPsQqhcFlORFJfT/CiZy8cj+P6X
         6A3QyBju0JqrfjfwLx8OpDP7mLO8Y7QELfzJYvtj7eoNwzGjYeLfDy13PV7x9gasxB1/
         LR2aYzTVrxyNCA23120rZ+ETO+MWyQW2LNzHu6t6XqaRulXJl8jRhKdiiZNNhl94SsED
         es5ZIL+Eyu79R0X5vwCvIJmMcDmXtb7IQBiPQjviSTuJfCmk47N36sUuoy2nvhnT9kyQ
         mJ5OrErYPSHnJfPAcGNNZqP6eq+QaRh4mIOxDm+jAJ2hja18/6muR6tkFizMY4bSdttI
         j7EA==
X-Gm-Message-State: AOJu0YwgIPbgqNpsLkEv3sdnkAziZ+2V2UEI7Uxy1ZezKHfzqADjVLoB
	85s4R9iDYb0o/6cMylT7iH7kHaiopw5lqU0WVGRq9uOWN4IVYbpIRPM9YybvZs12keeQbJOkGF/
	kPTUqbdWB481bwf1gWyVtoiaWQ2MvFc0=
X-Gm-Gg: AY/fxX7dSqHQNcS59iEWrpLG2dogs5Scg6eZR33l2mUGpPTRiJplNKp/0wNTgozJR3A
	z6C3LBn2m33VpeYYsNhSJhyjp0azaV9ekWha8e2zF+aUGqZXVBSE7LFAUKb5g/W4MdjQFE1QNll
	8cbtZV+mWskKRS/ndIPk3pQP5mWi/oj9b0uAJur/oIlJaZg7qpQbcCCZTi80K3cz9ezzIWPKJJX
	w76ecFg+81M7QiICYs3V7AU4Jro7hdSM6cDLqHqdbqp2NZLrCQ6YK2E3FpvTbYl5UWPf+z9aYEj
	Hpvo58UX0zvuaMP8pHv6++u3lw==
X-Google-Smtp-Source: AGHT+IGrinvXEY9OiYce+TV+BKLbJYrAdI9M0klPPYSTRtwqsSg1j27qRT3ooq85Ii1ZYUs7EEJkOm4GXqgNT2XGS4c=
X-Received: by 2002:ac8:5f8f:0:b0:4f1:b6bc:5833 with SMTP id
 d75a77b69052e-4ffb499a295mr144212351cf.54.1767995158057; Fri, 09 Jan 2026
 13:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
 <CAPt2mGOV+ZxVLkFFXRKX3Cr9vZ-pd=5QeN=cxwc_msGFtpPN=Q@mail.gmail.com>
In-Reply-To: <CAPt2mGOV+ZxVLkFFXRKX3Cr9vZ-pd=5QeN=cxwc_msGFtpPN=Q@mail.gmail.com>
Reply-To: mjnowen@gmail.com
From: Mike Owen <mjnowen@gmail.com>
Date: Fri, 9 Jan 2026 21:45:47 +0000
X-Gm-Features: AZwV_QhZdvrq4i5rbNq5OOb6VAebBhgj0Jieics57bjPw1K6HG8B62yseqEm4bk
Message-ID: <CADFF-zcFgycZ7c0KC_5eUafjvba_ZxhzED0a7yDR4oip4_KxbA@mail.gmail.com>
Subject: Re: fscache/NFS re-export server lockup
To: Daire Byrne <daire@dneg.com>, dhowells@redhat.com
Cc: linux-nfs@vger.kernel.org, netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Daire, thanks for the comments.

> Can you stop the nfs server and is access to /var/cache/fscache still blocked?
As the machine is deadlocked, after reboot (so the nfs server is
definitely stopped), the actual data is gone/corrupted.

>And I presume there is definitely nothing else that might be
interacting with that /var/cache/fscache filesystem outside of fscache
or cachefilesd?
Correct. Machine is dedicated to KNFSD caching duties.

> Our /etc/cachefilesd.conf is pretty basic (brun 30%, bcull 10%, bstop 3%).
Similar settings here:
brun 20%
bcull 7%
bstop 3%
frun 20%
fcull 7%
fstop 3%
Although I should note that the issue happens when only ~10-20% of the
NVMe capacity is used, so culling has never had to run at this point.

We did try running 6.17.0 but made no difference. I see another thread
of yours with Chuck: "refcount_t underflow (nfsd4_sequence_done?) with
v6.18 re-export"
and suggested commits to investigate, incl: cbfd91d22776 ("nfsd: never
defer requests during idmap lookup") as well as try using 6.18.4, so
it's possible there is a cascading issue here and we are in need of
some NFS patches.

I'm hoping @dhowells might have some suggestions on how to further
debug this issue, given the below stack we are seeing when it
deadlocks?

Thanks,
-Mike

2025-12-03T15:54:24.189530+00:00 ip-172-23-113-43 kernel: netfs:
fscache_begin_operation: cookie state change wait timed out:
cookie->state=1 state=1
2025-12-03T15:54:24.189546+00:00 ip-172-23-113-43 kernel: netfs:
fscache_begin_operation: cookie state change wait timed out:
cookie->state=1 state=1
2025-12-03T15:54:24.189549+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie c=00049c53 [fl=6124 na=1 nA=2 s=L]
2025-12-03T15:54:24.189550+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie c=0004ddfe [fl=4124 na=1 nA=2 s=L]
2025-12-03T15:54:24.189551+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie V=0000000a
[Enfs,4.2,2,108,887517ac,2,,,50,100000,100000,927c0,927c0,927c0,927c0,1]
2025-12-03T15:54:24.189552+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie V=0000000f
[Enfs,4.2,2,108,887517ac,3,,,50,100000,100000,927c0,927c0,927c0,927c0,1]
2025-12-03T15:54:24.189553+00:00 ip-172-23-113-43 kernel: netfs:
O-key=[56] '0100010c0200000008000000e7ba9075008000002000f360d67b09000000e7ba907508000000ffffffff000000000b00700b010000000000'
2025-12-03T15:54:24.190876+00:00 ip-172-23-113-43 kernel: netfs:
O-key=[56] '0100010c03000000070000002fbb9934008000002000f360d67b060000002fbb993407000000ffffffff000000000200c109010000000000'
2025-12-03T15:54:24.702103+00:00 ip-172-23-113-43 kernel: netfs:
fscache_begin_operation: cookie state change wait timed out:
cookie->state=1 state=1
2025-12-03T15:54:24.702112+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie c=000404b3 [fl=6124 na=1 nA=2 s=L]
2025-12-03T15:54:24.702113+00:00 ip-172-23-113-43 kernel: netfs:
O-cookie V=0000000f
[Enfs,4.2,2,108,887517ac,3,,,50,100000,100000,927c0,927c0,927c0,927c0,1]
2025-12-03T15:54:24.703856+00:00 ip-172-23-113-43 kernel: netfs:
O-key=[56] '0100010c03000000070000007ece2438008000002000f360d67b060000007ece243807000000ffffffff000000000200c109010000000000'
2025-12-03T15:57:25.438905+00:00 ip-172-23-113-43 kernel: INFO: task
kcompactd0:171 blocked for more than 122 seconds.
2025-12-03T15:57:25.438921+00:00 ip-172-23-113-43 kernel:
Tainted: G           OE      6.14.0-36-generic #36~24.04.1-Ubuntu
2025-12-03T15:57:25.438928+00:00 ip-172-23-113-43 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
2025-12-03T15:57:25.439 is bellow995+00:00 ip-172-23-113-43 kernel:
task:kcompactd0      state:D stack:0     pid:171   tgid:171   ppid:2
   task_flags:0x210040 flags:0x00004000
2025-12-03T15:57:25.440000+00:00 ip-172-23-113-43 kernel: Call Trace:
2025-12-03T15:57:25.440000+00:00 ip-172-23-113-43 kernel:  <TASK>
2025-12-03T15:57:25.440003+00:00 ip-172-23-113-43 kernel:
__schedule+0x2cf/0x640
2025-12-03T15:57:25.441017+00:00 ip-172-23-113-43 kernel:  schedule+0x29/0xd0
2025-12-03T15:57:25.441022+00:00 ip-172-23-113-43 kernel:  io_schedule+0x4c/0x80
2025-12-03T15:57:25.441023+00:00 ip-172-23-113-43 kernel:
folio_wait_bit_common+0x138/0x310
2025-12-03T15:57:25.441023+00:00 ip-172-23-113-43 kernel:  ?
__pfx_wake_page_function+0x10/0x10
2025-12-03T15:57:25.441024+00:00 ip-172-23-113-43 kernel:
folio_wait_private_2+0x2c/0x60
2025-12-03T15:57:25.441025+00:00 ip-172-23-113-43 kernel:
nfs_release_folio+0xa0/0x120 [nfs]
2025-12-03T15:57:25.441032+00:00 ip-172-23-113-43 kernel:
filemap_release_folio+0x68/0xa0
2025-12-03T15:57:25.441033+00:00 ip-172-23-113-43 kernel:
split_huge_page_to_list_to_order+0x401/0x970
2025-12-03T15:57:25.441033+00:00 ip-172-23-113-43 kernel:  ?
compaction_alloc_noprof+0x1c5/0x2f0
2025-12-03T15:57:25.441034+00:00 ip-172-23-113-43 kernel:
split_folio_to_list+0x22/0x70
2025-12-03T15:57:25.441035+00:00 ip-172-23-113-43 kernel:
migrate_pages_batch+0x2f2/0xa70
2025-12-03T15:57:25.441035+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_free+0x10/0x10
2025-12-03T15:57:25.441038+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_alloc+0x10/0x10
2025-12-03T15:57:25.441039+00:00 ip-172-23-113-43 kernel:  ?
__mod_memcg_lruvec_state+0xf4/0x250
2025-12-03T15:57:25.441039+00:00 ip-172-23-113-43 kernel:  ?
migrate_pages_batch+0x5e8/0xa70
2025-12-03T15:57:25.441040+00:00 ip-172-23-113-43 kernel:
migrate_pages_sync+0x84/0x1e0
2025-12-03T15:57:25.441040+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_free+0x10/0x10
2025-12-03T15:57:25.441041+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_alloc+0x10/0x10
2025-12-03T15:57:25.441044+00:00 ip-172-23-113-43 kernel:
migrate_pages+0x38f/0x4c0
2025-12-03T15:57:25.441047+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_free+0x10/0x10
2025-12-03T15:57:25.441048+00:00 ip-172-23-113-43 kernel:  ?
__pfx_compaction_alloc+0x10/0x10
2025-12-03T15:57:25.441048+00:00 ip-172-23-113-43 kernel:
compact_zone+0x385/0x700
2025-12-03T15:57:25.441049+00:00 ip-172-23-113-43 kernel:  ?
isolate_migratepages_range+0xc1/0xf0
2025-12-03T15:57:25.441049+00:00 ip-172-23-113-43 kernel:
kcompactd_do_work+0xfc/0x240
2025-12-03T15:57:25.441050+00:00 ip-172-23-113-43 kernel:  kcompactd+0x43f/0x4a0
2025-12-03T15:57:25.441052+00:00 ip-172-23-113-43 kernel:  ?
__pfx_autoremove_wake_function+0x10/0x10
2025-12-03T15:57:25.441053+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kcompactd+0x10/0x10
2025-12-03T15:57:25.441053+00:00 ip-172-23-113-43 kernel:  kthread+0xfe/0x230
2025-12-03T15:57:25.441054+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.441054+00:00 ip-172-23-113-43 kernel:
ret_from_fork+0x47/0x70
2025-12-03T15:57:25.441055+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.441057+00:00 ip-172-23-113-43 kernel:
ret_from_fork_asm+0x1a/0x30
2025-12-03T15:57:25.441058+00:00 ip-172-23-113-43 kernel:  </TASK>
2025-12-03T15:57:25.441059+00:00 ip-172-23-113-43 kernel: INFO: task
jbd2/md127-8:6401 blocked for more than 122 seconds.
2025-12-03T15:57:25.441059+00:00 ip-172-23-113-43 kernel:
Tainted: G           OE      6.14.0-36-generic #36~24.04.1-Ubuntu
2025-12-03T15:57:25.443097+00:00 ip-172-23-113-43 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
2025-12-03T15:57:25.445001+00:00 ip-172-23-113-43 kernel:
task:jbd2/md127-8    state:D stack:0     pid:6401  tgid:6401  ppid:2
   task_flags:0x240040 flags:0x00004000
2025-12-03T15:57:25.445005+00:00 ip-172-23-113-43 kernel: Call Trace:
2025-12-03T15:57:25.445006+00:00 ip-172-23-113-43 kernel:  <TASK>
2025-12-03T15:57:25.445006+00:00 ip-172-23-113-43 kernel:
__schedule+0x2cf/0x640
2025-12-03T15:57:25.445007+00:00 ip-172-23-113-43 kernel:  schedule+0x29/0xd0
2025-12-03T15:57:25.445007+00:00 ip-172-23-113-43 kernel:
jbd2_journal_wait_updates+0x71/0xf0
2025-12-03T15:57:25.445008+00:00 ip-172-23-113-43 kernel:  ?
__pfx_autoremove_wake_function+0x10/0x10
2025-12-03T15:57:25.445008+00:00 ip-172-23-113-43 kernel:
jbd2_journal_commit_transaction+0x26e/0x1800
2025-12-03T15:57:25.445009+00:00 ip-172-23-113-43 kernel:  ?
__update_idle_core+0x58/0x130
2025-12-03T15:57:25.445010+00:00 ip-172-23-113-43 kernel:  ?
psi_group_change+0x201/0x4e0
2025-12-03T15:57:25.445010+00:00 ip-172-23-113-43 kernel:  ?
psi_task_switch+0x130/0x3a0
2025-12-03T15:57:25.445011+00:00 ip-172-23-113-43 kernel:  kjournald2+0xaa/0x250
2025-12-03T15:57:25.445011+00:00 ip-172-23-113-43 kernel:  ?
__pfx_autoremove_wake_function+0x10/0x10
2025-12-03T15:57:25.445012+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kjournald2+0x10/0x10
2025-12-03T15:57:25.445012+00:00 ip-172-23-113-43 kernel:  kthread+0xfe/0x230
2025-12-03T15:57:25.445015+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.445016+00:00 ip-172-23-113-43 kernel:
ret_from_fork+0x47/0x70
2025-12-03T15:57:25.445017+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.445018+00:00 ip-172-23-113-43 kernel:
ret_from_fork_asm+0x1a/0x30
2025-12-03T15:57:25.445018+00:00 ip-172-23-113-43 kernel:  </TASK>
2025-12-03T15:57:25.445019+00:00 ip-172-23-113-43 kernel: INFO: task
nfsd:6783 blocked for more than 122 seconds.
2025-12-03T15:57:25.445020+00:00 ip-172-23-113-43 kernel:
Tainted: G           OE      6.14.0-36-generic #36~24.04.1-Ubuntu
2025-12-03T15:57:25.445023+00:00 ip-172-23-113-43 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
2025-12-03T15:57:25.447708+00:00 ip-172-23-113-43 kernel: task:nfsd
        state:D stack:0     pid:6783  tgid:6783  ppid:2
task_flags:0x240040 flags:0x00004000
2025-12-03T15:57:25.447713+00:00 ip-172-23-113-43 kernel: Call Trace:
2025-12-03T15:57:25.447714+00:00 ip-172-23-113-43 kernel:  <TASK>
2025-12-03T15:57:25.447714+00:00 ip-172-23-113-43 kernel:
__schedule+0x2cf/0x640
2025-12-03T15:57:25.447715+00:00 ip-172-23-113-43 kernel:  schedule+0x29/0xd0
2025-12-03T15:57:25.447716+00:00 ip-172-23-113-43 kernel:
schedule_preempt_disabled+0x15/0x30
2025-12-03T15:57:25.447716+00:00 ip-172-23-113-43 kernel:
rwsem_down_read_slowpath+0x261/0x490
2025-12-03T15:57:25.447717+00:00 ip-172-23-113-43 kernel:  ?
mempool_alloc_slab+0x15/0x20
2025-12-03T15:57:25.447717+00:00 ip-172-23-113-43 kernel:  down_read+0x48/0xd0
2025-12-03T15:57:25.447718+00:00 ip-172-23-113-43 kernel:
ext4_llseek+0xfc/0x120
2025-12-03T15:57:25.447719+00:00 ip-172-23-113-43 kernel:  vfs_llseek+0x1c/0x40
2025-12-03T15:57:25.447719+00:00 ip-172-23-113-43 kernel:
cachefiles_do_prepare_read+0xc1/0x3d0 [cachefiles]
2025-12-03T15:57:25.447720+00:00 ip-172-23-113-43 kernel:
cachefiles_prepare_read+0x32/0x50 [cachefiles]
2025-12-03T15:57:25.447720+00:00 ip-172-23-113-43 kernel:
netfs_read_to_pagecache+0xc1/0x530 [netfs]
2025-12-03T15:57:25.447721+00:00 ip-172-23-113-43 kernel:
netfs_readahead+0x169/0x270 [netfs]
2025-12-03T15:57:25.447735+00:00 ip-172-23-113-43 kernel:
nfs_netfs_readahead+0x1f/0x40 [nfs]
2025-12-03T15:57:25.447736+00:00 ip-172-23-113-43 kernel:
nfs_readahead+0x184/0x2b0 [nfs]
2025-12-03T15:57:25.447737+00:00 ip-172-23-113-43 kernel:  read_pages+0x85/0x220
2025-12-03T15:57:25.447737+00:00 ip-172-23-113-43 kernel:  ?
__pfx_workingset_update_node+0x10/0x10
2025-12-03T15:57:25.447738+00:00 ip-172-23-113-43 kernel:
page_cache_ra_unbounded+0x18e/0x240
2025-12-03T15:57:25.447738+00:00 ip-172-23-113-43 kernel:
page_cache_sync_ra+0x228/0x230
2025-12-03T15:57:25.447739+00:00 ip-172-23-113-43 kernel:
filemap_get_pages+0x133/0x4a0
2025-12-03T15:57:25.447740+00:00 ip-172-23-113-43 kernel:
filemap_splice_read+0x155/0x380
2025-12-03T15:57:25.447740+00:00 ip-172-23-113-43 kernel:  ?
find_inode+0xd9/0x100
2025-12-03T15:57:25.447741+00:00 ip-172-23-113-43 kernel:
nfs_file_splice_read+0xba/0xf0 [nfs]
2025-12-03T15:57:25.447741+00:00 ip-172-23-113-43 kernel:
do_splice_read+0x63/0xe0
2025-12-03T15:57:25.447742+00:00 ip-172-23-113-43 kernel:
splice_direct_to_actor+0xb1/0x260
2025-12-03T15:57:25.447743+00:00 ip-172-23-113-43 kernel:  ?
__pfx_nfsd_direct_splice_actor+0x10/0x10 [nfsd]
2025-12-03T15:57:25.447743+00:00 ip-172-23-113-43 kernel:
nfsd_splice_read+0x11b/0x130 [nfsd]
2025-12-03T15:57:25.447744+00:00 ip-172-23-113-43 kernel:
nfsd4_encode_splice_read+0x65/0x120 [nfsd]
2025-12-03T15:57:25.447744+00:00 ip-172-23-113-43 kernel:
nfsd4_encode_read+0x132/0x170 [nfsd]
2025-12-03T15:57:25.447745+00:00 ip-172-23-113-43 kernel:
nfsd4_encode_operation+0xd4/0x350 [nfsd]
2025-12-03T15:57:25.447745+00:00 ip-172-23-113-43 kernel:
nfsd4_proc_compound+0x1da/0x7d0 [nfsd]
2025-12-03T15:57:25.447746+00:00 ip-172-23-113-43 kernel:
nfsd_dispatch+0xd7/0x220 [nfsd]
2025-12-03T15:57:25.447746+00:00 ip-172-23-113-43 kernel:
svc_process_common+0x4c6/0x740 [sunrpc]
2025-12-03T15:57:25.447747+00:00 ip-172-23-113-43 kernel:  ?
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
2025-12-03T15:57:25.447747+00:00 ip-172-23-113-43 kernel:
svc_process+0x136/0x1f0 [sunrpc]
2025-12-03T15:57:25.447748+00:00 ip-172-23-113-43 kernel:
svc_handle_xprt+0x46e/0x570 [sunrpc]
2025-12-03T15:57:25.447751+00:00 ip-172-23-113-43 kernel:
svc_recv+0x184/0x2e0 [sunrpc]
2025-12-03T15:57:25.447752+00:00 ip-172-23-113-43 kernel:  ?
__pfx_nfsd+0x10/0x10 [nfsd]
2025-12-03T15:57:25.447752+00:00 ip-172-23-113-43 kernel:  nfsd+0x90/0xf0 [nfsd]
2025-12-03T15:57:25.447753+00:00 ip-172-23-113-43 kernel:  kthread+0xfe/0x230
2025-12-03T15:57:25.447753+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.447754+00:00 ip-172-23-113-43 kernel:
ret_from_fork+0x47/0x70
2025-12-03T15:57:25.447756+00:00 ip-172-23-113-43 kernel:  ?
__pfx_kthread+0x10/0x10
2025-12-03T15:57:25.447757+00:00 ip-172-23-113-43 kernel:
ret_from_fork_asm+0x1a/0x30
2025-12-03T15:57:25.447757+00:00 ip-172-23-113-43 kernel:  </TASK>


On Fri, 19 Dec 2025 at 17:02, Daire Byrne <daire@dneg.com> wrote:
>
> On Fri, 19 Dec 2025 at 16:25, Mike Owen <mjnowen@gmail.com> wrote:
> >
> > We are using NFS re-exporting with fscache but have had a number of
> > lockups with re-export servers.
> >
> > The NFS re-export servers are running Ubuntu 24.04 with a
> > 6.14.0-36-generic kernel mounting Isilon and NetApp filers over NFSv3.
> >
> > The NFS clients are mounting the re-exported shares over NFSv4 and
> > running AlmaLinux 9.6.
> >
> > When the re-export server locks up, it is not possible to access the
> > /var/cache/fscache directory (separate file system) on the server and
> > all clients are hanging on their mounts from the re-export.
>
> That does kind of point to a filesystem problem with /var/cache/fscache itself?
>
> Can you stop the nfs server and is access to /var/cache/fscache still blocked?
>
> > When the server is rebooted, most of the contents of the
> > /var/cache/fscache directory is missing e.g. the file system contents
> > before the lockup may have been a few TBs, but after a reboot only a
> > few hundred GBs.
>
> I can't say I've ever seen that before... we use ext4 for the fscache
> filesystem mount on /var/cache/fscache.
>
> And I presume there is definitely nothing else that might be
> interacting with that /var/cache/fscache filesystem outside of fscache
> or cachefilesd?
>
> Our /etc/cachefilesd.conf is pretty basic (brun 30%, bcull 10%, bstop 3%).
>
> > The kern.log (below) from the re-export server reports the following
> > when the lockup happens.
> >
> > We have tried using a more recent 6.17.11 kernel on the re-export
> > server and changing the fscache file system from ext4 to xfs, but
> > still have the same lockups.
>
> We were running a heavily patched v6.4 kernel for almost 2 years and
> have just updated to v6.18.1 with no patches - so far so good!
>
> We are mostly re-exporting NFSv3 -> NFSv3 (Linux NFS storage servers)
> with a small amount of NFSv3 -> NFSv4.2 (Netapps).
>
> > Any ideas on what is happening here - and how it may be fixed?
>
> Sorry I can't be more helpful.
>
> Daire

