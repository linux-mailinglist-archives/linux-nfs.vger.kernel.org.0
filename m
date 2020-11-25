Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB66F2C4807
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 20:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgKYTDS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 14:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKYTDR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 14:03:17 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73114C0613D4
        for <linux-nfs@vger.kernel.org>; Wed, 25 Nov 2020 11:03:16 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 770376EAD; Wed, 25 Nov 2020 14:03:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 770376EAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606330995;
        bh=GCfj1jzbCfSW/LiIq/NfQBzT5VgI1Awx4tOhEsW0VXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=damraUJwHBSE71kBWey0qdSi2wraLEhp7miS2ib4YCu+/1JyBxTEZbKd0VoidZuHF
         VwxHrh7AyeEikIcdn0JZ113wZQXYmfzhvX+iXczmDt1JwtHn5tBxQ1jFTZUHjQK4lT
         R7m/quH3buZSEfaBao/gtM/wk/a+/uVDNVaZh8Is=
Date:   Wed, 25 Nov 2020 14:03:15 -0500
From:   'bfields' <bfields@fieldses.org>
To:     Frank Filz <ffilzlnx@mindspring.com>
Cc:     'Daire Byrne' <daire@dneg.com>,
        'Trond Myklebust' <trondmy@hammerspace.com>,
        'linux-cachefs' <linux-cachefs@redhat.com>,
        'linux-nfs' <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201125190315.GB7049@fieldses.org>
References: <1188023047.38703514.1600272094778.JavaMail.zimbra@dneg.com>
 <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
 <20201109160256.GB11144@fieldses.org>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
 <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
 <20201124211522.GC7173@fieldses.org>
 <0fc201d6c2af$62b039f0$2810add0$@mindspring.com>
 <20201125144753.GC2811@fieldses.org>
 <100101d6c347$917ed0f0$b47c72d0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <100101d6c347$917ed0f0$b47c72d0$@mindspring.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 25, 2020 at 08:25:19AM -0800, Frank Filz wrote:
> On the other
> hand, re-export with state has a pitfall. If the re-export server crashes,
> the state is lost on the original server unless we make a protocol change to
> allow state re-export such that a re-export server crashing doesn't cause
> state loss.

Oh, yes, reboot recovery's an interesting problem that I'd forgotten
about; added to that wiki page.

By "state re-export" you mean you'd take the stateids the original
server returned to you, and return them to your own clients?  So then
I guess you wouldn't need much state at all.

> For this reason, I haven't rushed to implement lock state
> re-export in Ganesha, rather allowing the re-export server to just manage
> lock state locally.
> 
> > Cooperating servers could have an agreement on filehandles.  And I guess
> we
> > could standardize that somehow.  Are we ready for that?  I'm not sure what
> > other re-exporting problems there are that I haven't thought of.
> 
> I'm not sure how far we want to go there, but potentially specific server
> implementations could choose to be interoperable in a way that allows the
> handle encapsulation to either be smaller or no extra overhead. For example,
> if we implemented what I've thought about for Ganesha-Ganesha re-export,
> Ganesha COULD also be "taught" which portion of the knfsd handle is the
> filesystem/export identifier, and maintain a database of Ganesha
> export/filesystem <-> knfsd export/filesystem and have Ganesha
> re-encapsulate the exportfs/name_to_handle_at portion of the handle. Of
> course in this case, trivial migration isn't possible since Ganesha will
> have a different encapsulation than knfsd.
> 
> Incidentally, I also purposefully made Ganesha's encapsulation different so
> it never collides with either version of knfsd handles (now if over the
> course of the past 10 years another handle version has come along...).

I don't think anything's changed there.

--b.
