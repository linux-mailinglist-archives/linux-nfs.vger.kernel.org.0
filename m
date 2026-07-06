Return-Path: <linux-nfs+bounces-23055-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gqpBHsxTS2q2PQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23055-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 09:05:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 186E870D48A
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 09:05:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23055-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23055-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16218316AF36
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 06:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D042B31E;
	Mon,  6 Jul 2026 06:22:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8E0400E15;
	Mon,  6 Jul 2026 06:21:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318931; cv=none; b=ueYPVbdVXGq3onQTU4qw/C2teGm471FCkJ80bfOZHlieP5XZvPozRGhfOeRDc84qZEix59/QXFtGk5nxEjDnpuNKd6AyNfG75GOxBvqEM+TR40lsTHX2mgLGGfntOOoglA9bzPX+29catAUAfVyvlbP07wSfNXrCgqWwnfdudk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318931; c=relaxed/simple;
	bh=qdrhPquz9LK1TSCcGBmbSQVFrGLawwrbGLlsjRyWAwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nZGWObkToGdXmp9oXFD+0ke+uVj1ZglVZ4Q73UJNe5GqiPA5reECm2x9sFlPJld6t1WvzKoo9iFAdiVywXFiEUcyXofzW9P/LC9TY1ocFpr+FzjIteAAY79SexqvnqUbz9GqOG2ZV9Tn0szjXxFmlW4aLgSmDMcXOogwc4QwcHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c45ff70000001609-c7-6a4b4983bcb4
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
Subject: [PATCH v19 34/40] rcu/update: fix same dept key collision between various types of RCU
Date: Mon,  6 Jul 2026 15:19:22 +0900
Message-Id: <20260706061928.66713-35-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d97/7eXhiY3FfWKMZga8CURdUE9S8Sgidt1ZolmWTT6QW/k
	KkVA1yITMw1OQCXS1BrWzMq7LdpCi1UMilWsWhE2KL6MokjHEipMCuGlgIAvt25+OfnlOec8
	5/lwGFLZhaMZdUamqMkQ0lS0nJIHIytWnNqyNXVVsS0aLjmqafDabQj8oTMIJqZNJLw3eGTw
	0eVB8Fu7gQSf9x4Jo7UfaAj6GzAYi7wIRvr/RnDD042gV19HQtmvLgyBly4C2t/OEGBzfg9+
	S4ACYz8NJuMpQip9BBTVNBDwzmKVgSUnFuzBNgxvAwYa/I/zMTg7HyEoz79Mwe8lXTTccT2h
	4FxtHYYc0wQGb2MLBscbHwFPLl6loO12DQZzRzsB1//8g4Rx3QLwni/E4NP3IqgZrKDhyrBR
	SvQinwBP2Vy4WlolZb48ToF5bJCE030NNDgCD0iYqpKuNk81E/CPLiiDkeIPGIpmzkipT+oQ
	nBz1I8jtWgO61m9hzGalYVA/hsH0qFuWlMRP5OkoPu/pe5qvLqlG/PSUAfF5eokeDAyRvLll
	gOabKzj+1sXXMr7MeYTPfRjEfOWdfoIvHwlh3mk9S/Pl030kP9jaKtsWs0u+PllMU2eJmpUb
	9spTyttcxOHnG47eLbCSOahtVQGKYDg2gbNWhugv7O924zDT7BLO53tHhjmKXcRdLwxIupwh
	2Wcx3DlLIVWAGGY2u4eratofnqHYWG7Y5/jso2DXcq8m22X/ecZwttrGzz4Rkm6fKSbCrGTX
	cK+GHlNhT461RXATnfX/L8zn7l/xUXqkKEOzrEipzshKF9RpCfEp2Rnqo/H7DqU7kfRzluMz
	u+vRiPcHN2IZpIpUQNJ3qUosZGmz092IY0hVlCJu6dZUpSJZyD4mag7t0RxJE7VutIChVPMU
	X43/nKxkDwiZ4kFRPCxqvnQJJiI6B8Wf0N7YWbFkdLJ/8TF9k2xH/ZbX8+d4WxuH7ycYzvak
	DAzHDgVDTTsTbx3XHvjLeCFqnsnhXhy5fe2u1UJJrrjbuUzl2htKLO39cezeptNxpYmquT3W
	yp/q7MoOYVGLvOeafeOJfztn4bivXzaui3s+mZhp3udZ+PSbFZu33TR3TK/7RUVpU4TVy0mN
	VvgEtFflsW8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTGfd9779tLY81NIXqDiZoG8SuKZkhOVIgmRu40GhMTRRMDjV6l
	fKmtQzFblGJjZTjbmpZIQQGlakFBQBS1SiDrHIpQi9IMsGI6HAFFkSqfdu3M/jn5nec858n5
	47CU/C4TyaqyjorqLGWGgkhp6ba1ecu1P25JW2k6Hwt63Uno8foYeJXbRIN/VE9DcXUVgWnr
	XQnoay8y8KRLS0PHrUoEXr8ewddJKwW6xgAN0yanBEbHuyVgzkUQcDgRWFwmCjwdjymoqs/F
	8LnmG4HBlhEE5j4fgcKBXBqGbQUIivqtEhj4PRHeex8wEOh9h6HryxACm+8bBl/TGQTTlnS4
	XF4XXLd8JDDZ1k5BobkDQVlfLwUjA28Q1DtfI3Bc1xL423CHArdvFnT6hwn8af6VwHtXMYYP
	NQRKtQ4GXM8GEZRYTQj6/3JgyLtSTcBSUktD45v7EnANTmHosZgwVNZuBa+tn4anhnIcPDfo
	uj0HrIV5OFj+wWC++QDDuM0uWV+BhK+632jBXteABd2LaSJUXapCwuSECQmjFXmUoDME25ah
	YUo4XXdMqHg6RIQJ/0siOL6U0kJrOS9cPTuBBWPbcqGxqFeyfcMe6br9YoYqW1THJKRIU8va
	HfhwZ8LxR/l26hRqX5mPwliei+W9r5uZEBNuEe/xjFMhjuAW8HXn+oO6lKU493y+wHaOzkcs
	G84l89eeHAh5aG4h/8lTTUIs4+L47jGX5HvmfL6ypum/nLCgfmuqBIdYzq3mu4f/oA1IWopm
	2FGEKis7U6nKWL1Ck56ak6U6vmLfocxaFHwn2y9Txnto1J3YjDgWKWbKYP3mNDmjzNbkZDYj
	nqUUEbLoxVvS5LL9ypwTovpQsvqnDFHTjOaytGKObPMuMUXOHVQeFdNF8bCo/n+K2bDIUyj+
	PO6r2bs1ENs52/HQuNH+6fYPC3t+1p1s60hagjbJR4pnLotfUxTQ7Yjyawui8knU7lfUEaNp
	G7NkjafhUon7Rmt4Qtlzg3GMOC9E1scdIclvW/DOMynassRonX6PIjzJ1XUjGxrmHUttdS7Q
	lEu1MSSmKd697+bY6WimM05Ba1KVq5ZSao3yX1zt3TVKAwAA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-23055-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sk.com:from_mime,sk.com:email,sk.com:mid,kzalloc.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 186E870D48A

