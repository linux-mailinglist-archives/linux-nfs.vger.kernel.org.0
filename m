Return-Path: <linux-nfs+bounces-13180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E5FB0D853
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 13:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6433AFF2A
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 11:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839712E425C;
	Tue, 22 Jul 2025 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="Ucm/zZCO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B72E3B05
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184219; cv=none; b=aTb7AeL6lQtl1oez/7jaXL+4R9/eeIbqvBv+NdwkqfhuPbdep2XbringXFCu3NnzMXDY5ZUyi8UMhAuUheu6ttvueMFwcjt0nF/PVIrbNL8raS8zT5N9flGXojDTz1tfkYFEs4Y+ddbpveAb0bvojxc/HAvVS6ZGfFUy8MEbnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184219; c=relaxed/simple;
	bh=8iemogpsBkMMA0VvbWm79f6T8U6G6OCVioboRlKLeYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POGhZ+NGkEtM+s+HtuoxKOwlZXZVyMCYYtqgxZn1Q4b+1lgJq61p4E5NsvCsVHFPklkhecNxzi/965ihK8kO/8NFkq54sn7JbGU14v7hVPYrvZ4mkSm+PBwKITFs1jw15t4otg4jTelqMsbpTYvRAKGHfyALupVBtKlH1Vn4R3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=Ucm/zZCO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso10383522a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1753184215; x=1753789015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8iemogpsBkMMA0VvbWm79f6T8U6G6OCVioboRlKLeYs=;
        b=Ucm/zZCO3AKAt5WGzVc1Hdj3lvXs9mhq734o8VCiQ36ml6nOpuuaW6Mo7h5bnEmzoP
         IO3I5zoI0flkDiBeqyHqEhpBnEwyQFwn+On1qTamztMAfVGxmsU99rhmxldnKshxu0ia
         KiYKFWpVXGSDCbhiIxkAyHk/RSJIH2xXbX9YTB13dYN/0Qzou5eJkOI6MV8WCS/j0GcL
         QVezet+ItI3CX4C7s1aI8kkhbdOczIWZSZSr5k0vaMHwk+7hVPWcO3OMgmyeMAB9lpjU
         JFmxhGon9zr63Fqj3004GIrt/w5RRfpj1+UTwIW87PjnIMImViJGIac/NFB8capVSZdT
         RzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184215; x=1753789015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iemogpsBkMMA0VvbWm79f6T8U6G6OCVioboRlKLeYs=;
        b=H1+4ceijCVSSdERaFKhLJQe4u5ZBKjKAc9+9K5/xRlheFkO9YyDW0ElWgUT+ur7lvB
         Vl+nSLLTUnCwvyvY3IZ3Li2OnwrH4LJNDH5DOL30yy1cXwFwS5froOWN7oSM9ZUwleeY
         xa0dhQcta1numfYCJqvGLH7sog5wbqrRBAZuVOH8+FfqVOxDfXfUwWd0WlAG/UP9jJSn
         eiRaoCeTON39CWy71kHnNJXzl9ltljvepiEXRcSApQYfA8eORY5/JPxsWOxAuzoIyVw5
         JeR9Tk+liXqZV/Dg4NjCc/j6iJj1fLwMLd2lpjZryG1q+BofE2D+JarbDUVvSfEnKhPt
         k/Tg==
X-Gm-Message-State: AOJu0Yz5afVRrNlGYvUd9L6kQ196qURa7AVaAzCOYM1xuX4VqMCCj/eD
	Y08+1nkdkh5+qvT2BdPrfzOTxcPv3kh/LHVGIRwwqNmvqaeGIuDN9hvjjS/a6D3r65IhaiOHXzI
	lpnyXjLaPGa7I+/E/9+M/2pCa6poWqg2KMbtWMDPTUg==
X-Gm-Gg: ASbGnctjCCJVk/1I+BsI/UcVj5Fj8ORCQ+KVfWK8PUNnCZrYVizgncRirmlVjctQ70L
	tAzjTKoIyvlrA1utPoESyLKWhI6BID3Dq1OkOI4od0hHjvajRER9hmTEF2+5NZV8bXm6zhw9VZ4
	ZTDUwYN4SJHk0rwmngN/vq8JvBp3uPLmt+QOFvfHgdgmW7d+hWy2YRepmvZphxSLfRZnmRYLJgM
	3nCDw==
X-Google-Smtp-Source: AGHT+IEhHbLrHCwc4VliCPJEEd3qMuQZ8aOd/cwxIwHv+M242eb80Pwfh4gpg1FKxvm2pknhdTvlt8stQX/++NYCQnk=
X-Received: by 2002:a17:907:1b02:b0:ae0:1fdf:ea65 with SMTP id
 a640c23a62f3a-aec4fa9542fmr2054010766b.17.1753184215394; Tue, 22 Jul 2025
 04:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <054308ba-bad7-4e61-a11d-34f041399543@gmail.com>
In-Reply-To: <054308ba-bad7-4e61-a11d-34f041399543@gmail.com>
From: Daire Byrne <daire@dneg.com>
Date: Tue, 22 Jul 2025 12:36:19 +0100
X-Gm-Features: Ac12FXx0DyUI38hVXfDE42KLdEYMqMUGma-WqBXAtfNA2A_AN2xtI_3ksS8fbh0
Message-ID: <CAPt2mGOZ2ehyUMb2m6TgDr2Y2ghRozmamxwtjd8NwAAKGBuPDw@mail.gmail.com>
Subject: Re: Re-exporting NFS shares with a generated fsid as a UUID?
To: James Pearson <jcpearson@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

We just hard code "fsid=12345" into the /etc/exports for each
mountpoint on the "re-export" server. We use config management on our
servers to maintain consistency.

We also mostly use NFSv3 re-exports but that shouldn't matter much.

Things get a bit trickier in the case of something like a Netapp that
might have multiple "volumes" appear as a single namespace (you have
to fsid each one in the tree).

Daire


On Tue, 22 Jul 2025 at 09:49, James Pearson <jcpearson@gmail.com> wrote:
>
> I've been experimenting with re-exporting NFS shares and using the
> external fsidd service via the 'reexport' option - which all seems to
> work OK
>
> As it is possible to use a UUID as a fsid for an export, would it
> possible to allow an automatically generated fsid as a UUID - i.e.
> instead of talking to an external service to provide a fsid, just
> generate a UUID which would be a hash (of some kind) of the exported
> path ? i.e. no need to use an external database to supply a consistent
> fsid ?
>
> Thanks
>
> James Pearson
>
>

