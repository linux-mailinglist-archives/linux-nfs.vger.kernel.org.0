Return-Path: <linux-nfs+bounces-9409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20648A17382
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 21:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24CE18863F3
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F0E1EF0AE;
	Mon, 20 Jan 2025 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqhSWdo0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEFC1EE7BC
	for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737404084; cv=none; b=h44E3Dv5P17vqC5khUVHPvBI/7FFA92xU6aN2IZWVoWg0srPWQ8Vcbsd6GqkA2er5LM7Vk5EGnWZL1zU28l7sHbpyYst71SMxRb4y4cjVOwh6BNv9YqgSzlf+JPr4uJioZ90jFMlCiYmKTxl9M1BFDmuBP2zAomFvKbrA501Gbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737404084; c=relaxed/simple;
	bh=KpZxBGc6TSyHI4eBbF8svUwlXCdAPknywkhS+ZiZqmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SxtfcMR4bKU0GiMJw2JR9Iyd8nmqcYalrUZvHDFz5r4FOESpWUuEfvl3PwmZ5hwTCzKd9r2y8L2MV9rbdnQcYBp9wXVa3dlUhj/yH9Qhdgq7REsMOWTbf9eIIJo1Ooi0ZfXMzhUJVQUFfFD6pOekFjOCcWnJ0wO0OYGwB3kbD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqhSWdo0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso8410900a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2025 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737404081; x=1738008881; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaEcougJ7mrDIPrxzZzMgnz0RQ1BA1ipVMiOOIYxlCo=;
        b=ZqhSWdo0Lg2HMelKDcu/iw1Qqyeg45jJuQdy73GobOwQu3WhwjTMPYGrFDkOoip9CJ
         wRio1O5eNS+wCsIf/aqqH5Q9/ZqialIw8A9XHjvNP5Fde0SgpYtcDVIXQvAQe7IuMz2N
         mizwCKS1etSaGe6km/pvzQ+6hPxRDIywhWhoP2NgukBcXzqF61n+NLxe8G71kYaVbnaH
         PKxW6eyzn3tJo4GeVEHyBxt1QCa/rLzMNSsLDvN2gsYecuXpKkpsXhYPSob4BPw47GRN
         Hiirx8bKWCPNhCPdwq1xkiAAFfVM5eAAa1Ne5OQnvQkzj+J7hOuUGeO3a6hSO8XTCqIr
         tWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737404081; x=1738008881;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaEcougJ7mrDIPrxzZzMgnz0RQ1BA1ipVMiOOIYxlCo=;
        b=vQ4lhsKKaUwizMOP0F1CmWbOkEDqt0MYbx99dgASE+pztC/vx0cuf/8TAYq0YpqYIj
         p+zeg/qPi/JrgssxgztkZH2k5JE1sIr3jyiQoQxbVpfA3d6w5VPdnm/4lV3GOlFkcdY4
         MDmJspxxu2S3s7zVn64Zd5OqI6Y7cic2vNln5tKQ/K3VSureN0UCqdqJcpGmx3HfTTXB
         dszA6JDDpv9LZuqMaqlyuQgts00N1A+z3uuhZ7ubA15X6MjybvyEl/iZROrYWQ0cdk5G
         CrZwTvUDQBGzmpfcuiEMh7pdBw+uJ9P77Xez+7S3m5+YSqStsNsEn+29M41Ad104Exe3
         9W5Q==
X-Gm-Message-State: AOJu0Yz/u4w8lkT18XstTPqvjHfoBP2GEVGjhiobSGoVgp6XR9usCdij
	ATGLVbdm7GQXvWAJfceD65zImaBlq1kxeh2HmmtqKTX54JUB3yu5WV0A2I2Ugy62ZH7LATGAHOy
	IplBCl+lYX81OnH/xpcuOv8LK72WC/P8S
X-Gm-Gg: ASbGncuQ7vuI/6lP/o/YpnV56FgNK+QshloB79ALc2OEpy7ac6KB0z9vdx/MCOJPcES
	DAwzo/iK3pmvsI6pbj4LJT7foRYYhLwq/mg4rt/8m5Qq0h2PVViQ=
X-Google-Smtp-Source: AGHT+IH86+Hjilspol0+XtZv6pVPm2TiW4fIH4OguyYmBq8s0A6o+ipCFR/Octujg5f9DnKugpemiFG3LpN3/Qa0aAc=
X-Received: by 2002:a05:6402:35d5:b0:5d0:e563:4475 with SMTP id
 4fb4d7f45d1cf-5db7d6331e5mr11940873a12.29.1737404079628; Mon, 20 Jan 2025
 12:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPJSo4V9TssdPre+Xps6s3qa0dBAuAadJqT8=+DLzvJk-2P8CQ@mail.gmail.com>
In-Reply-To: <CAPJSo4V9TssdPre+Xps6s3qa0dBAuAadJqT8=+DLzvJk-2P8CQ@mail.gmail.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 20 Jan 2025 21:14:00 +0100
X-Gm-Features: AbW1kvZOlNcdb5t0_YC1F1XeISAoYo3bohP3sEu6NUp9cqUWqkpZP8z0iAbslhA
Message-ID: <CAPJSo4WY4dNmTKG1ZHqR38QGkbfxB+ayiO+dW0zX4BgfYSm1Ow@mail.gmail.com>
Subject: Re: Linux nfsd always returns { .minor=0, .major=0 } for
 FATTR4_WORD0_FSID, why?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jan 2025 at 15:09, Lionel Cons <lionelcons1972@gmail.com> wrote:
>
> Does anyone know why the per-fileobjet attribute FATTR4_WORD0_FSID
>  always returns { .minor=0, .major=0 } for a Linux nfsd?
> This does not sound right.
>
> Ref https://datatracker.ietf.org/doc/html/rfc5661#section-5.8.1.9

Never mind. The colleague found a bug in our XDR/cache code. Wireshark
shows that fsid contains non-zero data in the .major field (why not
.minor ?!), and it was our fault of not decoding it into the correct
struct member.

No action required on Linux nfsd side. Sorry

Lionel

