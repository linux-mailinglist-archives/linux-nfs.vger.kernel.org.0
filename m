Return-Path: <linux-nfs+bounces-1084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C92C82D81E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jan 2024 12:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023E41F222C4
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jan 2024 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222642C683;
	Mon, 15 Jan 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIxX8Hd5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A042BB06;
	Mon, 15 Jan 2024 11:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EDEC433C7;
	Mon, 15 Jan 2024 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705316951;
	bh=u5h2QQBP6fhgiKwHjsHHAv7nLPOgzXKmoQfDD5Bd5Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIxX8Hd5rBfP0r5teoC/V9pf4fzdq1XLqNdrl71NceoOqWpFHJAjRLmIPEdW3+kkN
	 EnP5GzQYBMRQWvhU8a9N0RR8oXnsdF5ySK3JbNcPy9gjIb+ogxD/E9mwT44Oms/b5c
	 +EZ5tyhBRvanH4yFfKXN6NCIUl+Oc+agV6Iw7G9HwC7lxWAyJp4hgG5S8EE5wWGDdo
	 o3bf7StzVZcQcUzYX3qMaD7UUWrIz1PVavZDcuFlGaw/xVcgYf5ZiZyiiQkYJtDj3M
	 G2kRomH8XW/tjz/3ZCvzwpXqNMCwGb2DXXKfY5ChqTjPrNviNvHH0ZvToTC3oSuRkz
	 aGd1z/6cZdvBg==
Date: Mon, 15 Jan 2024 11:09:05 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simo Sorce <simo@redhat.com>, Steve Dickson <steved@redhat.com>,
	Kevin Coffman <kwc@citi.umich.edu>, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] SUNRPC: fix a memleak in gss_import_v2_context
Message-ID: <20240115110905.GR392144@kernel.org>
References: <20240112084540.3729001-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112084540.3729001-1-alexious@zju.edu.cn>

On Fri, Jan 12, 2024 at 04:45:38PM +0800, Zhipeng Lu wrote:
> The ctx->mech_used.data allocated by kmemdup is not freed in neither
> gss_import_v2_context nor it only caller radeon_driver_open_kms.

Should radeon_driver_open_kms be gss_krb5_import_sec_context?

Also, perhaps it is useful to write something like this:

... gss_krb5_import_sec_context, which frees ctx on error.

> Thus, this patch reform the last call of gss_import_v2_context to the
> gss_krb5_import_ctx_v2, preventing the memleak while keepping the return
> formation.
> 
> Fixes: 47d848077629 ("gss_krb5: handle new context format from gssd")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Hi Zhipeng Lu,

Other than the comment above, I agree with your analysis.
And that although the problem has changed form slightly,
it was originally introduced by the cited commit.
I also agree that your fix.

...

