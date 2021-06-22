Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471053B0B7C
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jun 2021 19:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFVRg4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Jun 2021 13:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231549AbhFVRg4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Jun 2021 13:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624383280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TVtNJdZu0dZrKv60AsPsMQ8QLT37JNkD/0O90aTqUu4=;
        b=LlWhsq6DgRBigtLUZtuZ7RKPrvoh7r5CMvBokGpheTN/hqLBt5Jb0WH06QmPpLA5Nryajp
        0xJRgXGxYtYzjZu5EU6cfHN5oEa07x+g4NvKAZTT6219tTtsay+gn0jRj3hrOhJqrzdwBo
        RKrldGnKZf8zqX7mT2ZUqjmNGnuKctA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-sqpDuflGOmSeBfG4yMOcwg-1; Tue, 22 Jun 2021 13:34:38 -0400
X-MC-Unique: sqpDuflGOmSeBfG4yMOcwg-1
Received: by mail-pj1-f70.google.com with SMTP id x2-20020a17090ab002b029016e8b858193so2525641pjq.3
        for <linux-nfs@vger.kernel.org>; Tue, 22 Jun 2021 10:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TVtNJdZu0dZrKv60AsPsMQ8QLT37JNkD/0O90aTqUu4=;
        b=Mvng26SaiAmYw5MiSq6+aP9e3EZZ9gGoVMOY8h/qMSczqcAQczxJntVsHmGu6BoWiJ
         htX8f4mNfRH6gRm/8vDmavjC7h2p5m9iq5iXOd0/M9Ti2cRE7IJ8UsCmsJXUWOTpIdc7
         tk0YbM3/dVVV4qEbaR1q0AqW7bcIX5JoeueUAd0okI1Xwynz+j5d4WxWUcp2ic6m34qS
         5ZTZLPbv/rcanxh8fhCmkw6b5ol32JIxXKXVabm3eWs9k6FpwiQSGGD2hfxX5NFwuC1Q
         e/2wn2GlPJv2DoGNeB2ONAF2Jx6yM/lASItmQ4nPFGEVwXdqVexTd5GB2i1ja6YBTive
         VzTQ==
X-Gm-Message-State: AOAM533skI8KQV0UTfk+wr2WCXfoCA6KZ0hRUEL25iBs9k2THpXIvKVY
        178iopfk4woEUssraQrBP0yPwgiCOh+cc4msuwTTZMiIuhDk5/P+yzKd/zeELg6LMF5MFGa5scd
        3YnSizrTCDU19VzrgUpFI
X-Received: by 2002:a17:90a:8a95:: with SMTP id x21mr4952279pjn.154.1624383277763;
        Tue, 22 Jun 2021 10:34:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAnFMJn4mymaXMrnUiEn3S5eyEqzjR1+8cHrCXWrfPlniEkj9lZX8Xveugvmton6t5eo5gJw==
X-Received: by 2002:a17:90a:8a95:: with SMTP id x21mr4952261pjn.154.1624383277496;
        Tue, 22 Jun 2021 10:34:37 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-143-216.hsd1.or.comcast.net. [76.105.143.216])
        by smtp.gmail.com with ESMTPSA id k6sm18552697pfa.215.2021.06.22.10.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 10:34:36 -0700 (PDT)
Subject: Re: any idea about auto export multiple btrfs snapshots?
To:     Wang Yugui <wangyugui@e16-tech.com>,
        Frank Filz <ffilzlnx@mindspring.com>
Cc:     'NeilBrown' <neilb@suse.de>, linux-nfs@vger.kernel.org,
        Frank Filz <ffilz@redhat.com>
References: <20210621225541.3CEB.409509F4@e16-tech.com>
 <001901d766c5$cf427af0$6dc770d0$@mindspring.com>
 <20210622064158.98CA.409509F4@e16-tech.com>
From:   Frank Filz <ffilz@redhat.com>
Message-ID: <f2581d9f-dfe4-3280-80de-31683c9e647d@redhat.com>
Date:   Tue, 22 Jun 2021 10:34:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210622064158.98CA.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/21/21 3:41 PM, Wang Yugui wrote:
> Hi,
>
>> OK thanks for the information. I think they will just work in nfs-ganesha as
>> long as the snapshots or subvols are mounted within an nfs-ganesha export or
>> are exported explicitly. nfs-ganesha has the equivalent of knfsd's
>> nohide/crossmnt options and when nfs-ganesha detects crossing a filesystem
>> boundary will lookup the filesystem via getmntend and listing btrfs subvols
>> and then expose that filesystem (via the fsid attribute) to the clients
>> where at least the Linux nfs client will detect a filesystem boundary and
>> create a new mount entry for it.
>
> Not only exported explicitly, but also kept in the same hierarchy.
>
> If we export
> /mnt/test		#the btrfs
> /mnt/test/sub1	# the btrfs subvol 1
> /mnt/test/sub2	# the btrfs subvol 2
>
> we need to make sure we will not access '/mnt/test/sub1' through '/mnt/test'
> from nfs client.
>
> current safe export:
> #/mnt/test		#the btrfs, not exported
> /mnt/test/sub1	# the btrfs subvol 1
> /mnt/test/sub2	# the btrfs subvol 2
>

What's the problem with exporting /mnt/test AND then exporting sub1 and 
sub2 as crossmnt exports? As far as I can tell, that seems to work just 
fine with nfs-ganesha.

Frank

