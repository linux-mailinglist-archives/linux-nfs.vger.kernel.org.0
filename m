Return-Path: <linux-nfs+bounces-21862-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA0ZHde1EWpupAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21862-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 16:12:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F985BF49D
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 16:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 368403034B14
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCE139A7E9;
	Sat, 23 May 2026 14:07:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C383168FB
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779545263; cv=none; b=f6Tw1+cQ4LAe0OZQM7lv6+b9qOJpgzaYWeRuIaUT4TOPH9K4fFU2MU4j+nBFJT5v5lxLn5uqRc1xBYbPg37P9rmaLrHfTWyrIqz0Ly0Z3PZQnVD2vZVUfQCp4vCShQjsbxYpsPGH+kTDoIlcA4yVWm84TUpYGFYoKr/Avb4LKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779545263; c=relaxed/simple;
	bh=QLj/GX5k7eFyGfeZf3Wtm2oB8X6vtQ/bwHDCPYzJK1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMIsKyjJdRS7mUBbDM7cI8bZpMwXiIz1Wg7Uuix6Kp2rnvC5HHOnKw3WUfYoqmixgBH1QrHUkzB5VR2fkdr/KBq85GlhBb2PnX/HPpOUTU9xyfoeKRulzhk2iCLs3qyXNVwNwVEP45b4dzlQYsdR77LiGJArB0oM55pm0GmdmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bcd03747ee7so122597366b.1
        for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 07:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779545261; x=1780150061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WuWEfTQYjsCVqVvHObEiNmRNaaJS3/KGoVEjCdjn4Xk=;
        b=EJJWOwFYfXhxdVtzFvmOIxAQuTi4yvCQ0HZHVFnaJHwbSQQCGZ68kfbdOOi3yoCZj0
         LqlTUDSFTRn0tWJMe9yN7uA/c0rOhIgxbUViOUPo5lVozE8BxuQ1arvCsHRj/Nnehywu
         uLW48y/GLT6baE7oQ8KI136FlfX2hFMeI7pL+rK7x4nGM5tbmrbLyqJItx3L9aXa3R0f
         4piEdsIHQBTlGlBP3Pn/O9rFAT4Yefl1L+N2siqji1uUeXc4dzShacc2kGTuLkIl5zz3
         9eIMnjdGFYzp0r7ZuQnRxAogGcGiwRzqc4AX402zPmEo2KPCs+K3JaSaB2WaP5UfpUac
         9/+A==
X-Forwarded-Encrypted: i=1; AFNElJ99fWYsp9706kR7u2uKAmBG3clphoHaNj6Eo2s+udvGWS+jLvy7/P566PNtsW/ws3LYi8g6OSV0574=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyXm13Zqet23nrt6JYzT+AEUC5DZGDLMw/Vzy9Uz4mQjpDzRG
	AgJ33XRzmwpFT7kkIg8DeG9EBv8mFexQKbP7Csyy9Jd7/O66p6PsJTWjbiuiiU9bo60=
X-Gm-Gg: Acq92OHe6kigfMpZt8g+HpB2/dh8qU02WZiOLtdyKtDm/XueoO+XQOY8blRCOkZkikJ
	EApugJuSOlGdv8LU3djsgHEeMY6oL6sM6/vDS8Zd7d6ECCggRIGlocNTkizydET7Kf6iPcoOwfW
	eyw7QN2vy9WR9nxuiiblY0M1kZFZKcort09QklKKBml+E5KazTPfS1VfTjEuvC1BkT931YkCw9Q
	/xbNbBywryeGek5SPqEDXQX24+Kp8TDgDDshiZV7Uo3KgJ0b/trJ4F+9zlnOl5KY04YCQIvjjdE
	SD2Rjvx0BQVwf3GqBMQj1beYlh65sFT61jCxKknd0VAZ3B1C57r609VNh8a/xXLZp16+NqooPMS
	ifjIyPlvUermE75H2PN6UzJW3L+QCCHYH3MvJwa2vxkRs9jkoCWYHR71snbVs17nSUrR6Qgc+zb
	oXoOWiYyUmk9ZED1y9urnT/ADISDbosCWGS6dWGbWhNxjlNXcI2Rsbh5hqbyA7ZFW5z0l/bkri0
	ZEPwIiaV9bZei5jKaTqUZw7Krnl7izbTetTeDhEsVQCrAJv7cQoujFbnlL8r2D5H8490p9ZUYGR
	p3P4N+LM4g==
