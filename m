Return-Path: <linux-nfs+bounces-23127-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aGeKIhNmTGr4jwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23127-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 04:36:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F5A716DE1
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 04:36:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=sk.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23127-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23127-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C975301A39C
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 02:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D919373BE7;
	Tue,  7 Jul 2026 02:35:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCA136B048;
	Tue,  7 Jul 2026 02:35:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391756; cv=none; b=avezIVHor5HBINqgHTabGyzkFeCNg794O0UTbP0YuELdXWqwPMgtJW5CC9z9lU+vkbs0LB04oMH5FDkOmcTdy6OSm1I76xvNG9kX9Sikx9O2rJ/Dr3E01HzP5zu7sUanoFnbCntE6P9hpGO8LNiocbRwCuZIXVA5BjCHsRKK8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391756; c=relaxed/simple;
	bh=4aXH2f9ytQjDBaSOD98MPjwilmVXY5Gbzhe6oue0oYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrknILNZmzbBrxGUn5HMTs3x9e9J87LTdTXOBHJRMXSSyWYy2WRJ3g2VKdTcT/io+4KWKAPM4ymWr5jdhlu1DXlgfmo2H6K42xrRaAfADWYcIysL52js83cVjJDtYDBccIgf0ZAZ1jHUf5FIK1FL9vN/GG6Bz3FOv1O0NprSxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
