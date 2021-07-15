Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64173CAF85
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jul 2021 01:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhGOXLf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 19:11:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48232 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhGOXL3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 19:11:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 987432031D;
        Thu, 15 Jul 2021 23:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626390514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ve8ErLhX1f+100lLvDLhv/pIh4svJ8cQRMH6eGKkCVc=;
        b=W7+YWau6NX8iVZLJYrW0B5dh1J0pOC9r1oGl0PQlhymAh0p4Bw4zbrCUoR3NX0jc6kdrmp
        Z2Mdj1HgoLCwp5QwF7G4XL4GrJM9tGH/wJ3Lb6GvfcO8+DRG7oXm3gOVovTZAiOA6cLFxy
        14WLXd/J+GFA88JC+Up+9nwrvxYacOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626390514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ve8ErLhX1f+100lLvDLhv/pIh4svJ8cQRMH6eGKkCVc=;
        b=Bux2qrgiOgxGtLJ/L6bS80wg62raaM88jPOETmfTMmo8VkWOouJiQvE6jzgVlWGYGnckrX
        +kEwGEwA/uO7+MCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F24B13C4B;
        Thu, 15 Jul 2021 23:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vcJrCO+/8GCWaAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 15 Jul 2021 23:08:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "David Sterba" <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Ulli Horlacher" <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
In-reply-to: <20210715154534.GA24492@fieldses.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>,
 <20210310074620.GA2158@tik.uni-stuttgart.de>,
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>,
 <20210715154534.GA24492@fieldses.org>
Date:   Fri, 16 Jul 2021 09:08:27 +1000
Message-id: <162639050750.13764.15083673238872288080@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 16 Jul 2021, J. Bruce Fields wrote:
> On Thu, Jul 15, 2021 at 02:37:52PM +1000, NeilBrown wrote:
> > To fix this, we need to report a different fsid for each subvolume, but
> > need to use the same fsid that we currently use for the top-level
> > volume.  Changing this (by rebooting a server to new code), might
> > confuse the client.  I don't think it would be a major problem (stale
> > filehandles shouldn't happen), but it is best avoided.
> ...
> > Again, we really want an API to get this from the filesystem.  Changing
> > it later has no cost, so we don't need any commitment from the btrfs team
> > that this is what they will provide if/when we do get such an API.
> 
> "No cost" makes me a little nervous, are we sure nobody will notice the
> mountd-on-fileid changing?

One cannot be 100% sure, but I cannot see how anything would depend on
it being stable.  Certainly the kernel doesn't.
'ls -i' doesn't report it - even as "ls -if".  "find -inum xx" cannot see
it.
Obviously readdir() will see it but if any application put much weight
on the number, it could already get confused when btrfs returns
non-unique numbers as I mentioned.  
I certainly wouldn't lose sleep over changing it.

NeilBrown

> 
> Fileid and fsid changes I'd worry about more, though I wouldn't rule it
> out if that'd stand in the way of a bug fix.
> 
> Thanks for looking into this.
> 
> --b.
> 
> 
