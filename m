Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC8D6955
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2019 20:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfJNSTW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Oct 2019 14:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbfJNSTW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Oct 2019 14:19:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E0CE3084295;
        Mon, 14 Oct 2019 18:19:22 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-253.phx2.redhat.com [10.3.116.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96A405D6A3;
        Mon, 14 Oct 2019 18:19:21 +0000 (UTC)
Subject: Re: [PATCH] utils/statd.man: Clarify the --name argument usage
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-nfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20191002005241.28308-1-marcos.souza.org@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <433d129b-1dd5-d99a-6eb9-52355f00bb61@RedHat.com>
Date:   Mon, 14 Oct 2019 14:19:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002005241.28308-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 14 Oct 2019 18:19:22 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/1/19 8:52 PM, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> The man page does not clarifies that the --name argument is only used by
> the sm-notify command, and statd itself listen to all interfaces. This
> change makes clear that the --name argument is only passed to sm-notify.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
I was traveling... but.. Committed!

steved.

> ---
>  utils/statd/statd.man | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/utils/statd/statd.man b/utils/statd/statd.man
> index 71d58461..03732a6f 100644
> --- a/utils/statd/statd.man
> +++ b/utils/statd/statd.man
> @@ -185,18 +185,16 @@ restarts without the
>  option.
>  .TP
>  .BI "\-n, " "" "\-\-name " ipaddr " | " hostname
> -Specifies the bind address used for RPC listener sockets.
> +This string is only used by the
> +.B sm-notify
> +command as the source address from which to send reboot notification requests.
> +.IP
>  The
>  .I ipaddr
>  form can be expressed as either an IPv4 or an IPv6 presentation address.
>  If this option is not specified,
>  .B rpc.statd
>  uses a wildcard address as the transport bind address.
> -.IP
> -This string is also passed to the
> -.B sm-notify
> -command to be used as the source address from which
> -to send reboot notification requests.
>  See
>  .BR sm-notify (8)
>  for details.
> 
