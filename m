Return-Path: <linux-nfs+bounces-14036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBF9B440D9
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 17:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127421CC04B6
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17CB2836BD;
	Thu,  4 Sep 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQZGe6xq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877DE2820D7
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000635; cv=none; b=Lfdk8NdEaKXJou6R97h+BguLkDEJ99mSpZdHk/umyjPMlHSMVEC/15Ml7oZlXRVzoNFyTmD4Ae+KIZXoLNMA9RFq3Q4Y6D/FJmpICeW1IR2h11mV9vM78Yj56GOdEWRCOtKzmsOhLHsmMbkPt+tmblNko8DHa2ZLQa+f17zHSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000635; c=relaxed/simple;
	bh=n8vxhLjJ+2pMbKTb9Lo24wwUBNQFbjPaoBu/dAM8eHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWnCd6xcSNlLh3VtJf0c5+ADUi8dqtoRMeVcp78useBhcDFmP8rIVX8V+Qb3+R0S4iCFpdWDQwq0UYlwSdUTIduCkz4h9EpeWJMIAxpa+iTUWIRqlXLl3Vf7P3fxpOmD+awLVkA0T+CowzIK66GcXhUy0OcYTLwp6WsTcGDkBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQZGe6xq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757000632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enHjJyMY1tDg+blQcSMBol0wxlzfDS62E/f579bSqJI=;
	b=KQZGe6xqf3e+qkClJ4ro9DwmVw0TxKeA+2oEFTTBxeiqTMIMpGW0xJakD0MQamp6OL2S6m
	aVlV773T7QB/Vk40E8c9zajTVmm6j1T/fQt7dQQXCDir4TikknIVt+VAUfGVhYi88Yjr34
	u+yIORtNUMwqoPfk9oj/Oj+UdJDShX0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-9plG5IvTNmO2dJOCDLlR9w-1; Thu, 04 Sep 2025 11:43:51 -0400
X-MC-Unique: 9plG5IvTNmO2dJOCDLlR9w-1
X-Mimecast-MFC-AGG-ID: 9plG5IvTNmO2dJOCDLlR9w_1757000630
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-61d2adb3258so1134284a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 04 Sep 2025 08:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757000630; x=1757605430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enHjJyMY1tDg+blQcSMBol0wxlzfDS62E/f579bSqJI=;
        b=FMfYNeLY1IuBX3GY2Z3yIcaq6KdXt9mgz8dQ7Sk+02JtxpgyDsZLqlyVfgawiNbLI1
         pwCaZ7kkMUVu6dXHlEDiR2ShB6h15e4FFXiV4tzgWCx033ev0ytoZR8GjN60m298VgBD
         at+35J7PNUObIQLwO+2ya+yooUdczNKEMtXPAUQXVJC2koy1HFygGVslDiThSCjqc20D
         XmY5+F0Dy9l3VlRFWOLnvgMd3E89bgU/7CGBw5GenGia4XUQqcrVBB+RGjzum5pU0fdR
         AMWlSwDLB2sqmcaFnnIkQuVWoiZbMjowQ8pOKrEYGgNRCEwHYQbGR4xY4t8+2oE1f0Eq
         c6ig==
X-Forwarded-Encrypted: i=1; AJvYcCW4jHDFLcaVjYFEcNjtrbIGqSK0H/BWnR3vdLObUClN18JxNYsGeErSiDDZKPS1XQwO1nRz50E2OoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7gbbNAEDaOl/E1lcLBYKzMsypJDUXz92OkQM+lpKBDIH29+M9
	pZIN02OEkqdgCD+HpK/WE78p+yhztbksOY5dzBtLiT2yOqU4OA8tSzem8c/Ds6+z0tkKQCwYF6X
	OpEwF46QKSBWYMJlTZvnWMFGFApB2OoImKYQXZpYNc8HFK+MRfOLxb2XF2jUSMawqd7SdNMXDmP
	ciNbSrqBDF9BUtaXj8n8a3HFEOSgNfNEk4Pxzs
X-Gm-Gg: ASbGncuiERiSUajBNfViPAEHLAOwv2UdjFwSKHUt4jw8u27xGNo2sXSiQwoAUseiSdN
	Cx8q8Sf0ZmwBi692uvWPq9gPrEqalsi2+yMo2RXrsgZQNjeUz/vbkJjKv5N91ZBh1Wwd5hVZ7Qx
	wigS6Nunibn9Hfi1h+a8xH1B4+w4/xFDJGnSulr1SKtrttHfDnl5U=
