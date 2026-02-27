Return-Path: <linux-nfs+bounces-19428-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCMtFgPgoWlcwgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19428-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 19:18:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A534F1BBE63
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 19:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D5B3018778
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B482336C5AE;
	Fri, 27 Feb 2026 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6LVdD/G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CF36E46D
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216136; cv=none; b=JR4I1rV4BYa5LKDAO5pDqWgxk6ZuYYW06sQKRy4Q1HjYtslPUymgI+FwyAEL5Cf/9VM1fApT5UpgOm7PfdXA6XK6up/fc7gJOVK3aPNtQ1jzuP+EJmSm/L4V69wjEalpgnJDjyLvffjU3IStiz1jEnOKURtDDuZ4816tYlxXYs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216136; c=relaxed/simple;
	bh=EIHCSnDQnPgzLOrkBSeiEeMSnqPciWc+HEYIcaNXe48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8OJsCM7Z9WNTAdyCluNoo9dnZ3SX7GusRy8fuG/C5FI8uzvvOk5eqZR0d1/yDiK1XP0NIRcEgQakHUdq6dUl1ZqaKOHXls2l6ToHZWM1sukJzbutXRap9YNAOPNe4NX1HeTuZmtJYJvueaPfSKRawYeuG0yAKVJf3hJZ8uz5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6LVdD/G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483abed83b6so19287495e9.0
        for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772216134; x=1772820934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vLtKfQfpUyImPgufwuUFBCxVkCuAbK5gi85kgZFI1o=;
        b=h6LVdD/GZ4s3Hr4A2zQzkP4zWi17wlFecgS4tVhNz+dAjce1OQ27sPJHqP8Qm/NJ2Q
         GzX7gNLydWx7M0Pnp7WTRQpuQR+s1z3V7Y7w5Gg1PtQImctmytNVD+vPwbh14IUhSAbQ
         w5yW/7qliqcX8p82bDrHPfDt81/zU7ZcctW0iwVocEio1OzWGBquNwQqSmwWHpWuXhP8
         Is6iVJ300Z08CS3ea0WrczFtTIwpmcOpe3O1vyd0EsuJK+pt3UEVmYFFD4fMbSffbrdU
         FlIi0Dym+m9cXCXvFeotg0tIMGGPOoFxqiS8Hkz4USL9nYsVz/E81GgU4k9AEEhtZZ71
         phRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772216134; x=1772820934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+vLtKfQfpUyImPgufwuUFBCxVkCuAbK5gi85kgZFI1o=;
        b=Jhl+RCbW0nVnsVU4tGDOLAl9HHmPchMQY1pKuMlCoikiocXVfj+yzSOxYW8vdwRJla
         sFThOSq5LVTU8yXqrc9U5LzVdEV9L+oi2hR+t3c/oTh9blY67/M1hImssxDrHtxly9By
         B2Bg0TYlVcJLH8brIzklXavFMJ0mTJ4VLYCa5Spu3CHskbo29U1uegk78JBy/50PvUkK
         kFzwfXO7VbAsHcmxOeGGA5NzmHhzREpE1TjlBAjzbqB8w2lWHGeLyD7eg8xS2QYWoj3h
         KxZguJt7ZUY5WDqgNZK2Iahyc0RGvUfgHJVhjM0djaC9kywaDSIh0CEUm0e6kGRcQrMX
         /4kA==
X-Forwarded-Encrypted: i=1; AJvYcCUXOH00+AdcSA9PuexaUpUANn1BTqqRcaWVwcwjUwlJtXm4x46EjdXnqg8qF5x2qJjUhzqmcr/FJ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqGQOSwtbOPGu/4tT7VSPXvSQ61QkTeCdIX7w4vS5TTo+S7kS
	FPyavMnfGLbUTX5ThvaMBaSBrHtnT632YonFMSqyGjMTvbNG7yislz8S
X-Gm-Gg: ATEYQzxM3o7QLoydTxKjzYb9NFeXJVOVTe5JWRVnvyFa6H3PzPdABTryAGpTy3fCfWa
	jEdZgu5/yysIBxVlpZkwuaPdWfmx06YKwtagawVrdjP/AtpSpS+6D8f8wOU1dqAoldf+rFCsbq6
	m3GIyRMkoTDiS/9mZD3fXU0EIGjq44vzN9HUBGkHHd2P2XxJuNU7wUskKEeB+ChxV5r//huSBEE
	GaDjTcNRdV/yCvQhwyhpNIKG2VdCZQz0QFfq2pFNbey9MFFNd3ZbQnszMaR5lIrB8SXlTxBU8oU
	Ruknsg61lXyOdjhKIKwZWbMMhJNQWnPmJH7cWNENUtIC6XC4J4Qu9YGVfBH/YQrBPkcZo40Ns9N
	jT9YcBAV+iect4LOx9epAqXS+gEggSZDH4/BmLtt+NPYpPCQIgeZUsGIrrP12UOhrzOtpUmFtlz
	7DtWNl5kmAWEG5QYusrJc8lOpW4YFTf0G+ye+GbQ2zdCDBJgE7sCSd5wHqHQO3Poqx
X-Received: by 2002:a05:600c:3e16:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-483c9ba38damr64818595e9.7.1772216133739;
        Fri, 27 Feb 2026 10:15:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b770e7sm131066685e9.9.2026.02.27.10.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:15:33 -0800 (PST)
Date: Fri, 27 Feb 2026 18:15:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sean Chang <seanwascoding@gmail.com>, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using
 no_printk
Message-ID: <20260227181532.1616f720@pumpkin>
In-Reply-To: <c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
	<20260227152624.164964-2-seanwascoding@gmail.com>
	<20260227173814.2f928556@pumpkin>
	<c28cbfc2-208f-47db-9c5a-21b54b2be8c1@lunn.ch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19428-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: A534F1BBE63
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 18:57:33 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > >  # define ifdebug(fac)		if (0)
> > > -# define dfprintk(fac, fmt, ...)	do {} while (0)
> > > -# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
> > > +# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> > > +# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)  
> > 
> > You can omit fmt, then you don't need the ##
> > #define dfprintk(fac, ...)	no_printk(__VA_ARGS__)  
> 
> /*
>  * Dummy printk for disabled debugging statements to use whilst maintaining
>  * gcc's format checking.
>  */
> #define no_printk(fmt, ...)				\
> ({							\
> 	if (0)						\
> 		_printk(fmt, ##__VA_ARGS__);		\
> 	0;						\
> })
> 
> Without fmt, gcc cannot do format checking. Or worse, it takes the
> first member of __VA_ARGS__ as the format, and gives spurious errors?

By the time the compiler looks at it the pre-processor has expanded
__VA_ARGS__.
So it doesn't matter that the format string is in the __VA_ARGS__
list rather than preceding it.

	David 

> 
>       Andrew


