Return-Path: <linux-nfs+bounces-23037-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dh0oOOtOS2pDPAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23037-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:44:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E770D1C9
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:44:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23037-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23037-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68C8E314181C
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F803C73EC;
	Mon,  6 Jul 2026 06:21:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5903E3E5A33;
	Mon,  6 Jul 2026 06:20:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318872; cv=none; b=e7PS43Hv5Sm+4MGcwYfRCmSaP//ITisX6s1T1Qp/qBNn8gIecHmNWkg5FvVM5bSKQCvUsoc3xcPaUm0MImNOYrcYMsvuNFUAUktTPcaLhUdNzu+5yVdZZOd9VoezJnpKBzgL2pWEEADwYpFl1NQm+oaSdQCpmxFwFi0FKx51UjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318872; c=relaxed/simple;
	bh=b4wIyRNvI2EycGpP1ATGas8ShfzLdMlBYh3q9Efaew0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pHrCr/PRkliDhO7y3MqVozBaX7uwWiKiX8TrWS3mGSgY8zcoaKp57++qV2XDuRs7h84ty/UaAbFCW12f8kG6iDTfb0Xdw73DqNrdjmiMTE9wFRAJFYuDv2KjuYD0+jXUytaRjKmILOMd/J8ptpUfAMDtFvmPEMj74jmYvMS9LfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c2dff70000001609-59-6a4b4904ad2c
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
Subject: [PATCH v19 26/40] cpu/hotplug: use a weaker annotation in AP thread
Date: Mon,  6 Jul 2026 15:19:14 +0900
Message-Id: <20260706061928.66713-27-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xbdRjG+Z97G6rHssQz9mFag3eGLNvyuhlkCdHDZYkJkQ8imVVOpNy2
	lYtg5hxOkBFuQgobjI0ORi23YYGNybhLVFxHG3YplE4asQUZRbl0K9TNUwjffu/z5H2e98PL
	4HIrGcio0jMFdboyVUFJCemivzaYiIxOfqtHEwqF+V+Dqb0FQZW5AgeLaQCH1q48DDT2WQqq
	5/MIWGoqRlDjqKVhfvR9eGpzYnDf/RDBf1UpsGEcx6FaY0KgtdtwmJh9BhbNFzBwdVBgvrWA
	oK62AsGZhqviuODFYLqqAhNTKaitnhM72nox8NpDwVamIaB9cZwEw+QogsKf1ggw/HmPhL6p
	N0Bb0EhAcUc3CabB30mwGstosM9YSHCX7gJL+V8I2lyXKah0ORAsuJtwcNwtwEDfZ6RAf0mH
	oMKxTMN06d8E3JnsRdBfOIOBs6YOg5G1hxiM2VZo6DRocFi39ZCwrhP7jdfGaNB4C8Uz80oR
	dI8+oqHjXx0Fqy3Nojb6gA4P55s7r2F868VWxK9eOYPz+eUi9bnrCb7x7DrGf28M5m/U2Gj+
	2/4pmq83ZPENN+cx3tB8luK1G3M4P33vJsW7bt+m+dk71dgHL34kfSdRSFVlC+qQsE+kSRbt
	MHHcIcnxPHCTp9E3TBGSMBy7j7uy7EHb/GT1HOZjin2Fs1g8uI93sC9wnSUOsghJGZyd2M0V
	N5UQPiOAjeHM9y/TPibYIG5DN0n6WMYe4KxDv1Fbobu5lo7BzSCJqLd76zYL5Ox+zrr0C+EL
	5VidhCtavk5uLezkhn6wEOVIVo/8mpFclZ6dplSl7tuTlJuuytnz2bE0AxJfrukrb3wPWjbF
	DiOWQQp/GYRHJctJZXZGbtow4hhcsUP28qvRyXJZojL3S0F97Kg6K1XIGEa7GELxvGyv+4tE
	Ofu5MlNIEYTjgnrbxRhJ4GmUfVjhMMyc+NHtjLgV4dfrejcs4CX7+ec488CjuY+dwR82NviF
	RSZaE+yXngQFxoW8F/Trd7Uxf3yabH9tqS/w0MqMOvbo+NWJuLfjAi7Geit/tjeMPSv8443K
	WZxQ1D+O96vSez3OsuttR0b0pw76M48TFHq958ZKZvTJ3nNdb4a3ryuIjCRl6Ou4OkP5Pz/8
	+OduAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe2xLcRTH/e6rd80qV7fYDX+QikckGxKWkxAhzK55E48swsou695axojH
	Oo0alWrSjlXZxopttq7z2EZjKuYxo7WxMduQrszGmHayRzct8c/J55zvOd9z/jg0Lq4iJ9Cy
	1L28PFWaLKGEhHD1/OxwfPmKxNmXRyJBrToK7ztcJLzJqiXA61ETcKG8lAKf8Y4A1NbzJDxp
	VhLgKCtB0OFVI/g9ZMRBVT1KgE9XJwDPQKsA9FkIRm11CAxOHQ4tjvs4lN7MwuCXZYSC7od9
	CPQfXRTkdmUR0Gs+jSDPbRRA16No+NZxl4TRts8YNPf3IDC7RjBw1Z5A4DMkwaXCSv+44QcF
	Qw0vccjVOxAUfGzDoa/rA4Kbde0IbNeUFHRqb+HQ6BoLTd5eCp7qT1HwzXkBg+8WCvKVNhKc
	z7sRmIw6BO53NgyyL5dTYDBZCaj+UCMAZ/cwBu8NOgxKrKugw+wmoF5biPnP9XdVhIExNxvz
	hy8Y6G/cxWDAXCxYVIS436ozBFdceRvjVK98FFd6sRRxQ4M6xHmKsnFOpfWnD3t6ce545X6u
	qL6H4ga9rynO1p9PcM8KWe7KyUGMO9sQzlXntQnWLo4VLojnk2UZvHzWwjhhQkuBnUh3Bx0Y
	aO8njyElnYOCaJaZy454zmEBppjpbEvLAB7gUGYyW6lxkzlISONM4yT2tFlDBIQQZiXrbC4U
	BJhgprJDV9+SARYxkWzrg6fUP9NJbIml9q9RkL9eNmz6u0DMzGNbex8TWiTMR2OKUagsNSNF
	KkueF6FISshMlR2I2JmWYkX+fzIfHj5bhTyN0XbE0EgSLIJFMYliUpqhyEyxI5bGJaGiaTNW
	JIpF8dLMg7w8bbt8XzKvsKOJNCEJE8Vs5uPEzG7pXj6J59N5+X8Vo4MmHEPrtG8O1+xyLd1f
	JrrR/uC2RKZdtefcrKNtFx3k4qown7LV2zzX4Xi9NdbdNPFF6MZtG+yak+XGmE2m4KXMdxOm
	MS0rsN/rXBMS3xXVN8UaNVN451VFZ6xFE5YTsv7HvtVfHdG2Qz/TP824Pn7LkTM78jrHqeXB
	kTVLvE1N0zZGWebUSwhFgnTOTFyukP4BUcBZc0sDAAA=
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
	TAGGED_FROM(0.00)[bounces-23037-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sk.com:from_mime,sk.com:email,sk.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 883E770D1C9

cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
introduced to make lockdep_assert_cpus_held() work in AP thread.

However, the annotation is too strong for that purpose.  We don't have
to use more than try lock annotation for that.

rwsem_acquire() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1.  So trylock version of
annotation is sufficient for that purpose.  Now that dept partially
relies on lockdep annotaions, dept interpets rwsem_acquire() as a
potential wait and might report a deadlock by the wait.

Replace it with trylock version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bc4f7a9ba64e..ba9d89613590 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -542,7 +542,7 @@ int lockdep_is_cpus_write_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 1, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
-- 
2.17.1


