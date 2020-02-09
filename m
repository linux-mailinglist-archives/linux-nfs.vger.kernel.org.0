Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65DC156C43
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2020 20:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgBITlJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Feb 2020 14:41:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727404AbgBITlJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Feb 2020 14:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581277268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FBe5EYpDKTtlHc+g8aua6+DH9alfFOxhvhaOSTLRB4Q=;
        b=R1gQ2iuo5wJjZML/tyjvkYq73p1Xy1rlySEB8Z+hqAAN1Q6oN5C/HdLuFrLgi6sFoBqPzF
        XGZ+EzNEyO3mAXVL1/xNAsUwFyuF9Fg9LJjdaMmB71x8q6TnelytwHNamrxWGZI1c9vrJU
        JU+Jv3oC5E9MgjeuuKVelh3r5mjGLAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-sEKbjsKSNzCtb1OZO6ztTg-1; Sun, 09 Feb 2020 14:41:04 -0500
X-MC-Unique: sEKbjsKSNzCtb1OZO6ztTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B52A91005502
        for <linux-nfs@vger.kernel.org>; Sun,  9 Feb 2020 19:41:03 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-141.phx2.redhat.com [10.3.117.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7005B1001DF2;
        Sun,  9 Feb 2020 19:41:03 +0000 (UTC)
Subject: Re: [PATCH] mountstats.man: Fix a typo in man page.
To:     Kenneth D'souza <kdsouza@redhat.com>, linux-nfs@vger.kernel.org
References: <20200209121059.19048-1-kdsouza@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <a0bb4733-a7a1-a8a9-0110-d451765b65ba@RedHat.com>
Date:   Sun, 9 Feb 2020 14:41:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200209121059.19048-1-kdsouza@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/9/20 7:10 AM, Kenneth D'souza wrote:
> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
Committed... Thanks!

steved.

> ---
>  tools/mountstats/mountstats.man | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/mountstats/mountstats.man b/tools/mountstats/mountstats.man
> index ff2f8ba3..d5595fc7 100644
> --- a/tools/mountstats/mountstats.man
> +++ b/tools/mountstats/mountstats.man
> @@ -35,7 +35,7 @@ mountstats \- Displays various NFS client per-mount statistics
>  .RI [ count ]
>  .RI [ mountpoint ] ...
>  .P
> -.B mounstats nfsstat
> +.B mountstats nfsstat
>  .RB [ \-h | \-\-help ]
>  .RB [ \-v | \-\-version ]
>  .RB [ \-f | \-\-file
> 

