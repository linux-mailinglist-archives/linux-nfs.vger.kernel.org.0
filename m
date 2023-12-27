Return-Path: <linux-nfs+bounces-819-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F5281EADB
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Dec 2023 01:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BF11C21388
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Dec 2023 00:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F13117CA;
	Wed, 27 Dec 2023 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s89Q63H7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D4810
	for <linux-nfs@vger.kernel.org>; Wed, 27 Dec 2023 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42786a44837so1039911cf.1
        for <linux-nfs@vger.kernel.org>; Tue, 26 Dec 2023 16:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703635498; x=1704240298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu/qf+bjEILFWY/j9c3jT6yosTe90CaF+xUFcPBPQ4U=;
        b=s89Q63H7lSjFUPRPHOXceFcPm0iEJAbmbB0LGyk7rLbsEEE8fV4NNU0JZqqcW9IwSU
         7uPXPXXVpW3VrAwVcKuuS1WN1c1wgKBrRwW4xWTI3YYlAnW8Ob00VP2oLt7jXKfw2Mug
         /CWajcNQpKVn/zqjVeh4HBj+kh1VOM0Jd1QUfGRGGhnpIQ/MtbefHTNkqyvmUulZQwx9
         0FS8gJZUu8V5fOmLbwe8GaGfHLshVCGyyiSEK1WJyJb6VS3K1AON8SQojEXWzxi9emyH
         OF36dxtABJJ5Df9NuC1fTYf8chct+bYyJfX8mMxnK9zDlZXIPa7NoinDUJqTzv8HrhGx
         gFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703635498; x=1704240298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fu/qf+bjEILFWY/j9c3jT6yosTe90CaF+xUFcPBPQ4U=;
        b=cxJu187zAC7Ah/G2crIqsVG/57inTy3Gd+nucgixtb2UTwn859THKOQbPcULnxxbyu
         jO3qV7xaXmFrmfg8VMQOnz82TRY8QtVqHWKWGTpod6mvaGtdys9ewDJ82rRA0TerUM+f
         eA3nAZmCm5+X0W7LeicUVSOfTO6wjLk0DqkbRKgubiJtHamrr9WEW1hA76H+8GwfmA8t
         QO25vH04mDZs9LmfrKpgxiMklHdckGc3Zg+PefhZ93soiH0QtE2TpINKJBFe2vHbd0WX
         AEQHkrX6Ffb/5dShDErzW7DdsF5uRbhf0gVXK28T68W1ad7di3U4pkX2FeYA03/zCf/D
         HoHg==
X-Gm-Message-State: AOJu0YypRhvuRJfhmpfA0/rm/cNBg0HVnawpzq7C+3U3ZXoF2eflcfcV
	xRnMwJDKnyZe5GQlzgerqO7g65zHVJTOdbag5ctQoIiq7ujU
X-Google-Smtp-Source: AGHT+IEQl2Oa5eL4dh0DKYuef29kServuq4hc+/N4CvN3WUh2I+yoAL6hjuh2X8ByYXtkzMvsWzCIz1ka4D44yIIoZk=
X-Received: by 2002:a05:622a:1344:b0:425:4890:6f11 with SMTP id
 w4-20020a05622a134400b0042548906f11mr583135qtk.15.1703635497954; Tue, 26 Dec
 2023 16:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226-verbs-v1-1-3a2cecf11afd@google.com> <fadeaa0b-e9d2-4467-97ad-63ba8f7d8646@infradead.org>
 <CAE-cH4rc6gWNcsgm243i=dXQhaAQsC4gEz15GEWZO4HB7Vki3A@mail.gmail.com> <12958640-e6c0-43d3-a710-48ba7873c8f5@infradead.org>
In-Reply-To: <12958640-e6c0-43d3-a710-48ba7873c8f5@infradead.org>
From: Tanzir Hasan <tanzirh@google.com>
Date: Tue, 26 Dec 2023 16:04:45 -0800
Message-ID: <CAE-cH4q2L4C6SHikUD5Le6K7T7Y39S9K1yvSFWvxCWq2crEZ3A@mail.gmail.com>
Subject: Re: [PATCH] xprtrdma: removed unnecessary headers from verbs.c
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hi Randy,

> Where can I find your current working list of what/how to #include?
 Here is my current working list of what to #include.

#include <linux/bitops.h>
#include <linux/interrupt.h>
#include <linux/slab.h>
#include <linux/sunrpc/addr.h>
#include <linux/sunrpc/svc_rdma.h>
#include <linux/log2.h>

#include <asm/barrier.h>

#include <rdma/ib_cm.h>

#include "xprt_rdma.h"
#include <trace/events/rpcrdma.h>

There was a discussion here about when to include asm/asm-generics:
https://lore.kernel.org/llvm/20231215210344.GA3096493@ZenIV/

If I misunderstood your question please let me know.

Best,
Tanzir

