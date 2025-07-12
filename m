Return-Path: <linux-nfs+bounces-13001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013CAB02977
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Jul 2025 07:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF4C7B01B8
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Jul 2025 05:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341A1FCCF8;
	Sat, 12 Jul 2025 05:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="h8pme+2c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D01FAC54
	for <linux-nfs@vger.kernel.org>; Sat, 12 Jul 2025 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752297923; cv=none; b=OPYiyW5XHGbo5I28ObRAd/CaGMLeq+ZOuKgacNzumm5oywRbXusKZPfP0uWELIyBQjdwjgGA/gn3zIpGQMNa1bdvJu9aQo7y6hE7mTzYy7svvO6VheFLSGA7z0LWHr4Vht0/AEADLHVRMuBWliX48nkMq3aZvFE4a1V9fXaujM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752297923; c=relaxed/simple;
	bh=OzWsfRdh2rEvxUhB0pK+C5jZ3YphBuaX/nfPDWir2oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Upxog+7axXkf+ZPXmNeh0supo3JCTXmI+8OgdVmSEr/K1KrPdqXxTyp3FKNRDwpBB85WHxtrDn8Y987ukimK/YbsYiyo50jsDKBKd/o4C3A3Rz5nrtrIX74lGg+WrlbougEy39tJAZHMiP/Ip8zDf6Ic5hXNF52U6FCdbbNhLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=h8pme+2c; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acb5ec407b1so484174666b.1
        for <linux-nfs@vger.kernel.org>; Fri, 11 Jul 2025 22:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752297919; x=1752902719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boc987p5GRc2CF/iPi0/+tIlnyX8mVA51H3ddLq0Reo=;
        b=h8pme+2czoxn377wcsYImLfiK0tyLMEzxmutBmuVmkDk8qJ7SiJRAq5ev1OYIgo7p/
         wNpqumQQL2Asw/5KPuBwSITlG9t+kLHi8D5NS7VhTXZZig9/k+8WYDLGQOAgqc9hc/FX
         g43lM0/CMvVn7qq/PZu98O2cSpDASMdUf4Fk83z9KjSrqbEKrPjcXXuIMk+Nr/WBsGhI
         AogW7Nk+6sf7tOCC/TfCd8P7ocZDbnuyg9Tc/+sTvddHGLrtDmotXV58g9uwOMWTuaAE
         4eqrPAsDNcK5CxhTzzmiWXVOGiDgkYxncNQ2uX45Q87k0rS56AicNaeu21nIFjzREgc6
         rQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752297919; x=1752902719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boc987p5GRc2CF/iPi0/+tIlnyX8mVA51H3ddLq0Reo=;
        b=DZBn/UbHDZdB5Etzekaqa/QzG4N4CQIzgBgLA0f9K42p3xWxKbaub42XarvpTouioC
         HRa9VhlJZDoIIFs74lPzYn1rJmRJ1wxo9fxtswJ26TDIBBEiBJ7y6e1pi+TLqTJZGEtP
         4zKPDRytq0PnISxofJ9nEyWMlz5M/OxXoBIuNBhB7WnauLoZKiCvY3gkwpdEiksocWcD
         c2LZzI75GA8ZVIjvcYCLHml2BqfinX/1G5glJdxuS34sy4rTQLApRInpHGyjcU9SngnZ
         0c6zuNMQJbEdEzL/DytY3svMeGfnqZySFTsfBRq+TKIKlnQakr/nN65uru7yxuKJkErY
         LEMA==
X-Forwarded-Encrypted: i=1; AJvYcCWtX/8mX1XeuAfge6kH8zcwbovh7KEHuxWO9jmBIEMV+/0uF1sFMsrMjEdwQkbR68A7fJzn2rRt0t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpL0yOXk0BBpksj9DeGMYaPWB8ufT3ZccW0t5PH4U/2SuwgdU0
	t8CavqPro6Pga2ZOQI3PkLMGFTLm4lzjf60Aqyvv/FwxuH0KIVJxZRzGyofptImthQO1xsGwY/A
	Axgwu+E4WKH/dSfquwxzeU27NTkyJpYa5XFnHMgq5zA==
X-Gm-Gg: ASbGncvQLCfNtHGPLnO/PFXPTRUslJfzWRIn9Nw7JCO5iiB/WvA5whwwmHOQD/TWHvY
	NyXLrfYCsE1VavoYh4L5TD0XwESLmx0+mgmNxhufUz7B2oI4Ko/2vrls3ZR5IP4aVu+I0VMnEQb
	I6PLme0VO7YHZSVpk+CDrc3DL2Fh4MPuMNWcc6cGO4m3lmY0xnl+tc7XyOtTlzNTdiaQtw+V6nE
	ZjEWnllX8kUA3vKnohgHO6qkmZcQsFrHd8=
X-Google-Smtp-Source: AGHT+IHRqhss1VHoNOeBE3dSH85TBdQyutMEzLaeevjSPISD0eb6jad4c18gV5T9kZxrzRKcHgf2BSQwMPB2TaBTj0c=
X-Received: by 2002:a17:906:fe05:b0:ade:4339:9358 with SMTP id
 a640c23a62f3a-ae6fbc9275emr580496666b.22.1752297919256; Fri, 11 Jul 2025
 22:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151005.2956810-1-dhowells@redhat.com> <20250711151005.2956810-2-dhowells@redhat.com>
In-Reply-To: <20250711151005.2956810-2-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 12 Jul 2025 07:25:08 +0200
X-Gm-Features: Ac12FXwI74XFtOm4i3YUfybrD81gXwe_XUMrlDA403K5FZ8k3_E2nvLf9lzB7zA
Message-ID: <CAKPOu+-Qsy0cr7XH1FsJbBxQpjmsK2swz-ptexaRvEM+oMGknA@mail.gmail.com>
Subject: Re: [PATCH 1/2] netfs: Fix copy-to-cache so that it performs
 collection with ceph+fscache
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Alex Markuze <amarkuze@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 5:10=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> The netfs copy-to-cache that is used by Ceph with local caching sets up a
> new request to write data just read to the cache.  The request is started
> and then left to look after itself whilst the app continues.  The request
> gets notified by the backing fs upon completion of the async DIO write, b=
ut
> then tries to wake up the app because NETFS_RREQ_OFFLOAD_COLLECTION isn't
> set - but the app isn't waiting there, and so the request just hangs.
>
> Fix this by setting NETFS_RREQ_OFFLOAD_COLLECTION which causes the
> notification from the backing filesystem to put the collection onto a wor=
k
> queue instead.

Thanks David, you can add me as Tested-by if you want.

I can't test the other patch for the next two weeks (vacation). When
I'm back, I'll install both fixes on some heavily loaded production
machines - our clusters always shake out the worst in every piece of
code they run!

