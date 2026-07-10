Return-Path: <linux-nfs+bounces-23229-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2xvDLhyJUGrD0wIAu9opvQ
	(envelope-from <linux-nfs+bounces-23229-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 07:54:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F87737705
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 07:54:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23229-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23229-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ED033013698
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 05:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CB53939AF;
	Fri, 10 Jul 2026 05:54:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1E230BE9;
	Fri, 10 Jul 2026 05:54:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662853; cv=none; b=ueCD2zFrv+MdlRfIJHrHCJdhZo9HanZ55ZK/uRY8v2OQNFNLp5ENywz/DMih1EI0vWDe8BbiGhjXkG2ncSCxwBLfLaw5NJcTj2rAwjnC1i+C7132BtbKDJVFuKva1RfsB2+DHWa+gBYpoEqEGKsy/0rpIvbhwPnmwYTsjY2SClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662853; c=relaxed/simple;
	bh=nyDBnktELM+hz7RvTSyEr5tTXDizK+ufnQXY3jTKq48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHnNTng40LYlxMTCqM6XcjVREF4/k/oaH9ahfyy5Arw+jpXnGc2i8Ro68QoH8dv0kZTkQHDUG5mFrx9Gx8Rpj42bJHAz2j5bVoS/6hG1WcF2kODfR8+yWe798+pf5Lz/2Ys5KXyOkrwWnt1aveZUFtJtjAV3PUMe3YYQo+V6YOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c2dff70000001609-c3-6a5088f7d053
Date: Fri, 10 Jul 2026 14:53:54 +0900
From: Byungchul Park <byungchul@sk.com>
To: Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com,
	kernel_team@skhynix.com, torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, will@kernel.org,
	tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
	sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
	johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
	hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	boqun.feng@gmail.com, longman@redhat.com, yunseong.kim@ericsson.com,
	ysk@kzalloc.com, yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
	gustavo@padovan.org, christian.koenig@amd.com,
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	broonie@kernel.org, kevin.brodsky@arm.com, dwmw@amazon.co.uk,
	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
	yuzhao@google.com, baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com, joel.granados@kernel.org,
	richard.weiyang@gmail.com, geert+renesas@glider.be,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	alexander.shishkin@linux.intel.com, lillian@star-ark.net,
	chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com, neilb@ownmail.net,
	bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v19 31/40] dept: assign unique dept_key to each distinct
 wait_for_completion() caller
