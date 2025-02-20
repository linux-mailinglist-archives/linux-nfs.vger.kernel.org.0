Return-Path: <linux-nfs+bounces-10206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269FFA3DD8F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 16:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5644F1881865
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90721D5CE7;
	Thu, 20 Feb 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Ele8cKsI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9A1B6556
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063665; cv=none; b=ptW7WMcYuFORTfUB9FPJXBFz7CcdxHcdL1+gnBkbBap3F/+gncGumjWU5pXUjtrWVaR+DPJJx8O6drQLBNCM4FoaiG31EK8n+9JCHf6lC6L1LvpXMrx4v7Wx44kjAFzaSjLejSe2C4qsS152Nv6jf1CR6BU79mzM0epSid6IDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063665; c=relaxed/simple;
	bh=QX45Sw49DqWmVMlR4tXEGRM0noTXirnZFmIFacKpQVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NupOp1inYTDUmOwkWyK8pVuVQxuwUtsJ5CPogAjbKyyIxZ/ZJ/owQtlzGP3FIcP0Fyt4tBWrvlziwV0f1zfzYEqFEsM7WoF9N2uiR/d+ISZRmjHXPZeeyiOakkuOwrdLiLyMph9lrUv8bL4NCjMRG/F9YayntD/qFh6p1QnJKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Ele8cKsI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso1597289a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740063661; x=1740668461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX45Sw49DqWmVMlR4tXEGRM0noTXirnZFmIFacKpQVc=;
        b=Ele8cKsIT24FYjkrAo1OrXddZb0T9pGKeIAPMwU1Tn2ZAE03HbYvgNwIPpM9wDhJ0b
         DtaxgDorZvJYbcbEyg/OKsjotFUJkC/LTE22dZHd+IZIm0CZ4B6xsP8CZvAmVCommfYy
         h/NKq4y1/hUARtECAJJ5hVWUnfVzXD74eji7H5YvAZps04k8GNR0Kc0u++HG9DsGusoe
         7FXMef+WN21el/OWt83SQ+vemUpuFAOVtBLg6jGa+/0V5Pi8D6cLlNq1LDmbPTJcNSms
         OYb5RleQz5exsyk7xUvjlQ98lpigeLAeBPqJ85VOqmQVXTA4xM8cYrvfqfg8ZCFq36Ig
         vt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063661; x=1740668461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX45Sw49DqWmVMlR4tXEGRM0noTXirnZFmIFacKpQVc=;
        b=NMORpA62vHFMGtZs8R0E21dEYVvKgIarQXJIJ4urKjiJAzWirDnSesFP9zqetpU/Rd
         6JBKypPhZ1kpEWHg6MJXInm3a4XrXWHoe7cc0AG9G4e7iaXAGjGCSQJoE4PA5vBbGiz8
         nW94I1PomWxWa9Fr11s1Ak0bkXSmNr9W33Vy2EpJGNBKrfF4AbQG5ZFuFFLKQom1Z65G
         DbB697psCHLcv9pN05zwLA1yReMTV1srm+x2P9X+HNGAsE7Aobu52ctQEDhdx2Io42SH
         cdsKs7wHpMU5r50qVgJ40lUD+4JlgQQHrzah8aJAjoABTN8wbFaAIah4DOV3SpNKFKCr
         cLIA==
X-Forwarded-Encrypted: i=1; AJvYcCX823ig7OmstweDJUAiTlD0t6vXf84wYCjYFUlERHuVQMi+lo4qXmaSFsFfEOl4YdvOMOyJPmMZ7aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkeGvOT3fo63dR5acGSpIs+/GLtJJI+h83/GOmiw7iwUERSh8
	l1lWjjvWPWnaPIQVw5tS1pxQg3VOeLT2wpFUJpwWxitOHHuYo5Jb/u/O5K+H78I+OZA7ySjmK/Q
	9LFF+M+RKkKKw9pTDCJuQTk+5GVtkNx+0nOLeFg==
X-Gm-Gg: ASbGncudae2wRS0Zn+GlrrtI2wHQYx2a+f9cZcYTjeGZIDiiMw+CLGJCBq/MVVIt7xv
	xqvLzSmhgKNfVn0RDyZB+vkRFs1STgvAHdwYBeNcjZjG0oZm4Jt9RwXQvuURtA1TSBzGtqnmQg+
	At7gfZ2Hhe6bK5I3LB2dEO2ZS7MA==
X-Google-Smtp-Source: AGHT+IFsNIPyDQGc+75Qve6xdXZqYra68xghYqvPNR/a93wAgL+cet1YYKlnIsmF7J644V3bLmLkzN1ceWcyLicDD5A=
X-Received: by 2002:a17:907:3d8b:b0:abb:b1a4:b0fd with SMTP id
 a640c23a62f3a-abbccccfde8mr753397866b.7.1740063661328; Thu, 20 Feb 2025
 07:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com> <3978045.1739537266@warthog.procyon.org.uk>
 <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com> <2025022051-rockband-hydroxide-7471@gregkh>
In-Reply-To: <2025022051-rockband-hydroxide-7471@gregkh>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 20 Feb 2025 16:00:49 +0100
X-Gm-Features: AWEUYZn11RtW2auyLztupwrGFbfU0x95LBmhMBqsyNDNUcIi41ux5lVFUDQ1JfI
Message-ID: <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:17=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> It wasn't sent to me or to the stable list, so how could have I seen it?

Oh, of course, I forgot to add stable. How shall we proceed? Do you
want me to resend to you with David's Signed-off-by?

