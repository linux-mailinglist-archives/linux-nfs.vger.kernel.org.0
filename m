Return-Path: <linux-nfs+bounces-16089-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A51C377B6
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 20:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B7784E0FFB
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 19:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3862686A0;
	Wed,  5 Nov 2025 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojH/Lm5o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C452264B1
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371065; cv=none; b=lkFQFPA4UJKcpX1Yo4bjqDc37a6FNi0YDosqHig5JmeXzv9ER/OEdLafOBa3e29fr1r+ddj+iss5g9oWAzT2VaDdnQpwZCHTE7ZpMcK7mH5Y3hjtU2jKdDQyYQNvUFvpDjx1jqE0SRyjIu0hA11F8HMlj3mH5X4thvhGu4UjAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371065; c=relaxed/simple;
	bh=nx+QDVxDIn03Hi95j48zKJ3fiyMsbmmx266B7vAjrfc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qqc+7OnNtgcr2RB2fjPGw95/85Gr/3co19dh0LRBlYjqGxK07MBubM2hvxtQ/VBHtpO+YfmAENPofQe+jhbamsG4Gp1Kn+wZH4ONZstWo6DR4vx2pjLGue5JFO3ghTcmftBb7fKeVm0YMt2fmoaW0q/UiFM9YR3jVdCexKWTIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojH/Lm5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF798C4CEF5;
	Wed,  5 Nov 2025 19:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762371065;
	bh=nx+QDVxDIn03Hi95j48zKJ3fiyMsbmmx266B7vAjrfc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ojH/Lm5o4aliTENmFo0cTWQVU+VcXGAlprpgdVNWfSxiRR/jSSrjFCKgc92qpaznl
	 1ZEb8CxLRpwVOSFJIXi408t+Hu/89ezgJNsfHriLp5V6a6GRY1fy4EJ31aGM9Qy8Um
	 TP4gacHC2GMrQ81mujb1ktQmqJNlkOjnXnEoety2KQWhZhMg5tqhJEjvTN2a/cLxFM
	 IhzGXTJYDGmP9esbvCQl+hR5bOAlhoWIn8pIABThjhVPVXi6dTxL3QJfo4cE2bx3Ab
	 jIHSRds66jomLRyedhVEocyV+malop719VfRaQX/k7pJLew4j/ugXOgFh8nhvZfoTB
	 WQIIGA1pON1AQ==
Message-ID: <80bd00e7-8728-4468-b7b5-287c7bd7c56b@kernel.org>
Date: Wed, 5 Nov 2025 14:31:03 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/5] NFSD: don't start nfsd if sv_permsocks is empty
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-2-cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20251105192806.77093-2-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 2:28 PM, Chuck Lever wrote:
> From: Olga Kornievskaia <okorniev@redhat.com>
> 
> Previously, while trying to create a server instance, if no
> listening sockets were present then default parameter udp
> and tcp listeners were created. It's unclear what purpose
> was of starting these listeners were and how this could have
> been triggered by the userland setup. This patch proposed
> to ensure the reverse that we never end in a situation where
> no listener sockets are created and we are trying to create
> nfsd threads.
> 
> The problem it solves is: when nfs.conf only has tcp=n (and
> nothing else for the choice of transports), nfsdctl would
> still start the server and create udp and tcp listeners.
> 
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> Reviewed-by: NeilBrown <neil@brown.name>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfssvc.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 7057ddd7a0a8..b08ae85d53ef 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -249,27 +249,6 @@ int nfsd_nrthreads(struct net *net)
>  	return rv;
>  }
>  
> -static int nfsd_init_socks(struct net *net, const struct cred *cred)
> -{
> -	int error;
> -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> -
> -	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
> -		return 0;
> -
> -	error = svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
> -				SVC_SOCK_DEFAULTS, cred);
> -	if (error < 0)
> -		return error;
> -
> -	error = svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
> -				SVC_SOCK_DEFAULTS, cred);
> -	if (error < 0)
> -		return error;
> -
> -	return 0;
> -}
> -
>  static int nfsd_users = 0;
>  
>  static int nfsd_startup_generic(void)
> @@ -377,9 +356,12 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
>  	ret = nfsd_startup_generic();
>  	if (ret)
>  		return ret;
> -	ret = nfsd_init_socks(net, cred);
> -	if (ret)
> +
> +	if (list_empty(&nn->nfsd_serv->sv_permsocks)) {
> +		pr_warn("NFSD: Failed to start, no listeners configured.\n");
> +		ret = -EIO;
>  		goto out_socks;
> +	}
>  
>  	if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
>  		ret = lockd_up(net, cred);

Ignore this one. It's already applied.

-- 
Chuck Lever


