Return-Path: <linux-nfs+bounces-1858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4884E2F7
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB829052C
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA7E78696;
	Thu,  8 Feb 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cpIHrnvw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086476908
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401823; cv=none; b=sg+NGzx1aSnLmsDPSxfBF7y78i+fTGpQx2EcUCOmk+HWsAZiUWuEi6hf36VsspetgFf+LHwr/lACctFc1DFY6eirdhPdG3nRjBwvw8UG73sjziQe8i94n+/EVGXOuKT1gjgtWYMxyEwEJxDRFyVKRGpi+pU9rXBj2YpiMfPXQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401823; c=relaxed/simple;
	bh=ujj/RLFDfuqS7PIZP68+3l/KZkd1KHttxlgRuGySCOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPyEUhMrnMaU/PzhU6zxxx2CCRt2xYdUTnvXfjcCbhcqhO6iYdofknFotR/olgs0rPKQl/5vUSW9ONOtcwudoqfKPaj1w6TPRRo4So+HlVSPWc3whXcUleGSUD2M4tlKS5oYqWY3hEad0O5xdsxWaAAHJ67n/JzgoTy7YppfdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cpIHrnvw; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d8f31930so790238276.0
        for <linux-nfs@vger.kernel.org>; Thu, 08 Feb 2024 06:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707401819; x=1708006619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rHe4xV1s4X4NVlAmyq1Fqck0kWWWvVIv4qB+Ky5Oo4=;
        b=cpIHrnvwduqrSfAbUDvwcTPVwb8rM5uk1zLq3xwzi1+jkLLXKNesv/zHRV50VOFZaB
         mjlVz2xq0Xc8wRbbScpCr3Wh5pqRY9CZuD3kTn2yTGmzl+o8rE0z/xm05jjVGkOWGawM
         Xxxv8E2Gc9w3bLvEcWitgQLLWHaZUaDvduZSg9GuLo7L3cKhJ5uJxf6emmisiriIiips
         pdVU8EKnp07svFd9da5oSFwwvxUFKN4N4Lb4ISOGhVuRuy+FWj1WfqwXv6Nb3t+CYuAw
         QNYIU7wJoFpclTxaQAF4DVT9S3X15ml/BEDGJMv/ATW8HrjwHnYfPjXqKrRyICCe0GOf
         InRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401819; x=1708006619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rHe4xV1s4X4NVlAmyq1Fqck0kWWWvVIv4qB+Ky5Oo4=;
        b=bvCDQGx7VNu90bbFHeseud03NfpwYvu6ugZxfvkOXtf7j3yi8GkErm3TkBRqzwaiLX
         vjJwhxoKU5LhFdr5pVVMJyVm/9PBeyGAhDp2LthpuAYTp5c/LzS9rpAPQka7NDaLKUbC
         42JK2mOFNfFKqG44iCdB6qoPf+/wgBeLFrYrThDf4oFtOhCzh3iVJLnkh9a/ZgS3xPir
         yXI4g2agje8Ecdj8YqpGsZSF48vTkS5SLJS5pa7IxYLHc/FOEPZgGkUd5ScfLfV7ZZVB
         0xogUs2DwyK3OblSkJQ39EM3IA8xxw5fs77NkhjMaFNxQHLmsCPJj9eYvGoplaBTttVb
         gYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2d8wZwdxPygMZa6JnzXncq34Esb8DJ/areYFKIifK0w/CBuQQb3H2NHMpNLj2NIKfqZWW6eY6qQf+akgGWPt+OzQOB/QQBSZR
X-Gm-Message-State: AOJu0Yw2pLGOzuMD39ZM/JbL8XqK7xLQHNSKwy1loNmInSv+nMnuXoxd
	JK+G82o6IkAME34i2z8SpZ9MwahvS9pLkUmiERrqQPOfv6/bANkYBnnxryeAwT+IECN0K4Scr9j
	9MxO7Lw5Dd/XGJPDdObaR09tRkf5i330Dqf+K
X-Google-Smtp-Source: AGHT+IF4KdKYv/i3KNL4LQkNiYFcff3UiechbnntE/n8lsxGtDCyAecpPgauuzlLRFB/79dZx13Kgoa30gmOFF58owY=
X-Received: by 2002:a25:7483:0:b0:dc6:c2ec:ff4c with SMTP id
 p125-20020a257483000000b00dc6c2ecff4cmr1925355ybc.6.1707401819151; Thu, 08
 Feb 2024 06:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <d54ca249c3071522218c7ba7b4984bab@paul-moore.com> <dd8a979df500489c0d8595f9a3f89c801ce6f1c2.camel@huaweicloud.com>
In-Reply-To: <dd8a979df500489c0d8595f9a3f89c801ce6f1c2.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Feb 2024 09:16:48 -0500
Message-ID: <CAHC9VhRu-_v19zWS0Pm0-4E-PWONcfR1-=Ekz9ObuOAgL0Y+sA@mail.gmail.com>
Subject: Re: [PATCH v9 0/25] security: Move IMA and EVM to the LSM infrastructure
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, 
	jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:06=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2024-02-07 at 22:18 -0500, Paul Moore wrote:

...

> > I had some pretty minor comments but I think the only thing I saw that
> > I think needs a change/addition is a comment in the Makefile regarding
> > the IMA/EVM ordering; take a look and let me know what you think.
>
> Oh, I remember well, it is there but difficult to spot...
>
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -18,5 +18,6 @@ integrity-$(CONFIG_LOAD_IPL_KEYS) +=3D platform_certs/l=
oad_ipl_s390.o
>  integrity-$(CONFIG_LOAD_PPC_KEYS) +=3D platform_certs/efi_parser.o \
>                                       platform_certs/load_powerpc.o \
>                                       platform_certs/keyring_handler.o
> +# The relative order of the 'ima' and 'evm' LSMs depends on the order be=
low.
>  obj-$(CONFIG_IMA)                      +=3D ima/
>  obj-$(CONFIG_EVM)                      +=3D evm/

Great, thanks for that.  Not sure how I missed that ... ?

> > Once you add a Makefile commane and we sort out the IMA/EVM approval
> > process I think we're good to get this into linux-next.  A while back
> > Mimi and I had a chat offline and if I recall everything correctly she
> > preferred that I take this patchset via the LSM tree.  I don't have a
> > problem with that, and to be honest I would probably prefer
> > that too, but I wanted to check with everyone that is still the case.
> > Just in case, I've added my ACKs/reviews to this patchset in case this
> > needs to be merged via the integrity tree.
>
> Ok, given that there is the comment in the Makefile, the last thing to
> do from your side is to remove the vague comment in the file_release
> patch.
>
> Other than that, I think Mimi wanted to give a last look. If that is
> ok, then the patches should be ready for your repo and linux-next.

If Mimi is okay with the patchset as-is, and both of you would prefer
this to in via the LSM tree, don't worry about the file_release
comment, I'll just remove that when merging.

--=20
paul-moore.com

