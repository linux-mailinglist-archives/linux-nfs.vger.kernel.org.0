Return-Path: <linux-nfs+bounces-22737-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mZ+WMDi5N2rBQQcAu9opvQ
	(envelope-from <linux-nfs+bounces-22737-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 12:13:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 399406AA938
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 12:13:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SsyZ+1Ts;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22737-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22737-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD8AB3010C35
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46C288530;
	Sun, 21 Jun 2026 10:13:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8B1607A4;
	Sun, 21 Jun 2026 10:13:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782036784; cv=none; b=hOcB7ZBqOJqklP4Gznf7BZQMVX8nkP3lku/wullKlccs6vWWUotS7JG7Ve/9Gx21BtX+/6U2doEo4+PizYyghTBayNWlV+Xp/lkCDZATSUCJD3D59pa+wZ3XjFzYEwx3lGpv9NiGvz44JFDrKdMvqJ6QCHz1lAxQISdPP25Jt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782036784; c=relaxed/simple;
	bh=DJFj2d4jetqATaqONn55FTHphGABMlPWtXjbD+9smpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+WKZIPV9FXF0WuFl8tjX1IWJbkyEP437CWJmj+xBLwmwKoLEaf1VIOpWsG6URVRmgYiJbtklWVlJANr9RtQ2X9NsFq//BImodvj8gT3cQZuxZzjKJHML04TSBwpSHjKXBuzDgWoSGownkEXgnQaayOppyvxk67d9d/a3ISruFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsyZ+1Ts; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8508F1F000E9;
	Sun, 21 Jun 2026 10:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782036783;
	bh=6XsKwg1GS9lT4/Q7bmwm9MowVi5d7q2SDPsQIWMoNaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SsyZ+1TsvgLflg0juXYCjcA3pH8vd+Y9MqLc0jYTOhxn+P6dy4eY5MVrVxb5LOEoG
	 RrsJ0srGqaRi77KiHkc+wrXh1Emat3ZrzazsysIAaCQMNMGheBK5y3Hia7XGDjeIwh
	 LpelPKZxXhh8Y2s446VszI2jLhTRwLl2n4aoLyozgo8nfNqijIIBJo83nfZDkhDjVn
	 zeV/f4D/0nNSdjN56lwbs/1HvvZ3/sR6vxbzEQ0DhZ/vS4thbxkh+Wd09+S0HmhHwJ
	 J68RbJ78ssT3222GKOLcajGNFfc3WxJv5d4ocntPrsfqRDltQ6MWCkBxIPIk+xpkfW
	 jKewonDrI7TBQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
In-Reply-To: <20260621093811.168514984@kernel.org>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.168514984@kernel.org>
Date: Sun, 21 Jun 2026 12:13:00 +0200
Message-ID: <87ik7cmcb7.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22737-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rostedt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,vger.kernel.org,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fw13:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 399406AA938

On Sun, Jun 21 2026 at 05:34, Steven Rostedt wrote:
> Instead of having trace_printk.h included in kernel.h, create a config
> TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> Makefile to allow developers to add trace_printk() without the need to add
> the include for it. Having it included in the Makefile keeps it from being
> in the dependency chain and it will not waste extra CPU cycles for those
> building the kernel without using trace_printk.

IOW, you make it worse just because.

With the header being separate I add the three trace_printk()s and the
include to the source file I'm investigating. The recompile will build
exactly this source file.

Having to enable the config knob will result in a full kernel rebuild
for no value.

Seriously?

Thanks,

        tglx



