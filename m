Return-Path: <linux-nfs+bounces-23041-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EbVeC2FNS2rPOwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23041-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:38:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE970D0C1
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 08:38:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23041-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23041-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E229830A2026
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 06:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0C3EDAC1;
	Mon,  6 Jul 2026 06:21:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C533D6CDF;
	Mon,  6 Jul 2026 06:20:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318879; cv=none; b=aTa/aEDYaQnMBJyC+iqt4Hr5XPJu3WxyK0BRXGtS9EufPOsP6myOKCSUQ57I4twP4FDEm3skWakWtAdQR9CdP/e9G/zjAX9YLkrAO7XwvBvJed8TGripW7mJ8hgJf+LRXL9CsiyDDvkZhPq1VQTlxzrpWXX4vbTT6qiLrOoo0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318879; c=relaxed/simple;
	bh=Lp3G4SurifFSvmcZ/8UHAqo+I+Y1O71cAhYereWOhus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PtYkf7gKPYMcfefsreFFe2nHUA3/WH2lfi5pDUlncucTwfy2VOYIGudT3fvUV9id9FmhfUvloI9OVY3TyM2IQtQKvVjTkb+BSPTWKXMs6vykf8bIy+i8ZYoNZ4M4MAA8lfV7ZgRodT1vFb8exaEWBDjhOF8THJ5x4Bl+kVM1T1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c45ff70000001609-3a-6a4b4903be83
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
Subject: [PATCH v19 25/40] dept: add documents for dept
Date: Mon,  6 Jul 2026 15:19:13 +0900
Message-Id: <20260706061928.66713-26-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxjF978v/3vb0OWmmniVbbgm6uKEDQP6uLeYfdl/M0tM3L6MJVsn
	N1IshbSIFONSXtTCyoLNipGCYNkqoZVBK26gVYQAQahWma5iBaqINoMxDGiEMtZC9uXJL+ec
	nA9PDk8rg+wGXqPLl/Q6tVaF5Yx8OuFsMvPpnux3a8NvQmhsgoW7xV0MzM+ZGTB7TrMQaHEh
	GJs3I3ixaKdhydrHga0YwbKvD0EwcJUG94ViCmzhCQwzTguCmkk7B5HeT2B67BILyw+eUPDn
	8ykEE10nECxVH4R6hxfDov8mDc8i4wgu9I0i8DWVYHhc1U7D8MSrMGD7AcP0rVoK/m7F0FDi
	Y+HW0F8I6uxWBJMjPgpKG3/F0DHeyUGo2kqBy/M5DFY5KDgVwVDdtg7sp0qp2HlKwVBjiAG7
	f5iFh001HPS5nnDQMn2ThYHRuyyM9R9n4TfTOAeee70I5v4IU+C2TNJg7pxnwPMoFvGNvA2n
	z4QwmJfmEAx31mKwtLazMOpejn2na5DdnUmavRcpcuz2EibuM25EFhesiPRMzdCkzHuYLMzf
	weS6QyQ/ly9Q5KQ/mXTUPOBI2ZURjjR4DhFv01bSeDlCEU9zOd6b8pX8g0xJqymQ9O989K08
	y2cZxHmBBVTovO6iTcjRgSoQz4tCmviTM7cCyVZwtOcxG2csbBGDwZd0nNcKG0Vv5WRMl/O0
	MJwkWpyVTNxYI+wUHb5zVJwZYZNYOlCG46wQdoi9/17lVkuTRFdr10qRLKa3ROtW8kohXbw/
	08+sZs7JxNbw9lVeL15rCjJVSNGAXmlGSo2uIEet0aalZBl1msKU/bk5HhTbm/NoNON39Cyw
	rxsJPFIlKGD3Z9lKVl1gMOZ0I5GnVWsVm9/ak61UZKqNRZI+9xv9Ia1k6EaJPKNap9j+/HCm
	UjigzpcOSlKepP/fpXjZBhMq8P6yc2P93tC29u+j9nRDo+5j9sbru0Y84S8rdO+na/sjs4lX
	9rV9mBctGj+i2GTUvtZjQEmm80cydpWY1pyfTX0v9emBf1qyZglODrwBssKaxEff+V3W+q/D
	R2+c/CJ/yn+ijs9Ydm+DIWdCGm2UV94padti23zpYXl0h63I9qOKMWSpU7fSeoP6P3uonTFr
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe2xLcRTH/X739vaulKsWbhCPyuY5I15HsMxfu7ZY/OEVBA2XdU9pmU2I
	bW1nGKbSDjWms0vaYlqvWcps2bARnWHDHhbdmG0mbGSPrlrin5PP+X6/5+T8cWhC9kA0nlYm
	7uVViYp4OSUhJdHLNCHEqqjYeZmuGZClOwwNzW4RvE0vJaG3J4uECzdtFHhM98SQZT8ngqd1
	GSS4blgRNPdmIfg9YCJAV+wlwaOvFENP3wcxGNIReJ2VCIw1egLqXY8IsN1Ox/CzaIiCjvIf
	CAwtbgpy29NJ6BayEZxvM4mhvSICuppLROBt/Iyh7lcnAsE9hMFdegSBxxgHl8wO37jxOwUD
	L14SkGtwIbjc0kjAj/aPCG5XNiFwXsugoDXnDgG17pHwurebgmeG4xR01VzA8K2IgvwMpwhq
	nncgyDPpEbS9d2LQFNykwJhnJ6H44wMx1HQMYmgw6jFY7auhWWgjoTrHjH3n+lK3xoEpV4N9
	5QsGw/USDH2CRRxeiLjfupMkZ3HcxZzulYfibBdtiBvo1yOup1BDcLocX1ve2U1wWsd+rrC6
	k+L6e99QnPNXPslVmVnuytF+zJ1+EcIVn28Ur1m5SbJ8Jx+vTOZVoWHbJTHO7Gpqj6sfpQhV
	ViINmYvRMRRAs8xCtqm8VeRnipnO1tf3EX4OZKawjhNtPl1CE0ztZDZbOEH6jTHMEtbsvIr9
	TDJBrOaZlvKzlFnMVgw9Ev9bOpm1FpX+XRTg028M5v3Ny5hF7IfuJ2QOkuSjYRYUqExMTlAo
	4xfNVcfFpCYqU+buSEqwI99HCYcGT99HPbURZYihkXyEFMIjY2UiRbI6NaEMsTQhD5QGz4iK
	lUl3KlIP8Kqkbap98by6DE2gSfk4aeQGfruM2a3Yy8fx/B5e9d/FdMD4NPTu09V98994l57R
	6szn7q4Im/1wSsG6iVsrI0xh4S1TH89MCg7XloRiW+b+plG0UHXQEdwQvHt6xdFTnpSzkTvu
	M1GKd+tb17TzOv776IneXXMsm6edSlKVP9ZaQp9Hz1pbUh90KbrODlsl1cu3hGD0Km3x5UzV
	wa/CpAV66/CxXRvlpDpGMX8WoVIr/gBJXe+ATQMAAA==
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
	TAGGED_FROM(0.00)[bounces-23041-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sk.com:from_mime,sk.com:email,sk.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07FE970D0C1

Add documents describing the concept and APIs of dept.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 Documentation/dev-tools/dept.rst     | 905 +++++++++++++++++++++++++++
 Documentation/dev-tools/dept_api.rst | 124 ++++
 Documentation/dev-tools/index.rst    |   2 +
 3 files changed, 1031 insertions(+)
 create mode 100644 Documentation/dev-tools/dept.rst
 create mode 100644 Documentation/dev-tools/dept_api.rst

diff --git a/Documentation/dev-tools/dept.rst b/Documentation/dev-tools/dept.rst
new file mode 100644
index 000000000000..c0ed1314a5a7
--- /dev/null
+++ b/Documentation/dev-tools/dept.rst
@@ -0,0 +1,905 @@
+DEPT(DEPendency Tracker)
+========================
+
+Started by Byungchul Park <max.byungchul.park@sk.com>
+
+How lockdep works
+-----------------
+
+Lockdep detects deadlocks by checking lock acquisition order. For
+example, a graph to track acquisition order built by lockdep might look
+like:
+
+.. code-block::
+
+   A -> B -
+           \
+            -> E
+           /
+   C -> D -
+
+   where 'A -> B' means that acquisition A is prior to acquisition B
+   with A still held.
+
+Lockdep keeps adding each new acquisition order into the graph at
+runtime. For example, 'E -> C' will be added when the two locks have
+been acquired in the order E and then C. The graph will look like:
+
+.. code-block::
+
+       A -> B -
+               \
+                -> E -
+               /      \
+    -> C -> D -        \
+   /                   /
+   \                  /
+    ------------------
+
+   where 'A -> B' means that acquisition A is prior to acquisition B
+   with A still held.
+
+This graph contains a subgraph that demonstrates a loop like:
+
+.. code-block::
+
+                -> E -
+               /      \
+    -> C -> D -        \
+   /                   /
+   \                  /
+    ------------------
+
+   where 'A -> B' means that acquisition A is prior to acquisition B
+   with A still held.
+
+Lockdep reports it as a deadlock on detection of a loop and stops
+working.
+
+CONCLUSION
+
+Lockdep detects a deadlock by checking if a loop has been created after
+adding a new acquisition order into the graph.
+
+
+Limitation of lockdep
+---------------------
+
+Lockdep deals with deadlocks involving typical locks e.g. spinlock and
+mutex, that are supposed to be released within the acquisition context.
+However, when it comes to a deadlock involving folio lock that is not
+supposed to be released within the acquisition context or other general
+synchronization mechanisms, lockdep doesn't work.
+
+NOTE: In this document, 'context' refers to any type of unique context
+e.g. irq context, normal process context, wq worker context, and so on.
+
+Can lockdep detect the following deadlock?
+
+.. code-block::
+
+   context X	   context Y	   context Z
+
+		   mutex_lock A
+   folio_lock B
+		   folio_lock B <- DEADLOCK
+				   mutex_lock A <- DEADLOCK
+				   folio_unlock B
+		   folio_unlock B
+		   mutex_unlock A
+				   mutex_unlock A
+
+No. What about the following?
+
+.. code-block::
+
+   context X	   context Y
+
+		   mutex_lock A
+   mutex_lock A <- DEADLOCK
+		   wait_for_completion B <- DEADLOCK
+   complete B
+		   mutex_unlock A
+   mutex_unlock A
+
+No.
+
+CONCLUSION
+
+Lockdep cannot detect a deadlock involving folio lock or other general
+synchronization mechanisms.
+
+
+What leads to a deadlock
+------------------------
+
+A deadlock occurs when one or more contexts are waiting for events that
+will never happen. For example:
+
+.. code-block::
+
+   context X	   context Y	   context Z
+
+   |		   |		   |
+   v		   |		   |
+   1 wait for A    v		   |
+   .		   2 wait for C    v
+   event C	   .		   3 wait for B
+		   event B	   .
+				   event A
+
+Event C cannot be triggered because context X is stuck at 1, event B
+cannot be triggered because context Y is stuck at 2, and event A cannot
+be triggered because context Z is stuck at 3. All the contexts are stuck.
+We call this **deadlock**.
+
+If an event occurrence to awaken its wait is a prerequisite to reaching
+another event, we call it **dependency**. In this example:
+
+   * Event A occurrence is a prerequisite to reaching event C.
+   * Event C occurrence is a prerequisite to reaching event B.
+   * Event B occurrence is a prerequisite to reaching event A.
+
+In terms of dependency:
+
+   * Event C depends on event A.
+   * Event B depends on event C.
+   * Event A depends on event B.
+
+Dependency graph reflecting this example will look like:
+
+.. code-block::
+
+    -> C -> A -> B -
+   /                \
+   \                /
+    ----------------
+
+   where 'A -> B' means that event A depends on event B.
+
+A circular dependency exists. Such a circular dependency leads to a
+deadlock since no waiters can have desired events triggered.
+
+CONCLUSION
+
+A circular dependency of events leads to a deadlock.
+
+
+Introduce DEPT
+--------------
+
+DEPT(DEPendency Tracker) tracks wait and event instead of lock
+acquisition order so as to recognize the following situation:
+
+.. code-block::
+
+   context X	   context Y	   context Z
+
+   |		   |		   |
+   v		   |		   |
+   wait for A	   v		   |
+   .		   wait for C	   v
+   event C	   .		   wait for B
+		   event B	   .
+				   event A
+
+and builds up a dependency graph at runtime that is similar to lockdep.
+The graph might look like:
+
+.. code-block::
+
+    -> C -> A -> B -
+   /                \
+   \                /
+    ----------------
+
+   where 'A -> B' means that event A depends on event B.
+
+DEPT keeps adding each new dependency into the graph at runtime. For
+example, 'B -> D' will be added when event D occurrence is a
+prerequisite to reaching event B like:
+
+.. code-block::
+
+   context W
+
+   |
+   v
+   wait for D
+   .
+   event B
+
+After the addition, the graph will look like:
+
+.. code-block::
+
+                     -> D
+                    /
+    -> C -> A -> B -
+   /                \
+   \                /
+    ----------------
+
+   where 'A -> B' means that event A depends on event B.
+
+DEPT is going to report a deadlock on detection of a new loop.
+
+CONCLUSION
+
+DEPT works on wait and event so as to theoretically detect all potential
+deadlocks.
+
+
+How DEPT works
+--------------
+
+Let's take a look at how DEPT works with the 1st example in the section
+'Limitation of lockdep'.
+
+.. code-block::
+
+   context X	   context Y	   context Z
+
+		   mutex_lock A
+   folio_lock B
+		   folio_lock B <- DEADLOCK
+				   mutex_lock A <- DEADLOCK
+				   folio_unlock B
+		   folio_unlock B
+		   mutex_unlock A
+				   mutex_unlock A
+
+NOTE: In this document, 'event context' refers to a portion within a
+context where an interesting event is triggered in, between a point
+where the context has started progressing toward the event, and the
+event.
+
+Adding comments to describe DEPT's view in detail:
+
+.. code-block::
+
+   context X	   context Y	   context Z
+
+		   mutex_lock A
+		   /* might wait for A */
+		   /* start to take into account event A's context */
+		   /* 1 */
+   folio_lock B
+   /* might wait for B */
+   /* start to take into account event B's context */
+   /* 2 */
+
+		   folio_lock B
+		   /* might wait for B */ <- DEADLOCK
+		   /* start to take into account event B's context */
+		   /* 3 */
+
+				   mutex_lock A
+				   /* might wait for A */ <- DEADLOCK
+				   /* start to take into account
+				      event A's context */
+				   /* 4 */
+
+				   folio_unlock B
+				   /* event B that has been valid since 2 */
+		   folio_unlock B
+		   /* event B that has been valid since 3 */
+
+		   mutex_unlock A
+		   /* event A that has been valid since 1 */
+
+				   mutex_unlock A
+				   /* event A that has been valid since 4 */
+
+Let's build up a dependency graph with this example. Firstly, context X:
+
+.. code-block::
+
+   context X
+
+   folio_lock B
+   /* might wait for B */
+   /* start to take into account event B's context */
+   /* 2 */
+
+There are no events to create dependency. Next, context Y:
+
+.. code-block::
+
+   context Y
+
+   mutex_lock A
+   /* might wait for A */
+   /* start to take into account event A's context */
+   /* 1 */
+
+   folio_lock B
+   /* might wait for B */
+   /* start to take into account event B's context */
+   /* 3 */
+
+   folio_unlock B
+   /* event B that has been valid since 3 */
+
+   mutex_unlock A
+   /* event A that has been valid since 1 */
+
+There are two events, folio_unlock B a.k.a. event B and mutex_unlock A
+a.k.a. event A. For event B, since there are no waits between 3 and the
+event, event B does not create any dependency. For event A, there is a
+wait, folio_lock B a.k.a. wait B, between 1 and the event. Which means
+event A cannot be triggered if wait B cannot be awakened by event B.
+Therefore, we can say event A depends on event B, say, 'A -> B'. The
+graph will look like after adding the dependency:
+
+.. code-block::
+
+   A -> B
+
+   where 'A -> B' means that event A depends on event B.
+
+Lastly, context Z:
+
+.. code-block::
+
+   context Z
+
+   mutex_lock A
+   /* might wait for A */
+   /* start to take into account event A's context */
+   /* 4 */
+
+   folio_unlock B
+   /* event B that has been valid since 2 */
+
+   mutex_unlock A
+   /* event A that has been valid since 4 */
+
+There are also two events, folio_unlock B a.k.a. event B and
+mutex_unlock A a.k.a. event A. For event B, there is a wait, mutex_lock
+A a.k.a. wait A, between 2 and the event. Which means event B cannot be
+triggered if wait A cannot be awakened by event A. Therefore, we can
+say event B depends on event A, say, 'B -> A'. The graph will look like
+after adding the dependency:
+
+.. code-block::
+
+    -> A -> B -
+   /           \
+   \           /
+    -----------
+
+   where 'A -> B' means that event A depends on event B.
+
+A new loop has been created. So DEPT can report it as a deadlock. For
+event A, since there are no waits between 4 and the event, event A does
+not create any dependency. That's it.
+
+Let's take a look at how DEPT works with the 2nd example in the section
+'Limitation of lockdep'.
+
+.. code-block::
+
+   context X	   context Y
+
+		   mutex_lock A
+   mutex_lock A <- DEADLOCK
+		   wait_for_completion B <- DEADLOCK
+   complete B
+		   mutex_unlock A
+   mutex_unlock A
+
+Similarly adding comments to describe DEPT's view in detail:
+
+.. code-block::
+
+   context X	   context Y
+
+		   mutex_lock A
+                   /* might wait for A */
+                   /* start to take into account event A's context */
+                   /* 1 */
+
+                   request_something_and_complete_B
+                   /* request to handle something via e.g. wq, daemon,
+                      or any its own way, and finally do 'complete B'
+                      a.k.a. event B */
+                   /* 2 */
+   /* notice the request from 2 and handle it running toward event B */
+   /* start to take into account event B's context */
+   /* 3 */
+
+   mutex_lock A
+   /* might wait for A */ <- DEADLOCK
+   /* start to take into account event A's context */
+   /* 4 */
+		   wait_for_completion B
+                   /* wait for B */ <- DEADLOCK
+                   /* 5 */
+   complete B
+   /* event B that has been valid since 3 */
+		   mutex_unlock A
+                   /* event A that has been valid since 1 */
+   mutex_unlock A
+   /* event A that has been valid since 4 */
+
+Let's build up a dependency graph with this example. Firstly, context X:
+
+.. code-block::
+
+   context X
+
+   /* notice the request from 2 and handle it running toward event B */
+   /* start to take into account event B's context */
+   /* 3 */
+
+   mutex_lock A
+   /* might wait for A */
+   /* start to take into account event A's context */
+   /* 4 */
+
+   complete B
+   /* event B that has been valid since 3 */
+
+   mutex_unlock A
+   /* event A that has been valid since 4 */
+
+There are two events, complete B a.k.a. event B and mutex_unlock A a.k.a.
+event A. For event A, since there are no waits between between 4 and the
+event, event A does not create any dependency. For event B, there is a
+wait, mutex_lock A a.k.a. wait A, between 3 and the event. Which means
+event B cannot be triggered if wait A cannot be awakened by event A.
+Therefore, we can say event B depends on event A, say, 'B -> A'. The
+graph will look like after adding the dependency:
+
+.. code-block::
+
+   B -> A
+
+   where 'A -> B' means that event A depends on event B.
+
+If context X might notice the request after mutex_lock A, DEPT cannot
+track this dependency, which results in missing a dependency. However,
+that can be improved by adding proper DEPT annotations if needed.
+
+Next, context Y:
+
+.. code-block::
+
+   context Y
+
+   mutex_lock A
+   /* might wait for A */
+   /* start to take into account event A's context */
+   /* 1 */
+
+   request_something_and_complete_B
+   /* request to handle something via e.g. wq, daemon, or any its own
+      way, and finally do 'complete B' a.k.a. event B */
+   /* 2 */
+
+   wait_for_completion B
+   /* wait for B */
+   /* 5 */
+
+   mutex_unlock A
+   /* event A that has been valid since 1 */
+
+There is one event, mutex_unlock A a.k.a. event A. For event A, there is
+a wait, wait_for_completion B a.k.a. wait B, between 1 and the event.
+Which means event A cannot be triggered if wait B cannot be awakened by
+event B. Therefore, we can say event A depends on event B, say, 'A -> B'.
+The graph will look like after adding the dependency:
+
+.. code-block::
+
+    -> B -> A -
+   /           \
+   \           /
+    -----------
+
+   where 'A -> B' means that event A depends on event B.
+
+A new loop has been created. So DEPT can report it as a deadlock.
+
+CONCLUSION
+
+DEPT works well with any general synchronization mechanisms by focusing
+on wait, event and its context.
+
+
+Interpret DEPT report
+---------------------
+
+The following is the same example in the section 'How DEPT works'.
+
+.. code-block::
+
+   context X	   context Y	   context Z
+
+		   mutex_lock A
+		   /* might wait for A */
+		   /* start to take into account event A's context */
+		   /* 1 */
+   folio_lock B
+   /* might wait for B */
+   /* start to take into account event B's context */
+   /* 2 */
+
+		   folio_lock B
+		   /* might wait for B */ <- DEADLOCK
+		   /* start to take into account event B's context */
+		   /* 3 */
+
+				   mutex_lock A
+				   /* might wait for A */ <- DEADLOCK
+				   /* start to take into account
+				      event A's context */
+				   /* 4 */
+
+				   folio_unlock B
+				   /* event B that has been valid since 2 */
+		   folio_unlock B
+		   /* event B that has been valid since 3 */
+
+		   mutex_unlock A
+		   /* event A that has been valid since 1 */
+
+				   mutex_unlock A
+				   /* event A that has been valid since 4 */
+
+We can simplify this by labeling each waiting point with [W], each point
+where its event's context starts with [S] and each event with [E]. This
+example will look like after the labeling:
+
+.. code-block::
+
+   context X	   context Y	   context Z
+
+		   [W][S] mutex_lock A
+   [W][S] folio_lock B
+		   [W][S] folio_lock B <- DEADLOCK
+
+				   [W][S] mutex_lock A <- DEADLOCK
+				   [E] folio_unlock B
+		   [E] folio_unlock B
+		   [E] mutex_unlock A
+				   [E] mutex_unlock A
+
+DEPT uses the symbols [W], [S] and [E] in its report as described above.
+The following is an example reported by DEPT for a real problem in
+practice.
+
+.. code-block::
+
+   Link: https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
+   Link: https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
+
+   ===================================================
+   DEPT: Circular dependency has been detected.
+   6.2.0-rc1-00025-gb0c20ebf51ac-dirty #28 Not tainted
+   ---------------------------------------------------
+   summary
+   ---------------------------------------------------
+   *** DEADLOCK ***
+
+   context A
+       [S] lock(&ni->ni_lock:0)
+       [W] folio_wait_bit_common(PG_locked_map:0)
+       [E] unlock(&ni->ni_lock:0)
+
+   context B
+       [S] (unknown)(PG_locked_map:0)
+       [W] lock(&ni->ni_lock:0)
+       [E] folio_unlock(PG_locked_map:0)
+
+   [S]: start of the event context
+   [W]: the wait blocked
+   [E]: the event not reachable
+   ---------------------------------------------------
+   context A's detail
+   ---------------------------------------------------
+   context A
+       [S] lock(&ni->ni_lock:0)
+       [W] folio_wait_bit_common(PG_locked_map:0)
+       [E] unlock(&ni->ni_lock:0)
+
+   [S] lock(&ni->ni_lock:0):
+   [<ffffffff82b396fb>] ntfs3_setattr+0x54b/0xd40
+   stacktrace:
+         ntfs3_setattr+0x54b/0xd40
+         notify_change+0xcb3/0x1430
+         do_truncate+0x149/0x210
+         path_openat+0x21a3/0x2a90
+         do_filp_open+0x1ba/0x410
+         do_sys_openat2+0x16d/0x4e0
+         __x64_sys_creat+0xcd/0x120
+         do_syscall_64+0x41/0xc0
+         entry_SYSCALL_64_after_hwframe+0x63/0xcd
+
+   [W] folio_wait_bit_common(PG_locked_map:0):
+   [<ffffffff81b228b0>] truncate_inode_pages_range+0x9b0/0xf20
+   stacktrace:
+         folio_wait_bit_common+0x5e0/0xaf0
+         truncate_inode_pages_range+0x9b0/0xf20
+         truncate_pagecache+0x67/0x90
+         ntfs3_setattr+0x55a/0xd40
+         notify_change+0xcb3/0x1430
+         do_truncate+0x149/0x210
+         path_openat+0x21a3/0x2a90
+         do_filp_open+0x1ba/0x410
+         do_sys_openat2+0x16d/0x4e0
+         __x64_sys_creat+0xcd/0x120
+         do_syscall_64+0x41/0xc0
+         entry_SYSCALL_64_after_hwframe+0x63/0xcd
+
+   [E] unlock(&ni->ni_lock:0):
+   (N/A)
+   ---------------------------------------------------
+   context B's detail
+   ---------------------------------------------------
+   context B
+       [S] (unknown)(PG_locked_map:0)
+       [W] lock(&ni->ni_lock:0)
+       [E] folio_unlock(PG_locked_map:0)
+
+   [S] (unknown)(PG_locked_map:0):
+   (N/A)
+
+   [W] lock(&ni->ni_lock:0):
+   [<ffffffff82b009ec>] attr_data_get_block+0x32c/0x19f0
+   stacktrace:
+         attr_data_get_block+0x32c/0x19f0
+         ntfs_get_block_vbo+0x264/0x1330
+         __block_write_begin_int+0x3bd/0x14b0
+         block_write_begin+0xb9/0x4d0
+         ntfs_write_begin+0x27e/0x480
+         generic_perform_write+0x256/0x570
+         __generic_file_write_iter+0x2ae/0x500
+         ntfs_file_write_iter+0x66d/0x1d70
+         do_iter_readv_writev+0x20b/0x3c0
+         do_iter_write+0x188/0x710
+         vfs_iter_write+0x74/0xa0
+         iter_file_splice_write+0x745/0xc90
+         direct_splice_actor+0x114/0x180
+         splice_direct_to_actor+0x33b/0x8b0
+         do_splice_direct+0x1b7/0x280
+         do_sendfile+0xb49/0x1310
+
+   [E] folio_unlock(PG_locked_map:0):
+   [<ffffffff81f10222>] generic_write_end+0xf2/0x440
+   stacktrace:
+         generic_write_end+0xf2/0x440
+         ntfs_write_end+0x42e/0x980
+         generic_perform_write+0x316/0x570
+         __generic_file_write_iter+0x2ae/0x500
+         ntfs_file_write_iter+0x66d/0x1d70
+         do_iter_readv_writev+0x20b/0x3c0
+         do_iter_write+0x188/0x710
+         vfs_iter_write+0x74/0xa0
+         iter_file_splice_write+0x745/0xc90
+         direct_splice_actor+0x114/0x180
+         splice_direct_to_actor+0x33b/0x8b0
+         do_splice_direct+0x1b7/0x280
+         do_sendfile+0xb49/0x1310
+         __x64_sys_sendfile64+0x1d0/0x210
+         do_syscall_64+0x41/0xc0
+         entry_SYSCALL_64_after_hwframe+0x63/0xcd
+   ---------------------------------------------------
+   information that might be helpful
+   ---------------------------------------------------
+   CPU: 1 PID: 8060 Comm: a.out Not tainted
+	6.2.0-rc1-00025-gb0c20ebf51ac-dirty #28
+   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
+	BIOS Bochs 01/01/2011
+   Call Trace:
+    <TASK>
+    dump_stack_lvl+0xf2/0x169
+    print_circle.cold+0xca4/0xd28
+    ? lookup_dep+0x240/0x240
+    ? extend_queue+0x223/0x300
+    cb_check_dl+0x1e7/0x260
+    bfs+0x27b/0x610
+    ? print_circle+0x240/0x240
+    ? llist_add_batch+0x180/0x180
+    ? extend_queue_rev+0x300/0x300
+    ? __add_dep+0x60f/0x810
+    add_dep+0x221/0x5b0
+    ? __add_idep+0x310/0x310
+    ? add_iecxt+0x1bc/0xa60
+    ? add_iecxt+0x1bc/0xa60
+    ? add_iecxt+0x1bc/0xa60
+    ? add_iecxt+0x1bc/0xa60
+    __dept_wait+0x600/0x1490
+    ? add_iecxt+0x1bc/0xa60
+    ? truncate_inode_pages_range+0x9b0/0xf20
+    ? check_new_class+0x790/0x790
+    ? dept_enirq_transition+0x519/0x9c0
+    dept_wait+0x159/0x3b0
+    ? truncate_inode_pages_range+0x9b0/0xf20
+    folio_wait_bit_common+0x5e0/0xaf0
+    ? filemap_get_folios_contig+0xa30/0xa30
+    ? dept_enirq_transition+0x519/0x9c0
+    ? lock_is_held_type+0x10e/0x160
+    ? lock_is_held_type+0x11e/0x160
+    truncate_inode_pages_range+0x9b0/0xf20
+    ? truncate_inode_partial_folio+0xba0/0xba0
+    ? setattr_prepare+0x142/0xc40
+    truncate_pagecache+0x67/0x90
+    ntfs3_setattr+0x55a/0xd40
+    ? ktime_get_coarse_real_ts64+0x1e5/0x2f0
+    ? ntfs_extend+0x5c0/0x5c0
+    ? mode_strip_sgid+0x210/0x210
+    ? ntfs_extend+0x5c0/0x5c0
+    notify_change+0xcb3/0x1430
+    ? do_truncate+0x149/0x210
+    do_truncate+0x149/0x210
+    ? file_open_root+0x430/0x430
+    ? process_measurement+0x18c0/0x18c0
+    ? ntfs_file_release+0x230/0x230
+    path_openat+0x21a3/0x2a90
+    ? path_lookupat+0x840/0x840
+    ? dept_enirq_transition+0x519/0x9c0
+    ? lock_is_held_type+0x10e/0x160
+    do_filp_open+0x1ba/0x410
+    ? may_open_dev+0xf0/0xf0
+    ? find_held_lock+0x2d/0x110
+    ? lock_release+0x43c/0x830
+    ? dept_ecxt_exit+0x31a/0x590
+    ? _raw_spin_unlock+0x3b/0x50
+    ? alloc_fd+0x2de/0x6e0
+    do_sys_openat2+0x16d/0x4e0
+    ? __ia32_sys_get_robust_list+0x3b0/0x3b0
+    ? build_open_flags+0x6f0/0x6f0
+    ? dept_enirq_transition+0x519/0x9c0
+    ? dept_enirq_transition+0x519/0x9c0
+    ? lock_is_held_type+0x4e/0x160
+    ? lock_is_held_type+0x4e/0x160
+    __x64_sys_creat+0xcd/0x120
+    ? __x64_compat_sys_openat+0x1f0/0x1f0
+    do_syscall_64+0x41/0xc0
+    entry_SYSCALL_64_after_hwframe+0x63/0xcd
+   RIP: 0033:0x7f8b9e4e4469
+   Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
+   89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
+   3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
+   RSP: 002b:00007f8b9eea4ef8 EFLAGS: 00000202 ORIG_RAX: 0000000000000055
+   RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b9e4e4469
+   RDX: 0000000000737562 RSI: 0000000000000000 RDI: 0000000020000000
+   RBP: 00007f8b9eea4f20 R08: 0000000000000000 R09: 0000000000000000
+   R10: 0000000000000000 R11: 0000000000000202 R12: 00007fffa75511ee
+   R13: 00007fffa75511ef R14: 00007f8b9ee85000 R15: 0000000000000003
+    </TASK>
+
+Let's take a look at the summary that is the most important part.
+
+.. code-block::
+
+   ---------------------------------------------------
+   summary
+   ---------------------------------------------------
+   *** DEADLOCK ***
+
+   context A
+       [S] lock(&ni->ni_lock:0)
+       [W] folio_wait_bit_common(PG_locked_map:0)
+       [E] unlock(&ni->ni_lock:0)
+
+   context B
+       [S] (unknown)(PG_locked_map:0)
+       [W] lock(&ni->ni_lock:0)
+       [E] folio_unlock(PG_locked_map:0)
+
+   [S]: start of the event context
+   [W]: the wait blocked
+   [E]: the event not reachable
+
+The summary shows the following scenario:
+
+.. code-block::
+
+   context A	   context B	   context ?(unknown)
+
+				   [S] folio_lock(&f1)
+   [S] lock(&ni->ni_lock:0)
+   [W] folio_wait_bit_common(PG_locked_map:0)
+
+		   [W] lock(&ni->ni_lock:0)
+		   [E] folio_unlock(&f1)
+
+   [E] unlock(&ni->ni_lock:0)
+
+Adding comments to describe DEPT's view in detail:
+
+.. code-block::
+
+   context A	   context B	   context ?(unknown)
+
+				   [S] folio_lock(&f1)
+				   /* start to take into account context
+				      B heading for folio_unlock(&f1) */
+				   /* 1 */
+   [S] lock(&ni->ni_lock:0)
+   /* start to take into account this context heading for
+      unlock(&ni->ni_lock:0) */
+   /* 2 */
+
+   [W] folio_wait_bit_common(PG_locked_map:0) (= folio_lock(&f1))
+   /* might wait for folio_unlock(&f1) */
+
+		   [W] lock(&ni->ni_lock:0)
+		   /* might wait for unlock(&ni->ni_lock:0) */
+
+		   [E] folio_unlock(&f1)
+		   /* event that has been valid since 1 */
+
+   [E] unlock(&ni->ni_lock:0)
+   /* event that has been valid since 2 */
+
+Let's build up a dependency graph with this report. Firstly, context A:
+
+.. code-block::
+
+   context A
+
+   [S] lock(&ni->ni_lock:0)
+   /* start to take into account this context heading for
+      unlock(&ni->ni_lock:0) */
+   /* 2 */
+
+   [W] folio_wait_bit_common(PG_locked_map:0) (= folio_lock(&f1))
+   /* might wait for folio_unlock(&f1) */
+
+   [E] unlock(&ni->ni_lock:0)
+   /* event that has been valid since 2 */
+
+There is one event, unlock(&ni->ni_lock:0). There is a wait,
+folio_lock(&f1), between 2 and the event. Which means
+unlock(&ni->ni_lock:0) is not reachable if folio_lock(&f1) cannot be
+awakened by the owner's folio_unlock(&f1). Therefore, we can say
+unlock(&ni->ni_lock:0) depends on folio_unlock(&f1), say,
+'unlock(&ni->ni_lock:0) -> folio_unlock(&f1)'.
+
+The graph will look like after adding the dependency:
+
+.. code-block::
+
+   unlock(&ni->ni_lock:0) -> folio_unlock(&f1)
+
+   where 'A -> B' means that event A depends on event B.
+
+Secondly, context B:
+
+.. code-block::
+
+   context B
+
+   [W] lock(&ni->ni_lock:0)
+   /* might wait for unlock(&ni->ni_lock:0) */
+
+   [E] folio_unlock(&f1)
+   /* event that has been valid since 1 */
+
+There is also one event, folio_unlock(&f1). There is a wait,
+lock(&ni->ni_lock:0), between 1 and the event. Which means
+folio_unlock(&f1) is not reachable if lock(&ni->ni_lock:0) cannot be
+awakened by the owner's unlock(&ni->ni_lock:0). Therefore, we can say
+folio_unlock(&f1) depends on unlock(&ni->ni_lock:0), say,
+'folio_unlock(&f1) -> unlock(&ni->ni_lock:0)'.
+
+The graph will look like after adding the dependency:
+
+.. code-block::
+
+    -> unlock(&ni->ni_lock:0) -> folio_unlock(&f1) -
+   /                                                \
+   \                                                /
+    ------------------------------------------------
+
+   where 'A -> B' means that event A depends on event B.
+
+A new loop has been created. So DEPT can report it as a deadlock! Cool!
+
+CONCLUSION
+
+DEPT works awesome!
diff --git a/Documentation/dev-tools/dept_api.rst b/Documentation/dev-tools/dept_api.rst
new file mode 100644
index 000000000000..6706d206f6bf
--- /dev/null
+++ b/Documentation/dev-tools/dept_api.rst
@@ -0,0 +1,124 @@
+DEPT(DEPendency Tracker) APIs
+=============================
+
+Started by Byungchul Park <max.byungchul.park@sk.com>
+
+SDT(Single-event Dependency Tracker) APIs
+-----------------------------------------
+Use these APIs to annotate either wait or event. These have been already
+applied to the existing synchronization primitives e.g. waitqueue, swait,
+wait_for_completion(), dma fence and so on. The basic APIs of SDT are:
+
+.. code-block:: c
+
+   /*
+    * After defining 'struct dept_map map', initialize the instance.
+    */
+   sdt_map_init(map);
+
+   /*
+    * Place just before the interesting wait.
+    */
+   sdt_wait(map);
+
+   /*
+    * Place just before the interesting event.
+    */
+   sdt_event(map);
+
+The advanced APIs of SDT are:
+
+.. code-block:: c
+
+   /*
+    * After defining 'struct dept_map map', initialize the instance
+    * using an external key.
+    */
+   sdt_map_init_key(map, key);
+
+   /*
+    * Place just before the interesting timeout wait.
+    */
+   sdt_wait_timeout(map, time);
+
+   /*
+    * Use sdt_might_sleep_start() and sdt_might_sleep_end() in pair.
+    * Place at the start of the interesting section that might enter
+    * schedule() or its family that needs to be woken up by
+    * try_to_wake_up().
+    */
+   sdt_might_sleep_start(map);
+
+   /*
+    * Use sdt_might_sleep_start_timeout() and sdt_might_sleep_end() in
+    * pair. Place at the start of the interesting section that might
+    * enter schedule_timeout() or its family that needs to be woken up
+    * by try_to_wake_up().
+    */
+   sdt_might_sleep_start_timeout(map, time);
+
+   /*
+    * Use sdt_might_sleep_start() and sdt_might_sleep_end() in pair.
+    * Place at the end of the interesting section that might enter
+    * schedule(), schedule_timeout() or its family that needs to be
+    * woken up by try_to_wake_up().
+    */
+   sdt_might_sleep_end();
+
+   /*
+    * Use sdt_ecxt_enter() and sdt_ecxt_exit() in pair. Place at the
+    * start of the interesting section where the interesting event might
+    * be triggered.
+    */
+   sdt_ecxt_enter(map);
+
+   /*
+    * Use sdt_ecxt_enter() and sdt_ecxt_exit() in pair. Place at the
+    * end of the interesting section where the interesting event might
+    * be triggered.
+    */
+   sdt_ecxt_exit(map);
+
+
+LDT(Lock Dependency Tracker) APIs
+---------------------------------
+Do not use these APIs directly. These are wrappers for typical locks
+that have been already applied to major locks internally e.g. spin lock,
+mutex, rwlock and so on. The APIs of LDT are:
+
+.. code-block:: c
+
+   ldt_init(map, key, sub, name);
+   ldt_lock(map, sub_local, try, nest, ip);
+   ldt_rlock(map, sub_local, try, nest, ip, queued);
+   ldt_wlock(map, sub_local, try, nest, ip);
+   ldt_unlock(map, ip);
+   ldt_downgrade(map, ip);
+   ldt_set_class(map, name, key, sub_local, ip);
+
+
+Raw APIs
+--------
+Do not use these APIs directly. The raw APIs of dept are:
+
+.. code-block:: c
+
+   dept_free_range(start, size);
+   dept_map_init(map, key, sub, name);
+   dept_map_reinit(map, key, sub, name);
+   dept_ext_wgen_init(ext_wgen);
+   dept_map_copy(map_to, map_from);
+   dept_wait(map, wait_flags, ip, wait_func, sub_local, time);
+   dept_stage_wait(map, key, ip, wait_func, time);
+   dept_request_event_wait_commit();
+   dept_clean_stage();
+   dept_ttwu_stage_wait(task, ip);
+   dept_ecxt_enter(map, evt_flags, ip, ecxt_func, evt_func, sub_local);
+   dept_ecxt_holding(map, evt_flags);
+   dept_request_event(map, ext_wgen);
+   dept_event(map, evt_flags, ip, evt_func, ext_wgen);
+   dept_ecxt_exit(map, evt_flags, ip);
+   dept_ecxt_enter_nokeep(map);
+   dept_key_init(key);
+   dept_key_destroy(key);
+   dept_map_ecxt_modify(map, cur_evt_flags, key, evt_flags, ip, ecxt_func, evt_func, sub_local);
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 59cbb77b33ff..0f37940e4c6e 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -23,6 +23,8 @@ Documentation/process/debugging/index.rst
    coccinelle
    context-analysis
    sparse
+   dept
+   dept_api
    kcov
    gcov
    kasan
-- 
2.17.1


