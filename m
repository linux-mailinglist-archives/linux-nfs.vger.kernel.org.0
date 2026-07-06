Return-Path: <linux-nfs+bounces-23020-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dxiIMnBJS2qrOgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23020-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:21:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA0470CDD1
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:21:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23020-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23020-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47BFB301C5BD
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 06:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB643C13EE;
	Mon,  6 Jul 2026 06:19:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D963C23ED6F;
	Mon,  6 Jul 2026 06:19:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318786; cv=none; b=thJi8wCqmVIiAI+9flUhSK4/NIziiI/NmTCBdYBAim2hUQk1FjrmosqVe68xQcB9BiPWN1gUAAh02R2JlazdTREN5Zah/X89AzpgruZUq0TFIH5Zif2Mu0xueLPrHP6Jwo1uOodgVmhGqFp29BAMIa3SbZrin79P9KGTsjtB+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318786; c=relaxed/simple;
	bh=7LQtZfSFV+ucO+3UZcewjHC/WOxu+83GU38+H9B+zyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WgJZTtIxby99s6Ffn588zLXpfys7xYrxO1P3+pqCIJFUVEUEPjN7czbx8n9+0RbsJj2gXQOfAMe9i4/K1Wil5vZhbjIsDEW7bPjE7JHTQj2MbWArn798dFLR3sefXvA/pjZnXHOUV3Q6I3/nC6l77H0ikk+Asdg4CTESuqtzvyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c45ff70000001609-38-6a4b48fb82d0
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
Subject: [PATCH v19 00/40] DEPT(DEPendency Tracker)
Date: Mon,  6 Jul 2026 15:18:48 +0900
Message-Id: <20260706061928.66713-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH97zv815o6PKumvnqsrDUubElw21IPFkWY/ywPRt+IHHJMv3g
	mvFGiqWYIghqHQ5xlcHs3LSj5dICVmhx1Fa8jWYdkQriBp1EO6VCCRcRAcMKDLmtnbv47Zzf
	Of9//ic5PK0oZdfwau1eSadVaZSsDMvG421vzJPUzDdti+vAUPw59PYNMnDrsA/DdMSAoaKp
	kYVFy0UODO5yBvqmDQgWT/g5iMzd5WDZ60fQeP4wBX+4llgwD1s4GG17H5ZDIxTYB5coqK7x
	sDB26hELppPdCGzhEA1To/0IzvvvIRgyNtPQMz3JwniggoIJFwvWL7wMBG6MIRi+46WgqLaJ
	hVOVbgyX+69wEBhboKDPPozBNBrl51aBxXSfgpNnf6Rgzu7gYKDezIHfOcLBD+Nd0bzXjjJw
	sbCfA/fvbQgiPWEKDFemMdiO1mEor+plocXbgcGwGEHgvzRAQamrmYFCyywD3b5OBppGghR0
	+tsxdJgbMNz95TgH4f4gA0HjEIKzEzXR62bs9OZ0Mlv8NSYOzwWKNFY1IjL/+AQikdNFNCk2
	Rtsjnn3EO2PF5HqNSOqOPabIZXOII1Z3LjlydZwhtS2jFHE7jrGk91YLm5a4XfZuuqRR50m6
	9Zs+lWW0+t7b03AT5fsCQaoQ2WyoBMXxorBBHPl+gv6vvh+iYjUrvCoGg3N/85XCS6KnbJgp
	QTKeFm4miKX2MhwbrBCSxeXwEluCeB4L68QboeQYlgsp4mSgnnvimSA6XT76CX9O7CgfxLF1
	OurfVKWIYTq6UtRsoWP2onA9TjzzU8U/eVaLP9cHsRE9a35Kbv5fbn5KbkW0AynU2rwslVqz
	ISmjQKvOT/osO8uNoj9q1y/suISmure1IoFHyng5bP4wU8Go8nIKslqRyNPKlfJXElMzFfJ0
	VcF+SZe9U5erkXJa0Qs8Vq6Svz2zL10h7FLtlXZL0h5J9++U4uPWFKKPBkrodzo2xT/TlTb7
	iTP3G0fPWpl+qmtLmr46Wbe7ZuMHnodJVfbKbKVfP/DiVwkPTLfb64YeHby3lXQql1qckw+t
	7bu2fpv48fN6nbO2elZLX0updK1uSwofEB/8mv3dwrk/j78W3vFbUQPZEv/l7ZdT5tdOGcsO
	ZeaD1lSamq/ZpsQ5Gaq3Xqd1Oaq/AG8Md8afAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0xTZxTG89739t5rt27XyuJVP7g0my4moJvDnTiz6D6MdxgXv7nopjZw
	A4WCrlWEZcsoXTNEGKVZS2gtQieNQies/BloujWQkTEwo6soGdRC0hUJsBpsJbQU1sYs88vJ
	c57zO0/Oh8NheViynVOVXhA1pUq1gpHS0o/e1WfGydGifXZfNlQbvoLpYEgC93VeGmLRahqu
	droYSNp+YqHa3SSB3x5U0TB+qwNBMFaNYCVhw2AY2KAhaRpmIbo6xYJZh2DDM4zA4jNhmBz/
	BYOrR0fBk651BhaGlhGYZ0MMNM7raIg4axFYwzYW5n/NgaXgHQlsBOYoePB0EYEztE5ByPsN
	gqSlGK45ulPrlscMJO7+gaHRPI6gdTaAYXl+BkHP8EMEnhtVDPxt7MXgD70E92IRBkbMVxhY
	8l2l4J8uBlqqPBLwjS0gsNtMCMJ/eSjQf9/JgMXupmFg5jYLvoU1CqYtJgo63Mcg6AzTMGp0
	UKlzU9SPW8HWqKdS5REF5h/uULDqbGcPtyGyYviWJu3dfRQx/JlkiKvZhUgibkIk2qbHxGBM
	tUOLEUy+7r5E2kYXGRKPTTDE87SFJr87BHL9cpwiDXczyYA1wB4/clJ6KF9Uq8pEzd73zkoL
	B70fnL/pR+Ve3yRViVpbUQ3axAn828LcowCV1gy/W5icXMVpncG/KnTXhSU1SMph3r9TqHXW
	0enBFn6/sDG7ztQgjqP514WxwP60LeOzhYjvBvssc6fQ0eXFz/zNwkhTiE7jOJXf2SxP2ziF
	6Htt2IhesD5HWf+nrM9RLQi3owxVaVmJUqXOztIWF1aUqsqz8s6VuFHq+5xfrjX0o6g/ZxDx
	HFK8KIPDuUVyibJMW1EyiAQOKzJku944WiSX5SsrPhc1585oLqpF7SDawdGKrbLcE+JZOV+g
	vCAWi+J5UfPflOI2ba9EssoJ/anIpZnpkXLXONvS910XK3+y73icdrw8XBAbE4z21049zul1
	39tR2b85b+2dombr6R6d+sP7xw4U5H2cOfHJiSl7/kWpbGl02/srZCjpqP2sof6KuLL8Sm4i
	CFWJn+uduwKfMuambDwlO3jEX38gunyQPEzMfXG5762Gui0KWluofHMP1miV/wIIt/YleQMA
	AA==
