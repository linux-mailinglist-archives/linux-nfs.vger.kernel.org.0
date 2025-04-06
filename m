Return-Path: <linux-nfs+bounces-11014-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA0FA7CE97
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 17:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C50F1889F36
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10613B58A;
	Sun,  6 Apr 2025 15:28:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B0224F0
	for <linux-nfs@vger.kernel.org>; Sun,  6 Apr 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743953294; cv=none; b=bmDw26381C3EJXBPnNNAjbQHRdBh5pfRHAIdPhP/zj7MXE+IGzpQ/piasdije4C56vRzUmYsUbCgZZzCQxTc8td856yHw6a1bWYBOCzNDTULpMup0QEslxyPOhOUZ53UMU0S9xGWORxI0a0ClcKqb2GI6CddL3m+RFbwESDxnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743953294; c=relaxed/simple;
	bh=AITI723g6j7sCQGaUaNObOSaOJaOxUVI3QzdbmQOpmU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txDFhD540e283fl2vWDUwdIWvYuwdg05zvWV30pwikeLDXYltmrRjdXSxcZ73gh4Wm5ZlbLg8m9F31dDJy26R8yKF5VtrU2gwgK7EFqNnw+4naV94MQIDmO2GZW1sIEePUBN7/NA3EjIFABXzRSY1DulhyBMiXOsfjK7QectL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso114132439f.2
        for <linux-nfs@vger.kernel.org>; Sun, 06 Apr 2025 08:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743953292; x=1744558092;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbVgrXwY7yXd5piamGxenXd3ZvwxgGA0LpsP9kD8fEo=;
        b=aIuiMOmXVSPwpPdiXzGyOiBrNr21ZYrYhIAoef4EznjmVkDhyaLnuUq1F1kDZ02G+n
         v9isdVyuhh13Jd/rSTgeX/BGq/80VHs354SKnLK4FCZ1wh6NDwxmgjVemObBENdfZ+va
         oYGrG/Z8LnhGUtNwFf3VNy/juXxqMxMAWMjZrNxsEotYtBRCbp9c4RxfZlERpY8DrwVC
         EoN4V/BAHOvXKY88Urgs0rn6H9zGGJhdtEqJlCtJl59T56rNrc25uiDGntVKQZEdA2Yb
         Qg6fUdFC89kkOZjXT072gmz/63KEuVh8DLSk8eAAcRWE9h0SWRpVS16gd24qe4UNHPa5
         KXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW/UdHzrZ/0VyxohdePnHfwGTjp7w6IcIcBj49sxTMQsOkWD8Aj5RVby7za8VXFq4rEtlDXX/FLX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9P0JYeUr0ectHQE6nDHKrMHls2vzQSUyLcjBBFZ8ZG+RferYl
	WhwngpLGeBszz+LWDKzivzYvzEPj4Uavo7Eikql50Ni2WDQsFb4=
X-Gm-Gg: ASbGnct+dg00pN88ta0fFcjKplTuCxMEk/3rrJAW0YbXhUujL+ouvCjpFhrRgsFmM5S
	PpVgqry6c2tlJHXL6y1g8BQU1VWwpo5AMB43gQt+69UY2xdWIoVGmmbrDvYetQh9v0iGi59euRM
	XBgNK3nxB6p9/1z3Wh/tBYqaUkiHMMslgA7HM3ZlIKXECyTL3LhZe8ZyKuSsz/CZ1puphv9ElG1
	tssvPvI+MqD3t9D30wR1NeKV9QVdAZWWzEWVWGBKtzpJ0FEazqZBFNH1BW4d4FTcooTa8pzV4mN
	goZ53WrWrZYp3Ppcovnx7porjU/8Q3j9j12iLZx799RMoPKLgv8OUeoGLbtJNw==
X-Google-Smtp-Source: AGHT+IFiH5D5B+hVtKwndFPWQBNHPFVud7BHNnVJ1yG2qYFyAUlvqZu/6IFcRaTZcBiYjB4uJFbDzQ==
X-Received: by 2002:a05:6e02:1a0e:b0:3d4:3d8c:d5b4 with SMTP id e9e14a558f8ab-3d6e5329207mr82321515ab.11.1743953291840;
        Sun, 06 Apr 2025 08:28:11 -0700 (PDT)
Received: from leira.trondhjem.org ([46.140.75.202])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5c2e8acsm1837843173.1.2025.04.06.08.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 08:28:10 -0700 (PDT)
Message-ID: <bf530a569ad6d65edd011154b8f0cc609ae897fc.camel@kernel.org>
Subject: Re: [PATCH 1/2] NFSv4: Handle fatal ENETDOWN and ENETUNREACH errors
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Omar Sandoval <osandov@osandov.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org
Date: Sun, 06 Apr 2025 17:28:06 +0200
In-Reply-To: <b0342047d444e49aef379193497dbbc4f3fff3d7.camel@kernel.org>
References: <cover.1743930506.git.trond.myklebust@hammerspace.com>
		 <756e03b4405f80344f98a695f49e50dd3a1caca0.1743930506.git.trond.myklebust@hammerspace.com>
	 <b0342047d444e49aef379193497dbbc4f3fff3d7.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-04-06 at 09:08 -0400, Jeff Layton wrote:
> On Sun, 2025-04-06 at 11:11 +0200, trondmy@kernel.org=C2=A0wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > Ensure that the NFSv4 error handling code recognises the
> > RPC_TASK_NETUNREACH_FATAL flag, and handles the ENETDOWN and
> > ENETUNREACH
> > errors accordingly.
> >=20
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > =C2=A0fs/nfs/nfs4proc.c | 9 +++++++++
> > =C2=A01 file changed, 9 insertions(+)
> >=20
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index da97f87ecaa9..f862c862b3a3 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -671,6 +671,15 @@ nfs4_async_handle_exception(struct rpc_task
> > *task, struct nfs_server *server,
> > =C2=A0	struct nfs_client *clp =3D server->nfs_client;
> > =C2=A0	int ret;
> > =C2=A0
> > +	if ((task->tk_rpc_status =3D=3D -ENETDOWN ||
> > +	=C2=A0=C2=A0=C2=A0=C2=A0 task->tk_rpc_status =3D=3D -ENETUNREACH) &&
> > +	=C2=A0=C2=A0=C2=A0 task->tk_flags & RPC_TASK_NETUNREACH_FATAL) {
> > +		exception->retry =3D 0;
> > +		exception->recovering =3D 0;
> > +		exception->retry =3D 0;
>=20
> Why set exception->retry twice?

Oops. That last one is supposed to be exception->delay =3D 0

Thanks for noticing!

>=20
> > +		return -EIO;
> > +	}
> > +
> > =C2=A0	ret =3D nfs4_do_handle_exception(server, errorcode,
> > exception);
> > =C2=A0	if (exception->delay) {
> > =C2=A0		int ret2 =3D nfs4_exception_should_retrans(server,
> > exception);
>=20
> Other than that, this looks sane.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>