Message-ID: <20260710055354.GA37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-32-byungchul@sk.com>
 <DJSEK3KA2ECQ.1512A4KGOBSCV@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJSEK3KA2ECQ.1512A4KGOBSCV@garyguo.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxzG857zngsdHYdO4ztrNlNHWJhTt7jln+gu2RdPspmxkS1u+zCb
	9QTKVVvlssSsKKhBcAzXMtqJXFxtAFktDgfSBYt0NmjWakJqp7OSBlML6DqEIdjuUGPmt1+e
	53mf5//h5WlVK7ua15fukQyl2mINq8CK6fT2V/89nFu46YcZNdy4FWFgvHoYw4PZwxge2c5x
	4O/tRjC/aKOhdiApa01eDmYX/uTAXI0g6fYisASaaPjHmWAhNhJHYL4dYaE5Wo3hnr0eQXR0
	GyRv3qHAHklQELPcl02zH0E8Gkbgduxn4VrkWfCZj7AwHfiRghknC2373QxMhtwUWI67MAyE
	BzkIxJYo6HZth1v2SQxjjR2UPMKC5cwqsDUfoMB8+jwFC/YuDi533sBgN2WB7co1BiYcVg6S
	bWXg+2ucgXOmMAeu66PydOgVaD94EsOQ24eh3vkLAybbPAP+4TEGrnb7Mfx8J0jBmPcShr4r
	l2mYO6oG/3cNDJye6WDh2MwkgticnX5XJ87XHsViV18/Jfa09iBx8WETEmsbZRqZukeLNX0V
	4k9jU6w4YL3JiTW/hTixzbVXrLk4zYh9jhyxcyhKie3xB4wYir2V+/Lniq06qVhfLhk2vr1T
	UTB6sh/vas2sHJwcok3ob2UdSuOJsJlEL52in/DExSFmmbGQRaYPTHHLzArZJBhcSGVWCC8S
	V1cHVYcUPC20vECuzvlSD54TisiSI5oKKQUgI+OdqZBKaEDE+9DGPDYyia8lgpeZFnJIMBGV
	Q7zManIqwS/LacIb5P7ZeGp4pbCODPf/nuohwkQa+f5sEj++9HlywRHEjUiwPlVrfarW+n9t
	G6K7kEpfWl6i1Rdv3lBQVaqv3PBVWYkLyb/Wvm/pi19R3J/nQQKPNOnKTd98WKhitOXGqhIP
	IjytWaEMr5ElpU5b9bVkKPvSsLdYMnqQmseaVcrX5yp0KiFfu0cqkqRdkuGJS/Fpq01IO5G+
	bfexuy25RxZbErfzQmcKF/Kuf2LJL6rgwp7eWemjei9nXGvO3nmionLjt1M7mo/bMg6Onrfm
	1wWysne8r165fp9ljY6d3f2S2lkXWMoteedCQc9na/9Yt5j5waNPuYZDvYcKleTN97ZnfNzB
	ntBsHcx4Jr6eOD3m5tot9pq7WzTYWKB9LYc2GLX/Ae5QvRexAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjH877n9PTQWT0UCCdek5rFhEyRTZIn2bKLmXpivPCNhCzRRk9G
	5aJpEWUJU6iN1ampTVqk9QJFKitMsCCOSyMBrUPnbLlIo7DCUuu6giBQCJeWnWKMfnnye57n
	/8vzfnhpQrYkWk0r8wt4Vb4iV05JSMm+LzWbZ3UZR7bet6aCTnsKBn1+ETwv6SAhPK0j4Wp9
	HQURyz0x6BzlIvhjoJQE9+1aBL6wDsHsgoUAbcsSCRGDSwzTcy/FYCxBsOR0ITB5DAR43fcJ
	qGsqwTDVEKUg1DWJwDjip6AsWELCuO0CAnPAIobgw10w5msTwdLQawwDM6MIbP4oBn/HWQQR
	Uw7csDYKummCgoWnzwgoM7oRVI4METAZHEbQ5PobgbOmlIJX+rsE9PpXQl94nIJu4y8UjHmu
	YnjTQEFFqVMEnj9DCK5ZDAgCL5wYNFX1FJiuOUhoGW4Vgye0iGHQZMBQ69gLPluAhCd6Kxae
	K6TuJIOlTIOF8i8G429tGOZsdvG31Yib1V4iOXtjM+a0PRGKq7teh7iFeQPipqs1BKfVC23X
	6DjBnWk8wVU/GaW4+XA/xTlnKkjusZXlbp6bx9zlp5u5FvOQOOO7LMlXh/lcZSGvSv36oCT7
	4c1m8tj1+JOtgXbiNHorPY/iaJbZxv7zoF0UY5L5lB3TjIpjTDGbWK93johxIrOBddit+DyS
	0ARTvp7tmeleFhKYHHaxJrgckjLAdj2vWg7JmIuIdc1bRO8W8Wx3uZ+MMcGksN5oUAjRAq9h
	b0Xp2DiOSWcnmiaXDycxG9mO5kdYj6Tmj2zzR7b5g12BCDtKVOYX5imUuelb1DnZRfnKk1sO
	Hc1zIOFb2ooXL/+Opnt3dSKGRvIV0q2n9h+RiRSF6qK8TsTShDxROrxWGEkPK4p+4lVHD6iO
	5/LqTrSGJuXJ0t2Z/EEZ86OigM/h+WO86v0W03GrT6NNrXcKip9lq88W7zBMeONTd//X03ku
	lLh36pXsojnl5aNP0jrazUWRAcnaK+4+Q8iV3PD5TllCZtKqxuTt4YxfM+9VfpEU/N7zwD5Y
	2+/ybf+mH+uyVuzYqV73Q3Pv20D6SNvdqopV6/V861Rl9K8+RVZC8DO38/XjffXMngvlB9J+
	lpPqbEVaCqFSK/4HtzJC/ZIDAAA=
