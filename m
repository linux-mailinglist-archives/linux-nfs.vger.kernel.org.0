Return-Path: <linux-nfs+bounces-10860-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C45A709DE
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980B41794D3
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA8919B5B1;
	Tue, 25 Mar 2025 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIGg8OOU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78351799F
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928901; cv=none; b=ZOttjashKtIrpN9yrdI9lOBfxZtIlEgjzTxU2WzWW+90mvU+Z0kN2H+iwpOBMYsK97xAeJ/pL1YQBV9Rjo04lNBlAAaGM1xudztuS5bOjWw8RDhe1i7FA/DHd1Hhmdd1E9KL75e4R4ds0K62/4FOcjYBN+uOlQH65Q87qJ9H4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928901; c=relaxed/simple;
	bh=gfwPJOLd1AvJ3B70C1QyG2p9MfOw4e2MANYoiCZZ8F0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=huylqrVwr0DOlSFbxf8yjbe4nCgN6KmnMrPOQBUsZDWODMa5E+UlrNda+7gIs9yWF0ob6nL0aH7DtVcssaZ+pE85cIZffUpaFHqoX308K1ECwDl1wxNbhKKd6mZXW836IxrnoA3hkFYXVvS75z92U0PpsZpU49JbYg6g6puoCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIGg8OOU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2963dc379so1009764366b.2
        for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742928898; x=1743533698; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfwPJOLd1AvJ3B70C1QyG2p9MfOw4e2MANYoiCZZ8F0=;
        b=FIGg8OOUrfvonrkaj8KrpznelL2eV9FZTAgR1xiUaMrx/jTGnw7WB1oCiXHEz8tRE/
         ZIguxfqNO+WW53BszbMJ9uHgf6yDwNDUZ7o9Jm5VcMma5AmAIK565ktd7U6LgxGXu9BD
         m/b/LWezahp0FwNQeNjFvsQP8nL98W3+Bk+wwNmjLLFXBylkOxMUikurH8dfmKaixF19
         acy2QxT3XPErHbB12onA2Hjpq2nD2/5HWi8B0NQVxKlT3AXu767ygpSxtkyIkgkmBEkh
         blN6u4/kUS+wI/xTPnweL97mjQmR1uYSDorxg32iyGvl9gE7LdrinhJrXm1rnwGVr1Vi
         m4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742928898; x=1743533698;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfwPJOLd1AvJ3B70C1QyG2p9MfOw4e2MANYoiCZZ8F0=;
        b=jkLLzozKiTJh2UJS8JSeCmTUzJ4JjSk6AEktpVpIN8FRAA4/JknDKoDCkx1YCmNSRE
         mq+IS0WmPP8eR58YxpfDhOgWQUiBZz7l0HOw8d6mw/4XG5BxFFkqUANLHcGN1erAGhrt
         UF05P1XHudonzfLjAUl5ToTJT2gA3ZJrzz7VsRIpmXMfWK2UN0MNWggojh4RV/Tm/UbO
         1vyjL6LYW7SgUCQT5Zdc8TQznJPtPauqPV0+J3GuaaPn+BmH50HrixVKaok3dnjVtRac
         mYhFqqjdzvy5J2hzbx9zV75WpI0lmfhMBDtX4QFqlruodd+/KiyZbQMZHLAIm9crpSRH
         WqjQ==
X-Gm-Message-State: AOJu0Yxu00AzQLnrGC9i08jxFdWqdLVygmF5YMQdz1eQH1gBeZQmOpod
	qsVgOWdZVHjHoIqBqBaaT423sL6Oa7i3iNfMVXUdfNH3J29eGlZb5MXO/osOST4VOlzHhH+0DvX
	8JXqg4YwAunDJ1A/DnnvKDgGbuxNy5av5
X-Gm-Gg: ASbGncsvhZfWdKUUlrEvFuUn+TnVjYhluPZijLxk9w/Fjy1/r27DghW2PeF+1LkL2oc
	ZlFcohXnqAFW4UrG0dDEANukYHmElR3UxYAVIEZcP91oH66SxOxCiSbgvUAxcKGpQpvdIWD6Qyf
	9Fx0xo9A0MjRWNZIbjgNGHBT6IuQ==
X-Google-Smtp-Source: AGHT+IFguGIsx58jI38SOBB/b0uAIcuj4pcNL7YNfjqIaKE9Go95jbBhHQN1yDOM6lNpSK/Kj7UH+P/H5hTxZsfbjRk=
X-Received: by 2002:a17:907:7e82:b0:ac3:d3d5:4c31 with SMTP id
 a640c23a62f3a-ac3f24d794emr1616497266b.23.1742928897601; Tue, 25 Mar 2025
 11:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 25 Mar 2025 19:53:00 +0100
X-Gm-Features: AQ5f1Jr-cjCpI6MEM_FNiu6Z4QqkU8_7WLw7SFWc4gcgpIp2XozIrExtR_Hpx_I
Message-ID: <CAPJSo4V8WnCz0rrdHK0SdvrhKO9Ex-BONU3bkao5wziCnXfJ5g@mail.gmail.com>
Subject: Using Linux NFSv4.1 RDMA with normal network card?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Does Linux have some kind of RDMA emulation for "normal" network cards
(e.. not IB, not 10000baseT) which could be used for Linux
NFSv4.1/RDMA testing?

Lionel

