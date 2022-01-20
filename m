Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43169494C27
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jan 2022 11:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiATKvy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jan 2022 05:51:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56012 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiATKvj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jan 2022 05:51:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 875191F394;
        Thu, 20 Jan 2022 10:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642675897;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKfa9SFXl6MJ0kJcGesxG+9HhPslYZsN3J7f9633m10=;
        b=QPC6kEcYhKJhXsr6aHHC+BypzjpFqxR3IglWvoQ0iO513s31HLy6eOx14yShBLAYczOly7
        EbI4fwCQeQkYQFWopq6pF/ahTuBz0LTtGyaUZdC4puf12yhgBavA6DXujcQ+MD2lVwMkIh
        CwQIoSNxzPDsHtGEwAO2mjsSE9wVPkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642675897;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKfa9SFXl6MJ0kJcGesxG+9HhPslYZsN3J7f9633m10=;
        b=KM/S48DqyD3MH/vsfNSQzGrKpDGKrUWwXQDME4+jZFXrSvZVBfseYQiFQmkBIAzvxxSrp8
        1+kMOeSrkifMS0DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5549213E46;
        Thu, 20 Jan 2022 10:51:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hpQ7E7k+6WFqMgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 20 Jan 2022 10:51:37 +0000
Date:   Thu, 20 Jan 2022 11:51:35 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        Yong Sun <yosun@suse.com>
Subject: Re: pynfs: [NFS 4.0] SEC7, LOCK24 test failures
Message-ID: <Yek+t754lmv5lCQI@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <YLY9pKu38lEWaXxE@pevik>
 <YLZS1iMJR59n4hue@pick.fieldses.org>
 <164248153844.24166.16775550865302060652@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164248153844.24166.16775550865302060652@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

> On Wed, 02 Jun 2021, J. Bruce Fields wrote:
> > On Tue, Jun 01, 2021 at 04:01:08PM +0200, Petr Vorel wrote:

> > > LOCK24   st_lock.testOpenUpgradeLock                              : FAILURE
> > >            OP_LOCK should return NFS4_OK, instead got
> > >            NFS4ERR_BAD_SEQID

> > I suspect the server's actually OK here, but I need to look more
> > closely.

> I agree.
> I think this patch fixes the test.

> NeilBrown

> From: NeilBrown <neilb@suse.de>
> Date: Tue, 18 Jan 2022 15:50:37 +1100
> Subject: [PATCH] Fix NFSv4.0 LOCK24 test

> Only the first lock request for a given open-owner can use lock_file.
> Subsequent lock request must use relock_file.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Thanks!

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  nfs4.0/servertests/st_lock.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

> diff --git a/nfs4.0/servertests/st_lock.py b/nfs4.0/servertests/st_lock.py
> index 468672403ffe..db08fbeedac4 100644
> --- a/nfs4.0/servertests/st_lock.py
> +++ b/nfs4.0/servertests/st_lock.py
> @@ -886,6 +886,7 @@ class open_sequence:
>          self.client = client
>          self.owner = owner
>          self.lockowner = lockowner
> +        self.lockseq = 0
>      def open(self, access):
>          self.fh, self.stateid = self.client.create_confirm(self.owner,
>  						access=access,
> @@ -899,15 +900,21 @@ class open_sequence:
>      def close(self):
>          self.client.close_file(self.owner, self.fh, self.stateid)
>      def lock(self, type):
> -        res = self.client.lock_file(self.owner, self.fh, self.stateid,
> -                    type=type, lockowner=self.lockowner)
> +        if self.lockseq == 0:
> +            res = self.client.lock_file(self.owner, self.fh, self.stateid,
> +                                        type=type, lockowner=self.lockowner)
> +        else:
> +            res = self.client.relock_file(self.lockseq, self.fh, self.lockstateid,
> +                                        type=type)
>          check(res)
>          if res.status == NFS4_OK:
>              self.lockstateid = res.lockid
> +            self.lockseq = self.lockseq + 1
I'd just: self.lockseq += 1
(supported even on python 2.x)

>      def unlock(self):
>          res = self.client.unlock_file(1, self.fh, self.lockstateid)
>          if res.status == NFS4_OK:
>              self.lockstateid = res.lockid
> +            self.lockseq = self.lockseq + 1
And here.


Kind regards,
Petr

>  def testOpenUpgradeLock(t, env):
>      """Try open, lock, open, downgrade, close
