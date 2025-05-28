Return-Path: <linux-nfs+bounces-11953-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35030AC6EBF
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 19:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06088167862
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57AA28BAAD;
	Wed, 28 May 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is0I8ZDz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D5217F35;
	Wed, 28 May 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452033; cv=none; b=i1qlF5J07utTfUDwH+JX9a60K/0rVWDlDg/rh4FcAAKaf6qADlrZj8jxC27bK4H3g8UVBIP5cT6lDA1+eFqa5QXKM4iP2YKE4yAxZRw6cIfuAFwhAwXRroVrO/YV0IVffI+cU69rfEyM7MLPTte2k9D2e1bLm4vSS1lQVeAG8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452033; c=relaxed/simple;
	bh=t37yk+MnOZNVhzpxhZTfVy1pndiycr+ulkZxEYdPMZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmgxtuOhUI7+pJ/eaH/VvH/lHo9gDWbnitswXoTn1Blc1sjhxkKl8yjtEQpMfrXkclMZrqwgb9DKJIaHBSVmRyjJnBgMv7CMONZTurFbxJL4O+hDZJuX9KTBjQ3HkKkgfgOW6WPd89XdPSlrFy1NwGiGYGCVh5BpGHgXOy5HuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is0I8ZDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9AFC4CEE3;
	Wed, 28 May 2025 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748452033;
	bh=t37yk+MnOZNVhzpxhZTfVy1pndiycr+ulkZxEYdPMZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=is0I8ZDz85a7b7gIAoJ6yoIq/+Imay5aGk6o0z7cQ8iSpSHg+bIhl/5nm3mdHj4RQ
	 UVPUnUVxbNh7oxaKnA0knz3fg4dIgexwfTGxrrKhBonNlk0Huiq0gi7yYDAasyJNjv
	 CF3GWSbtpVZh7JfmDwQipA26tF1VlhBTDAVyTSX3aZ5fSokwP3rsx4aQ5Sy88gvFWE
	 GFEwUCcZbVqqk/sNvdFBYLwMdnuRuMoy6X0wyDqjhnEuEWoNxlZlGJsykN3v2VowiM
	 EOqmq0pJo8Keu/fpDaP5S3dsXjyhXqFHqde7RyqtQPrfV80mEFsgrKzdR60woaK006
	 yfAIMcp0i0ciQ==
Date: Wed, 28 May 2025 18:07:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
Message-ID: <20250528170705.GG1484967@horms.kernel.org>
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>

On Tue, May 27, 2025 at 08:12:47PM -0400, Jeff Layton wrote:
> The old nfsdfs interface for starting a server with multiple pools
> handles the special case of a single entry array passed down from
> userland by distributing the threads over every NUMA node.
> 
> The netlink control interface however constructs an array of length
> nfsd_nrpools() and fills any unprovided slots with 0's. This behavior
> defeats the special casing that the old interface relies on.
> 
> Change nfsd_nl_threads_set_doit() to pass down the array from userland
> as-is.
> 
> Fixes: 7f5c330b2620 ("nfsd: allow passing in array of thread counts via netlink")
> Reported-by: Mike Snitzer <snitzer@kernel.org>
> Closes: https://lore.kernel.org/linux-nfs/aDC-ftnzhJAlwqwh@kernel.org/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


