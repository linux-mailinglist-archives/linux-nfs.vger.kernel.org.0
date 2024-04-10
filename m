Return-Path: <linux-nfs+bounces-2741-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6489FBAA
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 17:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2370A1C2259B
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4776C16EC18;
	Wed, 10 Apr 2024 15:33:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F316EBE4;
	Wed, 10 Apr 2024 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763220; cv=none; b=UtQIH4EOPcWFxD7STJgNk3kITCA39X/7Mb/0BBUV5vKtnUzBzMfgWLZJq34PzZgXSAEYKv/eDSXHLKcCAJjbrR4cev93+Muy4BOnjoRttj1OYej6UhR2Tzn7f9AS/yF+t7aw35m6Kt1D0IUM6mkkVkSBTj870l/ImWG0Dsfv0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763220; c=relaxed/simple;
	bh=92ZRImfzi1uBmz5wPYU8Kbhx0TjrM28aNmBdmI8IclA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWv2xAQMoBUGG4DOEnd/bI3AF+K+3MlVZM+mjtNX6XSgx8Vtt5peScEBb/+dKvS7RkkGxNNl5plx3PO5yjrFanPf9GQjzMWuUrp3J+gfnGxywrSLuGQrWxZGcPo/fxwXspG7Hw6s9OB9GVFNpRb/FdpNB6dvrc4Eg56tnLbnwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9A4C433F1;
	Wed, 10 Apr 2024 15:33:37 +0000 (UTC)
Date: Wed, 10 Apr 2024 11:36:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] trace: events: cleanup deprecated strncpy uses
Message-ID: <20240410113614.39b61b0d@gandalf.local.home>
In-Reply-To: <20240401-strncpy-include-trace-events-mdio-h-v1-1-9cb5a4cda116@google.com>
References: <20240401-strncpy-include-trace-events-mdio-h-v1-1-9cb5a4cda116@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Apr 2024 23:48:52 +0000
Justin Stitt <justinstitt@google.com> wrote:

> diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
> index ba2d96a1bc2f..274c297f1b15 100644
> --- a/include/trace/events/rpcgss.h
> +++ b/include/trace/events/rpcgss.h
> @@ -618,7 +618,7 @@ TRACE_EVENT(rpcgss_context,
>  		__entry->timeout = timeout;
>  		__entry->window_size = window_size;
>  		__entry->len = len;
> -		strncpy(__get_str(acceptor), data, len);
> +		memcpy(__get_str(acceptor), data, len);
>  	),
>  
>  	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",

WTF, that code is just buggy. Looking at the rpcgss_context event we have:

> TRACE_EVENT(rpcgss_context,
>         TP_PROTO(
>                 u32 window_size,
>                 unsigned long expiry,
>                 unsigned long now,
>                 unsigned int timeout,
>                 unsigned int len,
>                 const u8 *data
>         ),
> 
>         TP_ARGS(window_size, expiry, now, timeout, len, data),
> 
>         TP_STRUCT__entry(
>                 __field(unsigned long, expiry)
>                 __field(unsigned long, now)
>                 __field(unsigned int, timeout)
>                 __field(u32, window_size)
>                 __field(int, len)
>                 __string(acceptor, data)

The __string() macro expects "data" to be a string and does *not* check
length when copying.

If anything, it needs to be:

		__string_len(acceptor, data, len)

as the macro code has changed recently, and the current code will crash!

>         ),
> 
>         TP_fast_assign(
>                 __entry->expiry = expiry;
>                 __entry->now = now;
>                 __entry->timeout = timeout;
>                 __entry->window_size = window_size;
>                 __entry->len = len;
>                 strncpy(__get_str(acceptor), data, len);

Then this needs to be:

		__assign_str(acceptor, data);

Note, the length is now saved via __string_len() and not needed here.

I'll go send a patch to fix this.

-- Steve


>         ),

