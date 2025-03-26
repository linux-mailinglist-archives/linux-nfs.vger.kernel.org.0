Return-Path: <linux-nfs+bounces-10899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83418A7150E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 11:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04456173702
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCBB19F48D;
	Wed, 26 Mar 2025 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/3TyzUl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6C19DF4A
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985829; cv=none; b=Mzk3oCUTnfGp0nLR4UjIPhdJkhusTB/Qei+NfRlFyapR2WKBQA5jlXbv+InL84DRU7lvRuWm9aMlkUBTLK+MbtimWKhpHWoQT/utCf0b7IxdBUo3E68WW54lg2pPgHD4x4eA4aMTuMV168YZKJCF2zcCO2mo23l9Fobqnfenlgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985829; c=relaxed/simple;
	bh=uomnmfjqgMMo3hm4xkzJe5753cdLN5X11WihGbcuL5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVL3aa394IHBKZck6i0uOMfE5DTGhB3n6+50F2zeczP/d8A7vsGBlG6946ZxXyg/szphlDCBCdO/gxRHGwuZY+oLXtDawALJSt9UdZBXlyGATXVaaN1fwHaGH8vyL3noTPSJdQQ5ELddqLtL80wbhvA/nAPMeLUVs9OnNRMEcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/3TyzUl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742985825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuIAwr7t0H6+7xI1/AAXbUpjib9k+KhfRPnUHncOE/c=;
	b=M/3TyzUl8/Q9OrDZCttgVt+i5BTeLc270j8aSIdRfOcnG4CCrLsp9EXcFEw5VMppCNnx0z
	GEs5KuracX7grq1bJV5FJuZFMfPnHqiZuEZgWHiNwcsbZoVp9FV9q8t6qVq0VbQH5gf+aS
	xszUOSCF/XhLnkFy0K/yD3nrqMwwYJo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-LLC_mC2zMhqYlLOcUGQzcw-1; Wed,
 26 Mar 2025 06:43:40 -0400
X-MC-Unique: LLC_mC2zMhqYlLOcUGQzcw-1
X-Mimecast-MFC-AGG-ID: LLC_mC2zMhqYlLOcUGQzcw_1742985819
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4531A180AF50;
	Wed, 26 Mar 2025 10:43:39 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41AFB180886A;
	Wed, 26 Mar 2025 10:43:37 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 2/6] SUNRPC: rpc_clnt_set_transport() must not change
 the autobind setting
Date: Wed, 26 Mar 2025 06:43:37 -0400
Message-ID: <07443573-CB5F-40E3-9420-27E386EA3CC9@redhat.com>
In-Reply-To: <d98dbfcf9e5979e053c624acc88d73e7ed14eb05.1742941932.git.trond.myklebust@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
 <d98dbfcf9e5979e053c624acc88d73e7ed14eb05.1742941932.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 25 Mar 2025, at 18:35, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> The autobind setting was supposed to be determined in rpc_create(),
> since commit c2866763b402 ("SUNRPC: use sockaddr + size when creating
> remote transport endpoints").
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/clnt.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 1cfaf93ceec1..6f75862d9782 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -270,9 +270,6 @@ static struct rpc_xprt *rpc_clnt_set_transport(stru=
ct rpc_clnt *clnt,
>  	old =3D rcu_dereference_protected(clnt->cl_xprt,
>  			lockdep_is_held(&clnt->cl_lock));
>
> -	if (!xprt_bound(xprt))
> -		clnt->cl_autobind =3D 1;
> -
>  	clnt->cl_timeout =3D timeout;
>  	rcu_assign_pointer(clnt->cl_xprt, xprt);
>  	spin_unlock(&clnt->cl_lock);
> -- =

> 2.49.0

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


