Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2213FAD9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 21:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgAPUtN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 15:49:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726994AbgAPUtN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 15:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579207752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lARv75RCTJ28w/w1Jd5Yp1uBn+NgkbZ8rS3L5EbFH1Q=;
        b=a9q+R2kAssVgumT5G3dFw4H9zjgaA5AClJLqUlybTtLJ1plnfbbfb2JTnEGZUQM33duFgm
        gdzcoXksHSa0XzpM7qjuH7X0MJefI9gqxCLTSiPhUPtNa68snqil4VTEZceMReFhefXuaF
        2JynyYj2OnEPEY+bXybPoLcvZRXAFYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-55ir7a7ZNB2eYOdWoafrTg-1; Thu, 16 Jan 2020 15:49:10 -0500
X-MC-Unique: 55ir7a7ZNB2eYOdWoafrTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE1C28017CC;
        Thu, 16 Jan 2020 20:49:08 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-35.phx2.redhat.com [10.3.117.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79C0210013A1;
        Thu, 16 Jan 2020 20:49:08 +0000 (UTC)
Subject: Re: [PATCH] mountd: Remove outdated/misleading comment
To:     =?UTF-8?Q?Christian_Bartolom=c3=a4us?= <use_v6@aglaz.de>,
        linux-nfs@vger.kernel.org
References: <20200107211914.GE4452@cus>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c3735526-a8c6-585a-ef28-7e2122f7c406@RedHat.com>
Date:   Thu, 16 Jan 2020 15:49:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107211914.GE4452@cus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/7/20 4:19 PM, Christian Bartolom=C3=A4us wrote:
> It became wrong when commit 78240c41be17bd20d5fb5b70b6f470d8e779adee
> ("mountd: fix mount issue due to comparison with uninitialized uuid") w=
as
> applied back in 2015. The final case of the switch statement no longer =
ends
> with a 'return true' and the final 'return false' is relevant now.
>=20
> Signed-off-by: Christian Bartolom=C3=A4us <use_v6@aglaz.de>
Committed... (tag: nfs-utils-2-4-3-rc5)

steved.

> ---
>  utils/mountd/cache.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
> index e5186c7..8f54e37 100644
> --- a/utils/mountd/cache.c
> +++ b/utils/mountd/cache.c
> @@ -672,7 +672,6 @@ static bool match_fsid(struct parsed_fsid *parsed, =
nfs_export *exp, char *path)
>  				if (memcmp(u, parsed->fhuuid, parsed->uuidlen) =3D=3D 0)
>  					return true;
>  	}
> -	/* Well, unreachable, actually: */
>  	return false;
>  }
>=20

