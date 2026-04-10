Return-Path: <linux-nfs+bounces-20808-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMy4DrQS2Wl+lggAu9opvQ
	(envelope-from <linux-nfs+bounces-20808-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 17:09:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E373D8FBC
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 17:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F5C53019057
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 15:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FED3D9023;
	Fri, 10 Apr 2026 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="mv8FUelo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A51CF8B
	for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833774; cv=none; b=kGk7EyJu0pYaR+2d8C2ME9IaYW2fBD4P0QjVWWK7rQa018+EEZ6F+uLdnYC4CA30qUULUcTo1PhSepJeF9cOTPKiE2IFY+d9NUSz9WjduqvHUoClWwSrCdoR0nDxt/XEIDixLoLJCiGsha0XWAQ/xv1t45Ttk0mKhfVSyBfp92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833774; c=relaxed/simple;
	bh=MkTiXa4ZLMwa46vHWDYneQN8G9FUNN7jl3S9y9UsRM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDmuEKFixa3frwix8NsY/STwHAjs1DyV1O5Rc0xqxbTEiRn3S92j7+LPJ9v9bcRujmmdBuBsuN4f70UAJbvkT0qHx2WtzKktL/rHUAx+fSz807UAMUESYlssmycmzdVCIHYKQjB6YqiROUKuCNzyXj51ubeihUob49A3DIXiWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=mv8FUelo; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d1872504cbso1940703a34.0
        for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1775833771; x=1776438571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n0ZBmxoxfXnsx2VGqrnP+0O10rmsKiHDOB93FnsPoM=;
        b=mv8FUelod/SmZsheQsVJgLMv6numkez5+MwJ5VPLxTfR7Z2oEs7QhWH+7TPqHp5wQc
         uYQm0TPprI4V9YeF4htQnmCEK3GNi04Lmsr3KGc+LehBb0nwmvshGuyzzA4Fv95p9wD7
         2eGDxi4OowPSVWHhssHLNNYPasnDOporEaNW72cxgIXPrxnvzSeU16dEWHjoD1GMMyT/
         eI6WgfbBQAs4qWbnrO6XRb/a3w070bqjdHQ3E3HQm3svRrA58TxaihV0D/gRVZGR7m06
         cI+YI+OIajJkUGyttcA5O90752cvzR529MvqL0pp3HhkN6lKK6o7kN8QLsSOhIehggx/
         I7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833771; x=1776438571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5n0ZBmxoxfXnsx2VGqrnP+0O10rmsKiHDOB93FnsPoM=;
        b=HrMOnU6F7nL2xP3bPN/zHevROwJo8li7KvxgFkyEbMRImR8v20N4LVLqebJD0kP9in
         HjATd+GLz0X1fhWqFGXELO6M1QERpqUyi/+ioXJ8ry6e7NG3OQQ9OzGnu1VPYN+Vl0dp
         l3HkrWI+povdrpxW2KD7Jz5ctq2VYyDOQkcfS+/0SlUdMLxFlE514xnqYnq9hW0xPdqf
         ixRrcvvjScy7N+ONjhJv6AYoTF1BtbV/qUeJqokLybCLpgX5l7/ZEu7hkr0Kd6x/p2kA
         zDkTTHvbE6/lcwxiv5X1Brr7pXiUx+W8ffFXg8X5mrmIFZUAA1PCBr00uyxkvRjRtEDp
         qbPw==
X-Forwarded-Encrypted: i=1; AJvYcCUPQ0T1ctipddRAaFjiYnPI0Ek9v8oUCfU7sAvEJAcFufUX4jfa4j6vvYMb/aWqvQyt1nG6HelkalA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLVmWz2sc9HNI4fkmOfgF9R3Rcu1l30xfaUwUaSbO4Vt+L/MP
	VvF6SakpH38OH6XeDbM/cTfdaGmWat3RkJ30tkBF/0tUQG5lNKE7tBMWeauXXK3UkVo=
X-Gm-Gg: AeBDievmCpeS8zJB4SsfidvtX1SlLjVJCsO59EZ3SnsD12EvxzSZHDF1EeR+xJeOnNe
	/YMLeCm6MnE09MHNJ4UtO1IN4CYloV5ZSE2esOCVKqy6wzTJskbbKIahrgEagwJ1jMfu1cwG0bF
	BaSm5fyJnGykhrK3OmTZY30ATZWFMw32GDQGGLwrDJlpffmWlz+0Ir42Vpu7mg7yU9iE8PO/vXf
	PbWJv5OvYewarIXamsuv5lyZnErtq3bGq88OyNmbSFLTbGsAncxXSWBpXctqPYjNTwhHLX4/m4M
	Q/y3NIeGFEEvHnx7mfgmTjvWoHaZFSy/MLH+NL7noJN8K18cvi1SFi1ADmLToILtvABfgDYPOKH
	dk5PS7fBAj8r5l3G/yqi6bXTdUeeV4VMiBENOZxGp/h7+wxG/BbAg9P6iNKScYmvAW/sj7m1O2a
	YNfft9aBFbRz5J9VejhlEyM9dIH8u7m4jUw+OtoKWbv8Q=
X-Received: by 2002:a05:6830:7207:b0:7dc:807:d1f3 with SMTP id 46e09a7af769-7dc1762dacdmr3033904a34.7.1775833771209;
        Fri, 10 Apr 2026 08:09:31 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2d18a063sm1067552a34.1.2026.04.10.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:09:30 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] NFS: fix RCU safety in nfs_compare_super_address
