Return-Path: <linux-nfs+bounces-263-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2268027C2
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Dec 2023 22:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58ECB207FA
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Dec 2023 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E1118B19;
	Sun,  3 Dec 2023 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhkgtrIi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265DCC2
	for <linux-nfs@vger.kernel.org>; Sun,  3 Dec 2023 13:23:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bef9b7a67so999834e87.1
        for <linux-nfs@vger.kernel.org>; Sun, 03 Dec 2023 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701638623; x=1702243423; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MWpdnpsUugQnYmHH2tOpQiSkZVHtU594EBNXuRVJkns=;
        b=fhkgtrIi3zJHruIG9xOIy3UDbcsTVo3ve0yEEKAA88LX2RggOC50cS+9bOd45inLoW
         hQ/HGoXrBvQ9TCG1kAmeAQisNYxANN89Mc1QOvJCJY23vKTmaLmY6QLgt1pOZoSkvWG8
         9sS0GMjQyOCgUrSU67x8vYqmn6fXCU4x9fEHUcwAKiTDFwWZsMNZ3kDi/dQ3AuGRr2SR
         iErqsE2waJVtcYP/EhVPmW1jaZyZKX71pI2CsHmgQ4B0kLInYFtRU0g1N2gGt0zDN7jL
         bPYvaXRfEk61gPE9XggsNYlF4UQgK27ZoXt6X3zftIrjqFuosU+vlEjUKtqGnzkuOz+x
         ba5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701638623; x=1702243423;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWpdnpsUugQnYmHH2tOpQiSkZVHtU594EBNXuRVJkns=;
        b=gx4aZU+ckhXXENumLezkb6SaStuCRTiKVonwifXK/S6sWZApnHPwFuWXUJB6RW8OVT
         5ffPz3VghEUani0l1OgxcuaRS8ZSN2UYWCsKomUuMRjj7I9PlQmhAsc5Vjsnnd6qB5Ue
         ivtlmcQJkRNJ1m0X9Cu7JneQ4lFHKAttIjikGrcydI8fCSYeBNDsTAp6owmvy9Ad9bFg
         YT4j5USvGD+NgowLQZsiZyWX+mJHC9v+h6KHK/fY6M1UyUuSJVJ/WIVw9EMhZkcXFx5q
         W/zhY/fE4n3VOnGQR7bM+Zp+NQHMcSC+0k8LyWUJnGI6zAO4wFOwCVz/N5DdMqwRZUds
         mIMA==
X-Gm-Message-State: AOJu0YzL715NwLwbJ802a4hcNkE3shfXbGv++K6oADycMYnJemnPXHYM
	kJeanWNo904n6BpBhy+WB9rnOdDmZ0SbRPSLVhnA26Mx
X-Google-Smtp-Source: AGHT+IElKijUTomGhn2HA1oBOsTt5P0XNkPTCGoZhrjN1nCQqbXNgjaJJaULuTTACrvuNCOrodH5SLR1r/yqon+zQiY=
X-Received: by 2002:a05:6512:11e1:b0:50b:d763:fe6b with SMTP id
 p1-20020a05651211e100b0050bd763fe6bmr1827614lfs.134.1701638622955; Sun, 03
 Dec 2023 13:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 3 Dec 2023 22:23:06 +0100
Message-ID: <CALXu0Ufm+b+9wOLk2bG79rKFfPCY9K_2USZaFhso-dR_NaS+Hg@mail.gmail.com>
Subject: PATH_MAX/max symlink length in the NFSv4/v4.1 protocol?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good evening!

Does NFSv4/v4.1 have a limit similar to PATH_MAX? What about
symlinks/reparse points? Is there no limit, or is the limit
configurable, or is the limit >= 4096?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

