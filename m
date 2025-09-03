Return-Path: <linux-nfs+bounces-14025-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AF6B42B65
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 22:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975DD3A1B94
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 20:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1AB2E040D;
	Wed,  3 Sep 2025 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Up6FqFuH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E572292B44
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932895; cv=none; b=rnfucwkOLYIkwc2OGamDAitVng/yaMPoH1ggQ4yhq1ULP2HKcOnRrtbBrzQAN6sCnwFXwuIqcCalxEwc7PuYEFKLFoOWpRrHen6RcGypaKAdFNQ0jqG2j/cf11CatNiAm60zLwExVPWS+pwrvxv4raJ6E2mrKfmNzFSIX6WSxI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932895; c=relaxed/simple;
	bh=6gdHjIdCeZuKoaFm8QoKpV2dKwe6wOCKeK3GVzKWpMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLHgSr4mr/Ud+Ujr8yQZ88j0IWo6vVc4FDk9vE0b9PJZ3hGzYsoLIZOSgH44oMhI3fPYh7Z8n61TCKN7K+GkEzZUZUKmK4hzA5HKfTPAmx9WhLQy8OmFBbmmIUT7Q8mjB6kTLHK0Si/k9Fn5UfYXixrgJJh5oXUQvFan1q/e3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Up6FqFuH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756932892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fiEAoKaeIVrjIZgukoqoXBxhf/xOXx2/1Q06rZBCRzA=;
	b=Up6FqFuHqSW4ELtZLmvAfMkA5wKaN1cLqdO73VjctvcdOoLDqhz2osIROblkDN3m6QBJt0
	QO3MTCzRxVN0jHYjEQ83VAdoqCbJWcTZjlBd8OKXgAa22SrVlXpWRRVs7VvnrcXMTgUmCb
	qG/2Wctu6wsoaMYjFcFQ9RykVZ6HbXI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-AqFrnI52MvKYVBlTdSgJSA-1; Wed,
 03 Sep 2025 16:54:51 -0400
X-MC-Unique: AqFrnI52MvKYVBlTdSgJSA-1
X-Mimecast-MFC-AGG-ID: AqFrnI52MvKYVBlTdSgJSA_1756932890
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 107C11956089;
	Wed,  3 Sep 2025 20:54:50 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1BB0195608E;
	Wed,  3 Sep 2025 20:54:49 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id D808642EBA7; Wed, 03 Sep 2025 16:54:47 -0400 (EDT)
Date: Wed, 3 Sep 2025 16:54:47 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Justin Worrell <jworrell@gmail.com>
Cc: linux-nfs@vger.kernel.org, trondmy@hammerspace.com, okorniev@redhat.com
Subject: Re: [PATCH] xs_sock_recv_cmsg failing to call xs_sock_process_cmsg
Message-ID: <aLirFyirQpRRW3qr@aion>
References: <966f4d30-16f6-4a11-8d6c-1d6102781e71@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966f4d30-16f6-4a11-8d6c-1d6102781e71@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Justin,

On Tue, 02 Sep 2025, Justin Worrell wrote:

> xs_sock_recv_cmsg was failing to call xs_sock_process_cmsg for any cmsg type
> other than TLS_RECORD_TYPE_ALERT (TLS_RECORD_TYPE_DATA, and other values not
> handled.) Based on my reading of the previous commit (cc5d5908: sunrpc: fix
> client side handling of tls alerts), it looks like only iov_iter_revert
> should be conditional on TLS_RECORD_TYPE_ALERT (but that other cmsg types
> should still call xs_sock_process_cmsg). On my machine, I was unable to
> connect (over mtls) to an NFS share hosted on FreeBSD. With this patch
> applied, I am able to mount the share again.
> 
> ---
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> --- a/net/sunrpc/xprtsock.c	(revision
> b320789d6883cc00ac78ce83bccbfe7ed58afcf0)
> +++ b/net/sunrpc/xprtsock.c	(date 1756813457481)
> @@ -407,9 +407,9 @@
>  	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
>  		      alert_kvec.iov_len);
>  	ret = sock_recvmsg(sock, &msg, flags);
> -	if (ret > 0 &&
> -	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
> -		iov_iter_revert(&msg.msg_iter, ret);
> +	if (ret > 0) {
> +		if (tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT)
> +			iov_iter_revert(&msg.msg_iter, ret);
>  		ret = xs_sock_process_cmsg(sock, &msg, msg_flags, &u.cmsg,
>  					   -EAGAIN);
>  	}
> 

I set up a freebsd server and can reproduce the mount failure from a
linux client (both with xprtsec=tls and xprtsec=mtls). 

Your changes look alright to me, but I can't actually apply your patch.
How was the patch generated?  There's a line break in the middle of
the from-file line (plus I've never seen the "revision" and "date" text
in the from-file and to-file lines in the patch header before... but
maybe I haven't paid enough attention).  Finally, every context line
seems to have an extra space or two.

If I make your changes manually, it fixes mounting with both xprtsec=tls
and xprtsec=mtls.

-Scott


