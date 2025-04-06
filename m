Return-Path: <linux-nfs+bounces-11015-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F623A7CE9A
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E713AF9E9
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D72206A3;
	Sun,  6 Apr 2025 15:29:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3C220680
	for <linux-nfs@vger.kernel.org>; Sun,  6 Apr 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743953374; cv=none; b=uuVuc5jNUEN98ibvlQPO4/AZ8Fq1FCecVc5tBb8H6yWYoLJ+hkLdH7eB+aQ8k1IHPt3hZC+3qG9Q9ZubXRihznxIHdv3f9PpZMNLYY+jrlz2DK427kiWLSlDjKkM7HkPa7B/3HHVhltWKLAyZUS90mmJYwRCrWYWa+Y5sNt4OkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743953374; c=relaxed/simple;
	bh=DpKGNXU/7u5HvuxUFXiNUorwKgghaJBLFdbhLJGTRTc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YhJC8J1gsSPpZFmM2JITfSoPcnJbTXdlB5HMoJfDUeGezpKTBD7od6/PlxWi2oZPH8JDNxus7NCIU/Xffx5o2FxkOlrycOLYE9qorTcEUVRl0AjhJXs7FF5odvhlSPHy2XiHhQynvORvC+WgGN9Q5HNxwsSB/fPA7V8fb06r3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso17881585ab.1
        for <linux-nfs@vger.kernel.org>; Sun, 06 Apr 2025 08:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743953371; x=1744558171;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggbrpGjqEkDEF21FfZntKxEubU9zZQ1QbbMXWydDSKs=;
        b=U+1TBUC513wuSg3hihx09TiFGRwzmkL2WEoXbmOivJ31670aPGsrkS/WfDK6Q+0/gM
         LkvmfGnQhtyj7+pSd+k+j4ATwvzcIZqfi09QwLss8ctnCP/1uZQjcAmr1MjSe4Za7TGU
         vu3zMeluADgwdVPbDSyhmQH2PSNBQf4T21hreiFAIVPSlAmMniWzSdL0b2+M+/rEwNqT
         7lqz+zKGivpDgphz5AxynP9cGyBdsBeqPrDZx/RacGaeVHPhuHQPp6UnYxyjU9cFkMRY
         BNIU2gEFEibMHqJq5NG407vB/y3SEbF9ztXbnjDla/deSN7p2qRqpHM+4WPYP712DaXF
         +bjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe4xG2rN4UOYwgHAvQ3sjZ5GmMDdPkq7jhhR5PYzi9eR8Hwl8+1dGrsTu5kvNaX9pSBcPw+je/73M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75l3N4bAYV9jAmykNWZpyfoKJpOSbiMnGIFnUNQItX4pRTTf+
	x3E+rup4aPst3rcF08yYxnrBUDKCNrHtCz3/6LGKtXvvlcSwkMlSLT22tQk=
X-Gm-Gg: ASbGnct88/p/r5dfPeFhTGZftmfvZV/hvrAEmIZ4Oh5mwRhBLkbzBwcNKKy8kPPic8w
	/zV8+cQ8vW3sxDgCP63aUkB+s9zsSPx4F2W21fc0HKa4DodfRZKuR1Bwl7oW4ygVYUUxxhBK6VQ
	GS66oszkQTcKt9ZRpxkFnC/DMws+MlJ11PmAXUYkqlJVP4FleQdMpZBwHFHs1IEjvHdgicwfStQ
	L2e6NS7oI7DJQ+HZOwZVI0GFmu56RJ8jkZxd6kK1RsEUCo113qt0KppyKliMuZ04Q6n6ZWcYkUZ
	WyMIgmH0B8R0kZ6hfSqZtJchrN5r+N8Radx9RHkBKx1rgAbb0wAXYVty6D4vYw==
X-Google-Smtp-Source: AGHT+IFT/tumtRjKMR2TJbGJssP6LGsFXBQajc1gAee9YQdrqsBsUUzFttg1eJbYMQdW7gf3Jd1p2w==
X-Received: by 2002:a05:6602:4010:b0:85b:3827:ed06 with SMTP id ca18e2360f4ac-8611b42b41bmr1163188239f.4.1743953371607;
        Sun, 06 Apr 2025 08:29:31 -0700 (PDT)
Received: from leira.trondhjem.org ([46.140.75.202])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8611137c306sm154511639f.33.2025.04.06.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 08:29:30 -0700 (PDT)
Message-ID: <761c9aad0a943febdf5b05dfe585197629ea0a5d.camel@kernel.org>
Subject: Re: [PATCH 2/2] NFSv4/pnfs: Layoutreturn on close must handle fatal
 networking errors
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Omar Sandoval <osandov@osandov.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org
Date: Sun, 06 Apr 2025 17:29:26 +0200
In-Reply-To: <a5c66e082a0b8669c89bb487027da7fac66fa5b6.camel@kernel.org>
References: <cover.1743930506.git.trond.myklebust@hammerspace.com>
		 <cdb06dc8d5ab3e65db78a78a9ac5969453efe0b5.1743930506.git.trond.myklebust@hammerspace.com>
	 <a5c66e082a0b8669c89bb487027da7fac66fa5b6.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-04-06 at 09:16 -0400, Jeff Layton wrote:
> On Sun, 2025-04-06 at 11:11 +0200, trondmy@kernel.org=C2=A0wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > If we have a fatal ENETDOWN or ENETUNREACH error, then the
> > layoutreturn
> > on close code should also handle that as fatal, and free the
> > layouts.
> >=20
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > =C2=A0fs/nfs/pnfs.c | 10 +++++++++-
> > =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> > index 5f582713bf05..3554046b5bfc 100644
> > --- a/fs/nfs/pnfs.c
> > +++ b/fs/nfs/pnfs.c
> > @@ -1659,8 +1659,16 @@ int pnfs_roc_done(struct rpc_task *task,
> > struct nfs4_layoutreturn_args **argpp,
> > =C2=A0		break;
> > =C2=A0	case -NFS4ERR_NOMATCHING_LAYOUT:
> > =C2=A0		/* Was there an RPC level error? If not, retry */
> > -		if (task->tk_rpc_status =3D=3D 0)
> > +		if (task->tk_rpc_status =3D=3D 0) {
> > +			if ((task->tk_rpc_status =3D=3D -ENETDOWN ||
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 task->tk_rpc_status =3D=3D -ENETUNREACH)
> > &&
> > +			=C2=A0=C2=A0=C2=A0 task->tk_flags &
> > RPC_TASK_NETUNREACH_FATAL) {
>=20
> You already checked that task->tk_rpc_status is 0, so the inside if
> statement will never be true. I think you probably want to get rid if
> the outside=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 if (task->tk_rpc_status =3D=3D 0)
>=20
> condition?

Sorry... Jet lagged in Switzerland.
Let me move that out of the =3D=3D 0 and before the !SENT...

>=20
> > +				*ret =3D 0;
> > +				(*respp)->lrs_present =3D 0;
> > +				retval =3D -EIO;
> > +			}
> > =C2=A0			break;
> > +		}
> > =C2=A0		/* If the call was not sent, let caller handle it
> > */
> > =C2=A0		if (!RPC_WAS_SENT(task))
> > =C2=A0			return 0;
>=20


