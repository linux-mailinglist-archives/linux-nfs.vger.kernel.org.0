Return-Path: <linux-nfs+bounces-22746-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OlVMEIvzN2qTVwcAu9opvQ
	(envelope-from <linux-nfs+bounces-22746-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 16:22:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 953676AB0B5
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 16:22:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=goodmis.org (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22746-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22746-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B0343012C4B
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB3A36BCD7;
	Sun, 21 Jun 2026 14:21:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8BE126C03;
	Sun, 21 Jun 2026 14:21:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782051716; cv=none; b=FRRAI6pgbHBRNvPJ4gSq5TI7ENUHz5kkZbQXh741XGtp1NzalyIBKN0qGYbNArsTZiyetvFHDyMSx8/u+Myu0ECR3Qqfe9J7nSjrHErytEqtLcs61YVXkPPIkKxj3JlHFIv+CZItyJdG4K2BcyLzZlCrX9xabssDjF/hTrKXWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782051716; c=relaxed/simple;
	bh=IpwTUV7cMr9DZyt+PGfboKuTJxbESBW6N7Y5Sf43YLI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YbP495Sol6A0VrKRNrzUV2NjE2F/YlU4yz8ki46SdAI01wVhFzvBf3eEzorQzjJE03Eal/n344XNfebREJDZtvr22DWL9u/6XnoG5IZpuLOn+0aqZEELz2fQlaHSA2DlwWeA2xU0IsuUBNZPDrsQzuXNhFvFyjMYGsP2iSlgLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 36393166CE4;
	Sun, 21 Jun 2026 14:21:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 1169420026;
	Sun, 21 Jun 2026 14:21:46 +0000 (UTC)
Date: Sun, 21 Jun 2026 14:24:07 +0100
From: Steven Rostedt <rostedt@goodmis.org>
To: Yury Norov <yury.norov@gmail.com>, Steven Rostedt <rostedt@kernel.org>
CC: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_tracing=3A_Move_non-tra?=
 =?US-ASCII?Q?ce=5Fprintk_prototypes_back_to_kernel=2Eh?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ajfiVTlCIVlqW3sh@yury>
References: <20260621093430.264983361@kernel.org> <20260621093811.007634476@kernel.org> <ajfiVTlCIVlqW3sh@yury>
Message-ID: <C4ED8F5F-042B-43B6-B17A-7C3E2743E48F@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: m5id8uysanmtioempn6emsnsdgs5phht
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19WinE5LWQa8HzvFNjRdlGwYann5/w38N8=
X-HE-Tag: 1782051706-894210
X-HE-Meta: U2FsdGVkX183C80JzklQEIa+kgNTjJZOknF6vAmyswd98TyGVgTRC8SyVWsz19w9BPwppSUtPiaeZPJXrIQbsy98gLBfQ1cJQl7yzp34fic0gzv0s9hrB6mxeJXqinMntnlfXe73gJIH/D2pt50tZwbP93X5621Z+n1JPgBDPeg2Qqz5v4YTHrFVzIaZ3VcUXUAKuj/7BGAd4D8VuUGw+dkVUMzvtoZoN/seDFwcReGQTYquH+YMzJ815xl7wR46FpiJ9+THR6XRxVuJCVh6iJAhD/ahytYNQMcMNmgFRXblBTPxbXFH63lW5Djcit4yMB+uNazqknvOnTkAw3vbLAB4CMkaAooU09WOrb4dRD5m5BQTaIQKdR+GIKMYTEwoPVIlbOYXwm+XOsikcSvwWkIxSgSJzlVeOeQCU6+wcUsByy327CPzOKFxszsj4v/QYc8SsHkTU40=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22746-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yury.norov@gmail.com,m:rostedt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rostedt@goodmis.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,goodmis.org:mid,goodmis.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 953676AB0B5



On June 21, 2026 2:08:37 PM GMT+01:00, Yury Norov <yury=2Enorov@gmail=2Eco=
m> wrote:
>On Sun, Jun 21, 2026 at 05:34:31AM -0400, Steven Rostedt wrote:
>> From: Steven Rostedt <rostedt@goodmis=2Eorg>
>>=20
>> In order to remove the include to trace_printk=2Eh from kernel=2Eh the =
tracing
>> control prototypes need to be moved back into kernel=2Eh=2E That's beca=
use
>
>Please don't=2E Instead, you can split them out to trace_control=2Eh, and
>include where needed=2E I actually have a prototype for it, FYI:
>
>https://github=2Ecom/norov/linux/tree/trace_pritk3
>

Sure, I have no problem adding another header for this=2E

>> they are used in other common header files like rcu=2Eh=2E There's no p=
oint in
>> removing trace_printk=2Eh from kernel=2Eh if it just gets added back to=
 other
>> common headers=2E
>>=20
>> Prototypes are very cheap for the compiler and should not be an issue=
=2E
>
>It's not about cost, it's about mess=2E kernel=2Eh is included everywhere=
=2E
>Is that API needed everywhere? No, it's needed in literally 10 files=2E
>So, no place in kernel=2Eh=2E
>=20

Well one of those files is rcu=2Eh which is also pretty much included ever=
ywhere=2E But OK=2E

-- Steve=20


>>=20
>> 2=2E53=2E0
>>=20