Date: Fri, 10 Apr 2026 11:09:29 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <C9851FD8-FFFA-47DD-BAA7-F465F293295B@hammerspace.com>
In-Reply-To: <20260408161428.155169-2-seanwascoding@gmail.com>
References: <20260408161428.155169-1-seanwascoding@gmail.com>
 <20260408161428.155169-2-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20808-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: 67E373D8FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 8 Apr 2026, at 12:14, Sean Chang wrote:

> The cl_xprt pointer in struct rpc_clnt is marked as __rcu. Accessing
> it directly in nfs_compare_super_address() without RCU protection is
> unsafe and triggers Sparse warnings about dereferencing noderef
> expressions.
>
> Fix this by wrapping the access with rcu_read_lock() and using
> rcu_dereference() to safely retrieve the transport pointer. This
> ensures the xprt remains valid during the comparison of network
> namespaces and addresses, preventing potential use-after-free during
> concurrent transport updates.
>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>

Fixes: 7e3fcf61abde ("nfs: don't share mounts between network namespaces"=
)

> ---
>  fs/nfs/super.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 7a318581f85b..071337f9ea37 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1166,43 +1166,55 @@ static int nfs_set_super(struct super_block *s,=
 struct fs_context *fc)
>  static int nfs_compare_super_address(struct nfs_server *server1,
>  				     struct nfs_server *server2)
>  {
> +	struct rpc_xprt *xprt1, *xprt2;
>  	struct sockaddr *sap1, *sap2;
> -	struct rpc_xprt *xprt1 =3D server1->client->cl_xprt;
> -	struct rpc_xprt *xprt2 =3D server2->client->cl_xprt;
> +	int ret =3D 0;
> +
> +	rcu_read_lock();
> +
> +	xprt1 =3D rcu_dereference(server1->client->cl_xprt);
> +	xprt2 =3D rcu_dereference(server2->client->cl_xprt);
> +
> +	if (!xprt1 || !xprt2)
> +		goto out;

^^ I'm not sure that's a great test, the rpc_xprt objects are refcounted.=

These might not be null but you could still race with a freeing path?

However, I think you might just be safe inside the RCU section here becau=
se
rpc_switch_client_transport() uses synchronize_rcu() before xprt_put(old)=
=2E
I didn't audit all the freeing paths.

>  	if (!net_eq(xprt1->xprt_net, xprt2->xprt_net))
> -		return 0;
> +		goto out;

Probably safe to drop the RCU protection scope after this point.  No need=
 to
hold it over all the other checks..

Ben

>
>  	sap1 =3D (struct sockaddr *)&server1->nfs_client->cl_addr;
>  	sap2 =3D (struct sockaddr *)&server2->nfs_client->cl_addr;
>
>  	if (sap1->sa_family !=3D sap2->sa_family)
> -		return 0;
> +		goto out;
>
>  	switch (sap1->sa_family) {
>  	case AF_INET: {
>  		struct sockaddr_in *sin1 =3D (struct sockaddr_in *)sap1;
>  		struct sockaddr_in *sin2 =3D (struct sockaddr_in *)sap2;
>  		if (sin1->sin_addr.s_addr !=3D sin2->sin_addr.s_addr)
> -			return 0;
> +			goto out;
>  		if (sin1->sin_port !=3D sin2->sin_port)
> -			return 0;
> +			goto out;
>  		break;
>  	}
>  	case AF_INET6: {
>  		struct sockaddr_in6 *sin1 =3D (struct sockaddr_in6 *)sap1;
>  		struct sockaddr_in6 *sin2 =3D (struct sockaddr_in6 *)sap2;
>  		if (!ipv6_addr_equal(&sin1->sin6_addr, &sin2->sin6_addr))
> -			return 0;
> +			goto out;
>  		if (sin1->sin6_port !=3D sin2->sin6_port)
> -			return 0;
> +			goto out;
>  		break;
>  	}
>  	default:
> -		return 0;
> +		goto out;
>  	}
>
> -	return 1;
> +	ret =3D 1;
> +
> +out:
> +	rcu_read_unlock();
> +	return ret;
>  }
>
>  static int nfs_compare_userns(const struct nfs_server *old,
> -- =

> 2.34.1

