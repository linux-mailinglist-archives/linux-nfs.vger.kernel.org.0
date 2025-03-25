Return-Path: <linux-nfs+bounces-10874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2EDA70BBC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 21:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0AB3B5F06
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D3C266B43;
	Tue, 25 Mar 2025 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Srq1ysR9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAABF1953A2
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935658; cv=none; b=TsDi/WBWpzqByxP4yeH9ViYOpcTMB9ZYo8ZqYDN038f7HXITMoyZYOrjbrWvjx7zOkuVRJ/Yu7HMTHcpQHk2FB+q6Y98yjFawsOEdwiIjawf86seTjj8PfuQ70NCWqfBLQK84hvQCSKoILGcybAIZwF2y+Utg6WDJ/t63eXj4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935658; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2fbNkT2c21ZtGmQx6EkpvNXf/49P4dVUEdPGWXcCPfRfveWpKXi/rmI9XO/aF6hdq+yUBnj2hEVAWXZ4EnBFtXxSOdsgkM6zMRMayZFdq8tsqGmuzwXHnWx3DDbsgW25wMsQZfQEcuFCNUXE6hyytE47JY2LDnZ4MtcQKxNRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Srq1ysR9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54954fa61c9so6939620e87.1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935655; x=1743540455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=Srq1ysR9x7kyZz8B00fYc4hFhJIg2V6o6SN95SrwdocE8Uof68a0Vv1uG1rtZTSJSN
         lHRdzEgWzYVn8KXN5jbb0Ii/kMx7Itl2fBFDzmIkreVMmGAr90cdVFMIYb0wswxdIAVF
         EMJ1c14Fh8dngFs9DlWzbiTB3aQI3XXoDLT28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935655; x=1743540455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=ta+BJtL+NuXnKv/WJuapao9Mcmr98QSTCCskP6HUzVWSzzMTj14n52SUCXTJPABUfL
         KMwpHpIvXwhgKJKPyuwuyk9XpeFvSguDAUNX6BzandyV62eWG9+RIm9dZWjBhyvqboEc
         lchjFnMs8g6emO+/TVhTlXE2Qx1oU/ZP3cxWguwEEbzLTv6vG6aMBS/up/4kP2xDouKc
         72Ygvk7jx2UtKVwByvYA2bqkJmBCP+6rt2M9WeifMji2s2AgmRy6VX5TS9r9tXDSS2nu
         ZqVAFTQnS1LDGmmok50/rIVC3BH0jJhtTd3f6UQcZj20urR05/79hgUA0tngRzHmPTx9
         Rv6g==
X-Forwarded-Encrypted: i=1; AJvYcCXNcZPNf/TS1EIw7e+LeF4cg4gf2JJXlZlpcGijz/RWbObj9xwtraF4gp5OrO+Ohdoh81ROK1QrhYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJDfrlfR7nwOObd5w019Hj8U8NR0icHB1+2n6On5hg95OuHHy
	kPpFO7kL9Wx+DoDq2QuYxyTPUTKzo1AjsPxzeSUOjDkGagqMMRKqV8pCet17AvmN0LPBgFgtt8D
	a071UXA==
X-Gm-Gg: ASbGncsAp6WYSSgBApDOBvjAD7aQ2tXOda4CNw/kgWDratQRKgWhkBQV+GLbJMBj1OS
	KOGm5NsgfWEiL0xe5KgrydS96F9CVhY1uI36iu5IepGQ3aMCmVBKhazgDZ6a6i5pA1oN2XqbqiW
	iVLmskIg3lsFQYLMEJ2ItSB9AM0InFsDUqstbgcEKCCD0XN61TOTF/T1TDKBHAhyls3dloKLInw
	wMtfv4/6XrVHAaDngyoyITLIJLRhcAkZIBxQulefltc0n2nJ8Y4ND2ZHyyvyCjNkL709toCtCs0
	uuJMrx/H4KjWay4XtVq/mT+KdGoCc9jy7a2Gr9jDGPz/bZ/5d+CiVQFwe5+GNKL6QdP9jZlvBOz
	0RzWnBlYFFNwJUD2Rhv0=
X-Google-Smtp-Source: AGHT+IHn7oWen6jfpYei3evNO7kj5TAYs9WZAsokaxLcQqWUwTm/W8QdKZo7fHkd3fct63Vt/j1MDA==
X-Received: by 2002:a05:6512:3512:b0:54a:fa58:a6f7 with SMTP id 2adb3069b0e04-54afa58a915mr576926e87.24.1742935654595;
        Tue, 25 Mar 2025 13:47:34 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6511672sm1628091e87.219.2025.03.25.13.47.33
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:47:34 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-549b159c84cso6814497e87.3
        for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 13:47:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4PUpItwwW/d2+eS5bDxjMdC60Z3Ch7rEDLdb756JzNIhD7hwXWLb7vBdryp/BI47U8rU1qs/er/8=@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus

