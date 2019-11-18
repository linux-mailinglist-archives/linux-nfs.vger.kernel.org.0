Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEDE10093B
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKRQaU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Nov 2019 11:30:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22912 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbfKRQaU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Nov 2019 11:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574094618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ps1J0Sgaa5h5lKe4Nq+npt7r0300+nye0TqjQf92wI=;
        b=i+NbxQnkVQOeXjdVWoSPaErbOyz+ATT8qGJuuDrKoi/qQsVZnkJQ0J3ec8NkITWUDusJ4U
        drGq0NZsP/fDddquWQFcdkT5GT3YbdsbHi8hx/5QEceF7p5pEIP8vhxIcsrAcxOuzxwUqJ
        okpbL3LZhBDjQcarv5SeZubSm1V2GmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Hk647fCrOM-DM3i1sTX8Pg-1; Mon, 18 Nov 2019 11:30:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1485A8F990B;
        Mon, 18 Nov 2019 16:30:15 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-206.phx2.redhat.com [10.3.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9BFF100EBC4;
        Mon, 18 Nov 2019 16:30:14 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 1/1] mountd: Fix compilation for --disable-uuid
To:     Petr Vorel <petr.vorel@gmail.com>, linux-nfs@vger.kernel.org
References: <20191118143147.26015-1-petr.vorel@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <73a7f1f5-4a02-4711-7826-6d82d08ac96b@RedHat.com>
Date:   Mon, 18 Nov 2019 11:30:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191118143147.26015-1-petr.vorel@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Hk647fCrOM-DM3i1sTX8Pg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/18/19 9:31 AM, Petr Vorel wrote:
> Although code in configure.ac pretends to set USE_BLKID as 0
> via AC_DEFINE_UNQUOTED, it's actually not defined
> support/include/config.h.in
> support/include/config.h
> /* #undef USE_BLKID */
>=20
> Fixes: 8e643554 ("Allow disabling of libblkid usage.")
>=20
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Committed! Thanks!!  (tag: nfs-utils-2-4-3-rc1)

steved.
> ---
>  utils/mountd/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
> index 31e9507d..e5186c78 100644
> --- a/utils/mountd/cache.c
> +++ b/utils/mountd/cache.c
> @@ -221,7 +221,7 @@ static void auth_unix_gid(int f)
>  =09=09xlog(L_ERROR, "auth_unix_gid: error writing reply");
>  }
> =20
> -#if USE_BLKID
> +#ifdef USE_BLKID
>  static const char *get_uuid_blkdev(char *path)
>  {
>  =09/* We set *safe if we know that we need the
>=20

