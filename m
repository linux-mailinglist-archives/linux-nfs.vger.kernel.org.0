Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E91223D78
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jul 2020 15:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgGQNzZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jul 2020 09:55:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51352 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgGQNzX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jul 2020 09:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594994123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X02b1vJFGgXMWYspYUu96RuX9CVP5XNPwVehuuuXgN0=;
        b=RQtpfXedRT4T26J2+LIhwV1isytEi29ySep7V6sHqzy0wRW1cLyt9GbkIfmaQGA2n3Td00
        ftXJ+R9UlSD9gwXsCIdV+qMXZFh6cIWvEF5GazGBM78a6vkOxVAyMQKMSbNzuQU9QgNfc5
        3Jz/Td3R6MxT8irWibunc6SFcagiFZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-MA8x7KJ1ORm6Zxaw3qITvg-1; Fri, 17 Jul 2020 09:55:19 -0400
X-MC-Unique: MA8x7KJ1ORm6Zxaw3qITvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2B4D107ACCA
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jul 2020 13:55:18 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D4BD78A45;
        Fri, 17 Jul 2020 13:55:18 +0000 (UTC)
Subject: Re: [PATCH] nfsiostat/mountstats: handle KeyError in
 compare_iostats()
To:     Kenneth D'souza <kdsouza@redhat.com>, linux-nfs@vger.kernel.org
References: <20200708160606.21279-1-kdsouza@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <27e519e5-c45f-d4b2-77c4-4b83747772fd@RedHat.com>
Date:   Fri, 17 Jul 2020 09:55:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200708160606.21279-1-kdsouza@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/8/20 12:06 PM, Kenneth D'souza wrote:
> This will prevent a backtrace like this from occurring if nfsiostat is run
> with <interval> <count>, eg: nfsiostat 1 3
> This issue can occur if old_stats.__rpc_data['ops'] keys are not up to
> date with result.__rpc_data['ops'].
> I belive this issue can also affect mountstats due to similar code,
> hence fix it too.
> 
> nfsiostat:217:compare_iostats:KeyError: 'NULL'
> 
> Traceback (most recent call last):
>   File "/usr/sbin/nfsiostat", line 649, in <module>
>     iostat_command(prog)
>   File "/usr/sbin/nfsiostat", line 617, in iostat_command
>     print_iostat_summary(old_mountstats, mountstats, devices, sample_time, options)
>   File "/usr/sbin/nfsiostat", line 468, in print_iostat_summary
>     diff_stats[device] = stats[device].compare_iostats(old_stats)
>   File "/usr/sbin/nfsiostat", line 217, in compare_iostats
>     difference, self.__rpc_data[op], old_stats.__rpc_data[op]))
> KeyError: 'NULL'
> 
> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
Committed... (tag: nfs-utils-2-5-2-rc2

steved.
> ---
>  tools/mountstats/mountstats.py | 5 ++++-
>  tools/nfs-iostat/nfs-iostat.py | 7 +++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index 014f38a3..1054f698 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -560,7 +560,10 @@ class DeviceData:
>          # the reference to them.  so we build new lists here
>          # for the result object.
>          for op in result.__rpc_data['ops']:
> -            result.__rpc_data[op] = list(map(difference, self.__rpc_data[op], old_stats.__rpc_data[op]))
> +            try:
> +                result.__rpc_data[op] = list(map(difference, self.__rpc_data[op], old_stats.__rpc_data[op]))
> +            except KeyError:
> +                continue
>  
>          # update the remaining keys
>          if protocol == 'udp':
> diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
> index b7e98a2a..5556f692 100755
> --- a/tools/nfs-iostat/nfs-iostat.py
> +++ b/tools/nfs-iostat/nfs-iostat.py
> @@ -213,8 +213,11 @@ class DeviceData:
>          # the reference to them.  so we build new lists here
>          # for the result object.
>          for op in result.__rpc_data['ops']:
> -            result.__rpc_data[op] = list(map(
> -                difference, self.__rpc_data[op], old_stats.__rpc_data[op]))
> +            try:
> +                result.__rpc_data[op] = list(map(
> +                    difference, self.__rpc_data[op], old_stats.__rpc_data[op]))
> +            except KeyError:
> +                continue
>  
>          # update the remaining keys we care about
>          result.__rpc_data['rpcsends'] -= old_stats.__rpc_data['rpcsends']
> 

