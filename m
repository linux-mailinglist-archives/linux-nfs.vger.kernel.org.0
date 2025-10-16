Return-Path: <linux-nfs+bounces-15280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F088BE120C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 02:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9FA04E5045
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 00:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E0D1922F6;
	Thu, 16 Oct 2025 00:46:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A805695;
	Thu, 16 Oct 2025 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760575612; cv=none; b=KSMEV0T9biTZjbm/2GcEEW90hDMLqWj6U5UD97j+s2AhBNfHqPg9371fmaW/hV2F7EX4xaJxpjndr0B2Y0PslA9eBHqZ2iyaETSWTX0QIx6ggCpOLgnBpJqQ4F0nMXrgsqxtNHemZJHv69Dv+OBKqXfQ2BOFLSF0tgUPARBx+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760575612; c=relaxed/simple;
	bh=bOKJ6TkZJV7OT6XeerMfxJtiPz1ZRcgBwgHMoF0YAxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmUsu6IiC2zDlZv4qTZzhRi0tuylifAifWBwu+1IE358LoT4A5cKj1iSFeX8TUq2QqeOwIiHw6mozmDgLXu0G6zaucShEOaT9Z59CY0C/BJ78Ng0tmcKt5JuN7iygrNNMGxrE9O2zoA/dbEyQrD5BHMe2L2+4Ts72t5qCqPbaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-3b-68f04075064b
Date: Thu, 16 Oct 2025 09:46:40 +0900
From: Byungchul Park <byungchul@sk.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-ide@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>, duyuyang@gmail.com,
	Johannes Berg <johannes.berg@intel.com>, Tejun Heo <tj@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>, kernel-team@lge.com,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
	SeongJae Park <sj@kernel.org>, jglisse@redhat.com,
	Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, ngupta@vflare.org,
	linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com, hamohammed.sa@gmail.com,
	harry.yoo@oracle.com, chris.p.wilson@intel.com,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	max.byungchul.park@gmail.com, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, yunseong.kim@ericsson.com,
	ysk@kzalloc.com, Yeoreum Yun <yeoreum.yun@arm.com>,
	Netdev <netdev@vger.kernel.org>,
	Matthew Brost <matthew.brost@intel.com>, her0gyugyu@gmail.com,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, gustavo@padovan.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>, da.gomez@kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	Josh Triplett <josh@joshtriplett.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, qiang.zhang@linux.dev,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>, neil@brown.name,
	okorniev@redhat.com, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, trondmy@kernel.org,
	Anna Schumaker <anna@kernel.org>, Kees Cook <kees@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Yu Zhao <yuzhao@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, usamaarif642@gmail.com,
	joel.granados@kernel.org, Wei Yang <richard.weiyang@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	tim.c.chen@linux.intel.com, linux <linux@treblig.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	lillian@star-ark.net, Huacai Chen <chenhuacai@kernel.org>,
	francesco@valla.it, guoweikang.kernel@gmail.com, link@vivo.com,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, wangfushuai@baidu.com,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-modules@vger.kernel.org, rcu <rcu@vger.kernel.org>,
	linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 01/47] llist: move llist_{head,node} definition to
 types.h
