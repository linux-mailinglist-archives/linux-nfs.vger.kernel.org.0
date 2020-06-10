Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17D1F5B3E
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2020 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgFJSdu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jun 2020 14:33:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45850 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727078AbgFJSdu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Jun 2020 14:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591814029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXzwqG3oe112MHknvY+eNQZalHsRMmbfKeVoPZEpDgQ=;
        b=dT+3xKrRx1xlx3RCIlJ6tZq7Fs9YgYzxB48iHc1tdA7wO6lQIVI/w6ul5mIJO9xIWogQns
        GxDxkydh7oNSrJvCTL4YS7wY9LCpqWZsBbTrxV1O2RTGIfnrpW+KA62DxqBRn4M60n989x
        ILq6WPEdi+VGUnpwnSxfAwKGRWQhWvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Rvdb2_wkNGa4DJxSNQFgZA-1; Wed, 10 Jun 2020 14:33:47 -0400
X-MC-Unique: Rvdb2_wkNGa4DJxSNQFgZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E98628018AD
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jun 2020 18:33:46 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-115-94.phx2.redhat.com [10.3.115.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A644819C71;
        Wed, 10 Jun 2020 18:33:46 +0000 (UTC)
Subject: Re: [PATCH] nfsdclnts: Change shebang to /usr/bin/python3
To:     Kenneth D'souza <kdsouza@redhat.com>, linux-nfs@vger.kernel.org
References: <20200610120437.17482-1-kdsouza@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c7d49f9f-965c-0ddd-bb6d-22d6eef6c38c@RedHat.com>
Date:   Wed, 10 Jun 2020 14:33:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200610120437.17482-1-kdsouza@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/10/20 8:04 AM, Kenneth D'souza wrote:
> Change shebang to /usr/bin/python3 which is widely accepted.
> 
> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
Committed. (tag: nfs-utils-2-4-4-rc7)

steved.

> ---
>  tools/nfsdclnts/nfsdclnts.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/nfsdclnts/nfsdclnts.py b/tools/nfsdclnts/nfsdclnts.py
> index e5f636a2..5e7e03c2 100755
> --- a/tools/nfsdclnts/nfsdclnts.py
> +++ b/tools/nfsdclnts/nfsdclnts.py
> @@ -1,4 +1,4 @@
> -#!/bin/python3
> +#!/usr/bin/python3
>  # -*- python-mode -*-
>  '''
>      Copyright (C) 2020
> 

