Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36AF533233
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfFCOcC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 10:32:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29891 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbfFCOcB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jun 2019 10:32:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6064A369C4
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jun 2019 14:32:01 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-46.phx2.redhat.com [10.3.116.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87FEC60856;
        Mon,  3 Jun 2019 14:31:57 +0000 (UTC)
Subject: Re: [PATCH v2] mountstats: add per-op error counts for mountstats
 command
To:     Dave Wysochanski <dwysocha@redhat.com>, linux-nfs@vger.kernel.org
References: <20190523201351.12232-4-dwysocha@redhat.com>
 <20190523203344.12487-1-dwysocha@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <5e717cc4-f24a-0f83-452f-39167f8e48e3@RedHat.com>
Date:   Mon, 3 Jun 2019 10:31:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523203344.12487-1-dwysocha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 03 Jun 2019 14:32:01 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/23/19 4:33 PM, Dave Wysochanski wrote:
> Display the count of ops completing with error status (status < 0)
> on kernels that support it.
> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  tools/mountstats/mountstats.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
Committed... 

steved.
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index c7fb8bb1..2f525f4b 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -475,7 +475,9 @@ class DeviceData:
>                  retrans = stats[2] - count
>                  if retrans != 0:
>                      print('\t%d retrans (%d%%)' % (retrans, ((retrans * 100) / count)), end=' ')
> -                    print('\t%d major timeouts' % stats[3])
> +                    print('\t%d major timeouts' % stats[3], end='')
> +                if len(stats) >= 10 and stats[9] != 0:
> +                    print('\t%d errors (%d%%)' % (stats[9], ((stats[9] * 100) / count)))
>                  else:
>                      print('')
>                  print('\tavg bytes sent per op: %d\tavg bytes received per op: %d' % \
> 
