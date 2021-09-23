Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B512D416373
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Sep 2021 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhIWQlA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 12:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhIWQk7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 12:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632415167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8ov93gh6gEgNam1zEVh52SO4uH/OFoKotsrTvuGAL4=;
        b=fSCpIBr3wI0FGtfXjWcy0dKi65D1QlBmmFNYWeSgs0+3Nf+AGE7QBGpjK09ZRyth8gvukj
        RoKbxm2rP8RRrF18Sks0NNQRI02v0yiHg85EzYrg3SygTnariwDt5Pp4+lbiYgpRr4mFzm
        cXStNQmQT5e6iEdazuPfzQANOb6JdJ0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-_XUdjmMYMRSEK9CRtLtqqA-1; Thu, 23 Sep 2021 12:39:26 -0400
X-MC-Unique: _XUdjmMYMRSEK9CRtLtqqA-1
Received: by mail-qv1-f70.google.com with SMTP id h16-20020a05621402f000b0037cc26a5659so21550776qvu.1
        for <linux-nfs@vger.kernel.org>; Thu, 23 Sep 2021 09:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P8ov93gh6gEgNam1zEVh52SO4uH/OFoKotsrTvuGAL4=;
        b=oEpeSbeL6OPOyyjIle7SZo4/sQtgicEX3jcjhDynGN6Qci2BbsY1WlniNMXSno+0R1
         H1C8MOswpvirPeOls97dhnliO9B7OAvoSnszSwVPTSIzm5eOcivLj/5J7Vmi834/a2Sj
         j2n/vbGAQZrlEoH/Crmku/G8ZP3+WEKCHBGcEha1oE3Dq1KIAhe1tita7bkoNictvnlS
         LZUnGHEuatG/rKXLJf6FmHxWPeUqSPM5U/EkS34KksMTU0GSDLOMdehgAW+ewepqbKZh
         n/1zF6bnH5ZGFOqG7cuMcqTuWtvx5wqRsjYmwMcjcv6yl/DAv/rRYsll12p6SmjfMWOW
         c5NQ==
X-Gm-Message-State: AOAM532r2+JqaYd4yQzDbnMNCp7dUbNcRCPhAt841q1eSuPi6GTgZcIp
        pScXL6gbxuXsD6SSz2g/w20HvGu+UQDTSPKy+ioNfoRDKLvFiw0HDQvlhspE8QtmXs8Ky59bOY4
        KHq46dVOvUOQCFcV3I5/dJwrgGLJKd3uKc8P9ykn6GAEJuW8XFdqFTsvVFLDrmVSEa992Ow==
X-Received: by 2002:a37:6683:: with SMTP id a125mr5723724qkc.351.1632415166097;
        Thu, 23 Sep 2021 09:39:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2YJiqAhJMViWR5Y4B1gMmexWmydEkc7lT56H7Z+0Fzj4Zf/mmGvoRHhKSrfi0n5fCxute8w==
X-Received: by 2002:a37:6683:: with SMTP id a125mr5723700qkc.351.1632415165859;
        Thu, 23 Sep 2021 09:39:25 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.105.255.190])
        by smtp.gmail.com with ESMTPSA id o19sm3549985qtv.85.2021.09.23.09.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:39:25 -0700 (PDT)
Subject: Re: [PATCH 1/1] mountstats: division by zero error on new mount when
 0==rpcsends
To:     Stig <thatsafunnyname@gmail.com>, linux-nfs@vger.kernel.org
References: <CAD9POpJSfbBYVgupAFxie_N6g2BQAUZ-qWV=tZFMHMJMmdqoYw@mail.gmail.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <52652487-e2c5-a7b9-ec87-5a184a48c1ab@redhat.com>
Date:   Thu, 23 Sep 2021 12:39:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAD9POpJSfbBYVgupAFxie_N6g2BQAUZ-qWV=tZFMHMJMmdqoYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/22/21 11:44 AM, Stig wrote:
> For https://bugzilla.linux-nfs.org/show_bug.cgi?id=367
> 
> When rpcsends is 0 this is the error seen when mounstats is run on a
> NFSv4.2 mount:
> 
>> sudo umount /fsx ; sudo mount /fsx ; mountstats /fsx
Committed... (tag: nfs-utils-2-5-5-rc3)

On future patches please use the proper 'Signed-off-by:' tag.

steved.

> ...
> RPC statistics:
>    0 RPC requests sent, 0 RPC replies received (0 XIDs not found)
> 
> SERVER_CAPS:
> Traceback (most recent call last):
>    File "mountstats.py.orig", line 1134, in <module>
>      res = main()
>    File "mountstats.py.orig", line 1123, in main
>      return args.func(args)
>    File "mountstats.py.orig", line 863, in mountstats_command
>      print_mountstats(stats, args.nfs_only, args.rpc_only, args.raw,
> args.xprt_only)
>    File "mountstats.py.orig", line 825, in print_mountstats
>      stats.display_rpc_op_stats()
>    File "mountstats.py.orig", line 486, in display_rpc_op_stats
>      (count, ((count * 100) / sends)), end=' ')
> ZeroDivisionError: division by zero
> 
> Fixed with:
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index 23876fc..8e129c8 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -482,8 +482,11 @@ class DeviceData:
>               count = stats[1]
>               if count != 0:
>                   print('%s:' % stats[0])
> +                ops_pcnt = 0
> +                if sends != 0:
> +                    ops_pcnt = (count * 100) / sends
>                   print('\t%d ops (%d%%)' % \
> -                    (count, ((count * 100) / sends)), end=' ')
> +                    (count, ops_pcnt), end=' ')
>                   retrans = stats[2] - count
>                   if retrans != 0:
>                       print('\t%d retrans (%d%%)' % (retrans, ((retrans
> * 100) / count)), end=' ')
> 

