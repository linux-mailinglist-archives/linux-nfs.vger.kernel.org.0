Return-Path: <linux-nfs+bounces-19502-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMm0BO+7pWnNFQAAu9opvQ
	(envelope-from <linux-nfs+bounces-19502-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 17:33:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9A1DCEC9
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 17:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 279473074544
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2F83FFACC;
	Mon,  2 Mar 2026 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTHu4mnk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90241B344
	for <linux-nfs@vger.kernel.org>; Mon,  2 Mar 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468914; cv=pass; b=G8fUbT0WyZroEvv5odqLjU1CxHj0AgQ3ENLHAn0v7QQDqIvENzWJS/0IRgjIOVYpDRuqSErm05WXHS4t1TeTc9jT6GivKLqPD5sO3P3qyhSYdzc8KLsnnKAs5P0GSqsp1Wu4WCXyhNc1+/iG4QeM3FPtZ45AbB26cEHBgeUvHJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468914; c=relaxed/simple;
	bh=dMHwqYxQisMntrA1NhfwmZ21wfBMDsPxJFujDbwlTqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctS9bB8YCIbhB7lTicxlHJI3HSilI13CcBRTTmhMVZ8KOdkRxuwJ46Aa2tgMjbdBcYGbBgYutT89RXL8GeDbL7h4b1xwkIBXgE/XBvwyfiigpPPfjGHrjHzilub2O3TD9c2zympAw9BgM9Iq6Lx0RoQvri6Rn5vMbmFrr6nkN3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTHu4mnk; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-567543b8989so1887101e0c.2
        for <linux-nfs@vger.kernel.org>; Mon, 02 Mar 2026 08:28:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772468910; cv=none;
        d=google.com; s=arc-20240605;
        b=MuAe9lvHYES+PAFUT6s6ZakADMDO2gakHxB+hYIRef3ZHYsUSf5ZlXAtU7DNxzVMgb
         eLgk1fj52bQuql9F++P5SUC3SDlNSl6vDwIoBfKD+r2rd9Adp1ilwfu6hvZREet1dZ+r
         HukLkzwPZ6NBNWF/mhPfszNlphPNwYAnmY4//nviQAfwguR7sDsSbS/6lObBcyQDhiG0
         UWavl+u61vEpPgQFCoaKImLzRhMUoA0TJriNRiMWBf+kS+qlJv2KM3tF9uui983sXO6o
         Y2YnhbXqvmhz3gygpHEiQgIKntJWL2eigXjxUHLZipORtU7drwLyViC8wgTZu2QU9Zaa
         wnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DzhZQOue2L9j4aXZ4jUdotleq+eYfW6Yii7JRxHrKCk=;
        fh=abZIHxHvPokSbSCUNqM52RV8UDsKYfW2beokaFLTrhA=;
        b=RM9uv/B2jGItmqGKkhDh8Z9MOpE0XomgXdYkAyvS/7aclei59tacMOsXvcwNl0XAaw
         NX5T14WozNgr+Q6cg5k53wn/X4oVzFKzb+prdr5/whPq19zte3s5YjapCy9MgVrOr3Nv
         mZ3L24DO+U/Yrl9BRzkJJEenuVTeE0Xmg3vInuNhrLYGqV3s25suHARCo3/ab0paROVv
         jBw+gCYrj9CUgUYy5AmyTXLDCZqDMtojFZi44iZZKg2iLyY3971ip3Rdt7GydDzQcbO8
         +ZBk5eRvIaZVmQhArgDi71/G/FgLs/QdSPrglYQzRBbc+4R4x/AXP4AwnVorfVhxreXK
         2GbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772468910; x=1773073710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzhZQOue2L9j4aXZ4jUdotleq+eYfW6Yii7JRxHrKCk=;
        b=jTHu4mnkdq4Mp0Wa+IUHaToBXRPHOla3hdUrd4M2LBO7vNEQ+CG8clGQ4QfXN06RT6
         QYS4ap6JDWOGi/qhQMUX4sTZCIQ5FG5iPpA0ff5LHyTh7kxQqB1Z0qlGpnpHDfkb3GbF
         S2E3hu7GtlzwV5XPZKS4VVShxQIfFVT0k9tJTWIir5Bm8tfaJayfFmUY2OUR8b1ZSkqB
         NkxTIYJg02A6ipzkL0ZbR5OWMGEyeoXGgCIob+TtjNNXw9cl0CYXSGnnc+o3N3XvNKki
         hPUyOdjVT3TdL14qdHkNDrcbVdGKgXGRt4eL/hUpZbCZotLS3gfyLTJHhFMQDChL+tpF
         l/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468910; x=1773073710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzhZQOue2L9j4aXZ4jUdotleq+eYfW6Yii7JRxHrKCk=;
        b=JXI9SyCKvto1GUWEurhgMiNXpSc1vGl1wxlIG12gYmN2TyZp9QJEfUaLBbK23QivA1
         xO88407Q2Q0kUN6LwwrcKQIaB+KZfiWlATfNCIy6/qS6soVFPxV1PsKRV3gvBwqEd/4r
         cldk9aiXfRTFMdd5U9seyE9JGds1Qss2YdvzQiC84vwhBILPAajabVyMZGCmFFby4vsq
         UjVCwIcAZZHdUtFWFzHoty0pvu/RGWYcZeF/NuSSgJeyhzwLCyX6DygcaTh+h5p7JO6X
         IxIo3CgjLDcl7InapzyhtfzqStIolbLRI9vy5iNy9oa3tPFcerbxlU3kfIa+PFpvSDax
         1oKA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Q4lKFOIsBovazPcvJkacpnn0ofeN7wAHieD30KBzez7kOTi8in/YX+tQelmHWvtcEjvFYZT3NJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1gRkCP0daJ2P87lHwf+Nl3YNUfsLMWIUuAPe846SnHxrjL/b
	VQ3RMcovN7nfFle1/11tixGd+OiiBJwRlpN8UkVXtDHau+jeztEbHz/ZbYZ9Uejj3sKJv4CEKSv
	JjA05PT/vye9HXwg0XdSUTdQqhczKDEY=
X-Gm-Gg: ATEYQzzMODacLG9UVnN3nMCrAarQc2cBnkBlRnXyF5sNj1l4LUOWubMh/Je/rXVo9Pk
	dvHMnOXmkfQqo3JQ3bVH0guMYqNSM+VdFRD3ivmyls+NW4AY1PzusNEKV5FnipklkCNt+22CIyp
	o+kG2l9hZ6PR/glqIav1u0SZaG+NDxkupY2szGXd/cWq4DzupmZRhroLyNwiigs0TMwNOuVg4y4
	pQN5b2BWQ1QW46Btau5wq9anP87qrgQxtg50BOA+AFm+vyNMFVCD0vX89c+MRtak9y8CBIMEjcG
	cCKZkMYf3D3aG1O/
X-Received: by 2002:a05:6102:b0f:b0:5ef:24aa:986f with SMTP id
 ada2fe7eead31-5ff32280163mr5192254137.2.1772468910139; Mon, 02 Mar 2026
 08:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301161709.1365975-1-seanwascoding@gmail.com>
 <0a784056-f57f-4634-aa7a-fd0b5916f40a@lunn.ch> <aaWP88PplFTsAPg3@black.igk.intel.com>
In-Reply-To: <aaWP88PplFTsAPg3@black.igk.intel.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Tue, 3 Mar 2026 00:28:19 +0800
X-Gm-Features: AaiRm51MTuyaW8sCf46M4X9momxmkR1idtlRx24QnNR4DCFftyUCbovalbjZGjs
Message-ID: <CAAb=EJU7QECk4Bs67=_q6aKbL+knRG6DBJa0AQRs_+014zZC0w@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Fix compiler warnings/errors in SUNRPC and MACB
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, nicolas.ferre@microchip.com, 
	claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org, 
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 67C9A1DCEC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19502-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,lunn.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 9:26=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Mar 01, 2026 at 06:39:44PM +0100, Andrew Lunn wrote:
> > > - Verified via .lst and nm that both variables (buf) and helper funct=
ions
> > >   (nlmdbg_cookie2a) are fully optimized out by the compiler when
> > >   CONFIG_SUNRPC_DEBUG is disabled.
> >
> > Thanks for doing this bit. It was needed to show my guess was correct.
> >
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> It already has your tag. My Q in v5 still stands: Why is this a series an=
d not
> standalone changes?
>
> Also I just gave a tag, please split these two and send individually.
>

Hi Andy,
Thanks for the suggestion. I have split these into two standalone patches
as you requested:
1. The SUNRPC/NFSD macro simplification [1]
2. The Ethtool/macb redundant guard cleanup [2]

I've also verified the optimization again via .lst files to ensure everythi=
ng
is clean.

[1] https://lore.kernel.org/all/20260302142931.49108-1-seanwascoding@gmail.=
com/
[2] https://lore.kernel.org/all/20260302161818.63651-1-seanwascoding@gmail.=
com/
---
Best Regards,
Sean

