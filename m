Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0730DE3A98
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2019 20:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503984AbfJXSF0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Oct 2019 14:05:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46810 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503978AbfJXSF0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Oct 2019 14:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571940325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2s2+OTlmIW/d1PsS5EQsCEFOkdJELm8wiSwgPfUQ5M=;
        b=DaZjsFa6uQWuLhsEM1oJ2tOmYTmy92I6L2WxaPVnhok2Cf+WrLIA0cg3Cc1KkIY5GogMQ5
        PK42wzjbtm6UcKbVhVFRckJv2caYjFiZUziEEgSWpfh5SsDRfh6BllWhdrOTIiuJoa7+NR
        4s5Vu7dXhPNfkHrJdtoJHbTizIunU4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-ppsrEca3PQefowPjkadn0Q-1; Thu, 24 Oct 2019 14:05:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB882107AD31
        for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2019 18:05:22 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-118-15.phx2.redhat.com [10.3.118.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FB9560BE3;
        Thu, 24 Oct 2019 18:05:22 +0000 (UTC)
Subject: Re: [nfs-utils PATCH v3] gssd: daemonize earlier
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20191017150844.21045-1-smayhew@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <3d4df712-d1e9-e46c-26a2-8ed75e681dc0@RedHat.com>
Date:   Thu, 24 Oct 2019 14:05:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017150844.21045-1-smayhew@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ppsrEca3PQefowPjkadn0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/17/19 11:08 AM, Scott Mayhew wrote:
> daemon_init() calls closeall() which closes all fd's >=3D 4.  This causes
> rpc.gssd to fail when it's configured to use the gssproxy interposer
> plugin (via "use-gss-proxy=3D1" in nfs.conf or GSS_USE_PROXY=3D"yes" in t=
he
> environment) *and* libtirpc debugging is enabled (i.e. at least one
> "-r" on the command line):
>=20
> 1. During startup if rpc debugging is enabled then libtirpc_set_debug()
>    is called, which calls openlog() which consumes fd 3.
> 2. If the gssproxy interposer plugin is enabled then when
>    gssd_check_mechs() is called, a socket is created (fd 4) and
>    connected to /var/lib/gssproxy/default.sock.  The fd is stored
>    internally in a struct gpm_ctx.
> 3. daemon_init() runs and closes all fd's >=3D 4.
> 4. event_init() runs which calls epoll_create() which returns an epoll
>    fd of 4.
> 5. Later when handling an upcall, gssd calls gssd_acquire_krb5_cred()
>    which winds up closing the gpm_ctx->fd which was 4.
> 6. event_dispatch() calls epoll_wait() with epfd=3D4, and -EBADF is
>    returned.  gssd logs the message ""ERROR: event_dispatch() returned!"
>    and exits.
>=20
> The solution is to call daemon_init() earlier.
>=20
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed...=20

steved.
> ---
>  utils/gssd/gssd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index 19ad4da..c38dedb 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -1020,11 +1020,11 @@ main(int argc, char *argv[])
>  =09=09=09    "support setting debug levels\n");
>  #endif
> =20
> +=09daemon_init(fg);
> +
>  =09if (gssd_check_mechs() !=3D 0)
>  =09=09errx(1, "Problem with gssapi library");
> =20
> -=09daemon_init(fg);
> -
>  =09event_init();
> =20
>  =09pipefs_dir =3D opendir(pipefs_path);
>=20

