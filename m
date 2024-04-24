Return-Path: <linux-nfs+bounces-2984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E6C8B141C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C299728D19B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6620C13C812;
	Wed, 24 Apr 2024 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObXWnX48"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83913BC19
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989239; cv=none; b=aTL/6ie/bKmZ39IX8prHhaQWj0ff24qHrpoGoZJ/f/mZMWU9lrvV7G48181jd7MW9oLzElg3kUi0jVeb7C9D1UWV1Irx6OfBkmTZhutPWN4vWjVvVUHhS6RbUwXKYu01AfSWbCYcbbUJMoy+yGyx0aBFZtaOY8d+oJBc4EUtrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989239; c=relaxed/simple;
	bh=aiTeXlgqUc2I7PGr9DFxoEyWbZ6ebSklPhY44dp+nIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xi6okG0NpTRE7YFMbugmV/78ZbHYWqJ+ZZ339ZpbLX9zdMRfsnupCtE5uKQit/MHiQcEJIGuZbO2vRexrpXVqm1qQOZK62Ch02F4VIFlnlOrIvedCsaClyklu930n5n5bxBGKpA67VXWp9hqwDSbgk9Ld7gWtw5bDJw1sVC+X1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObXWnX48; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713989236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu/xXE7mMWILwwQhQoKMguWl3qQTf6tJcOhQHpORss8=;
	b=ObXWnX48G4yDNWcoI4CfqQC3+6HON2c4mYtjCczr+/P+eoDSIie6Wqqgd0wbRZ76JzYRBt
	G6y2yQTTap1ecavfNZo7PF+AWMPd4y9my1Umf37aXoNitN4Css1lNByGelQH4peC+1xiWp
	v4gpmnrTrhMlOii8+0AaBLSjUwA01jw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-zoOJjm2cOBu8YVs6mbf_hQ-1; Wed, 24 Apr 2024 16:07:10 -0400
X-MC-Unique: zoOJjm2cOBu8YVs6mbf_hQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B508D8107BD;
	Wed, 24 Apr 2024 20:07:09 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-6.rdu2.redhat.com [10.22.0.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DD278492BC6;
	Wed, 24 Apr 2024 20:07:07 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: rpc_show_tasks: add an empty list check
Date: Wed, 24 Apr 2024 16:07:06 -0400
Message-ID: <76BBD76E-9CDC-4B97-81E0-72839DF63498@redhat.com>
In-Reply-To: <20240424104112.1053-1-chenhx.fnst@fujitsu.com>
References: <20240424104112.1053-1-chenhx.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 24 Apr 2024, at 6:41, Chen Hanxiao wrote:

> add an empty list check, so we can get rid of some useless
> list iterate or spin locks.
>
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  net/sunrpc/clnt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 28f3749f6dc6..749317587bb3 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -3345,8 +3345,13 @@ void rpc_show_tasks(struct net *net)
>  	int header = 0;
>  	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
>
> +	if (list_empty(&sn->all_clients))
> +		return;
> +
>  	spin_lock(&sn->rpc_client_lock);
>  	list_for_each_entry(clnt, &sn->all_clients, cl_clients) {
> +		if (list_empty(&clnt->cl_tasks))
> +			continue;
>  		spin_lock(&clnt->cl_lock);
>  		list_for_each_entry(task, &clnt->cl_tasks, tk_task) {
>  			if (!header) {
> -- 
> 2.39.1


Why optimize this?  Can you show the locks are contended?  Its probably
fine, but using list_empty outside of the lock has a bad smell to me.

Ben


