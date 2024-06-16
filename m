Return-Path: <linux-nfs+bounces-3858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194B6909CF6
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jun 2024 12:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CFE1F2121E
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jun 2024 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0A16C694;
	Sun, 16 Jun 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C12PPYTz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689D481A3;
	Sun, 16 Jun 2024 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718533413; cv=none; b=LTIK52xpCqAIFCu3Knxo1R3EgG1yPvPefikLooRxYs0jin25qo9WrVkzdJ1YKKQaabuKWhLmfjnzOB71TCXScoyEP0K+oENLjogH5TcO6Cku1hM9B46QaFWnZUwQwE2+Clg7UAJseHD+O5+czYINShifFT6zghfLPlNKy5dnhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718533413; c=relaxed/simple;
	bh=by8ohJEJs6lukJSLMe+E/tLehUWJmbmsLCVuB3MSp7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTTxTOwoazFsHFWNhFaKXxmfczXwF2QlG0a292wjCujdPHzPkX3Q3RFBjgZAeeznH6JNxpQQeUwnQ6WNlKG2AZJj92KXUubUnEGEXZbBWNL0M5bWiSMB3binkhb8f/xszAaxgK1UiPzyZvR09TGC18RNI6PATiiGh8tTMxytT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C12PPYTz; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4ed0abe8580so1104222e0c.2;
        Sun, 16 Jun 2024 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718533410; x=1719138210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSBxsPczZ+4pot3zvMVUtuvia7JJEO/t9QU4pSIhmLc=;
        b=C12PPYTz9h/ZJx7CkCEJ1ZhSkF3bp+FMzFdpdIbrs8D2WPVaeN/aKtRWQ3hxMe7ydQ
         M0mHihYih1NjUvAbkrSHVWqWGFhVy66bvg4oIJNAkjKPu5kTt6Lh8nEqfq+9N4DX6OMY
         PoTdoNK8rXfOmSemJT1eBMU20xjmeTSA7cWs6Clsd+j2K6PzQ6EfAUpCN5Qk6lmD0B4V
         GO01lrSrBxyhlhcy5LmKm2eNfjir6o5l6l8Tt2l4ngliaq7+6xp5r3oIXIyA99xj1RDx
         MHNlY+IiOyKK0UxeJo8J7v7HYm7rznjaz8Fr8Rutwq9PnbJyHqO/F+qAbWlGo5UlHJ5d
         AMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718533410; x=1719138210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSBxsPczZ+4pot3zvMVUtuvia7JJEO/t9QU4pSIhmLc=;
        b=H7bkMQEnpuV2hiiyBSanjDm/bFFKpkAHXmxqj6j4RCQ+7NKnNaZyDZuEEZmmxPFL3m
         s5VIhW2CUSCfBsdo/fgkSgE97KcCiA5Vhfh+1laCEFmT6fFPo0jWTvTn9jIWkwgK/v/6
         DHSkPoai36Tx8jZRJyYQ1UE+fy4T9g+Pl3I919SOPbTeaoueBtdE8iFepquYARvnJIbW
         lcavhHmZ3o+Kcbk78JmY0JxGd6cj8aTaT8CrM9RlhE7U1HnKbNcH5YH8pS4r2g7qU6mg
         QoW5gPYoQJXPKYzGTo8qrDDQG3bC+bVXd1gtZsPkL8qLhgXjLs15aO6JHeY8lTkF5IBv
         5qoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmOjVMdbAHDNdl8/hNVBKY7lCEDb50jsV0kkvj8xm7sTQ/k3DEeeriJAk3aaKsSfmJaJMHjWrKWrIbTicb/buJGt5vNS6Ggj1ZzZFyqK3kxvRmX4NDtrxm28rXKYbqgtVS1mkglQ==
X-Gm-Message-State: AOJu0Yx+1zdl9ufc6zMeB1xdrQK5043uJsx8yKwVD9pwhPuvNSV7QXaW
	aiFuUgFPiUAxVZIdeGANxHJnRliSI38GLERSR7MXcJ6YIV8fj8jujf57+wbZ50gtV8zq0cfc68O
	eWJ1ymCRvUe1umyZWVGlCiF7Dc+o=
X-Google-Smtp-Source: AGHT+IEEl4jPkQqUM+tuvbj8jM0PJmlDwSYA0hEp4W8mWisa+3eruCF0wyklnGyyisWLVfbaOiXpgiyXYE5YuXsglc0=
X-Received: by 2002:a05:6122:20a5:b0:4eb:5d5b:a894 with SMTP id
 71dfb90a1353d-4ee3e291ec4mr6496762e0c.6.1718533409829; Sun, 16 Jun 2024
 03:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de>
 <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org>
 <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com> <20240616085436.GA28058@lst.de>
In-Reply-To: <20240616085436.GA28058@lst.de>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 16 Jun 2024 18:23:16 +0800
Message-ID: <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 4:54=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jun 16, 2024 at 12:16:10PM +1200, Barry Song wrote:
> > As I understand it, this isn't happening because we don't support
> > mTHP swapping out to a swapfile, whether it's on NFS or any
> > other filesystem.
>
> It does happen.  The reason why I sent this patch is becaue I observed
> the BUG_ON trigger on a trivial swap generation workload (usemem.c from
> xfstests).

This is quite unusual. Could you share your setup and backtrace? I'd
like to reproduce the issue, as the mm code only supports mTHP
swapout on block devices. What is your swap device or swap file?
Additionally, on what kind of filesystem is the executable file built
from usemem.c located?

>

