Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C393140F51
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 17:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgAQQvj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 11:51:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37769 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgAQQvj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 11:51:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so22896006edb.4;
        Fri, 17 Jan 2020 08:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=96LG0GPidFH54SiCM0XDiVcbAovvK6mGYnlDshgyFRk=;
        b=ZACNq0PBZx1aF+u30AEqD6OLmz3Cgnz4hm6rVpXBMoY62n1XVOMuvGT/SsmI3TeYQj
         3b/N6T4ayIBXyp7kf1Uv341uIrU47z8OMkqQ/dkxkwqNFY5LI6yFOPBD/BjeBCu7K2X1
         7Bf6FzbWsuPG7RfbJ5T6RfKSYYfUl+7zadkw0u15kAXS4p6zFmpHbB5McW4BK3mOpg/t
         THikL7n5kZmSV8VxtCDg6eDu5H4y7UWCW4WDyl6srkGI3iT2vGN9kW4NFXKZAzf+GHH+
         kSiOL0Mfr8sidjdeTp3EnDCZ1VA8D8A2145tL8/IVxtV6ojRnabbmg5oHFKew626nI7f
         iWXw==
X-Gm-Message-State: APjAAAV8vq1RBRhqTM0Bd52IdDA3cPX4RiBS3B+BXMQFLjxFPgAs7wir
        E6AH4nFtSMBkq0AkZvUnqwM=
X-Google-Smtp-Source: APXvYqyaZsIauOpq1X0POCeTjXRUEXNVExY8r79MwcWm5a05h47iWdsrJnU/Lpd7ANMzUquKS+XFLQ==
X-Received: by 2002:a17:906:2db1:: with SMTP id g17mr8848463eji.240.1579279897085;
        Fri, 17 Jan 2020 08:51:37 -0800 (PST)
Received: from pi3 ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id z22sm1015705edq.79.2020.01.17.08.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:51:36 -0800 (PST)
Date:   Fri, 17 Jan 2020 17:51:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Scott Mayhew <smayhew@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] nfs: Return EINVAL rather than ERANGE for mount parse
 errors
Message-ID: <20200117165133.GA5762@pi3>
References: <464519.1579276102@warthog.procyon.org.uk>
 <20200117144055.GB3215@pi3>
 <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
 <433863.1579270803@warthog.procyon.org.uk>
 <465149.1579276509@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <465149.1579276509@warthog.procyon.org.uk>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 17, 2020 at 03:55:09PM +0000, David Howells wrote:
> commit b9423c912b770e5b9e4228d90da92b6a69693d8e
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Jan 17 15:37:46 2020 +0000
> 
>     nfs: Return EINVAL rather than ERANGE for mount parse errors
>     
>     Return EINVAL rather than ERANGE for mount parse errors as the userspace
>     mount command doesn't necessarily understand what to do with anything other
>     than EINVAL.
>     
>     The old code returned -ERANGE as an intermediate error that then get
>     converted to -EINVAL, whereas the new code returns -ERANGE.
>     
>     This was induced by passing minorversion=1 to a v4 mount where
>     CONFIG_NFS_V4_1 was disabled in the kernel build.
>     
>     Fixes: 68f65ef40e1e ("NFS: Convert mount option parsing to use functionality from fs_parser.h")
>     Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>     Signed-off-by: David Howells <dhowells@redhat.com>
> 
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 429315c011ae..74508ed9aeec 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -769,8 +769,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
>  out_invalid_address:
>  	return nfs_invalf(fc, "NFS: Bad IP address specified");
>  out_of_bounds:
> -	nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
> -	return -ERANGE;
> +	return nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
>  }
>  
>  /*

Yes, the boards boots up, thanks!

Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

I did not run extensive tests but few boots show also 2-3 seconds faster
mount of NFS root (faster switch from initramfs to proper user-space
from NFS).

Best regards,
Krzysztof

