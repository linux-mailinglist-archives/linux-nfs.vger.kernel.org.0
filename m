Return-Path: <linux-nfs+bounces-23025-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +hOkOvpJS2rhOgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23025-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:23:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1B70CE86
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:23:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23025-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23025-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEB6830277BD
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 06:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B536C3D4129;
	Mon,  6 Jul 2026 06:20:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B483CDBC0;
	Mon,  6 Jul 2026 06:19:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318801; cv=none; b=sxV/Cv8arXii8AceHcAI6jahqDM5LwGwVtOEqCehM0+E8PYkDc2hGHmZjo0XBT/wi2ZSM0KeKzDaa2vZxWwJRosQ/Lq/jzZJhQK95m16SUHQjDmHUEgj6VssdgXbG7yi5eGOisixdgzF9whRekUthnqkebRHRd4OYzVcZsYXB3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318801; c=relaxed/simple;
	bh=+s2j6yLA5HaibzGG0ZuVEzuWRMuvaCcwfUG0le5o9Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bzSpIJW72Np3xLC5rV+Tw0VWxKwgTw3CRAUuJ6fKqquBCSH+CEr5UQ7yizy09dagpbZvys4Y4BQo7xyfs1Enlq4cNwHKL62kbCFYilRhsohWHOm/PqybKVhKBsRIMlPwVGGHy2RSUMpTgaMk3sQTsTmIyd1hNPgNfptwDJw1cis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c2dff70000001609-0f-6a4b48fc473d
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
Subject: [PATCH v19 07/40] dept: distinguish each work from another
Date: Mon,  6 Jul 2026 15:18:55 +0900
Message-Id: <20260706061928.66713-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHee7Lc28rzW4uhF3rCLMpuml0uKA5UbeR7cNubJaYsGTJ+IA3
	cjOKULAoA6MJvoDKoJqx0imiFbpSebFaQpwKWlujgs6gg9qhLmBM1bRQrbTIm1vB+OXkl5z/
	/5fz4bAkP0yrWb1hh2w0SIUarKSUY4nNq96KuoKM8VoF+Pa6KTjh7MAw13iBgcmZRhImph4y
	4B+4SkLQG0FgHn2KIWyvRfAgFkJwqrkLQ7DhJYZexz4Mg9EwBuu+XhoCw70E7G9xYrg4comB
	e8FZAtpd30Gj5TkB5s7LBEzZ2xiwV6bDE8dxBv6zFsPjI2YK+v710RAM/Bo3Dq+E09U2Co6d
	fIShp7ePggH3bRr+eHCPgNERPw0x0xLoHG+OXxCzk/CPJRQXRsMMOF5Z4hcMVRNww5oCZ061
	Iui+WoUgYotRcLPOTcDB55cxVNvOE3DdeYEAZ8BLgqvDh8EbDRFQf9+KoX+6n4BI01sazLOH
	MDTuNSH4paqBgpk3JzCY7n4LTRNroHPOh7KyxI6THUisOhof3lCYFKejQ1i8ePwxI1pdO8Uu
	xwqxpecFIZ6ORGlxOPiF6Go7jMWasUFCvPX7DCV6vIeQ+HTQEk9UmsnN6h+VG/PkQn2ZbPzs
	yy3K/IG/rhAl40y5vaEdVaIeXIMUrMBlCnfdbuo937pjI+cZc8sFv39qgZO5j4WuugBdg5Qs
	yf2dJtTa6xYKSdw3woSlHs0zxaULr/pNTA1iWRW3Vpi4Lr1zpgnt59wLHgW3Tjg720TMMx+P
	PAzfpOadAudUCE5vN/OusFi45vBTR5HKihLaEK83lBVJ+sLM1fkVBn356q3FRS4U/zj7ntmc
	P1FkINuDOBZpElWQtamAp6Wy0ooiDxJYUpOsWvaJroBX5UkVu2Rjca5xZ6Fc6kFLWErzoerz
	2M95PPeTtEPeJsslsvH9lmAV6kq0SFt/INvBrtu1J6c6HUlJWa0j2q5UNa/UDoZ0gSOfrv++
	xCBd2t0SS1Qv3c56Et6YJm2bV2aM0qGP2lLngknGoZwPZvZneFN9409SrvxWlXDjNZ+my+3T
	LkXJuc82LP7qdYLOOpk5vSX/B+22lPLsM0mPuGWid+zsNP91a7ddpaFK86U1K0hjqfQ/ZF7q
	W20DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTGfd97e++lWnPXYbxBE02NbnMRNYo5U+NH9odvdCpLluwrRm/g
	brTlQ1tEIVEppRFRDHZpiRaUMWkcLVCBqQwriIoINoKooIjVrFYJSBULBmjFotk/J7+T5zlP
	nj8ORykvymI4dWq6pEsVk1WMnJZvW2NcEiJbNMuG8mMhz3QIHnt9MnhgaKJhJJhHQ3G1k4Gw
	7SILeTUnZdDanUNDR5UDgXckD8G7CRsFpvpJGsLmFhaCY70sWAwIJt0tCKydZgp6OhopcNYZ
	MLx1vWdg4NowAsszHwNF/QYaAvZjCE75bSz039gEr7wNMpjse4Ghe3QQgd33HoOv6TCCsFUL
	Z8pqI+fW1wxMeO5QUGTpQPDnsz4KhvufIqhreYLAfS6HgeeF/1DQ5ZsJ90YCDNyyHGXgVWcx
	hiEXA6U5bhl03h5AUGIzI/A/cmMw/lXNgLWkhob6p/+y0DkQwvDYasbgqNkKXrufhvbCMhyp
	G3Gdnw22IiOOjJcYLJUNGMbsFeyGckTemY7TpKL2Aiamu2GGOE87EZkYNyMSLDdSxFQYWa8N
	BiiSW7uPlLcPMmR85D5D3KOlNGkrE8jZI+OYnPAsIfWn+tj4jb/I1yZKyeoMSbd03S55Uofn
	Ct49xO63Wx0oG11m8lEUJ/ArhdbbZ6kpZvgvhJ6esY8czc8Xagv8snwk5yi+a55wzF5ATwmf
	898KwaI/0BTT/ELhTdtxNh9xnIKPE4LXxU+Z8wSHq+ljThS/SqgKleApVkYsvYGbdCGSl6Jp
	FShanZqRIqqT42L12qTMVPX+2IS0lBoUeSf7gdCJSyjYtakZ8RxSzVDAhs0apUzM0GemNCOB
	o1TRikVfbtEoFYliZpakS9up25ss6ZvRHI5WzVZs/lHapeR/F9MlrSTtlnT/q5iLislGXy/P
	GcYrNLb4aTOSpv902Xl41rnWhIWDXd+8ERu1e7Pky67kan0FcRqq0pIQl0gMM3XsD59djakU
	XLq5P3sOVtfVuxcvSsu+ef370HfFroZ4e/XYDa9nh7p7j+O3r7q3Z+WuzrjayK33BdJH/W29
	Z249/G/BTu2v8j1V4QNrje3Rf6tofZK4fDGl04sfAI6fsMZKAwAA
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-23025-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sk.com:from_mime,sk.com:email,sk.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFC1B70CE86

Workqueue already provides concurrency control.  By that, any wait in a
work doesn't prevents events in other works with the control enabled.
Thus, each work would better be considered a different context.

So let dept assign a different context id to each work.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/workqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6ea96d5b716..4a4075d0697c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -55,6 +55,7 @@
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -3204,6 +3205,8 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_update_cxt();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
2.17.1