X-AuditID: a67dfc5b-c45ff70000001609-b3-6a4c66043553
Date: Tue, 7 Jul 2026 11:35:42 +0900
From: Byungchul Park <byungchul@sk.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com,
	kernel_team@skhynix.com, torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, will@kernel.org,
	tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
	sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
	johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
	david@fromorbit.com, amir73il@gmail.com, gregkh@linuxfoundation.org,
	kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
	mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
	vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
	dennis@kernel.org, cl@linux.com, penberg@kernel.org,
	rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
	linux-block@vger.kernel.org, josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com, hamohammed.sa@gmail.com,
	harry.yoo@oracle.com, chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com, boqun.feng@gmail.com, longman@redhat.com,
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com,
	netdev@vger.kernel.org, matthew.brost@intel.com,
	her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com,
	bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
	sumit.semwal@linaro.org, gustavo@padovan.org,
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
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
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v19 22/40] dept: track PG_locked with dept
Message-ID: <20260707023542.GA33746@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-23-byungchul@sk.com>
 <akvueAxPl8aoLvMR@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akvueAxPl8aoLvMR@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUybZRSGfd7vNtS8qyM+jsVoVVy2dI5lJsdoyKJ/3kSNS/g3k2lZX6Wz
	wGwBhwRTYEysiF1dIbQgXefqRMiw3diAdOvYZ1VMO9jWlW/TVpdSpqOulo9iiy7u33XOfefK
	+XE4Um5nNnCasgpRV6bSKhgpJY3nOJTUe2/s2xaKAkxMh2m4WeeloMnVTsO1W/UUJJdsJDQO
	rFKwYr7CQiI1zoKlDkFrwExC0H+ehIW+NAOxi/cQWGbDDFijNhbi00M0rE7+RoAznCagy+HO
	VFr/YKDN4kdw6soUAs+JegYiptMkjIYfBZ/lcwbigQ4C5vsYsNd7aAj8HEPQaTMjiIY8BDQc
	O8lAa6eLgoGZQRYCsWUCJlrNBHzvehOmnVEK2u4wYGv7nQBL7xABKWc3C07Dc2AbGaVhebYA
	Vu3lMPmlhQLf1E0aYlEzA2cMMyy4bl9GkBibJaCnOUqCJ7QFmlYSCEYHOxho7jtNg8GWpMHv
	/YmG47cCBPgPf0FD0BRB0DvvYHaqhWRjCyV0u/sJofH6CiP0fN2DhKVFMxISxxtIodGUGS/O
	3SWFxb9uMMKPDix889kiIRweUQoD1klWOHguxAp2V6Vw8FKc3qXcLX1FLWo1VaLuhcJ3pSV/
	9kbI/baCA+5uD2tAC/lGJOEwvwOPXz9PPeB29w9rTPHP4l8u2YksM/zzOBhMkUbEcev5TXju
	1HYjknIkf+RJfLSln812HuML8bnx+2ss4wGb7EfYbEnONyM815ym/g3WYV97eI1JfjMOpu8Q
	WSnJ5+Fv01x2LcncMJ2MkVnO5Z/B3v6rRNaD+V8leDCS/u/QJ/CFE0HKhHjrQ1rrQ1rr/1o7
	IruRXFNWVarSaHdsLaku0xzYure81IUyf+usXX77LLrnLxpGPIcUObI+4+v75LSqSl9dOoww
	RyrWy/I3ZVYytar6Y1FX/o6uUivqh1EeRykel22//5Fazr+vqhA/EMX9ou5BSnCSDQYECx3D
	T+flblRoTw5Njrlv7/m7prK4Wjn20kzyUMunl72pwtzygWM3puJnJw5NUbOdqZ11TQ0vS/aG
	k0VY5tu4bsTx6rbOpbvsVwI392HVLp+xvfi7o127HwHixRFlUS3jfUudI9RESNOZT4a6EvqQ
	K3+xtqlCsDw1XyMxaF4rVlD6ElXBZlKnV/0DA5Tr8bMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH8zzP7b2XZtVrZfMGEhLry0wzcTI0J3PzJVnCzXyJcR+2+EWb
	cZXypmkdA5NFKDRWJKY0toRWtKLUBXkrrUxwZVi2MmUOKttgA1ZZKti0jg15CSDF1mXRLye/
	8z///8n5cFgij0qSWHX+KVGTr8pV0FJKemBH6Wbq2L7sdwMTUjDoz8BIICiB30q6KJiZNlBw
	qbmBhiXbNwwYWqsl8OOgjoL+ppsIAjMGBHOLNgL69mUKlkw+BqbnhxkwlyBY9vgQWPwmAkP9
	3xFocJdgeNYSpSHcPYXAPBakoSpUQsGkowKBddzGQOiHDHgauCOB5dEJDIOzEQSOYBRDsOss
	giVLDlypdcXiln9oWHzQR6DK3I/g6tgoganQIwRu358IPF/raHhsvEVgILgCfpmZpOGe+TwN
	T/2XMPzdQoNd55GA/6cwghqbCcH4Hx4MpdeaabDUtFLQ/qiDAX/4OYYRiwnDzdb9EHCMU9Br
	rMWxc2Mu5xqwVZXiWHmCwdx4B8O8o57ZXYeEOf0FSqh3tWFB/3CJFhouNyBhccGEhOm6UiLo
	jbG2OzJJhDLXl0Jdb4QWFmZ+pQXPrJ0S7tfywvVzC1iofLBZaLeOMgf3HJZ+kCnmqgtEzZad
	R6VZ/zY+JidtWwtd9R6mGD3bWI4SWJ5L56tdTirOFLee//l7O44zzb3NDw3Nk3LEsoncJj7i
	TitHUpZwF1P4qxfamLhnNbeT7xyefckyDnij/SITN8m5CsRHKqLUf4NV/L3q4EsmnJIfioZw
	fCnhkvkbUTYuJ8RuCMyFSZzf5NbxXW092Ihk1tfS1tfS1ldpOyL1KFGdX5CnUuduS9XmZBXl
	qwtTPz+R14piX+n46nnlbTQ9kOFFHIsUb8hayvdmyyWqAm1RnhfxLFEkyjZuikmyTFXRaVFz
	4ojmi1xR60XJLKVYI/v4U/GonDuuOiXmiOJJUfP/FLMJScVox8rOTzqN207vYrZ3HAzNjvUd
	ej/tQ+9b78gHC4uFhYq6bP9HqUfW9w4cakJlzhTnsfdu/I5GjG7Pck96dI//4Srf9hppzxZb
	d8YtX3Ll3W/DE86IUuFOYJo6XOfGy9YOW9OaJRuUuhFvn1Lc9VfSZ/evJDam56lG16YYdIev
	TWUqKG2WaquSaLSqF3VSn4uRAwAA
