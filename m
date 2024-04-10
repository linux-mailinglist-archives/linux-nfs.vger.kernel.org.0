Return-Path: <linux-nfs+bounces-2747-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD1389FDB7
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D9428A40F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357317BB09;
	Wed, 10 Apr 2024 17:05:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0317B4EB;
	Wed, 10 Apr 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768705; cv=none; b=VVUk9d2Zbv6EAwpVFmh27MZDULNs9dXyGgini1zVdO27l9qJjk/6v+5U6BIg+sDhUM1SPucZpwUSdoW7/3kVxBupcnvB2GEOQxpGGMblcmw0nr0k+LK5N+d/JU04CrX8zTS3VjTQyLP3bNrDDppGiFVj4mvE+Ho4mpxGpk1QFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768705; c=relaxed/simple;
	bh=uRbYkqygWX+qn1hlquG6FXFaBwSgfF2EWdt5hJTpGgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0zQNQ3bDwlz9fRejo6lpggXrcWL6XEgNr9msXVBCYQRZHj8Egtx/Ow577Ykl73a0yVI/8ME4YWnygHAQTiTskpxCWur+lXpfg9D11CY0pDqK6Q+5jtc9w2hEO6fOVxTSTb+pbjz+0zLXVSBr+OsW6Lvh7KmUc5n4xAIQIJ29wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29294C433C7;
	Wed, 10 Apr 2024 17:05:04 +0000 (UTC)
Date: Wed, 10 Apr 2024 13:07:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jeff Layton <jlayton@kernel.org>, Anna Schumaker
 <Anna.Schumaker@netapp.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix rpcgss_context trace event acceptor field
Message-ID: <20240410130741.40ebeda4@gandalf.local.home>
In-Reply-To: <ZhbAndktED4NsANF@tissot.1015granger.net>
References: <20240410123813.2b109227@gandalf.local.home>
	<ZhbAndktED4NsANF@tissot.1015granger.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 12:38:53 -0400
Chuck Lever <chuck.lever@oracle.com> wrote:

> On Wed, Apr 10, 2024 at 12:38:13PM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The rpcgss_context trace event acceptor field is a dynamically sized
> > string that records the "data" parameter. But this parameter is also
> > dependent on the "len" field to determine the size of the data.
> > 
> > It needs to use __string_len() helper macro where the length can be passed
> > in. It also incorrectly uses strncpy() to save it instead of
> > __assign_str(). As these macros can change, it is not wise to open code
> > them in trace events.
> > 
> > As of commit c759e609030c ("tracing: Remove __assign_str_len()"),
> > __assign_str() can be used for both __string() and __string_len() fields.
> > Before that commit, __assign_str_len() is required to be used. This needs
> > to be noted for backporting. (In actuality, commit c1fa617caeb0 ("tracing:
> > Rework __assign_str() and __string() to not duplicate getting the string")
> > is the commit that makes __string_str_len() obsolete).
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 0c77668ddb4e7 ("SUNRPC: Introduce trace points in rpc_auth_gss.ko")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 

Thanks, but feel free to take it if you want. Unless you rather have me
take it through my tree?

-- Steve

