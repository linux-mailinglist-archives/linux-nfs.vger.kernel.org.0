Return-Path: <linux-nfs+bounces-18962-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MZjDim+lGnHHQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18962-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 20:14:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBC514F8F0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 20:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 538D8301D07E
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A7376484;
	Tue, 17 Feb 2026 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGc6WYI8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08218376479
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355662; cv=pass; b=I+njBP1jJnVLbeuFRHnawJ9mvNh0y4Hcczc1yXsu5L86+wdh6nXHSD9X6i86PrMDdPMBSxyaP1VTzUXU5LkEzOEzFiGFCmWJPjn17QDTBM+siq6Ox925NKqugMfK2lfjWTq9YqSnllgESujR0HMXf4FlptupUb6mrMVgMj3TK/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355662; c=relaxed/simple;
	bh=aQiWyVSftilCOyVcfGMO5Txk9dV5oTrqKLEhf2u13ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0nODsf14WZhp8ft9AzSVRMG0Ow5F6ZN0I0WRjtaDLgDjIe2puMTktbE4cHmvlFdjPJ/aZERONa4/AxyKrSKYxpRlO5aGMfC1l07+jBC7HJvyagPUFuXLJ1EyUCIC1Y0gTs+whYKDoyMjngtiob7fjKxICCM1r+/PpRC2gUxifI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGc6WYI8; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5fa26e497feso1320073137.3
        for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 11:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771355660; cv=none;
        d=google.com; s=arc-20240605;
        b=GvJF3iUxaXwURv086w9VMCOEq6aDKJI4wQhb2a+JRquN86Q3vnwqNjTdNj+do9oN3+
         gnjtshfPVZXDRq4FUAyzhODuHaTCdPFCEX8Bty/VYWXqoUaFGCk17g+2IA/srspXrge/
         mDDjx8K4C/4+YWBODlwbR5oXX0ZuI9jY+64+wNy93beBhROUzlR1IualQNYI2eoxvk+W
         wEf+JzkNcucDdsFUmSoCN9A8nuhOVYrgusd4BaXTJBBKmJ8Y/g8uVDC52cbo5EgTofBC
         870X8BWoFoMuXBpEbkcrI4nBkG9YHd6zwUBtPeWoHtOaFkJ6EJU9ivJBcruZ4AhheccV
         iMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aQiWyVSftilCOyVcfGMO5Txk9dV5oTrqKLEhf2u13ts=;
        fh=xvbHey00/zI9AIBYZ0pz6KZuybhWZikHCsRIJUYbqvs=;
        b=Fd06g9bWC3mjRPHgkij1XTSu8W9o2lp+YO1OuDWTjj4eF6nqhB83NaYrtNgaV7lhdm
         uf/EGJVA8M8+8bDhA+/OIkD5z1EjlCgISIEK7VeP5alKo+bi6DkgckGC5+CHqIpyXtKj
         UyKzuLdp3Vw79a+/uZKwptyOQ7jBLh4Wdvy4xkSDPtLVWvzsBpQXH5q7c6iakILZdYse
         jkZKHj92FD2x9Hx6puoUkUpxG/fejjQXQHF+PtX7ZtibkE8o+Xk9DfV20KcbU4vQI2tr
         6uJhPmkRNgG8Cy8p4ARFKxjaXvQP+J7vBpdfATw8/9XdJfthAyDNBdMxVStfS+4FKL4H
         lEAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771355660; x=1771960460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQiWyVSftilCOyVcfGMO5Txk9dV5oTrqKLEhf2u13ts=;
        b=IGc6WYI8bY/ZXMjW9lw9OTgrpY2bnGl/0wSGdys9qkp0xk6ie+qaAjZWmhOmuOoyTj
         zd5vQ8Q1k1RIHJHe1cRcZ91lvduoAD0nBt0jgwjzjR66lkfRdtVCDGvu5ZlgxnukBRUR
         vU3ImO8RbmGWiRehhqHpIMLdEDFEyAxl847jeWKfNPSnL15FHPLfDnhCj96CbYRwQ6eo
         YOzHoRTTn+0GQqfRG+w7HYYJVnVnef+5pKFp0HNKkmgBL55zZZJDZBVk2NlyBlNhyIDY
         P1OcrUHcFT4g4cFogP0QCmGWiis8A6kNF0prL1LxeCFcROCq6lpdIkLMdiLRmhHeeb0/
         zPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771355660; x=1771960460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQiWyVSftilCOyVcfGMO5Txk9dV5oTrqKLEhf2u13ts=;
        b=tzZO7yKxBVfaAIURPjIAPX5x3HMYffkxb2rcgBTZ/fI1T9NTu5FRAoCJua04pglJfm
         OOHY3ciHTWXqHAfDKGGZrJLruZ7IwJeGFo8orCoDlNp/SoXs1aXw0jJ4nQYJliIcpkEP
         b3HxHPmsoaw3YXPN6pwzCzQDnditDZV/8OJAGbI2l0e++OhW3ZKf4ZgRTuyDd4iY/60e
         PUIgfx/PRBRPhZckUvbcDktArJkbh81YkgHkeOgP+FJMcblC+++3/GgTx/N1ebrqaerw
         6tznScQDsVfgGw5ZVd9cmDK1N5HIPbH2LTgPzun1u6FWnsJXg1qGRKDQkyBgTGZMWIfy
         P7ug==
