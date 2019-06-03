Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7F83321B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 16:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfFCO1U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 10:27:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbfFCO1U (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jun 2019 10:27:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62474C1EB1F2;
        Mon,  3 Jun 2019 14:27:20 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-46.phx2.redhat.com [10.3.116.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0041E601B6;
        Mon,  3 Jun 2019 14:27:19 +0000 (UTC)
Subject: Re: [PATCH] manpage: explain why showmount doesn't really work
 against a v4-only server
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, jfajerski@suse.com
References: <20190510215445.1823-1-jlayton@kernel.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <cb6af578-63fc-3832-0337-6a109e80dd0d@RedHat.com>
Date:   Mon, 3 Jun 2019 10:27:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510215445.1823-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 03 Jun 2019 14:27:20 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/10/19 5:54 PM, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> I occasionally see people that expect valid info when running showmount
> against a server that may export some or all filesystems via NFSv4.
> Let's make it clear that it only works by talking to the remote MNT
> service, and that that may not be available from a v4-only server.
> 
> Cc: Jan Fajerski <jfajerski@suse.com>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
Committed... 

steved.

> ---
>  utils/showmount/showmount.man | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/utils/showmount/showmount.man b/utils/showmount/showmount.man
> index a2f510fb5617..35818e1b61c5 100644
> --- a/utils/showmount/showmount.man
> +++ b/utils/showmount/showmount.man
> @@ -56,5 +56,10 @@ Because
>  .B showmount
>  sorts and uniqs the output, it is impossible to determine from
>  the output whether a client is mounting the same directory more than once.
> +.P
> +.B showmount
> +works by contacting the server's MNT service directly. NFSv4-only servers have
> +no need to advertise their exported root filehandles via this method, and may
> +not expose their MNT service to clients.
>  .SH AUTHOR
>  Rick Sladkey <jrs@world.std.com>
> -- 2.21.0
> 