From: Yunseong Kim <ysk@kzalloc.com>

The current implementation shares the same dept key for multiple
synchronization points, which can lead to false positive reports in
dependency tracking and potential confusion in debugging.  For example,
both normal RCU and tasks trace RCU synchronization points use the same
dept key.  Specifically:

   1. synchronize_rcu() uses a dept key embedded in __wait_rcu_gp():

      synchronize_rcu()
         synchronize_rcu_normal()
            _wait_rcu_gp()
               __wait_rcu_gp() <- the key as static variable

   2. synchronize_rcu_tasks_trace() uses the dept key, too:

      synchronize_rcu_tasks_trace()
         synchronize_rcu_tasks_generic()
            _wait_rcu_gp()
               __wait_rcu_gp() <- the key as static variable

Since the both rely on the same dept key, dept may report false positive
circular dependency.  To resolve this, separate dept keys and maps
should be assigned to each struct rcu_synchronize.

   ===================================================
   DEPT: Circular dependency has been detected.
   6.15.0-rc6-00042-ged94bafc6405 #2 Not tainted
   ---------------------------------------------------
   summary
   ---------------------------------------------------
   *** DEADLOCK ***

   context A
      [S] lock(cpu_hotplug_lock:0)
      [W] __wait_rcu_gp(<sched>:0)
      [E] unlock(cpu_hotplug_lock:0)

   context B
      [S] (unknown)(<sched>:0)
      [W] lock(cpu_hotplug_lock:0)
      [E] try_to_wake_up(<sched>:0)

   [S]: start of the event context
   [W]: the wait blocked
   [E]: the event not reachable
   ---------------------------------------------------
   context A's detail
   ---------------------------------------------------
   context A
      [S] lock(cpu_hotplug_lock:0)
      [W] __wait_rcu_gp(<sched>:0)
      [E] unlock(cpu_hotplug_lock:0)

   [S] lock(cpu_hotplug_lock:0):
   [<ffff8000802ce964>] cpus_read_lock+0x14/0x20
   stacktrace:
         percpu_down_read.constprop.0+0x88/0x2ec
         cpus_read_lock+0x14/0x20
         cgroup_procs_write_start+0x164/0x634
         __cgroup_procs_write+0xdc/0x4d0
         cgroup_procs_write+0x34/0x74
         cgroup_file_write+0x25c/0x670
         kernfs_fop_write_iter+0x2ec/0x498
         vfs_write+0x574/0xc30
         ksys_write+0x124/0x244
         __arm64_sys_write+0x70/0xa4
         invoke_syscall+0x88/0x2e0
         el0_svc_common.constprop.0+0xe8/0x2e0
         do_el0_svc+0x44/0x60
         el0_svc+0x50/0x188
         el0t_64_sync_handler+0x10c/0x140
         el0t_64_sync+0x198/0x19c

   [W] __wait_rcu_gp(<sched>:0):
   [<ffff8000804ce88c>] __wait_rcu_gp+0x324/0x498
   stacktrace:
         schedule+0xcc/0x348
         schedule_timeout+0x1a4/0x268
         __wait_for_common+0x1c4/0x3f0
         __wait_for_completion_state+0x20/0x38
         __wait_rcu_gp+0x35c/0x498
         synchronize_rcu_normal+0x200/0x218
         synchronize_rcu+0x234/0x2a0
         rcu_sync_enter+0x11c/0x300
         percpu_down_write+0xb4/0x3e0
         cgroup_procs_write_start+0x174/0x634
         __cgroup_procs_write+0xdc/0x4d0
         cgroup_procs_write+0x34/0x74
         cgroup_file_write+0x25c/0x670
         kernfs_fop_write_iter+0x2ec/0x498
         vfs_write+0x574/0xc30
         ksys_write+0x124/0x244

   [E] unlock(cpu_hotplug_lock:0):
   (N/A)
   ---------------------------------------------------
   context B's detail
   ---------------------------------------------------
   context B
      [S] (unknown)(<sched>:0)
      [W] lock(cpu_hotplug_lock:0)
      [E] try_to_wake_up(<sched>:0)

   [S] (unknown)(<sched>:0):
   (N/A)

   [W] lock(cpu_hotplug_lock:0):
   [<ffff8000802ce964>] cpus_read_lock+0x14/0x20
   stacktrace:
         percpu_down_read.constprop.0+0x6c/0x2ec
         cpus_read_lock+0x14/0x20
         check_all_holdout_tasks_trace+0x90/0xa30
         rcu_tasks_wait_gp+0x47c/0x938
         rcu_tasks_one_gp+0x75c/0xef8
         rcu_tasks_kthread+0x180/0x1dc
         kthread+0x3ac/0x74c
         ret_from_fork+0x10/0x20

   [E] try_to_wake_up(<sched>:0):
   [<ffff8000804233b8>] complete+0xb8/0x1e8
   stacktrace:
         try_to_wake_up+0x374/0x1164
         complete+0xb8/0x1e8
         wakeme_after_rcu+0x14/0x20
         rcu_tasks_invoke_cbs+0x218/0xaa8
         rcu_tasks_one_gp+0x834/0xef8
         rcu_tasks_kthread+0x180/0x1dc
         kthread+0x3ac/0x74c
         ret_from_fork+0x10/0x20
   (wait to wake up)
   stacktrace:
         __schedule+0xf64/0x3614
         schedule+0xcc/0x348
         schedule_timeout+0x1a4/0x268
         __wait_for_common+0x1c4/0x3f0
         __wait_for_completion_state+0x20/0x38
         __wait_rcu_gp+0x35c/0x498
         synchronize_rcu_tasks_generic+0x14c/0x220
         synchronize_rcu_tasks_trace+0x24/0x8c
         rcu_init_tasks_generic+0x168/0x194
         do_one_initcall+0x174/0xa00
         kernel_init_freeable+0x744/0x7dc
         kernel_init+0x78/0x220
         ret_from_fork+0x10/0x20

