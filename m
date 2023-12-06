Return-Path: <linux-nfs+bounces-354-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106138065A9
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 04:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B193282087
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 03:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D0ED27F;
	Wed,  6 Dec 2023 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0wEIN8u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF859122
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 19:33:34 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9f572c4c5so55752001fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 05 Dec 2023 19:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701833613; x=1702438413; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zzAqN/foFmSZjHYkEVNeIPkc0H+SnO42aXofKW6oxFA=;
        b=C0wEIN8uJdSedc9Ltu9h8V+V/VW3gsseaN5rVmQMviuDFbKUrSml2vNbNLNaX0c1ql
         9P/02uba2+DF9G+h6nenq2YrYbZ2o++ReeWVI0Y1RcJKQAX4giXftXHK/bst2XCLZQ13
         Xb9NZpgA7vcdmA3hEafy30x3dqVgvQ/8YSNe43aExP1z0SbyUdJCwe+0mpJCHI5vafeq
         DAfx6Qai8R7Kc3ip0rgEOrutGP/VqHyzKDJnWQ/QoLKm7iXJdw4xyTKlBiBBPYn2D09/
         i5LaY65nqV22G4cNT5sNHsA+n7nmbEBObW0Xkr2gnilngYBLGQBrbhRUUAn7ryaCNGgj
         ZjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833613; x=1702438413;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzAqN/foFmSZjHYkEVNeIPkc0H+SnO42aXofKW6oxFA=;
        b=AYSy1vwRI2C3JDO9lLdQK3mstB/f63iBULi9GN4rulgZAzTQR6GdivQBsBMsnpcB/J
         jBNgEYbzr4R2H0TwuJ8JWfzas08jLewmWV7zb1ECIZAMbFP52avvF0Cv4FV9F2POApsR
         mBn6aCQxjHPjZ5QZAsAF84lQncS9Uklk+6HVS5EsGg487mjGTVRas8GlnTFsr8H6INOC
         VOVPB1r6r4qfyeQ1oq5halyK0i6XKzfH3Dv3a3QeJlnilw2eF6+1pN7F4bgbGZWMOwYa
         FizwkBa2B29VtoTeNKNYaZ+VRRfTO1W+qqQj6QK417iXcvZGB6QABSs2dX1sPZpUyQ46
         FD2A==
X-Gm-Message-State: AOJu0YyoJqYQMEpiUy0ypJJ/zLeAIgPeSojevXTsd71ZMt8msVzGWvg3
	82Iuvj6nVBgEM8Vu6wZ+Vyo367PwD0NpYjejCQle7WukBZU=
X-Google-Smtp-Source: AGHT+IGePp06ZvKzCrTK1YwAzjdmYXUhrFip3jlOgD4q8rZ6O7oB6S8ZK/3BYYyk4JcT8fxc3rAXyWaZ1fuDulIovpo=
X-Received: by 2002:a2e:361a:0:b0:2ca:24c:e252 with SMTP id
 d26-20020a2e361a000000b002ca024ce252mr147655lja.91.1701833612695; Tue, 05 Dec
 2023 19:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Wed, 6 Dec 2023 04:33:20 +0100
Message-ID: <CAAvCNcA9R5ChZ3pXN689A=pZ_bffX3vZRvk-DUsSgT2WW7T2Fg@mail.gmail.com>
Subject: Linux NFSv4 client: open() AlternateDataStreams via ioctl()?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!
We know that Linux will never implement AlternateDataStreams, but as
we need it and need access to these data, could the Linux NFSv4 client
add a ioctl() to request a fd to an ADS?
-- 
Dan

