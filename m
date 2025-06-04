Return-Path: <linux-nfs+bounces-12097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD56EACE2C8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 19:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EDB1882CB2
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DA71E5B72;
	Wed,  4 Jun 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq81WB1o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4461C84D6
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056902; cv=none; b=FIdGNskuP+f3CgaB+epFpWBcnq9tdNwcnxh2G/D2CCfl2u8iKw7OZCkTNp6+p7PbKQqlZKb+Yx3W3hBZE6bHXFVkGpSADRXgL1P1N5Ew+xTdRJFIPflfNVNm9oVRneN8gVmYVvTdl3mjbhmR9gX7cfXp2wAdIc/XERon2FBw3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056902; c=relaxed/simple;
	bh=wmj2QZ6yfkP7RCkZZG45wmJL6rNTDG2J1R1ofurh5sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ocaBMGf0AY6pyzbYzfi3mkLgg4GXoTmy3OujXj3/ZLn5xVztzfUK2iB9je4uSrO/qK93LKIJrd4o3pPE+63fl7h3QmwbzpXwGsizI+ZHMks2VaENY+TE8GJxCUGkUoaUBt4IBcbHXU0Ce4QNdL9vc4+/dsoEjx5t5xRCC8Q+fpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq81WB1o; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2c3c689d20so6242a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 10:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749056899; x=1749661699; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMsdZfEZKuqIE7HPaBs/ShO0vPlmkRA+t9pPgXkXsLA=;
        b=Kq81WB1onNSQrQQR6r1S2AuL3rSyewetth/v2qGsrTHyezGmtPJc4Xwrs8NJ3cjBHM
         opna1NQ5mKf1PhsI6b7SYGjfzbrMVoZ++I2VNLax6VpQJ4+uO4VOsbgVFdmjnAlHeNa6
         1Q01vyEvjvjHcFCMOmGhdL2+m8D0kBc1rkI3xcN27F1eVmteT9cCMsbMISdg+K2621cX
         L282iQQL4j3B9D0PZ8lX0AUL6zVn5Kh63e4gCwizcabI5JamewstSZ+7/t5xvqN47JUq
         QcQGUdq9yBzwTiRoX8QmnXiZaIIPvjkkEjrZjk72oY2b888YqezsAGnbZZx+/mhzM7Gd
         j1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056899; x=1749661699;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMsdZfEZKuqIE7HPaBs/ShO0vPlmkRA+t9pPgXkXsLA=;
        b=qKYUDvQ1v9SUjX6X+tnaQyDUgnTFBrB+L3fiyGM/hQSFXXbxxlRzFuWxyayUaZq+ro
         g/4uorxiuOMvATCiCE61xU3tN1EfkFi/HdSGic+joC+HP4abTbomSTBJg7QX9ERJjcWO
         3TFHqdd1CSQBJSBLluBu68fqsg2NhZF17ZVOjWVwRn5L8hdBh/KLTxRO5vXkNhg7ohSs
         TKPNzvhvKPzjWegO1fRNF2k8rnKBHfC+c/gXsoYEhN/weI8pUszyoqAwg9lx/Gq9Aho9
         dZVCV7KMHyT7inlTK4hBNGP0Fw6vLAxHvZkjB03mQTdt33HZuGJNnFarPZbG5cq7x19A
         hTaA==
X-Gm-Message-State: AOJu0YxlJZ5oQQtBXNjv34jOAaN3FOfF5Aj3UDAhcpOTIOcW0ILQ8i9Y
	nLYlbBjCPKNdJnxaZ+nqiQLEeaSbV71qbtDERIaN/0H4F57SlBN04ktbqzdPxy4KggZ/3RvElub
	L/pU+MpEhVbXLYUzm3J3zX1EaRHBrViTHtVqd
X-Gm-Gg: ASbGnctQ2itg2DgB4AJzeZ0R7Gp+vfbfl9FJXMZ+wSUjgIG/O+/dSS//jQAQgbWbxyj
	fUMf1QPr58x/sZCsgNzCYBKJ8fITJiXEFEw1SMGYidyGDsxK9sWPxs7VLynqd8/ajn/y3ci6+ZZ
	lCSezJbGhUkDiD/TowudZTkBJkaZud0vq4
X-Google-Smtp-Source: AGHT+IHfGSfzSWub3yEQVf8NqAgbXGv2ExCq9Iii5z9Qgl9amQfVmWUmk2bIKSGGx/e1J6bV1LF+znTJ0Ru0U+nEo3k=
X-Received: by 2002:a17:90b:2f45:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-3130cd15a11mr6753836a91.12.1749056899448; Wed, 04 Jun 2025
 10:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-master-v1-1-e845fe412715@kernel.org>
In-Reply-To: <20250513-master-v1-1-e845fe412715@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 4 Jun 2025 19:07:41 +0200
X-Gm-Features: AX0GCFuuwD9KaRAps14qR-zzbHOFjzjZsbQrXRzGYp9PgU8SezGMIScoK9XRlU0
Message-ID: <CALXu0UdK=4Yj5CF-0ZyHWqKf7GdLL5J1xT4tn0cOpxvs5d4Z7g@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 15:50, Jeff Layton <jlayton@kernel.org> wrote:
>
> Back in the 80's someone thought it was a good idea to carve out a set
> of ports that only privileged users could use. When NFS was originally
> conceived, Sun made its server require that clients use low ports.
> Since Linux was following suit with Sun in those days, exportfs has
> always defaulted to requiring connections from low ports.
>
> These days, anyone can be root on their laptop, so limiting connections
> to low source ports is of little value.
>
> Make the default be "insecure" when creating exports.

I'd request that you also rename the darn thing to "resvport" and
"noresvport", and keep "insecure"+"secure" as a depreciated alias
around.

if you do that you'll get a Reviewed-by: Cedric Blancher
<cedric.blancher@gmail.com>

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

