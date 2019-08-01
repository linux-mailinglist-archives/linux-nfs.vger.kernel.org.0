Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134937DFDA
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfHAQNd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 12:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731767AbfHAQNd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Aug 2019 12:13:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BECB9EE563;
        Thu,  1 Aug 2019 16:13:32 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-78.phx2.redhat.com [10.3.117.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35AEC19C65;
        Thu,  1 Aug 2019 16:13:31 +0000 (UTC)
Subject: Re: [PATCH 1/2] nfsiostat: Add error counts to output when RPC
 iostats version >= 1.1
To:     Dave Wysochanski <dwysocha@redhat.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <20190624211639.22511-1-dwysocha@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <fc5c10ec-8330-144a-f418-ad9e17ac9148@RedHat.com>
Date:   Thu, 1 Aug 2019 12:13:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190624211639.22511-1-dwysocha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 01 Aug 2019 16:13:32 +0000 (UTC)
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
Committed.... 

steved.

> ---
>  tools/nfs-iostat/nfs-iostat.py | 17 +++++++++++++++--
>  tools/nfs-iostat/nfsiostat.man |  8 ++++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 tools/nfs-iostat/nfs-iostat.py
> 
> diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
> old mode 100644
> new mode 100755
> index dec0e861..b7e98a2a
> --- a/tools/nfs-iostat/nfs-iostat.py
> +++ b/tools/nfs-iostat/nfs-iostat.py
> @@ -329,6 +329,8 @@ class DeviceData:
>          queued_for = float(rpc_stats[5])
>          rtt = float(rpc_stats[6])
>          exe = float(rpc_stats[7])
> +        if len(rpc_stats) >= 9:
> +            errs = float(rpc_stats[8])
>  
>          # prevent floating point exceptions
>          if ops != 0:
> @@ -337,12 +339,16 @@ class DeviceData:
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
> +            if len(rpc_stats) >= 9:
> +                errs_percent = 0.0
>  
>          op += ':'
>          print(format(op.lower(), '<16s'), end='')
> @@ -352,7 +358,10 @@ class DeviceData:
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
> @@ -361,7 +370,11 @@ class DeviceData:
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
>      def ops(self, sample_time):
>          sends = float(self.__rpc_data['rpcsends'])
> diff --git a/tools/nfs-iostat/nfsiostat.man b/tools/nfs-iostat/nfsiostat.man
> index 9ae94c5f..940c0431 100644
> --- a/tools/nfs-iostat/nfsiostat.man
> +++ b/tools/nfs-iostat/nfsiostat.man
> @@ -97,6 +97,14 @@ This is the duration from the time the NFS client created the RPC request task t
>  .RE
>  .RE
>  .RE
> +.RS 8
> +- \fBerrors\fR
> +.RS
> +This is the number of operations that completed with an error status (status < 0).  This count is only available on kernels with RPC iostats version 1.1 or above.
> +.RS
> +.RE
> +.RE
> +.RE
>  .TP
>  Note that if an interval is used as argument to \fBnfsiostat\fR, then the diffrence from previous interval will be displayed, otherwise the results will be from the time that the share was mounted.
>  
> 
