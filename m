Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1831C531BA2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiEWUR6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 16:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiEWURz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 16:17:55 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F864B0D17
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 13:17:53 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 884015BD0; Mon, 23 May 2022 16:17:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 884015BD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1653337072;
        bh=LZjNK0QJZx0VwySuAQN+c/fv9SRXsDo1siBlZtPr5Y4=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=wed4/WjBcDf9m5s0RzrNvhl5floK1KDX4fNxwijOC+84pmP+pxHHjW7IAf3z/vQpg
         yL8xnOXHhbFwg8CPt2fzjPKtpz5t6Hxv4Vcf1SdjM2Z0trJfOUMqMk0OoXDnlwd6ci
         lLfURV7hg7OT8g/0mPLAiFKEKEFmB9BrJW/vBJ40=
Date:   Mon, 23 May 2022 16:17:52 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
Message-ID: <20220523201752.GI24163@fieldses.org>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
 <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
 <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
 <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
 <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
 <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
 <FF7F2939-C3DE-4584-BFFA-13B554706B9C@oracle.com>
 <f20de886f02402970c86c5195ea344de128afd91.camel@kernel.org>
 <9D7CE6C9-579D-4DF3-9425-4CE0099E75E0@oracle.com>
 <aed59b68ecbd312972fbcba0c369b39f6812fe2b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aed59b68ecbd312972fbcba0c369b39f6812fe2b.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 23, 2022 at 03:43:28PM -0400, Jeff Layton wrote:
> On Mon, 2022-05-23 at 19:35 +0000, Chuck Lever III wrote:
> > 
> > > On May 23, 2022, at 1:38 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > > 
> > > On Mon, 2022-05-23 at 17:25 +0000, Chuck Lever III wrote:
> > > > 
> > > > > On May 23, 2022, at 12:37 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > > > > 
> > > > > His suggestion was just to keep a counter in the lockowner of how many
> > > > > locks are associated with it. That seems like a good suggestion, though
> > > > > you'd probably need to add a parameter to lm_get_owner to indicate
> > > > > whether you were adding a new lock or just doing a conflock copy.
> > > > 
> > > > locks_copy_conflock() would need to take a boolean parameter
> > > > that callers would set when they actually manipulate a lock.
> > > > 
> > > 
> > > Yep. You'd also have to add a bool arg to lm_put_owner so that you know
> > > whether you need to decrement the counter.
> > 
> > It's the lm_put_owner() side that looks less than straightforward.
> > Suggestions and advice welcome there.
> > 
> 
> Maybe add a new fl_flags value that indicates that a particular lock is
> a conflock and not a lock record? Then locks_release_private could use
> that to pass the appropriate argument to lm_put_owner.
> 
> That's probably simpler overall than trying to audit all of the
> locks_free_lock callers.

Should conflock parameters really be represented by file_lock structures
at all?  It always seemed a little wrong to me.  But, that's a bit of
derail, apologies.

--b.
