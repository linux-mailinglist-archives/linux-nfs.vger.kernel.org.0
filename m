Return-Path: <linux-nfs+bounces-8669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A9D9F7D51
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 15:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10A7189225D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2024 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E9578F2A;
	Thu, 19 Dec 2024 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB0WblvJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0B41C79
	for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619669; cv=none; b=NS9Nd/5g7GmoobPOrqrL5X+uOnN9af/LMn50xNDJ+nyeP+/MrCfXW+J8ugwwFAwCSHq1h/56HV+/5eIM9Fg6L3a8a0G5hSrF1TMIh5/baInuJeDmN9JXc4GLgmR8Bizayv/YMoDe/bi2Fr3EHZHAdA2qWDsKU3RkJjF/mp1Kxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619669; c=relaxed/simple;
	bh=rcL0hclPyyulInB9cHOpBwSBJ74J8/dEBXXx4jcQuXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XWTUjsy28fW/mCcru2ZFXyjE2jNHsbne7X4YlBdqKpHE2xRnmmtGDPynTg3V+wdpungFdullyzfHUJEphnSdXojiZ7AbTt4m38f23b/TdWQeGwO0HYRBJ5L+ijhzWlPLO6lU+yFLblIuqibTx2wDnmhLiVW+Jwaqw7LdKEYuG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB0WblvJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa543c4db92so169069666b.0
        for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2024 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734619666; x=1735224466; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwQSCMetfXaevjYC33zeovLZbLIVkTcIl4Zg4fjB5ps=;
        b=YB0WblvJrQAvn3clc5d8Jkurv8CmZDwEAyk5olKwsRgEHA3XUde5gc3feOWSDIe0Ct
         jsVf1jwCwCrNbij/cUykPVsZPOK6SP3TZhg8bmwVQgd6RPaty8NkWEzsjGXiW1WxeCok
         PVMmqsq8FnKFk2ZGCfcf7YHtxLOz/dpwrYv6t2JIhgZlL2LA03lXcPdM596CoOLATh51
         no4BMNfRec6WKLTmjwwptYg4f3knTHOhBpsFo+3j+MEsksJvhvYwrJ0OEti5z7A9twYV
         wwhcEtMzqP3jOjcfkQRGU6MASSbEvw6NYvj7RhtOT4R/hKWoDnUJTsX+RsaAw72jkAz2
         e9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619666; x=1735224466;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwQSCMetfXaevjYC33zeovLZbLIVkTcIl4Zg4fjB5ps=;
        b=JAEH4/lqZw3eStPHZL9ZtMKobMIFuIyXnBJ8/QSoZVVQXgbZN3cxrqZzGstx9/H2IO
         Taab5F4ZFRoghyfQXqs/0WYEXzsXwPa5ux/+5d92doidYwNoZmSZ5A6bU07S2yDWGCZD
         bUvihq3V5K6Gd9ttkrqhGiTcPToukm3WwoXwBA7LKK7C1rcJNdT9a0ajWWQgfAOpvj5q
         vTM4zlApdO8K0yhEEhjalM5yoSpf4/gtcCsXAx6iRt5RfL9RUrivEywd7Bh3W3kYJFp9
         REyrBu21ZIOL0hEUMhLR2LQDRLTGA7gGai14k1TproOMNGOt5ZMY0RfWHqGqQ1rE5t6w
         hfIA==
X-Gm-Message-State: AOJu0Yx/RznTQTmcCfWj/0sISm76DeDUoirbRS1otqeePPCXI9AdnzfK
	Ca4danoByy/Sa4tnkeoR12tksdxfXrzW/ij/m5HE8ylZz+aVJUyAq7qwY4puXfqDq70+Js+/km3
	BsIfF2nub4ghLFth+3Jn12bCGvIfkFma2
X-Gm-Gg: ASbGncvmGa+4Tmm8USvk78502nZXWZPCaQHUtgxhlv72fs5wRXONNlNj4iwAdjPWA/4
	DZpXsMTWUPwXYw5dZbj5/KLG0PLwqHBfUAEw+Vg==
X-Google-Smtp-Source: AGHT+IFkx+CSs7wymeZ4LAPOgN1gZhTlcfvk25dMIcMxRfACJELvjqM0hVzBB+EjgTLM+hnU/FGa1110tYMUDk0VCyg=
X-Received: by 2002:a17:907:3f89:b0:aa6:80fa:f692 with SMTP id
 a640c23a62f3a-aac07af1b33mr327800266b.49.1734619666161; Thu, 19 Dec 2024
 06:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com> <CAKAoaQ=d0RUc2CGSGDej0yYQ5QMWJTEDSXd_Ox3WXx776xzrhg@mail.gmail.com>
 <699d3e51-49b5-4bcd-8c13-5714311f8629@oracle.com>
In-Reply-To: <699d3e51-49b5-4bcd-8c13-5714311f8629@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Thu, 19 Dec 2024 15:47:00 +0100
Message-ID: <CALXu0UeZu+Xu1N8Tr7hTPghF3jrg4X9NMqQ4YHiH+jCL+7bzuQ@mail.gmail.com>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 16:21, Chuck Lever <chuck.lever@oracle.com> wrote:
> >> IMO, using a URL parser library might be better for us in the
> >> long run (eg, more secure) than adding our own little
> >> implementation. FedFS used liburiparser.
> >
> > The liburiparser is a bit of an overkill, but I can look into it.
>
> Here's the point of using a library:
>
> A popular library implementation has been very well reviewed and is
> used by a number of applications. That gives a high degree of confidence
> that there are fewer bugs (in particular, security-related bugs). The
> library might be actively maintained, and so we don't have to do that
> work.
>
> Something like liburiparser might be more than we need for this
> particular job, but code re-use is pretty foundational. If liburiparser
> isn't a good fit, look for something that is a better fit.

I can have a stab at this unless Roland objects

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

