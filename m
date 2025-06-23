Return-Path: <linux-nfs+bounces-12672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5EAE45A7
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 15:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A307E3B8D2A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415AF2517AF;
	Mon, 23 Jun 2025 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc/4jh09"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452E19CD17;
	Mon, 23 Jun 2025 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686582; cv=none; b=m5iO1EofaBPgEQZCCwMR1N+PlbE1Oz2NGGrNoEHD4O5wddOg9ER+8YzxDHzYBynpdsy4BOXggu/utfQDcZcee0al7T7Qf+fAI0Wo1PFVG+Mysm/ZI2n7qmeIKUBQ9c/hZ8MsS+ZGIHvuZA2cp2Gv0T2Di2zXfimvoQ6wlx6yG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686582; c=relaxed/simple;
	bh=j3FUL7lAGubA/HiHlIi3dlPR2ex594MgXDFSkKeKxLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSJwTa4jtRrgNMTcWD6lEDbf8Vnn/bCsu3jF6p9rkKX9e6qVHMVxec6++jq6IHJsFreVKOmkZnxaVaOPFWQ+ntDh9h1Ef+6uTIg8PHZ8lp5Zsmt0UAHajtQhnbwqVtCHTjOP6w5b6RjIWFYGnjR45p54c6BlIIRrQBwsTvfXtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc/4jh09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE467C4CEEA;
	Mon, 23 Jun 2025 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750686581;
	bh=j3FUL7lAGubA/HiHlIi3dlPR2ex594MgXDFSkKeKxLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gc/4jh092TuZDjEOdjKCJzqNBzvJHxLt3fYKffhYkTjoHqn5kX6uyxq7WZcfOgZ1i
	 uKc2BUstYEtbOzv+H72jSZnFNcmwlVR5WD+eiwGz2wEUz+ZJRxfsDtykCAUvjiwnkM
	 MIy2TEODm/Q4XTSHTEG89WMLyRfLflk6wGHc/8zXRnTqBnACzX0uN4Tvn+K+NyZhcQ
	 a8RdAce4pRVG5mrvql43yfohjKQ1wTG1sK/F3nlRblYTZj90AzQdhdh6MnbLotS8Mx
	 qWxQvI6ojMFZaf119Da6krwmhgJ4ai3f0nBfd6k0zr6pR/7630ehKo8PCIGbZi8w1a
	 BTSKo7ecxmjOg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] sunrpc: patches and cleanups for v6.17
Date: Mon, 23 Jun 2025 09:49:34 -0400
Message-ID: <175068655499.1133652.7806743483169461253.b4-ty@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
References: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 20 Jun 2025 08:16:00 -0400, Jeff Layton wrote:
> The first 3 are directly related to the svc_process_common() patch I
> sent yesterday. They're just further cleanups and fixes to that
> codepath. The other two are random sunrpc patches I've been carrying for
> a while.
> 
> 

Applied to nfsd-testing, thanks!

[1/6] sunrpc: fix handling of unknown auth status codes
      commit: 0df827f0bd0529b4abd4f6c593f0416c8777df11
[2/6] sunrpc: remove SVC_SYSERR
      commit: 59d160a8f609674a51e7d90afbed8cb88534b962
[3/6] sunrpc: reset rq_accept_statp when starting a new RPC
      commit: 1e52e9a78dba2abf7c01b68c534d9ca22e9a1de7
[4/6] sunrpc: return better error in svcauth_gss_accept() on alloc failure
      commit: fedc609d9422e2b35e1a5af40b6ae134d6e4cc97
[5/6] sunrpc: rearrange struct svc_rqst for fewer cachelines
      commit: 32eb3ea18747600ebb2133ec167f6c56e71977be
[6/6] sunrpc: make svc_tcp_sendmsg() take a signed sentp pointer
      commit: 71d5b98c95c393e53a9cddac4e1c0f7a10ee92b2

--
Chuck Lever


