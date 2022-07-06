Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1995A567EB2
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 08:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiGFGgv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 02:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiGFGgt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 02:36:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A315E183BE;
        Tue,  5 Jul 2022 23:36:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 57A0F227A3;
        Wed,  6 Jul 2022 06:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657089403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZewOA184OSewd9I14K/9G+WUgM9nkCS/J7YWUXtrTA=;
        b=jsAhwHxHkVt8skZ1S7Gt+lnNBU1/jkKgeQ4aR76zLIXoylQXuPnpCTch9vuqycR+/37I0G
        LeixzlX5SvDRWdmTRZGMLQk/ZntrQ23fOTMbw4PZsvCC9ktFvj7+js4ft5pnEY3wqByDlZ
        Wz0qz+aum4L+7IOCocsIX18zFuQ9FTI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F221513A7D;
        Wed,  6 Jul 2022 06:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EhpsOHotxWL9cAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 06 Jul 2022 06:36:42 +0000
Message-ID: <148c0ac2-add4-69e8-ced7-49772841720b@suse.com>
Date:   Wed, 6 Jul 2022 09:36:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: bug in btrfs during low memory testing.
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     dai.ngo@oracle.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        gniebler@suse.com,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <c09e1af7-7d1f-1bbf-5562-ead9a4d99562@oracle.com>
 <CAL3q7H7Jm034yfVYJDzugWHPamvnKU=7XSb=38ey+-L_qdd=OA@mail.gmail.com>
 <YsSfPl6IvqrM5OPU@casper.infradead.org>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <YsSfPl6IvqrM5OPU@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5.07.22 г. 23:29 ч., Matthew Wilcox wrote:
> On Tue, Jul 05, 2022 at 09:26:47PM +0100, Filipe Manana wrote:
>> In this case we can actually call xa_insert() without holding that
>> spinlock, it's safe against other concurrent calls to
>> btrfs_get_or_create_delayed_node(), btrfs_get_delayed_node(),
>> btrfs_kill_delayed_inode_items(), etc.
>>
>> However, looking at xa_insert() we have:
>>
>>          xa_lock(xa);
>>          err = __xa_insert(xa, index, entry, gfp);
>>          xa_unlock(xa);
>>
>> And xa_lock() is defined as:
>>
>>          #define xa_lock(xa)             spin_lock(&(xa)->xa_lock)
>>
>> So we'll always be under a spinlock even if we change btrfs to not
>> take the root->inode_lock spinlock.
>>
>> This seems more like a general problem outside btrfs' control.
>> So CC'ing Willy to double check.
> 
> No, the XArray knows about its own spinlock.  It'll drop it if it needs
> to allocate memory and the GFP flags indicate that the caller can sleep.
> It doesn't know about your spinlock, so it can't do the same thing for
> you ;-)


In order to catch (and prevent) further offensive can we perhaps have 
something like that in xa_insert:


diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index c29e11b2c073..63c00b2945a2 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -770,6 +770,9 @@ static inline int __must_check xa_insert(struct 
xarray *xa,
  {
         int err;

+       if (gfpflags_allow_blocking(gfp))
+               might_sleep()
+
         xa_lock(xa);
         err = __xa_insert(xa, index, entry, gfp);
         xa_unlock(xa);


Because an alternative route to fix is it to have GFP_ATOMIC in the gfp.

Basically we'd want to bark on xa_insert execution when we are 
in_atomic(), cause by something else apart from xa_lock ?