X-CFilter-Loop: Reflected
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-23020-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,skhynix.com,linux-foundation.org,opensource.wdc.com,vger.kernel.org,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sk.com:mid,sk.com:from_mime,vger.kernel.org:from_smtp,kzalloc.com:email,intel.com:email,oracle.com:email,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BA0470CDD1

Hi Linus and folks,

DEPT(DEPendency Tracker) is a runtime deadlock detection framework that
sees what lockdep cannot.

I'm thrilled to share that DEPT has moved beyond theory and is now
catching real deadlocks in the wild:

   https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/
   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
   https://lore.kernel.org/all/b6e00e77-4a8c-4e05-ab79-266bf05fcc2d@igalia.com/

I've added comprehensive documentation explaining DEPT's design and usage.
Getting started is as simple as enabling CONFIG_DEPT and watching dmesg.

THE PROBLEM LOCKDEP CANNOT SOLVE
--------------------------------

Lockdep has been our trusted deadlock detector for two decades, but it
has a fundamental blind spot: it tracks lock acquisition order, not the
actual waits and events that cause deadlocks. This means lockdep misses:

  * Deadlocks involving folio locks (not released within the context)
  * Cross-context synchronization like wait_for_completion()/complete()
  * DMA fence waits, RCU waits, and general waitqueue patterns
  * Any synchronization primitive outside the classic lock/unlock model

