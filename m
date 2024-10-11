Return-Path: <linux-nfs+bounces-7043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB0999915
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 03:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0FC284BE3
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 01:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474EB6AA7;
	Fri, 11 Oct 2024 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OdRM6saY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908774A33
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609655; cv=none; b=b6rPimmZvUIe9g92GZYcNvohWpNqth/JBpMTpQqWHSmfCM4mHj85RX6lMFlatD/Fp4GrVm5P49BNPvN99UGQThW9O68WeYg5QdqYyGRrFtDNI8HUII4EjL06f6ihAl+vF3FeOO+cQiBAB6yljk2kAYdzC0czAWOCzpcr0tN+ZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609655; c=relaxed/simple;
	bh=J21f4ExjS1aOz7pOzlm+buIPn3KKSC2NKTl2Put8zxI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=rn0oZlbpbOxAj0CAm1MqkHL9gZqu3VazynViPaQdnwsxPG4eFwxUD0Df+PXXKifvBMrrYwvh7pHfWZEHdcnu+VtTFOEbK1NohtO4hhRsfTVtp1HAO9glRm+5PtbKc/LttfXAAkdXMhtiyk7X+H8PKTEaEdLhGHwm+veUxEjkAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OdRM6saY; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7afcf96affaso77437885a.0
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 18:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728609652; x=1729214452; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwmxlHyqdcIkfUbxcldjXD3k5eAHPqyJ6cSsNTro4sk=;
        b=OdRM6saYOzff707QPH60ilbsHrj89rR5vXqrkMmdGK3kWhU8UP4h76oh1W472fE1yG
         6hZRvvmjaGGDZcFUhzOSyB89fotmLDgmWqV3e8zLWVtnyOiC96KLiy0ssZT7lhj+7BQM
         P17gT1yNuLnGOns2odyDTewf7lf3vDl9ij0lwXa9A1PqOmDPBja9h0zNObxkdd2cING3
         y9V6ab1/Kuu2hH5MW2uPAg68cu0A4P+PF+48Jufa/jTt5ch9ENWWxSSFCbyioT9Ax0FJ
         LA3RzwtQBENFoVEn/qEj+uKy0c7GwG+nrQKNMTBXb1tS2UFFzA1CC35jhf/XzHImZRdM
         umJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728609652; x=1729214452;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UwmxlHyqdcIkfUbxcldjXD3k5eAHPqyJ6cSsNTro4sk=;
        b=i1jYADV5CWb5udfLwkXK+1yyB34JHs7JQ0+TFCbBoAlUZU+cdpm1Y031kuf1JqPCXQ
         +96AQnNEKM/mxXNJ0KxFqbjBqwsZoszMnMsCiHZcB9qua2v7Asgk9YoFAEHR+jO8FBsu
         nkt1l6XpfwLG+F73jiuY9sIcMy+LhTSIC9tQ9T6TJ1xRTXmJgjsmqkjWz1HnHsJO0I3O
         TDl6wh/BOJhJh8KC0G2i9WukDGUnyNFPJR2g4syQ5X6tLWN8K6AbkCxqJnebEONNjnnk
         lhj/M21ZNMdqpJn3obg9haYO8Srk5wQGIGxE0IdiYOZpBmqUs5DeZmb+GYXrqbHxUhS3
         fFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWo0UM0tLxPL73ir+8NhBKraxZjjRaGd/KdLrTwrqx0SvxF2d35v+foNafnErBIrnFDeisBy6qlIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSi5zUo9cWdNzU+F5m34QcepHVESOjRcbSDZ4mjc5qbCyhMJc3
	tsS1dZGifsbJ5rk1v8SMQB67UxRwjDLA/6axHafqv6y5PZu0Wyb4zXH130HYzg==
X-Google-Smtp-Source: AGHT+IHsP+qjIfAHxSjbfwyU9Ll/Jk/YZJnfQHNgATTxrgV21R4CyfxNf0EaoX4MDa5EPoddGmwvtw==
X-Received: by 2002:a05:620a:31a1:b0:7a9:b744:fc38 with SMTP id af79cd13be357-7b11a360c5cmr198405385a.15.1728609652412;
        Thu, 10 Oct 2024 18:20:52 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1149894efsm91601185a.131.2024.10.10.18.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 18:20:51 -0700 (PDT)
Date: Thu, 10 Oct 2024 21:20:51 -0400
Message-ID: <1fbc3e320cccdf2264404f51f2e1131c@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH RFC v1 3/7] selinux: Fix inode numbers in error messages
References: <20241010152649.849254-3-mic@digikod.net>
In-Reply-To: <20241010152649.849254-3-mic@digikod.net>

On Oct 10, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/selinux/hooks.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

