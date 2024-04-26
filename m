Return-Path: <linux-nfs+bounces-3032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779238B36AB
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 13:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A0D1C21C51
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5F4145343;
	Fri, 26 Apr 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJZoeAvl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F803A1B7
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131815; cv=none; b=TYHW/AF0gc4mt19A1gjOVvFMbCYoKvLSgek7+gJ1O8sydK9kQSginyc2Svi+hdVK9Gtwj4mJTuSnXwA4UlKJzZBwlF+9f+zSAeEDqkwnEA2FGTwObwOgNt2Weytk2WId07n45rE7TZ/YV4s468xLnF0t1weTIjAvXJbJ7/+nj2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131815; c=relaxed/simple;
	bh=jUxyDem5Qj3LChUa1ZvqwtfbndDhZqPuD+yptfe/+D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVQ6VApOA0OOGOXPWrfXDzsjiMQ4piBoTJmXW1K57dD+8Ss1HIYAYYKj1ioaQ4qdmSNOEhlgh55HmQDyJ8dhqQbb9olj43x4zQv07cGHQ6jqVMytN24CS7K8hMbd+zxrzVj5nHwPh9Ke86OHIcjtTPObQwT5VVuWrRpofANDVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJZoeAvl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714131812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVvLB09Cs7IPrmkvMKRrrRshC6c4zW2lowSAmuaLeDw=;
	b=GJZoeAvlMl9Shfbcm3j9X3abxyirINDT13Ke7D5WGOksSmjiLt8vkc4bfkusTRNV+L0n5H
	WF/jb8CWv3tz2U4d3toYKjzx7ZRKxiI+1AhEHGkCVFeDS4E3WNnH3YaV2PpaZMICDMtLMt
	jtElBjzjJYO5FIxc4isVE/u5Yvnrt+M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-a2OZ-sdSN2KhOrTs4JiYSw-1; Fri,
 26 Apr 2024 07:43:29 -0400
X-MC-Unique: a2OZ-sdSN2KhOrTs4JiYSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF4B92932484;
	Fri, 26 Apr 2024 11:43:28 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1563E151EF;
	Fri, 26 Apr 2024 11:43:27 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Subject: Re: [PATCH] NFS: Fix READ_PLUS when server doesn't support
 OP_READ_PLUS
Date: Fri, 26 Apr 2024 07:43:26 -0400
Message-ID: <A9C3D12F-3E5E-4DE5-9A56-ECB7EDDB0AD0@redhat.com>
In-Reply-To: <20240425202429.439014-1-anna@kernel.org>
References: <20240425202429.439014-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 25 Apr 2024, at 16:24, Anna Schumaker wrote:

> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> Olga showed me a case where the client was sending multiple READ_PLUS
> calls to the server in parallel, and the server replied
> NFS4ERR_OPNOTSUPP to each. The client would fall back to READ for the
> first reply, but fail to retry the other calls.
>
> I fix this by removing the test for NFS_CAP_READ_PLUS in
> nfs4_read_plus_not_supported(). This allows us to reschedule any
> READ_PLUS call that has a NFS4ERR_OPNOTSUPP return value, even after the
> capability has been cleared.
>
> Reported-by: Olga Kornievskaia <kolga@netapp.com>
> Fixes: c567552612ec ("NFS: Add READ_PLUS data segment support")
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

> ---
>  fs/nfs/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index ea390db94b62..c93c12063b3a 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5456,7 +5456,7 @@ static bool nfs4_read_plus_not_supported(struct rpc_task *task,
>  	struct rpc_message *msg = &task->tk_msg;
>
>  	if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS] &&
> -	    server->caps & NFS_CAP_READ_PLUS && task->tk_status == -ENOTSUPP) {
> +	    task->tk_status == -ENOTSUPP) {
>  		server->caps &= ~NFS_CAP_READ_PLUS;
>  		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
>  		rpc_restart_call_prepare(task);
> -- 
> 2.44.0