Consider this real deadlock pattern that lockdep cannot detect:

   context X              context Y              context Z

                          mutex_lock A
   folio_lock B
                          folio_lock B <- DEADLOCK
                                                 mutex_lock A <- DEADLOCK
                                                 folio_unlock B
                          folio_unlock B
                          mutex_unlock A
                                                 mutex_unlock A

Lockdep sees lock acquisitions. DEPT sees the actual dependency:

   "mutex_unlock A in context Y cannot happen until folio_lock B is
   awakened by the owner's folio_unlock B, and vice versa in context Z."

It's a circular dependency that means deadlock.

THE DEPT APPROACH
-----------------

DEPT asks a simpler question: "What is this context waiting for, and
what event will wake it up?"

Every deadlock is fundamentally about unreachable events. DEPT tracks:

  [S] Where an event context begins (the code path that will trigger
      an event)
  [W] Where a wait for another event apears between [S] and [E]
  [E] Where the event for [S] occurs

By building a dependency graph of "[E] cannot occur until the event that
[W] waits for occurs", DEPT detects circular dependencies regardless of
the underlying synchronization primitives involved.

WHAT DEPT BRINGS TO THE TABLE
-----------------------------

  * Universal coverage: Works with any wait/event-based synchronization,
    not just locks
  * Correct read-lock handling: No more blind spots for read-side
    dependencies
  * Continuous operation: Unlike lockdep, DEPT keeps running after
    reports, catching multiple deadlocks in a single session
  * Clean annotation API: Simple, intuitive interfaces for subsystem
    maintainers to refine detection
  * Battle-tested: Already catching real deadlocks as the links above
    demonstrate

FALSE POSITIVES: THE HONEST CONVERSATION
----------------------------------------

Like any powerful detection tool, DEPT faces the false positive
challenge. This is not unique to DEPT — lockdep spent years building its
annotation infrastructure (lock classes, subclasses, lockdep_map) to
separate real bugs from intentional patterns.

DEPT is on the same journey. We have:

  * Event site recovery: Declare when an event has fallback paths
  * Subclass-based classification: Distinguish per-CPU, per-device,
    and modality-specific waits
  * Page usage tracking: Separate block device mappings from regular
    file mappings to avoid spurious reports (currently being worked on)

But comprehensive annotation requires subsystem maintainer expertise.
This is where I need your help.

THE PATH TO MAINLINE
--------------------

DEPT is marked EXPERIMENTAL in Kconfig for a reason. Like lockdep, it
will mature through collaboration:

  1. Core framework: Stabilized and ready for review
  2. Subsystem pilots: Working with maintainers to add annotations
     where they matter most (mm, block, drm, networking, ...)
  3. Gradual enablement: DEPT and lockdep coexist; DEPT takes over
     dependency checking when ready

I am not proposing to replace lockdep. Lockdep's lock usage validation
remains invaluable. The vision is:

   LOCKDEP: Validates correct lock usage
      |
      v
   DEPT: Performs dependency checking with full wait/event coverage

WHY MERGE NOW?
--------------

Some might suggest: "Fix all false positives out-of-tree first." But
the affected subsystems span the entire kernel. Like lockdep's
two-decade annotation journey, DEPT needs mainline visibility for:

  * Proper annotation placement (maintainers know their code best)
  * Real-world testing across configurations and workloads
  * Incremental improvement through community feedback

CONFIG_DEPT is opt-in. It won't affect your default kernel build. But
for those debugging complex synchronization issues, DEPT is ready to
help today.

ACKNOWLEDGMENTS
---------------

This work would not be possible without:

   Harry Yoo <harry.yoo@oracle.com>
   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
   Yunseong Kim <ysk@kzalloc.com>
   Yeoreum Yun <yeoreum.yun@arm.com>

And the countless kernel developers whose lockdep annotations over two
decades showed us the path forward.

