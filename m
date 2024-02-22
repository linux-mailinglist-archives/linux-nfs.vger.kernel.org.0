Return-Path: <linux-nfs+bounces-2054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB788601A1
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 19:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0B9B26154
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 18:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25F140384;
	Thu, 22 Feb 2024 18:30:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC0140377;
	Thu, 22 Feb 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626603; cv=none; b=jSIAetVkdBnRU24eKKPpG9TzrismM2Fq/9ritCi7MIVnve9SKAl8ZpvUp500o/0TByj8MXC3t7HSJ3HWBCP6/cNOYUaTvrBx9dUMcV53cZh8+U/an01f6dBDBBXdaBZtuqSHb2Ff0ZDc4ED+33BzPVN6mzYbfWL7OLftje+9piU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626603; c=relaxed/simple;
	bh=Npnj8evtP1IDJMxVpAu3m1ovc7BdIp5IIXBqQcwayR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZurJ8YnUDgCZC5vIuVtGshWXynOYlJcKZ5t8Fh2s6cgVNAZJeIJUxhEG4p8LDEtbNVTCAK/ICQgC2wy7dltTcE6EKxjvS5CH97O3jiaaJjVw1wsW2hBS4EZgvl8VfVDvRAogjPC+QMMambvtrJrgKSrL0rwBx2o40I6sfPK03Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3EBC433F1;
	Thu, 22 Feb 2024 18:30:02 +0000 (UTC)
Date: Thu, 22 Feb 2024 13:31:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-nfs@vger.kernel.org, Jeff
 Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Subject: Re: [PATCH] NFSD: Fix nfsd_clid_class use of __string_len() macro
Message-ID: <20240222133153.39260aa9@gandalf.local.home>
In-Reply-To: <ZdeRnhXLhlXN4AqE@manet.1015granger.net>
References: <20240222122828.3d8d213c@gandalf.local.home>
	<ZdeRnhXLhlXN4AqE@manet.1015granger.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 13:25:34 -0500
Chuck Lever <chuck.lever@oracle.com> wrote:


> Do you want me to take this through the nfsd tree, or would you like
> an Ack from me so you can handle it as part of your clean up? Just
> in case:
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 

As my patches depend on this, I can take it with your ack.

Thanks!

-- Steve

