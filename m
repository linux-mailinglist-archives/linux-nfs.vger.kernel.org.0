Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17B6195E71
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 20:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgC0TQg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 15:16:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41464 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727143AbgC0TQg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 15:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585336595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ClgdbfsN2BzyCiLhgFHe7L5SuiA1rMvZiylC76ARHq8=;
        b=A/eNs6+ebO0l47mwjGkDNOipTYxJSxsKyjHo7e/jAj22rCrR/hNCsmVk+AQQfiPvw08t96
        GU6l/wgxM5gmf2zL/CjIWOOrQ1nv5jbSaxbsuAwBPCZa1F02gu8TFuemE9dqsWERPu7cpw
        aHka74eIkQbmwydaHl83K6fcbR5gpxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-FjqwnJsWNHm8_cyUuOET9g-1; Fri, 27 Mar 2020 15:16:31 -0400
X-MC-Unique: FjqwnJsWNHm8_cyUuOET9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4879B18B9FC1;
        Fri, 27 Mar 2020 19:16:30 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-250.phx2.redhat.com [10.3.114.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3E1E1001B28;
        Fri, 27 Mar 2020 19:16:29 +0000 (UTC)
Subject: Re: [PATCH nfs-utils] conffile: Don't give warning for optional
 config files.
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <87imiq7586.fsf@notabene.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <caecff75-cca3-53f4-ef7c-3b66bbd2ff11@RedHat.com>
Date:   Fri, 27 Mar 2020 15:16:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87imiq7586.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/27/20 1:10 AM, NeilBrown wrote:
> 
> A recent commit added the possibility of optional config files for which
> warning messages would be suppressed.
> Unfortunately only one of the possible warning messages - the least
> likely one - was suppressed.
> 
> This patch suppresses the other.
> 
> Fixes: c6fdcbe0a5cf ("conffile: allow optional include files")
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-4-4-rc2)

steved.
> ---
>  support/nfs/conffile.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
> That was careless - sorry.  I really have tested this time.
> NeilBrown
> 
> diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
> index d55bfe10120a..3d13610ee766 100644
> --- a/support/nfs/conffile.c
> +++ b/support/nfs/conffile.c
> @@ -429,9 +429,9 @@ conf_parse_line(int trans, char *line, const char *filename, int lineno, char **
>  
>  		subconf = conf_readfile(relpath);
>  		if (subconf == NULL) {
> -			xlog_warn("config error at %s:%d: "
> -				"error loading included config",
> -				  filename, lineno);
> +			if (!optional)
> +				xlog_warn("config error at %s:%d: error loading included config",
> +					  filename, lineno);
>  			if (relpath)
>  				free(relpath);
>  			return;
> 

