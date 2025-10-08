Return-Path: <linux-nfs+bounces-15066-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C9DBC67F5
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 21:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C225440478F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 19:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EA320487E;
	Wed,  8 Oct 2025 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFcI9Wzu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4F1A9FA4;
	Wed,  8 Oct 2025 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759952749; cv=none; b=PdsuVrCLWSEpkQTgfO8WFasK5qwPRaCPlXM7jXwlXfr+SUKTvj8Rj7P1q12z6LX6k1As0W821OyrPJE2LntjUXOoKLQLcvAsysXjDrAQz5qhhKyDwyKqK967dOOj/6VIFs7uDjgobCezffNHAhRR2Aib5gMc7+KbeJ+gl2V2KaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759952749; c=relaxed/simple;
	bh=Xdtz7UuIQp8hqA4r1Ku8EK1lvXw0MF7m6FcAEN60ZKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAHG037smeeVQdsfTq59QDoESWI+T3wRGWL+FB3TBRuFFG3NUptI1YbKdVn6pg9usz6sSrKqClsNvGL6lPKtfWwJmo2+wxJQzxUVp1mWzIBDFic5lpYwVhJAwbawTkPMwPq56ZwI5rjVqDxncP/3y7rjBqtCd2FhnBdCormv3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFcI9Wzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51C3C4CEE7;
	Wed,  8 Oct 2025 19:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759952748;
	bh=Xdtz7UuIQp8hqA4r1Ku8EK1lvXw0MF7m6FcAEN60ZKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFcI9WzuhFQwl3zDkUONfUG5G6nMgHmHSHkxNHw6I8NHreBCZsN3MF8/1XimCv7ho
	 nq9PMuwIqQD9qiy3s8cp84s53pg106JHg7PJ2nPktUY/Yon+pNwr3V/fGOpCzypyR8
	 DjEvGlOW+U7oDeGuKrgO9WfTtK7uI4OR6E1Zi+blxD8MKFBd1FkGL6Wm6Te3GW64xP
	 FaaI8wze+DhgQ1Pp46tn0JpP0Xdx7T5fLceZX2hhoGc3vFEN8DTQs9WNMasHiNZNOo
	 G48JlVJXYUfIcPbexxT4h5ntNW3i+C8uh1qaHlRai354G5Q9fPCj5MryoQcq4Qw/yV
	 HrQ/DnHSCReJg==
Date: Wed, 8 Oct 2025 15:45:47 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sunrpc: fix handling of rq_bvec array in svc_rqst
Message-ID: <aOa_a2w6KrG973YS@kernel.org>
References: <20251008-rq_bvec-v1-0-7f23d32d75e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-rq_bvec-v1-0-7f23d32d75e5@kernel.org>

On Wed, Oct 08, 2025 at 02:58:51PM -0400, Jeff Layton wrote:
> I've seen this message pop intermittently on some knfsd servers:
> 
>     rpc-srv/tcp: nfsd: sent 1045870 when sending 1045868 bytes - shutting down socket
> 

This ^ looks like useful info to include in the associated commit
header.

