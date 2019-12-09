Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3BF1170ED
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2019 16:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfLIP43 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Dec 2019 10:56:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43283 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbfLIP43 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Dec 2019 10:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575906988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4OGOImy+zW+rp8iuKHc1/Qt3mCg0wPou7dCrsAOrB4=;
        b=UOpx1uZyQ9ZIBpHyZbOE8DnmAmPE87bMXTbJqJrTFeWuqdisS8hgn0QvFOg4DQFg0Ob+8V
        V/fuZM5rKAyrUsS+unXDr4d3/Mfh9C271ZZ27ZX+BeBHYTspte5q5C4L0Utj6GF2bDui74
        /OWl003nZBPVNB0HCnwrHE9JdNwMV8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193--HPSAzWkPPGZiDSD6cbliQ-1; Mon, 09 Dec 2019 10:56:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2E33107ACC7;
        Mon,  9 Dec 2019 15:56:25 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-120.phx2.redhat.com [10.3.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 952111001B03;
        Mon,  9 Dec 2019 15:56:25 +0000 (UTC)
Subject: Re: [PATCH] Disable statx if using glibc emulation
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20191205102736.24314-1-nazard@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <af515986-dcaa-6a79-6e68-d589ba87568c@RedHat.com>
Date:   Mon, 9 Dec 2019 10:56:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191205102736.24314-1-nazard@nazar.ca>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: -HPSAzWkPPGZiDSD6cbliQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/5/19 5:27 AM, Doug Nazar wrote:
> On older kernels without statx, glibc with statx support will attempt
> to emulate the call. However it doesn't support AT_STATX_DONT_SYNC and
> will return EINVAL. This causes all xstat/xlstat calls to fail.
> 
> Signed-off-by: Doug Nazar <nazard@nazar.ca>
Committed... (tag: nfs-utils-2-4-3-rc3)

steved.

> ---
>  support/misc/xstat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/support/misc/xstat.c b/support/misc/xstat.c
> index 661e29e4..a438fbcc 100644
> --- a/support/misc/xstat.c
> +++ b/support/misc/xstat.c
> @@ -51,6 +51,9 @@ statx_do_stat(int fd, const char *pathname, struct stat *statbuf, int flags)
>  			statx_copy(statbuf, &stxbuf);
>  			return 0;
>  		}
> +		/* glibc emulation doesn't support AT_STATX_DONT_SYNC */
> +		if (errno == EINVAL)
> +			errno = ENOSYS;
>  		if (errno == ENOSYS)
>  			statx_supported = 0;
>  	} else
> 

