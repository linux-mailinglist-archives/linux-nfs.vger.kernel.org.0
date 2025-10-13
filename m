Return-Path: <linux-nfs+bounces-15174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9477BD27F1
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 12:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49103B7641
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F72EB865;
	Mon, 13 Oct 2025 10:16:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F92E2EF3
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350569; cv=none; b=uOz892prKqhGYRZFlFiCsX1m7PdiK9aRGSZ3WWJu3Zj9XCMYY68W0Fus64FPjamN4t5r72svNpdsU2uLJ3EyTkQKSfg0KBS5tU6RQ5VFQBDC/CyBXdcT5Tpubiz3zo+d4EkH8Wxl1MxXUU+SQp67QGBuHBuWF138K07xi6nF2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350569; c=relaxed/simple;
	bh=/dclAOZ1wcO3wJHRWYPxOk55bJ0h4fFw7TEM3TxPSYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1QYn5hnYPzWiLss68fjbwIl7DXQtxbch2xUrtP7+687bPO/62xMZmwScFVeVv9y6bXmNB4FV5nbjuDxWIV1a4rhc6LvX7bVXyadu3m2Eabo2Ca6oLLcxh1VEyPF1JZZ6cNmf1wxUgEjgjEwNcb+nCCEsn+xzN6xRfCFguzauBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-551b9d94603so1180277e0c.1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 03:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350565; x=1760955365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxBrW+9YUunZwvYGyVKGYyAsVgwAT/0jNiWc372U3Fg=;
        b=YbEr3gkr/+ZlAtZLK+c7tSV3p3b6AcEB/zlaNJF9CDbH9/XGrszgC5Ix7h80sMtc6F
         0t3oh6iWotCfwGYjzVA6h8s+swXIetehNv9V/Il44XnJAzTyYMrSan9+rq5g9qfToVfx
         bnofFfoCeBkmUu+l5cbjAP5utVNW9Ez0MlttzCV8iohE/jrV21/Tv9173G4uE3GoviVZ
         yu79Aiw1PZUtcNu5u3x5fejkReu5yO2BXJSAacz8a+UoeMinbQ26kXLzgwxm4G+eLdkX
         SktTRXP6wmtvtAaw5spZkxLk/H8kRwtspSWe3jjB7Uh4O1Br5qI79pRJoCo8z4PXyVcR
         8cug==
X-Forwarded-Encrypted: i=1; AJvYcCXltpnF+/mKs/zP4Xezlj0KzHKhEYkqy21AHltQVaVAUw20MUU6iASXOsHO/TQZ/Yk/UILGXDZDuM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtvWe04vGdg83Dp9X7biTlEhnziDLaTpxdD3pzdcoQl0De3Rfz
	pCfm9wz6BjQ5YsycRnX18SzlXQMGARzWZjXT7CLRm/tYJMGOqr9onceIXU/Swcvd
X-Gm-Gg: ASbGnctbS3e5RflmvQQma25897yNme1ptpn2bUuF9jh/9avBGJsuWFM0tR4i8KWaion
	oAz9sY2eVdqT9dGBBxMfk/bxt/W5iSq5vp86sVSECGTQ0BFCk9dsopd/hgquaJ7fPSknc6ZcZOb
	BF63MUaGiYYhtqrS3M17v4Q4uxcMu0+nuJ5Xrl/acozCLXZCMU/3a19yxmorlMe0KANiuOww8EG
	UfTi3HR+tCKWsrrer456AFHSosvQ8L/Asim0NOcGfoSB6A9ycOrNdLeuLf/9G0N6L+TAwmDm7hG
	jPlLP5Kd3QivDZ0SHytk5/57jyPWdEklL/m5rwkRvzy9V0FGwWyp86ql/Y6lu8SY8UqlsO/kyaM
	gMzV8aPwHzkl6gkI54Nj4rZSJVHllYVtAVJS18WTW0iP7WMIhzCDiHFHYgqlqpXB96IyjD8WkbP
	g0Z+UJhdiyFQTBnSkOYQ==
X-Google-Smtp-Source: AGHT+IHWBEntVq4fYPPrn6PosxENovLu+AMS5fJyGAP5cdCtxL0ssKLUqPCiTXkfzV7wl0IW64oWkQ==
X-Received: by 2002:a05:6122:32d0:b0:53f:7828:16c7 with SMTP id 71dfb90a1353d-554b8cfacefmr6818977e0c.15.1760350564544;
        Mon, 13 Oct 2025 03:16:04 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80aab53sm2951729e0c.15.2025.10.13.03.16.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 03:16:04 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-905b08b09f5so866719241.3
        for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 03:16:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9xUXpmGYaWL6XBT/ckgAMKZnnd+PAgYTWX+zKw8yyTDKQVvB279+YBqgxfG88oL9UPjOsM/iudbk=@vger.kernel.org
X-Received: by 2002:a05:6102:4bc8:b0:51b:fe23:f4c with SMTP id
 ada2fe7eead31-5d5e236b19cmr7934369137.22.1760350564013; Mon, 13 Oct 2025
 03:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006135010.2165-1-cel@kernel.org>
In-Reply-To: <20251006135010.2165-1-cel@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Oct 2025 12:15:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
X-Gm-Features: AS18NWC70YQ25pmV_8TDIyg3Sza9lycmcIj-QBQA-wQOcH5zOHgpO6WjHd-A4TQ
Message-ID: <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Chuck Lever <cel@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Chuck, Eric,

On Wed, 8 Oct 2025 at 00:05, Chuck Lever <cel@kernel.org> wrote:
> Eric Biggers (4):
>       SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it

This is now commit d8e97cc476e33037 ("SUNRPC: Make RPCSEC_GSS_KRB5
select CRYPTO instead of depending on it") in v6.18-rc1.
As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-enabled in
defconfigs that didn't enable it before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

