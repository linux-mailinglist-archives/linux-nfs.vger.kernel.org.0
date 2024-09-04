Return-Path: <linux-nfs+bounces-6188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA6C96C0E8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 16:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6981C226F5
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C591DA2F1;
	Wed,  4 Sep 2024 14:39:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C9929402;
	Wed,  4 Sep 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460759; cv=none; b=A7m0lSKhwvsRSwcqcARG4qbg12HHj2SjAiedmHFVqVodxFfjj5ReCPSqbhqGuPoCeGSZnpY1NUD5lC9vfs6oYpQxQwkDWw1iykl4GB9LdOasUa2gR+bZNRdL3EBLqz7F8owuviNDbYgCvJJAhdCmk9wIUYeWdo88ECTDJBg48hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460759; c=relaxed/simple;
	bh=5quALXjRZwLUm7dAnwuV4FUF2d6AtY1LbRXAskSXcPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umGeN9zHR6pcUAgX2gnCReNYNEDiWdwzmVpqHZQsSazV9sPmsKGQ7RybNV0B1xGike1spYhV7iwPSVSoxZO9jnvgPJvg73G/pNUrTLXccWfMDu1O2Cp0sVHk9PHSoGfFXNNa4s3VUDznmE21JnIXaE3CCckKKNk5ScPqyXuoqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a24dec9cbso29475839f.1;
        Wed, 04 Sep 2024 07:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460757; x=1726065557;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kvnOjXzU3FwJLWDXcoK40WNU+7mM5+pyM0Rfyz7Dho=;
        b=Zu8T3+vXfIjRtSMHWLbJy1lwZQmPq0lE9eonku71nLZAhFNp+Vl842XidKjgF9SDut
         QJFG5dBRAFXxyrpVKlf8F4HsM0L67JlTpwrrfFFEnWiAuiF/yAIx2XNKqD0EPjcrdA4T
         kUkw6VyRxASkKKasoZAHe7XDHoS4ffMwdquwk+zooOr/lpEoVlwkOBP5C533xoQSHvTv
         JbgYYquCNGvv96YS1VVcJACnCf4J+BltbhTZuf7dsUlHUA7I+auB+nAh2BRnBkzsg9vj
         Qye9qtv2itOZrqUIn3ewnf1L6Oo1X3pEYsSnMFMunxKnY4pYPU5Z4BlRMFeFAe37XOz+
         A+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6qzuCg4zMzCrUwIOycBQWW+kZLbYNiuXzuVa4EBNsl5D8kFu0qHYDzs52GsKWTlEavxebUPq/DZA/Mg=@vger.kernel.org, AJvYcCXOv2n02N4iGy6lzkZ1lBahgRqaNMCpn3O1wKWmIRpLM+IT5yUWt1lH3wsY0hWwg7GxFlnfbkBrDGYm@vger.kernel.org
X-Gm-Message-State: AOJu0YzjS7CMSrEEpiZPPCs4cKeriaTEYVArFAj7YiFfUupuVAXCMz0T
	x599dBe2qlof1jXmUKcPZjm60hI/EGM59AW2FtmCnZGydKjVg6Q=
X-Google-Smtp-Source: AGHT+IHs+kGc3Dt1q5uA8HC/zLD62drs9vIUHQQGPiLmP2kH7XWDuEOvltWaU6zXKTgCQg8hAEy9mQ==
X-Received: by 2002:a05:6e02:1a65:b0:39f:558f:dd8b with SMTP id e9e14a558f8ab-39f797bd912mr17901175ab.12.1725460757099;
        Wed, 04 Sep 2024 07:39:17 -0700 (PDT)
Received: from [192.168.75.138] ([204.8.116.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e9632dsm3139181173.93.2024.09.04.07.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:39:16 -0700 (PDT)
Message-ID: <8ee4ce7c4eb56ec80365492407b76ee3dc4b6347.camel@kernel.org>
Subject: Re: [PATCH] nfs: fix memory leak in error path of nfs4_do_reclaim
From: Trond Myklebust <trondmy@kernel.org>
To: Li Lingfeng <lilingfeng3@huawei.com>, anna@kernel.org
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org,  yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com,  yangerkun@huawei.com, lilingfeng@huaweicloud.com
Date: Wed, 04 Sep 2024 10:38:45 -0400
In-Reply-To: <20240904123457.3027627-1-lilingfeng3@huawei.com>
References: <20240904123457.3027627-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 20:34 +0800, Li Lingfeng wrote:
> Commit c77e22834ae9 ("NFSv4: Fix a potential sleep while atomic in
> nfs4_do_reclaim()") separate out the freeing of the state owners from
> nfs4_purge_state_owners() and finish it outside the rcu lock.
> However, the error path is omitted. As a result, the state owners in
> "freeme" will not be released.
> Fix it by adding freeing in the error path.
>=20
> Fixes: c77e22834ae9 ("NFSv4: Fix a potential sleep while atomic in
> nfs4_do_reclaim()")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
> =C2=A0fs/nfs/nfs4state.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 877f682b45f2..30aba1dedaba 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1957,6 +1957,7 @@ static int nfs4_do_reclaim(struct nfs_client
> *clp, const struct nfs4_state_recov
> =C2=A0				set_bit(ops->owner_flag_bit, &sp-
> >so_flags);
> =C2=A0				nfs4_put_state_owner(sp);
> =C2=A0				status =3D
> nfs4_recovery_handle_error(clp, status);
> +				nfs4_free_state_owners(&freeme);
> =C2=A0				return (status !=3D 0) ? status : -
> EAGAIN;
> =C2=A0			}
> =C2=A0

Nice catch! Yes, that leak has been there for quite a while. Thanks for
finding it.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



