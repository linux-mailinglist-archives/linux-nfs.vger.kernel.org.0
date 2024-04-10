Return-Path: <linux-nfs+bounces-2743-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF33E89FC06
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D198B281A3
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF0F16F0F7;
	Wed, 10 Apr 2024 15:53:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97781156C67;
	Wed, 10 Apr 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764422; cv=none; b=X7MjGwJ3nW87M/fh0Iu7JnpcCedf1kOUKN6z0W2qEOpGJqHiKIwvNS0yi5suUC3d0qAzaCoIju7RpYjhwPf3XfRNaHMj8cwPlj3YWku6zbgzhAWMU3SRs8s6wSYIn3MZDbpTB16b47yfM0ubgWHMzec5QB9eOajroCxCmJZxqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764422; c=relaxed/simple;
	bh=Yj2mjB7xGY/t85UZ8jq4NsVg3CMycDTWl975T4rbgkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwmWoZmQFVDAGO02ysKpSCNcLuR3WNGqdqZ3QCAKXEIK+iFbbAtW4fUYGwJ1ejXV+jPXX6qxgWqJComEEoe0hp2a324sv9lsqxsaiAFZgk6NWBTWIRMskoAw6aI+DpRK7Ng2l/jebs/LFKffHHXV+L044vfxFo8cSlcwvx6ONis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E3CC433F1;
	Wed, 10 Apr 2024 15:53:40 +0000 (UTC)
Date: Wed, 10 Apr 2024 11:56:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Jeff Layton
 <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] trace: events: cleanup deprecated strncpy uses
Message-ID: <20240410115617.14804133@gandalf.local.home>
In-Reply-To: <ZhazHrz4SxBs+BFD@tissot.1015granger.net>
References: <20240401-strncpy-include-trace-events-mdio-h-v1-1-9cb5a4cda116@google.com>
	<20240410113614.39b61b0d@gandalf.local.home>
	<ZhazHrz4SxBs+BFD@tissot.1015granger.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 11:41:18 -0400
Chuck Lever <chuck.lever@oracle.com> wrote:

> > If anything, it needs to be:
> > 
> > 		__string_len(acceptor, data, len)
> > 
> > as the macro code has changed recently, and the current code will crash!  
> 
> A general question:
> 
> Is there a test suite we should run regularly to build some
> confidence in the kernel's observability apparatus? We're building
> a menagerie of tests around kdevops, and one area where we know
> there is a testing gap is the tracepoints in NFSD and SunRPC.

I try to add self tests within the macros. As __assign_str() is going to
turn into just __assign_str(field) (instead of __assign_str(field, src)), I
added a test to make sure what was passed to __string() is also what
__assign_str() gets. But using strcpy() in place of __assign_str() really
is doing something that one should not be doing.

There's checks in the tracepoint code as well for things like referencing a
pointer that was not saved in the event, and other things. But a generic
test on a custom trace event, I don't really have.

Note, you could enable CONFIG_TRACE_EVENT_INJECT where an "inject" file is
created, and you can write into it:

 # cd /sys/kernel/tracing
 # echo 1 > events/rpcgss/rpcgss_context/enable
 # echo 'expiry=123456 now=222' > events/rpcgss/rpcgss_context/inject
 # cat trace
bash-843     [001] .....   720.083189: rpcgss_context: win_size=0 expiry=123456 now=222 timeout=0 acceptor=

And you could use that for testing.

-- Steve

