Return-Path: <linux-nfs+bounces-2215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C25487261C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 19:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776F01C260A3
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D1C17BAF;
	Tue,  5 Mar 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4AOMcJy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A017BBF
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661680; cv=none; b=jHX+4tGEimxu8jw3S8KQk3r6ruGRMO9gneOKw774Ogl4d2sXWIdNpOs8Xs5NdknuRSdQ4vmFYGj0p9nizGPUI9oHvuNNSFrzZClYE4HEqY0eVj901sbSh/36VevHVwFDjAuj4bRF4Gz6Zkejf4wVX7Zf5GmdbiXTQPtVQ2Mk4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661680; c=relaxed/simple;
	bh=BCPGLY2vD81oeI9Jp10XfpsnadDiwtz2X/xmj722vK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh34JQiXGmw0Z7Lx5vkRIwrDlhVDP5fTcOvMuQ6r8qAulAUA7eRLes5n3Oc7+WjqE6EtDXsLZMnwurI8poopbVIWx72mXgPIdpCJZ5zkkzhxBA7Z8ND86dcAcL1kTf/YNV+RCrpH8WC0ngxz5BchkgNaSaiw1heTlY7DiwbaDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4AOMcJy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709661677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QszKrPCksIK7Syt87ZfXlHMg04Po96JGvrbL2pmbC8A=;
	b=N4AOMcJyueM79Jb1R/5stQsBESkS/1YpDaP/z6ZuUT6x/tAy+lrO+JB3CCjhyrrgPRrWC9
	yZSFxBxlGNNLRrKMAUkG0sggdJlFa4PxsogyCn0GuodUsiRdZukRK6ap8+wG5KOfI319ZU
	tyBk+BcMhkUxcE86r2mQ3i3ylB247Yo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-wMjplEGTPRyCB6tcPppvBA-1; Tue, 05 Mar 2024 13:01:16 -0500
X-MC-Unique: wMjplEGTPRyCB6tcPppvBA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d5a080baf1so4926607a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Mar 2024 10:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661675; x=1710266475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QszKrPCksIK7Syt87ZfXlHMg04Po96JGvrbL2pmbC8A=;
        b=Lm7hgNMuKuON5GsMOXSNjJaSY4oPkAHfC8+YlqpogK6lM3VT5ZZTlkElF9wmnCIciZ
         WB86zjUcb3dsEnK/p89J3b9x3HB6A2CkRe6FKnV4EL5aLPNTMGKKz/FpwopwAKtmqrBE
         jSAqTsOK8Z6FGWzQpc8qRkXRxp5L8V55PJKGwUV2qoGjbWApK6eAeZzCWhWOpxwhd4tw
         MTXyyThvprku3DvyJuLRhfYjCuUp5UtD4WLWLNb3ZZiIBhq4mnrG0JX74e0+69YVy+tb
         kSkUXYr7itF16EhYaBaOO+Bs2s3ZjgEsPK7MSXLbb+t2gwOtOzei61QnaXxCJf0ifwKZ
         DjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZdokd28kZCSitB30O0K06oelMLv7ZRpy6qckNCRg8vKf8S3MwyKbnrQimJV0MCG3USpxCr0lJu0Ml5t4VnR3k6IG7AZgn/907
X-Gm-Message-State: AOJu0YzIhFZdILiWsLpnIJoGvzrHK6/Zy53KUce/65+e+sPcntLmZSE7
	u2d8csnIFLOWXFMmj3Rmes3K/b5ogFG/xKowtOjzTDfBSiXiIU3U4r0JbO0BlI+rZ362lAzUIXm
	MIM3Svygh+PG59nyHQxW8PjRnILNK7edTOQASxFg/B9z5mglmkcYT4lOKvReE+d73K6W5MLtI16
	OHHlBD/Oq3Z8haOOR/h4P//BPaqBt1y7f4
X-Received: by 2002:a17:90a:d489:b0:29b:2b85:c2dd with SMTP id s9-20020a17090ad48900b0029b2b85c2ddmr8864179pju.42.1709661674035;
        Tue, 05 Mar 2024 10:01:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb70EAYk1nlhs/DM1XipS3Z64aYLVlpPESKEtYo6n6wT0ybcQR2wSuSlelVL7Axgrkl+La+YHYhVjuPH4q8qw=
X-Received: by 2002:a17:90a:d489:b0:29b:2b85:c2dd with SMTP id
 s9-20020a17090ad48900b0029b2b85c2ddmr8864159pju.42.1709661673744; Tue, 05 Mar
 2024 10:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <810bc21335858754c1a3fbee0a3c94de001f4c3f.1709659767.git.bcodding@redhat.com>
In-Reply-To: <810bc21335858754c1a3fbee0a3c94de001f4c3f.1709659767.git.bcodding@redhat.com>
From: David Wysochanski <dwysocha@redhat.com>
Date: Tue, 5 Mar 2024 13:00:37 -0500
Message-ID: <CALF+zOn50xfKDBxqG1JfWVcRa+PvMvMpcWYfJmt0FWoUe0mW5w@mail.gmail.com>
Subject: Re: [PATCH] NFS: Read unlock folio on nfs_page_create_from_folio() error
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trond.myklebust@primarydata.com>, 
	Anna Schumaker <anna.schumaker@netapp.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:30=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> The netfs conversion lost a folio_unlock() for the case where
> nfs_page_create_from_folio() returns an error (usually -ENOMEM).  Restore
> it.
>
> Reported-by: David Jeffery <djeffery@redhat.com>
> Cc: <stable@vger.kernel.org> # 6.4+
> Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when =
fscache is enabled")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/read.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index 7dc21a48e3e7..a142287d86f6 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -305,6 +305,8 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *=
pgio,
>         new =3D nfs_page_create_from_folio(ctx, folio, 0, aligned_len);
>         if (IS_ERR(new)) {
>                 error =3D PTR_ERR(new);
> +               if (nfs_netfs_folio_unlock(folio))
> +                       folio_unlock(folio);
>                 goto out;
>         }
>
> --
> 2.43.0
>


Acked-by: Dave Wysochanski <dwysocha@redhat.com>


