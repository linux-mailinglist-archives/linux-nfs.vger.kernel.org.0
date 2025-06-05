Return-Path: <linux-nfs+bounces-12130-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B184DACF12B
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 15:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4ED16FF5C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB2C264A76;
	Thu,  5 Jun 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D4gPO/8H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1446263F5E
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131150; cv=none; b=mAim8tSp8UswyyL0sOabZYpz+8rNmd+HH3Rmjv2m4YAQE04V+ScC70JBJx1DqwOuCFVZnCpSpMDX7m9bxlBEGD92bw9AgvHe0oiQ5lXmwnGh+p5ZT6z/wfPIetP3CSEVo7vZdJStXX7Xof2DmslxGs863/oE3bmxV5IlPW1xjnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131150; c=relaxed/simple;
	bh=JSLKlf63uzdWEiAIU0XOg9xwJDS5mnY35f1hFp1zaMY=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:
	 References:In-Reply-To; b=YbD70LEaozPr+0SLr8LuipmjmjcJ3CZvF3dfMraWk+Miyt+1e6545bhMzADjqfzyjqu5Dmfxiqf8G1WGBl2cgpPjwP638lmqoRxApxmcAcTQftEqGgjejPajg5JNsiV9Bhr+fe98T3GYqx+iWe6H6f0IUuNQzTTZZRo7yfwoof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D4gPO/8H; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4f379662cso870464f8f.0
        for <linux-nfs@vger.kernel.org>; Thu, 05 Jun 2025 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749131146; x=1749735946; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:to:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fB9EIYd8dEE0KiLz+R3yD9D9jUwC8mMeE5rB9MpN9Y=;
        b=D4gPO/8Hm/PUbOg1wFWXf5+6kG0eV1VXC7Q7RcsL7K8ce4c3IqsHQfKTkP7EQtBgW5
         lNKTydO2EACu5Z7D1ailzk4CEF3lJmHucawiIBYHnrI2thnpgbc0galWftHWeHEt2Api
         FrQx5kRlHteSAJQ9VwxoHihbKqzvJ0qqjVL/xCCG10a20uTvS4CvSNFiDY7gk1O+euer
         atBHX49zjC1xmtz4cH23hVqdm4daPKhkQTd+GZ+oZjwM15GShuiZNwTUttRTk5MEX44K
         a2g3hIvRKD2yuPPBGinknLZ+a4mOhYuGUAnyA9gUooFLh4FSKzCuUOqm0ZwOdtmoPvfB
         41cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749131146; x=1749735946;
        h=in-reply-to:references:cc:subject:to:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fB9EIYd8dEE0KiLz+R3yD9D9jUwC8mMeE5rB9MpN9Y=;
        b=v/c+NkzIfPSL3OxRIet685RVEJqzMEq1O+eagSqXBa1gnTkPRQ+U1ZxYQSxy6/B2/F
         2SQuGpfnQIH58sPC+Bt442mKmuLhqD157VvW4XHN4WaR69GrbM1qGRSM/CUad7AN7aI3
         mC2+Ljo7brxIroHtf5B9vw7yku77gC8On4Ggm9JIrpZuxhgl+hXvTTzrWjcsA5nQcS5t
         M/RZuXFceE/GH9wLXXQROlh7rZdETUpoFsinUQco/eWOfZ5klA46vECgrdBbB2qXfssp
         d8BM6Rk/DP6ljls+um9g6D1ykgFir0gmmoGRrlMjugLu0dcgLi1Tt+mNoIwOecQ7GnE9
         74yw==
X-Forwarded-Encrypted: i=1; AJvYcCWyV6qnU4oWwQiyAy+03Ddd0zWbSy+MujJrnThsFHo0cQdsFcAGf46mfdCT8XOB2x4D8wsBy9IF0A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysjdvFvFcsijgtQpE2kTqnGOwmwwIEHg1DpLpNQi7TQlC3lBZs
	vq2flfBg9juY+c031OQQS9dHGa+Jpkf98r+YxzPMUIHrA5bD+9FgstuVyhuRP0O0AOs=
