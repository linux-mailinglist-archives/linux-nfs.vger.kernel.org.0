Return-Path: <linux-nfs+bounces-1707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54B08470C4
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 14:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E722F1C22623
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242D1FAB;
	Fri,  2 Feb 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARpYfK7K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75605441B
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878881; cv=none; b=m9Eic7SOsgeswXwEfJSWAvV9T2+K5I51e9MW9IV6iQ03mtdJkzTcBeN3SJPLbeOGWxlzwdO99N7yR9PwpBc/NroCYXSuQqUfNYsm8SEI0mJBjMl6Pcw0NhCN2F7fQcJo9PXf1ME2Ew4RivDkPx+h5px7hJPQorAMxwO9HplPAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878881; c=relaxed/simple;
	bh=/0Mr1boT5dgO1dJmNwB3DKoUQ93sm1s5a0rQnu8TF4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtOXjaFD+lrlEvl6i9ujT2qi3oHdYmHXAQnu9oVRdC/4Yf6E2WTfS+imATUK7TGYRt5voHEKyHk9vGK/3W2nPKHksfUbDjt/fJXxEMRgLqXd4zvLDgUdbMZYAqVYX2ro3EI96EDZK6sUoj44Gof8cnyju+gpk4grsUTpEwfaQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARpYfK7K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706878878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlYuin2d9cs9flbR5zn/xehFd1eWl3631fmtRw4qtQk=;
	b=ARpYfK7K728sqHwJiRR8PKiQTqYJY/ar4xvtREgWlmHhobOQTlSGuX8C20M/pIkrs0X7l4
	0VZ94ParI2St4CkHptiWJY85O0JO7Wr829wATw488h271lMadIblHZwOsBo45Q0/5nA1gx
	NGxMeCLzVlTwW1vesw1QSRFB4wo9ATI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-aJP49xyjPBWIfrKJ_a2GaQ-1; Fri, 02 Feb 2024 08:01:15 -0500
X-MC-Unique: aJP49xyjPBWIfrKJ_a2GaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A0F58A7F45;
	Fri,  2 Feb 2024 13:01:14 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A78D71C060B1;
	Fri,  2 Feb 2024 13:01:13 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSv4.1: add tracepoint to trunked nfs4_exchange_id
 calls
Date: Fri, 02 Feb 2024 08:01:12 -0500
Message-ID: <1DBC4AE1-E253-454F-9E7E-12DFBA14EBA6@redhat.com>
In-Reply-To: <20240126190333.13528-1-olga.kornievskaia@gmail.com>
References: <20240126190333.13528-1-olga.kornievskaia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 26 Jan 2024, at 14:03, Olga Kornievskaia wrote:

> From: Olga Kornievskaia <kolga@netapp.com>
>
> Add a tracepoint to track when the client sends EXCHANGE_ID to test
> a new transport for session trunking.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs4proc.c  |  3 +++
>  fs/nfs/nfs4trace.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 23819a756508..cdda7971c945 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -8974,6 +8974,9 @@ void nfs4_test_session_trunk(struct rpc_clnt *cln=
t, struct rpc_xprt *xprt,
>  		status =3D nfs4_detect_session_trunking(adata->clp,
>  				task->tk_msg.rpc_resp, xprt);
>
> +	trace_nfs4_trunked_exchange_id(adata->clp,
> +			xprt->address_strings[RPC_DISPLAY_ADDR], status);
> +

Any worry about the ambiguity of whether "status" comes from tk_status or=

from nfs4_detect_session_trunking() here?  The latter can return -EINVAL
which isn't in show_nfs4_status().

Otherwise, looks good to me.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


