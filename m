Return-Path: <linux-nfs+bounces-23024-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7KEyNp9JS2q8OgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23024-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:22:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B22C70CE0B
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:22:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23024-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23024-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C14543017B92
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 06:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB63CE4BA;
	Mon,  6 Jul 2026 06:19:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A293C3459;
	Mon,  6 Jul 2026 06:19:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318795; cv=none; b=EMmOL+ztIPVgkg5oFIgHmJM1sxvnu/pb+TW+MPfTi629f5ZysJPaw7tD8K7LTD1QQ8iNrB0GZnnKDxiAsXlKwmHn6GpOpikkF8P7lE4yQOKazMaYOssWXERlr3GvNoz5wzQ595WkNv7nJOGnXkC9ANWCYlMDxGaf4D4SWq4c+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318795; c=relaxed/simple;
	bh=ywGM9exg7NUclYmWmY1MHRIgF2XcdVWS3UTht7dW7rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZGNyswRUFYJIYETug1njbQToMGgFCADXYxdVfbwnGd6wfigO2FheCRT7wCOKJ5YSzT4k1evrDI8gPgcq0mLWI+4WMsOnjGglFT9ilgh2GccvOAqk8c1nFsYPFk1bbhmav/iwIznyNsRwxLn6g8DPaVJl/Rsyw+cS0Eo3DE7fuE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c2dff70000001609-b2-6a4b48fca72c
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
Subject: [PATCH v19 04/40] dept: tie to lockdep and IRQ tracing
Date: Mon,  6 Jul 2026 15:18:52 +0900
Message-Id: <20260706061928.66713-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSW0xTdxwHcP/nTkPjSTV6xERNI2rEy7q45fegjoc9/KOZ0fhgZPNS5TjK
	KJBymRg0KCq1gCl1lY1SrEUrAoXabkZhIJLZzYBYdELBsAFqxcBpJ0qdSHWt07dPfpfv7+XH
	kYoBOoHTZOaKukx1hpKRUTIp3r46gjenf1J5loLq5kYG9O6faPij/xgFEZOXBb/vBgmNPx8l
	wDzymIGqgIWF/vAEgscdJQjOjwyRcNtcyoDUW01A0MVAb/c4AqvFhKC4tpmB68MtLPztCFDQ
	ZbQTcPbKfLBUjkXTnK0EWO7cp2G0roqFmREVvLNlgbfhKQtN0l0abv/VR4N74BYC96Oo2gaT
	oMz1Cw1Fllc0+Dq6aLjX4KPgbouThov9vQSETy8EX0U5DX7jEwTOoJ2BM8EAgoHKCRYcUyEW
	vLZ54DoevXb53CUEpsAkCyVjrQy064cJeFplJeDMPRsDHreZhD7TOQZGT0ssTFrf0nCi7DUL
	5hk9A/+6HtFgfakCZ6QPQdD4kk5OxvWeqwRurGlE+M20CeHpqQcMbgvbKHzh1DSBK+6sxter
	hlh8vH2QxTZ3HvbUrcS1vz4j8OD4BuyuP8Vgg/QngYM9PezWxBTZ+lQxQ5Mv6tZu3CtL6+4b
	ZbNthQf/6f2RLEKv9hlQHCfw64Tz0jRhQNx7X3mui5UZfrng978mY57LLxE85QHagGQcyd9f
	LJQ5yqlYYw7/hVDXfQzFTPGJwrubpWzMcv4zob+5h/w/f7HQ4Op47zj+c6FpxkrErIjOPAz9
	TsVCBf5SnFDpb/uwsEC4WeenjEhuQ7PqkUKTma9VazLWrUkryNQcXLM/S+tG0YdzHJ75+hqa
	9G3vRDyHlPFySN6UrqDV+TkF2k4kcKRyrnzZis3pCnmquuCQqMvao8vLEHM60UKOUs6Xfxr+
	PlXBf6vOFb8TxWxR97FLcHEJRajCOObQRGpVWqnGY01RreiWLMNJe+xLlp2U19SrsvN2t9wq
	db/Y6QzpNy16UJzYOj6aX5IqLC1eu1cc2qLPvbZo+Y5vko6GyXZh1kRD8Icwuy2ej3RVzy5M
	N0jmZ3n2rd4E39RX273qnsInq44cObzFNlt7IC3UtCuUMmeo+svflFROmlq1ktTlqP8Dy+5Y
	RmwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSWUwTYRSF+Wf+zgyNNZOKOtEHtYm74hLRa9yfnIhbNNHERKXCRAqlmBYr
	oKKAjRWXYLVFLSiiVAIVEBBEbERQXAChgkJkJxUkgBUFCWttTXw5+U7OOcl9uAwpLRLNYhSq
	CEGtkitllBiLd2+IXz7G+4estNQA6HXnoLnNIYIvsaUYhgb1GJJzrBRMmIto0OfdFsG7hjgM
	tdlZCNqG9AiGx8wk6IpdGCYMFTQMjjTRYIxF4LJVIDDZDSQ01r4kwVoQS8Dv3EkKest/ITB2
	OChI6onF4LRcQXCny0xDz5vt0N9WIgJXSzcBDX/6EFgckwQ4Si8imDCFwr20fPfc9JOCseoa
	EpKMtQjud7SQ8KunHUFBRSsCW0YcBd8Sn5JQ55gK9UNOCt4bL1PQb08m4EcuBalxNhHYq3oR
	pJgNCLq+2giIf5BDgSklD0Nx+3Ma7L3jBDSbDARk5e2CNksXhsrENMJ9rrv1ZCaYk+IJt3wn
	wPi4hIARSya9NR3xw7prmM/MLyR43acJirfetSJ+bNSA+MH0eJLXJbpteZ+T5C/kn+LTK/so
	fnToM8Xb/qRi/kMaxz+8NErw16uX88V3Wui92w6JNwYJSoVWUK/YHCAOrvrSSZ9IPRP5036L
	PI+GjyUghuHYNdyTAXUC8mYodiHX2DhCetiHncvlX+0SJSAxQ7J1c7grlqvYE0xjt3AZVXHI
	w5idz7leXaY9LGH9uIacj//GHDuHy8ot/cfe7FouezyF8LDU3WlyvsWJSJyKvDKRj0KlDZMr
	lH6+mtDgKJUi0jcwPCwPud/Jcnb8+jM0WLe9DLEMkk2RwNYdIVKRXKuJCitDHEPKfCQLFvmH
	SCVB8qhoQR1+VH1SKWjK0GwGy2ZKdhwUAqTscXmEECoIJwT1/5RgvGedR75erm7N6U6nPuZI
	dGTElprTMSHrp6xet6fA7/6Suv71r+2bqioHCtvxjXrLTq+NOKgpfJdk9dLbk62F83weqY4s
	LqlfXOS/79CM180JbxVF6Q8CtS9iqkV7kxtH9MpubXSB4/BozED40pvaln240HpK0zQevawz
	o3SBdv/0ZXcPRC6SYU2wfNUSUq2R/wXD/663SgMAAA==
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
	TAGGED_FROM(0.00)[bounces-23024-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sk.com:from_mime,sk.com:email,sk.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B22C70CE0B

How to place dept this way looks so ugly.  However, it's inevitable for
now.  The way should be enhanced gradually.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/irqflags.h            |   7 +-
 include/linux/local_lock_internal.h |   1 +
 include/linux/lockdep.h             | 102 ++++++++++++++++++++++------
 include/linux/lockdep_types.h       |   3 +
 include/linux/mutex.h               |   1 +
 include/linux/percpu-rwsem.h        |   2 +-
 include/linux/rtmutex.h             |   1 +
 include/linux/rwlock_types.h        |   1 +
 include/linux/rwsem.h               |   1 +
 include/linux/seqlock.h             |   2 +-
 include/linux/spinlock_types_raw.h  |   3 +
 include/linux/srcu.h                |   2 +-
 kernel/dependency/dept.c            |   8 +--
 kernel/locking/lockdep.c            |  22 ++++++
 14 files changed, 127 insertions(+), 29 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 57b074e0cfbb..d8b9cf093f83 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -15,6 +15,7 @@
 #include <linux/irqflags_types.h>
 #include <linux/typecheck.h>
 #include <linux/cleanup.h>
+#include <linux/dept.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
@@ -55,8 +56,10 @@ extern void trace_hardirqs_off(void);
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()			\
 do {							\
-	if (__this_cpu_inc_return(hardirq_context) == 1)\
+	if (__this_cpu_inc_return(hardirq_context) == 1) { \
 		current->hardirq_threaded = 0;		\
+		dept_hardirq_enter();			\
+	}						\
 } while (0)
 # define lockdep_hardirq_threaded()		\
 do {						\
@@ -131,6 +134,8 @@ do {						\
 # define lockdep_softirq_enter()		\
 do {						\
 	current->softirq_context++;		\
+	if (current->softirq_context == 1)	\
+		dept_softirq_enter();		\
 } while (0)
 # define lockdep_softirq_exit()			\
 do {						\
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 234be7f12c15..09255c5a665f 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -35,6 +35,7 @@ typedef struct local_trylock local_trylock_t;
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
 		.lock_type = LD_LOCK_PERCPU,		\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	},						\
 	.owner = NULL,
 
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 621566345406..60b17a2ff555 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -12,6 +12,7 @@
 
 #include <linux/lockdep_types.h>
 #include <linux/smp.h>
+#include <linux/dept_ldt.h>
 #include <asm/percpu.h>
 
 struct task_struct;
@@ -39,6 +40,8 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 	 */
 	for (i = 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
 		to->class_cache[i] = NULL;
+
+	dept_map_copy(&to->dmap, &from->dmap);
 }
 
 /*
@@ -428,7 +431,8 @@ enum xhlock_context_t {
  * Note that _name must not be NULL.
  */
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
-	{ .name = (_name), .key = (void *)(_key), }
+	{ .name = (_name), .key = (void *)(_key), \
+	  .dmap = DEPT_MAP_INITIALIZER(_name, _key) }
 
 static inline void lockdep_invariant_state(bool force) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
@@ -510,33 +514,89 @@ extern bool read_lock_is_recursive(void);
 #define lock_acquire_shared(l, s, t, n, i)		lock_acquire(l, s, t, 1, 1, n, i)
 #define lock_acquire_shared_recursive(l, s, t, n, i)	lock_acquire(l, s, t, 2, 1, n, i)
 
-#define spin_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define spin_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define spin_release(l, i)			lock_release(l, i)
-
-#define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
+#define spin_acquire(l, s, t, i)					\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+} while (0)
+#define spin_acquire_nest(l, s, t, n, i)				\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, n, i);				\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+} while (0)
+#define spin_release(l, i)						\
+do {									\
+	ldt_unlock(&(l)->dmap, i);					\
+	lock_release(l, i);						\
+} while (0)
+#define rwlock_acquire(l, s, t, i)					\
+do {									\
+	ldt_wlock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+} while (0)
 #define rwlock_acquire_read(l, s, t, i)					\
 do {									\
+	ldt_rlock(&(l)->dmap, s, t, NULL, i, !read_lock_is_recursive());\
 	if (read_lock_is_recursive())					\
 		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
 	else								\
 		lock_acquire_shared(l, s, t, NULL, i);			\
 } while (0)
-
-#define rwlock_release(l, i)			lock_release(l, i)
-
-#define seqcount_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define seqcount_acquire_read(l, s, t, i)	lock_acquire_shared_recursive(l, s, t, NULL, i)
-#define seqcount_release(l, i)			lock_release(l, i)
-
-#define mutex_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define mutex_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define mutex_release(l, i)			lock_release(l, i)
-
-#define rwsem_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define rwsem_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define rwsem_acquire_read(l, s, t, i)		lock_acquire_shared(l, s, t, NULL, i)
-#define rwsem_release(l, i)			lock_release(l, i)
+#define rwlock_release(l, i)						\
+do {									\
+	ldt_unlock(&(l)->dmap, i);					\
+	lock_release(l, i);						\
+} while (0)
+#define seqcount_acquire(l, s, t, i)					\
+do {									\
+	ldt_wlock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+} while (0)
+#define seqcount_acquire_read(l, s, t, i)				\
+do {									\
+	ldt_rlock(&(l)->dmap, s, t, NULL, i, false);			\
+	lock_acquire_shared_recursive(l, s, t, NULL, i);		\
+} while (0)
+#define seqcount_release(l, i)						\
+do {									\
+	ldt_unlock(&(l)->dmap, i);					\
+	lock_release(l, i);						\
+} while (0)
+#define mutex_acquire(l, s, t, i)					\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+} while (0)
+#define mutex_acquire_nest(l, s, t, n, i)				\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, n, i);				\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+} while (0)
+#define mutex_release(l, i)						\
+do {									\
+	ldt_unlock(&(l)->dmap, i);					\
+	lock_release(l, i);						\
+} while (0)
+#define rwsem_acquire(l, s, t, i)					\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+} while (0)
+#define rwsem_acquire_nest(l, s, t, n, i)				\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, n, i);				\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+} while (0)
+#define rwsem_acquire_read(l, s, t, i)					\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_shared(l, s, t, NULL, i);				\
+} while (0)
+#define rwsem_release(l, i)						\
+do {									\
+	ldt_unlock(&(l)->dmap, i);					\
+	lock_release(l, i);						\
+} while (0)
 
 #define lock_map_acquire(l)			lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
 #define lock_map_acquire_try(l)			lock_acquire_exclusive(l, 0, 1, NULL, _THIS_IP_)
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index eae115a26488..0c3389ed26b6 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -11,6 +11,7 @@
 #define __LINUX_LOCKDEP_TYPES_H
 
 #include <linux/types.h>
+#include <linux/dept.h>
 
 #define MAX_LOCKDEP_SUBCLASSES		8UL
 
@@ -77,6 +78,7 @@ struct lock_class_key {
 		struct hlist_node		hash_entry;
 		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
 	};
+	struct dept_key				dkey;
 };
 
 extern struct lock_class_key __lockdep_no_validate__;
@@ -195,6 +197,7 @@ struct lockdep_map {
 	int				cpu;
 	unsigned long			ip;
 #endif
+	struct dept_map			dmap;
 };
 
 struct pin_cookie { unsigned int val; };
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index ecaa0440f6ec..3d9bc1a28569 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -29,6 +29,7 @@ struct device;
 		, .dep_map = {					\
 			.name = #lockname,			\
 			.wait_type_inner = LD_WAIT_SLEEP,	\
+			.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 		}
 #else
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index c8cb010d655e..ca9522f0882b 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -22,7 +22,7 @@ struct percpu_rw_semaphore {
 };
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname, .dmap = DEPT_MAP_INITIALIZER(lockname, NULL) },
 #else
 #define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)
 #endif
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index ede4c6bf6f22..ac68c3e5e2ec 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -91,6 +91,7 @@ do { \
 	.dep_map = {					\
 		.name = #mutexname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
+		.dmap = DEPT_MAP_INITIALIZER(mutexname, NULL),\
 	}
 #else
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index d5e7316401e7..f2ff62ef4c36 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -10,6 +10,7 @@
 	.dep_map = {							\
 		.name = #lockname,					\
 		.wait_type_inner = LD_WAIT_CONFIG,			\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),		\
 	}
 #else
 # define RW_DEP_MAP_INIT(lockname)
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 9bf1d93d3d7b..47ab3fcee48b 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -22,6 +22,7 @@
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	},
 #else
 # define __RWSEM_DEP_MAP_INIT(lockname)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5a40252b8334..efc93acf1612 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -52,7 +52,7 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 # define SEQCOUNT_DEP_MAP_INIT(lockname)				\
