Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86636296C49
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Oct 2020 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461643AbgJWJon (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Oct 2020 05:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461642AbgJWJon (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Oct 2020 05:44:43 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF730C0613D2
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 02:44:42 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id jMke230054C55Sk06MkeWb; Fri, 23 Oct 2020 11:44:38 +0200
Received: from geert (helo=localhost)
        by ramsan with local-esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kVtck-0007pP-4E; Fri, 23 Oct 2020 11:44:38 +0200
Date:   Fri, 23 Oct 2020 11:44:38 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>
cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: raise kernel RPC channel buffer size
In-Reply-To: <20201019132000.GA32403@fieldses.org>
Message-ID: <alpine.DEB.2.21.2010231141460.29805@ramsan.of.borg>
References: <20201019093356.7395-1-rbergant@redhat.com> <20201019132000.GA32403@fieldses.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

 	Hi Bruce, Roberto,

On Mon, 19 Oct 2020, J. Bruce Fields wrote:
> On Mon, Oct 19, 2020 at 11:33:56AM +0200, Roberto Bergantinos Corpas wrote:
>> Its possible that using AUTH_SYS and mountd manage-gids option a
>> user may hit the 8k RPC channel buffer limit. This have been observed
>> on field, causing unanswered RPCs on clients after mountd fails to
>> write on channel :
>>
>> rpc.mountd[11231]: auth_unix_gid: error writing reply
>>
>> Userland nfs-utils uses a buffer size of 32k (RPC_CHAN_BUF_SIZE), so
>> lets match those two.
>
> Thanks, applying.
>
> That should allow about 4000 group memberships.  If that doesn't do it
> then maybe it's time to rethink....
>
> --b.
>
>>
>> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
>> ---
>>  net/sunrpc/cache.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
>> index baef5ee43dbb..08df4c599ab3 100644
>> --- a/net/sunrpc/cache.c
>> +++ b/net/sunrpc/cache.c
>> @@ -908,7 +908,7 @@ static ssize_t cache_do_downcall(char *kaddr, const char __user *buf,
>>  static ssize_t cache_slow_downcall(const char __user *buf,
>>  				   size_t count, struct cache_detail *cd)
>>  {
>> -	static char write_buf[8192]; /* protected by queue_io_mutex */
>> +	static char write_buf[32768]; /* protected by queue_io_mutex */
>>  	ssize_t ret = -EINVAL;
>>
>>  	if (count >= sizeof(write_buf))

This is now commit 27a1e8a0f79e643d ("sunrpc: raise kernel RPC channel
buffer size") upstream, and increases kernel size by 24 KiB, even if
RPC is not used.

Can this buffer allocated dynamically instead? This code path seems to
be a slow path anyway. If it's critical, perhaps this buffer can be
allocated on first use?

Thanks!

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
