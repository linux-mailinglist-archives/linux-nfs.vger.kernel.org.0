Return-Path: <linux-nfs+bounces-2688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D2889A93C
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 08:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E10283619
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8019479;
	Sat,  6 Apr 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLLyMXCT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301F200DE;
	Sat,  6 Apr 2024 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712383660; cv=none; b=nbBa6yKavEfVXWppgN5BfiocQjR//64qNyDmX2/BZg3W2+A6FX/SZPYvbwvqras5k+VFx5ZrWw9yNBI2gWvyRbgOeQXzQcxGrbKszfwyI90cEzjpMStme9tPR0vQlplxGdlloIXdhEtWu+6Ph5qAZO4PGXPLKtJIKfgbagc5g9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712383660; c=relaxed/simple;
	bh=scfaY4WnteGM3U7rpqzfa55QBhmXa1xDwuDdv9hVIN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dseR1Tn2V1VrncuFoBV4YYzm7JxoO+rCepbRaelVGVfIal3SRB9v0+5LsAjn78i+3VwqTtVbmd6d3/vkOmBp/Tjbm1SlbOV8fD0LnJkZ72xqzytve3PWngOFKpWS2zYC5v4k7uK1dzaRvZ7lAtEyjyw7THS53c3pqzElLXOFsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLLyMXCT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a465ddc2c09so186096866b.2;
        Fri, 05 Apr 2024 23:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712383657; x=1712988457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=luuXkiPLqjOUYuai7b32l2277foMuYxG6POiRKCtamo=;
        b=QLLyMXCTUebSzOHQ4cVqar/FHfZw4CRvx7MXQWB5/bRQ7rSj7Q4ysWHKj1Mdd3sdWw
         25aOnYp9UxI5L5WLac3lEBKazPTsAgnOE++u9G4NnCGZW9eFqpG3vntszkHFagsl9ZBn
         fIMNRi0kvoz09UkItZ2qhhgiTbEgYN//zUTv0kljPget6I9ZeD0DDMGpIh1KBJ9zxupg
         r452NVEV+dKOWTmEF7PgvOByN2NYH8Cqbga1PWyyxXQnIS3N87TunuqIuN0yZmo4UYxn
         q4c9lnFBDEC+CdPYy2q2dRmNyXAuQjw+0Zvs7z2VmUpDrRr3WyhLqmj30bnE285YsaeW
         xhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712383657; x=1712988457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luuXkiPLqjOUYuai7b32l2277foMuYxG6POiRKCtamo=;
        b=JcDFIZ6R6vvA5+a/tkzz1Opk7/nY56+8rdKWSN5K3Sgo5I1gInFhL7XEGkegsTYtrI
         LCRo3qpeUYt34TKfQSdsqLj3uA1vUnPi7AZHJUIAhdhfFHrMbEAQAodQ5dQ+6xWZzDMT
         /M6gGvxkwVPAVSv9AWltpol4J913Txtl/N/WIDULGixeK2mv84KtR+NVrnOvVhuMBk/G
         tleR9o+yEFUQigA2NFJO4VJvoZxzZfH2tKHJdgeJeykLWoE0PcB8728Cv76y0zxH26C6
         hFOvCIad50UaljtyGr3kaWo/aYXGMUl0ODD6L+aHyHxit3uP9aLy9a8t2oirfNNdhUDX
         I8tQ==
X-Gm-Message-State: AOJu0Yy0eFWeIPY0YW0bTNqBrlCPBKNWHeCi0QiQl9uC2z0SHVmLgmCi
	uLosIoG00bDgogbybN/4txZJJCvuh0kXdpo3O4cU+IZkdI9tGW4qccZj09TGPKGQRZ3nL1FDoFj
	U6WQqBoTVNfhuHlD5al9LUFvgof1QjokE
X-Google-Smtp-Source: AGHT+IGFt5FWWSkkvWHZKKfisY6TmiuHUtulWN3a5fqlVWFBiiBm62nRL5sLQSIdr1YFo55tWOq8KdaC2zpRv2uWWIQ=
X-Received: by 2002:a50:d69b:0:b0:56e:10d3:85e3 with SMTP id
 r27-20020a50d69b000000b0056e10d385e3mr3130509edi.13.1712383656780; Fri, 05
 Apr 2024 23:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-rhel-31513-v2-1-b0f6c10be929@kernel.org> <ZhA93BQSxkJqmqaw@tissot.1015granger.net>
In-Reply-To: <ZhA93BQSxkJqmqaw@tissot.1015granger.net>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sat, 6 Apr 2024 08:07:00 +0200
Message-ID: <CALXu0UdPhS1KOZcwS3bXe0E_E9-XQ5W-y57DOibjc7FrXgxv7g@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: hold a lighter-weight client reference over CB_RECALL_ANY
To: linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 20:07, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On Fri, Apr 05, 2024 at 01:56:18PM -0400, Jeff Layton wrote:
> > Currently the CB_RECALL_ANY job takes a cl_rpc_users reference to the
> > client. While a callback job is technically an RPC that counter is
> > really more for client-driven RPCs, and this has the effect of
> > preventing the client from being unhashed until the callback completes.
> >
> > If nfsd decides to send a CB_RECALL_ANY just as the client reboots, we
> > can end up in a situation where the callback can't complete on the (now
> > dead) callback channel, but the new client can't connect because the old
> > client can't be unhashed. This usually manifests as a NFS4ERR_DELAY
> > return on the CREATE_SESSION operation.
> >
> > The job is only holding a reference to the client so it can clear a flag
> > in the after the RPC completes. Fix this by having CB_RECALL_ANY instead
> > hold a reference to the cl_nfsdfs.cl_ref. Typically we only take that
> > sort of reference when dealing with the nfsdfs info files, but it should
> > work appropriately here to ensure that the nfs4_client doesn't
> > disappear.
> >
> > Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
> > Reported-by: Vladimir Benes <vbenes@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>
> Applied to nfsd-fixes while waiting for review and testing. Thanks!

Please add this to the 6.6 LTS brach, too

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

