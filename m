Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F470E89C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 May 2023 00:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjEWWES (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 18:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbjEWWER (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 18:04:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C471BD
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 15:03:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D194C1FD6F;
        Tue, 23 May 2023 22:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684879432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eGOAP/MIWcs1Sz4S6So5wSJZfjFGT3JEy3/iwdOeWo=;
        b=xxtefjmJC0kAMxGxQN0AOxbugpqWnNBMnZLUGuRjXcBKdVKRSdc1S78UxnEpkRmtnfjIHG
        AcR5eFiapWFf8Hu1XSJRLywHzSjCDDwit3tSDzfrKZzrOWSBJ9JBG+Rh74DRD6qd6CH5qp
        MNQ27uIuYdEiTOCT0TbXfDAn7/xElsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684879432;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eGOAP/MIWcs1Sz4S6So5wSJZfjFGT3JEy3/iwdOeWo=;
        b=VwH4katuQjLr7kx8lisX7yTkfitwvQV9HvTyRBhYNghKElAMJoqQ/j/9MFYBNqr8GQDnA+
        aNelwdaKAMz5GyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AA0F13A10;
        Tue, 23 May 2023 22:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vasqD0c4bWSOEgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 May 2023 22:03:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr fails
In-reply-to: <143D2797-B071-43FF-AA85-E4C4A7218691@oracle.com>
References: <20230519111723.20612-1-jlayton@kernel.org>,
 <168471866230.5298.3283829268036917998@noble.neil.brown.name>,
 <143D2797-B071-43FF-AA85-E4C4A7218691@oracle.com>
Date:   Wed, 24 May 2023 08:03:48 +1000
Message-id: <168487942834.21808.17784288972950301860@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 23 May 2023, Chuck Lever III wrote:
> 
> > On May 21, 2023, at 9:24 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Fri, 19 May 2023, Jeff Layton wrote:
> >> nfsd calls fh_getattr to get the latest inode attrs for pre/post-op
> >> info. In the event that fh_getattr fails, it resorts to scraping cached
> >> values out of the inode directly.
> >> 
> >> Since these attributes are optional, we can just skip providing them
> >> altogether when this happens.
> >> 
> >> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >> ---
> >> fs/nfsd/nfsfh.c | 26 +++++++-------------------
> >> 1 file changed, 7 insertions(+), 19 deletions(-)
> >> 
> >> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> >> index ccd8485fee04..e8e13ae72e3c 100644
> >> --- a/fs/nfsd/nfsfh.c
> >> +++ b/fs/nfsd/nfsfh.c
> >> @@ -623,16 +623,9 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> >> 
> >> inode = d_inode(fhp->fh_dentry);
> >> err = fh_getattr(fhp, &stat);
> >> - if (err) {
> >> - /* Grab the times from inode anyway */
> >> - stat.mtime = inode->i_mtime;
> >> - stat.ctime = inode->i_ctime;
> >> - stat.size  = inode->i_size;
> >> - if (v4 && IS_I_VERSION(inode)) {
> >> - stat.change_cookie = inode_query_iversion(inode);
> >> - stat.result_mask |= STATX_CHANGE_COOKIE;
> >> - }
> >> - }
> >> + if (err)
> >> + return;
> >> +
> > 
> > I wondered if this might exercise error paths which had not previously
> > been tested.  Before this change fh_pre_saved is always set, now it is
> > not.
> > 
> > The code looks OK, but I was amused by xdr_stream_encode_item_absent().
> > Various places in the code test for "< 0" or "> 0" which seems to
> > suggest that "0" is not being handled consistently.
> 
> You can read those as "returns positive" and "returns negative" tests.

That leaves the curious reader, who isn't completely familiar with the
code, wondering what "0" would mean.
It's not a big deal, but it looked odd so I thought I would mention it.

> 
> 
> > But of course xdr_stream_encode_item_absent() can never return 0.  It
> > returns either XDR_UNIT or -EMSGSIZE.
> 
> I don't see any tests for it returning exactly zero.
> 
> 
> > I wonder if we should be consistent in how we test for an error ....  or
> > if it it really matters.
> 
> The xdr_stream_encode_* functions conventionally return a negative errno
> or a positive number of bytes encoded. The "< 0" and "> 0" tests convert
> that return value into a boolean.
> 
> I reviewed the call sites just now and do not see an evident problem.
> 
> 
> > Patch itself looks good.
> 
> May I add "Reviewed-by: Neil Brown <neilb@suse.de <mailto:neilb@suse.de>>" ?

Yes please. (though maybe without the "mailto:" :-)

NeilBrown
