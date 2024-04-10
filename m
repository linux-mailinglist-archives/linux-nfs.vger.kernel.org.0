Return-Path: <linux-nfs+bounces-2750-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0489FF30
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 19:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F63284398
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3D17F390;
	Wed, 10 Apr 2024 17:54:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FA168DC;
	Wed, 10 Apr 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771696; cv=none; b=G9GW4Em+DA7sIOI9vloBTwyYnQUOfXeff2rNLD6ehLQhnfbX+Z8GHMDTPnVKl7506bcOGuKICAQthSN295WbnkEp9DMv2kDLL9XGVVJO0PwdLRK2qrw7Rs5wAp/1lJ6UauzAOhS42oHedmqd6jqVIFMY16HaTKfOZm5uFYyL2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771696; c=relaxed/simple;
	bh=zTTUqwGIIpiNlag6dinC3dy18sCPxzH7sZQE54yYV28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+6aEYlbGUl0lML7c4wR4913PIGhAMDKZOLQGCr4lSTv6eHykdpGmfIQ32p2wzebzcMgmZV3iR1LuxMTIX2nKRwNYIMowXk0uMq+6lJ0/vCz2/8PNzI0rxjPWoYZAvCTRQHwtOkPABOYEd8YCUCo1mdGudTuMK7GxpN7DI6jmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A80BC43390;
	Wed, 10 Apr 2024 17:54:54 +0000 (UTC)
Date: Wed, 10 Apr 2024 13:57:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jeff Layton <jlayton@kernel.org>, Anna Schumaker
 <Anna.Schumaker@netapp.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix rpcgss_context trace event acceptor field
Message-ID: <20240410135731.5da54a09@gandalf.local.home>
In-Reply-To: <ZhbHSFsPQAP1pfQQ@tissot.1015granger.net>
References: <20240410123813.2b109227@gandalf.local.home>
	<ZhbAndktED4NsANF@tissot.1015granger.net>
	<20240410130741.40ebeda4@gandalf.local.home>
	<ZhbHSFsPQAP1pfQQ@tissot.1015granger.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 13:07:20 -0400
Chuck Lever <chuck.lever@oracle.com> wrote:

> Well I guess I could test it for you. I'll take it for nfsd v6.9-rc.

Thanks!

-- Steve