FAQ
---

Q. Isn't this the cross-release feature that got reverted?

A. Cross-release (commit b09be676e0ff2) attempted to extend lockdep
   with wait/event tracking. It found real bugs but introduced false
   positives that masked further issues. DEPT learns from that
   experience with a cleaner design and flexible reporting that makes
   false positives less disruptive.

Q. Why not build DEPT into lockdep?

A. Lockdep is stable, battle-tested code. I chose separation because
   while DEPT borrows BFS and hashing ideas, the wait/event model
   requires rebuilding from scratch. Lockdep was designed for lock
   acquisition order — retrofitting it would risk its stability.

Q. Will DEPT replace lockdep?

A. No. Lockdep validates correct lock usage — that's not going away.
   DEPT supersedes only the dependency-checking logic when mature.

Q. Should we merge DEPT now or wait for more annotations out-of-tree?

A. Now. The annotation journey requires mainline collaboration. Lockdep
   didn't become useful overnight — it grew through maintainer
   contributions. DEPT needs the same path.

Q. What if I enable DEPT and get false positives?

A. That's the point — report them. Work with us to add annotations that
   distinguish your intentional patterns from real deadlocks. This is
   how lockdep became indispensable, and it's how DEPT will too.

GETTING STARTED
---------------

  1. Enable CONFIG_DEPT (EXPERIMENTAL)
  2. Boot your kernel
  3. Check dmesg for DEPT reports
  4. Read Documentation/dev-tools/dept.rst for interpretation

DEPT is a tool for understanding your code's synchronization behavior.
Even if you never see a deadlock report, the visibility it provides
is invaluable.

I look forward to your feedback, patches, and collaboration. Let's make
DEPT as indispensable to kernel developers as lockdep has been.
---
Changes from v18:

	1. Rebase on v7.0.
	2. Add 'Reviewed-by: Jeff Layton <jlayton@kernel.org>' on 37th
	   patch, 'SUNRPC: relocate struct rcu_head to the first field
	   of struct rpc_xprt'. (thanks to Jeff Layton)
	3. Refine and supplement dept documents and comments, and fix
	   typos. (feedbacked by Bagas Sanjaya and Yunseong Kim)
	4. Add __rust_helper to rust_helper_wait_for_completion().
	   (feedbacked by Dirk Behme)
	5. Remove the part supporting recover events tracking - I will
	   keep maintaining it out of tree tho - as it unnecessarily
	   complicates the initial DEPT patchset and significantly
	   increases the review burden.
	6. Get rid of 'extern' keyword with function declarations.
	   (feedbacked by Petr Pavlu)

Changes from v17:

	1. Rebase on the mainline as of 2025 Dec 5.
	2. Convert the documents' format from txt to rst. (feedbacked
	   by Jonathan Corbet and Bagas Sanjaya)
	3. Move the documents from 'Documentation/dependency' to
	   'Documentation/dev-tools'. (feedbakced by Jonathan Corbet)
	4. Improve the documentation. (feedbacked by NeilBrown)
	5. Use a common function, enter_from_user_mode(), instead of
	   arch specific code, to notice context switch from user mode.
	   (feedbacked by Dave Hansen, Mark Rutland, and Mark Brown)
	6. Resolve the header dependency issue by using dept's internal
	   header, instead of relocating 'struct llist_{head,node}' to
	   another header. (feedbacked by Greg KH)
	7. Improve page(or folio) usage type APIs.
	8. Add rust helper for wait_for_completion(). (feedbacked by
	   Guangbo Cui, Boqun Feng, and Danilo Krummrich)
	9. Refine some commit messages.

Changes from v16:

	1. Rebase on v6.17.
	2. Fix a false positive from rcu (by Yunseong Kim)
	3. Introduce APIs to set page's usage, dept_set_page_usage() and
	   dept_reset_page_usage() to avoid false positives.
	4. Consider lock_page() as a potential wait unconditionally.
	5. Consider folio_lock_killable() as a potential wait
	   unconditionally.
	6. Add support for tracking PG_writeback waits and events.
	7. Fix two build errors due to the additional debug information
	   added by dept. (by Yunseong Kim)

