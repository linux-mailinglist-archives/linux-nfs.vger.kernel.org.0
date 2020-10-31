Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE712A18AD
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Oct 2020 17:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgJaQQr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 31 Oct 2020 12:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgJaQQq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 31 Oct 2020 12:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604161004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdDvgkZ0S9DwIkCEFa3vBakJ7UPa2euYsw+ts9gdC9k=;
        b=VJCLZgQ7LHKlajY3NZasMpZ+1yiyuqvPySDV1pk70KWIe7Scfvsg9CulD0/ZCpFI+PICx1
        nr5rbpA9IWYaO8JEDDUOoGl1312nCEMU4yghSageitdj+WALf5s5tV8A7aH/SBfIF2MQNM
        fueNeqrO5zylaWjR/3ph44k/r99Ujww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-Rx5xM9--NFe-d3fyETaupg-1; Sat, 31 Oct 2020 12:16:40 -0400
X-MC-Unique: Rx5xM9--NFe-d3fyETaupg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE6708030B9
        for <linux-nfs@vger.kernel.org>; Sat, 31 Oct 2020 16:16:39 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-8.phx2.redhat.com [10.3.113.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6368C5578C;
        Sat, 31 Oct 2020 16:16:39 +0000 (UTC)
Subject: Re: [PATCH v1] mountstats: handle KeyError in display_raw_stats
To:     Rohan Sable <rsable@redhat.com>, linux-nfs@vger.kernel.org
References: <20201028125911.GA140323@fedora.rsable.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <d640308c-cc4d-ef25-4cac-5754051f82e8@RedHat.com>
Date:   Sat, 31 Oct 2020 12:16:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028125911.GA140323@fedora.rsable.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/28/20 8:59 AM, Rohan Sable wrote:
> While printing Nfsv4ops from older /proc/self/mountstats
> e.g. in 2.6.32-754.el6.x86_64 from RHEL 6.10,
> it will not have all the Keys present leading to a KeyError
> like below :
> 
> Traceback (most recent call last):
>   File "nfs-utils/tools/mountstats/mountstats.py", line 1131, in <module>
>     res = main()
>   File "nfs-utils/tools/mountstats/mountstats.py", line 1120, in main
>     return args.func(args)
>   File "nfs-utils/tools/mountstats/mountstats.py", line 860, in mountstats_command
>     print_mountstats(stats, args.nfs_only, args.rpc_only, args.raw, args.xprt_only)
>   File "nfs-utils/tools/mountstats/mountstats.py", line 813, in print_mountstats
>     stats.display_raw_stats()
>   File "nfs-utils/tools/mountstats/mountstats.py", line 381, in display_raw_stats
>     print('\t%12s: %s' % (op, " ".join(str(x) for x in self.__rpc_data[op])))
> KeyError: 'FSID_PRESENT'
> 
> Signed-off-by: Rohan Sable <rsable@redhat.com>
I was not able to reproduce this on a RHEL6.10 box but it didn't make either. ;-) 

Committed... 

steved.
> ---
>  tools/mountstats/mountstats.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index 25e92a19..23876fc4 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -378,7 +378,10 @@ class DeviceData:
>                  print('\t%12s: %s' % (op, " ".join(str(x) for x in self.__rpc_data[op])))
>          elif vers == '4':
>              for op in Nfsv4ops:
> -                print('\t%12s: %s' % (op, " ".join(str(x) for x in self.__rpc_data[op])))
> +                try:
> +                    print('\t%12s: %s' % (op, " ".join(str(x) for x in self.__rpc_data[op])))
> +                except KeyError:
> +                    continue
>          else:
>              print('\tnot implemented for version %d' % vers)
>          print()
> 

