Return-Path: <linux-nfs+bounces-22738-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IZH2GFq/N2pzRgcAu9opvQ
	(envelope-from <linux-nfs+bounces-22738-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 12:39:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA26AA9A2
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 12:39:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=goodmis.org (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22738-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22738-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B672C300AEEC
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7773628B4E2;
	Sun, 21 Jun 2026 10:39:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664EA74BE1;
	Sun, 21 Jun 2026 10:39:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782038355; cv=none; b=VbgtBVqJ1l6tMSan5tH3KZjP6Jj5W66NQwDI08U5eZO+TNUxWGJTJKHKGP6GBk0WRAd4vEPITWDaBgneHpMWCNMKZlyEIUGKqRt+0sZZB38FYzhFUnbAnKqQoChdsgOu10smHklERHOPj+Td344KsLqtUgRKDF3wjxOSh3QdAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782038355; c=relaxed/simple;
	bh=vG8e9limOnj0jrCGh5nGVxswyihBpxRX/4JwXlAAtP4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AbQoSgQPGMGaEYn07z1GhB8n9P6YE3OEfdUDhXs1LoyPeVG6t8exqvYWsPQek3pxdQEeYL/yoDHzFbN6fcODYVSI5LomLMatLJZwmIVc1GbKm4ggEXm+0g93Qm83eYKeEONoMVCI3PjdCpV925c6F78nqLkWgLOMBTaXrCPvmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id A4F80403B5;
	Sun, 21 Jun 2026 10:39:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id A063517;
	Sun, 21 Jun 2026 10:38:58 +0000 (UTC)
Date: Sun, 21 Jun 2026 11:38:55 +0100
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@kernel.org>, Steven Rostedt <rostedt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_tracing=3A_Add_CONFIG=5FTRA?=
 =?US-ASCII?Q?CE=5FPRINTK=5FDEBUGGING_to_clean_up_kernel=2Eh?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87ik7cmcb7.ffs@fw13>
References: <20260621093430.264983361@kernel.org> <20260621093811.168514984@kernel.org> <87ik7cmcb7.ffs@fw13>
Message-ID: <65FD4729-3DEB-44BF-B085-1F72A0B7BF3A@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 1rpq566iuu696tbe6de19udoqya4ijdw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+altd1Yz9Y3NVTA4Q+RMlDrpJ2CoeKO4s=
X-HE-Tag: 1782038338-801961
X-HE-Meta: U2FsdGVkX1+UIJ7kmLtbV5k3wlv8csQwDalYtg7WqKufnOv7be+VuRDa3ft8H3X3zzwfr+uJaQZNz0sDC4oyI98+t0mZe8z4QM7YVjOJ7k9IvaQO5X/gwLzm/T/snIDf9B1tqJjVQMbg/Fnqr36PDksXLybxk5Wk4szMxT0dI7RGk8YrmbCkpbiPzakXtErPJu/4LvGLwyxtHWX9zek973SlOgxvLlgqkXDRAT2+DqJr5WMtzWdQf68LXDneXrIH36GLwhtQHs9JqXlxGiQxIii+hAq+RQvxokuLaf3ukb8Kl6fOR60wgmpjUFzbMjevVHTotC5pRIjw762yNXa4cwdML3kSKjmj+IzsGxPuo8Puez99eB9siQ==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22738-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,vger.kernel.org,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rostedt@goodmis.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:rostedt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,goodmis.org:mid,goodmis.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19BA26AA9A2



On June 21, 2026 11:13:00 AM GMT+01:00, Thomas Gleixner <tglx@kernel=2Eorg=
> wrote:
>On Sun, Jun 21 2026 at 05:34, Steven Rostedt wrote:
>> Instead of having trace_printk=2Eh included in kernel=2Eh, create a con=
fig
>> TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
>> Makefile to allow developers to add trace_printk() without the need to =
add
>> the include for it=2E Having it included in the Makefile keeps it from =
being
>> in the dependency chain and it will not waste extra CPU cycles for thos=
e
>> building the kernel without using trace_printk=2E
>
>IOW, you make it worse just because=2E
>
>With the header being separate I add the three trace_printk()s and the
>include to the source file I'm investigating=2E The recompile will build
>exactly this source file=2E
>
>Having to enable the config knob will result in a full kernel rebuild
>for no value=2E
>
>Seriously?

Like having lockdep enabled, this would always be set in the development e=
nvironment=2E It's not something to only enable when you need to add a trac=
e_printk=2E If you don't want to rebuild everything, by all means add the i=
nclude file by file=2E There's nothing preventing you to do that with this =
solution=2E

-- Steve=20

P=2ES=2E I'm replying on my phone as I'm in the London Tube=2E Thus why I'=
m not trimming my email=2E


>
>Thanks,
>
>        tglx
>

