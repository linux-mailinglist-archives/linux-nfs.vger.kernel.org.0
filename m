Return-Path: <linux-nfs+bounces-23056-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hT3HIhRUS2rMPQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23056-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 09:07:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE1C70D4A7
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 09:07:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23056-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23056-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E6A1317EEA9
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 06:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818A42E8E0;
	Mon,  6 Jul 2026 06:22:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3003E5A32;
	Mon,  6 Jul 2026 06:22:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318941; cv=none; b=Z9FxOz8QFlVy5LIitkbAZJDaT8BQHHtuXXPAXlH+QvpGLd4dTg4dGon7uz3U5azN7V8FICQtc2h6YTXPitR/d3evNWEl0WvLcVeFGYAa27zuXHorHJd6tCC4e+XdVRkqo3gViqEbLoKGvdnO9nz6hwJEmHIj9X9IOQJ6/MBDVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318941; c=relaxed/simple;
	bh=yYQ/ICrr4Ybg4wzxLt2HdYTviFZ3VJcNVrq9rKQPtWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6pkNDhQSBxb/7NDkEfoqvXfZefrXMctwmpOloYxiriD65lR+aqLVZpj/Peej+fJpTETL/bsHxVj/IQtLm1hpIrPY1qFU2hF0/qnLa1c0zDRBg5lKt+cv1u62U13mRxM8Y33xdSZcq5TaAnObEVPS30piuQwMMlSaLu2mOsOEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c45ff70000001609-21-6a4b4983f504
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
Subject: [PATCH v19 37/40] SUNRPC: relocate struct rcu_head to the first field of struct rpc_xprt
Date: Mon,  6 Jul 2026 15:19:25 +0900
Message-Id: <20260706061928.66713-38-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxbdRTG87//+0azbneVZddNs63JNoMO0eA8M4YQY8x1+2LiWzY12shV
	WnlpWmCDzA0cVMZga6qw0IaujJeRtgi01IFQ0mEoIpAhaGmhCNXKZpxbtnUgA5y3kMV9+53n
	PM9zvhwWKxrobaw6J0/U5aiylLSMlP29oX5f6euHNCkOxyYoLzsJ4dkoBYESHwmrlssMLC5b
	MJR1P5BGk5+B2NI0A9UlCB54/QicnSUEVEeiNJjnLQxEfV8iWB69iqE+MoPhD6MHw0R0IwxV
	n6FhfspLQE2di4Rh40WJOraC5fx1Kd7aQ8BIQ5iEmXPVJMwOGii4XDzHgOv3AAXeqaeh3tBI
	Qq01TEOvd4gEf9dvBFS2eygY8w1TMO4YI6HtWpCAYf8PJEyPnmPg6netFDRN/kRAZC5IgXt0
	BMPC2e3w10IzhnGfjQDD3X8pGKzyEdAUu4nh51APgr7yOQJ+nLnLwFfjNhoCpgs03KmTfJaS
	swjOlNWQ4BlYZKD99iUaYg47Da2rAQQ3jTEqPV1wWp1IWL5vQkKs6RQWmoZv0ML9e7/QgnfB
	Rgrd5hlGKO2bYgSbK19wtyQJDb1/EoLLfpoW6pevYyEc6KWF/u/LkdAdOfDGk0dkL2eIWeoC
	Ufds2keyzJaWAaS9sflYj8FKF6PajRUogeW5VH7i9kX8kMdNXUycaW4vHwwuremJ3E7eXTVP
	VSAZi7mJHXxlcxUZXzzGqfj5yGkiziS3m7dO3qPiLOf28yMdRrReuoN3tPvWihIk/ZuVujW/
	gnuBn741SK77N/NDtVGJWenAXr7NqojLWIqe8lhw/C7P/ZrAhwYqifXOx/krLUHSiDjzI3Hz
	/3HzI3EbwnakUOcUZKvUWanJmYU56mPJH+dmu5D0us2fr7zXhe6MvdmPOBYpN8gh/aBGQakK
	9IXZ/YhnsTJRvuepQxqFPENVWCTqcj/U5WeJ+n60nSWVW+XPLxzNUHCfqvLEz0RRK+oebgk2
	YVsx0h79wJq/+62KE/SKJtiqDJ5I9WWGXju++Iya8nzSGDSoNbmrLx6OFRzZUsnk2buLa5JT
	XklzExMd/i1J+51X3i994rC26EDkgkGr63zn2753XzU11x4kuK+dUKhL99tL3UQoxem4lPb2
	dFtbOPTSF7uKlmYn6/boMxr/SXJ37ktUkvpM1XNJWKdX/Qc09s50tgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0wTWRSA986dTofGkrGQOEFd3GZ9xKi7m4g5icZHjHFWsmY3/jDxj050
	lPKStIBgVgVqsSBuSpOW0EpFlIpQBYuoiF0JBlypRBBZiIKIW4uEIkZbTUsLTjUb/XPz3XO+
	8/hxaKyYlSTQqsxsQZ3JpyspGSnbuV67WvtrcurPd6ZWgV53AoZHPRL4t7CdhIBfT8LZRgcF
	EetNKeidlRL4Z7CIhN6rDQhGA3oEH2esGHStcyREjF1S8AefScFUiGDO1YXA3GfEMNR7F4Pj
	eiEB75tmKZi89w6BacxDQcVEIQnT9jIEFq9VChOd22FqtE0CcyPjBAx+8CGwe2YJ8LSfQhAx
	p8G5mmax3PyWgpmeRxgqTL0Izo+NYHg38QLB9a7nCFx1RRS8MrRg6PfEwpPANAUPTKcpmOo7
	S8CbJgqqi1wS6Hs4iaDKakTgfeoiQHuhkQJzlZOE1he3pdA3GSZg2GwkoMH5G4zavSS4DTWE
	uK5oXVsA1gotIT6vCTBdaSMgaK+Xbq5F3EfdXyRX33yD4HSPIxTnsDkQNxMyIs5fq8WcziB+
	7/mmMXey+QhX6/ZRXCgwQHGuD9Uk113DchdLQgRX3rOaa7WMSH/fske24YCQrsoV1D9t3CdL
	qavrRFm++XltxTaqAFXGlqIYmmXWso+Nt6RRppjl7NBQEEc5nlnCNp/xSkqRjMZMfyJbZj9D
	RhNxDM96x0qIKJPMUtY2GJBEWc6sYx9eM6AvTRPZhqb2z41ixPjVcNVnX8Eksc+m75Nf/Pns
	g0qPyLQ4YDnbaFNEw1gs1bZYsQHJLd9Ylq+W5RurGuF6FK/KzM3gVelJazRpKfmZqrw1+w9n
	OJF4lfZj4fJbyN+/vQMxNFLOk8PmHakKCZ+ryc/oQCyNlfHyZSuSUxXyA3z+UUF9eK86J13Q
	dKCFNKlcIN+xW9inYA7x2UKaIGQJ6v+zBB2TUIDc/SH3wN/2FcGw+whOlI//t3/D4q0q/6ns
	E/rZsLaok36y9sdd53aef2+L7eiu7fTLy5OX3L/rjJMlWkqK12/JebrIl1vwZ0vCywGjMdU/
	Hjn0aLCUPh7nefvHd3k/bJu7nJT1KlS2tFu1yTFsv33cqjp9MFzM56yq6Io/+X2wZ/ElJalJ
	4X9ZidUa/hOqfMNukQMAAA==
