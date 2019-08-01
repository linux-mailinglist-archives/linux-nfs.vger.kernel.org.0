Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7D7DFDD
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbfHAQNt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 12:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731704AbfHAQNt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Aug 2019 12:13:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C2E7AFA5B;
        Thu,  1 Aug 2019 16:13:48 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-78.phx2.redhat.com [10.3.117.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 145895C219;
        Thu,  1 Aug 2019 16:13:47 +0000 (UTC)
Subject: Re: [PATCH 2/2] mountstats: Add per-op error counts to iostat command
 when RPC iostats version >= 1.1
To:     Dave Wysochanski <dwysocha@redhat.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <20190624211639.22511-1-dwysocha@redhat.com>
 <20190624211639.22511-2-dwysocha@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <d6989a9e-68ce-66fb-f9a5-2af8079d87e6@RedHat.com>
Date:   Thu, 1 Aug 2019 12:13:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190624211639.22511-2-dwysocha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 01 Aug 2019 16:13:48 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/24/19 5:16 PM, Dave Wysochanski wrote:
> With RPC iostats 1.1 there is a new metric which counts the RPCs
> completing with errors (tk_status < 0).  Add these to the output at
> the end of the line.  This increases the length of an output line
> to 136 columns from 120, but keeps consistent format and spacing:
> 
> read:              ops/s            kB/s           kB/op         retrans    avg RTT (ms)    avg exe (ms)  avg queue (ms)          errors
>                    0.000           0.106         512.316        0 (0.0%)          17.500          17.500           0.000        0 (0.0%)
> write:             ops/s            kB/s           kB/op         retrans    avg RTT (ms)    avg exe (ms)  avg queue (ms)          errors
>                    0.001           0.476         512.398        0 (0.0%)           1.667           5.778           3.889       1 (11.1%)
> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Committed... 

steved.
> ---
>  tools/mountstats/mountstats.py | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index 2f525f4b..c5e8f506 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -607,6 +607,8 @@ class DeviceData:
>          queued_for = float(rpc_stats[5])
>          rtt = float(rpc_stats[6])
>          exe = float(rpc_stats[7])
> +        if len(rpc_stats) >= 9:
> +            errs = int(rpc_stats[8])
>  
>          # prevent floating point exceptions
>          if ops != 0:
> @@ -615,12 +617,15 @@ class DeviceData:
>              rtt_per_op = rtt / ops
>              exe_per_op = exe / ops
>              queued_for_per_op = queued_for / ops
> +            if len(rpc_stats) >= 9:
> +                errs_percent = (errs * 100) / ops
>          else:
>              kb_per_op = 0.0
>              retrans_percent = 0.0
>              rtt_per_op = 0.0
>              exe_per_op = 0.0
>              queued_for_per_op = 0.0
> +            errs_percent = 0.0
>  
>          op += ':'
>          print(format(op.lower(), '<16s'), end='')
> @@ -630,7 +635,10 @@ class DeviceData:
>          print(format('retrans', '>16s'), end='')
>          print(format('avg RTT (ms)', '>16s'), end='')
>          print(format('avg exe (ms)', '>16s'), end='')
> -        print(format('avg queue (ms)', '>16s'))
> +        print(format('avg queue (ms)', '>16s'), end='')
> +        if len(rpc_stats) >= 9:
> +            print(format('errors', '>16s'), end='')
> +        print()
>  
>          print(format((ops / sample_time), '>24.3f'), end='')
>          print(format((kilobytes / sample_time), '>16.3f'), end='')
> @@ -639,7 +647,11 @@ class DeviceData:
>          print(format(retransmits, '>16'), end='')
>          print(format(rtt_per_op, '>16.3f'), end='')
>          print(format(exe_per_op, '>16.3f'), end='')
> -        print(format(queued_for_per_op, '>16.3f'))
> +        print(format(queued_for_per_op, '>16.3f'), end='')
> +        if len(rpc_stats) >= 9:
> +            errors = '{0:>10.0f} ({1:>3.1f}%)'.format(errs, errs_percent).strip()
> +            print(format(errors, '>16'), end='')
> +        print()
>  
>      def display_iostats(self, sample_time):
>          """Display NFS and RPC stats in an iostat-like way
> 
