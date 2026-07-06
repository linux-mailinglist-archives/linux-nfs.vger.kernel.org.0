Return-Path: <linux-nfs+bounces-23052-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cOAyJHRRS2okPQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23052-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:55:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C9370D369
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:55:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23052-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23052-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2EAB316AFCB
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 06:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FAD3F65E5;
	Mon,  6 Jul 2026 06:21:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9FC3C5DC3;
	Mon,  6 Jul 2026 06:21:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318897; cv=none; b=V05sNCRX7YtW2FskqmQ1D2Kn8WmNAqMVlyCK+sG47RQsMbrs6BhBlphkkBnMnMs24sdGFNSMjLA3/WIkTuzrM5zyhdFj6zKdh91k61YS0wZDDVzhdQZG6pEmjVqPO/P/EsBDiYYkO77ErWphm1nox2IBHubA0MP3vlAad1a5xBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318897; c=relaxed/simple;
	bh=zDQdYdTFavgacMtdiXy3/hskR9xaYH1DaF21getAMWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GNSkDN98Cvnd6admLCwwFiAcLGxwLcSPLuy/p+GsZj7X3Mokkn4dZfl5ELX90cE/3PRmyVKDTvq/yORLCYFvFqNnalrdx7v4O6PuQyCUvIVy73YIi0H6Ceie96I2gCDLjhi4vjVivQC0f2b1CtJKbeBwd7oXwInIqPVQDcF267A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c45ff70000001609-2d-6a4b4905bbfc
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: max.byungchul.park@gmail.com,
	kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yunseong.kim@ericsson.com,
	ysk@kzalloc.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	sumit.semwal@linaro.org,
	gustavo@padovan.org,
	christian.koenig@amd.com,
	andi.shyti@kernel.org,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	chuck.lever@oracle.com,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	wangkefeng.wang@huawei.com,
	broonie@kernel.org,
	kevin.brodsky@arm.com,
	dwmw@amazon.co.uk,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	ziy@nvidia.com,
	yuzhao@google.com,
	baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com,
	joel.granados@kernel.org,
	richard.weiyang@gmail.com,
	geert+renesas@glider.be,
	tim.c.chen@linux.intel.com,
	linux@treblig.org,
	alexander.shishkin@linux.intel.com,
	lillian@star-ark.net,
	chenhuacai@kernel.org,
	francesco@valla.it,
	guoweikang.kernel@gmail.com,
	link@vivo.com,
	jpoimboe@kernel.org,
	masahiroy@kernel.org,
	brauner@kernel.org,
	thomas.weissschuh@linutronix.de,
	oleg@redhat.com,
	mjguzik@gmail.com,
	andrii@kernel.org,
	wangfushuai@baidu.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	2407018371@qq.com,
	dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	neilb@ownmail.net,
	bagasdotme@gmail.com,
	wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com,
	geert@linux-m68k.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v19 33/40] dept: call dept_hardirqs_off() in local_irq_*() regardless of irq state
