Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B055D2C4260
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 15:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgKYOry (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 09:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgKYOry (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 09:47:54 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370CCC0613D4
        for <linux-nfs@vger.kernel.org>; Wed, 25 Nov 2020 06:47:54 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 10D696EA1; Wed, 25 Nov 2020 09:47:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 10D696EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606315673;
        bh=vZJ6rqqCLO9Rn+i2pM+yesoiN1pJ6o1MPv8iuylxfQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYw13DlIp25Q9rrYz8JSF44OjvqJUEADVOSG2W6LjKFO1Dne5/nIAHqhYy41gGhEk
         2kFEBg+ioDhj11MiptAXgmIBf9g5zVwWqRS9qEOrL7NCBpY7f4yR21bjkt3vfV0bEB
         fpcTZ1TWvJkJm4BBF5EjMHuWzSYhWPkO4JFOowvM=
Date:   Wed, 25 Nov 2020 09:47:53 -0500
From:   'bfields' <bfields@fieldses.org>
To:     Frank Filz <ffilzlnx@mindspring.com>
Cc:     'Daire Byrne' <daire@dneg.com>,
        'Trond Myklebust' <trondmy@hammerspace.com>,
        'linux-cachefs' <linux-cachefs@redhat.com>,
        'linux-nfs' <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201125144753.GC2811@fieldses.org>
References: <20200915172140.GA32632@fieldses.org>
 <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com>
 <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com>
 <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
 <20201109160256.GB11144@fieldses.org>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
 <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
 <20201124211522.GC7173@fieldses.org>
 <0fc201d6c2af$62b039f0$2810add0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc201d6c2af$62b039f0$2810add0$@mindspring.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 02:15:57PM -0800, Frank Filz wrote:
> How much conversation about re-export has been had at the wider NFS
> community level? I have an interest because Ganesha  supports re-export via
> the PROXY_V3 and PROXY_V4 FSALs. We currently don't have a data cache though
> there has been discussion of such, we do have attribute and dirent caches.
> 
> Looking over the wiki page, I have considered being able to specify a
> re-export of a Ganesha export without encapsulating handles. Ganesha
> encapsulates the export_fs handle in a way that could be coordinated between
> the original server and the re-export so they would both effectively have
> the same encapsulation layer.

In the case the re-export server only servers a single export, I guess
you could do away with the encapsulation.  (The only risk I see is that
a client of the re-export server could also access any export of the
original server if it could guess filehandles, which might surprise
admins.)  Maybe that'd be useful.

Another advantage of not encapsulating filehandles is that clients could
more easily migrate between servers.

Cooperating servers could have an agreement on filehandles.  And I guess
we could standardize that somehow.  Are we ready for that?  I'm not sure
what other re-exporting problems there are that I haven't thought of.

--b.

> I'd love to see some re-export best practices shared among server
> implementations, and also what we can do to improve things when two server
> implementations are interoperating via re-export.
