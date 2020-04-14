Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4228D1A7FAA
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2020 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390543AbgDNO0G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Apr 2020 10:26:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56950 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733197AbgDNO0D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Apr 2020 10:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586874362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUnrI8a/LRuh/krAaV6gfJC7jslGuf9CJt0GDZnCtGE=;
        b=hsTPtnjmLErvAySeamaB1OfWOWyPJFUI7KU0y20BVM5jQuYlA4902W8bOaPkC5cBi1bLi8
        yB/ZlsIBKcvEAWWvAqlURDFrQyn1ZLIuIOYcwMDBaF+BXFChleXaTt+t/YZs2DN6pk7gzd
        X8Iqdr38G/CFpJmZJoulTWVTqxaWLZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-Byk32WVRO_26baYEDxI5Eg-1; Tue, 14 Apr 2020 10:26:01 -0400
X-MC-Unique: Byk32WVRO_26baYEDxI5Eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FAADDBA3;
        Tue, 14 Apr 2020 14:26:00 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-136.phx2.redhat.com [10.3.113.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C31229F99D;
        Tue, 14 Apr 2020 14:25:59 +0000 (UTC)
Subject: Re: [PATCH 2/2] nfs-utils: tools: use nls.h
To:     Rosen Penev <rosenp@gmail.com>, linux-nfs@vger.kernel.org
References: <20200404052453.2631191-1-rosenp@gmail.com>
 <20200404052453.2631191-2-rosenp@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <7537a7dd-ad2b-5131-adc8-47a412dd3c8e@RedHat.com>
Date:   Tue, 14 Apr 2020 10:25:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200404052453.2631191-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/4/20 1:24 AM, Rosen Penev wrote:
> libintl.h is not available everywhere. This fixes compilation.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Committed... (tag: nfs-utils-2-4-4-rc3)

steved.
> ---
>  tools/rpcgen/rpc_main.c | 2 +-
>  tools/rpcgen/rpc_scan.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/rpcgen/rpc_main.c b/tools/rpcgen/rpc_main.c
> index 1b26e522..e97940b9 100644
> --- a/tools/rpcgen/rpc_main.c
> +++ b/tools/rpcgen/rpc_main.c
> @@ -42,7 +42,6 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <unistd.h>
> -#include <libintl.h>
>  #include <locale.h>
>  #include <ctype.h>
>  #include <sys/types.h>
> @@ -54,6 +53,7 @@
>  #include "rpc_util.h"
>  #include "rpc_scan.h"
>  #include "proto.h"
> +#include "nls.h"
>  
>  #ifndef _
>  #define _(String) gettext (String)
> diff --git a/tools/rpcgen/rpc_scan.c b/tools/rpcgen/rpc_scan.c
> index 79eba964..7de61120 100644
> --- a/tools/rpcgen/rpc_scan.c
> +++ b/tools/rpcgen/rpc_scan.c
> @@ -37,11 +37,11 @@
>  #include <stdio.h>
>  #include <ctype.h>
>  #include <string.h>
> -#include <libintl.h>
>  #include "rpc_scan.h"
>  #include "rpc_parse.h"
>  #include "rpc_util.h"
>  #include "proto.h"
> +#include "nls.h"
>  
>  #ifndef _
>  #define _(String) gettext (String)
> 

