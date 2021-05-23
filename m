Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A0538DC8D
	for <lists+linux-nfs@lfdr.de>; Sun, 23 May 2021 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhEWTLu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 May 2021 15:11:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:35622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231883AbhEWTLt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 23 May 2021 15:11:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621797022;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjhQwj3dqEBAvyuC0NysXifVb1PUhKRkHESLxmHI2G8=;
        b=yWimogXXwUfMc4WqHe9DMw4TWkaWcdAt8jyH6Xm4WyjCxoADYN8p+N2k0OLii8cv689VqE
        sHLUxtcXb2uwrT/tCbcipYiDJCZbB7fJJefD7rWTd5DrxF5nX82sLBE2TGaBv2QhBaymx8
        SO/0qPGd8zqJYfyWAVx5uOVX7IyT7Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621797022;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjhQwj3dqEBAvyuC0NysXifVb1PUhKRkHESLxmHI2G8=;
        b=i63+89vMv4cb4/ed4RLvwsg0r+NBQZwkpuvIBKAAA0XtO10gAcA+St3T6P/uZrJ865nPRV
        phmBmuBvXNGAJBCA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CCCBAB5F;
        Sun, 23 May 2021 19:10:22 +0000 (UTC)
Date:   Sun, 23 May 2021 21:10:20 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs 2/2] README: Add openSUSE
Message-ID: <YKqonLWEQIXctDeA@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210521060943.7223-1-pvorel@suse.cz>
 <20210521060943.7223-2-pvorel@suse.cz>
 <YKf5JmJ4uRnMob5K@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKf5JmJ4uRnMob5K@pick.fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

> Both applied, thanks.--b.
Thanks a lot! BTW I don't see it in master branch yet,
but you probably push it on Monday.

Kind regards,
Petr

> On Fri, May 21, 2021 at 08:09:43AM +0200, Petr Vorel wrote:
> > + sort alphabetically, improve formatting a bit

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  README | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)

> > diff --git a/README b/README
> > index 9093236..ddb802a 100644
> > --- a/README
> > +++ b/README
> > @@ -3,11 +3,17 @@ the merge of what were originally two independent projects--initially
> >  the 4.0 pynfs code was all moved into the nfs4.0 directory, but as time
> >  passes we expect to merge the two code bases.

> > -Install dependent modules; on Fedora:
> > -	yum install krb5-devel python3-devel swig python3-gssapi python3-ply
> > -on Debian:
> > +Install dependent modules:
> > +
> > +* Debian
> >  	apt-get install libkrb5-dev python3-dev swig python3-gssapi python3-ply

> > +* Fedora
> > +	yum install krb5-devel python3-devel swig python3-gssapi python3-ply
> > +
> > +* openSUSE
> > +	zypper in install krb5-devel python3-devel swig python3-gssapi python3-ply
> > +
> >  You can prepare both for use with
> >  	./setup.py build
> >  which will create auto-generated files and compile any shared libraries
> > -- 
> > 2.31.1


