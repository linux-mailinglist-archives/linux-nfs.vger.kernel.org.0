Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15A01006F1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 15:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKROCn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Nov 2019 09:02:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29778 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726627AbfKROCm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Nov 2019 09:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574085761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFDTNzSmncWoiXrtDV5MkFPjzmN8qwHSjYQsF6etTkk=;
        b=PMqvkPOaJt8mnKx+3SDil9hGHJevEUNyNy4GYx9VvYUiwi+pmkc2knpMiv0AEvLKwrgnC1
        u1hycd1u2s1uYN1fy09itTnyi5bWT1IeVUZhvadjerDsl9pdZ7RW2jLJcwRhr1FYKYtSm3
        9gnf9mrToDDgxib2l1XB4tteJn/TXKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-s6lhjt34Nn-RWzeq7p9UhA-1; Mon, 18 Nov 2019 09:02:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83F8A1883546;
        Mon, 18 Nov 2019 14:02:36 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-206.phx2.redhat.com [10.3.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10F6961071;
        Mon, 18 Nov 2019 14:02:35 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 1/1] mountd: Add check for 'struct file_handle'
To:     Petr Vorel <petr.vorel@gmail.com>, linux-nfs@vger.kernel.org
Cc:     Maxime Hadjinlian <maxime.hadjinlian@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20191117221506.32084-1-petr.vorel@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <61828832-a5ef-7aaf-07ac-e9bbf279e104@RedHat.com>
Date:   Mon, 18 Nov 2019 09:02:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191117221506.32084-1-petr.vorel@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: s6lhjt34Nn-RWzeq7p9UhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/17/19 5:15 PM, Petr Vorel wrote:
> From: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
>=20
> The code to check if name_to_handle_at() is implemented generates only a
> warning but with some toolchain it doesn't fail to link (the function mus=
t be
> implemented somewhere).
> However the "struct file_handle" type is not available.
>=20
> So, this patch adds a check for this struct.
>=20
> Patch taken from buildroot distribution.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> [ pvorel: rebased from nfs-utils-1-3-4 ]
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
Committed... (tag: nfs-utils-2-4-3-rc1)

steved.
> ---
>  configure.ac         | 1 +
>  utils/mountd/cache.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 9ba9d4b5..949ff9fc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -510,6 +510,7 @@ AC_TYPE_PID_T
>  AC_TYPE_SIZE_T
>  AC_HEADER_TIME
>  AC_STRUCT_TM
> +AC_CHECK_TYPES([struct file_handle])
> =20
>  dnl *************************************************************
>  dnl Check for functions
> diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
> index 3861f84a..31e9507d 100644
> --- a/utils/mountd/cache.c
> +++ b/utils/mountd/cache.c
> @@ -446,7 +446,7 @@ static int same_path(char *child, char *parent, int l=
en)
>  =09if (count_slashes(p) !=3D count_slashes(parent))
>  =09=09return 0;
> =20
> -#if HAVE_NAME_TO_HANDLE_AT
> +#if defined(HAVE_NAME_TO_HANDLE_AT) && defined(HAVE_STRUCT_FILE_HANDLE)
>  =09struct {
>  =09=09struct file_handle fh;
>  =09=09unsigned char handle[128];
>=20