Changes from v15:

	1. Fix typo and improve comments and commit messages (feedbacked
	   by ALOK TIWARI, Waiman Long, and kernel test robot).
	2. Do not stop dept on detection of cicular dependency of
	   recover event, allowing to keep reporting.
	3. Add SK hynix to copyright.
	4. Consider folio_lock() as a potential wait unconditionally.
	5. Fix Kconfig dependency bug (feedbacked by kernel test rebot).
	6. Do not suppress reports that involve classes even that have
	   already involved in other reports, allowing to keep
	   reporting.

Changes from v14:

	1. Rebase on the current latest, v6.15-rc6.
	2. Refactor dept code.
	3. With multi event sites for a single wait, even if an event
	   forms a circular dependency, the event can be recovered by
	   other event(or wake up) paths.  Even though informing the
	   circular dependency is worthy but it should be suppressed
	   once informing it, if it doesn't lead an actual deadlock.  So
	   introduce APIs to annotate the relationship between event
	   site and recover site, that are, event_site() and
	   dept_recover_event().
	4. wait_for_completion() worked with dept map embedded in struct
	   completion.  However, it generates a few false positves since
	   all the waits using the instance of struct completion, share
	   the map and key.  To avoid the false positves, make it not to
	   share the map and key but each wait_for_completion() caller
	   have its own key by default.  Of course, external maps also
	   can be used if needed.
	5. Fix a bug about hardirq on/off tracing.
	6. Implement basic unit test for dept.
	7. Add more supports for dma fence synchronization.
	8. Add emergency stop of dept e.g. on panic().
	9. Fix false positives by mmu_notifier_invalidate_*().
	10. Fix recursive call bug by DEPT_WARN_*() and DEPT_STOP().
	11. Fix trivial bugs in DEPT_WARN_*() and DEPT_STOP().
	12. Fix a bug that a spin lock, dept_pool_spin, is used in
	    both contexts of irq disabled and enabled without irq
	    disabled.
	13. Suppress reports with classes, any of that already have
	    been reported, even though they have different chains but
	    being barely meaningful.
	14. Print stacktrace of the wait that an event is now waking up,
	    not only stacktrace of the event.
	15. Make dept aware of lockdep_cmp_fn() that is used to avoid
	    false positives in lockdep so that dept can also avoid them.
	16. Do do_event() only if there are no ecxts have been
	    delimited.
	17. Fix a bug that was not synchronized for stage_m in struct
	    dept_task, using a spin lock, dept_task()->stage_lock.
	18. Fix a bug that dept didn't handle the case that multiple
	    ttwus for a single waiter can be called at the same time
	    e.i. a race issue.
	19. Distinguish each kernel context from others, not only by
	    system call but also by user oriented fault so that dept can
	    work with more accuracy information about kernel context.
	    That helps to avoid a few false positives.
	20. Limit dept's working to x86_64 and arm64.

Changes from v13:

	1. Rebase on the current latest version, v6.9-rc7.
	2. Add 'dept' documentation describing dept APIs.

Changes from v12:

	1. Refine the whole document for dept.
	2. Add 'Interpret dept report' section in the document, using a
	   deadlock report obtained in practice. Hope this version of
	   document helps guys understand dept better.

	   https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
	   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/

Changes from v11:

	1. Add 'dept' documentation describing the concept of dept.
	2. Rewrite the commit messages of the following commits for
	   using weaker lockdep annotation, for better description.

	   fs/jbd2: Use a weaker annotation in journal handling
	   cpu/hotplug: Use a weaker annotation in AP thread

	   (feedbacked by Thomas Gleixner)

Changes from v10:

	1. Fix noinstr warning when building kernel source.
	2. dept has been reporting some false positives due to the folio
	   lock's unfairness. Reflect it and make dept work based on
	   dept annotaions instead of just wait and wake up primitives.
	3. Remove the support for PG_writeback while working on 2. I
	   will add the support later if needed.
	4. dept didn't print stacktrace for [S] if the participant of a
	   deadlock is not lock mechanism but general wait and event.
	   However, it made hard to interpret the report in that case.
	   So add support to print stacktrace of the requestor who asked
	   the event context to run - usually a waiter of the event does
	   it just before going to wait state.
	5. Give up tracking raw_local_irq_{disable,enable}() since it
	   totally messed up dept's irq tracking. So make it work in the
	   same way as lockdep does. I will consider it once any false
	   positives by those are observed again.
	6. Change the manual rwsem_acquire_read(->j_trans_commit_map)
	   annotation in fs/jbd2/transaction.c to the try version so
	   that it works as much as it exactly needs.
	7. Remove unnecessary 'inline' keyword in dept.c and add
	   '__maybe_unused' to a needed place.

