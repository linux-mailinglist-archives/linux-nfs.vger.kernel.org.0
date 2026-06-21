Return-Path: <linux-nfs+bounces-22742-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8LKFC1/iN2rUVAcAu9opvQ
	(envelope-from <linux-nfs+bounces-22742-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 15:08:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A156AAD92
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 15:08:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nfEhSIE7;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22742-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22742-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97290300E25E
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jun 2026 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B1367283;
	Sun, 21 Jun 2026 13:08:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6236655B
	for <linux-nfs@vger.kernel.org>; Sun, 21 Jun 2026 13:08:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782047320; cv=none; b=nnWZXkAe6PUM0fifSARm3XvHKXTKTe9mWfq4eKqefXCmOXMKuaeqpONyjStBOZM7B03Y70AM5QaW+wbh3amPrElulXRvmIB+CzoIO4bcN7NxcZttd2TmWxvEjq0fSJyK4AM+YD7IgkvOO0Ijx+gfrxw11Tpn3nn9X6vLEzfJ1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782047320; c=relaxed/simple;
	bh=me33Az45dCRutFUzQ4N1c3MdvdJrDzsOWQ4IrxhWNMc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQMDQsM/P0S5ptjj6g7tatl2JQ+RMCb04oxPv/GlM0LnAPPIwLR+/2CcsFK9lEn/xNf4H5Eg8XbtXgw9xtfj3nn3C6Bui+JpKkcnfeyKMPdjr1nxeLNpO5VtI64UjMx50RgLUxsOhYKDysxRwSmXY8vVstTyfvO+pXWyH1HQlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfEhSIE7; arc=none smtp.client-ip=209.85.128.180
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8000e21f014so34813697b3.2
        for <linux-nfs@vger.kernel.org>; Sun, 21 Jun 2026 06:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782047318; x=1782652118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JelQF+PgdiILboeOL52+qm2l/XNW/EjjD3ktKV3cKe4=;
        b=nfEhSIE74z/mf/Z0c5mBSac7i23tgbFrZildwk1bx4AMBh+Zvd6dgn1udde+l8ZPPt
         0/2MSos+4QuEn79HqB7TNx+LupVlYAuHYCQso+l8Qu24O0nCvNIjadYhVuzQNhGZuGat
         +imEhhVfRs9k0rJXxvPzJSID5NjBzk6jzcCjfaQVfidNvLI159z3cgw76JnCvUU6svHi
         o1dWoJaO+ZxaW9xedadD57tLyWjTqjFUTrYt0Z66hkoiPVP+32DBA/zOqd5NzPx4Qo+F
         elQdARSkMiZK16gZd19EcX5w0Mu5Uesp5bySYww6zgBY9BTejYSEeYeX8mhHvewdew2h
         YP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782047318; x=1782652118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JelQF+PgdiILboeOL52+qm2l/XNW/EjjD3ktKV3cKe4=;
        b=pQiVktCvLYydUf4Tp9spHqLBObSSeTXVZ3THqv2WEualoppAoQAacfPlqjHBioLu3J
         gm8T4eeQcEuT1ZBG5fZk5/MtwvE0BZEFKW3LK4cPtXfn0KVmUqmNYEiWYMKOh7bdbrH7
         QyNE3pt43mlnrGO5aWZ4nJEBCvxWcR8uSEdkj7AnlCvHj6j8D8TcYs8/jWKGphkL87kB
         qSa8fo8vR17l4d9TYXsNfQ2Zf8D4OosRJTDCGDADyG1DhCVxYWQZKOXJOFcovFIt5ZRG
         BoWmePg+lIVo+Wdbg2XoVKKf9yszPd712z/P9zmp0Tc/BCaz12YIdPn3hU4hqWxTnbKZ
         685A==
X-Forwarded-Encrypted: i=1; AHgh+RpfMRJVnioRBaVZckfrtDXZa8y+oC9ZIxGilMm7G5bbrgIQrNWxUb+VnWJC+Q4An7G7AtjFqo4K6g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNpG1ifakpe2vOIOGdLjH6pr573AbrLMyu/s72TOPYkzne0qSw
	Al3en/zXOtLj03KNbjWGJjrFITuT2G8PbMiac0ugozi4b56qMVpAhVSC
X-Gm-Gg: AfdE7cn9KEl2cAUvAAyZ6J7u04HRR7qVd4Q2gxi9L+lrOEv3hGGJ4JoQGcUeJV2ca7l
	rjkMaTtnEK8jfK9H9rijggQkjN7e8EBcXCtwd6zzF0oTS3IPpY/LBba7rp88hbX8R5Rx/WoS5Ep
	/yepuH4afkEA/Uffr5K7SS8qmloW2hkh4BpP/h88/chDvpcXtCVT93YQiXiAKCyzK8rQnVw8hZV
	w18ucUkuTcxmjM4mxBI5074tlBnbIS7vAxIgnUa7fsefjx34dsqdlRbUckg+ir/K6CegzmOdIvh
	0IMkXZqcrWac1IzomGrKYDkSRo18fwPANCOGz7VUkDrRCto9oJfVO+uwlev8ddEOMuQkPTHeWW3
	hRt5JFaV0fCeBV3i2B5lTjexpDagk/AzUtALiUMzZniZcwdwAx0vnbWt4Lz7e58fSmIHw2rS37a
	lo6jlDBUI70Guke2KeNU6FYwyw2nyIG87cm4E=
X-Received: by 2002:a05:690c:6881:b0:7fd:5297:28da with SMTP id 00721157ae682-80139103c73mr119142517b3.49.1782047317965;
        Sun, 21 Jun 2026 06:08:37 -0700 (PDT)
Received: from localhost (user-24-214-85-55.knology.net. [24.214.85.55])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf693f8sm20544597b3.15.2026.06.21.06.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:08:37 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sun, 21 Jun 2026 09:08:37 -0400
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] tracing: Move non-trace_printk prototypes back to
 kernel.h
