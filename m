Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B4D3FA1C7
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 01:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhH0XZH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 19:25:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45956 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhH0XZH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 19:25:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1274A223BB;
        Fri, 27 Aug 2021 23:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630106657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRX5IHP4fRhATZ4OEIy3EzUas7+DeUsabR2SGE0WfXI=;
        b=Hi0/JwWQ4vZsSCIfS2Xfd//3LvsuopagUaBqE6bz1FeD06qQs2rSGEIwMoMbxF5i9s6H6t
        Utmw9sPYvED+Lj5NwAo90aCqiFbgoq0O4NbjhhE/8RHlVYmAVUHiuFUq63ZcQdHz2qEaDd
        p9QhT+tc39S2Azq0z0L/7RAKIptathI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630106657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRX5IHP4fRhATZ4OEIy3EzUas7+DeUsabR2SGE0WfXI=;
        b=CoTDqxqkBvGF9vbaukiisnhQHO1cAEYISdguQOO/pD0z1bBdQ+5ooo2n73uh56mRKTdydZ
        Cr6USjf9KJSB7/AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B05B113D7D;
        Fri, 27 Aug 2021 23:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lfWHGR90KWHlKAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Aug 2021 23:24:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     "J.  Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Christoph Hellwig" <hch@lst.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: drop support for ancient file-handles
In-reply-to: <20210827151505.GA19199@lst.de>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <20210827151505.GA19199@lst.de>
Date:   Sat, 28 Aug 2021 09:24:12 +1000
Message-id: <163010665269.7591.11571286577204380127@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 28 Aug 2021, Christoph Hellwig wrote:
> On Thu, Aug 26, 2021 at 02:28:15PM +1000, NeilBrown wrote:
> > This patch also moves the nfsfh.h from the include/uapi directory into
> > fs/nfsd.  I can find no evidence of it being used anywhere outside the
> > kernel.  Certainly nfs-utils and wireshark do not use it.
> 
> That sounds fine, but I'd split this into a separate patch.

Thanks for your review.  Your suggestions seem appropriate.
I'll send out revised patches in a couple of days.

NeilBrown


> 
> > fh_base and fh_pad are occasionally used to refer to the whole
> > filehandle.  These are replaced with "fh_raw" which is hopefully more
> > meaningful.
> 
> I think that kind of cleanup should also be a separate patch.  That
> being said as far as I can tell fh_raw is only ever used in context
> where we can just pass a void pointer.  So just giving the struct
> for the "new" file handle after fh_size a name and passing that
> would be much cleaner than a union with a char array.
> 
> 
> > I found
> >  https://www.spinics.net/lists/linux-nfs/msg43280.html
> >  "Re: [PATCH] nfsd: clean up fh_auth usage"
> > from 2014 where moving nfsfh.h out of uapi was considered but not
> > actioned. Christoph said he would "do some research if the
> > uapi <linux/nfsd/*.h> headers are used anywhere at all".  I can find no
> > report on the result of that research.  My own research turned up
> > nothing.
> 
> I can't remember doing much of research, and certainly not of finding
> anything.
> 
> > -	memcpy((char*)&fh.fh_handle.fh_base, f->data, f->size);
> > +	memcpy((char*)&fh.fh_handle.fh_raw, f->data, f->size);
> 
> Indedpendnt on what we're going to pass here, I don't think we
> should need cast like this one (there are a few more).
> 
> 
