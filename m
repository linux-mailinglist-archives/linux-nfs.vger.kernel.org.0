Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83952D2D05
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfJJOzc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 10:55:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:43788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbfJJOzc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 10 Oct 2019 10:55:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79C5DABB1;
        Thu, 10 Oct 2019 14:55:30 +0000 (UTC)
Message-ID: <f2b0fb36b1bcace13283f2daa926e7c035b3b051.camel@suse.de>
Subject: Re: [PATCH] utils/statd.man: Clarify the --name argument usage
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Thu, 10 Oct 2019 11:57:32 -0300
In-Reply-To: <20191002005241.28308-1-marcos.souza.org@gmail.com>
References: <20191002005241.28308-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ping?

On Tue, 2019-10-01 at 21:52 -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> The man page does not clarifies that the --name argument is only used
> by
> the sm-notify command, and statd itself listen to all interfaces.
> This
> change makes clear that the --name argument is only passed to sm-
> notify.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
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
> +command as the source address from which to send reboot notification
> requests.
> +.IP
>  The
>  .I ipaddr
>  form can be expressed as either an IPv4 or an IPv6 presentation
> address.
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