Changes from v9:

	1. Fix a bug. SDT tracking didn't work well because of my big
	   mistake that I should've used waiter's map to indentify its
	   class but it had been working with waker's one. FYI,
	   PG_locked and PG_writeback weren't affected. They still
	   worked well. (reported by YoungJun)
	
Changes from v8:

	1. Fix build error by adding EXPORT_SYMBOL(PG_locked_map) and
	   EXPORT_SYMBOL(PG_writeback_map) for kernel module build -
	   appologize for that. (reported by kernel test robot)
	2. Fix build error by removing header file's circular dependency
	   that was caused by "atomic.h", "kernel.h" and "irqflags.h",
	   which I introduced - appolgize for that. (reported by kernel
	   test robot)

Changes from v7:

	1. Fix a bug that cannot track rwlock dependency properly,
	   introduced in v7. (reported by Boqun and lockdep selftest)
	2. Track wait/event of PG_{locked,writeback} more aggressively
	   assuming that when a bit of PG_{locked,writeback} is cleared
	   there might be waits on the bit. (reported by Linus, Hillf
	   and syzbot)
	3. Fix and clean bad style code e.i. unnecessarily introduced
	   a randome pattern and so on. (pointed out by Linux)
	4. Clean code for applying dept to wait_for_completion().

Changes from v6:

	1. Tie to task scheduler code to track sleep and try_to_wake_up()
	   assuming sleeps cause waits, try_to_wake_up()s would be the
	   events that those are waiting for, of course with proper dept
	   annotations, sdt_might_sleep_weak(), sdt_might_sleep_strong()
	   and so on. For these cases, class is classified at sleep
	   entrance rather than the synchronization initialization code.
	   Which would extremely reduce false alarms.
	2. Remove the dept associated instance in each page struct for
	   tracking dependencies by PG_locked and PG_writeback thanks to
	   the 1. work above.
	3. Introduce CONFIG_dept_AGGRESIVE_TIMEOUT_WAIT to suppress
	   reports that waits with timeout set are involved, for those
	   who don't like verbose reporting.
	4. Add a mechanism to refill the internal memory pools on
	   running out so that dept could keep working as long as free
	   memory is available in the system.
	5. Re-enable tracking hashed-waitqueue wait. That's going to no
	   longer generate false positives because class is classified
	   at sleep entrance rather than the waitqueue initailization.
	6. Refactor to make it easier to port onto each new version of
	   the kernel.
	7. Apply dept to dma fence.
	8. Do trivial optimizaitions.

Changes from v5:

	1. Use just pr_warn_once() rather than WARN_ONCE() on the lack
	   of internal resources because WARN_*() printing stacktrace is
	   too much for informing the lack. (feedback from Ted, Hyeonggon)
	2. Fix trivial bugs like missing initializing a struct before
	   using it.
	3. Assign a different class per task when handling onstack
	   variables for waitqueue or the like. Which makes dept
	   distinguish between onstack variables of different tasks so
	   as to prevent false positives. (reported by Hyeonggon)
	4. Make dept aware of even raw_local_irq_*() to prevent false
	   positives. (reported by Hyeonggon)
	5. Don't consider dependencies between the events that might be
	   triggered within __schedule() and the waits that requires
	    __schedule(), real ones. (reported by Hyeonggon)
	6. Unstage the staged wait that has prepare_to_wait_event()'ed
	   *and* yet to get to __schedule(), if we encounter __schedule()
	   in-between for another sleep, which is possible if e.g. a
	   mutex_lock() exists in 'condition' of ___wait_event().
	7. Turn on CONFIG_PROVE_LOCKING when CONFIG_DEPT is on, to rely
	   on the hardirq and softirq entrance tracing to make dept more
	   portable for now.

