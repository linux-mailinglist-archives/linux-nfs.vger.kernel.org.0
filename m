Return-Path: <linux-nfs+bounces-20043-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAilEEN6sWk2vgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20043-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 15:20:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F05265530
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45FC3301287B
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C058436DA13;
	Wed, 11 Mar 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/b/iXz9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D53D36CDE2;
	Wed, 11 Mar 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238848; cv=none; b=Rr/IdnQUe8IfQVgb5EJ8GqJ8Qx09hb6JyDpBm0LzCHWlrBny3fYZcPO1SiTiJRNPMwJBzj/tfTZ1lWCWKaDaMHWbIeW+d7cGGF2wIaVexHc8ssOift3bQK5a2/ZSIOl70/Ezb7m3A4/22BVxEC3wUty+AG9IUrD+E85ND5rVcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238848; c=relaxed/simple;
	bh=t0zMQLLWn8qY/GiuewiNpQmrxDLN7vxpCqE3pvHmEno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZvil2iDk8E/YclYaheApEt5op8Y1UBPDxWezwJCDg4RKxQKSghGZYa53IXNZ7RtIOApfOjR3V3Vt124QUnBKLfQwGwg6NpnIZg7imC6xsuYp4xEo0lPyooHCUiiIEP/V5xePBCT8LsletcC1zhEppRNXw3SSsJS+0VE09fbN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/b/iXz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91E8C4CEF7;
	Wed, 11 Mar 2026 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773238848;
	bh=t0zMQLLWn8qY/GiuewiNpQmrxDLN7vxpCqE3pvHmEno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a/b/iXz9A6iIP7OxXL55jzJEX/XBP2eLKwDl5Av2xcMxujxM2G4pC+fclYaOXwO1d
	 50dmJZEIQvuF2WO5xqxkpBSZ8AXUlRmXp0ronwhkr4ZFy72vtIV5S56RAqYqu//OVO
	 /uKBnerjhCsXxDAL/Z0wGYCR4T9X2W+8AM7rnUeWCyLnFtrD2BHnF/4EUlJwppArhM
	 m6pQMLfPqSNSRluRf0+uCeIoIPP1EoThJB+lO0kqoQxSlcOMbKc4hIL7lRjRmYFlq6
	 CzK+AtUBnkX5kUqO4ctX/g+IdQQuMPjXQUZ4fBAwC2QaO6VKKk86ah98+tIBLJ1NUU
	 1cpB7npjjwiWQ==
Message-ID: <19d1571d-0415-42ff-b9b4-8c866f566958@kernel.org>
Date: Wed, 11 Mar 2026 10:20:45 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunrpc: fix TLS connect_worker rpc_clnt lifetime UAF
To: Benjamin Coddington <bcodding@hammerspace.com>, bsdhenrymartin@gmail.com,
 Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260309112041.1336519-1-bsdhenrymartin@gmail.com>
 <FEF1FBB7-B82A-4A71-8F25-689EB5CD8F41@hammerspace.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <FEF1FBB7-B82A-4A71-8F25-689EB5CD8F41@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D4F05265530
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20043-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[hammerspace.com,gmail.com,kernel.org];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/11/26 10:18 AM, Benjamin Coddington wrote:
> On 9 Mar 2026, at 7:19, bsdhenrymartin@gmail.com wrote:

>> @@ -2805,7 +2811,11 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
>>         } else
>>                 dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
>>
>> -       transport->clnt = task->tk_client;
>> +       if (transport->connect_worker.work.func == xs_tcp_tls_setup_socket) {
> 
> ^^ .. this seems a bit brittle..

This caught my eye as well.


> 
>> +               WARN_ON_ONCE(transport->clnt != NULL);
>> +               refcount_inc(&task->tk_client->cl_count);
>> +               transport->clnt = task->tk_client;
>> +       }
>>         queue_delayed_work(xprtiod_workqueue,
>>                         &transport->connect_worker,
>>                         delay);
> 
> This fix works and I think its great for stable:
> 
> Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>
> 
> But I think we ended up with this problem because we're re-using the
> rpc_clnt in order to set up the lower_transport, and maybe we don't have to
> actually mix those layers.
> 
> Chuck, Trond - can we use a "dummy" rpc_program to create the lower rpc_clnt,
> and keep the lifetime of the original rpc_clnt disconnected from the
> sock_xprt?  I can send a patch..

The upper/lower architecture was Trond's suggestion. I just implemented
it (poorly). Let's see whatcha got!


-- 
Chuck Lever

