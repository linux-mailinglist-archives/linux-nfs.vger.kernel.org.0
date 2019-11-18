Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1837B1006F3
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 15:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfKRODS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Nov 2019 09:03:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726909AbfKRODS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Nov 2019 09:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574085797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCLGnRGUsijBGJHvbvOvHUl/3nma4D0wGBdByjG13AQ=;
        b=Oe2Au79DBrHiv4RusH0ODG/tCl5lxnFsy4AP39un+WXm1BI0R/VZZhDmChyEGhJ74oMFVM
        r6pqQpskcSkSjll9vvev9uvaFVTnlapFedz446ghSidH4NF0k3+8R/dxX/4zGSUp1h1WZV
        1FwIuMSYuIbWElbXYl7F+DWv5quFa8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-9RIFpQdCPQaoiUaAN-gZRA-1; Mon, 18 Nov 2019 09:03:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 210D5189D942;
        Mon, 18 Nov 2019 14:03:13 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-206.phx2.redhat.com [10.3.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB8F31ED;
        Mon, 18 Nov 2019 14:03:12 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 1/1] autoconf: Add Debian paths for Kerberos v5
 with GSS
To:     Petr Vorel <petr.vorel@gmail.com>, linux-nfs@vger.kernel.org
References: <20191117183033.11382-1-petr.vorel@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <6c5dedaa-f932-798b-69e0-1d1c09605644@RedHat.com>
Date:   Mon, 18 Nov 2019 09:03:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191117183033.11382-1-petr.vorel@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 9RIFpQdCPQaoiUaAN-gZRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/17/19 1:30 PM, Petr Vorel wrote:
> Debian stores it's shared libraries in
> /usr/lib/$(uname -m)-linux-gnu
>=20
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  aclocal/kerberos5.m4 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
Committed.... (tag: nfs-utils-2-4-3-rc1)

steved.
>=20
> diff --git a/aclocal/kerberos5.m4 b/aclocal/kerberos5.m4
> index faa58049..bf0e88bc 100644
> --- a/aclocal/kerberos5.m4
> +++ b/aclocal/kerberos5.m4
> @@ -42,7 +42,9 @@ AC_DEFUN([AC_KERBEROS_V5],[
>                     -f $dir/lib32/libgssapi_krb5.a -o \
>                     -f $dir/lib32/libgssapi_krb5.so -o \
>                     -f $dir/lib64/libgssapi_krb5.a -o \
> -                   -f $dir/lib64/libgssapi_krb5.so \) ; then
> +                   -f $dir/lib64/libgssapi_krb5.so -o \
> +                   -f $dir/lib/$(uname -m)-linux-gnu/libgssapi_krb5.a -o=
 \
> +                   -f $dir/lib/$(uname -m)-linux-gnu/libgssapi_krb5.so \=
) ; then
>           AC_DEFINE(HAVE_KRB5, 1, [Define this if you have MIT Kerberos l=
ibraries])
>           KRBDIR=3D"$dir"
>           gssapi_lib=3Dgssapi_krb5
>=20

