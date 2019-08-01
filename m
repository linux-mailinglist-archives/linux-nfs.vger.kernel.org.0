Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA06A7DFD7
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbfHAQNO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 12:13:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732803AbfHAQNO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Aug 2019 12:13:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C5C97A182;
        Thu,  1 Aug 2019 16:13:14 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-78.phx2.redhat.com [10.3.117.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2EE660A9F;
        Thu,  1 Aug 2019 16:13:13 +0000 (UTC)
Subject: Re: [PATCH] mountstats: Fix nfsstat command to handle RPC iostats
 version >= 1.1
To:     Dave Wysochanski <dwysocha@redhat.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <20190626170259.8347-1-dwysocha@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <d55ee4a1-e4f9-afac-b750-636645cb2584@RedHat.com>
Date:   Thu, 1 Aug 2019 12:13:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190626170259.8347-1-dwysocha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 01 Aug 2019 16:13:14 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/26/19 1:02 PM, Dave Wysochanski wrote:
> Later kernels with RPC iostats version >= 1.1 have an additional errors
> count for each op.  Lengthen the array of values created inside
> DeviceData and then in __parse_rpc_line just zero this value out for
> prior kernels where this count is not present.  The count is not used
> for nfsstat, but this keeps DeviceData consistent with the new count
> as well as proper functioning of accumulate_iostats.
> 
> Before this patch, nfsstat will backtrace on a kernel with RPC iostats
> version >= 1.1 due to the fixed array inside DeviceData.  This patch
> fixes this backtrace and also allows nfsstat to work with these new
> kernels.
> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Committed... 

steved
> ---
>  tools/mountstats/mountstats.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index c5e8f506..6ac83ccb 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -308,6 +308,8 @@ class DeviceData:
>              op = words[0][:-1]
>              self.__rpc_data['ops'] += [op]
>              self.__rpc_data[op] = [int(word) for word in words[1:]]
> +            if len(self.__rpc_data[op]) < 9:
> +                self.__rpc_data[op] += [0]
>  
>      def parse_stats(self, lines):
>          """Turn a list of lines from a mount stat file into a 
> @@ -582,7 +584,7 @@ class DeviceData:
>              self.__nfs_data['fstype'] = 'nfs4'
>          self.__rpc_data['ops'] = ops
>          for op in ops:
> -            self.__rpc_data[op] = [0 for i in range(8)]
> +            self.__rpc_data[op] = [0 for i in range(9)]
>  
>      def accumulate_iostats(self, new_stats):
>          """Accumulate counters from all RPC op buckets in new_stats.  This is
> 
