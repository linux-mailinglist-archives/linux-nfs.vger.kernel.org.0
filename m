Return-Path: <linux-nfs+bounces-1064-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048D982C613
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 21:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92F01F2398D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jan 2024 20:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0CD15AFE;
	Fri, 12 Jan 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btEuZUNQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6215EB2;
	Fri, 12 Jan 2024 20:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ABCC433C7;
	Fri, 12 Jan 2024 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705089688;
	bh=7uJMXaQV5alFCbUKlnhGLawxsYt6JRPXMzaCcU9fPJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=btEuZUNQy9RXXCnyQ7qE0OoT3ueMKlV3XaeGNnbtz4sjay+iRKa8mn3My3x3p8JOU
	 AdJGRkctwTI9ctAIQ0wm5uUXq03eN9Wt2prvIY7dleAnyGAedwjxfRSXAr51do4t7i
	 y8aOGiW9Wd7ttbDRVlrnpymNL0YN0F9CJaoaruL2XJrqwUYpEyKAcikexVbxffkzWR
	 sLvTV3ICYL6yyACwGJAKxAWsfF9jQI0TKoQu0QgUi0XNzCIwkIfGo4f7iWxBhlEwJO
	 TVgWX56t+Q9TSZ+Xq142LIS01secEzr4KNEIcWPzO+JUSoOAGDOxZT1wl69AO8h6oV
	 Rj6U7C36DDKSA==
Date: Fri, 12 Jan 2024 12:01:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Zhipeng Lu <alexious@zju.edu.cn>, Jeff Layton <jlayton@kernel.org>, Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simo Sorce <simo@redhat.com>, Steve Dickson
 <steved@redhat.com>, Kevin Coffman <kwc@citi.umich.edu>, Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>, "open list:NETWORKING [GENERAL]"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] SUNRPC: fix a memleak in gss_import_v2_context
Message-ID: <20240112120127.5eee94f2@kernel.org>
In-Reply-To: <824EC6A8-24EA-4998-B1CB-8E54FBB51129@oracle.com>
References: <20240112084540.3729001-1-alexious@zju.edu.cn>
	<20240112112454.0840bcf3@kernel.org>
	<824EC6A8-24EA-4998-B1CB-8E54FBB51129@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 19:27:40 +0000 Chuck Lever III wrote:
> > cocci says:
> > 
> > net/sunrpc/auth_gss/gss_krb5_mech.c:458:2-3: Unneeded semicolon  
> 
> I planned to take this patch via NFSD's "for v6.9" branch.
> I can remove that semicolon. Thanks!

Sorry for the lack of clarity, I wasn't intending to take it.
The patch did get into our checking machinery and the warning 
was reported, so I figured why not say so on the list.
I'll mention the intentions more clearly next time!

