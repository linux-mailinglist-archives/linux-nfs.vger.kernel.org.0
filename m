Return-Path: <linux-nfs+bounces-4998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0342938469
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jul 2024 13:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214F22813F7
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jul 2024 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF168EEA9;
	Sun, 21 Jul 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="WKVgYW4Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF91607A0
	for <linux-nfs@vger.kernel.org>; Sun, 21 Jul 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721559834; cv=none; b=MdVVAo1AYVVc3/SLBUzFy/pdG/uezNUJxzfsOTKsEyp26aCsECizNVX1IMUuG3NjzXiQMxn9f3W3hgHgQKzSrU9Npd+oBKHTJJEZ0UJwsK9LagESZxU+fUmibMgWLbUPIiAEKB7PM36xlKsp/1qzbH5Ufy0e+0nbhFishnsGM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721559834; c=relaxed/simple;
	bh=s6eBAf15lXoYZOMfq5xQtgUwUyBSEUwyxiHlB9ZiZjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQOpX5iOp76eSbppHTb0wfchcmkbN9HI5YvCO7mKoZxGBenYy/Ia5sgkr35OmNPhsDQ7We7wrRvPyV1dEPaqr6yQDgNMc3XncBr8xbot/Ne4X9yrh/nQ8BJNv25f+X0LEmVFDBj3ecragkkZbBgNboyYbLw3bRbDpGOJumuuqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=WKVgYW4Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso23497605e9.0
        for <linux-nfs@vger.kernel.org>; Sun, 21 Jul 2024 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1721559830; x=1722164630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQ9aaM096hTM9IC6hZCIC3uNZyeMVvdGgp6zQTb26uI=;
        b=WKVgYW4YNxlxB2XlVxHgEmA4pStqCvDYXIbltGcnrdjn+iaRrbp87e+aBDul/67MXy
         nvycxsbE4ndgktAyWNZZOcP2nWmzsYVUQXtM8vQB+wfOF6fZ2t+mUEW4VVLFIPnBsDjP
         U+TiBKrIf8E2HMjTi+XT71tVuIdCxrL586/spDrb0cDIrjLzN9r5OlsYdo0qBvgLIj1E
         fL6tNHdj/SGhyIZPB3b51FpuKmrnEJ2p4I9UCzVwEJKkdwyJVpFcAuSLEUqV1XOdh4X3
         niknQENJ5dpsmovmmMndMXXph+GLEX16RuOuE6BKKtAiq7DawXlMKnzrv7ugxs7egrme
         VRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721559830; x=1722164630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ9aaM096hTM9IC6hZCIC3uNZyeMVvdGgp6zQTb26uI=;
        b=tygLcodRByQ9my4QJoCxbCXUh4WIl8+/PfZn8q5lK5R8v7+1VEKVPN0Lbenbu9DqTt
         fOwqQg9hPOhP6q7Ief83ZCqbs08hcLZwPMBfIj7FwtKlfCKPPq8GUVb+cz6httqdrXES
         TcHxqtzO2wrVBnYU2EmRRmoUjiC4BfwxyBvkCtEtt4jYPj0nlYu7/4y9tw7SidYBgx67
         W8imrfsmIz6qeiUuDuKhF2G8OM9K1fxRVN+tFehlww8X11HemXBd9jZhibj+TlK58OTS
         1dQfqWJDIuqsutKyfU6RZOa3sSXtkRUG4P8EWZJpajTHjcWR8g8pAQ++I0JwQXcncYcV
         GSxA==
X-Gm-Message-State: AOJu0Yxs84yWzWJCOju57Ulz+2i2nMyOrPpxLAJE3kKLBZTV3VYgHjrK
	Mu6I8iJ/WpbygYnY7K2Kak1DdxLcYeIr7K6V6IxggnkhzRwLPolUm+4kYOqBkXkCgQ+xHWC2vMb
	V
X-Google-Smtp-Source: AGHT+IEtwtvkXxYMYsZbuKCjbiNhDImi+BvYQ70IZuHPDem3QSXmpWxt7WejAKZ7xHDX8/aW2KN4LA==
X-Received: by 2002:a05:6000:1972:b0:368:255e:7235 with SMTP id ffacd0b85a97d-369bae62859mr2591898f8f.16.1721559830336;
        Sun, 21 Jul 2024 04:03:50 -0700 (PDT)
Received: from gmail.com ([176.230.79.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ced33sm5744470f8f.86.2024.07.21.04.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 04:03:49 -0700 (PDT)
Date: Sun, 21 Jul 2024 14:03:47 +0300
From: Dan Aloni <dan.aloni@vastdata.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"blokos@free.fr" <blokos@free.fr>
Subject: Re: kernel 6.10
Message-ID: <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
References: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
 <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>

On 2024-07-16 16:09:54, Trond Myklebust wrote:
>[..]
> 	gdb -batch -quiet -ex 'list *(nfs_folio_find_private_request+0x3c)' -ex quit nfs.ko
> 
> 
> I suspect this will show that the problem is occurring inside the
> function folio_get_private(), but I'd like to be sure that is the case.

I would suspect that `->private_data` gets corrupted somehow. Maybe
the folio_test_private() call needs to be protected by either the
&mapping->i_private_lock, or folio lock?

-- 
Dan Aloni

