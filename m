Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A6D4BAAB1
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 21:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbiBQUSV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 15:18:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiBQUSV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 15:18:21 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAFA5D189
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 12:18:06 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9FC496CD5; Thu, 17 Feb 2022 15:18:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9FC496CD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1645129085;
        bh=EIV6bSrUCovsJA7LLmLYBMGsYjZLrMe5hyXnYoy3tyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nhL+JnMEm+3c+5wdJk8yZZFVef3gYfW6Rwnptcu+F2xgd5EOYD9ZG8+K4rWh0x8Xe
         JzmUCpl7xZGs2j+hEYzLB0iej929f5+OcWDKCWj6iVctsGvFIB8T4FdrU6y9wA62vu
         8kdWIL+ixa7+sBYBdTok5JIViyPIegOJidCCwfpU=
Date:   Thu, 17 Feb 2022 15:18:05 -0500
From:   bfields <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Subject: Re: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports
Message-ID: <20220217201805.GC16497@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at>
 <20220217163332.GA16497@fieldses.org>
 <1525788049.60261.1645118835162.JavaMail.zimbra@nod.at>
 <20220217192726.GB16497@fieldses.org>
 <245552734.60874.1645128938141.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <245552734.60874.1645128938141.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 17, 2022 at 09:15:38PM +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "bfields" <bfields@fieldses.org>
> >> Which one do you prefer?
> >> "predefined-fsidnum" should be the safest one to start.
> > 
> > I don't know!  I'll have to do some more reading and think about it.
> 
> No need to worry, take your time.
>  
> >> > Setting the timeout to 0 doesn't help with re-export server reboots.
> >> > After a reboot is another case where we could end up in a situation
> >> > where a client hands us a filehandle for a filesystem that isn't mounted
> >> > yet.
> >> > 
> >> > I think you want to keep a path with each entry in the database.  When
> >> > mountd gets a request for a filesystem it hasn't seen before, it stats
> >> > that path, which should trigger the automounts.
> >> 
> >> I have implemented that already. This feature is part of this series. :-)
> > 
> > Oh, good, got it.  It'll take me some time to catch up.
> 
> The reason why setting the timeout to 0 is still needed is because
> when mountd uncovers a subvolume but no client uses it a filehandle,
> it is not locked and can be unmounted later.
> Only when nfsd sees a matching filehandle the reference counter will
> be increased and umounting is no longer possible.

I understand that.  But, then if a client comes in with a matching
filehandle, mountd should be able to look up the filesystem and trigger
a new mount, right?

I can imagine that setting the timeout to 0 might be an optimization,
but I'm not seeing why it's required for correct behavior.

--b.
