Return-Path: <linux-nfs+bounces-23048-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +t/5BGtdS2q8QAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23048-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 09:46:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6370DBF3
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 09:46:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23048-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23048-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209303145F24
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247FE3F58DC;
	Mon,  6 Jul 2026 06:21:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D213E4C87;
	Mon,  6 Jul 2026 06:21:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318892; cv=none; b=RJmdLEq6y0HUprxrsRGmo0kadzYBjM6cL9UzK7BqCvsgzjQM7T+9iQX2mNJ2aieS/ko8EAc/D1u+hq/sxy0erq8atGwZPekaLoeno9oJaHX0UlTpS5Sjdee1xK6uTcnA4pFMKAY2/ghcoHSJ5fjGn8xZkqsva5SmcO77f0ZANKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318892; c=relaxed/simple;
	bh=w+C1tGe+D2gcMh5vmD2+eMhKBKW1r3S6v2wTTfvfqWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=W55eyDz3YGvbGK2ENy9c/bikFgBjhwd1Fe/kDMgxm0xtAVpZfoQNgUBCFBK77BBCCgMchYeJMIrHUDm2N7RhZo7bapL2lN26smPn+ICNb1yjbE3QJQUtEDR3k1XkoTU6tA3ny8jmOxD6jkG77XQ7nJeBqE3+hXi+E3Gpl/qe4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c2dff70000001609-d4-6a4b4905193c
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
Subject: [PATCH v19 30/40] dept: make dept stop from working on debug_locks_off()
Date: Mon,  6 Jul 2026 15:19:18 +0900
Message-Id: <20260706061928.66713-31-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG/c75zoXaZmfVzCMmY6nZNGTqmLq8ccaRzCzfdJhd/pvLtgZO
	pKwgHrDKphlEunVTWG1kRCc3mazSUrBMYwGRtcNdvFBxsKLtBDEVLHgp0OpkdgeI/zz55b08
	efLm5WntdSaZN+QVSnKe3qhjVVg1rq5bwb69OeeV4MlUCN64xUB/SReGqUkLBov7MAN+lwOB
	2ZPAUFGCIHH2PIKA/xwNzp9LKJhoecJCxBdFUDlagiERuk3Bra6vEURHBxH8UbGfhfC1sxTs
	q29mwTPYxsGVyDQFDncGXLAeo+D7k4vgh8p9lCIjFFQ0tVNwsT6IYXooDULfVWBwjfcwEAnb
	WLC0TWFwD/czcLg6yMI/zoSSresCA70OP4bm2wEKetqaGIiVLwH/wTJlK9ZAg/1BJQPhvq8o
	OF/7HJyo+QmBLRzl4NQ5sxLyxxiGYPkdDH8NtCPotAxScNw+zoDb2c+Cb2qMgj9DExz8Gzqj
	nMVWw8Kp7jgHjx8eZeFhyzADVZNpMOloZNPTSdxcjomz2omI2aqIb+weTUpbdxHPkRBHSjuv
	caTWvZO02lNJfccoRdyN37DEHbVxpO7xCE2C/R0suXv5Mke8Pgt6N+VD1fosyWgwSfKqDZ+q
	spsTj5j8bs1u+8gAKkbm+d+iJF4U1oj/uU4wT9kTr59lVlgmBgKP6BleKLwgtpaFlbqKp4Wr
	KeKBhjI801ggvCc648fRDGPhRbEz2jPLGuE10RqNsHOmKaKjpWvWKEmpu6arqBnWCmvF6/d+
	w3MzNUli76+vz/Fi8Rd7AFuRphbNa0RaQ54pV28wrlmZXZRn2L0yc3uuGykv17B3eusZFPV/
	4EUCj3RqDaRvytEyelNBUa4XiTytW6h5afnmHK0mS1/0uSRv/0TeaZQKvGgJj3WLNK/GdmVp
	hW36QukzScqX5Kddik9KLkZ71qUfGrqbyXnvd291HqqZ93uqaZntTp/vjUL1xEbXJSnjgb24
	KbZYKOxdrclYr74Y//gg5PNW4ctN+eOrnu9LfEHfxLJz/w7zsSfy0mf6qjpM8to9E40bSGRL
	8pj9o6VqPPB+adnpI+8wpPPNv4efDQ29zC8ncp1ozLzSXul5S4cLsvVpqbRcoP8fHQuW9W4D
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH/d3H787V4rIGXYyyFj3oYQVZJ4owirxpRQUhCJUjLzmfsZVp
	EKlrtN5rsUlOy1aOmitNe61aipaVFmlmWmYrWqZpWUsdPubaiv45fM73e86X88cRkdI7dJhI
	mb5XUKUrUuVYTIk3rdAsoNfHJi86vR102kPw3uWm4U1uNQUD/ToKCsvsGHzmOwzoKs7R8LQ1
	j4LG66UIXAM6BN4RMwlah58Cn6GOgf6hdgaMuQj8zjoEpiYDCW2NVSTYb+YS8Lt8DENPrQeB
	8ZMbQ353LgV91hMICjrNDHQ/jobvrvs0+Du+EtA62IvA6h4jwF19BIHPlAIXLJWBddNPDCMv
	XpKQb2xEcPFTBwme7o8IbtZ9QOC8kofhi/4WCc3uCfB6oA/DM+NxDN+bCgn4UY6hOM9JQ9Pz
	HgRFZgOCzndOAjSXyjCYiioocHy8x0BTzygB700GAkorNoLL2klBg95CBM4NTN2YBOZ8DREo
	XQQYr90nYMhqY6JKEO/VnqJ4W+Vtgte+8mHeft6O+JFhA+L7SzQkr9UH2trePpI/XLmfL2no
	xfzwQAvmnYPFFF9v4fjLR4cJ/syLBbyjoIPZvDpevDJRSFVmCqqFqxLESWX+IXrPY0nWla63
	KAdpxx1DoSKOXcI5vJfoIGN2NtfWNkQGWcZO4ypPdgZ0sYhkm8O5E9aTVNCYyG7h7N4SFGSK
	nck99Lz8yxJ2Kaf39OB/oeFcaXn136DQgH59tIgIspSN5Nr7nlB6JC5GITYkU6ZnpimUqZER
	6pSk7HRlVsSujLQKFHgn68HRM3dRf3N0DWJFSD5eAlExyVJakanOTqtBnIiUyySz5sQmSyWJ
	iuwDgipjp2pfqqCuQZNFlHySJCZOSJCyuxV7hRRB2COo/ruEKDQsBxGcKjZtnX5HiPLz88Mt
	svqYQ1cPREc9NNhCcnaTM260tIdV2fCaKeE7lt36mUjqLK1bxlDD4KMMZt+ci9uy8FpXVcRw
	pGwwbkWkGk3vUnXMPRsV88FvfVvgy1weHf7mV6zrQve8qfUHv82vjbfcU6zVF2q+mJgNq70W
	j2MrfpAgp9RJisVzSZVa8Qc5S0vSSgMAAA==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-23048-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sk.com:from_mime,sk.com:email,sk.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82A6370DBF3