Separating the dept key and map for each of struct rcu_synchronize,
ensuring proper tracking for each execution context.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
[ Rewrote the changelog. ]
Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/rcupdate_wait.h | 13 ++++++++-----
 kernel/rcu/rcu.h              |  1 +
 kernel/rcu/update.c           |  5 +++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 4c92d4291cce..ee598e70b4bc 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -19,17 +19,20 @@ struct rcu_synchronize {
 
 	/* This is for debugging. */
 	struct rcu_gp_oldstate oldstate;
+	struct dept_map dmap;
+	struct dept_key dkey;
 };
 void wakeme_after_rcu(struct rcu_head *head);
 
 void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_func_t *crcu_array,
-		   struct rcu_synchronize *rs_array);
+		   struct rcu_synchronize *rs_array, struct dept_key *dkey);
 
 #define _wait_rcu_gp(checktiny, state, ...) \
-do {												\
-	call_rcu_func_t __crcu_array[] = { __VA_ARGS__ };					\
-	struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];				\
-	__wait_rcu_gp(checktiny, state, ARRAY_SIZE(__crcu_array), __crcu_array, __rs_array);	\
+do {													\
+	call_rcu_func_t __crcu_array[] = { __VA_ARGS__ };						\
+	static struct dept_key __key;									\
+	struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];					\
+	__wait_rcu_gp(checktiny, state, ARRAY_SIZE(__crcu_array), __crcu_array, __rs_array, &__key);	\
 } while (0)
 
 #define wait_rcu_gp(...) _wait_rcu_gp(false, TASK_UNINTERRUPTIBLE, __VA_ARGS__)
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9b10b57b79ad..d30dfc345532 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -12,6 +12,7 @@
 
 #include <linux/slab.h>
 #include <trace/events/rcu.h>
+#include <linux/dept_sdt.h>
 
 /*
  * Grace-period counter management.
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index d98a5c38e19c..c2858650ccf5 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -409,7 +409,7 @@ void wakeme_after_rcu(struct rcu_head *head)
 EXPORT_SYMBOL_GPL(wakeme_after_rcu);
 
 void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_func_t *crcu_array,
-		   struct rcu_synchronize *rs_array)
+		   struct rcu_synchronize *rs_array, struct dept_key *dkey)
 {
 	int i;
 	int j;
@@ -426,7 +426,8 @@ void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_func_t *c
 				break;
 		if (j == i) {
 			init_rcu_head_on_stack(&rs_array[i].head);
-			init_completion(&rs_array[i].completion);
+			sdt_map_init_key(&rs_array[i].dmap, dkey);
+			init_completion_dmap(&rs_array[i].completion, &rs_array[i].dmap);
 			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
 		}
 	}
-- 
2.17.1