X-CFilter-Loop: Reflected
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[sk.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23127-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willy@infradead.org,m:linux-kernel@vger.kernel.org,m:max.byungchul.park@gmail.com,m:kernel_team@skhynix.com,m:torvalds@linux-foundation.org,m:damien.lemoal@opensource.wdc.com,m:linux-ide@vger.kernel.org,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:mingo@redhat.com,m:peterz@infradead.org,m:will@kernel.org,m:tglx@linutronix.de,m:rostedt@goodmis.org,m:joel@joelfernandes.org,m:sashal@kernel.org,m:daniel.vetter@ffwll.ch,m:duyuyang@gmail.com,m:johannes.berg@intel.com,m:tj@kernel.org,m:tytso@mit.edu,m:david@fromorbit.com,m:amir73il@gmail.com,m:gregkh@linuxfoundation.org,m:kernel-team@lge.com,m:linux-mm@kvack.org,m:akpm@linux-foundation.org,m:mhocko@kernel.org,m:minchan@kernel.org,m:hannes@cmpxchg.org,m:vdavydov.dev@gmail.com,m:sj@kernel.org,m:jglisse@redhat.com,m:dennis@kernel.org,m:cl@linux.com,m:penberg@kernel.org,m:rientjes@google.com,m:vbabka@suse.cz,m:ngupta@vflare.org,m:linux-block@vger.kernel.org,m:josef@toxicpanda.com,m:linux-fsdevel@vger.kern
 el.org,m:jack@suse.cz,m:jlayton@kernel.org,m:dan.j.williams@intel.com,m:hch@infradead.org,m:djwong@kernel.org,m:dri-devel@lists.freedesktop.org,m:rodrigosiqueiramelo@gmail.com,m:melissa.srw@gmail.com,m:hamohammed.sa@gmail.com,m:harry.yoo@oracle.com,m:chris.p.wilson@intel.com,m:gwan-gyeong.mun@intel.com,m:boqun.feng@gmail.com,m:longman@redhat.com,m:yunseong.kim@ericsson.com,m:ysk@kzalloc.com,m:yeoreum.yun@arm.com,m:netdev@vger.kernel.org,m:matthew.brost@intel.com,m:her0gyugyu@gmail.com,m:corbet@lwn.net,m:catalin.marinas@arm.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:luto@kernel.org,m:sumit.semwal@linaro.org,m:gustavo@padovan.org,m:christian.koenig@amd.com,m:andi.shyti@kernel.org,m:arnd@arndb.de,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:rppt@kernel.org,m:surenb@google.com,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:jo
 sh@joshtriplett.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[byungchul@sk.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,skhynix.com,linux-foundation.org,opensource.wdc.com,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[165];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sk.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8F5A716DE1

On Mon, Jul 06, 2026 at 07:05:44PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 06, 2026 at 03:19:10PM +0900, Byungchul Park wrote:
> > Makes dept able to track PG_locked waits and events, which will be
> > useful in practice.  See the following link that shows dept worked with
> > PG_locked and detected real issues in practice:
> >
> >    https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
> 
> > @@ -219,6 +220,7 @@ struct page {
> >       struct page *kmsan_shadow;
> >       struct page *kmsan_origin;
> >  #endif
> > +     struct dept_ext_wgen pg_locked_wgen;
> >  } _struct_page_alignment;
> 
> I may not understand this quite correctly, but I think that tracking
> PG_locked dependencies in the struct page has both false positive and
> false negative problems.
> 
> Imagine we have a file mapping M1 containing folio F1 at index 0 and F2
> at index 1.  It is correct locking order to lock F1 before locking F2
> (for example when doing writeback).  Later, M1 has its folios reclaimed
> and returned to the free pool.  Then each is added to mapping M2, this
> time with folio F2 at index 8 and F1 at index 9.  Now the correct order
> to lock these folios in the order F2 followed by F1.

First of all, I appreciate your feedback.  Thanks!

That case doesn't generate any dependency unless any other waits are
involved in.  That should be handled in xxx_nested manner e.g.
folio_lock_nested() that I need to introduce.  The work is in progress.

> I don't see a part of this patch where we clear pg_locked_wgen when the
> page is returned to the page allocator.  Maybe I missed that.

You are right.  pg_locked_wgen doesn't get cleared.  However, DEPT works
this way:

   folio_lock()
      wait_for_pg_locked_cleared()
      set_pg_locked() // (1) update pg_locked_wgen to the current wgen

   ... // there might be other waits

   folio_unlock()
      clear_pg_locked() // (2) check if there have been any waits since (1)

In other words, it's guranteed that pg_locked_wgen has been updated e.i.
(1) when DEPT refers to pg_locked_wgen e.i. (2).  So I don't think it's
a problem.

> I think we should be tracking PG_locked dependencies in the owner
> of the folio.  For files, that would be in the struct address_space.
> For anon memory, I think that's in the anon_vma, but if somebody told
> me it was in some other structure, I wouldn't argue with them.

I think it's a good point but it's a classification issue.  folios owned
by struct address_space should be classified to e.g. address_space_class
and ones owned by struct anon_vma should be classified to e.g.
anon_vma_class.  I will work on it to apply the insight you just gave
but better do it as follow-up patches since the initial patchset is
already too big to get reviewed.

> This requires slightly more complexity than lockdep currently has.
> We don't want to use a lockdep class for each folio, obviously.  So we
> need something to say "I already have folio F1 locked, is it OK to lock

From DEPT's perspective, folio_lock(F1) and folio_lock(F2) are waits and
folio_unlock(F1) and folio_unlock(F2) are events.  Since DEPT tracks
dependencies with specified classes between waits and events, DEPT's
interest in the following example is to detect a situation like:

   < context X >

   folio_lock(address_space_class'ed F1)
   ...
   folio_lock(anon_vma_class'ed F2)
   ...
   folio_unlock(anon_vma_class'ed F2)
   ...
   folio_unlock(address_space_class'ed F1)

   < context Y >

   folio_lock(anon_vma_class'ed any folio)
   ...
   folio_lock(address_space_class'ed any folio)
   ...
   folio_unlock(address_space_class'ed any folio)
   ...
   folio_unlock(anon_vma_class'ed any folio)

However, the following pattern should be manually annotated by
developers like using folio_lock_nested() or something.  DEPT cannot
work with it automatically:

   folio_lock(address_space_class'ed F1)
   ...
   folio_lock(address_space_class'ed F2)
   ...
   folio_unlock(address_space_class'ed F2)
   ...
   folio_unlock(address_space_class'ed F1)

or

   folio_lock(anon_vma_class'ed F1)
   ...
   folio_lock(anon_vma_class'ed F2)
   ...
   folio_unlock(anon_vma_class'ed F2)
   ...
   folio_unlock(anon_vma_class'ed F1)

These should be explicitly annotated by developers if it's intended:

   folio_lock(address_space_class'ed F1)
   ...
   folio_lock_nested(address_space_class'ed F2)
   ...
   folio_unlock(address_space_class'ed F2)
   ...
   folio_unlock(address_space_class'ed F1)

or

   folio_lock(anon_vma_class'ed F1)
   ...
   folio_lock_nested(anon_vma_class'ed F2)
   ...
   folio_unlock(anon_vma_class'ed F2)
   ...
   folio_unlock(anon_vma_class'ed F1)

> folio F2?".  Essentially figuring out how we can track all folios in a
> given mapping the same way, and making sure that we don't deadlock on
> folios in the same mapping.

At the moment, as I told you, DEPT cannot work with dependencies between
the same class'ed folios.  However, it'd be much better if DEPT can work
with even those cases.  Could you provide a scenario where a deadlock
happens between the same class'ed ones?  Any idea how to detect for the
cases?

> If F1 and F2 are in different mappings, it's not a deadlock if F1 is in a
> filesystem mapping and F2 is in its backing dev.  It's also not a deadlock
> if F1 and F2 are both filesystem folios and the inodes are both locked.
> See vfs_lock_two_folios() in fs/remap_range.c.

Yeah.. DEPT is a tracker to track dependencies between waits and events
even across different contexts, but not a magic unfortunately.  That
lock ordering issue - with the same class'ed ones - should be resolved
in the manual manner as vfs_lock_two_folios() does.

> I have much less knowledge about anonymous memory locking order.
> Maybe it doesn't happen.  Or about locking one anon and one file folio.
> For slab memory, we don't sleep on PG_locked (it's used as a spinlock bit).
> For other kinds of memory ... I don't know.  Page migration is fun.

Anyway, the sophisticated classification you mentioned is necessary for
DEPT to be better especially for folio locking mechanism.

Thanks again!

	Byungchul

