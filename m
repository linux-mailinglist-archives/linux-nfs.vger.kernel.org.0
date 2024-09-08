Return-Path: <linux-nfs+bounces-6327-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A09708CF
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686921F2123D
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Sep 2024 16:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2024436E;
	Sun,  8 Sep 2024 16:49:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB238DD6;
	Sun,  8 Sep 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725814144; cv=none; b=ExsV0MpHQV5Cdn0wRXfIgxrvZD6NoAFccJSanDDhLl7KceG2Hm9h0b3Y6wEMrvYC5ol+i6cFbvPFzdV4wWJtFmpw02BfIq8kA9vepR8ZjmuLyh4c/kish8o32UlDM+luNe0PqaWECNmcP4UKoVs9TeqNm4KgFOSGnxOgZZspRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725814144; c=relaxed/simple;
	bh=pPyJ3kUirQYn4+JQ29MFE+X/XJy2rwfruUuUdLtdQvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SNRFiTxIa/WL3EOihrd9qeyqeznhuEmzBQLZOTt9gTh5kTQtabON+6eDwjbx7c7gIvGVXDTeBytxXtc2Qbn3mihcwgPYndxFFJP+8NlA8nWdu+QhdJEDRmrL8CNjLmjJCv6fArDxslkYtGU3t55il47Wh15f/LxZLCjvaKO2wrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39fd6a9acb6so13217105ab.0;
        Sun, 08 Sep 2024 09:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725814142; x=1726418942;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSdhcuMTGOIHru22hOTpdD1/wkvsf2zXlA9z1zicQdY=;
        b=o2DkUjFh6vvHeFr5AsZ9njqWBLvOgM8gfWthmBdAsIjmHhpHE22EYk1JQGaX8T/onI
         vTPQut6K1uyJLPwGU6+xKNaUtBIjIgL2QtGDDw7RLBLmDvTOY4IO5HlDErosAwabaTCK
         SkQwllEMPQAPMdbIJYuzKgUAWhE/2u5T2FrGoi5VVu5OAMAgwOkC/vzjL8cKc4ChDNMh
         XiwB1fG5YIQRktfSPwbufoSxh14kW0Fbv3K0TOel+ZHe4r48rf2q+6zZfMAqVAa9DsGK
         v99fB54bdti9bWod+aAgqzrK9rBl8lPIgDz+K0PryCCKP0NrzNsYRflmMhj59ic8hGfh
         rDoA==
X-Forwarded-Encrypted: i=1; AJvYcCVMqu8TL8JUJLcibDRCqUx2KMEdoL2pNwLKsmOQxYbJl6wAc73gPnGWOv6lMoZt9+5p5BuPEbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzftCQROWwLQyBnuw70XyidQBjX06JCtgIGW9fQsWvJIV+XGRly
	QVMi8/MZWILwHv1gNfqHYJspAOgiOfzHMYGoaASHcvBx+SMnu0ATftVq
X-Google-Smtp-Source: AGHT+IFBh1TN9+2EYqwL6fhAVrBfDwQtaKapAwsg/HjpQ6QnQve+1WgZb7FQkCgDkITAj97KtPFS3Q==
X-Received: by 2002:a05:6e02:180c:b0:36c:4688:85aa with SMTP id e9e14a558f8ab-3a04f079317mr109262395ab.10.1725814142243;
        Sun, 08 Sep 2024 09:49:02 -0700 (PDT)
Received: from [192.168.75.138] (104-63-89-173.lightspeed.livnmi.sbcglobal.net. [104.63.89.173])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fc7ed1sm9205155ab.2.2024.09.08.09.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:49:01 -0700 (PDT)
Message-ID: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
Subject: Re: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
From: Trond Myklebust <trondmy@kernel.org>
To: Oleksandr Tymoshenko <ovt@google.com>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, jbongio@google.com, stable@vger.kernel.org
Date: Sun, 08 Sep 2024 12:48:30 -0400
In-Reply-To: <20240906-nfs-mount-deadlock-fix-v1-1-ea1aef533f9c@google.com>
References: <20240906-nfs-mount-deadlock-fix-v1-1-ea1aef533f9c@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-06 at 00:57 +0000, Oleksandr Tymoshenko wrote:
> nfs41_init_clientid does not signal a failure condition from
> nfs4_proc_exchange_id and nfs4_proc_create_session to a client which
> may
> lead to mount syscall indefinitely blocked in the following stack
> trace:
> =C2=A0 nfs_wait_client_init_complete
> =C2=A0 nfs41_discover_server_trunking
> =C2=A0 nfs4_discover_server_trunking
> =C2=A0 nfs4_init_client
> =C2=A0 nfs4_set_client
> =C2=A0 nfs4_create_server
> =C2=A0 nfs4_try_get_tree
> =C2=A0 vfs_get_tree
> =C2=A0 do_new_mount
> =C2=A0 __se_sys_mount
>=20
> and the client stuck in uninitialized state.
>=20
> In addition to this all subsequent mount calls would also get blocked
> in
> nfs_match_client waiting for the uninitialized client to finish
> initialization:
> =C2=A0 nfs_wait_client_init_complete
> =C2=A0 nfs_match_client
> =C2=A0 nfs_get_client
> =C2=A0 nfs4_set_client
> =C2=A0 nfs4_create_server
> =C2=A0 nfs4_try_get_tree
> =C2=A0 vfs_get_tree
> =C2=A0 do_new_mount
> =C2=A0 __se_sys_mount
>=20
> To avoid this situation propagate error condition to the mount thread
> and let mount syscall fail properly.
>=20
> Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
> ---
> =C2=A0fs/nfs/nfs4state.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 877f682b45f2..54ad3440ad2b 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -335,8 +335,8 @@ int nfs41_init_clientid(struct nfs_client *clp,
> const struct cred *cred)
> =C2=A0	if (!(clp->cl_exchange_flags & EXCHGID4_FLAG_CONFIRMED_R))
> =C2=A0		nfs4_state_start_reclaim_reboot(clp);
> =C2=A0	nfs41_finish_session_reset(clp);
> -	nfs_mark_client_ready(clp, NFS_CS_READY);
> =C2=A0out:
> +	nfs_mark_client_ready(clp, status =3D=3D 0 ? NFS_CS_READY :
> status);
> =C2=A0	return status;
> =C2=A0}

NACK. This will break all sorts of recovery scenarios, because it
doesn't distinguish between an initial 'mount' and a server reboot
recovery situation.
Even in the case where we are in the initial mount, it also doesn't
distinguish between transient errors such as NFS4ERR_DELAY or reboot
errors such as NFS4ERR_STALE_CLIENTID, etc.

Exactly what is the scenario that is causing your hang? Let's try to
address that with a more targeted fix.


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



