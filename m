Return-Path: <linux-nfs+bounces-21860-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EtNOfaeEWr1oAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21860-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 14:35:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F65BEE9C
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 14:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B00F73018D43
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8CA399899;
	Sat, 23 May 2026 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW3+XESk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225F399361;
	Sat, 23 May 2026 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779539612; cv=none; b=Ltp3L6yeDsT8DqAoOpzTvnS4fy9MKT2pFdwHMBXxx7CAZkNIlubZEZ66I9J9ZpnUAY6ypK9dmgyAOcytkLhltiGK8I9uiS+yZStHelfQe2uJhUSa6OKhinYRx+auzuf2Cftb9FnnrrmpFI0H2G2t7kXj6UC6JAUrgY9d8qKWyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779539612; c=relaxed/simple;
	bh=56rtl5yWcqt/qvv0kT1QPxahxvD5Oep41kV/zQgRNLw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BCBnco9lLzAqCsjkIiC7wbyZX3Q4mfMVkxvqxXpgQrvRmhg0qZ2NOzxerEygdnY3GXO7fNot+h+qFF5Zv6rOwU5dgvnhtgOxNS5qC3rE0c3uzLlScf/RF8st/cbv4uHbApJRTsxyjhIodZV3tQouEDxHluvJ7QMRurRVFIfuMPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW3+XESk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D033D1F000E9;
	Sat, 23 May 2026 12:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779539609;
	bh=feRzGMWHkALLA8SyrU6RJ1+Ne9lKt9MuXcA+HfB5g6s=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=jW3+XESk7IvEcBU+bpy8yPJAU/0IVwlShO9v6KZOWX/ll0bKB5YUpHGA74CScGkib
	 h61p7Ii11ojyLl4zWD9zC9jbGza8+08D0KF1Xyx9eBM6rLRsPBrMoOJWaYv4k5Vx5f
	 b+ou7eQ1gREOxWOzgW+VN7myFXCmEhBFTQ9Sdu659LX8/GPVkRUMTXMWimv/FjEczf
	 bG24n4N8iuPU4UnGW4T49bADfkhY2K1I2wXkGRyHTK9qH1ARUHqANTaWPkqp1iRNQ2
	 wp7jB+4PxO00QxNwhLHhUxRt7tl3Y/eymRjs0Aul1vvTeTOYwlxBhdLtHlabRl0oG/
	 MVc5rNjQJ3rsg==
Message-ID: <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
Date: Sat, 23 May 2026 21:32:41 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Harry Yoo <harry@kernel.org>
Subject: DEPT (the dependency tracker) as AI review prompt? (was: DEPT v18)
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org,
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
 linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
 dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
 dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com,
 chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
 max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com,
 yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com,
 netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com,
 corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org,
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
 Josef Bacik <josef@toxicpanda.com>
References: <20251205071855.72743-1-byungchul@sk.com>
Content-Language: en-US
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[skhynix.com,linux-foundation.org,opensource.wdc.com,vger.kernel.org,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21860-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,locking.md:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[169];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 4E6F65BEE9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Can we start DEPT as an AI review prompt, by documenting DEPT's 
dependency tracking model and false positive elimination rules as a 
carefully crafted prompt?

While DEPT can identify deadlock issues beyond lockdep's capabilities, 
it is hard to enable in automated testing; without fine-grained 
annotations it can produce a high rate of false positives, and verifying 
them requires significant human effort.

The open source AI Review Prompt has locking.md file [1] that teaches 
the AI how to review locks and detect misuse.

If we can write a review prompt for DEPT in a similar manner and have 
the AI do the deadlock detection and false positive elimination, I think 
we could identify those problems more effectively with much less human 
effort.

[1] 
https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/locking.md

-- 
Cheers,
Harry / Hyeonggon

On 12/5/25 4:18 PM, Byungchul Park wrote:
> I'm happy to see that DEPT reported real problems in practice:
> 
>     https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/
>     https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
>     https://lore.kernel.org/all/b6e00e77-4a8c-4e05-ab79-266bf05fcc2d@igalia.com/
> 
> I’ve added documentation describing DEPT — this should help you
> understand what DEPT is and how it works.  You can use DEPT simply by
> enabling CONFIG_DEPT and checking dmesg at runtime.
> ---
> 
> Hi Linus and folks,
> 
> I’ve been developing a tool to detect deadlock possibilities by tracking
> waits/events — rather than lock acquisition order — to cover all the
> synchronization mechanisms.  To summarize the design rationale, starting
> from the problem statement, through analysis, to the solution:
> 
>     CURRENT STATUS
>     --------------
>     Lockdep tracks lock acquisition order to identify deadlock conditions.
>     Additionally, it tracks IRQ state changes — via {en,dis}able — to
>     detect cases where locks are acquired unintentionally during
>     interrupt handling.
>     
>     PROBLEM
>     -------
>     Waits and their associated events that are never reachable can
>     eventually lead to deadlocks.  However, since Lockdep focuses solely
>     on lock acquisition order, it has inherent limitations when handling
>     waits and events.
>     
>     Moreover, by tracking only lock acquisition order, Lockdep cannot
>     properly handle read locks or cross-event scenarios — such as
>     wait_for_completion() and complete() — making it increasingly
>     inadequate as a general-purpose deadlock detection tool.
>     
>     SOLUTION
>     --------
>     Once again, waits and their associated events that are never
>     reachable can eventually lead to deadlocks.  The new solution, DEPT,
>     focuses directly on waits and events.  DEPT monitors waits and events,
>     and reports them when any become unreachable.
> 
> DEPT provides:
> 
>     * Correct handling of read locks.
>     * Support for general waits and events.
>     * Continuous operation, even after multiple reports.
>     * Simple, intuitive annotation APIs.
> 
> There are still false positives, and some are already being worked on
> for suppression.  Especially splitting the folio class into several
> appropriate classes e.g. block device mapping class and regular file
> mapping class, is currently under active development by me and Yeoreum
> Yun.
>> Anyway, these efforts will need to continue for a while, as we’ve seen
> with lockdep over two decades.  DEPT is tagged as EXPERIMENTAL in
> Kconfig — meaning it’s not yet suitable for use as an automation tool.
> 
> However, for those who are interested in using DEPT to analyze complex
> synchronization patterns and extract dependency insights, DEPT would be
> a great tool for the purpose.


