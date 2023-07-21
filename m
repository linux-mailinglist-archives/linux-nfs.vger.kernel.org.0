Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A076575D00A
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGUQwk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGUQwj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 12:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F9D1FD2;
        Fri, 21 Jul 2023 09:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EF3661D5A;
        Fri, 21 Jul 2023 16:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38989C433C9;
        Fri, 21 Jul 2023 16:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689958357;
        bh=PR089C6S00Ete/sGrEJmC9XiseG8/b3K/mww8qxTnSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kP/BSn8+yu8CcxDLvf8TvsdbIkge98fxX8x2XDhndcl2bZNx1CZHm/XH2gzKQricX
         Kd2/j6i8bMHaRqQw3aKZzoSLVE1qeCqCcjTRX7i0ajjEaPZj/W0sWsgSljfpm1Z33p
         RzNjiJktQHTHuut5nW94py7BSmR4PVrV/gAD2oVtfVu9HjIkgryKRU2IJ82fUsH00X
         XvOodi5/wkZByFnsW6cBhoUI9fGbU7uzM6+qkzCTRg2+gZYJQHMClcbMjq29OK4iVb
         Z849gYpGUAPiJBZWXU9ng3PByaTiNINN16uB8WDMj2ryYzZ5YfZtQL/dAiTw06ZRiK
         QTr+TUrsAZ+Yw==
Date:   Fri, 21 Jul 2023 12:52:35 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boyang Xue <bxue@redhat.com>
Subject: Re: [PATCH v3 0/2] nfsd: sanely handle inabilty to fetch pre/post
 attributes
Message-ID: <ZLq303cWOen+tkk5@manet.1015granger.net>
References: <20230721-bz2223560-v3-0-bb57e302bab7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721-bz2223560-v3-0-bb57e302bab7@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 21, 2023 at 10:29:09AM -0400, Jeff Layton wrote:
> Boyang reported tripping the BUG_ON in set_change_info. While we
> couldn't confirm it, one way this could happen would be for nfsd_lookup
> to succeed and then for fh_fill_both_attrs to fail.
> 
> This patchset attempts to (sanely) fix this, usually by aborting the
> operation if fetching the pre attributes fails. Post-op attribute fetch
> handling is more difficult to deal with however since we've already done
> the operation, so this has it just fudge the change_info4 if that
> occurs.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Applied v3 to nfsd-next. Thanks!


> ---
> Changes in v2:
> - rework the error paths to consistently use gotos
> - add __must_check to fh_fill_pre_attrs and fh_fill_both_attrs
> - fix bad error handling in setxattr codepath
> 
> ---
> Jeff Layton (2):
>       nfsd: handle failure to collect pre/post-op attrs more sanely
>       nfsd: remove unsafe BUG_ON from set_change_info
> 
>  fs/nfsd/nfs3proc.c |  4 +++-
>  fs/nfsd/nfs4proc.c | 46 ++++++++++++++++++++++++++++++++++++++++------
>  fs/nfsd/nfsfh.c    | 26 ++++++++++++++++----------
>  fs/nfsd/nfsfh.h    |  6 +++---
>  fs/nfsd/vfs.c      | 52 +++++++++++++++++++++++++++++++++++-----------------
>  fs/nfsd/xdr4.h     | 11 -----------
>  6 files changed, 97 insertions(+), 48 deletions(-)
> ---
> base-commit: c9194156c1039499533303fc63a66b0f1399896b
> change-id: 20230720-bz2223560-9c4690a8217b
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