Changes from v4:

	1. Fix some bugs that produce false alarms.
	2. Distinguish each syscall context from another *for arm64*.
	3. Make it not warn it but just print it in case dept ring
	   buffer gets exhausted. (feedback from Hyeonggon)
	4. Explicitely describe "EXPERIMENTAL" and "dept might produce
	   false positive reports" in Kconfig. (feedback from Ted)

Changes from v3:

	1. dept shouldn't create dependencies between different depths
	   of a class that were indicated by *_lock_nested(). dept
	   normally doesn't but it does once another lock class comes
	   in. So fixed it. (feedback from Hyeonggon)
	2. dept considered a wait as a real wait once getting to
	   __schedule() even if it has been set to TASK_RUNNING by wake
	   up sources in advance. Fixed it so that dept doesn't consider
	   the case as a real wait. (feedback from Jan Kara)
	3. Stop tracking dependencies with a map once the event
	   associated with the map has been handled. dept will start to
	   work with the map again, on the next sleep.

Changes from v2:

	1. Disable dept on bit_wait_table[] in sched/wait_bit.c
	   reporting a lot of false positives, which is my fault.
	   Wait/event for bit_wait_table[] should've been tagged in a
	   higher layer for better work, which is a future work.
	   (feedback from Jan Kara)
	2. Disable dept on crypto_larval's completion to prevent a false
	   positive.

Changes from v1:

	1. Fix coding style and typo. (feedback from Steven)
	2. Distinguish each work context from another in workqueue.
	3. Skip checking lock acquisition with nest_lock, which is about
	   correct lock usage that should be checked by lockdep.

Changes from RFC(v0):

	1. Prevent adding a wait tag at prepare_to_wait() but __schedule().
	   (feedback from Linus and Matthew)
	2. Use try version at lockdep_acquire_cpus_lock() annotation.
	3. Distinguish each syscall context from another.

Byungchul Park (39):
  dept: implement DEPT(DEPendency Tracker)
  dept: add single event dependency tracker APIs
  dept: add lock dependency tracker APIs
  dept: tie to lockdep and IRQ tracing
  dept: add proc knobs to show stats and dependency graph
  dept: distinguish each kernel context from another
  dept: distinguish each work from another
  dept: add a mechanism to refill the internal memory pools on running
    out
  dept: record the latest one out of consecutive waits of the same class
  dept: apply sdt_might_sleep_{start,end}() to
    wait_for_completion()/complete()
  dept: apply sdt_might_sleep_{start,end}() to swait
  dept: apply sdt_might_sleep_{start,end}() to waitqueue wait
  dept: apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
  dept: apply sdt_might_sleep_{start,end}() to dma fence
  dept: track timeout waits separately with a new Kconfig
  dept: apply timeout consideration to wait_for_completion()/complete()
  dept: apply timeout consideration to swait
  dept: apply timeout consideration to waitqueue wait
  dept: apply timeout consideration to hashed-waitqueue wait
  dept: apply timeout consideration to dma fence wait
  dept: make dept able to work with an external wgen
  dept: track PG_locked with dept
  dept: print staged wait's stacktrace on report
  locking/lockdep: prevent various lockdep assertions when
    lockdep_off()'ed
  dept: add documents for dept
  cpu/hotplug: use a weaker annotation in AP thread
  dept: assign dept map to mmu notifier invalidation synchronization
  dept: assign unique dept_key to each distinct dma fence caller
  dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
  dept: make dept stop from working on debug_locks_off()
  dept: assign unique dept_key to each distinct wait_for_completion()
    caller
  completion, dept: introduce init_completion_dmap() API
  dept: call dept_hardirqs_off() in local_irq_*() regardless of irq
    state
  dept: introduce APIs to set page usage and use subclasses_evt for the
    usage
  dept: track PG_writeback with dept
  SUNRPC: relocate struct rcu_head to the first field of struct rpc_xprt
  mm: percpu: increase PERCPU_DYNAMIC_SIZE_SHIFT on DEPT and large
    PAGE_SIZE
  rust: completion: Add __rust_helper to
    rust_helper_wait_for_completion()
  dept: implement a basic unit test for dept

