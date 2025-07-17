Return-Path: <linux-nfs+bounces-13123-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B4B082A2
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 03:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2657A5E91
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 01:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E521C1411EB;
	Thu, 17 Jul 2025 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAqShdDV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292FF258A
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 01:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717166; cv=none; b=ByGUtrEayVT3anusC0zH1WxLJGKXjzBs7/+WXW/nmXevTRUnLn3LbXwoqoiZDezjbx6Lah0J3InbLVUR5b6HklDV2W/vSU0APdaB+E6KbU23hX/LSqOewdJ9COa0IgPUyhS8Muigz7sfxaBfz+4gwlNCc6VIKXq2pjCVvIjLSVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717166; c=relaxed/simple;
	bh=qGAl9nTEsIfLyEJpwZL/pUhpqwiKeex8GDQeK8MoPgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBdSb1dXRACRNe+CdBHYmik24Gii6n0PiHQ+bODBBM9kWgxC7FXiQM/WchjsHg1910n7iIEbMpzh2vAc3TFR/xszZGMV7tRXR0k3wVhgOijzJgg7i5YhDn8d1FhFD/XSLxN+g5Hl561ldRz0ccRDBFal260NiDOOm4j7QETGIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAqShdDV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54b10594812so456438e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 18:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752717163; x=1753321963; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5+BMo0iW2+UmxVze9uK8bOd1i7RlstoG3QI04rLxVI=;
        b=gAqShdDVa3mxHfUrPd8RGRCezN16kShQVtwN0XFCHnBbVvGPEcuY4h22NbshbshvJu
         RCoaBzke84PGti0wdar0YlA8I6pWnF3RvKSL1FzQFV6fBz/V5Tc/1VdT7mu6F7hwAupX
         PUzO+rqZi45SP0D2zTHucidaH5o1Em7Maffj+skv6iBYIVgFFm4YgEkEZ98xMmHD433P
         Zr6rW3qyr/9fiHwBbxMYVcPxkP+u+gxysQH2LQ6Ov6/Jc4drdd+X1hYtFHHb9IH3CV1I
         /lMBSG/xmJeug0tKobqQAhpvvv693ucwp84Zgs82JP01tWTdVf/kVOLH1hglGRfRA42c
         UqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752717163; x=1753321963;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5+BMo0iW2+UmxVze9uK8bOd1i7RlstoG3QI04rLxVI=;
        b=nvNyfn6e9MYJ2bfdzwtmmEFoDz9TEhrVZdjjQmQkY+YZfx4mZuRPSR6CeaVO9B0HdP
         xd+1Dg2ZYNgKNiztrjndSrCurQTYhhlv2Chd7uBqvgud1+58CMcPHGtEfBtD8/HEgr8F
         K5KUZTL1KiUZGSy2XLczxgPyl4weNCy6kN4ItnmzDRuRQwCo9F128XR7wnUbNefHUsu8
         G0/AOFCJSxNxpMa0O9LXfKzyO7EK7hUCeqQB9KRYG/00NNUkdDm5fZdYb9H/aPtPl+lL
         8fQb7BdKfI1IebaHLC+NUqJtCKlERaZcbjS9vSFrAROXPP7FYOzPXsaz7//wERkoLucd
         s8rQ==
X-Gm-Message-State: AOJu0Yya+rh5bWb0nSWBxFFo/Nko2kT6J+wCNEVRqrQkyRl/4Z05xv2K
	OiEj/HGnQ9T6e9SvdLxk/sjNrTaN6SG3WtmpMXMTa8ukKtidiFzzK4jFgVfw2+lF
X-Gm-Gg: ASbGncvrz61Ee1okmgxiWQeJw24MjLAUq68SZO96lqvLL8BIGy/ZoH/Xr7U1JOBrwja
	GtA89DWcM20nTpYdRMZcwSSzt6UkBXsM5MetflTaqVHO5T0KtETDcjdnbU8F6JQlFqGdWVcy20+
	ehl86bQRR+M5Vbk2pLWFxX7HfbJg9skhOOFExMXfqRYdqbH0098ixzTGnvce/cf8nVEzkNJaoYO
	bEwNt9mTNNiNDy/KZ+0IFFL1pPW7/G03c/Hq6KXf9R80csNdlbiD3p58PKA9zkFntkD5GeHMCFj
	h9tVJX+MnnsKFU4wngp0P/alSvS8QrwY0V5edoXEa5vT9+CerezS1vyWlNuhKCGcAIhVEzcrEUM
	jEhbMZUm05ow8Ky0sMsmZCrhgiPwx9Ag7p6J7ciQ63Qh/E3mkSk8=
X-Google-Smtp-Source: AGHT+IFscSUmyG0nJPokwui7POAE0zw22jmJPxiiwzHNJqDSX4lcSOBxxRclwt/qhHdU2jfCMLkEzA==
X-Received: by 2002:a05:6512:3e1c:b0:553:3172:1c23 with SMTP id 2adb3069b0e04-55a23ef9f43mr1426097e87.17.1752717162643;
        Wed, 16 Jul 2025 18:52:42 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.192.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b7a6f2sm2839145e87.235.2025.07.16.18.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:52:42 -0700 (PDT)
Date: Thu, 17 Jul 2025 04:52:40 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [bug report] pNFS: Fix extent encoding in block/scsi layout
Message-ID: <pghwtblomyjyz5ckir2jdfckc5v7zj6upcj2e4y7ba267ivkkl@dvyxwqxl4u2h>
References: <a9e502be-2c67-4a49-a6f3-861f5b82067d@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9e502be-2c67-4a49-a6f3-861f5b82067d@sabinyo.mountain>
User-Agent: NeoMutt/20231103

Hi Dan Carpenter,

On Wed, Jul 16, 2025 at 02:39:09PM -0500, Dan Carpenter wrote:
> Hello Sergey Bashirov,
>
> Commit d84c4754f874 ("pNFS: Fix extent encoding in block/scsi
> layout") from Jun 30, 2025 (linux-next), leads to the following
> Smatch static checker warning:
>
> 	fs/nfs/blocklayout/extent_tree.c:615 ext_tree_encode_commit()
> 	error: uninitialized symbol 'be_prev'.
>
> fs/nfs/blocklayout/extent_tree.c
>     584 static int
>     585 ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
>     586                 size_t buffer_size, size_t *count, __u64 *lastbyte)
>     587 {
>     588         struct pnfs_block_extent *be, *be_prev;
>     589         int ret = 0;
>     590
>     591         spin_lock(&bl->bl_ext_lock);
>     592         for (be = ext_tree_first(&bl->bl_ext_rw); be; be = ext_tree_next(be)) {
>     593                 if (be->be_state != PNFS_BLOCK_INVALID_DATA ||
>     594                     be->be_tag != EXTENT_WRITTEN)
>     595                         continue;
>     596
>     597                 (*count)++;
>     598                 if (ext_tree_layoutupdate_size(bl, *count) > buffer_size) {
>     599                         (*count)--;
>     600                         ret = -ENOSPC;
>
> If we fail on the first iteration then be_prev is uninitialized.

This static check warning appears to be a false positive. This is an
internal static function that is not exported outside the module via
an interface or API. Inside the module we always use a buffer size
that is a multiple of PAGE_SIZE, so at least one page is provided.
The block extent size does not exceed 44 bytes, so we can always
encode at least one extent. Thus, we never fail on the first iteration.
Either ret is zero, or ret is nonzero and at least one extent is encoded.

There is a patch thread related to this bug with more details, link:
https://lore.kernel.org/r/20250716143848.14713-1-antonio@mandelbit.com

--
Sergey Bashirov