X-Gm-Gg: ASbGncu2ziPXpu8PJV8ohCL32Q3blLRb230sQH9+kiNOdKX3Pl2NExUjqJRCCCgwNxz
	rs9CmBhdyCb5pY8ptr34Tp3pUCc4pFQPO5eH+1DbeAehnBjY9O3o91BLQ2dKfRcOWyni9mPiALc
	QF8Uy2y5zel2P3LwBPfUNy6pQTZvCx7eqcwNbJSUuIhW2VVinH44w8GMJDBvxpcCfqyEoCkT5sG
	+C2oOgxTMnBQLqlSh+rJ6cnOZTzqou37no7k+3whEs8mNqd4nbV44T6DrOYtb2/ru88YEFfnm1u
	4kAFIoJBiU2u/IWa6f9K+5d7ZS0A5PaAoLt2zQE=
X-Google-Smtp-Source: AGHT+IFdWOkY8XQmtnFNzr8A/E7xIcpeS2nqzq6qr2t002+lujkrTbevinTQ6M+oJ6BEX+4D6ozUpw==
X-Received: by 2002:a05:6000:2283:b0:3a4:fa6a:9174 with SMTP id ffacd0b85a97d-3a51d9708d4mr6479588f8f.33.1749131146086;
        Thu, 05 Jun 2025 06:45:46 -0700 (PDT)
Received: from localhost ([189.99.237.136])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53074bf86b1sm12621327e0c.36.2025.06.05.06.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:45:45 -0700 (PDT)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Jun 2025 10:45:42 -0300
Message-Id: <DAEN8PXPZ2VW.3O70BTPH4BZCI@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH rpcbind 2/2] rpcbind: Add -v flag to print version and
 config
Cc: <libtirpc-devel@lists.sourceforge.net>, "Steve Dickson"
 <SteveD@RedHat.com>, =?utf-8?b?UmljYXJkbyBCIC4gTWFybGnDqHJl?=
 <rbm@suse.com>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250605060042.1182574-1-pvorel@suse.cz>
 <20250605060042.1182574-2-pvorel@suse.cz>
In-Reply-To: <20250605060042.1182574-2-pvorel@suse.cz>

Hi Petr,

On Thu Jun 5, 2025 at 3:00 AM -03, Petr Vorel wrote:
> This helps to see compiled time options, e.g. remote calls enablement.
>
> $ ./rpcbind -v
> rpcbind 1.2.7
> debug: no, libset debug: no, libwrap: no, nss modules: files, remote call=
s: no, statedir: /run/rpcbind, systemd: yes, user: root, warm start: no
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

LGTM, thanks for doing this.
For the series:
Reviewed-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>

