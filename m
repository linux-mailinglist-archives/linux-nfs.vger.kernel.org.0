Return-Path: <linux-nfs+bounces-19426-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFFzJzTXoWlcwgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19426-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 18:41:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 010811BB8EA
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 18:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 503E9300F10C
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D782449ECD;
	Fri, 27 Feb 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6aVplE+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4D361646
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213899; cv=none; b=Y1tn7YA1O+q0St1oH1eoOALPxpEbBxw8ToWOjuHayDWguju+JqUwKf3pe5FtqRHc2+5+MKHdnYLTM6e2B1PC+xdxqZFVCFmdgVBHO97EfcN4aBm8UbSixOfcudSO0RR8YhV4GtNiAVdAdkoE590S/DRrlLkRFGFTOPzGnX9bOnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213899; c=relaxed/simple;
	bh=GqKJN4wicu+ARcppCF2d6g6bNUpLTY8dZOP//kGjqUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TX+YOs6E17liSmvqNhaw4ASu9p2rVT+7BsdBnGTg0IN/9o+PtGfpgP5AegDxQl3/+Fi4KqATlgr7Yh24Bveyj1dxae6yGKyydZvgvnbPVPbNXyCY8X7672Bz91Zwa9NaGJQdMkHak1NCxU13jxuB4qJ92086Fp8riNI89yrO4m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6aVplE+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4398f9e3b40so2415390f8f.1
        for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772213896; x=1772818696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5330lVPGxgJgwW4sth2NQqr3TSgpLx4HpGSr8ZLQeRA=;
        b=P6aVplE+WNFBo+ayyk6rY6iLnPh8J4YGtzfAuFS7UNVhT0/wlvI5iUe9RivBDHCz3q
         d2oXD1UIigI5yNH5+elv0o5/tIu4EPlxHaqa8YqeKqaq5pCTEKnv2cBKfvNr1/PTenWL
         nvqUBY9LBQnr7kCVgigl8qVElLbbgS0TwLcxzV939HSO2NktSLOT1ue/8HEcR/7aB8kr
         QGP/ykZredSBuLQg7f4DUk178VU0K6hFD4A0aXGSQCrWt9xGyQ8yduHl4Z7W06WKMf1C
         kILiyzhw13qtwkamD/KoZWU9i2kY3zSMtPCIN4HFUpP/uPdjBgphi11wfBzqI6sKejBR
         xNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772213896; x=1772818696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5330lVPGxgJgwW4sth2NQqr3TSgpLx4HpGSr8ZLQeRA=;
        b=VUkr8KtFpGZ9xNJDJWNZx81HVQU72Q76XpeXmIsJueksULc4w4R6h/jPWx1mQcJl3w
         zAifHiNu0cVQJTrs+GgJlSh9JfZ/G+zEUZxfNq9sRc6bWLWoEHU2rA0HkSIcrtIyrg/3
         5D6WbAy4JvNtDrwAipDZ0Zz0LsFTsdLA3Y//J5Eh86Sxq2ORvpVb1BGdhNvUBIoaBlnY
         wIShaLHw2Wuba3HogiiPuGiiVd9nIzTglwSGoTW+8RejXgL6AdrAxee8grr0JNly7MBy
         inXuD0wSxdn2kUaL+ZRrQ1dpN024LGCR0HKO3vlE1BIeLbJtHUXXBzkhL6mI6sBlo0ZL
         iUhw==
X-Forwarded-Encrypted: i=1; AJvYcCXwlS45Vf2tB6v/1KVWR3lDQmao75jCSiuy/jlREHx0aq8aDqpUuHxW3FApgU3L3YSHCf30xMg8n98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcUXPiNKcVvf9NXAK6v5VoeXVcVPaj3fYI+w1R9kOoQL0Np0x
	X62UXIOBGLF+Lz+JeKQwO8mq99/5DvraxwZF6QE9wA1CHE2ITTPzWxkO
X-Gm-Gg: ATEYQzzK7+TyLIHiG8suOkwz66ilgS9GvIqKR+z09WcT9ItEXlk+v071oCv4NR5oGkK
	sn/8MjRViIs4Hg9457PHIYyIAn26pUlWyLS19dabXedF5e2c5Yw0Fpxt7CKpsEdWPTW1FFic8xe
	yS5zd8bly89xeVRXyn4tPgp2BCCJbC41c+8iQjCrV3nlpQmgNvudGym7DaOLv1LoM1eyhkHoJPE
	d2LWP8CdIEB3wBwnJ04RUDliIEJvJHuQAPQ9wGg2tz5U4G6NcQxKsmkgCYQJXA6Ss+JhVKOtJCI
	oe3FL15noadCL6ufwdNENW6nVfNin79BkAcKOzlf1f7PkuMBdRS8mZbJDswXgJmo3yTXpYRzFUb
	LfpF7zu2L07OZrhZzpYw+PWKaJ8P/W6ViMB1D+D2luWoSQ6enB+kNiFxTEcA6axfSOoSkwhMxeu
	W59QU1AeEWL5W+vtkGhLKyuM/KB5UaK+L9XBPrVUoAZlG9tO6ZAX+TjloL92iPJbr8fZgOxWWIc
	XM=
X-Received: by 2002:a05:6000:2c08:b0:437:712a:fab5 with SMTP id ffacd0b85a97d-4399de3e39bmr6530808f8f.35.1772213895640;
        Fri, 27 Feb 2026 09:38:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c7657c7sm8793640f8f.28.2026.02.27.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:38:15 -0800 (PST)
Date: Fri, 27 Feb 2026 17:38:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using
 no_printk
Message-ID: <20260227173814.2f928556@pumpkin>
In-Reply-To: <20260227152624.164964-2-seanwascoding@gmail.com>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
	<20260227152624.164964-2-seanwascoding@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19426-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 010811BB8EA
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 23:26:23 +0800
Sean Chang <seanwascoding@gmail.com> wrote:

> When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
> expand to empty do-while loops. This causes variables used solely
> within these calls to appear unused, triggering -Wunused-variable
> warnings.
> 
> Instead of marking every affected variable with __maybe_unused,
> update the dfprintk and dfprintk_rcu stubs to use no_printk().
> This allows the compiler to see the variables and perform type
> checking without emitting any code, thus silencing the warnings
> globally for these macros.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> ---
>  include/linux/sunrpc/debug.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index eb4bd62df319..55c54df8bc7d 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -52,8 +52,8 @@ do {									\
>  # define RPC_IFDEBUG(x)		x
>  #else
>  # define ifdebug(fac)		if (0)
> -# define dfprintk(fac, fmt, ...)	do {} while (0)
> -# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
> +# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> +# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)

You can omit fmt, then you don't need the ##
#define dfprintk(fac, ...)	no_printk(__VA_ARGS__)

	David

>  # define RPC_IFDEBUG(x)
>  #endif
>  


