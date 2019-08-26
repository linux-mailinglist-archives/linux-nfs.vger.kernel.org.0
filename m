Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B49D55E
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 20:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfHZSEA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 14:04:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbfHZSEA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 14:04:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7EA610C0330;
        Mon, 26 Aug 2019 18:03:59 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FC5F5F7C0;
        Mon, 26 Aug 2019 18:03:59 +0000 (UTC)
Subject: Re: [PATCH 3/3] tests: add missing include for strerror(3P)
To:     Patrick Steinhardt <ps@pks.im>, linux-nfs@vger.kernel.org
References: <6de0089348765e60bcdf59ef5813d7bb631c967f.1566805721.git.ps@pks.im>
 <7e2258fd221466a2974dcf7f0643c65168b429f8.1566805721.git.ps@pks.im>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <814c5e74-03ec-62ce-3801-e69a7f7bc670@RedHat.com>
Date:   Mon, 26 Aug 2019 14:03:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7e2258fd221466a2974dcf7f0643c65168b429f8.1566805721.git.ps@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Mon, 26 Aug 2019 18:03:59 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/26/19 3:48 AM, Patrick Steinhardt wrote:
> The function strerror(3P) is declared in <string.h>, but it is not
> included in "statdb_dump.c". Include it to fix compile errors.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  tests/statdb_dump.c | 1 +
>  1 file changed, 1 insertion(+)
Committed...

steved.
> 
> diff --git a/tests/statdb_dump.c b/tests/statdb_dump.c
> index 92d63f29..3ac12bff 100644
> --- a/tests/statdb_dump.c
> +++ b/tests/statdb_dump.c
> @@ -23,6 +23,7 @@
>  #include "config.h"
>  #endif
>  
> +#include <string.h>
>  #include <stdio.h>
>  #include <errno.h>
>  #include <arpa/inet.h>
> 
