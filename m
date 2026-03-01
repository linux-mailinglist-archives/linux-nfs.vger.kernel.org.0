Return-Path: <linux-nfs+bounces-19480-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FAOMhtepGmKewUAu9opvQ
	(envelope-from <linux-nfs+bounces-19480-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 16:41:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDEB1D0754
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA73300C014
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A6285C8B;
	Sun,  1 Mar 2026 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6DLyr2M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A931A9F8C
	for <linux-nfs@vger.kernel.org>; Sun,  1 Mar 2026 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772379673; cv=pass; b=j279iBP/Osam8MibzVE93qRG34gKStp52zyy+YbjxdoLoaD0YX2soYZwU9VMqRdXBmC61X78UwC0d+wOfvHtFoAgNFHw/x0rsXBS5knr5TTLf1YfGUaew7TQUGUY6IAMIfAhonmiqjUohci3fVMmscDI153gmzP49FBsnzh2s7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772379673; c=relaxed/simple;
	bh=At7p6+O9DaVDb/y0TtWto2Zv6yFiF0SON38YauYu8Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSg8NScfJqZBI0VKorKtPT/gxV+Ti7Y6h6VYAgcWUOYTtGUtAAlLuCOxhLSbo53CZDEQJ6LfGm7CGZ/SKcuq+rSSiuQKq5zZK9CtPw4XML0Fol6lUzJaUvqIS2eIZUGyOCbHr3jVHd/rIbaIUUuYjlh6nyUIorEnh/ydB3ywhk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6DLyr2M; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94ddba39060so1050816241.1
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2026 07:41:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772379671; cv=none;
        d=google.com; s=arc-20240605;
        b=OkkT1aIx3zpUVapZqJy67u0BjDk+iAqgAh16buSRN4vZPrjf6C0uqaN16kaTfTw0Ny
         8d44VmaTq2Y5TqgCUhkUvtCZbgV8W0Jvhy5Ag+BlLLajIKnXCDUx9AgVhgAYTsGOC3ZT
         zTDPz/T4KjeCaj3iAMWJbwaUtalIja8+EwdN2Xb1rVAleHtBfha2eCiWgxlaUGNFM5R7
         2RLgI8O5vJDnW5mQcRzKzEXQ6cNV6xqY9TQQxxmnpnsyvbUMoXzZIExEWinDEel44QpB
         DRgaj4AAXnLc/Lr+a7ZLcgOTEl4J2OzYtICCzgVwXQ4R3FhwTvFFrnbUXQfJYSBInTvY
         b5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sO43ZCSlecClG7pL9h+vhzeBsnpICLVP6BPdwQGYyro=;
        fh=wn2VsYb/Y51VGkamyuNtakOSbAElBJsV5Ay9ENrQwgI=;
        b=aNzWvzkPvIlUyOfhHptx8xisYtx11vEwfHtTscJbqgmzpeuAOv6T+DQSHDwQa3C/Vt
         snGaWdVbXRsudE+jkmTMCBj4D52/qdKtKXwRJSK2Y8D6kELGZw8yvy873yrUqtt4zki2
         +O9Uy8096gXpYtD9fwCX2TZ7MecIuV++7GbKhjqY4i8CdsX00sa0hPc5AZCaVdL5lk+t
         bhbyj2vut3m/3x2Mc0qi3fiMNuQR3fT/f26vSz8IDHDiDpY4oa4NsaEam5hF0GjfXo0Q
         gyfTNufRUVlvsb6rYZyO6qjtjifNwBBg4Ct4NmWX8PkVkba9kncMV0fgmEsND5ChoW2J
         qd1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772379671; x=1772984471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sO43ZCSlecClG7pL9h+vhzeBsnpICLVP6BPdwQGYyro=;
        b=h6DLyr2MWbGidLCBy+zOw8kItl7V+nr8jFH671X7I8jGnNiTyteQmGrIzJlDPcd4P9
         pW1ohaf6JPKnU3CG4zEg33X5oG4KP5T+F0/dPsDh/1prKdWB4SRvIXNVokulJuWw9FfR
         k1jv85re0Bm9OyU/1doCksXQWRLWCsRqHZhEynC4iYNkYGyuD9XV5Icrr5m8g8uUiwXB
         8RhQd143Vpv1TqRkjhVD/njzCw15B1YVpjMhZ2qLcyYR73+IDbH+NPX+P4Dzyd0KEHHC
         YCKxiaAi4w4yr9nTOJ1bwYcp4AwgKNtUL7bI+HUjZ03dJWTmwonDsj8w8Unf/eJ4Kz6k
         2nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772379671; x=1772984471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sO43ZCSlecClG7pL9h+vhzeBsnpICLVP6BPdwQGYyro=;
        b=w9kliL8/WBuisrOwkE3ztRV/cApQrEL3/ltwsbgrNlseI/ber/7iHme10oqP6wrgDO
         5VYNqQV+gpa6YhrxXN1Zjt+OVsX7YBDEN+F7664yYpiqkimnIFYrXx1LuaHPWgS9hBjK
         Mt+F8FralnY40vWo/ohLWSjFc8rUZm6J5+UEFaOG8KAnF+ykvWXr/jAR2zojf+rSi2QQ
         7bbbc8X2XZ+kvC+MA0vhaOKXKqJB2EdibdeJqFkgRYTRJfY+N8lwRWaZYj12E1HCfPmi
         XtCR9TnxtoJvv/fBMQWNKBZDZZlMVl5vBhtHkmfSVE+DLZKtFdckiKF+dfwdrW1y08ER
         6cOw==
X-Forwarded-Encrypted: i=1; AJvYcCUvCvGK0JlUXbIrqixsTKE4alNzFlzvFXOS/rDTE4fTo1wqlrMvXoyAVOP2U9JXQyIIJNmSuqdpkM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YQ13pQIqK7GK1l22NON9mNzx5l7gPlyp/DfYwOsnz5/d5952
	P5L2djTNoLmI+sR1AhxLEcImdkbUk+W7hKytNcMzxEkzK19RQVAltc/FERT09Rwyw0I7BJA959H
	5aY7VQQKTcbX5xf/wSRs0S+yh2XjU2Is=
X-Gm-Gg: ATEYQzxcNkagrP0iZcxgh9n1XSvBd+jo2CRYNLZHxJRn3RpZkwmCW5lEyaGbgiGFN7G
	p5QFy6K/CDvGpsntRSJBLj8BPsSQ+fFLRDg98pEondbN7asZISKVVF+KugI3ZxgWt0oX7XS6vH2
	Ktnq2Ty26HRmcx0K9yDAlS//K9tIrtau5DzDf7U5yt0vf7dxXXp/v5x5eOOmI3gOETVAquDzEdI
	XCzZRx5BsH56utBCFvBBdBZNmmQNknfGeLaGhadqv/uKrQB68zy2z5Wqq9LUFh9ZssPbA2De/P6
	/P5X2Pvo/CMfH10N
X-Received: by 2002:a05:6102:dc8:b0:5f5:40ab:2d65 with SMTP id
 ada2fe7eead31-5ff324bbee6mr3472910137.22.1772379670860; Sun, 01 Mar 2026
 07:41:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227152624.164964-1-seanwascoding@gmail.com>
 <20260227152624.164964-2-seanwascoding@gmail.com> <20260227173814.2f928556@pumpkin>
 <c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch> <20260227181532.1616f720@pumpkin>
 <CAAb=EJXmQDc2EzVKCELoXaZehov_YBWMHcSzh0_ReqxDadfnFg@mail.gmail.com>
 <CAAb=EJVCA-xxqiXqy1oNgvEhv48ecDxd=OicFpFrtqrHCvhmiA@mail.gmail.com> <177cb226-7466-44df-a358-ce92c5612187@lunn.ch>
In-Reply-To: <177cb226-7466-44df-a358-ce92c5612187@lunn.ch>
From: Sean Chang <seanwascoding@gmail.com>
Date: Sun, 1 Mar 2026 23:40:59 +0800
X-Gm-Features: AaiRm52Z_o-NyOrudymzVnNt4udtFfp48n0MIvPLvAgWNAczDG4nkkQ6WKvEbxQ
Message-ID: <CAAb=EJUXdDdTpCPQv7KbWjhLgGyp2iRmjDT7zMLk4TzjYn7FCQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using no_printk
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Laight <david.laight.linux@gmail.com>, nicolas.ferre@microchip.com, 
	claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org, 
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19480-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EDEB1D0754
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 4:04=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Please try to avoid adding such #if code. Compile testing does not
> work as well if there are millions of #if def combinations. Ideally we
> want the stub functions to allow as much as possible to be compiled,
> and then let the optimizer throw it out because it is unreachable.
>
> >
> > static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
> > {
> > ....
> > RPC_IFDEBUG(struct sockaddr *sap);
> > ...
> > #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> > dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
> > sap =3D (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
> > dprintk(" local address : %pIS:%u\n", sap, rpc_get_port(sap));
> > sap =3D (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
> > dprintk(" remote address : %pIS:%u\n", sap, rpc_get_port(sap));
> > dprintk(" max_sge : %d\n", newxprt->sc_max_send_sges);
> > dprintk(" sq_depth : %d\n", newxprt->sc_sq_depth);
> > dprintk(" rdma_rw_ctxs : %d\n", ctxts);
> > dprintk(" max_requests : %d\n", newxprt->sc_max_requests);
> > dprintk(" ord : %d\n", conn_param.initiator_depth);
> > #endif
> > ...
> > }
> >
> > The refactor in fs/nfsd/nfsfh.c will look like this:
> >
> > static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
> > struct svc_cred *cred,
> > struct svc_export *exp)
> > {
> >     /* Check if the request originated from a secure port. */
> >     if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
> >        RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
> > +#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> >        dprintk("nfsd: request from insecure port %s!\n",
> >        svc_print_addr(rqstp, buf, sizeof(buf)));
> > +#endif
>
> In this case, now dprintk() uses it arguments, i think you can drop
> the RPC_IFDEBUG() and always have buf. This code then gets
> compiled. Ask make to produce fs/nfsd/nfsfh.lst and see if it
> generated any code for this, or has it optimized it out.
>

Hi Andrew,
You are absolutely right. I have verified the generated code with
fs/nfsd/nfsfh.lst and net/sunrpc/xprtrdma/svc_rdma_transport.lst
under -O2 optimization.

Even after dropping the #ifdef and always declaring the char buf[],
the compiler successfully optimizes everything out when
CONFIG_SUNRPC_DEBUG is disabled. Specifically:
- There is no stack allocation (no sub %rsp) for the buffer.
- The logic flows directly as if the dprintk lines were never there.

Given this, I agree it is the perfect time to also remove the
RPC_IFDEBUG(x) macro entirely, as it is only used in these
two files and is now redundant with the new no_printk approach.

I will send out v6 shortly with these cleanups.

Best Regards,
Sean

