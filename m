Return-Path: <linux-nfs+bounces-19448-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNwYH9BMo2nW/AQAu9opvQ
	(envelope-from <linux-nfs+bounces-19448-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 21:15:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3E1C8166
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 21:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB45367AEF5
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965DA430B90;
	Sat, 28 Feb 2026 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G85XoUUw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1E430B86;
	Sat, 28 Feb 2026 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309114; cv=none; b=N0t0x8jjuSMivFijq5V1IlAlk1vPgth4iZHlSXeUA6y4LgkSWOtNZZ2nsLGgKV8iYTi3ne9A9kgaZR76/PkSCSEq0zKCmzC0Lu73o3xpuRZNmsPkT1HquxwRywpPJQRENWV3rXLEPLhTZYC2j6fRvEg+A/jjO/ZX5lSyccyFn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309114; c=relaxed/simple;
	bh=vdMGG4/8Hix+4FoWu/B8a1mMs7X6rU62YDOscX2pIp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nc3uxKBYxHCKsPTD9nj5l9ByUBhREGhE4bQXwmYVvFCgb7YpuhIvfxUzaTZxLZX0Qfe0F6XMYkb2xd5ZDvrwcd8orFHWZfIpXtuf9ZbDA+LdZMYJ9ivwZiGln78BKXkxWBuIOQi3tFE6nvzAZM4z+28/AOSmdXAUIgG1a7mDI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G85XoUUw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WPcP+4kIV12LpNOXbcBdaDqCQ0c2Ambd6oz7BD835wA=; b=G85XoUUwHa+W9v+OFm/sWWzV4d
	/2ewIGltz8zebm3VXrDy9xdTNRTF7bSakNQI0FlWdLWSZ7V4vUIowg/vmYEyC48w98kOvYV/X55/b
	SkkOgenle8kdifdOqEhoikmXjPCyLehMwukYBgeAe7icZx5Zni8P1d5SkcGW9XJTILEI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vwQYZ-009DVs-Iy; Sat, 28 Feb 2026 21:04:55 +0100
Date: Sat, 28 Feb 2026 21:04:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Chang <seanwascoding@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using
 no_printk
Message-ID: <177cb226-7466-44df-a358-ce92c5612187@lunn.ch>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
 <20260227152624.164964-2-seanwascoding@gmail.com>
 <20260227173814.2f928556@pumpkin>
 <c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch>
 <20260227181532.1616f720@pumpkin>
 <CAAb=EJXmQDc2EzVKCELoXaZehov_YBWMHcSzh0_ReqxDadfnFg@mail.gmail.com>
 <CAAb=EJVCA-xxqiXqy1oNgvEhv48ecDxd=OicFpFrtqrHCvhmiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAb=EJVCA-xxqiXqy1oNgvEhv48ecDxd=OicFpFrtqrHCvhmiA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19448-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: ECC3E1C8166
X-Rspamd-Action: no action

> HI all,
> I've also identified the cause of the build error in fs/nfsd/nfsfh.c
> reported by syzbot [1]. The "use of undeclared identifier 'buf'" occurs
> because buf is only declared within the RPC_IFDEBUG macro,
> which is removed when CONFIG_SUNRPC_DEBUG is disabled.
> To fix this, I will follow the pattern used in net/sunrpc/xprtrdma/
> svc_rdma_transport.c by wrapping the dprintk call that references
> buf within an #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) block.

Please try to avoid adding such #if code. Compile testing does not
work as well if there are millions of #if def combinations. Ideally we
want the stub functions to allow as much as possible to be compiled,
and then let the optimizer throw it out because it is unreachable.

> 
> static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
> {
> ....
> RPC_IFDEBUG(struct sockaddr *sap);
> ...
> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
> sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
> dprintk(" local address : %pIS:%u\n", sap, rpc_get_port(sap));
> sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
> dprintk(" remote address : %pIS:%u\n", sap, rpc_get_port(sap));
> dprintk(" max_sge : %d\n", newxprt->sc_max_send_sges);
> dprintk(" sq_depth : %d\n", newxprt->sc_sq_depth);
> dprintk(" rdma_rw_ctxs : %d\n", ctxts);
> dprintk(" max_requests : %d\n", newxprt->sc_max_requests);
> dprintk(" ord : %d\n", conn_param.initiator_depth);
> #endif
> ...
> }
> 
> The refactor in fs/nfsd/nfsfh.c will look like this:
> 
> static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
> struct svc_cred *cred,
> struct svc_export *exp)
> {
>     /* Check if the request originated from a secure port. */
>     if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
>        RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
> +#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>        dprintk("nfsd: request from insecure port %s!\n",
>        svc_print_addr(rqstp, buf, sizeof(buf)));
> +#endif

In this case, now dprintk() uses it arguments, i think you can drop
the RPC_IFDEBUG() and always have buf. This code then gets
compiled. Ask make to produce fs/nfsd/nfsfh.lst and see if it
generated any code for this, or has it optimized it out.

	  Andrew