X-CFilter-Loop: Reflected
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[sk.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23229-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:linux-kernel@vger.kernel.org,m:max.byungchul.park@gmail.com,m:kernel_team@skhynix.com,m:torvalds@linux-foundation.org,m:damien.lemoal@opensource.wdc.com,m:linux-ide@vger.kernel.org,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:mingo@redhat.com,m:peterz@infradead.org,m:will@kernel.org,m:tglx@linutronix.de,m:rostedt@goodmis.org,m:joel@joelfernandes.org,m:sashal@kernel.org,m:daniel.vetter@ffwll.ch,m:duyuyang@gmail.com,m:johannes.berg@intel.com,m:tj@kernel.org,m:tytso@mit.edu,m:willy@infradead.org,m:david@fromorbit.com,m:amir73il@gmail.com,m:gregkh@linuxfoundation.org,m:kernel-team@lge.com,m:linux-mm@kvack.org,m:akpm@linux-foundation.org,m:mhocko@kernel.org,m:minchan@kernel.org,m:hannes@cmpxchg.org,m:vdavydov.dev@gmail.com,m:sj@kernel.org,m:jglisse@redhat.com,m:dennis@kernel.org,m:cl@linux.com,m:penberg@kernel.org,m:rientjes@google.com,m:vbabka@suse.cz,m:ngupta@vflare.org,m:linux-block@vger.kernel.org,m:josef@toxicpanda.com,m:linu
 x-fsdevel@vger.kernel.org,m:jack@suse.cz,m:jlayton@kernel.org,m:dan.j.williams@intel.com,m:hch@infradead.org,m:djwong@kernel.org,m:dri-devel@lists.freedesktop.org,m:rodrigosiqueiramelo@gmail.com,m:melissa.srw@gmail.com,m:hamohammed.sa@gmail.com,m:harry.yoo@oracle.com,m:chris.p.wilson@intel.com,m:gwan-gyeong.mun@intel.com,m:boqun.feng@gmail.com,m:longman@redhat.com,m:yunseong.kim@ericsson.com,m:ysk@kzalloc.com,m:yeoreum.yun@arm.com,m:netdev@vger.kernel.org,m:matthew.brost@intel.com,m:her0gyugyu@gmail.com,m:corbet@lwn.net,m:catalin.marinas@arm.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:luto@kernel.org,m:sumit.semwal@linaro.org,m:gustavo@padovan.org,m:christian.koenig@amd.com,m:andi.shyti@kernel.org,m:arnd@arndb.de,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:rppt@kernel.org,m:surenb@google.com,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagn
 elf@nvidia.com,m:josh@joshtriplett.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:chuck.lever@oracle.com,m:neil@brown.name,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[byungchul@sk.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,skhynix.com,linux-foundation.org,opensource.wdc.com,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,protonmail.com,umich.edu];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[165];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sk.com:from_mime,sk.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09F87737705

On Tue, Jul 07, 2026 at 03:18:29PM +0100, Gary Guo wrote:
> On Mon Jul 6, 2026 at 7:19 AM BST, Byungchul Park wrote:
> > wait_for_completion() can be used at various points in the code and it's
> > very hard to distinguish wait_for_completion()s between different usages.
> > Using a single dept_key for all the wait_for_completion()s could trigger
> > false positive reports.
> >
> > Assign unique dept_key to each distinct wait_for_completion() caller to
> > avoid false positive reports.
> >
> > While at it, add a rust helper for wait_for_completion() to avoid build
> > errors.
> 
> This will cause Rust code to share the same dept_key, so it will have all the
> false positives that the change is trying to avoid.

Thank you for the input.

> In general it is easy to create Rust bindings for static inline C functions
> because it'll be just some computation, while creating bindings for C
> function-like macros that define additional statics can be challenging.
> 
> Is dept_key similar to lock_class_key, where only the address matters? If so,
> the approach that I use in
> https://lore.kernel.org/rust-for-linux/DJP0CDOR98N5.29BK8PUFRWRUK@garyguo.net

Yes, dept_key is similar to lock_class_key.  IIUC, the way you tried for
lock_class_key can be applied to DEPT too.  I will do:

   1) add 'key' parameter to sdt_might_sleep_start_timeout()
   2) introduce init_completion_dkey() to allow custom keys
   3) remove init_completion_dmap() and adjust the existing users

Just in case, it's worth noting that the custom keys must be
well-managed using e.g. dept_key_destroy() when the key gets freed.

	Byungchul

> could be used for dept_key as well, then we can keep Rust `wait_for_completion`
> still a function; otherwise we have to turn it into a macro too on the Rust side
> to create such statics, which isn't ideal.
> 
> Best,
> Gary
> 
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/linux/completion.h | 100 +++++++++++++++++++++++++++++++------
> >  kernel/sched/completion.c  |  60 +++++++++++-----------
> >  rust/helpers/completion.c  |   5 ++
> >  3 files changed, 120 insertions(+), 45 deletions(-)

