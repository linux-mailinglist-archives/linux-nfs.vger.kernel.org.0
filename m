Return-Path: <linux-nfs+bounces-13262-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A9EB12D09
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 01:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5623A1897933
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jul 2025 23:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5B321C166;
	Sat, 26 Jul 2025 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Upp7HVSt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42917DFE7
	for <linux-nfs@vger.kernel.org>; Sat, 26 Jul 2025 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753571619; cv=none; b=euP/T6vCZiPpUPrFxrK0AqqgTmB6lkbD6QKdI/+qkEPmif6aiUMS16tyXV0Clf82QAfLZEubhq2dsQWlStwXBxPyXxww5htghhi7V41TUYwt2K4XnS9ZFE1CVi4+bfqN0gWT+HhUg5GPY3jrAL28HysxpSAWSP6A7LyQD1EFYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753571619; c=relaxed/simple;
	bh=002poAq1GhsXWb41tc2T8WBg5Ay9uQPVyd2eo2Ygkww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHEkPS1aSIIDQtYU5vwA/skrEHJd0cz3SmLNenlu5f32ZcbV5APYEkrD+wiyF/atCS31nP7rWOf2MP7dkevFfOEoCYWgKcjNhcn62kPdg4tBcVPFp4pwX/u/1GBGrWMtJ5hO+rh6RUCBanCEFk21HEvp7uKstk6DflUnNICBNK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Upp7HVSt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753571616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fMeJvHrB0Dkd4OSKUl3T1xTf+tnan8IbBllxJHd/kXg=;
	b=Upp7HVStvcP6PUEmDrZJDy5IQdJNy3j2h5QJIdh0tsE/iHuuyxJkzmaAcEZElFBzu1D44m
	pOtHJn/luXASUR0ZkpRCOsbNJFo6XtcMpKWtD5JoJ0lFw4ENMGCOateAFX8SyX7cnqtlB2
	YBnYfb9RnN0RkRhnlqekgVVkRFKDCh8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-jOm789-qMn6eQvPdBGuNuw-1; Sat, 26 Jul 2025 19:13:34 -0400
X-MC-Unique: jOm789-qMn6eQvPdBGuNuw-1
X-Mimecast-MFC-AGG-ID: jOm789-qMn6eQvPdBGuNuw_1753571614
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab801d931cso66544671cf.2
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jul 2025 16:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753571614; x=1754176414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMeJvHrB0Dkd4OSKUl3T1xTf+tnan8IbBllxJHd/kXg=;
        b=Onpn5SrfOFljq3aCmu+izGeMeYURYcjlFhmuxT6hvoAjzCzTHuXrWl9rhYM6YLq6Kd
         UptYGxHdC8JLwXDXO04xaE7OWftklAh4h1Tp8+YYm9zs+WJwT1L41ZUYiWfXBW/8h3C4
         UCQhpuxfQopCj/0NYVN1XsaKx/Lfxs+1tX5atc3OZ42Y0uXw3A9a5pNTkx41PttQ+Wju
         +vgkyaTlGNzItwiG2xS983AI/UGWU+wQE6ALPQnB9nS/XKNdihbyL3CSWM9i104EwhdX
         X7zAud4PM7q4TbPLCDA+RhUjasVT+9uAfJkbfDpwU+CWbhTOfSyrqhmgkAwldTPEwC7z
         qHBA==
X-Forwarded-Encrypted: i=1; AJvYcCXmwghlCyaWdm0gDJoj31I0weC8uVy8sS9tfWZuoT8bqVWYzTHltKIUeT57KgiROfYVplO/e8uC9L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3WbCbDW/olMyttfSY9B65C+PKalnFrYnz1Hczvovej257uMD
	26HJKKiY0x8LFlnajXTGkcXoBIwpmRvEUhgo3qPx8NDOur//z5UAB0yZY6RL4YYxmJsXGxgToQk
	iVhHVihBCWkgde5FfwF6CCRjOW3tcxNDdSA2rbnNZtzxEz41vnsQxRNvsdhbN7A==
X-Gm-Gg: ASbGnct0/MwELlndS2fYtc/DOnbXwEjJXzvzpTdRLPtb96VymKj4cIrH3mX3pSzFiB+
	ZPcVxrlRsoIIebkeb4dCFNQwMvbxN9AuXyjXWaLW/f02JOdJn9+lKaQ5kU00kvNqzZYvO4V+ZOR
	mAEH58ymekLxgoHXrKEojOpOm0mMY4BCS0NFPalCXhcrgqPz38vG1GIL914Km+vtTzsxNHlEHkb
	jUNuWA0wJlfUOQWFPNQ85LBEDYk9Fu79UV6MEja1p4X+yhNhNHrLu0C3nUd1+3yMU4vm+cF6YVw
	XVMdbgzrBIRFhOYweKKbWB42zElgO0nkhnJftp0q
