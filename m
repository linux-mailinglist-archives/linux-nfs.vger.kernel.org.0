Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2494BA9C7
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 20:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiBQT1n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 14:27:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiBQT1l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 14:27:41 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263D0101F0E
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 11:27:27 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 625BD23D8; Thu, 17 Feb 2022 14:27:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 625BD23D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1645126046;
        bh=2W3L8zZX2WzJW1xPaCmGeCKuhvlClJA4KYf8MI4jkh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEoolzdmkZfanaYFUQDfimezdo6F44UK3yNRpkl0x+SCQwn5uVwD8c3XxSOK/GT9E
         HSBkT1EbB90bkZPUQxa6DMad4DgjKAJrVCBbj9f9MLuFhvzS2NgkoIpRzuPXnkW7h5
         n7jynRXrh3zo1/9ES3FJCoSOX6KPOdXRO95yKZNE=
Date:   Thu, 17 Feb 2022 14:27:26 -0500
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
Message-ID: <20220217192726.GB16497@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at>
 <20220217163332.GA16497@fieldses.org>
 <1525788049.60261.1645118835162.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525788049.60261.1645118835162.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 17, 2022 at 06:27:15PM +0100, Richard Weinberger wrote:
> > Von: "bfields" <bfields@fieldses.org>
> > Thanks, I'll try to take a look.
> > 
> > Before upstreaming, I would like us to pick just one.  These kind of
> > options tend to complicate testing and documentation and debugging.
> > 
> > For an RFC, though, I think it makes sense, so I'm fine with keeping
> > "reexport=" while we're still exploring the different options.  And,
> > hey, maybe we end up adding more than one after we've upstreamed the
> > first one.
> 
> Which one do you prefer?
> "predefined-fsidnum" should be the safest one to start.

I don't know!  I'll have to do some more reading and think about it.

> > Setting the timeout to 0 doesn't help with re-export server reboots.
> > After a reboot is another case where we could end up in a situation
> > where a client hands us a filehandle for a filesystem that isn't mounted
> > yet.
> > 
> > I think you want to keep a path with each entry in the database.  When
> > mountd gets a request for a filesystem it hasn't seen before, it stats
> > that path, which should trigger the automounts.
> 
> I have implemented that already. This feature is part of this series. :-)

Oh, good, got it.  It'll take me some time to catch up.

--b.
