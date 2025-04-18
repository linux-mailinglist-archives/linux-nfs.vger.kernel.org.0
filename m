Return-Path: <linux-nfs+bounces-11165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A310A92F9B
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 04:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7731A8A8600
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 02:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1424B266EF7;
	Fri, 18 Apr 2025 02:02:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CED266EEC;
	Fri, 18 Apr 2025 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941737; cv=none; b=r0kW88mu++Si2PdQnxegdMyMzcEU56M2Ct/yyZZwA1vlEUgYsy6n1JxnzAb5M7KfC/jbi8QBv2iL1R7NkEKq3ZO+ohD1diDb1sKNqosdmZDk4u4rxGrf3OwOhG2nfU7JK7w4fAIOS7u8DRQAC0Oz40jrabvtt3cSTEutHrHbbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941737; c=relaxed/simple;
	bh=tRfIomkNtUEP2kGAvsnaZSuhHpQOGwQ8zvOofAGsLSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qu75TqUwo571rVcIMPQYPpWEw8/JvlizsFhMYKf4JBZCevo2Gh4aFDi0TVMnCuVvsiDAK3DVMDBMQ73KZaSrwapXxHv7jlUPVKiGsyeKeO5QTmHtiS6P2KudpByRX53i3A1DZCLCUUkkYpnCb+/Pb6uNdChxMj6KdFypUqVV3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54b10956398so1728272e87.0;
        Thu, 17 Apr 2025 19:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744941733; x=1745546533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSUKGFHrQQ1ECv52Z2Qr0+8oDt1S9PQG3cqbPHUxCvk=;
        b=i1SdDJzcWkxi8wxzF3mifhuBs195BAwAbDPerZWZWfsyYcmXAW3etz2vbIwcTYfyk1
         QtuFkZTOBDuSPsJqgL+Grdp8O7jDReqW7sBHuYv/0yMT6Ltt+ARDnTAsSq1Z+VueXhBV
         3+VnevR7TwUhBsp33qdeQV8o1fjeJ2EmNdCwd2R5njSJeslgewR+P2eF8/X93IN8OgMR
         aaS/0L8lLuG9Gctfedf5K4iAUaVUmvzC58Us/GismtI5csIR6h+PMmawjyk83AcUQOnY
         gR4z3UeLBvIqfpj+/JYhedMWE7f/TX/GCeYgBoxTfZ4j3nWWfMDiuPJqIalS7jodqrZM
         HRPg==
X-Gm-Message-State: AOJu0YzpHoPVmF3+cmLHtGcaAZw0i+QfJgFVszHb7AbSpL3+Je0/keZW
	Y8c5mjJ+jFGdcSIBuZynzRACBNtDB65WbpUD/DPiDY4RbCZAmfF/6hieKN9x
X-Gm-Gg: ASbGnct1oiek1ZAhSy4g5ZbMWKmysr+hh6hbYHN0OEYQmdWJoNvwoeKVMG9iUwj143h
	cQ/B7kmB4ag8/CAD4Dar7D7XzWB3ACOOY9WJogRDDHgQCVuELUge5MuEk+4hOM9NfJlxfvvh17M
	0tw+dgQsbu/CZ3wnhPkgsk6hLwGOb+dOSfo+5+tWkGIJtCjqP4zyF7eLgYNDjS4VwjtpiG96ILu
	Dc43dr9p1qAvUATHNYYQfbyMw4TqBKPb+FjCr3MDowmgkcd8+I4QOwiHkFaG2pnx6xwteYJDvLM
	H00MbeJ+U2rf/3O9layLE4dUC6aLtAFpO53KL7SxkdC+MOROOnbVVmhNpnVYSzha5ExybtNxLWm
	2elHVlWS1iaki0/Ym
X-Google-Smtp-Source: AGHT+IGxAsqvg/ahVHtIlM35oRKjugTJ2ju8e+NCZwUcmaJJH1UsG9cp7AngfBAtMZvmeBvKNbfTzQ==
X-Received: by 2002:a05:6512:3b22:b0:549:8999:8bc6 with SMTP id 2adb3069b0e04-54d6e770a2amr222042e87.6.1744941733069;
        Thu, 17 Apr 2025 19:02:13 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e52534asm67721e87.14.2025.04.17.19.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 19:02:12 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so27505751fa.1;
        Thu, 17 Apr 2025 19:02:12 -0700 (PDT)
X-Received: by 2002:a05:651c:1606:b0:30b:a100:7fec with SMTP id
 38308e7fff4ca-31090e299a1mr1910191fa.12.1744941732365; Thu, 17 Apr 2025
 19:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418011009.1135794-1-andrew.zaborowski@intel.com>
In-Reply-To: <20250418011009.1135794-1-andrew.zaborowski@intel.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Fri, 18 Apr 2025 04:02:01 +0200
X-Gmail-Original-Message-ID: <CAOq732LZ6JdwRjniX8Zd7FzA4ha05w3n6jXm4Zm3XJjtQ-JJvA@mail.gmail.com>
X-Gm-Features: ATxdqUF_LjelGLiX-TReaL03z9swAs7swt8GWjNFrWW3xoZqG5VNbIMxUkLA2iI
Message-ID: <CAOq732LZ6JdwRjniX8Zd7FzA4ha05w3n6jXm4Zm3XJjtQ-JJvA@mail.gmail.com>
Subject: Re: [RFC][PATCH] nfs: Revert "nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS"
To: linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 03:10, Andrew Zaborowski
<andrew.zaborowski@intel.com> wrote:
> version is 4.1 or higher.  This attribute was apparently defined in
> RFC9754 as an extension to v4.2, never valid in v4.1, but it is neither
> valid for use in OP_GETATTR.

My bad, re-reading the specs this is wrong.  As long as an attribute
is not Required in v4.1 the v4.1 server shouldn't have returned an
error.  I need to look at the specific server.  Please ignore this
message and sorry for the noise.

Best regards