Yunseong Kim (1):
  rcu/update: fix same dept key collision between various types of RCU

 Documentation/dev-tools/dept.rst     |  905 ++++++++
 Documentation/dev-tools/dept_api.rst |  124 +
 Documentation/dev-tools/index.rst    |    2 +
 drivers/dma-buf/dma-fence.c          |   23 +-
 include/linux/completion.h           |  124 +-
 include/linux/dept.h                 |  267 +++
 include/linux/dept_ldt.h             |   78 +
 include/linux/dept_sdt.h             |   68 +
 include/linux/dept_unit_test.h       |   61 +
 include/linux/dma-fence.h            |   74 +-
 include/linux/hardirq.h              |    3 +
 include/linux/irq-entry-common.h     |    4 +
 include/linux/irqflags.h             |   21 +-
 include/linux/local_lock_internal.h  |    1 +
 include/linux/lockdep.h              |  105 +-
 include/linux/lockdep_types.h        |    3 +
 include/linux/mm_types.h             |    4 +
 include/linux/mmu_notifier.h         |   26 +
 include/linux/mutex.h                |    1 +
 include/linux/page-flags.h           |  217 +-
 include/linux/pagemap.h              |   37 +-
 include/linux/percpu-rwsem.h         |    2 +-
 include/linux/percpu.h               |    4 +
 include/linux/rcupdate_wait.h        |   13 +-
 include/linux/rtmutex.h              |    1 +
 include/linux/rwlock_types.h         |    1 +
 include/linux/rwsem.h                |    1 +
 include/linux/sched.h                |  111 +
 include/linux/seqlock.h              |    2 +-
 include/linux/spinlock_types_raw.h   |    3 +
 include/linux/srcu.h                 |    2 +-
 include/linux/sunrpc/xprt.h          |    9 +-
 include/linux/swait.h                |    3 +
 include/linux/wait.h                 |    3 +
 include/linux/wait_bit.h             |    3 +
 init/init_task.c                     |    2 +
 init/main.c                          |    2 +
 kernel/Makefile                      |    1 +
 kernel/cpu.c                         |    2 +-
 kernel/dependency/Makefile           |    5 +
 kernel/dependency/dept.c             | 3222 ++++++++++++++++++++++++++
 kernel/dependency/dept_hash.h        |   10 +
 kernel/dependency/dept_internal.h    |  314 +++
 kernel/dependency/dept_object.h      |   13 +
 kernel/dependency/dept_proc.c        |   94 +
 kernel/dependency/dept_unit_test.c   |  149 ++
 kernel/exit.c                        |    1 +
 kernel/fork.c                        |    2 +
 kernel/locking/lockdep.c             |   33 +
 kernel/module/main.c                 |    2 +
 kernel/rcu/rcu.h                     |    1 +
 kernel/rcu/update.c                  |    5 +-
 kernel/sched/completion.c            |   62 +-
 kernel/sched/core.c                  |    9 +
 kernel/workqueue.c                   |    3 +
 lib/Kconfig.debug                    |   48 +
 lib/debug_locks.c                    |    2 +
 lib/locking-selftest.c               |    2 +
 mm/filemap.c                         |   38 +
 mm/mm_init.c                         |    3 +
 mm/mmu_notifier.c                    |   31 +-
 rust/helpers/completion.c            |    5 +
 62 files changed, 6247 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/dev-tools/dept.rst
 create mode 100644 Documentation/dev-tools/dept_api.rst
 create mode 100644 include/linux/dept.h
 create mode 100644 include/linux/dept_ldt.h
 create mode 100644 include/linux/dept_sdt.h
 create mode 100644 include/linux/dept_unit_test.h
 create mode 100644 kernel/dependency/Makefile
 create mode 100644 kernel/dependency/dept.c
 create mode 100644 kernel/dependency/dept_hash.h
 create mode 100644 kernel/dependency/dept_internal.h
 create mode 100644 kernel/dependency/dept_object.h
 create mode 100644 kernel/dependency/dept_proc.c
 create mode 100644 kernel/dependency/dept_unit_test.c


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.17.1


