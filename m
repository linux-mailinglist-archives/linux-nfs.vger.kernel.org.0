Return-Path: <linux-nfs+bounces-11954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0969AC6EF3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 19:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CE3A40731
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014E928DF04;
	Wed, 28 May 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2psMI5V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881428BA86;
	Wed, 28 May 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452445; cv=none; b=Lr4+2tLa3I0FhvQt+dlxAsrudMvTuz+SmNoh8fbbplU8SYawPjMqNqNsez9WH6wKy+ToD748P8oKl8HStjLUXiY0fWbrNi/Mf+B4VuwiLNBb8PXRjSorEeecIdOqcCgnQhKXbvlSaFOvhxSsTBUUTrhTtiKAjLRpyGSWKfsMbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452445; c=relaxed/simple;
	bh=ocKhl6406FUqTd+xR9E9Nvxe/6eEu2xfSUv2MHPhyPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tverhk0jtmDMTm8ll8PPb+PBblFhDnms9HsVwHNO8l41ogPgXnOM6c425D/lAqf9uEzE0CpCj9aT+rNqHL8rtzV7piteawC7YUpMofmqvEZJZ4HPPeGOnwAOqm81eeajgO+FbIBbb4ikm1K8S+ywi6u0uwLOfK3/n2Rbdh5Gi2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2psMI5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B54FC4CEED;
	Wed, 28 May 2025 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748452445;
	bh=ocKhl6406FUqTd+xR9E9Nvxe/6eEu2xfSUv2MHPhyPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2psMI5V+v8w0TEzP11kLazuh49V7KurmT7aPyo04bt4AfQ8+w207vq9SdbS8xtJf
	 3K3BkC1vsLKbrTDzdjFNbOvXg8zSQ/HV110cRaapiODzQwHmzEV2mmXucF5996ADLc
	 7OdrFYq3OFVGftaLFrHG7cxUaLJqXy2CjwNP5rwwLhMprVz3K15hnWVe42fvhwLxVS
	 RpOOdGGdw8d904ubjJ3tENpmj0a4SQ0ieKiBoJyQ3p2HHY81yf/7j8AFc7u06tBQva
	 4T/p/+c6K195IjgWEDHGWx5B84QMYR6JRLxttugFE8y4k+ggqP6Pw97ChjTdn7toUH
	 rKmc4Wt/SU7cw==
Date: Wed, 28 May 2025 18:13:58 +0100
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
Subject: Re: [PATCH 2/2] sunrpc: new tracepoints around svc thread wakeups
Message-ID: <20250528171358.GH1484967@horms.kernel.org>
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <20250527-rpc-numa-v1-2-fa1d98e9a900@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-rpc-numa-v1-2-fa1d98e9a900@kernel.org>

On Tue, May 27, 2025 at 08:12:48PM -0400, Jeff Layton wrote:
> Convert the svc_wake_up tracepoint into svc_pool_thread_event class.
> Have it also record the pool id, and add new tracepoints for when the
> thread is already running and for when there are no idle threads.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

...

> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index e7f9c295d13c03bf28a5eeec839fd85e24f5525f..de80d3683350dc86bee3413719797dcf7a4562e8 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -749,13 +749,16 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
>  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
>  		if (!task_is_running(rqstp->rq_task)) {
>  			wake_up_process(rqstp->rq_task);
> -			trace_svc_wake_up(rqstp->rq_task->pid);
> +			trace_svc_pool_thread_wake(pool, rqstp->rq_task->pid);
>  			percpu_counter_inc(&pool->sp_threads_woken);
> +		} else {
> +			trace_svc_pool_thread_running(pool, rqstp->rq_task->pid);
>  		}
>  		rcu_read_unlock();
>  		return;
>  	}
>  	rcu_read_unlock();

Hi Jeff,

Above, rqstp is conditionally initialised if ln
(pool->sp_idle_threads.first) is not NULL.
But below it is dereferenced unconditionally.
This does not seem consistent.

Reported by clang-20.1.4 builds and Smatch.

> +	trace_svc_pool_thread_noidle(pool, rqstp->rq_task->pid);
>  
>  }
>  EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
> 
> -- 
> 2.49.0
> 

