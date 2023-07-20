Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1275BB03
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 01:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjGTXPZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 19:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTXPY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 19:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6EA1724;
        Thu, 20 Jul 2023 16:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A87D61CB5;
        Thu, 20 Jul 2023 23:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEC6C433C7;
        Thu, 20 Jul 2023 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689894922;
        bh=t/+qowoP9CB/NKB2N4O3EAM8OzUyIX9DTycf5HiAHBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeHbslgHW6sXqTEk7BiCh+xudqNAZi7v34MkFxgoWqsTle0J/sgW1vtmjPvSKZsOE
         9mRlqVu7fvY1UJyRg9iT3DwlmMVO8N7JlyBXkKELWTWMmsEXmiKhGVTZptGhrpeCKt
         k/MHwS5X0DHQWNVshE2GqhzC4Von4+KllY/kInEt2wQPieNnupeLNL8ZVsHCSkdA8j
         t1QedT2LvCh8zbBhFC0Lq7Jq0bX1dF4RKxONMl89Zc+qXNtl6Mn6xeo3F7DrdY1Irr
         B2LsPhxJ7arDwC6ZSOQMFOgP+cg+RzR/3T84c4EM8OrTWdQCD7QgWakn8eiWU6kwRY
         ziXXeifN4o+xA==
Date:   Thu, 20 Jul 2023 19:15:19 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Boyang Xue <bxue@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] nfsd: sanely handle inabilty to fetch pre/post
 attributes
Message-ID: <ZLnAB8Nfy/hPBhFl@manet.1015granger.net>
References: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>
 <168988936713.11078.5407820394334916284@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168988936713.11078.5407820394334916284@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 21, 2023 at 07:42:47AM +1000, NeilBrown wrote:
> On Fri, 21 Jul 2023, Jeff Layton wrote:
> > Boyang reported tripping the BUG_ON in set_change_info. While we
> > couldn't confirm it, one way this could happen would be for nfsd_lookup
> > to succeed and then for fh_fill_both_attrs to fail.
> > 
> > This patchset attempts to (sanely) fix this, usually by aborting the
> > operation if fetching the pre attributes fails. Post-op attribute fetch
> > handling is more difficult to deal with however since we've already done
> > the operation, so this has it just fudge the change_info4 if that
> > occurs.
> 
> I think both v3 and v4 allow a reply that says "the operation was a
> success but there are no post-op attrs".  With v4 you can say "there is
> no change-attr, but here are some other attrs".  I think.

If the protocols enable NFSD to avoid returning made-up values, I'm
all for it.


> Our xdr-encoding doesn't make that easy, but it is just a "simple matter
> of coding".  If you think it is worth it.
> 
> NeilBrown
> 
> 
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Changes in v2:
> > - make fh_fill_*_attrs return an error and have the callers handle it
> > - rework of set_change_info, to better handle missing pre/post attrs
> > 
> > ---
> > Jeff Layton (2):
> >       nfsd: handle failure to collect pre/post-op attrs more sanely
> >       nfsd: remove unsafe BUG_ON from set_change_info
> > 
> >  fs/nfsd/nfs3proc.c |  4 +++-
> >  fs/nfsd/nfs4proc.c | 45 +++++++++++++++++++++++++++++++++------
> >  fs/nfsd/nfsfh.c    | 26 ++++++++++++++---------
> >  fs/nfsd/nfsfh.h    |  6 +++---
> >  fs/nfsd/vfs.c      | 62 ++++++++++++++++++++++++++++++++++--------------------
> >  fs/nfsd/xdr4.h     | 11 ----------
> >  6 files changed, 100 insertions(+), 54 deletions(-)
> > ---
> > base-commit: 070f391ca4d48e1750ee6108eb44f751a9e9448e
> > change-id: 20230720-bz2223560-9c4690a8217b
> > 
> > Best regards,
> > -- 
> > Jeff Layton <jlayton@kernel.org>
> > 
> > 
> 
