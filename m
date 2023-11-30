Return-Path: <linux-nfs+bounces-231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1225E7FFCEC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 21:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE3F281B06
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795E055C1A;
	Thu, 30 Nov 2023 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M97g5dWU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CEA10E6
	for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 12:43:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2839b922c18so1294301a91.1
        for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 12:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701377016; x=1701981816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdNYtN41s2jpwnfeA1V4jjdLs2pUYVZuwjOD5GJva84=;
        b=M97g5dWUv2qK7YEVeRI3SH4KalaygsB0vB9UgZW08qVyJZlaABUPy54+MiBd5H08AF
         e43J3cLT79T4SGPNp8150+na/fR2kAxGilUSu9YKNOLFjQFYMjtgCR9dtHbV+HQQQucB
         i5yQLS6rF6m7LyYKCpf+VnVe1cX6cOyz+iH/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377016; x=1701981816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdNYtN41s2jpwnfeA1V4jjdLs2pUYVZuwjOD5GJva84=;
        b=bRG3L1u3wY8fyTcemmBIZM4WOB4CLv8dA91T5AC6aSAPzIiALH7lp/X9C7mWbJJFA1
         ev8MyoxBUovSz1tSrTmegztsSyxd6mszgS9V8/z7wQfN7H4NL+FXqPoVnzLYTnfP1JDY
         jwVpoEUkCmPQhUwdclZshZ96HeumOX2HUosaWTvm+6ZA+Hx3kAJ86Ah+gaRM6LQ0geCb
         ekwhQy2FlqNogm/LENMrkQoJTpo9yCVGUavq3pJNIhepw7KvbR7ueX9zg0DipKSaxRc0
         MSxHAFxgnjEe2RrU2oYxc2Ku9vBt7BA0Bivut6zuUwUBrvkuNU8JqERrsgqOaGrC6/cX
         ZFVw==
X-Gm-Message-State: AOJu0YwVq4apNwjM234jdLX+E0ZwJsHw3YudCGFONfQzUU7wWuXcOe9G
	ynzKhj9bbUvIucrikBBoaMrhTg==
X-Google-Smtp-Source: AGHT+IFcCWPCS5aAuYhRFgwSXNFOr9+0EHuLwrCI1lVTjpQUPkKOStN+Dh+dc5+CPp21DSIvXhJYxw==
X-Received: by 2002:a17:90a:350:b0:286:40e7:e99 with SMTP id 16-20020a17090a035000b0028640e70e99mr2520980pjf.28.1701377016042;
        Thu, 30 Nov 2023 12:43:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b00283991e2b8esm1872854pjc.57.2023.11.30.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:43:35 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Kees Cook <keescook@chromium.org>
Cc: Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Replace strlcpy() with strscpy()
Date: Thu, 30 Nov 2023 12:43:31 -0800
Message-Id: <170137700879.3640204.581331941374933494.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114175407.work.410-kees@kernel.org>
References: <20231114175407.work.410-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 Nov 2023 09:54:18 -0800, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] SUNRPC: Replace strlcpy() with strscpy()
      https://git.kernel.org/kees/c/cb6d2fd30ddd

Take care,

-- 
Kees Cook