Message-ID: <20251016004640.GB2948@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-2-byungchul@sk.com>
 <2025100230-grafted-alias-22a2@gregkh>
 <63034035-03e4-4184-afce-7e1a897a90e9@efficios.com>
 <3bbe14af-ccdc-4c78-a7ca-d4ed39fa6b5d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbe14af-ccdc-4c78-a7ca-d4ed39fa6b5d@app.fastmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA03Sf0zMYRwHcM/395277euEh8zmMK1NYTafjcwW8zUmpvkDw9F37qaudqeI
	NSxHbrQkWZfsdCtXXckZw5JkuVVDJqfFdaGdbt1d5IqSy13N+OfZ6/m8n+e954+HIxWd9DxO
	oz0q6rSqVCUjpaR+2c1lWeu/qpe3NsjAeaaJAvdwHgLDwwkKgqPvWfheH2LgmvcMBd6WTXDz
	o4uEstJCBLmW2wwUl9kpeD0wToC70kNB8Z05UHotlwgv/QSMVlaz8MlqYmHCnA51/lc0tPY4
	aRjwFDLgdpyjocc2QUNHU3s4MFVR8OpRLQ21gXIGrgQ8CCqHB1nwvD1HQKFniIV7TwwIHJea
	CKgIBkh4UfqShsa83vDW6qfBbnMy0Ob6zsKY6wENbWNtBHzK97MwVBaioeY1BfXfbjHw6+d1
	BgIFQXr9cuGHIZ8SbDdsSAhW5JKCoSCsxyNmSrj8Ypnw0ORihbON3axgtmcKd62xgqXBSwjd
	AwmCvfoCI9iHClnB6O8khA/OBmZ79G7p2hQxVZMl6uLXHZCqzQO/iYw6/vjztlrmNPLJjEjC
	YX4Vtjieob++68ojI6b4JfhN8AcVMcMvxV1do5PzKH4hvtrvmTTJe2JwUYc+4pl8MnbWVE+e
	l/OrcbmxJWwpp+DHEK7z/aKnghm4taSPmroci7tCXsKIuLCj8a0QFxlL+A3Y9/Y8E/EsfhFu
	uu8gIj2Y75FgR/kHZuqhc/FTaxdVgHjTf7Wm/2pN/2rNiKxGCo02K02lSV0Vp87Wao7HHUpP
	s6PwX6vMGd/zAA117GxGPIeUMnmvdVCtoFVZ+uy0ZoQ5UhklX33Sp1bIU1TZJ0Rd+n5dZqqo
	b0bRHKWcI185cixFwR9WHRWPiGKGqPubEpxk3mkkRy6F5x69efrPfbufBciiZO+2pAP+vPHB
	x4eLh6MXZa4sYIp8MduSUnrXxGydaHQ3hhJr2se2BL/s3ZEwPK11z+f27JmXtS0ZVaNV+YsN
	6+r73N7O/He2nNl9svl9V4uZl3UlcQcvli5ITDK28yWWU92JGy03+iWxybsyp4/E++8oKb1a
	tSKW1OlVfwA4H8q/ZwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH87uP37001txVjDeSLKEb6EzwtRlPlCnJJF5NYPsDddlitJGb
	tQLFtIqgceMZCW4TO9uGVl0HsRIKBQGRihiCo4s6ItipnVqxpvKQMhZpIVBK12LM/Ofkc76P
	5PxxWFIWpleyKvVRUaNW5MqxhJJkbi1LOZb2r3J958gn8Kikh4JgoJKCC82NGCpba2gYsNsQ
	DAUrEcyEzCRUOCIUhHVOBgKzTxmIdDsRGAZ1JDS2lxAw1bKAYfz2GwR6rw+DcayEgknrjwhM
	w2YGxvp2wsRQFw0RzwgBj6f9CKy+BQJ8PacRhA058GttG4ZQ/30SjPoBBL95PSSMtkTNdudz
	BN31pRheVV8jweVbCn8FJzHc0Z/BMDF4gYB/WjBYSrtpuGjWISira8ZguNhKgePFDQYGx+cJ
	eGbQEWBrzYAh6zAF96prieh90dTVFWA2lhHRMUqAvqmLgFlrAwN/1j2jwFqcBOZ+Fw0v600M
	zHs3QMSSD07bCAOes3oK7BP36TQ9EmYqfqaEhrYOQqh4EMZC46VGJITmdEgIXC4jhYrq6Hrb
	P0kK5W3Hhcv3/FiYCz7EQve0hRLu1vLCuf4UwWHyMEL5rSfMV1u+kaRmi7mqAlGzbttBidIy
	HiaO2LlC590mXIz8S6pQHMtzn/FtnkoyxhSXxLsCM1SMMbeKd7tnF/V4LpHXjw4vMskNr+bP
	D2hjvIzL4h/ZGhbzUm4zX1vVF2UJK+PmEG/3h+i3xgf8nRof9ba8hncvjBFViI1yAn9lgY3J
	cdwO3v/wNI7xcu4jvqfjD6IaSU3vtU3vtU3/ty2IbEDxKnVBnkKVu2mtNkdZpFYVrj2Un9eK
	ok9pPTV/rhMFXDt7Ecci+RLpi/pJpYxWFGiL8noRz5LyeOnmk36lTJqtKDohavIPaI7litpe
	lMBS8hXS3fvEgzLuO8VRMUcUj4iady7Bxq0sRvG7iY+nBgO3nExhnnq9p+VA35Wp1Kb6oo2v
	p9+k7/82/dOUr8O+mj1fRpy/nEwJ9m5JXv75aM7Zpemp7r3N0sc/7BO/KPcmlzrcrw/HaQe8
	icmO8/aqzKEe+3xId8a1/SfjhyP6XRldaXRC/6q9x/GrrN9P/W30J9pu3PxescuQVHJdTmmV
	ig1rSI1W8R8ELch0kAMAAA==
X-CFilter-Loop: Reflected

On Fri, Oct 03, 2025 at 01:19:33AM +0200, Arnd Bergmann wrote:
> On Thu, Oct 2, 2025, at 15:53, Mathieu Desnoyers wrote:
> > On 2025-10-02 04:24, Greg KH wrote:
> >> On Thu, Oct 02, 2025 at 05:12:01PM +0900, Byungchul Park wrote:
> >>> llist_head and llist_node can be used by some other header files.  For
> >>> example, dept for tracking dependencies uses llist in its header.  To
> >>> avoid header dependency, move them to types.h.
> >>
> >> If you need llist in your code, then include llist.h.  Don't force all
> >> types.h users to do so as there is not a dependency in types.h for
> >> llist.h.
> >>
> >> This patch shouldn't be needed as you are hiding "header dependency" for
> >> other files.
> >
> > I agree that moving this into a catch-all types.h is not what we should
> > aim for.
> >
> > However, it's a good practice to move the type declarations to a
> > separate header file, so code that only cares about type and not
> > implementation of static inline functions can include just that.
> >
> > Perhaps we can move struct llist_head and struct llist_node to a new
> > include/linux/llist_types.h instead ?
> 
> We have around a dozen types of linked lists, and the most common
> two of them are currently defined in linux/types.h, while the
> rest of them are each defined in the same header as the inteface
> definition.
> 
> Duplicating each of those headers by splitting out the trivial
> type definition doesn't quite seem right either, as we'd end
> up with even more headers that have to be included indirectly
> in each compilation unit.
> 
> Maybe a shared linux/list_types.h would work, to specifically

I found a way to resolve my issue, but I thought it's good idea
regardless of my issue and took a quick look.  However, it seems like
there's an overwhelming amount of work since it might require to replace
all the existing include <linux/types.h> for use of list things with the
new one :-).

	Byungchul

> contain all the list_head variants that are meant to be included
> in larger structures?
> 
>     Arnd