Message-ID: <ajfiVTlCIVlqW3sh@yury>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.007634476@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621093811.007634476@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22742-lists,linux-nfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[yurynorov@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:rostedt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurynorov@gmail.com,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,yury:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1A156AAD92

On Sun, Jun 21, 2026 at 05:34:31AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In order to remove the include to trace_printk.h from kernel.h the tracing
> control prototypes need to be moved back into kernel.h. That's because

Please don't. Instead, you can split them out to trace_control.h, and
include where needed. I actually have a prototype for it, FYI:

https://github.com/norov/linux/tree/trace_pritk3

> they are used in other common header files like rcu.h. There's no point in
> removing trace_printk.h from kernel.h if it just gets added back to other
> common headers.
> 
> Prototypes are very cheap for the compiler and should not be an issue.

It's not about cost, it's about mess. kernel.h is included everywhere.
Is that API needed everywhere? No, it's needed in literally 10 files.
So, no place in kernel.h.
 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  include/linux/kernel.h       | 18 ++++++++++++++++++
>  include/linux/trace_printk.h | 17 -----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index e5570a16cbb1..c3c68128827c 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -194,4 +194,22 @@ extern enum system_states system_state;
>  # define REBUILD_DUE_TO_DYNAMIC_FTRACE
>  #endif
>  
> +#ifdef CONFIG_TRACING
> +void tracing_on(void);
> +void tracing_off(void);
> +int tracing_is_on(void);
> +void tracing_snapshot(void);
> +void tracing_snapshot_alloc(void);
> +void tracing_start(void);
> +void tracing_stop(void);
> +#else
> +static inline void tracing_start(void) { }
> +static inline void tracing_stop(void) { }
> +static inline void tracing_on(void) { }
> +static inline void tracing_off(void) { }
> +static inline int tracing_is_on(void) { return 0; }
> +static inline void tracing_snapshot(void) { }
> +static inline void tracing_snapshot_alloc(void) { }
> +#endif
> +
>  #endif
> diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> index 3d54f440dccf..879fed0805fd 100644
> --- a/include/linux/trace_printk.h
> +++ b/include/linux/trace_printk.h
> @@ -35,15 +35,6 @@ enum ftrace_dump_mode {
>  };
>  
>  #ifdef CONFIG_TRACING
> -void tracing_on(void);
> -void tracing_off(void);
> -int tracing_is_on(void);
> -void tracing_snapshot(void);
> -void tracing_snapshot_alloc(void);
> -
> -extern void tracing_start(void);
> -extern void tracing_stop(void);
> -
>  static inline __printf(1, 2)
>  void ____trace_printk_check_format(const char *fmt, ...)
>  {
> @@ -176,16 +167,8 @@ __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
>  
>  extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
>  #else
> -static inline void tracing_start(void) { }
> -static inline void tracing_stop(void) { }
>  static inline void trace_dump_stack(int skip) { }
>  
> -static inline void tracing_on(void) { }
> -static inline void tracing_off(void) { }
> -static inline int tracing_is_on(void) { return 0; }
> -static inline void tracing_snapshot(void) { }
> -static inline void tracing_snapshot_alloc(void) { }
> -
>  static inline __printf(1, 2)
>  int trace_printk(const char *fmt, ...)
>  {
> -- 
> 2.53.0
> 

