Return-Path: <linux-nfs+bounces-8470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA839E9CB8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 18:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACB018872AA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 17:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0312B13AA2F;
	Mon,  9 Dec 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="g2G2BVnp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864EA14A60F
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764350; cv=none; b=hbfj7h8pJRrzSCL9QezGl0a6Mnr+nhQwyaxc0SfS7FV2qMFtPsQ9LaRSuuvZn935nWC/bLON20rUvaACZr4V40cODyU81e23y3IdEEiHFgAb3szpx5w5OzZQLN3Ln9zOaenPyDViRi8HH+OMOT+5IN99YSzU/2tLWaI2pHqAnmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764350; c=relaxed/simple;
	bh=cOzd8+7H/GN0o1zps3NAZOOuJnioPUq6sgRKP597Lz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQnuCC+vyFgGX3z6mybNjk/I2r2kj1rwJ7hwmhGh1v8X7mpwSGhbrcFm15Audhxcoko1cuXXLXvtCCzpkT7jTVTOQ7PsJywb8DPtRXEYIeKhZOzI1vKkp3zP1QInarNhr4sgrJtTF1fjfD2yEuYN07pVoLWTcU/3GKyIjMglykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=g2G2BVnp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa64f3c5a05so431825366b.3
        for <linux-nfs@vger.kernel.org>; Mon, 09 Dec 2024 09:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733764347; x=1734369147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaWyuI+1zfgRvLafZXYRvDDVpYcT2uiI1jU4yIWvFaI=;
        b=g2G2BVnp/ZCX9zQOKJVBL4UQ7g1WMuWzYTZ3VIC8OvHT/E8XJpCT2fzbglAUes1nAj
         3MuC2xtpwLl1IE1SzKEs+P+jK5vbpsfeVQSL+xso9TJ5mUAAUh8A6GKEp82jshbFLwVZ
         WC6vr3X/wcrBQU85U2ah/SE6z6UrXhh6Mas7LaEnpGJWvflQ6N9I8dK0pSSsXN2r7pBd
         0KvrPzgX0mAtbSmaNtL2YN4yUeeFfUFs6fRlFnPQhOeQ0JIS02nz2XbZuxvT3zq1J3RN
         aOUioIf+DuYgpW8J5WkSgg0foDmx4ZvClvILOLG3encu5W97MVTXHgRv/iLWif3J5yjB
         oYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764347; x=1734369147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaWyuI+1zfgRvLafZXYRvDDVpYcT2uiI1jU4yIWvFaI=;
        b=PstXjJQ77mp2XqvROI584+6jT26hMn7EpxauvoWX4t/uB538aNDRUNpBg1Plze3Kt2
         h7I0xpPKa8XI+s/4yxd40Y+uTnza12p9I3XFneMhxgxLfxXKxvd6KZGuNfd5Fxtc30zy
         KzzrManh1YkUuFviYeYGRPEMFk2TpdAtCT13wyCViI8DFMfBs4PWzMMa7PI+TFPfIUUz
         5xSxEbTDduH2Dw9QQ5Jit4DPWfXLY+v4oEVBAYt9/wBOcRSPH5CaQMJgTElqrrGWH6jQ
         egyw9dDYzeIUmWyWhXRuB5kGkFm9hIelx53wnSf0jvM+bMGYDbxAXlOpPlVgUpq30wWT
         dT3w==
X-Forwarded-Encrypted: i=1; AJvYcCUidgPa/MY7/wmi9hqI7Hc5667L16CVDVZgZ8McGJI9yu2u7A/KP0IBFFxAvsROb9ifHN1H7NY9lA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWnfj5fhecyZdthxaO+eoIf6El/pnLmrfYvro1n4dVcjauW3w
	T763lReL/pLpb1ipB73Hjp/G94u/80ILMJIIi1KqIeWy+bCEcjwKzgWBsWdLtYesJzZZ6pLBXBG
	xyWyBRTJfZ735YoPOGpyJUSsqQmcZjQU5RLKnN1X+tE0afjlgIJ7XDA==
X-Gm-Gg: ASbGncv5Sno4LKbBi8K/mHM9g0pJ2ydIJiSfuFXfPKeQECQ08NdqWa33XHEfLCanOIX
	+NTwKuO9NGHBy1TuqlA1s4hPfU9sErYBVIInC6ZF+Z+qaqSBDleGvrG4txdPA