X-Forwarded-Encrypted: i=1; AJvYcCXsFot+hLJmQFyKd8N1gCPjjtKbJgZ4cuWz/BYz3QO79pZcMenv2BE47+3rjYuS8pnsW7B6FlGPbb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM0b3ezFiEBxfS/WVr2Q8d+flHd8kHg+H2+95e1q9rrokPxIz4
	/T6D6qnew4M8JFpQw86eRhEbJnrjDZIGPGLB+8kZPwgsk+2AZywIuxY6VmexZxLIJCHxwo6pJ2R
	Xr37u4bqPuLGj8MLfMYNXbcJmVZJlajk=
X-Gm-Gg: AZuq6aJHLFy63fS5dpa5hd2UO1WIyQhaWhPEkmcj4XIMmelesaaa4AW9cdmNnsvxe4t
	apl1vkLzvu5+dbY7jW+qHKeP81AeOtlla9f1neh9tO3yhRCAv9G6phtzoYfFAY6b2GilTppi+ph
	UVE9cCI1CyGGufDBoA9bDupug5ba6/m3oAY1CT51CjyDm8wg/qrYxok8j+vDBZCXlSQrjKQS+PG
	xpHUVf3CD6GAtUrG+bTxsRBOr+M6xhgpAgtefsL8Ua3xmv8bRJgy40tm8SucCkCgeRXBJcA9iLT
	q0nnVA==
X-Received: by 2002:a05:6102:290c:b0:5f8:e509:aedf with SMTP id
 ada2fe7eead31-5fe1acfffdbmr4992636137.17.1771355659924; Tue, 17 Feb 2026
 11:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-3-seanwascoding@gmail.com> <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
 <CAAb=EJWNSvTHuUX862vLmA2s1uKO0vy_x9OSZ6VXqY9X-+JNsg@mail.gmail.com> <00ebdd77-d6ef-48f2-a25d-8d8b3c7dc7a8@lunn.ch>
In-Reply-To: <00ebdd77-d6ef-48f2-a25d-8d8b3c7dc7a8@lunn.ch>
From: Sean Chang <seanwascoding@gmail.com>
Date: Wed, 18 Feb 2026 03:14:08 +0800
X-Gm-Features: AaiRm50ToVexierr1z1Su_gldXlSCi4DybqgKCXAHCAJD53YMQslZ6G7oLK7A-Y
Message-ID: <CAAb=EJXQjraL=VEod0N8Pm5tuQ5UE9UbrdxdZQ+ArKVhDUT83w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: macb: fix format-truncation warning
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18962-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CDBC514F8F0
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 1:46=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Given the other patches in there series, i have to wounder, is the
> diagnostic analysis correct? Or is the RISC-V toolchain buggy?
>

I retry the different methods, I found that when I directly compile
the macb_main.c, it can trigger the same error, and I already prove
the different compiler will reach the same result, so it is not a bug
of the compiler.

I also found that the x86_64 defconfig does not enable CONFIG_MACB
because it requires CONFIG_COMMON_CLK (which is also disabled by
default on x86), whereas the RISC-V defconfig has both enabled.

>
> I do agree ethtool_sprintf() is better. But we want the commit message
> to reflect why we are making this change. Is it because
> ethtool_sprintf() is better, or are we working around toolchain bugs?
>

according to the content I mentioned upon, I think the commit will
something like "ethtool_sprintf() is better to prevent data truncation
and properly fill the 32-byte ethtool string boundary.'"

Best regards,
Sean

