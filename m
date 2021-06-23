Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26F83B23EF
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 01:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWXb0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 19:31:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39866 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWXb0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 19:31:26 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3840C2196A;
        Wed, 23 Jun 2021 23:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624490947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TDk4MJHAr8cX9w59gaSzhS7by5hlWpd6ewiFXFe3OU=;
        b=Pk8WijZBqqWaJnmQ8J9fp/1w3wYapyU0cBpcd8ooFnSD2qviSNADPWvozy4+CgDNDlWSWB
        xst5Crsm9ZGrIkM0pFzb2Qi7QX9kqHae+HArBeF0JvmW/MHI6S0wEi5lb3Uq6M5zaPCz1K
        qvsnXg1TbL+EWbcxWYU+L9fxJRQYS9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624490947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TDk4MJHAr8cX9w59gaSzhS7by5hlWpd6ewiFXFe3OU=;
        b=mnd/pdj//Z91IxGE2hsQFVqpfs/wLt23dT7FT7Xv6xllqfzalCIoPwUTy47zMXZZ/fovMK
        5uoX1Uo5UsMSsACg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id DFBDC11A97;
        Wed, 23 Jun 2021 23:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624490947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TDk4MJHAr8cX9w59gaSzhS7by5hlWpd6ewiFXFe3OU=;
        b=Pk8WijZBqqWaJnmQ8J9fp/1w3wYapyU0cBpcd8ooFnSD2qviSNADPWvozy4+CgDNDlWSWB
        xst5Crsm9ZGrIkM0pFzb2Qi7QX9kqHae+HArBeF0JvmW/MHI6S0wEi5lb3Uq6M5zaPCz1K
        qvsnXg1TbL+EWbcxWYU+L9fxJRQYS9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624490947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TDk4MJHAr8cX9w59gaSzhS7by5hlWpd6ewiFXFe3OU=;
        b=mnd/pdj//Z91IxGE2hsQFVqpfs/wLt23dT7FT7Xv6xllqfzalCIoPwUTy47zMXZZ/fovMK
        5uoX1Uo5UsMSsACg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id g3mxI8HD02DWUQAALh3uQQ
        (envelope-from <neilb@suse.de>); Wed, 23 Jun 2021 23:29:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Wang Yugui" <wangyugui@e16-tech.com>, linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <20210623222559.GI20232@fieldses.org>
References: <162432531379.17441.15110145423567943074@noble.neil.brown.name>,
 <20210622112253.DAEE.409509F4@e16-tech.com>,
 <20210622151407.C002.409509F4@e16-tech.com>,
 <162440994038.28671.7338874000115610814@noble.neil.brown.name>,
 <20210623153548.GF20232@fieldses.org>,
 <162448589701.28671.8402117125966499268@noble.neil.brown.name>,
 <20210623222559.GI20232@fieldses.org>
Date:   Thu, 24 Jun 2021 09:29:01 +1000
Message-id: <162449094105.28671.17150162627927917482@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 24 Jun 2021, J. Bruce Fields wrote:
> On Thu, Jun 24, 2021 at 08:04:57AM +1000, NeilBrown wrote:
> > On Thu, 24 Jun 2021, J. Bruce Fields wrote:
> 
> One other thing I'm not sure about: how do cold cache lookups of
> filehandles for (possibly not-yet-mounted) subvolumes work?

Ahhhh...  that's a good point.  Filehandle lookup depends on the target
filesystem being mounted.  NFS exporting filesystems which are
auto-mounted on demand would be ... interesting.

That argues in favour of nfsd treating a btrfs filesystem as a single
filesystem and gaining some knowledge about different subvolumes within
a filesystem.

This has implications for NFS re-export.  If a filehandle is received
for an NFS filesystem that needs to be automounted, I expect it would
fail.

Or do we want to introduce a third level in the filehandle: filesystem,
subvol, inode.  So just the "filesystem" is used to look things up in
/proc/mounts, but "filesystem+subvol" is used to determine the fsid.

Maybe another way to state this is that the filesystem could identify a
number of bytes from the fs-local part of the filehandle that should be
mixed in to the fsid.  That might be a reasonably clean interface.

> 
> > All we really need is:
> > 1/ someone to write the code
> > 2/ someone to review the code
> > 3/ someone to accept the code
> 
> Hah.  Still, the special exceptions for btrfs seem to be accumulating.
> I wonder if that's happening outside nfs as well.

I have some colleagues who work on btrfs and based on my occasional
discussions, I think that: yes, btrfs is a bit "special".  There are a
number of corner-cases where it doesn't quite behave how one would hope.
This is probably inevitable given they way it is pushing the boundaries
of functionality.  It can be a challenge to determine if that "hope" is
actually reasonable, and to figure out a good solution that meets the
need cleanly without imposing performance burdens elsewhere.

NeilBrown
