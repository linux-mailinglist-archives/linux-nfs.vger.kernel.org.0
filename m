Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14EF9B611
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2019 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403824AbfHWSIP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Aug 2019 14:08:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732152AbfHWSIO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 23 Aug 2019 14:08:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92397307BCC4;
        Fri, 23 Aug 2019 18:08:14 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-80.phx2.redhat.com [10.3.116.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 358EA600C1;
        Fri, 23 Aug 2019 18:08:14 +0000 (UTC)
Subject: Re: [nfs-utils PATCH] gssd: add configure options verbosity to man
 page rpc.gssd(8)
To:     Yongcheng Yang <yongcheng.yang@gmail.com>
Cc:     linux-nfs@vger.kernel.org, plambri@redhat.com
References: <20190823085945.14465-1-yongcheng.yang@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <0fc3b144-8a2b-1ce4-c09e-36d1f441a599@RedHat.com>
Date:   Fri, 23 Aug 2019 14:08:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823085945.14465-1-yongcheng.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 23 Aug 2019 18:08:14 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/23/19 4:59 AM, Yongcheng Yang wrote:
> Signed-off-by: Pierguido Lambri <plambri@redhat.com>
> Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
> ---
>  utils/gssd/gssd.man | 8 ++++++++
>  1 file changed, 8 insertions(+)
Committed... Thanks for the clean up!

steved.
> 
> diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
> index e620f0d1..cc3a210a 100644
> --- a/utils/gssd/gssd.man
> +++ b/utils/gssd/gssd.man
> @@ -305,6 +305,14 @@ section of the
>  .I /etc/nfs.conf
>  configuration file.  Values recognized include:
>  .TP
> +.B verbosity
> +Value which is equivalent to the number of
> +.BR -v .
> +.TP
> +.B rpc-verbosity
> +Value which is equivalent to the number of
> +.BR -r .
> +.TP
>  .B use-memcache
>  A Boolean flag equivalent to
>  .BR -M .
> 