-		.dep_map = { .name = #lockname }
+		.dep_map = { .name = #lockname, .dmap = DEPT_MAP_INITIALIZER(lockname, NULL) }
 
 /**
  * seqcount_init() - runtime initializer for seqcount_t
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index e5644ab2161f..5f245afdd77c 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -32,11 +32,13 @@ typedef struct raw_spinlock raw_spinlock_t;
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SPIN,	\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	}
 # define SPIN_DEP_MAP_INIT(lockname)			\
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	}
 
 # define LOCAL_SPIN_DEP_MAP_INIT(lockname)		\
@@ -44,6 +46,7 @@ typedef struct raw_spinlock raw_spinlock_t;
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
 		.lock_type = LD_LOCK_PERCPU,		\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	}
 #else
 # define RAW_SPIN_DEP_MAP_INIT(lockname)
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index bb44a0bd7696..50c78f71ad43 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -53,7 +53,7 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
 	__init_srcu_struct_fast_updown((ssp), #ssp, &__srcu_key); \
 })
 
-#define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map = { .name = #srcu_name },
+#define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map = { .name = #srcu_name, .dmap = DEPT_MAP_INITIALIZER(srcu_name, NULL) },
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 int init_srcu_struct(struct srcu_struct *ssp);
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 52b9669fe017..47fef2207af1 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -250,10 +250,10 @@ static bool dept_working(void)
  * Even k == NULL is considered a valid key because it would use
  * &->map_key as the key in that case.
  */
-struct dept_key __dept_no_validate__;
+extern struct lock_class_key __lockdep_no_validate__;
 static bool valid_key(struct dept_key *k)
 {
-	return &__dept_no_validate__ != k;
+	return &__lockdep_no_validate__.dkey != k;
 }
 
 /*
@@ -1921,7 +1921,7 @@ void dept_softirqs_off(void)
 	dept_task()->softirqs_enabled = false;
 }
 
-void dept_hardirqs_off(void)
+void noinstr dept_hardirqs_off(void)
 {
 	/*
 	 * Assumes that it's called with IRQ disabled so that accessing
@@ -1943,7 +1943,7 @@ void dept_softirq_enter(void)
 /*
  * Ensure it's the outmost hardirq context.
  */
-void dept_hardirq_enter(void)
+void noinstr dept_hardirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2d4c5bab5af8..dc97f2753ef8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1224,6 +1224,8 @@ void lockdep_register_key(struct lock_class_key *key)
 	struct lock_class_key *k;
 	unsigned long flags;
 
+	dept_key_init(&key->dkey);
+
 	if (WARN_ON_ONCE(static_obj(key)))
 		return;
 	hash_head = keyhashentry(key);
@@ -4361,6 +4363,8 @@ static void __trace_hardirqs_on_caller(void)
  */
 void lockdep_hardirqs_on_prepare(void)
 {
+	dept_hardirqs_on();
+
 	if (unlikely(!debug_locks))
 		return;
 
@@ -4481,6 +4485,8 @@ EXPORT_SYMBOL_GPL(lockdep_hardirqs_on);
  */
 void noinstr lockdep_hardirqs_off(unsigned long ip)
 {
+	dept_hardirqs_off();
+
 	if (unlikely(!debug_locks))
 		return;
 
@@ -4525,6 +4531,8 @@ void lockdep_softirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
 
+	dept_softirqs_on_ip(ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -4563,6 +4571,8 @@ void lockdep_softirqs_on(unsigned long ip)
  */
 void lockdep_softirqs_off(unsigned long ip)
 {
+	dept_softirqs_off();
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -4940,6 +4950,8 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 {
 	int i;
 
+	ldt_init(&lock->dmap, &key->dkey, subclass, name);
+
 	for (i = 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
 		lock->class_cache[i] = NULL;
 
@@ -5736,6 +5748,12 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
 {
 	unsigned long flags;
 
+	/*
+	 * dept_map_(re)init() might be called twice redundantly. But
+	 * there's no choice as long as Dept relies on Lockdep.
+	 */
+	ldt_set_class(&lock->dmap, name, &key->dkey, subclass, ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -5753,6 +5771,8 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
+	ldt_downgrade(&lock->dmap, ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -6588,6 +6608,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	bool found = false;
 	bool need_callback = false;
 
+	dept_key_destroy(&key->dkey);
+
 	might_sleep();
 
 	if (WARN_ON_ONCE(static_obj(key)))
-- 
2.17.1


