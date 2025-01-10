Return-Path: <linux-nfs+bounces-9075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF89A085C2
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 04:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DD916924F
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F33A1E3761;
	Fri, 10 Jan 2025 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JB8HSWR2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0771E25FC
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478383; cv=none; b=hLJ+FFKUuH5spzyNpQPoL3t+yvbCaMXmz5k5FxxjcAXxS1JO+7Im8NCknkMTuzoi2roCyb9TjLmKKmpsojYjU9pPHR8xwXb8kh78Wnq0MGvKQn1nuiI02tnPZVOvSm2IVKKI3aLa0NyTv2GGqCJo7YIJPmxrpcP0Fyjjp2eiO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478383; c=relaxed/simple;
	bh=eO9qA3/8ifU3K1qAWG9+/jWM0J19EBHyfEdTCwZPx8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQ13Dfsv8xY7omA+YxwMxn+Wq4ks99C3CHiRv16jGPo/p6PyeruwDUcGDggmAXuFRdFOCrd0oy79gVT8gccr3L3h6j/9Ezmr6zpPlUWwS1RmVvMFqFFq5WdmwwFI5A9jW88ivkpwwF5WTBTkfVDkkgJt8p1ytEQeYbnvnq5lppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JB8HSWR2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee0b309adso262435466b.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 Jan 2025 19:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736478380; x=1737083180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NT3GMHnGMUPgyBvIrXX2eIZQS9LIQ7g/foVqlCeiI5w=;
        b=JB8HSWR2baufp/g1ombS5eN2Ro74klSpVUiFXpT43/5/opWtW5QBQzcGlhZinIciOU
         ScZ4dKp8YzqJzUxMxB5trllUdwydJEsL3mkEs2lmh64LfAvGJ0cmn9e9AiMoLdbPUN+h
         6YiSTBE7eCGVZzAgScd/RgL2IOWDZouB3/VaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736478380; x=1737083180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NT3GMHnGMUPgyBvIrXX2eIZQS9LIQ7g/foVqlCeiI5w=;
        b=CrZ0+tz48MeUvtFhSYR0LLYQBpCK4WKDZGlhrGrrBRNotOIU+ndgUdfEbliScVbGn0
         fvwwlCVvFMHM4Etbn5+IthQ8+g7HHaNG/sDNDvHolU//1AFGpgOSu6qFSZV5yofVY4oZ
         yRNtixdpcs7EukEaTZzfkmupJMDyZw58p5VnwaLQI50N+6yzLITSlf9ppqM2d3j8Q2Ri
         tkoVRfAEvLwGs6rCh5at8EoDSrl+3q82pd2EM/FLFl+eVvgwlIW5crKSGzIvWcKj7EWS
         AN50EIheBzENF2O75yA8FxQnu70sHTWcT7kkc7SNTDK50+Mdz+JFCmYyNm1rJ+twsaqA
         FQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCWLE72q0YhlH1jNP2S0aXG4610raLtL9oTV12nYtG3byE50DhANNowce+v9bALKflyDFAbX9SiC3kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVhdu2+4zxhTQfN4sXN23ZbbrKrm8jvw4VPuS9su+effAgDWi
	l5CXlhVP7xptRKv7O0h48pas0aWIlmOTG8SX1vjf82wBXHKQN1etXZ1L1dIUxVSzbdQc9WLyWgk
	KJWC1Xg==
X-Gm-Gg: ASbGncvaiBNbVnimOANzyMIwy7wxwk/2SfLBGsj8H4U/hlwc8jnL1+z2WhHZASrTXWX
	4QD+3Tn9uuDL4+udhHcZKBeON/o5V4VIh6ujUh/Mp7Yczq0cXzQKGcX8xhUMpUWugVfOFKZNrZ2
	0gK2OXhyDWkA8tm0z4erALkbpLh/dSKB803IeB1Lfw0maKHq2TnEzCwyjrYHDUNxFNRBxp1mvut
	JuRN3p/ZRFuCe5fs/f7R47mZgNrKcQZ21PM+V8tmoLzCakNA2HUo/S/0GzQ8s0l1ow8JTMCEaC6
	DsuXVJD6RY4IKAjM0/lDl2Doe0cR/vU=
X-Google-Smtp-Source: AGHT+IFgQ/Vo0suAZxiwbKOnd6yF59E24ZPcu4QmM3kQhwOSGtQ/2GyBXgxT4n97JGlvkCTZ1tI5Nw==
X-Received: by 2002:a17:907:97d2:b0:aa6:96ad:f8ff with SMTP id a640c23a62f3a-ab2abc927abmr787666766b.52.1736478380135;
        Thu, 09 Jan 2025 19:06:20 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c956306bsm125266666b.104.2025.01.09.19.06.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 19:06:18 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaee0b309adso262431866b.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 Jan 2025 19:06:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBOU3w1AjVTQI0NVasHIe3gOVWEzLZMs6TkJ23QCKnndoG4N3fgqETPICPXdh8Iz0xJF+no/uAFUQ=@vger.kernel.org
X-Received: by 2002:a17:906:f58c:b0:aab:740f:e467 with SMTP id
 a640c23a62f3a-ab2ab67061amr690971166b.8.1736478377190; Thu, 09 Jan 2025
 19:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110023854.GS1977892@ZenIV> <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-19-viro@zeniv.linux.org.uk>
In-Reply-To: <20250110024303.4157645-19-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Jan 2025 19:06:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=whbsqyPw2t=OaCgiNKSSDs48hXm7fdGnTbDqTg7KTY-JQ@mail.gmail.com>
X-Gm-Features: AbW1kvYZQhGLGE_BMmhRgYKnvI869LDYbaAYYJtKtzXM8cY35G-c_oMO0L1sNfg
Message-ID: <CAHk-=whbsqyPw2t=OaCgiNKSSDs48hXm7fdGnTbDqTg7KTY-JQ@mail.gmail.com>
Subject: Re: [PATCH 19/20] orangefs_d_revalidate(): use stable parent inode
 and name passed by caller
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, 
	linux-nfs@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 18:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ->d_name use is a UAF.

.. let's change "is a UAF" to "can be a potential UAF" in that sentence, ok?

The way you phrase it, it sounds like it's an acute problem, rather
than a "nobody has ever seen it in practice, but in theory with just
the right patterns and memory pressure".

Anyway, apart from this (and similar wording in one or two others,
iirc) ack on all the patches up until the last one. I'll write a
separate note for that one.

          Linus