X-Received: by 2002:a05:6402:358d:b0:687:8a9f:3148 with SMTP id 4fb4d7f45d1cf-6889cc4eb41mr1944202a12.7.1779545260737;
        Sat, 23 May 2026 07:07:40 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b9b6d277sm1941640a12.1.2026.05.23.07.07.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 07:07:40 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49048a8ca1bso893405e9.1
        for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 07:07:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/pBoYiKq1FRFx+howsxltjw7S/GjUiMBlHQ6ykifPz8ywAXxTNUYSXkDXPdIKe7euRcD5KEbyeNcc=@vger.kernel.org
X-Received: by 2002:a05:600c:8484:b0:48a:56d4:7274 with SMTP id
 5b1f17b1804b1-490428ce814mr56748215e9.3.1779544847387; Sat, 23 May 2026
 07:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205071855.72743-1-byungchul@sk.com> <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
In-Reply-To: <6b2a816f-eb3b-4e0c-a024-ee2e3743eb04@kernel.org>
From: Yunseong Kim <ysk@kzalloc.com>
Date: Sat, 23 May 2026 16:00:36 +0200
X-Gmail-Original-Message-ID: <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
X-Gm-Features: AVHnY4Jzdbo-RS-M3p-EbMJdQhZ_EyUwot0ge9SpoXayUSqjrmRfCiJZJ7yo4J8
Message-ID: <CA+7O06GxeDLR9RcKDN2i-Rgc4kgzz6BfF4b0XAH4tFx=A723Nw@mail.gmail.com>
Subject: Re: DEPT (the dependency tracker) as AI review prompt? (was: DEPT v18)
To: Harry Yoo <harry@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org, 
	akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org, 
	hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, 
	dennis@kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	vbabka@suse.cz, ngupta@vflare.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, gustavo@padovan.org, 
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org, 
	miguel.ojeda.sandonis@gmail.com, neilb@ownmail.net, bagasdotme@gmail.com, 
	wsa+renesas@sang-engineering.com, dave.hansen@intel.com, geert@linux-m68k.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	Chris Mason <clm@meta.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Josef Bacik <josef@toxicpanda.com>, Yunseong Kim <yunseong.kim@est.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[sk.com,vger.kernel.org,skhynix.com,linux-foundation.org,opensource.wdc.com,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,linux.intel.com,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev,qq.com,ownmail.net,sang-engineering.com,linux-m68k.org,garyguo.net,protonmail.com,umich.edu,meta.com,toxicpanda.com,est.tech];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,locking.md:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21862-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kzalloc.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,renesas];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ysk@kzalloc.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.974];
	RCPT_COUNT_GT_50(0.00)[170];
	R_DKIM_NA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 10F985BF49D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Harry,

On Sat, May 23, 2026 at 2:33=E2=80=AFPM Harry Yoo <harry@kernel.org> wrote:
>
> Can we start DEPT as an AI review prompt, by documenting DEPT's
> dependency tracking model and false positive elimination rules as a
> carefully crafted prompt?
>
> While DEPT can identify deadlock issues beyond lockdep's capabilities,
> it is hard to enable in automated testing; without fine-grained
> annotations it can produce a high rate of false positives, and verifying
> them requires significant human effort.
>
> The open source AI Review Prompt has locking.md file [1] that teaches
> the AI how to review locks and detect misuse.
>
> If we can write a review prompt for DEPT in a similar manner and have
> the AI do the deadlock detection and false positive elimination, I think
> we could identify those problems more effectively with much less human
> effort.
>
> [1]
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/lock=
ing.md
>
> --
> Cheers,
> Harry / Hyeonggon