X-Received: by 2002:a05:6402:5057:b0:620:d826:b4c3 with SMTP id 4fb4d7f45d1cf-620d826ba9amr507434a12.0.1757000630047;
        Thu, 04 Sep 2025 08:43:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY2E4sFC6dFu9viq/+nrzGDApCwRqiYi2ZKyjRqUenZB6wxoVw1MZtGkJ0i05y+wIrKfyhfgHqcaSUdSvCiOU=
X-Received: by 2002:a05:6402:5057:b0:620:d826:b4c3 with SMTP id
 4fb4d7f45d1cf-620d826ba9amr507417a12.0.1757000629573; Thu, 04 Sep 2025
 08:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903155335.1558-1-cel@kernel.org>
In-Reply-To: <20250903155335.1558-1-cel@kernel.org>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Thu, 4 Sep 2025 11:43:38 -0400
X-Gm-Features: Ac12FXxltCsTxwaJlRGKiXgkAA6jbtpyzU6nyzKy8_A2UwDN0CqoS5LjLRle0D0
Message-ID: <CACSpFtB7CSkakYL5FZj_6L4dgj2ybBMVzgqX8kWhZrGBW0GT7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1] svcrdma: Release transport resources synchronously
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:53=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> NFSD has always supported added network listeners. The new netlink
> protocol now enables the removal of listeners.
>
> Olga noticed that if an RDMA listener is removed and immediately
> re-added, the deferred __svc_rdma_free() function might not have
> run yet, so some or all of the old listener's RDMA resources
> linger, which prevents a new listener on the same address from
> being created.

Does this mean that you prefer to go the way of rdma synchronous
release vs the patch I posted?

I'm not against the approach as I have previously noted it as an
alternative which I tested and it also solves the problem. But I still
dont grasp the consequence of making svc_rdma_free() synchronous,
especially for active transports (not listening sockets).

> Also, svc_xprt_free() does a module_put() just after calling
> ->xpo_free(). That means if there is deferred work going on, the
> module could be unloaded before that work is even started,
> resulting in a UAF.
>
> Neil asks:
> > What particular part of __svc_rdma_free() needs to run in order for a
> > subsequent registration to succeed?
> > Can that bit be run directory from svc_rdma_free() rather than be
> > delayed?
> > (I know almost nothing about rdma so forgive me if the answers to these
> > questions seems obvious)
>
> The reasons I can recall are:
>
>  - Some of the transport tear-down work can sleep
>  - Releasing a cm_id is tricky and can deadlock
>
> We might be able to mitigate the second issue with judicious
> application of transport reference counting.
>
> Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> Suggested-by: NeilBrown <neil@brown.name>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/svc_xprt.c                    |  1 +
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 19 ++++++++-----------
>  2 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 8b1837228799..8526bfc3ab20 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -168,6 +168,7 @@ static void svc_xprt_free(struct kref *kref)
>         struct svc_xprt *xprt =3D
>                 container_of(kref, struct svc_xprt, xpt_ref);
>         struct module *owner =3D xprt->xpt_class->xcl_owner;
> +
>         if (test_bit(XPT_CACHE_AUTH, &xprt->xpt_flags))
>                 svcauth_unix_info_release(xprt);
>         put_cred(xprt->xpt_cred);
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrd=
ma/svc_rdma_transport.c
> index 3d7f1413df02..b7b318ad25c4 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -591,12 +591,18 @@ static void svc_rdma_detach(struct svc_xprt *xprt)
>         rdma_disconnect(rdma->sc_cm_id);
>  }
>
> -static void __svc_rdma_free(struct work_struct *work)
> +/**
> + * svc_rdma_free - Release class-specific transport resources
> + * @xprt: Generic svc transport object
> + */
> +static void svc_rdma_free(struct svc_xprt *xprt)
>  {
>         struct svcxprt_rdma *rdma =3D
> -               container_of(work, struct svcxprt_rdma, sc_work);
> +               container_of(xprt, struct svcxprt_rdma, sc_xprt);
>         struct ib_device *device =3D rdma->sc_cm_id->device;
>
> +       might_sleep();
> +
>         /* This blocks until the Completion Queues are empty */
>         if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
>                 ib_drain_qp(rdma->sc_qp);
> @@ -629,15 +635,6 @@ static void __svc_rdma_free(struct work_struct *work=
)
>         kfree(rdma);
>  }
>
> -static void svc_rdma_free(struct svc_xprt *xprt)
> -{
> -       struct svcxprt_rdma *rdma =3D
> -               container_of(xprt, struct svcxprt_rdma, sc_xprt);
> -
> -       INIT_WORK(&rdma->sc_work, __svc_rdma_free);
> -       schedule_work(&rdma->sc_work);
> -}
> -
>  static int svc_rdma_has_wspace(struct svc_xprt *xprt)
>  {
>         struct svcxprt_rdma *rdma =3D
> --
> 2.50.0
>


