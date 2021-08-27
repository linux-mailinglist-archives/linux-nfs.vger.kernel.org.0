Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D33C3FA1A9
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 01:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhH0XCn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 19:02:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58322 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhH0XCn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 19:02:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B2DB71FF4B;
        Fri, 27 Aug 2021 23:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630105312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nHU1Ux1kS4uzV5I7vGm2nV6xB5sfxiugKrsg1GfIvo=;
        b=p7Z1aS5RZdcAjUQqTBlGlZQ8StpGlrh97yt3aHp5+rieUl01Vbe6EcCg1Iw5whb/JBU38/
        xvJaaTAvA9e7DwacERCLxKQd8baeeT8shbrQR8TVHm9zuJC1Ci8RtBWWizYn93GIK0CrjF
        cOqrJh83f80IhUU16idwUIC8IMabGmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630105312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nHU1Ux1kS4uzV5I7vGm2nV6xB5sfxiugKrsg1GfIvo=;
        b=G9uQ3esHOjRFSxeW9/XbR/S7eWhr3TR3CUV7QVq6qibbQBhrWIjhlLK6PPnlr5af3nowUW
        uB5iPYq4b/ev/cCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63D2313A66;
        Fri, 27 Aug 2021 23:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DSXVCN9uKWHwJAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Aug 2021 23:01:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J.  Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <20210827183216.GC3915@fieldses.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <20210826201916.GB10730@fieldses.org>,
 <163001583884.7591.13328510041463261313@noble.neil.brown.name>,
 <20210827183216.GC3915@fieldses.org>
Date:   Sat, 28 Aug 2021 09:01:48 +1000
Message-id: <163010530848.7591.9076942348960044071@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 28 Aug 2021, J.  Bruce Fields wrote:
> On Fri, Aug 27, 2021 at 08:10:38AM +1000, NeilBrown wrote:
> > On Fri, 27 Aug 2021, J.  Bruce Fields wrote:
> > > On Thu, Aug 26, 2021 at 04:03:04PM +1000, NeilBrown wrote:
> > > > +	}
> > > > +	if (resp->dir_ino_uniquifier != ino)
> > > > +		ino ^= resp->dir_ino_uniquifier;
> > > 
> > > I guess this check (here and in nfsd_uniquify_ino) is just to prevent
> > > returning inode number zero?
> > 
> > Yep.  The set of valid inode numbers is 1..MAX and that set isn't closed
> > under xor.
> 
> I was curious....
> 
> The NFS specs don't require FILEID to be nonzero as far as I can tell.
> 
> Our client doesn't treat fileid 0 specially.  In the case it has to
> return a 32-bit inode it xors the high and low parts and makes no effort
> I can see to check for the 0 case.
> 
> I modified a server to return 0 for FILEID and MOUNTED_ON_FILEID on one
> particular file, and an strace shows that's happily passed on to
> userspace:
> 
> 	getdents64(3, [..., {d_ino=0, d_off=2048, d_reclen=32,
> 	d_type=DT_REG, d_name="LOCKTESTFILE"}]
> 
> But ls silently skips that file in the output.  Huh.
> 

What DO they teach in history class?
The original Unix File System (edition 6, 7 at least) had 16 bytes per
entry in directories (that could be read with read(2)).  Two bytes of
inode number and 14 bytes of name.
When a name was deleted, the inode number was over-written with '0'.
So code - and coders - from that era ignore directory entries with
d_ino==0.

I'm not certain what inode 0 was used for, but I think it had some
behind-the-scenes role.  Free-space?

So some code might work find with ino==0, but I'd rather not risk it.

NeilBrown
