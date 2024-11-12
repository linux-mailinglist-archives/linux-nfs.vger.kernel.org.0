Return-Path: <linux-nfs+bounces-7893-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32C9C569A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 12:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A330F285211
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE051FB734;
	Tue, 12 Nov 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU8yBeJ+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B561FB72E
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410902; cv=none; b=lQVlL3PPW4Ausp8/xk2+C/vNkLtGrrs+AswX99Xuurs5vLpiNXCwJTv3+86fX0gCIZcZskfUNRFaAp/jZWy6vWHLVOQSDWMbq19GFyJo8kxMH3r5Tlp5WMJu2qIw+5Ks5lST+gOflsZiqvO5uIhbrchKVJSa+Watnl1nzBkQveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410902; c=relaxed/simple;
	bh=uCTN65b6PWIT2LkRk3K92OrKu2DMIYesa3QXnVglJIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jQpI/jp02gYw/toLri+fkm/i5B94DGe5SDFHyHSNde6m92CwI7iinn484lqVGwwvMSpJkZMt1r9dN9iTZ6GbpKp4wHKtqWVWO4z0bid5lE9uVcGk4z3iIEmYa6MgNX7ti3HNOvvK4bS+Bl/9ScAc9ISeZY3GX+vZ5Dwo7xwTqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU8yBeJ+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99e3b3a411so1130523766b.0
        for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 03:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731410898; x=1732015698; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCTN65b6PWIT2LkRk3K92OrKu2DMIYesa3QXnVglJIk=;
        b=nU8yBeJ+Zw8gygY7YFkzyaWfvjF72tE24lPdLC0Ze/t+W5ZC1mIC3m8EjhdpPoo6uE
         //wS2tjoYxUSseyzdiwqgM/kbS/kkB5zfp79xg0p+rkh+hJPRdmQ1M2wo84YDHcZE9jP
         gJPsZ+AZ7o1r34vUTUYf6ownNZxEZEbeopDKSJF5WhXgPm0w8ZDyBTiKQrMHJf7AJwtG
         9hb2KhhkXNYvOy0amlKATVQvf+Pt0ZTQUQjmVbeR1GjYCGzQgh63/ksf5zZFc/dnRO19
         XMdx4SXh01/foyLv3QBkkDkQ8uth0+xaQFMUv38o41NDt6Pwr2KonaJ5moPFhX0ic4sK
         bO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731410898; x=1732015698;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCTN65b6PWIT2LkRk3K92OrKu2DMIYesa3QXnVglJIk=;
        b=Y+A/oObrDQX9hEU84rzqXIk9EVP4eiJn6RHsy8tMArLtlwSJAiopUJLVClmPKMWu9R
         TniND2oJ0mtPUxa6Ga/QLCOMvXsfdII0yo7hssYbKPR1XEH/LFqIlE3q55K3fUaJOjlk
         l2YHHiLDkjgDU0p5EouqfaENcP2fAvbyp/NiOz0uJk+V+sal6LRPuuTAtZHx1IU4q3Cd
         1YyfK/u8uQfu8yV9XEFfT4nkc7WCAQO911kPHoyVq6u3bJ1igIrHIoR7uaxv3rXcMhI/
         Un2lmtuCFciFg2IsgaNdY6mIatfBfvSErDbFHbeLAXt1fJ8xI22KcoaadY+vLzZlfbPu
         nVLg==
X-Gm-Message-State: AOJu0YxARWkWmhMADZsdivxAWh2cfOY7NizmXav+ybc8p82Kox89cGv/
	JTpj+5kknmck7OCiGXRqnwtCMNN7RfxJAQDLFuYBDaDo5m0UKSvfGso1M9PWcQ9CmVXmwpmikmk
	L1Z5Zry5U9t1ZueEA6lqzrmwcWsYL3xiv
X-Google-Smtp-Source: AGHT+IHkXELyHt84R5CfiAgccXZ37MKijiG2aa1IkDyWAHFawLtEcrgiLkuuW2w0sSV17UqEMlkNco5P7oauTUDq6uc=
X-Received: by 2002:a17:906:4fd4:b0:a9e:e1a5:755f with SMTP id
 a640c23a62f3a-a9eec767f2emr1577569266b.1.1731410898329; Tue, 12 Nov 2024
 03:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Tue, 12 Nov 2024 12:27:41 +0100
Message-ID: <CAHnbEGKJ+=gn4F5tuy+2dY58VS7wOyhyxEqsBQ5xdzXMs-C7cw@mail.gmail.com>
Subject: rsize/wsize chaos in heterogeneous environments Re: [PATCH] nfs(5):
 Update rsize/wsize options
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 8:25=E2=80=AFAM Seiichi Ikarashi (Fujitsu)
<s.ikarashi@fujitsu.com> wrote:
>
> The rsize/wsize values are not multiples of 1024 but multiples of PAGE_SI=
ZE
> or powers of 2 if < PAGE_SIZE as defined in fs/nfs/internal.h:nfs_io_size=
().

*facepalm*

How should this work at all in a heterogeneous environment where
pagesizes can be 4k or 64k (ARM)?

IMHO this is a BIG, rsize and wsize should count in 1024 bytes, and
warn if there is no exact match to a page size. Otherwise non-portable
chaos rules.

Sebi
--=20
Sebastian Feld - IT secruity expert