X-CFilter-Loop: Reflected
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[sk.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[byungchul@sk.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:max.byungchul.park@gmail.com,m:kernel_team@skhynix.com,m:torvalds@linux-foundation.org,m:damien.lemoal@opensource.wdc.com,m:linux-ide@vger.kernel.org,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:mingo@redhat.com,m:peterz@infradead.org,m:will@kernel.org,m:tglx@linutronix.de,m:rostedt@goodmis.org,m:joel@joelfernandes.org,m:sashal@kernel.org,m:daniel.vetter@ffwll.ch,m:duyuyang@gmail.com,m:johannes.berg@intel.com,m:tj@kernel.org,m:tytso@mit.edu,m:willy@infradead.org,m:david@fromorbit.com,m:amir73il@gmail.com,m:gregkh@linuxfoundation.org,m:kernel-team@lge.com,m:linux-mm@kvack.org,m:akpm@linux-foundation.org,m:mhocko@kernel.org,m:minchan@kernel.org,m:hannes@cmpxchg.org,m:vdavydov.dev@gmail.com,m:sj@kernel.org,m:jglisse@redhat.com,m:dennis@kernel.org,m:cl@linux.com,m:penberg@kernel.org,m:rientjes@google.com,m:vbabka@suse.cz,m:ngupta@vflare.org,m:linux-block@vger.kernel.org,m:josef@toxicpanda.com,m:linux-fsdevel@vger.kern
 el.org,m:jack@suse.cz,m:jlayton@kernel.org,m:dan.j.williams@intel.com,m:hch@infradead.org,m:djwong@kernel.org,m:dri-devel@lists.freedesktop.org,m:rodrigosiqueiramelo@gmail.com,m:melissa.srw@gmail.com,m:hamohammed.sa@gmail.com,m:harry.yoo@oracle.com,m:chris.p.wilson@intel.com,m:gwan-gyeong.mun@intel.com,m:boqun.feng@gmail.com,m:longman@redhat.com,m:yunseong.kim@ericsson.com,m:ysk@kzalloc.com,m:yeoreum.yun@arm.com,m:netdev@vger.kernel.org,m:matthew.brost@intel.com,m:her0gyugyu@gmail.com,m:corbet@lwn.net,m:catalin.marinas@arm.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:luto@kernel.org,m:sumit.semwal@linaro.org,m:gustavo@padovan.org,m:christian.koenig@amd.com,m:andi.shyti@kernel.org,m:arnd@arndb.de,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:rppt@kernel.org,m:surenb@google.com,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:jo
 sh@joshtriplett.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23056-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,skhynix.com,linux-foundation.org,opensource.wdc.com,vger.kernel.org,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[165];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sk.com:from_mime,sk.com:email,sk.com:mid,kzalloc.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DE1C70D4A7

While compiling Linux kernel with DEPT on, the following error was
observed:

   ./include/linux/rcupdate.h:1084:17: note: in expansion of macro
   ‘BUILD_BUG_ON’
   1084 | BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);	\
        | ^~~~~~~~~~~~
   ./include/linux/rcupdate.h:1047:29: note: in expansion of macro
   'kvfree_rcu_arg_2'
   1047 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
        |                             ^~~~~~~~~~~~~~~~
   net/sunrpc/xprt.c:1856:9: note: in expansion of macro 'kfree_rcu'
   1856 | kfree_rcu(xprt, rcu);
        | ^~~~~~~~~
    CC net/kcm/kcmproc.o
   make[4]: *** [scripts/Makefile.build:203: net/sunrpc/xprt.o] Error 1

Since kfree_rcu() assumes 'offset of struct rcu_head in a rcu-managed
struct < 4096', the offest of struct rcu_head in struct rpc_xprt should
not exceed 4096 but does, due to the debug information added by DEPT.

Relocate struct rcu_head to the first field of struct rpc_xprt from an
arbitrary location to avoid the issue and meet the assumption.

Reported-by: Yunseong Kim <ysk@kzalloc.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/xprt.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index f46d1fb8f71a..666e42a17a31 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -211,6 +211,14 @@ enum xprt_transports {
 
 struct rpc_sysfs_xprt;
 struct rpc_xprt {
+	/*
+	 * Place struct rcu_head within the first 4096 bytes of struct
+	 * rpc_xprt if sizeof(struct rpc_xprt) > 4096, so that
+	 * kfree_rcu() can simply work assuming that.  See the comment
+	 * in kfree_rcu().
+	 */
+	struct rcu_head		rcu;
+
 	struct kref		kref;		/* Reference count */
 	const struct rpc_xprt_ops *ops;		/* transport methods */
 	unsigned int		id;		/* transport id */
@@ -317,7 +325,6 @@ struct rpc_xprt {
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	struct dentry		*debugfs;		/* debugfs directory */
 #endif
-	struct rcu_head		rcu;
 	const struct xprt_class	*xprt_class;
 	struct rpc_sysfs_xprt	*xprt_sysfs;
 	bool			main; /*mark if this is the 1st transport */
-- 
2.17.1


