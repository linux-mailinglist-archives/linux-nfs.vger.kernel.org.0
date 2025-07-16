Return-Path: <linux-nfs+bounces-13117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8167BB07E1D
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 21:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96FE17C2EF
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125BB2BCF4B;
	Wed, 16 Jul 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wP+2PhF4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B429DB95
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694754; cv=none; b=ARRhjAw5hA5D/wePHs/Ug4zrZDHX38uDFXXPtwe0qnGgsOSdgwa90fN/6HyicfOP5rMUtVrQyLlpODTThz8tj4EjNfNp1j5RNwegxFtthks6XwSrvOdgBSdm1WuWRykMy6mNR/g8MSQWV8PGo9cq7LFo90HuVyk8gXnpC2b57So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694754; c=relaxed/simple;
	bh=QbM/4ZsItdris8E3/Ky7oITQasWdEHIN0cg+9Zxzl00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DWJzOJ4U5A1fA/aMsiedH7fI0HFRYsPWT9QxrySBvLNVZMU1z4BI7WGaLxertRvepN0c5DGivmzoVdiOVzWWxWbFe7S+811e9rldltROIJTCk1ZIMZU9XE/S4KPwhPNicL26daNpvFK4vHuVZMMyjMg4ohyMoI8V8juFM64iSME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wP+2PhF4; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73e5523ef8fso81685a34.1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752694751; x=1753299551; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsoVlfuUTu00sjjn8X3aUGtP621dKoXZgDG8o+vL+hM=;
        b=wP+2PhF4dbNaj9aNZTmSZsnJc29ozCIagwiO0zwpXDnnpzvYWb/9bmYA7KOrvWvNql
         ridmU/pPUuM5p7ApDHPbuPkWaTgb6i8VRqrvIOUt7WwOY256LpD0e9PnoG91aXzmp3pt
         qrR0jWAmt/Rg17NaJVp6pTV72SD/39MJEwIKSnEoEdS87xaqhkqdQDVPXriHSApMSN1X
         bPr/7kvjZQmFO/MnaXZNtye11fw6VAjXc9udMUNoM11U9K/woV4ATjo9AnWqMwWSX+hP
         pn/MOMNRvibRu5WR8QMXvhZnqESlLh/dD4wubpHSGGeStBLuF6/THAvcPbEaqCRx+UBr
         mzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694751; x=1753299551;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsoVlfuUTu00sjjn8X3aUGtP621dKoXZgDG8o+vL+hM=;
        b=URDSDS9xD8oUZ9YpnU9XBEPphh8fedbd3EJ2xMr71WKIlR4FbJsnTOMh8G6n5Z4dZ0
         GQlS/B5dXSGUU20I9RAqAShYpuPf77KTwyyYJXo87kOBx6VaczTETyNQpV2N1pFOEylV
         wDFJqRmxkM8lLkLERQ7VcwI9MhSssn2p6eHhrE9bXuQksiAP5p7z6P92Zek3pCanNDu/
         7opvAToxKxTBIn3gGNWNOQK+rHQkX5MafYykJp15LNlYNeleELav/HTSq2B14mgnP2NC
         RSRHezL5cI1atbnmWSDntXCV+Q1KLLNa2B6YolQsiasrRg+Duoi2/6PyzooHtVlAM+ze
         61NQ==
X-Gm-Message-State: AOJu0YxXpoC9FrDFxhs7IqS/GOCoxdH3BbUCDHwOFMTcX0laZ2XngBfp
	XtdGlU7yzhtXXDSpMLjDALWBwoxcH/RHobuLoLj2rKqw8vTc0lyD/JYkAmAMcUsmETFT9ZxM9GE
	53327
X-Gm-Gg: ASbGncvNsdE0/45xBlImX/phb+gnUgpYhC5PcV2o9NIg6IM15kF68+7kG9i3/nsnK95
	dvKRK98aLPubSBF3/6IaWww3QrsZZyi4DfM3bDSAgIVmwOfAZlGAlXR7eVJpHjb/uSinP/863d/
	XnlL9S8+nBNqSMmVN4/PLTaZCT4ZTEg5z+L9kK7LKXuHOm4sA30I45ifX2pbsrt6MU1OMN0JQSf
	u6a/lt8Lt3/o1kUbVqBeuubkQCqVJLe3nrMpEj4seU5l9F5LzLzqL2hLNznVhKeTJsWelFQ2Im0
	XiT15quvEfjITsiBr7BGdXcw+ggeyCoaVyEhm/V9GKjqUekbWRZAxGkwdQh9HcWnDyyxJYxmxHe
	w5TtJPwjUimQZEoBleh7DuDd94wCxGg==
X-Google-Smtp-Source: AGHT+IFJivSutWeAncCGs8Vb3v5qqzPb8r12t2p39iGLhBTvAezD/l5vgg5n7teyzzTiMs/paEN+Xw==
X-Received: by 2002:a05:6830:40c8:b0:73a:96e5:19cd with SMTP id 46e09a7af769-73e64a2487bmr4422319a34.10.1752694751258;
        Wed, 16 Jul 2025 12:39:11 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e68892a25sm638048a34.51.2025.07.16.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:39:10 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:39:09 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] pNFS: Fix extent encoding in block/scsi layout
Message-ID: <a9e502be-2c67-4a49-a6f3-861f5b82067d@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sergey Bashirov,

Commit d84c4754f874 ("pNFS: Fix extent encoding in block/scsi
layout") from Jun 30, 2025 (linux-next), leads to the following
Smatch static checker warning:

	fs/nfs/blocklayout/extent_tree.c:615 ext_tree_encode_commit()
	error: uninitialized symbol 'be_prev'.

fs/nfs/blocklayout/extent_tree.c
    584 static int
    585 ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
    586                 size_t buffer_size, size_t *count, __u64 *lastbyte)
    587 {
    588         struct pnfs_block_extent *be, *be_prev;
    589         int ret = 0;
    590 
    591         spin_lock(&bl->bl_ext_lock);
    592         for (be = ext_tree_first(&bl->bl_ext_rw); be; be = ext_tree_next(be)) {
    593                 if (be->be_state != PNFS_BLOCK_INVALID_DATA ||
    594                     be->be_tag != EXTENT_WRITTEN)
    595                         continue;
    596 
    597                 (*count)++;
    598                 if (ext_tree_layoutupdate_size(bl, *count) > buffer_size) {
    599                         (*count)--;
    600                         ret = -ENOSPC;

If we fail on the first iteration then be_prev is uninitialized.

    601                         break;
    602                 }
    603 
    604                 if (bl->bl_scsi_layout)
    605                         p = encode_scsi_range(be, p);
    606                 else
    607                         p = encode_block_extent(be, p);
    608                 be->be_tag = EXTENT_COMMITTING;
    609                 be_prev = be;
    610         }
    611         if (!ret) {
    612                 *lastbyte = (bl->bl_lwb != 0) ? bl->bl_lwb - 1 : U64_MAX;
    613                 bl->bl_lwb = 0;
    614         } else {
--> 615                 *lastbyte = be_prev->be_f_offset + be_prev->be_length;
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Dereferenced here.

    616                 *lastbyte <<= SECTOR_SHIFT;
    617                 *lastbyte -= 1;
    618         }
    619         spin_unlock(&bl->bl_ext_lock);
    620 
    621         return ret;
    622 }

regards,
dan carpenter

