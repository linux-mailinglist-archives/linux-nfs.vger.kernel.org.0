Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3141E75D835
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jul 2023 02:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGVAeR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 20:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGVAeR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 20:34:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571AE35AC;
        Fri, 21 Jul 2023 17:34:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3A7421903;
        Sat, 22 Jul 2023 00:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689986048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSXC/2EX9oy7Zub+xfuyFakWJVtNoucQuw1q9yV6Xeg=;
        b=yLqNv1r4YqQh6E1WAEpOgBxySH8ndFJEDsEEEvrxVszfMMm1IMVEHQ2oTH9oV9kQv1WXdV
        uaD3dDScl+kh7d8DBptUah4MEpmnTl3oTBzI0Wb/13XFWtoiixZ2OL/MbAgRjRT7JiTo4/
        wABfVLd1kiFR5Tl/sGBaFv17sDpz/K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689986048;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSXC/2EX9oy7Zub+xfuyFakWJVtNoucQuw1q9yV6Xeg=;
        b=7ek051keFIYVAERfA+joxMZtS8Ghn+h7CZZXDKTAoCKKFkq5d247zVZX8Q/D93Un8XRe8i
        82hlJigUlfdR9pBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EDE4134B0;
        Sat, 22 Jul 2023 00:34:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iVrFMP0ju2SGDwAAMHmgww
        (envelope-from <neilb@suse.de>); Sat, 22 Jul 2023 00:34:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        "Boyang Xue" <bxue@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nfsd: sanely handle inabilty to fetch pre/post attributes
In-reply-to: <11c799a6cb0bf073dda77f592d70d809fca9b030.camel@kernel.org>
References: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>,
 <168988936713.11078.5407820394334916284@noble.neil.brown.name>,
 <11c799a6cb0bf073dda77f592d70d809fca9b030.camel@kernel.org>
Date:   Sat, 22 Jul 2023 10:34:01 +1000
Message-id: <168998604179.11078.18238251274062077853@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 21 Jul 2023, Jeff Layton wrote:
> On Fri, 2023-07-21 at 07:42 +1000, NeilBrown wrote:
> > 
> > I think both v3 and v4 allow a reply that says "the operation was a
> > success but there are no post-op attrs".  With v4 you can say "there is
> > no change-attr, but here are some other attrs".  I think.
> > 
> 
> v3 has this ability:
> 
>       union pre_op_attr switch (bool attributes_follow) {
>       case TRUE:
>            wcc_attr  attributes;
>       case FALSE:
>            void;
>       };
> 
> ...we can just set the attributes_follow flag to false there in that
> case.
> 
> That's not possible with v4, AFAICT. Several of the *4resok structures
> contain a change_info4, which just looks like this:
> 
> struct change_info4 {
>         bool            atomic;
>         changeid4       before;
>         changeid4       after;
> };

Yes...  I was thinking of GETATTR which reports a bitmap of all the
attributes that it can return.  Though I'm not sure if the server is
"allowed" to not return something that it has said is "supported".  And
I think changeid has to be "supported".  I'm not sure.

But anyway, that doesn't help change_info4 which comes with
directory-modifying operation.

> 
> We can set "atomic" to false (and this patch does that in this
> situation), but I don't believe there is any alternative to the change
> attribute. If the underlying fs doesn't support native change attrs, the
> server is expected to fake one up somehow (usually from the ctime).

I had a look again at the current code and your patch, and I think that
if the "post' vfs_getattr() fails, then the operation succeeds, the
change_info is marked non-atomic (as you say) and the "after" changeid is
set to an uninitialised value.  Is that right?  Did I miss something?
Maybe we should set it to the pre value plus 1.

It probably doesn't matter at all in practice, but if I'm right and it
is using an uninitialized value, we should at least fix that.

Thanks - your v3 patch looks good in general.  I like the must_check and
the goto structure.

Thanks,
NeilBrown


> 
> We could (in principle) allow the operation to proceed on v3 even if
> fh_fill_pre_attrs fails, but I don't think we can do the same thing with
> v4. That said, if getattr is failing then it's somewhat likely that
> other operations will fail too, so aborting the operation in this
> situation doesn't seem too onerous.
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

