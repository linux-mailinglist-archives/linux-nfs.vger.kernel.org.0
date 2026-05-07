Return-Path: <linux-nfs+bounces-21439-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GKfNXj8/GmxVwAAu9opvQ
	(envelope-from <linux-nfs+bounces-21439-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 22:56:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8514EF062
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 22:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E89B93041A2A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913B2DF134;
	Thu,  7 May 2026 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3rXATF6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412C2DB780;
	Thu,  7 May 2026 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186817; cv=none; b=Dfg9PIiwE4TxeOAvasH98hqlMCFwkuDplK/5FDUYcmsLaBJwtjcKljORG1IgLnYb73e5nYkUag/KRjm4M8Urd2uu6ngqFTAEMd8jBwqZ8q7yGbtHUVzE3/iTqtsynfiZaY/VVZwjE1DB+kyu7CNT+Hnryt1rs80xPuQ2DSj2bjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186817; c=relaxed/simple;
	bh=hb9//lof+vspQk+jPB4w0ydgX5sjYskjWWnapGZP7Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kfkdbo+DNVldFJTOmRPHFa6erhyrHy3SzVJKa98BoLjvt9hH+t16fwDH08+DMSbcqoD93GJqZCzR9Zygl0rub6i4q3CYwQI9hnVIRAxyWVK7/AbEWFgtq/qAHvdQ8FV9K8pQ4p18QbDW0VfFphlOaZMJv0qh1QrQ91nlAs4E2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3rXATF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F6FC2BCB2;
	Thu,  7 May 2026 20:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778186816;
	bh=hb9//lof+vspQk+jPB4w0ydgX5sjYskjWWnapGZP7Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3rXATF6tSIZ0R3y96S7EGmpjMStlHVIePdEiiwKDd1l6RWmHvQeTBwqyQ/o24OAV
	 VNwM8+b+Ejzl4hvt+z387GxeRrQ82pQsG5QJCfafl1bb3Owj+F75RocvqCbK9nSXka
	 G7G6cLU+KGw6Dja00uHoGTJcGEhM5kr+TjlOmpf4SP0gOxb3sa9O03CgExhGCja4U/
	 PCljhKtRA7Q/fTnq4kmRTJ+vAwdvP5vnntNzmQCMKN8eF/HFpfY8bPekYCDrgFzvYy
	 ZPikTG60GnFifuGLrIhwRZvjAnNbjEH69Y269+f2A4V7B9nJydKmWp/0HQ1f/vOF18
	 iZzg+aRhOfyTw==
Date: Thu, 7 May 2026 16:46:55 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>,
	Jonathan Flynn <jonathan.flynn@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	ben.coddington@hammerspace.com
Subject: Re: [PATCH 1/2] svcrdma: Release write chunk resources without
 re-queuing
Message-ID: <afz6PwRlpJFzoIQE@kernel.org>
References: <20260506-svcrdma-next-v1-0-915fce8c4fbb@oracle.com>
 <20260506-svcrdma-next-v1-1-915fce8c4fbb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506-svcrdma-next-v1-1-915fce8c4fbb@oracle.com>
X-Rspamd-Queue-Id: 5C8514EF062
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21439-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 11:26:50AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Each RDMA Send completion triggers a cascade of work items on the
> svcrdma_wq unbound workqueue:
> 
>   ib_cq_poll_work (on ib_comp_wq, per-CPU)
>     -> svc_rdma_send_ctxt_put -> queue_work    [work item 1]
>       -> svc_rdma_write_info_free -> queue_work [work item 2]
> 
> Every transition through queue_work contends on the unbound
> pool's spinlock. Profiling an 8KB NFSv3 read/write workload
> over RDMA shows about 4% of total CPU cycles spent on this
> lock, with the cascading re-queue of write_info release
> contributing roughly 1%.
> 
> The initial queue_work in svc_rdma_send_ctxt_put is needed to
> move release work off the CQ completion context (which runs on
> a per-CPU bound workqueue). However, once executing on
> svcrdma_wq, there is no need to re-queue for each write_info
> structure. svc_rdma_reply_chunk_release already calls
> svc_rdma_cc_release inline from the same svcrdma_wq context,
> and svc_rdma_recv_ctxt_put does the same from nfsd thread
> context.
> 
> Release write chunk resources inline in
> svc_rdma_write_info_free, removing the intermediate
> svc_rdma_write_info_free_async work item and the wi_work
> field from struct svc_rdma_write_info.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

You were correct: this patch alone eliminates the OOM (we tested with
both 16K and then 4K read IO from 121 clients to 8 NFS servers, no
measurable memory growth while testing).

Feel free to add:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Tested-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>

Thanks!
Mike

ps.
So you are aware, couldn't test your 2nd patch at the customer site
because the baseline kernel there is based on 6.12-stable but your
2nd patch builds on your 7.1 svcrdma changes. I think your 2nd patch
is ideal though, and will be able to pull it in to test in future, but
won't have the ability to test at this customer's scale until we can
role that newer kernel out there... might take a couple months.

