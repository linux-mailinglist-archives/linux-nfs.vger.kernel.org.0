Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A475779BA
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 05:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiGRDVu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Jul 2022 23:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGRDVu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Jul 2022 23:21:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CD110FC4
        for <linux-nfs@vger.kernel.org>; Sun, 17 Jul 2022 20:21:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECF553399C;
        Mon, 18 Jul 2022 03:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658114506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=798hgegU7Pgev28UDU7W/+ikbeFdPUq5dnJVjLGQz7A=;
        b=dCAKnTd3SD9nwA983jiI3OKnGLf9KU6oRT/gNoFmqg1e1aUrJAc9+/PyrP1wUb7XDUcXJ2
        woPj6cIWusaJBxiup8hXfXKCmUKo+e7//awRbW7kdxtsZIUlFtWbB54z9SByPLI/RGdJ0R
        vmC6vROnBOWXTLv50hRwE8ow7sE8IGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658114506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=798hgegU7Pgev28UDU7W/+ikbeFdPUq5dnJVjLGQz7A=;
        b=hy2PfENmxl2IFiUiWMTjitoORygxj374DgtyjhUpGE3PsUzdh8AL+2FFIoROy+Fgs0FT8I
        E1/FMIgyDB+EAxBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C48EF13A83;
        Mon, 18 Jul 2022 03:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KNWyHsnR1GJcJQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 18 Jul 2022 03:21:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd: close potential race between open and delegation
In-reply-to: <c10b61cd59a940dd93f6977300ab0d3c6742320f.camel@kernel.org>
References: <20220714200434.161818-1-jlayton@kernel.org>,
 <165784314214.25184.13511971308364755291@noble.neil.brown.name>,
 <c10b61cd59a940dd93f6977300ab0d3c6742320f.camel@kernel.org>
Date:   Mon, 18 Jul 2022 13:21:42 +1000
Message-id: <165811450205.25184.16800980627192339653@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 15 Jul 2022, Jeff Layton wrote:
> On Fri, 2022-07-15 at 09:59 +1000, NeilBrown wrote:
> 
> > however...
> > 2/ Do we really need to lock the parent?  If a rename or unlink happens
> >    after the lease was taken, the lease will be broken. So
> >     take lease.
> >     repeat lookup (locklessly)
> >     Check if lease has been broken
> >    Should provide all you need.
> > 
> >    You don't *need* to lock the directory to open an existing file and
> >    with my pending parallel-updates patch set, you only need a shared
> >    lock on the directory to create a file.  So I'd rather not be locking
> >    the directory at all to get a delegation
> > 
> 
> Yeah, we probably don't need to lock the dir. That said, after your
> patch series we already hold the i_rwsem on the parent at this point so
> lookup_one_len is fine in this instance.

But the only reason we hold i_rwsem at this point is to prevent renames
in the "opened existing file" case.  The "created new file" case holds
it as well just be be consistent with the first case.

If we "vet" the dentry, then we don't need the lock any more.  We can
then simplify nfsd_lookup_dentry() to always assume the dir is not
locked - so the "locked" arg can go, and nfsd_lookup() can lose the
"lock" arg and always return with the directory unlocked.

I'm tempted to add your patch to the front of my series.  The
inconsistency in locking can be fix by unlocking the directory before we
get even close to handing out a delegation - so the delegation never
sees a locked directory.
But right now I have a cold and don't trust myself to think clearly
enough to create code worth posting.  Hopefully I'll be thinking more
clearly later in the week.

While I'm here ...  is "vet" a good word?  The meaning is appropriate,
but I wonder if it would cause our friends for whom English isn't their
first language to stumble.  There are about 5 uses in the kernel at
present.

Would validate or verify be better?  Even though they are longer..

Thanks,
NeilBrown