X-Google-Smtp-Source: AGHT+IGjhgia80GwIq5GYW/J/My9MoNCTxyL/+qNp0qo2eVT8TVjbjcgPbng+OjrTZMWEUN4ktGPt5mr5dUK2s5wNHQ=
X-Received: by 2002:a17:906:c38b:b0:aa6:7b34:c1a8 with SMTP id
 a640c23a62f3a-aa69ce8deddmr107306866b.55.1733764346946; Mon, 09 Dec 2024
 09:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+986mTt1i9xGBXiQPVOmu4ZJTskrCt6f-99EL_s0rhz_A@mail.gmail.com>
 <2128544.1733755560@warthog.procyon.org.uk>
In-Reply-To: <2128544.1733755560@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 9 Dec 2024 18:12:15 +0100
Message-ID: <CAKPOu+8LSKtGmtjwRpY9tMnt=1Y7RvrhDxVsfSRQW02_g5-6XA@mail.gmail.com>
Subject: Re: [PATCH] nfs: Fix oops in nfs_netfs_init_request() when copying to cache
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Dave Wysochanski <dwysocha@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 3:46=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> Does this fix the issue?

The issue is with 6.11, but this patch fails to build with 6.11 and
I'm not sure how to backport that part:

 fs/nfs/fscache.c: In function =E2=80=98nfs_netfs_init_request=E2=80=99:
 fs/nfs/fscache.c:267:50: error: =E2=80=98NETFS_PGPRIV2_COPY_TO_CACHE=E2=80=
=99
undeclared (first use in this function); did you mean
=E2=80=98NETFS_RREQ_COPY_TO_CACHE=E2=80=99?
   267 |                 if (WARN_ON_ONCE(rreq->origin !=3D
NETFS_PGPRIV2_COPY_TO_CACHE))
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~

Our production machines are all 6.11, because 6.12 has that other
netfs regression that freezes all transfers immediately
(https://lore.kernel.org/netfs/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=3Dgcmkz=
wYSY4syqw@mail.gmail.com/).
I guess this other bug only affects Ceph and not NFS, but after
experiencing so many kernel regressions recently, I had to become more
cautious with kernel updates (the past 2 months had more
netfs/NFS/Ceph regression than the last 20 years combined).


>
> David
> ---
> nfs: Fix oops in nfs_netfs_init_request() when copying to cache
>
> When netfslib wants to copy some data that has just been read on behalf o=
f
> nfs, it creates a new write request and calls nfs_netfs_init_request() to
> initialise it, but with a NULL file pointer.  This causes
> nfs_file_open_context() to oops - however, we don't actually need the nfs
> context as we're only going to write to the cache.
>
> Fix this by just returning if we aren't given a file pointer and emit a
> warning if the request was for something other than copy-to-cache.
>
> Further, fix nfs_netfs_free_request() so that it doesn't try to free the
> context if the pointer is NULL.
>
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Reported-by: Max Kellermann <max.kellermann@ionos.com>
> Closes: https://lore.kernel.org/r/CAKPOu+986mTt1i9xGBXiQPVOmu4ZJTskrCt6f-=
99EL_s0rhz_A@mail.gmail.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Trond Myklebust <trondmy@kernel.org>
> cc: Anna Schumaker <anna@kernel.org>
> cc: Dave Wysochanski <dwysocha@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-nfs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/nfs/fscache.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index 810269ee0a50..d49e4ce27999 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -263,6 +263,12 @@ int nfs_netfs_readahead(struct readahead_control *ra=
ctl)
>  static atomic_t nfs_netfs_debug_id;
>  static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct =
file *file)
>  {
> +       if (!file) {
> +               if (WARN_ON_ONCE(rreq->origin !=3D NETFS_PGPRIV2_COPY_TO_=
CACHE))
> +                       return -EIO;
> +               return 0;
> +       }
> +
>         rreq->netfs_priv =3D get_nfs_open_context(nfs_file_open_context(f=
ile));
>         rreq->debug_id =3D atomic_inc_return(&nfs_netfs_debug_id);
>         /* [DEPRECATED] Use PG_private_2 to mark folio being written to t=
he cache. */
> @@ -274,7 +280,8 @@ static int nfs_netfs_init_request(struct netfs_io_req=
uest *rreq, struct file *fi
>
>  static void nfs_netfs_free_request(struct netfs_io_request *rreq)
>  {
> -       put_nfs_open_context(rreq->netfs_priv);
> +       if (rreq->netfs_priv)
> +               put_nfs_open_context(rreq->netfs_priv);
>  }
>
>  static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequ=
est *sreq)
>

