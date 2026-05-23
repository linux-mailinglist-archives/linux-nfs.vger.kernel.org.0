Return-Path: <linux-nfs+bounces-21863-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE9KOAi7EWpVpQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21863-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 16:34:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BC55BF66A
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 16:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 210D43004C81
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01712E06D2;
	Sat, 23 May 2026 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRuMNnEn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA292D1F44;
	Sat, 23 May 2026 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546882; cv=none; b=TZ28NaEJ21p2r2wEl0juj4JNAlfa0d8Zk55q3vw7GwSNIYb4ny73SBa8VDce7Sm1gItueIC5iUmZI5I70dVYnGAtWpYdPkKGMTndtCTviXLmlKATldJVWqAq4C2Iw2qGKKBUHi7kbXssbqvUIYEnCNdLMR+kpIS8ImQuwgjcqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546882; c=relaxed/simple;
	bh=wRmeeDFW9aLsG7APMHX0/TFOJPnEO5M+u+iIvZF5X3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfAoYqkfVo+nb8j2/4qJ/YJ6fCncSjThRH+dMzrhqaA1uu/dFkKeJdPOIlRdKOQk0eaMZtHFXJk2A4GWh6zxI/09flg334G8L8AyjUFYIvpideJGtfSrvL1PfocBhAInOUGCApiQcaUQX+5TTMehfeqSvI7QXvxSNNqbKMkmxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRuMNnEn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A8F1F000E9;
	Sat, 23 May 2026 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779546881;
	bh=m0RMW+vUTF/Kw0EclT9JxUQS8BolCI+Rfe/P5jHnTs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fRuMNnEnaU3pUZeCti0/1FjuF1JXjZLBPgmMnv61LrJySZ6X8EFw4h2BCpGe3W364
	 f+9TH0AgdXEX9X7yLx0+VKbn0qgcbuAO51gJuiY2p1d+A/K6NqWlqTun1KP2N5Qd1u
	 9/yPoL0gp7BNmbXkMwnk20TdBUFwagzYOSTEaD2Ww0In+zde2qnzcSAcBA5S4vFz/1
	 i1k+D0fxc9jwqqB0D96e1yuj5vzgO3x0eJY8B8QPTXwXDcHwhvQHiQfJ3SyX3YnzuA
	 8cpCjfk1Cu/tjjhiI9kllFtuwCkOTVqsyDsk/+ZQ4bT+UY/+1Q+KXZm0s45qWVf0FB
	 XkiIfM2Ewr0dw==
Message-ID: <0592b09b-a084-4d9d-bcbf-1b77e45226cf@kernel.org>
Date: Sat, 23 May 2026 23:34:07 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DEPT (the dependency tracker) as AI review prompt?
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, torvalds@linux-foundation.org,
 damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com,
 peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
 rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
 daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com,
 tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
 amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
 minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
 sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
 djwong@kernel.org, dri-devel@lists.freedesktop.org,
 rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 hamohammed.sa@gmail.com, harry.yoo@oracle.com, chris.p.wilson@intel.com,
 gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
 boqun.feng@gmail.com, longman@redhat.com, yunseong.kim@ericsson.com,
 yeoreum.yun@arm.com, netdev@vger.kernel.org, matthew.brost@intel.com,
 her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
 gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org,
 arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com,
 neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
 kristina.martsenko@arm.com, wangkefeng.wang@huawei.com, broonie@kernel.org,
 kevin.brodsky@arm.com, dwmw@amazon.co.uk, shakeel.butt@linux.dev,
 ast@kernel.org, ziy@nvidia.com, yuzhao@google.com,
 baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
 joel.granados@kernel.org, richard.weiyang@gmail.com,
 geert+renesas@glider.be, tim.c.chen@linux.intel.com, linux@treblig.org,
 alexander.shishkin@linux.intel.com, lillian@star-ark.net,
 chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com,
 link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org,
 brauner@kernel.org, thomas.weissschuh@linutronix.de, oleg@redhat.com,
 mjguzik@gmail.com, andrii@kernel.org, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rcu@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 2407018371@qq.com, dakr@kernel.org, miguel.ojeda.sandonis@gmail.com,
 neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
 dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, rust-for-linux@vger.kernel.org, Chris Mason
 <clm@meta.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Josef Bacik <josef@toxicpanda.com>, Yunseong Kim <yunseong.kim@est.tech>
References: <20251205071855.72743-1-byungchul@sk.com>
 <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
 <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sk.com,vger.kernel.org,skhynix.com,linux-foundation.org,opensource.wdc.com,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,lists.freedesktop.org,oracle.com,ericsson.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu,meta.com,toxicpanda.com,est.tech];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21863-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[169];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 31BC55BF66A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/23/26 11:00 PM, Yunseong Kim wrote:
> I've previously experimented with running DEPT alongside syzkaller fuzzing,
> and many hung tasks missed by lockdep are caught by DEPT, but the resulting
> high volume of reports makes it easy for issues to get lost in the massive
> log output. Sorting through that output manually is a huge bottleneck, so
> leveraging a well-crafted AI prompt to triage the warnings and filter out
> the false positives would be incredibly valuable.

I mean both 1) detection of deadlock issues AND 2) false positive 
elimination with AI.

If the review prompt is only used to eliminate DEPT's false positives, I 
think that would be quite hard to get broad use.

Someone would have to build out-of-tree DEPT, collect the reports, and 
then feed those back into the AI. I don't think building that kind of 
pipeline would actually work well in practice.

-- 
Cheers,
Harry / Hyeonggon