For many reasons, debug_locks_off() is called to stop lock debuging
feature e.g. on panic().  dept should also stop it in the conditions.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 2 ++
 kernel/dependency/dept.c | 6 ++++++
 lib/debug_locks.c        | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index f3cc7566ddf2..236e57befb13 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -142,6 +142,7 @@ struct dept_ext_wgen {
 	unsigned int wgen;
 };
 
+void dept_stop_emerg(void);
 void dept_on(void);
 void dept_off(void);
 void dept_init(void);
@@ -194,6 +195,7 @@ struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 
+#define dept_stop_emerg()				do { } while (0)
 #define dept_on()					do { } while (0)
 #define dept_off()					do { } while (0)
 #define dept_init()					do { } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 048348ea64d2..007e1bc7d201 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -187,6 +187,12 @@ static void dept_unlock(void)
 	arch_spin_unlock(&dept_spin);
 }
 
+void dept_stop_emerg(void)
+{
+	WRITE_ONCE(dept_stop, 1);
+}
+EXPORT_SYMBOL_GPL(dept_stop_emerg);
+
 enum bfs_ret {
 	BFS_CONTINUE,
 	BFS_DONE,
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index a75ee30b77cb..14a965914a8f 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
  */
 int debug_locks_off(void)
 {
+	dept_stop_emerg();
+
 	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {
 			console_verbose();
-- 
2.17.1


