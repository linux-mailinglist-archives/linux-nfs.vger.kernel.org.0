Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FA81EE733
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2020 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgFDPCR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Jun 2020 11:02:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29743 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729139AbgFDPCQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Jun 2020 11:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591282935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1ED4QJKI/4Iqfn3JU6ZLGoyccqDWrmFfeRiynzHN94=;
        b=dDdpn18ajTN3AwlbpkOE8szf5lzzCD0g3q4N21eOn6nmCi35lOTo2u/DKru7EZJUA0wW59
        S80xTskEcYflMz9rkzO01Cf489NcfN4f1AdQElJJzycVqCxsoo1bFMeTQyyD+Cq17TZHyb
        qLAlNxDHB8w0tSBaelm/zldh2tkdE/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-dubSIxZSNROjZbcbgyW4HA-1; Thu, 04 Jun 2020 11:02:13 -0400
X-MC-Unique: dubSIxZSNROjZbcbgyW4HA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8094835B40
        for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2020 15:02:12 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-73.phx2.redhat.com [10.3.114.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 848A57CCCD;
        Thu,  4 Jun 2020 15:02:12 +0000 (UTC)
Subject: Re: [nfs-utils PATCH] mountstats: add missing operations
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20200603182839.3282825-1-smayhew@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <e1681b95-3755-ac26-fa6d-f2cac580b5a5@RedHat.com>
Date:   Thu, 4 Jun 2020 11:02:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603182839.3282825-1-smayhew@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/3/20 2:28 PM, Scott Mayhew wrote:
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  tools/mountstats/mountstats.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
Committed... 

steved.

> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index 3e2a3fe..f101ce5 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -225,7 +225,12 @@ Nfsv4ops = [
>      'ALLOCATE',
>      'DEALLOCATE',
>      'LAYOUTSTATS',
> -    'CLONE'
> +    'CLONE',
> +    'COPY',
> +    'OFFLOAD_CANCEL',
> +    'LOOKUPP',
> +    'LAYOUTERROR',
> +    'COPY_NOTIFY'
>  ]
>  
>  def sec_conv(rem):
> 