Date: Mon,  6 Jul 2026 15:19:21 +0900
Message-Id: <20260706061928.66713-34-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxjG/Z87nZWTasYRs2BqcNpFFEHzxrnNffJ4y0yW7MMWo904Slmh
	TatcTAytihEHUru0BgoEYUOk5RKKFzpRrFAE2tACYlVAqq6MYMWoZZuUsML0y5snz/O8v08P
	g0uGyXhGkXVU0GTJlVJKRIhCSy9tYHbtydgUsLNwtiAfhvUdBJQ32SiYs1yn4d6DkwR4G60I
	/p614GDSI5hvdyEw+4w4XJzUE1AWtNAw2bUT5kcnMJgyv6Jg1tOPQ6trDEF73UkKBp8vg6Hw
	NAUhXzkGL5sp8LmnEFRYjAiCj9oxOFXTREHbuIMG31QEgxGzEQNryz7oM1RjYLl4CgNTwx8Y
	uGtGCKjVJYLFM0hCJJAM81UqcFknaBgtMRHQGOonoWdsmISpoJGC67pxGt4OBTA46wgT0PIs
	GpRWjlDguvEUg0FHOQVFzVdJGLPNk+Dt6CNhwOoloGnCj0Gf6x4BPWVXCHjsKaGh39FAgt3j
	xmHm/CrwXigmwW/4E0HDy2pqRxpfb7+G8bZKG+ILDNFz98U0zv/e94Li34XvU3xvNcf/VvgO
	4y94NvBtZaM0f/rWI5qvajnGn+4Mkby9TsbX3JzE+Euvw+T+5O9F29MEpSJb0Gz88pAo/a/h
	AlKtj80N2kCHQh+dQzEMx6ZyrbcHsA+6v1VPLGiK/ZTz+//FF/QKdjVnLw6S55CIwdnBBK6o
	tnixtJz9kTOHxqIlhiHYRK54SL1gi9mtXO01w3tmAmdt7ljkxET9xkjFoi9ht3CPp7uJBSbH
	Xo7hTPW95P8PK7k7dX7CgMRVaEk9kiiysjPlCmVqUnpeliI36SdVZguKrq32ROSHG+i191sn
	YhkkXSqGHbszJKQ8W5uX6UQcg0tXiNeu25MhEafJ844LGtVBzTGloHWiVQwhjRNvnslJk7BH
	5EeFnwVBLWg+pBgTE69DFWcCsfmxm2Rfd5pK26oSfKXrfBH2WfevPTu7TBZ3ZQ9a82SJk0kJ
	9K5RQX78P2y5LnVOJatWqVNUb745MKPccqij8JcjszkfG90O+ulxKvFKUUn21r3jh9VnZPRA
	3Of738geblPkGMxfhDMLI7s/62bn8j+5v/6rJ0kJztxk7XdSQpsuT5bhGq38PzJOGWtpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xScRTH+90XV5K6Ec07bdlYT0urle30WPbmmus129r6p6juEgUzKItW
	SyCmPWxEgUs0zZI1pTIflDWWs2UPa0n2cOWjB1FOiVZY+UBDW/+cfc/nfM93549D42InGUkr
	0vfz6nS5UkoJCeGGJYZYMjEpde4JxxzIMR6D1g4PCa91dQT0BHIIKLjhoCBouyWAnMoLJDx6
	oyeg6Xo5go6eHAS/+204GGuHCAiaGwQQ6H0nAIsOwZCrAYHVbcahpekeDo5qHQY/KwYp6Lr/
	A4Hlg4eCvE4dAX77aQT5XpsAOh/IwNdxl4Shti8YvPnVjcDuGcTAU5eNIGhNg6KSqtC69TsF
	/c+e45BnaUJw6UMbDj863yOobmhH4Lqqp+CzqQaHZs8YeNnjp+Cx5RQFPncBBt8qKCjWu0hw
	P+1CUGgzI/C+dWFguHyDAmthJQG17+8IwN01gEGr1YxBeeV66LB7CWg0lWChc0OumxFgyzNg
	ofIVA8u1uxj02ssEy0sR99t4huDKqpwYZ3wRpDjHRQfi+vvMiAuUGnDOaAq197v9OHe86iBX
	2thNcX09ryjO9auY4J6UsNyVE30Yd/ZZLFeb3ybYtGKbcOluXqnI5NVzlu0Qpnx9bSQzdGMP
	eR2QhXyjT6IwmmUWsM+rdcSwppjpbEtLLz6sJcxktirXS55EQhpnmqPZ0/bcEdN4Zidr9bWH
	TDRNMFPZ3JcZw1jELGTtThP2LzOaLa+oG8kJC/HrA4UjXMzEs+/8DwkTEhajUWVIokjPVMkV
	yvg4TVqKNl1xKG7XXlUlCn2T/ejA2dso0CyrRwyNpOEiWL4uVUzKMzVaVT1iaVwqEU2bkZQq
	Fu2Waw/z6r3b1QeUvKYeRdGENEK0biu/Q8zske/n03g+g1f/n2J0WGQWulWTrfRLuFFrHdPu
	zIjJ7t066WPUqnPYlORA8Jg2fO30yT7JlVUDWRPVTnf827hZ81dPiNJGvpiavCjxJlqcXIav
	UanOxSQcWR3VvuXy5i/hR/cl/BkXiNZr/Pol9bNlO396Z9ZuDPTrGrelnTl/QC4rkh3+HPuA
	SJj/9NPKmsEVW45ICU2KfF4MrtbI/wIjatboSQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[sk.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,skhynix.com,linux-foundation.org,opensource.wdc.com,vger.kernel.org,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:max.byungchul.park@gmail.com,m:kernel_team@skhynix.com,m:torvalds@linux-foundation.org,m:damien.lemoal@opensource.wdc.com,m:linux-ide@vger.kernel.org,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:mingo@redhat.com,m:peterz@infradead.org,m:will@kernel.org,m:tglx@linutronix.de,m:rostedt@goodmis.org,m:joel@joelfernandes.org,m:sashal@kernel.org,m:daniel.vetter@ffwll.ch,m:duyuyang@gmail.com,m:johannes.berg@intel.com,m:tj@kernel.org,m:tytso@mit.edu,m:willy@infradead.org,m:david@fromorbit.com,m:amir73il@gmail.com,m:gregkh@linuxfoundation.org,m:kernel-team@lge.com,m:linux-mm@kvack.org,m:akpm@linux-foundation.org,m:mhocko@kernel.org,m:minchan@kernel.org,m:hannes@cmpxchg.org,m:vdavydov.dev@gmail.com,m:sj@kernel.org,m:jglisse@redhat.com,m:dennis@kernel.org,m:cl@linux.com,m:penberg@kernel.org,m:rientjes@google.com,m:vbabka@suse.cz,m:ngupta@vflare.org,m:linux-block@vger.kernel.org,m:josef@toxicpanda.com,m:linux-fsdevel@vger.kern
 el.org,m:jack@suse.cz,m:jlayton@kernel.org,m:dan.j.williams@intel.com,m:hch@infradead.org,m:djwong@kernel.org,m:dri-devel@lists.freedesktop.org,m:rodrigosiqueiramelo@gmail.com,m:melissa.srw@gmail.com,m:hamohammed.sa@gmail.com,m:harry.yoo@oracle.com,m:chris.p.wilson@intel.com,m:gwan-gyeong.mun@intel.com,m:boqun.feng@gmail.com,m:longman@redhat.com,m:yunseong.kim@ericsson.com,m:ysk@kzalloc.com,m:yeoreum.yun@arm.com,m:netdev@vger.kernel.org,m:matthew.brost@intel.com,m:her0gyugyu@gmail.com,m:corbet@lwn.net,m:catalin.marinas@arm.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:luto@kernel.org,m:sumit.semwal@linaro.org,m:gustavo@padovan.org,m:christian.koenig@amd.com,m:andi.shyti@kernel.org,m:arnd@arndb.de,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:rppt@kernel.org,m:surenb@google.com,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:jo
 sh@joshtriplett.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[byungchul@sk.com,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23052-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_GT_50(0.00)[165];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7C9370D369

For dept to function properly, dept_task()->hardirqs_enabled must be set
correctly.  If it fails to set this value to false, for example, dept
may mistakenly think irq is still enabled even when it's not.

Do dept_hardirqs_off() regardless of irq state not to miss any
unexpected cases by any chance e.g. changes of the state by asm code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/irqflags.h | 14 ++++++++++++++
 kernel/dependency/dept.c |  1 +
 2 files changed, 15 insertions(+)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index d8b9cf093f83..586f5bad4da7 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -214,6 +214,13 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_disable();		\
 		if (!was_disabled)			\
 			trace_hardirqs_off();		\
+		/*					\
+		 * Just in case that C code has missed	\
+		 * trace_hardirqs_off() at the first	\
+		 * place e.g. disabling irq at asm code.\
+		 */					\
+		else					\
+			dept_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_save(flags)				\
@@ -221,6 +228,13 @@ extern void warn_bogus_irq_restore(void);
 		raw_local_irq_save(flags);		\
 		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_off();		\
+		/*					\
+		 * Just in case that C code has missed	\
+		 * trace_hardirqs_off() at the first	\
+		 * place e.g. disabling irq at asm code.\
+		 */					\
+		else					\
+			dept_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_restore(flags)			\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 007e1bc7d201..35a3667ac8b3 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2095,6 +2095,7 @@ void noinstr dept_hardirqs_off(void)
 	 */
 	dept_task()->hardirqs_enabled = false;
 }
+EXPORT_SYMBOL_GPL(dept_hardirqs_off);
 
 void noinstr dept_update_cxt(void)
 {
-- 
2.17.1