I think this is an excellent idea, Harry.

I've previously experimented with running DEPT alongside syzkaller fuzzing,
and many hung tasks missed by lockdep are caught by DEPT, but the resulting
high volume of reports makes it easy for issues to get lost in the massive
log output. Sorting through that output manually is a huge bottleneck, so
leveraging a well-crafted AI prompt to triage the warnings and filter out
the false positives would be incredibly valuable.

Leveraging an AI prompt to triage these warnings would be incredibly valuab=
le.
I'd be happy to help translate DEPT's tracking model into specific rules fo=
r
reducing false positives and establishing solid filtering patterns.

> On 12/5/25 4:18 PM, Byungchul Park wrote:
> > I'm happy to see that DEPT reported real problems in practice:
> >
> >     https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I=
-love.SAKURA.ne.jp/
> >     https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byun=
gchul.park@lge.com/
> >     https://lore.kernel.org/all/b6e00e77-4a8c-4e05-ab79-266bf05fcc2d@ig=
alia.com/
> >
> > I=E2=80=99ve added documentation describing DEPT =E2=80=94 this should =
help you
> > understand what DEPT is and how it works.  You can use DEPT simply by
> > enabling CONFIG_DEPT and checking dmesg at runtime.
> > ---
> >
> > Hi Linus and folks,
> >
> > I=E2=80=99ve been developing a tool to detect deadlock possibilities by=
 tracking
> > waits/events =E2=80=94 rather than lock acquisition order =E2=80=94 to =
cover all the
> > synchronization mechanisms.  To summarize the design rationale, startin=
g
> > from the problem statement, through analysis, to the solution:
> >
> >     CURRENT STATUS
> >     --------------
> >     Lockdep tracks lock acquisition order to identify deadlock conditio=
ns.
> >     Additionally, it tracks IRQ state changes =E2=80=94 via {en,dis}abl=
e =E2=80=94 to
> >     detect cases where locks are acquired unintentionally during
> >     interrupt handling.
> >
> >     PROBLEM
> >     -------
> >     Waits and their associated events that are never reachable can
> >     eventually lead to deadlocks.  However, since Lockdep focuses solel=
y
> >     on lock acquisition order, it has inherent limitations when handlin=
g
> >     waits and events.
> >
> >     Moreover, by tracking only lock acquisition order, Lockdep cannot
> >     properly handle read locks or cross-event scenarios =E2=80=94 such =
as
> >     wait_for_completion() and complete() =E2=80=94 making it increasing=
ly
> >     inadequate as a general-purpose deadlock detection tool.
> >
> >     SOLUTION
> >     --------
> >     Once again, waits and their associated events that are never
> >     reachable can eventually lead to deadlocks.  The new solution, DEPT=
,
> >     focuses directly on waits and events.  DEPT monitors waits and even=
ts,
> >     and reports them when any become unreachable.
> >
> > DEPT provides:
> >
> >     * Correct handling of read locks.
> >     * Support for general waits and events.
> >     * Continuous operation, even after multiple reports.
> >     * Simple, intuitive annotation APIs.
> >
> > There are still false positives, and some are already being worked on
> > for suppression.  Especially splitting the folio class into several
> > appropriate classes e.g. block device mapping class and regular file
> > mapping class, is currently under active development by me and Yeoreum
> > Yun.
> >> Anyway, these efforts will need to continue for a while, as we=E2=80=
=99ve seen
> > with lockdep over two decades.  DEPT is tagged as EXPERIMENTAL in
> > Kconfig =E2=80=94 meaning it=E2=80=99s not yet suitable for use as an a=
utomation tool.
> >
> > However, for those who are interested in using DEPT to analyze complex
> > synchronization patterns and extract dependency insights, DEPT would be
> > a great tool for the purpose.

Best regards,
Yunseong

