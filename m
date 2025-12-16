Return-Path: <linux-nfs+bounces-17119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5045BCC4AA6
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 18:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE8E73006DA3
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B39530E0D9;
	Tue, 16 Dec 2025 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="da8sZ4Sl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D402D9796
	for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906138; cv=none; b=lUJSlCk6cWKDT60Vs62o1moI9smok+m2CzLOeyX/4JxDz0sJzejsSQeyvQ05ijizhWEVTnaAdTNZ+tElIxYyr/ls8KGQiGUu8UIzJnDZP52CxFgHoQ+F9N/Ss+NVp8dNudkEotvbR/kDZM1R88ZibBkWqqn7mCfM1EvJqj592fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906138; c=relaxed/simple;
	bh=8CglxGVvxtm68zVUWSsJTdLAduinsE2Y2tBcHG/i/p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/Eghh3I8kMpVVIqbvedIjtQGe2rjMf8MieM/VaqnqGIbF0qX1ZzxAto311z2L86tDYyWrYKOvdOnVKlv3uLrJBpT0vPGMYkszUBED7rLoelJQrkRHIPxbC7boVpWpa3ru2nwKGoGY5HxysYBogPdh5IEWgQQJleId6QrgZ1QG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=da8sZ4Sl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b713c7096f9so813759766b.3
        for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 09:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765906133; x=1766510933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bjv+JXKKhCaRIOR7JirA+z8SlS4qGp55T2RSKay43wQ=;
        b=da8sZ4Sl5yZLDCwaPqAw+Rbxz/ZB5b6DnY1RxDpPsdF3cjbhTUbsep0AhPbuHiW24/
         rWZJcbaOOF3ZrMP8HuorI9haZ+pYRmFIfOlMiTc6t85WwERFtPPD0MaqogLJTmau9gHQ
         23FUuqIy3VqhqUMBHKsn4MyBnG2+aFJgihNIwRK4fZD+vNxQP2PLG2+3HtwdSP7qt3HY
         dpNxfBkp93d5W8jOj7P9+0vr2H83yi6Q6o/l8eYoqhRdhFd8DhkdDMkLDlZi8ofpsYHu
         O5ehegkJTmC9Wpz39amwy9zdaQAtdyy/VXMXUsiUzT/5wT40qyrEkiPRzYmY+kG4b5Sk
         roeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906133; x=1766510933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bjv+JXKKhCaRIOR7JirA+z8SlS4qGp55T2RSKay43wQ=;
        b=BqjmHA8iVJtoJgkus2HUeq+gIovVudsOBxYv/RVQoCMKM/6IY0AR2BEA8DCSPVHXXC
         YhADFf3zT4jCQGoioavdMprRgl/wF6hISYwXiAAtZjvOYGbeaHXshLV+7bBpic8MJNd2
         VwfD+B7+hZR9OT5Ks8OGtfxJE5ov+ZOUc2vqBYop07Vh5xklJOoU+6C0RdhdUujet2Xf
         wftRNIfeLnhFVx/FxmpougYsvklSwGcIttXkfFxiAW24Mv435VUoxFoJwE8K+5BeI0rF
         VDl2Jk1pM+QLXrSr7/SRUcuxjmCc7SpbihYekDwW7Dpe+7md8vtNqBJx+nUWTWLe/cs+
         E74g==
X-Forwarded-Encrypted: i=1; AJvYcCUvpGKnk8GsUQLDJeFZNIn4sXEuJgY0r8M+DnX2g2sKAHTLYH80KKsaI0hFT/OVILNM482plmYpfno=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+xufHGSghT+oY37L1itvp/4dZc8nfCdQ7JBBiKsuQhGy5Buq
	+lbtKwwoEstQFGo2EuuJOeyTCkvgdvz1umJ2WUk8Gy/Wp1u89aO+NPEY55ycOg+Korf0qT4GzNl
	n4gJuwOvna72x3ZG6L4IcFUpKjlTbAR4OovWY6hbCr0HRRPk1NIkj
X-Gm-Gg: AY/fxX5zUIAjWTpKw/71gedDdCY2YzEJJqbtvgl80zlgrIN/TEV4oMfvWrgJwkd9ugE
	9lVW3ZeGkV16Omol9KIYvPuYHSkrK3XB/7My+cfOevGivI9tVFIJhi9Ahpu54AaVphHA3mjqXi/
	GF1U3Ef87o/cORsSImozzS8TOgcBJmto17y61x64RdNGp3P7JkCjqfCFMw73d8y9mXnTSfrYFlI
	03Ok0NuCVNfHKVgNKo/3E+VpGQMzI43xFkd5sSN3lvZwPOvsvuC1Rw2zKhAju+4ngN30A==
X-Google-Smtp-Source: AGHT+IEFFFl+NA4/CnnmECyvwKCdJpCJngNrwieHoNo2400ua0IY1vs6bASieU26WB2ZYaubSOJDFfByv05/K2n++eE=
X-Received: by 2002:a17:907:1c1f:b0:b70:df0d:e2e9 with SMTP id
 a640c23a62f3a-b7d23a3467cmr1581416666b.44.1765906133459; Tue, 16 Dec 2025
 09:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215211404.103349-1-jcurley@purestorage.com>
 <20251215211404.103349-2-jcurley@purestorage.com> <b218ea930cb48529fd3fef7efe20c088a78e7253.camel@kernel.org>
In-Reply-To: <b218ea930cb48529fd3fef7efe20c088a78e7253.camel@kernel.org>
From: Jon Curley <jcurley@purestorage.com>
Date: Tue, 16 Dec 2025 09:28:18 -0800
X-Gm-Features: AQt7F2p_-1toYul3KPpBgEbhGfPD3Efk5MqBiqpL2Pa7QzbKZKPMjGAL_ZrMtZo
Message-ID: <CAHeb9+kijFt+RuK3irQeKFQuMwObjd0Mhv-f0h2vNO7u5e9ZgQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4/flexfiles: Layouts are only available if
 specific stripe has a valid mirror
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The correct way to handle the unavailability of a stripe is to
>    1. When reading, look for a mirror, and just report the data server
>       as being unavailable using LAYOUTERROR.

That's the way I'm trying to handle it with this diff? When the client
is trying to read from a particular dss_id, I'm looking for whether
there's an available mirror for that dss_id. The client needs an
available mirror for that dss_id in order to continue. The problem I'm
trying to fix is to get the client to report unavailability of the
dss_id it needs to continue. A DS for dss_id+1 or any other dss_id
being alive doesn't allow a client to continue against dss_id. That's
why I'm getting rid of the loop.

I didn't make any changes to the layout validity checks, only the DS
availability check. I may have made a mistake in the diff title by
using the word "valid" when I meant "available". Would making the
change to the title and description resolve your concern?

>    2. When writing, or if there are no mirrors available to read from,
>       return the layout, and report the error as part of the flexfiles
>       layoutreturn.

The write case I can revert. It just seemed like an improvement to
allow the client to continue against the mirrors for one dss_id while
another dss_id that is not relevant to the write that the client is
performing is unavailable.

> If the server has no way to fix the issue, it can signal that by
> refusing to hand out a layout when the client asks for a new one for
> the same stripe.

Understood, I can handle that at the server. This diff is fixing it so
that the client reaches out to the server for the corrected layout
when the DS it needs to continue is unavailable.

