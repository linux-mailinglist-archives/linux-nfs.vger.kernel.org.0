Return-Path: <linux-nfs+bounces-14372-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC2BB5512D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E247B3A863A
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C3B320384;
	Fri, 12 Sep 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="hQiSLEaB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4789431D757
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686921; cv=none; b=DMO5sl2fPCu025SXqWtxkA4n4tqil1+cIkRvJpLjKD3VtSaBdbckcUQpEhaK9xBVtorF2/k/PxLeV67cSaoTgsBBWfrTQq4HhCSS5uZflaNFxTs/hlfbH/lePInVzi7HUHrnxzFNl9kmU3+mHnl12W548EBUQe/9IDhVjFMPo64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686921; c=relaxed/simple;
	bh=KVi9fjJDMjrHBkdMjrvJ4x2r6TE3gOD27Y77U4K3GoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBngKSD3fLV49JpRVYv3NFnipLSSq0yFVToKWLMgbgLnx6WVygpMNZU0hQfGVCP5qvIlBAxUDjVN/14Y6K6xMN18Hn4UdUc7zk3MG2vRI2/G6DUw4nqB+hdcIKmSRCo3W/W0m22wHIYydKZEuLsazdoUSagl/YcRaxhgKW8ait0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=hQiSLEaB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f6017004dso2131834e87.0
        for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1757686917; x=1758291717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd0/wEk5QXEg1P96jcmKMZrNuyx2xWV1bMQuxVb9F7E=;
        b=hQiSLEaBC8mClsPamS8d1N0BK1+SwnRASo1CCTsnlHnc8rUPGFplIJ9b4yUuNkQDez
         NQWitYd7jUicaCfauRg4XJgZYWkD1YwvFJ2dk1MzhX3Bj2KkiPGuOdIrkFUQpeZlC5Gw
         kuq9q3USxBOfBwIjNPEU1QWMyzICH/bmBEBOxPf91lNZhuF7M6pa7L9YberJL6VO6+pm
         C6qOwKG5WZd9V6tKCJvqHboehkmNg+w3NnH9pVnKKgNC+cLDAXevhBLT4g2LdNeF82w0
         gBc6qg3bC9vfZA960OcGAVEraO/WAbER6GHvHs3mUiucC5uohnE0TIFDLcoJxk2xbjeu
         yixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686917; x=1758291717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd0/wEk5QXEg1P96jcmKMZrNuyx2xWV1bMQuxVb9F7E=;
        b=lIH07/JsLq9CH31OTszAqD1i+nmLWUfEVe9V9l5MDS5yVZqFldAFVH3f0TwSIHQAvW
         He1qbkX6vIl3ubwbB5a/mFGiE9NH2oI3Y/MBexC02M5i5QA8wUZzpxgVUG1GKcoiFHf/
         Op1roD3Usx+oupERjh9knZM5eMuqKPe6PGwWxAHUUtFRg5qHq5NTkDC3+SrwUQA5GlD4
         r+E8V95zfLeLi7+NvQOfoK603vzpmSN0+Ni787U5XLcDociqMp9YB6KwmA1m1OGSb4AG
         ttQRDigtvnkdIev8rHHowMDoNOPyR2A69UNiFHWkdto6FZ4yoST+9PIY7V7u1RWRCoQP
         AxXw==
X-Forwarded-Encrypted: i=1; AJvYcCWR7Pn/Prlm+kRqGeO+Cuwq6vGCgjM/DRakDIpZ3z1iUorO1+HClcrF2+UkxFOMZ5P0lxs7wEd5ivA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllYkt0nMLZD+MdfuWtfyPE1oIZuD27EbMIQoVF++vK9hLSrEN
	7oRZ+z4cIniSBiIPIZTQa4hUa33MwE6S4yYISdEOsAn3XIqrxuEF94z9bpgJ2B1gDxYqMvlZr5S
	JymIQUq8R+rdZMCKMUFlk38rdFi89Qgc=
X-Gm-Gg: ASbGnctH21pm36RXFXHi7rL+vODIlWK+RAtsCBq+wCspT8T2yYdrs6Am4E+Nd7QsA/C
	de75To60zwl0UMNIrWs/88PK+j620Dx3BaC2zSrcmI5jIpsxMt/8IJ54JMaSZ3IgRdOlF7cZ1mH
	vVpMb67MIsWEE96g6qxgIckbzjjxKqC7oI0rNlTlhADZILX+yf0rGaCsjfApM1/jreXvsJT7l4J
	ajyaxpBpKY9iwMdOvzHKMTiQztsKkFKH5h2avlc8w==
X-Google-Smtp-Source: AGHT+IHjmcv0WMnG/HP3QXIjXIGZ6+2HEwkikL7viGXgzUnWmo82i/oOH2FytEeA6uGGfhu/YiOl3mQOuDt1SduamIM=
X-Received: by 2002:a2e:bc0e:0:b0:353:5008:5dcd with SMTP id
 38308e7fff4ca-35350086e23mr1641101fa.3.1757686917046; Fri, 12 Sep 2025
 07:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811181848.99275-1-okorniev@redhat.com>
In-Reply-To: <20250811181848.99275-1-okorniev@redhat.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 12 Sep 2025 10:21:45 -0400
X-Gm-Features: Ac12FXyTvraSYU6nTSrIWiwHll8d-LWKGbPvYPKZAMgHuSFVoM4lHT0nTErYu6Y
Message-ID: <CAN-5tyEmf9HHMuXHDU86Y5FWYZz+ZYFKctmoLaCAB+DZ1zcXSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: trondmy@hammerspace.com, anna.schumaker@oracle.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Any comments on or objections to this patch? It does lead to possible
data corruption.

On Mon, Aug 11, 2025 at 2:25=E2=80=AFPM Olga Kornievskaia <okorniev@redhat.=
com> wrote:
>
> RFC7530 states that clients should be prepared for the return of
> NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.
>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfs/nfs4proc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 341740fa293d..fa9b81300604 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct file_lock =
*fl, struct nfs4_state *state,
>                 return err;
>         do {
>                 err =3D _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
> -               if (err !=3D -NFS4ERR_DELAY)
> +               if (err !=3D -NFS4ERR_DELAY && err !=3D -NFS4ERR_GRACE)
>                         break;
>                 ssleep(1);
> -       } while (err =3D=3D -NFS4ERR_DELAY);
> +       } while (err =3D=3D -NFS4ERR_DELAY || err =3D=3D -NFSERR_GRACE);
>         return nfs4_handle_delegation_recall_error(server, state, stateid=
, fl, err);
>  }
>
> --
> 2.47.1
>
>