> ---
>  man/rpcbind.8 |  6 +++-
>  src/rpcbind.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 83 insertions(+), 4 deletions(-)
>
> diff --git a/man/rpcbind.8 b/man/rpcbind.8
> index cd0f817..15b70f9 100644
> --- a/man/rpcbind.8
> +++ b/man/rpcbind.8
> @@ -11,7 +11,7 @@
>  .Nd universal addresses to RPC program number mapper
>  .Sh SYNOPSIS
>  .Nm
> -.Op Fl adfhilsw
> +.Op Fl adfhilsvw
>  .Sh DESCRIPTION
>  The
>  .Nm
> @@ -141,6 +141,10 @@ to use non-privileged ports for outgoing connections=
, preventing non-privileged
>  clients from using
>  .Nm
>  to connect to services from a privileged port.
> +.It Fl v
> +Print
> +.Nm
> +version and builtin configuration and exit.
>  .It Fl w
>  Cause
>  .Nm
> diff --git a/src/rpcbind.c b/src/rpcbind.c
> index 122ce6a..bf7b499 100644
> --- a/src/rpcbind.c
> +++ b/src/rpcbind.c
> @@ -96,10 +96,11 @@ char *rpcbinduser =3D RPCBIND_USER;
>  char *rpcbinduser =3D NULL;
>  #endif
> =20
> +#define NSS_MODULES_DEFAULT "files"
>  #ifdef NSS_MODULES
>  char *nss_modules =3D NSS_MODULES;
>  #else
> -char *nss_modules =3D "files";
> +char *nss_modules =3D NSS_MODULES_DEFAULT;
>  #endif
> =20
>  /* who to suid to if -s is given */
> @@ -143,6 +144,76 @@ static void rbllist_add(rpcprog_t, rpcvers_t, struct=
 netconfig *,
>  static void terminate(int);
>  static void parseargs(int, char *[]);
> =20
> +static void version()
> +{
> +	fprintf(stderr, "%s\n", PACKAGE_STRING);
> +
> +	fprintf(stderr, "debug: ");
> +#ifdef RPCBIND_DEBUG
> +	fprintf(stderr, "yes");
> +#else
> +	fprintf(stderr, "no");
> +#endif
> +
> +	fprintf(stderr, ", libset debug: ");
> +#ifdef LIB_SET_DEBUG
> +	fprintf(stderr, "yes");
> +#else
> +	fprintf(stderr, "no");
> +#endif
> +
> +	fprintf(stderr, ", libwrap: ");
> +#ifdef LIBWRAP
> +	fprintf(stderr, "yes");
> +#else
> +	fprintf(stderr, "no");
> +#endif
> +
> +	fprintf(stderr, ", nss modules: ");
> +#ifdef NSS_MODULES
> +	fprintf(stderr, "%s", NSS_MODULES);
> +#else
> +	fprintf(stderr, "%s", NSS_MODULES_DEFAULT);
> +#endif
> +
> +	fprintf(stderr, ", remote calls: ");
> +#ifdef RMTCALLS
> +	fprintf(stderr, "yes");
> +#else
> +	fprintf(stderr, "no");
> +#endif
> +
> +	fprintf(stderr, ", statedir: ");
> +#ifdef RPCBIND_STATEDIR
> +	fprintf(stderr, "%s", RPCBIND_STATEDIR);
> +#else
> +	fprintf(stderr, "");
> +#endif
> +
> +	fprintf(stderr, ", systemd: ");
> +#ifdef SYSTEMD
> +	fprintf(stderr, "yes");
> +#else
> +	fprintf(stderr, "no");
> +#endif
> +
> +	fprintf(stderr, ", user: ");
> +#ifdef RPCBIND_USER
> +	fprintf(stderr, "%s", RPCBIND_USER);
> +#else
> +	fprintf(stderr, "");
> +#endif
> +
> +	fprintf(stderr, ", warm start: ");
> +#ifdef WARMSTART
> +	fprintf(stderr, "yes");
> +#else
> +	fprintf(stderr, "no");
> +#endif
> +
> +	fprintf(stderr, "\n");
> +}
> +
>  int
>  main(int argc, char *argv[])
>  {
> @@ -888,7 +959,7 @@ parseargs(int argc, char *argv[])
>  {
>  	int c;
>  	oldstyle_local =3D 1;
> -	while ((c =3D getopt(argc, argv, "adh:ilswf")) !=3D -1) {
> +	while ((c =3D getopt(argc, argv, "adfh:ilsvw")) !=3D -1) {
>  		switch (c) {
>  		case 'a':
>  			doabort =3D 1;	/* when debugging, do an abort on */
> @@ -918,13 +989,17 @@ parseargs(int argc, char *argv[])
>  		case 'f':
>  			dofork =3D 0;
>  			break;
> +		case 'v':
> +			version();
> +			exit(0);
> +			break;
>  #ifdef WARMSTART
>  		case 'w':
>  			warmstart =3D 1;
>  			break;
>  #endif
>  		default:	/* error */
> -			fprintf(stderr,	"usage: rpcbind [-adhilswf]\n");
> +			fprintf(stderr,	"usage: rpcbind [-adfhilsvw]\n");
>  			exit (1);
>  		}
>  	}


