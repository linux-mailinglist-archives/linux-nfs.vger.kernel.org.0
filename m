Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EF02861F0
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgJGPRX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 11:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGPRX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 11:17:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7472AC061755
        for <linux-nfs@vger.kernel.org>; Wed,  7 Oct 2020 08:17:23 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A0984F3B; Wed,  7 Oct 2020 11:17:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7A0984F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602083841;
        bh=gWF60kTa6qaJSZW9VGSirwmljthvgORrU+G2KAXieHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTgfRh/Uj578NNTj5/OkTQxEjcGRIgvDWTKAVPzVdOdY1FRGZJG8b7Z+7vrTnmUIu
         1etREgZLeZ3K+dVfbyOlXozmdXF5BD4znHwluG4m8Rc1kyvRuUN4wzn4ZxbOEjO5Vh
         /rlv+l2zoFTVENaPvC49lbLoSZQzxsyI6vCxxXTA=
Date:   Wed, 7 Oct 2020 11:17:21 -0400
From:   "'J. Bruce Fields'" <bfields@fieldses.org>
To:     Frank Filz <ffilzlnx@mindspring.com>
Cc:     'Kenneth Johansson' <ken@kenjo.org>,
        'Patrick Goetz' <pgoetz@math.utexas.edu>,
        linux-nfs@vger.kernel.org
Subject: Re: nfs home directory and google chrome.
Message-ID: <20201007151721.GD23452@fieldses.org>
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
 <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu>
 <923003de-7fcf-abee-07a2-0691b25673d8@kenjo.org>
 <20201006181454.GB32640@fieldses.org>
 <07f3684e-482e-dc73-5c9a-b7c9329fc410@kenjo.org>
 <20201007131037.GA23452@fieldses.org>
 <031501d69cb6$f6843a10$e38cae30$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031501d69cb6$f6843a10$e38cae30$@mindspring.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 07, 2020 at 07:34:27AM -0700, Frank Filz wrote:
> > -----Original Message----- From: J. Bruce Fields
> > [mailto:bfields@fieldses.org] Maybe I overlooked the obvious: if
> > Chrome holds a lock on that file when you suspend, and if you stay
> > in suspend for longer than the NFSv4 lease time (default 90
> > seconds), then the client will lose its lease, hence any file locks.
> > I think these days the client then returns EIO on any further IO to
> > that file descriptor.
> > 
> > Maybe there's some way to turn off that locking as a workaround.
> > 
> > The simplest thing we can do to help might be implementing
> > "courteous server" behavior: instead of automatically removing locks
> > after a client's lease expires, it can wait until there's an actual
> > lock conflict.  That might be enough for your case.
> > 
> > There's been a little planning done and it's not a big project, but
> > I don't think it's actually at the top of anyone's todo list right
> > now, so I'm not sure when that will get done.
> 
> I've had courtesy locks on my back burner for Ganesha though I hadn't
> thought about that there might actually be an important practical
> issue. Does any other server implement them? If we suggest this as a
> solution to the Chrome suspend issue, it might be good to assure that
> the major server vendors implement this.
> 
> There is a problem with the courtesy locks for this solution though...
> The clientid is still going to be expired, and the locks are
> associated with the clientid, so unless we allow courtesy
> re-instatement of expired clientids, courtesy locks don't actually
> solve the problem...

The server's not required to expire the clientid when the lease expires.
A server that chooses to be "courteous" can let it hang around.

As a first implementation our server would probably wait until there's a
lock conflict, then destroy all the client's state.  But we could also
choose to revoke only those locks we have to.  The client uses
TEST_STATEID, I think, to sort out what's happened in that case.

I believe the Linux client implements all of this.  I'm not sure about
the status of other servers.

--b.
