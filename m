Return-Path: <linux-nfs+bounces-5127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BC93EF25
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 09:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E2C1F212D7
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 07:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A97E126F2A;
	Mon, 29 Jul 2024 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmakOytx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76CF1EB2C
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239751; cv=none; b=qH2Mj+lEMGzHHnu6FY1Q8aKfq1ffF9q5DjTcRToB/YhhTfxBnQOh6kdf0JJ9v3tAStms//TpWExoDrePSY9Pt/0W5GABccbgVTUvG/ldVtu0sKzGhBvyHJ+qzS2P8tUPrAYF+WB7iei5XV7Uus55v+XJ9L1eWSodxDOoSpz/70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239751; c=relaxed/simple;
	bh=/l0OpKKDWq7k93HJSE5CtdQA9nd+8ITjB0XjRT4IxJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDbkKvHCZSNOuvjfhdKbfIZMM4ou+pJNP7JtmovJQTOlNqhVLQ42zai1T2Xjw7fndccqltZ/szEaRyOtUeHNXepdHmrNBkJczO5eN80bKGCi5OESCKbBDIxB5+RYYqmaVYL0StsejXW9GU7/6sNTFmAfSiDllAPeMEAUS1gpRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmakOytx; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1586535a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722239749; x=1722844549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l0OpKKDWq7k93HJSE5CtdQA9nd+8ITjB0XjRT4IxJ4=;
        b=nmakOytx3unj5cL/45RW4KtoMayMCaCZXBsQYSf0DEaMZJwG8meeEpv+kp9sE8qNqU
         OdV00kdmuNDgevUQEp5glsgytIgkDkdHNpHt/wSHk+aVWz8GG1rrw+g8DPhrbJAFSmrf
         2Ebccj0N4TQkSCHPmVNHW60jMlkLaOR3zASNnfOS8cBTardF5IZTFLF84gu/scxFUnkI
         A+JErzxdSaXrz/kElRs09QZFKXfje0IieCCiz76hkc07UZahbWFBCPxO5slmk0OLqerV
         7hb25V39d/dU6X7FtXco0SQUbYgRVmvGavR8vgZRaNlhxQ0zBVJc39WgeXR63WNLhrNi
         rwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722239749; x=1722844549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l0OpKKDWq7k93HJSE5CtdQA9nd+8ITjB0XjRT4IxJ4=;
        b=lKKfjS6na1QJEF6AlLGjIqR+Ybxu2IDmPoY2NBef5z64Whg2v5oiS/WCVMw184sadr
         9Q6DF6oqdtntJvEexz6dvNTLpeH92YazNceEd5Xwo/5sKyqpYmd3OXS34DkVTs3fiMjx
         tCvle8cxPGZZ3tuzgGyFwLkrdSQoAw6YRl/NgcK4R96W08zbhBn8fkE06FpOu0Brrdu0
         pTggsiwhulUq9i+sYfajTHMmLFgw7GVfBMIRPli45rJyDSD2RhJcU3bPjDT+L20ikDbd
         G9f+Qx1lRfLvlcNs8nkSe+WGpXXHpdQkHbfnPeXgVxXWN8FLygwEa3KGtwvEUfAzIpcu
         0/mg==
X-Forwarded-Encrypted: i=1; AJvYcCVPnjAtDAabpcxtK2qdc2yyCz4K2U6+mqibsKg/hykt04rmjFOZFksjocRvr6Fut/Wp56GYNV5PYs7qHrXR5R0Ku1nNEDN6eT3L
X-Gm-Message-State: AOJu0Yxdnwpcv0ej4ObN1ERLLlAI4PUaonzl/XJIeg6mbGee8114PtlU
	MWZUBdmzIfNhr75nUepLLJzigE75YK2EwwbmQEyBP4J1Jsx6bx8RbhxYVZpPHju00m3yO7B9IbS
	cfTeVZPB7hn3dkl21RsSGvQ2UkVY=
X-Google-Smtp-Source: AGHT+IF3XngYCsyWvj2u+FJL5php5esH/7Oz8DZfDENFLQHWn11k9H/WjmtQUjbmGp8VDG+zDQUIw1fBfFyo6q9vgcQ=
X-Received: by 2002:a17:90a:8a81:b0:2c9:69cc:3a6a with SMTP id
 98e67ed59e1d1-2cf7e09cf34mr4795625a91.3.1722239749082; Mon, 29 Jul 2024
 00:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728204104.519041-4-sagi@grimberg.me> <202407290814.7REsmaH7-lkp@intel.com>
 <aa94fd00-0a91-4924-a943-2e21e6da1df8@grimberg.me>
In-Reply-To: <aa94fd00-0a91-4924-a943-2e21e6da1df8@grimberg.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Jul 2024 09:55:37 +0200
Message-ID: <CANiq72nsDdvrT_QpwD=t4euwpay9E25W=v2iPP+6LsZ0M6A7Gw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] nfsd: resolve possible conflicts of reads using
 special stateids and write delegations
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kernel test robot <lkp@intel.com>, Chuck Lever <chuck.lever@oracle.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Dai Ngo <dai.ngo@oracle.com>, 
	Olga Kornievskaia <aglo@umich.edu>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:23=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> Its not clear what is the warning about here...

Yeah, it would be nice if it said from which "step" it came from, i.e.
from the docs. Or if `kernel-doc` prefixed itself there (like
`objtool` does).

`@inode` etc. are not parameters of the function but are documented in
the patch.

Cheers,
Miguel

