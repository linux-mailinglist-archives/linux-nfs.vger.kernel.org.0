Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ABA1F5B3D
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2020 20:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgFJSdT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jun 2020 14:33:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31312 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727078AbgFJSdS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Jun 2020 14:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591813997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LpWcHcS7Inh3139O9TFA1yKOcaZbpjAaJCES8NvihQ=;
        b=XifOssCP6dyUyCyExLnB8YPsKPRZL+P8r96Ct5TY02zi1Zxu01O5feydiBAaMAGeUAzdeP
        tBNFhA12gk7VuAonSMN9itmVDQeyVJ6KzAWxgpdULKeAqY20ZbxdCJaVFcf3LRJ77pOm9I
        pIhkQMn8/HH4cJ3JBajDlyTa6epuuVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-eqUylsDDMDeXstuXo9zoGQ-1; Wed, 10 Jun 2020 14:33:13 -0400
X-MC-Unique: eqUylsDDMDeXstuXo9zoGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F191C107ACCD;
        Wed, 10 Jun 2020 18:33:12 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-115-94.phx2.redhat.com [10.3.115.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D3205D9D3;
        Wed, 10 Jun 2020 18:33:12 +0000 (UTC)
Subject: Re: [PATCH] man: Correct rpc.gssd(8) description of rpc-timeout and
 context-timeout
To:     Robert Milkowski <rmilkowski@gmail.com>, linux-nfs@vger.kernel.org
References: <118701d63f40$d538e1e0$7faaa5a0$@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c48f4b75-cac1-5a0d-b28c-0f21759638c1@RedHat.com>
Date:   Wed, 10 Jun 2020 14:33:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <118701d63f40$d538e1e0$7faaa5a0$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/10/20 12:04 PM, Robert Milkowski wrote:
> From: Robert Milkowski <rmilkowski@gmail.com>
> 
> The rpc-timeout is equivalent to -T and context-timeout to -t options,
> not vice versa.
> 
> Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
Committed... (tag: nfs-utils-2-4-4-rc7)

steved.

> ---
>  utils/gssd/gssd.man | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
> index 3ec286b..26095a8 100644
> --- a/utils/gssd/gssd.man
> +++ b/utils/gssd/gssd.man
> @@ -322,11 +322,11 @@ Equivalent to
>  .TP
>  .B context-timeout
>  Equivalent to
> -.BR -T .
> +.BR -t .
>  .TP
>  .B rpc-timeout
>  Equivalent to
> -.BR -t .
> +.BR -T .
>  .TP
>  .B keytab-file
>  Equivalent to
> 

