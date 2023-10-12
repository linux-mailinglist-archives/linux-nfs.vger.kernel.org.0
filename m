Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC17C6489
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 07:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377068AbjJLFSQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 01:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376996AbjJLFSO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 01:18:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E590;
        Wed, 11 Oct 2023 22:18:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D19BC433C7;
        Thu, 12 Oct 2023 05:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697087892;
        bh=X2EgHL3bP9Z/d24NMKCsDm1I5GcM24gx9PTUqoTwRcw=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=IM2Miui2wjqBg+35Y0cnpAfmvMhAbJP4euW8uYDawMrUzn52++iNi+x+lyWFr8ru+
         qKhJfozH87vDqthqM5EPznTuF0x5ajxxknOUbVR673mym/TK9QVN2ClTE4VbuGPyVq
         YyupIaWfGxZsIkQAl6DNF/VOcU6M4CVfQ4TOAzK78AYqvURCQ8UrWqhL6ryFVPss9O
         JKh4tB0pKPM5Ac2DkVwtY2vLZil4i9ztWVxy9NJi/iDzdth67EXRLNZHkKIClQEE8d
         iEw5OKDk2sMtUMvwRrUMVeyeZYrk1Shamj7KGlrZdB1En5IeffyTGWY51LKUst4tvP
         6OY2xZDPETYoA==
References: <20230929-xfs-iversion-v1-1-38587d7b5a52@kernel.org>
 <b4136500fe6c49ee689dba139ce25824684719f2.camel@kernel.org>
 <20231011154938.GL21298@frogsfrogsfrogs>
 <e0599593fcff0eca5c8287b8d09631b5fcb3a7e4.camel@kernel.org>
 <20231011191200.GA21277@frogsfrogsfrogs>
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandanbabu@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org
Subject: Re: [PATCH] xfs: reinstate the old i_version counter as
 STATX_CHANGE_COOKIE
Date:   Thu, 12 Oct 2023 10:17:44 +0530
In-reply-to: <20231011191200.GA21277@frogsfrogsfrogs>
Message-ID: <874jiwa06p.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 11, 2023 at 12:12:00 PM -0700, Darrick J. Wong wrote:
> On Wed, Oct 11, 2023 at 11:51:08AM -0400, Jeff Layton wrote:
>> On Wed, 2023-10-11 at 08:49 -0700, Darrick J. Wong wrote:
>> > On Wed, Oct 11, 2023 at 09:09:38AM -0400, Jeff Layton wrote:
>> > > On Fri, 2023-09-29 at 14:43 -0400, Jeff Layton wrote:
>> > > > The handling of STATX_CHANGE_COOKIE was moved into generic_fillattr in
>> > > > commit 0d72b92883c6 (fs: pass the request_mask to generic_fillattr), but
>> > > > we didn't account for the fact that xfs doesn't call generic_fillattr at
>> > > > all.
>> > > > 
>> > > > Make XFS report its i_version as the STATX_CHANGE_COOKIE.
>> > > > 
>> > > > Fixes: 0d72b92883c6 (fs: pass the request_mask to generic_fillattr)
>> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > > > ---
>> > > > I had hoped to fix this in a better way with the multigrain patches, but
>> > > > it's taking longer than expected (if it even pans out at this point).
>> > > > 
>> > > > Until then, make sure we use XFS's i_version as the STATX_CHANGE_COOKIE,
>> > > > even if it's bumped due to atime updates. Too many invalidations is
>> > > > preferable to not enough.
>> > > > ---
>> > > >  fs/xfs/xfs_iops.c | 5 +++++
>> > > >  1 file changed, 5 insertions(+)
>> > > > 
>> > > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>> > > > index 1c1e6171209d..2b3b05c28e9e 100644
>> > > > --- a/fs/xfs/xfs_iops.c
>> > > > +++ b/fs/xfs/xfs_iops.c
>> > > > @@ -584,6 +584,11 @@ xfs_vn_getattr(
>> > > >  		}
>> > > >  	}
>> > > >  
>> > > > +	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
>> > > > +		stat->change_cookie = inode_query_iversion(inode);
>> > > > +		stat->result_mask |= STATX_CHANGE_COOKIE;
>> > > > +	}
>> > > > +
>> > > >  	/*
>> > > >  	 * Note: If you add another clause to set an attribute flag, please
>> > > >  	 * update attributes_mask below.
>> > > > 
>> > > > ---
>> > > > base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
>> > > > change-id: 20230929-xfs-iversion-819fa2c18591
>> > > > 
>> > > > Best regards,
>> > > 
>> > > Ping?
>> > > 
>> > > This patch is needed in v6.6 to prevent a regression when serving XFS
>> > > via NFSD. I'd prefer this go in via the xfs tree, but let me know if
>> > > you need me to get this merged this via a different one.
>> > 
>> > Oh!   Right, this is needed because the "hide a state in the high bit of
>> > tv_nsec" stuff got reverted in -rc3, correct?  So now nfsd needs some
>> > way to know that something changed in the file, and better to have too
>> > many client invalidations than not enough?  And I guess bumping
>> > i_version will keep nfsd sane for now?
>> > 
>> > If the answers are [yes, yes, yes] then:
>> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>> 
>> Yes, yes, and yes. Can you guys shepherd this into mainline?
>
> Chandan, can you queue this (and the other xfs fixes I sent) for -rc6?
>

I have pulled in your fixes and also the current patch. I will have to execute
fstests for atleast one day before updating xfs-linux's for-next branch.

-- 
Chandan
