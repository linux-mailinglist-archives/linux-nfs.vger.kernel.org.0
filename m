Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405AE390872
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhEYSHR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 14:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230145AbhEYSHQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 May 2021 14:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621965945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62BGTaZF69YDzfad9ZG3Jm6yAwXMrYK/lWUSFApeGZs=;
        b=GsAB1USVjTIOHh+GFb6jqxqPSp5KZIydgZmOZYAicJCPB0JjFmMztWPm77OS5YS6m+W5Qb
        bcAK1czo35aJ2TBs0MbdBXJX9TVF11mGQcOMI46vjs7k6YsHaQu0qWQd6UI4kJlG8YU8E9
        +jE68+f1iZR7N/nHzK1clSyyjMBUlSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-fNj9dOEsPr2RA5lT5PCeSQ-1; Tue, 25 May 2021 14:05:35 -0400
X-MC-Unique: fNj9dOEsPr2RA5lT5PCeSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57B499126B;
        Tue, 25 May 2021 18:05:34 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-214.phx2.redhat.com [10.3.112.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 159B96062F;
        Tue, 25 May 2021 18:05:34 +0000 (UTC)
Subject: Re: [PATCH nfs-utils 2/2] configure: check for rpc/rpc.h presence
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     linux-nfs@vger.kernel.org
References: <20210525112729.29062-1-rhi@pengutronix.de>
 <20210525112729.29062-2-rhi@pengutronix.de>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <042d49ae-2c4a-7c51-7c71-755fb1351905@RedHat.com>
Date:   Tue, 25 May 2021 14:08:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525112729.29062-2-rhi@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/25/21 7:27 AM, Roland Hieber wrote:
> Recent versions of glibc (since 2.26?) no longer supply rpc/rpc.h, and
> in previous versions, RPC was optional. Detect such cases and prompt the
> user to build with libtirpc instead.
> 
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>
Committed... (tag: nfs-utils-2-5-4-rc5)

steved.
> ---
>  configure.ac | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index f2e1bd30d0f2..25e988dfa33c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -335,6 +335,13 @@ AC_CHECK_HEADERS([sched.h], [], [])
>  AC_CHECK_FUNCS([unshare fstatat statx], [] , [])
>  AC_LIBPTHREAD([])
>  
> +# rpc/rpc.h can come from the glibc or from libtirpc
> +nfsutils_save_CPPFLAGS="${CPPFLAGS}"
> +CPPFLAGS="${CPPFLAGS} ${TIRPC_CFLAGS}"
> +AC_CHECK_HEADER(rpc/rpc.h, ,
> +                AC_MSG_ERROR([Header file rpc/rpc.h not found - maybe try building with --enable-tirpc]))
> +CPPFLAGS="${nfsutils_save_CPPFLAGS}"
> +
>  if test "$enable_nfsv4" = yes; then
>    dnl check for libevent libraries and headers
>    AC_LIBEVENT
> 

