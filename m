Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427E24865E7
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 15:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbiAFOQa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 09:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiAFOQ3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 09:16:29 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A70C061245
        for <linux-nfs@vger.kernel.org>; Thu,  6 Jan 2022 06:16:29 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id D100E7250; Thu,  6 Jan 2022 09:16:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D100E7250
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641478588;
        bh=lE3KJ8vIHxZtbza8cYz/Z33gOJ5BZYkSnwOoi6gEYLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWbvuz4FfVu4VG9LBLnBOD6Y/YCgbBkjKpW1V1AAMAM4AJoXyfe1bExNxFOB7QYZ8
         sbRBEL18I75+qgvSx5c8JRpgsb653nNlSAkcrmVP4zWERC9S90NWfqa13vOWDEPH/c
         9ekSofUp1z+wkEOdz5vM18Vb8Z58fyglz5npHaHA=
Date:   Thu, 6 Jan 2022 09:16:28 -0500
From:   "'bfields@fieldses.org'" <bfields@fieldses.org>
To:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
Cc:     'Trond Myklebust' <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'neilb@suse.de'" <neilb@suse.de>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: Re: client caching and locks
Message-ID: <20220106141628.GA7105@fieldses.org>
References: <20201006172607.GA32640@fieldses.org>
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>
 <20220103162041.GC21514@fieldses.org>
 <OSZPR01MB7050F9737016E8E3F0FD5255EF4A9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
 <20220104153205.GA7815@fieldses.org>
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>
 <OSZPR01MB7050C5098D47514FFEC2DA82EF4B9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
 <20220105220353.GF25384@fieldses.org>
 <OSZPR01MB7050BC53F1F38FAA579E03B3EF4C9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSZPR01MB7050BC53F1F38FAA579E03B3EF4C9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 06, 2022 at 07:23:16AM +0000, inoguchi.yuki@fujitsu.com wrote:
> > How about this?  I also updated the lock/nolock description and deleted
> > the end of this subsection since it's redundant with that. And removed
> > the bit about using nolock to mount /var with v2/v3 as that seems like a
> > bit of a niche case at this point.  If we still want to document that, I
> > think it belongs elsewhere.
> 
> Thank you so much for creating the patch!
> 
> For the most part I agree with you, but I feel unsafe to remove the part 
> "using nolock to mount /var with v2/v3" even if it seems niche case. 
> I'm also not sure if there is another suitable document to migrate it. 
> 
> Therefore, at the end of "lock/nolock" subsection ...

I could live with that.

Though the other reason I cut it was because I think it needs updates
too and I wasn't sure exactly how to handle them.

The v4 case is more important and should probably be dealt with first.
I think the answer there is just "don't mount /var over NFSv4", period.

And maybe we should be more specific: the problem is with /var/lib/nfs,
not all of /var.

--b.

> 
> > @@ -733,16 +733,9 @@ but such locks provide exclusion only against other
> > applications
> >  running on the same client.
> >  Remote applications are not affected by these locks.
> >  .IP
> > -NLM locking must be disabled with the
> > -.B nolock
> > -option when using NFS to mount
> > -.I /var
> > -because
> > -.I /var
> > -contains files used by the NLM implementation on Linux.
> > -Using the
> > +The
> >  .B nolock
> > -option is also required when mounting exports on NFS servers
> > +option is required when using NFSv2 or NFSv3 to mount servers
> >  that do not support the NLM protocol.
> >  .TP 1.5i
> >  .BR cto " / " nocto
> 
> ... can we keep the description like this ?
> -----
> @@ -733,17 +733,14 @@ but such locks provide exclusion only against other applications
>  running on the same client.
>  Remote applications are not affected by these locks.
>  .IP
> -NLM locking must be disabled with the
> +When using NFSv2 or NFSv3, the
>  .B nolock
> -option when using NFS to mount
> -.I /var
> -because
> +option is required to mount servers that do not support the NLM protocol,
> +or to mount
>  .I /var
> +because
> +.I /var
>  contains files used by the NLM implementation on Linux.
> -Using the
> -.B nolock
> -option is also required when mounting exports on NFS servers
> -that do not support the NLM protocol.
>  .TP 1.5i
>  .BR cto " / " nocto
>  Selects whether to use close-to-open cache coherence semantics.
> -----
> Yuki Inoguchi