X-Received: by 2002:a05:622a:54:b0:4ab:659a:61b4 with SMTP id d75a77b69052e-4ae8ef7ddeemr103533741cf.14.1753571614160;
        Sat, 26 Jul 2025 16:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7WWgnjUVoC+j+r8iiGXo+B/JXfwcwJzO5Biv3HK91J2vigOSqz3jstH6i3gq8a+ZxhOoKwg==
X-Received: by 2002:a05:622a:54:b0:4ab:659a:61b4 with SMTP id d75a77b69052e-4ae8ef7ddeemr103533481cf.14.1753571613729;
        Sat, 26 Jul 2025 16:13:33 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.240.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9963b704sm16324771cf.34.2025.07.26.16.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 16:13:33 -0700 (PDT)
Message-ID: <03db5b0e-00f6-4647-a3bb-0593d9815400@redhat.com>
Date: Sat, 26 Jul 2025 19:13:32 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rpcbind 2/2] rpcbind: Add -v flag to print version and
 config
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net, =?UTF-8?Q?Ricardo_B_=2E_Marli?=
 =?UTF-8?Q?=C3=A8re?= <rbm@suse.com>
References: <20250605060042.1182574-1-pvorel@suse.cz>
 <20250605060042.1182574-2-pvorel@suse.cz>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250605060042.1182574-2-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/5/25 2:00 AM, Petr Vorel wrote:
> This helps to see compiled time options, e.g. remote calls enablement.
> 
> $ ./rpcbind -v
> rpcbind 1.2.7
> debug: no, libset debug: no, libwrap: no, nss modules: files, remote calls: no, statedir: /run/rpcbind, systemd: yes, user: root, warm start: no
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Committed... (tag: rpcbind-1_2_8-rc3)

steved.

> ---
>   man/rpcbind.8 |  6 +++-
>   src/rpcbind.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 83 insertions(+), 4 deletions(-)
> 
> diff --git a/man/rpcbind.8 b/man/rpcbind.8
> index cd0f817..15b70f9 100644
> --- a/man/rpcbind.8
> +++ b/man/rpcbind.8
> @@ -11,7 +11,7 @@
>   .Nd universal addresses to RPC program number mapper
>   .Sh SYNOPSIS
>   .Nm
> -.Op Fl adfhilsw
> +.Op Fl adfhilsvw
>   .Sh DESCRIPTION
>   The
>   .Nm
> @@ -141,6 +141,10 @@ to use non-privileged ports for outgoing connections, preventing non-privileged
>   clients from using
>   .Nm
>   to connect to services from a privileged port.
> +.It Fl v
> +Print
> +.Nm
> +version and builtin configuration and exit.
>   .It Fl w
>   Cause
>   .Nm
> diff --git a/src/rpcbind.c b/src/rpcbind.c
> index 122ce6a..bf7b499 100644
> --- a/src/rpcbind.c
> +++ b/src/rpcbind.c
> @@ -96,10 +96,11 @@ char *rpcbinduser = RPCBIND_USER;
>   char *rpcbinduser = NULL;
>   #endif
>   
> +#define NSS_MODULES_DEFAULT "files"
>   #ifdef NSS_MODULES
>   char *nss_modules = NSS_MODULES;
>   #else
> -char *nss_modules = "files";
> +char *nss_modules = NSS_MODULES_DEFAULT;
>   #endif
>   
>   /* who to suid to if -s is given */
> @@ -143,6 +144,76 @@ static void rbllist_add(rpcprog_t, rpcvers_t, struct netconfig *,
>   static void terminate(int);
>   static void parseargs(int, char *[]);
>   
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
>   int
>   main(int argc, char *argv[])
>   {
> @@ -888,7 +959,7 @@ parseargs(int argc, char *argv[])
>   {
>   	int c;
>   	oldstyle_local = 1;
> -	while ((c = getopt(argc, argv, "adh:ilswf")) != -1) {
> +	while ((c = getopt(argc, argv, "adfh:ilsvw")) != -1) {
>   		switch (c) {
>   		case 'a':
>   			doabort = 1;	/* when debugging, do an abort on */
> @@ -918,13 +989,17 @@ parseargs(int argc, char *argv[])
>   		case 'f':
>   			dofork = 0;
>   			break;
> +		case 'v':
> +			version();
> +			exit(0);
> +			break;
>   #ifdef WARMSTART
>   		case 'w':
>   			warmstart = 1;
>   			break;
>   #endif
>   		default:	/* error */
> -			fprintf(stderr,	"usage: rpcbind [-adhilswf]\n");
> +			fprintf(stderr,	"usage: rpcbind [-adfhilsvw]\n");
>   			exit (1);
>   		}
>   	}


