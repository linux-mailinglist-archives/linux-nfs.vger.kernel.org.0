Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A494C192F
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiBWQ6G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 11:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243084AbiBWQ57 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 11:57:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA99825E5;
        Wed, 23 Feb 2022 08:57:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FE76006F;
        Wed, 23 Feb 2022 16:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE159C340E7;
        Wed, 23 Feb 2022 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645635449;
        bh=F2OZITzbPLjglp+oG3kfzs+cx9PZX0CEj4yGVLb5+do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfusfLeTlhVEvrTrfhIPLapiFJ/Sq4KD8Gv9SpX81LYxhFBVAGqMZC88Nt4YdcP5Y
         jO/M8r+C6tUPy/wkrxQh6zwDZBU5TJoOSigGrbwMlFWdv3Oq4wfJbM06Ayyav+piRu
         I8WVPs6SD7TeykGpFwgCf/cxAHJr8/ZOxhgMlyJkABchGuuajMN5cegfr/t30+gR2r
         oGfJIyrp5c/zp2zX1spqw6bGr69506Z9e1Gg3mhh6i22PG7sXS4O89LSOcRJou8GHf
         Wc2M5F/sUed5F0ZJarW/AU1Ti7aO2p1RlNKFdHqS3rnFgZ7iHiLHF/DvSgJkHWMq0n
         W68+FkQSdrlVA==
Date:   Wed, 23 Feb 2022 08:57:29 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/4] generic/578: Test that filefrag is supported before
 running
Message-ID: <20220223165729.GH8288@magnolia>
References: <20220208215232.491780-1-anna@kernel.org>
 <20220208215232.491780-4-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208215232.491780-4-anna@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 08, 2022 at 04:52:31PM -0500, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> NFS does not support FIBMAP/FIEMAP, so the check for non-shared extents
> on NFS v4.2 always fails with the message: "FIBMAP/FIEMAP unsupported".
> I added the _require_filefrag check for NFS and other filesystems that
> don't have FIEMAP or FIBMAP support.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  common/rc         | 14 ++++++++++++++
>  tests/generic/578 |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index b3289de985d8..73d17da9430e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4673,6 +4673,20 @@ _require_inode_limits()
>  	fi
>  }
>  
> +_require_filefrag()
> +{
> +	_require_command "$FILEFRAG_PROG" filefrag
> +
> +	local file="$TEST_DIR/filefrag_testfile"
> +
> +	echo "XX" > $file

Nit: You might want to rm -f $file before echoing into it, just in case
some future knave ;) sets up that pathname to point to a named pipe or
something that will hang fstests...

> +	${FILEFRAG_PROG} $file 2>&1 | grep -q "FIBMAP/FIEMAP[[:space:]]*unsupported"
> +	if [ $? -eq 0 ]; then

...and rm it again here to avoid leaving test files around.

Otherwise this looks ok to me.

--D

> +		_notrun "FIBMAP/FIEMAP not supported by this filesystem"
> +	fi
> +	rm -f $file
> +}
> +
>  _require_filefrag_options()
>  {
>  	_require_command "$FILEFRAG_PROG" filefrag
> diff --git a/tests/generic/578 b/tests/generic/578
> index 01929a280f8c..64c813032cf8 100755
> --- a/tests/generic/578
> +++ b/tests/generic/578
> @@ -23,7 +23,7 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs generic
>  _require_test_program "mmap-write-concurrent"
> -_require_command "$FILEFRAG_PROG" filefrag
> +_require_filefrag
>  _require_test_reflink
>  _require_cp_reflink
>  
> -- 
> 2.35.1
> 
