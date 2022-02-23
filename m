Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869FE4C1924
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbiBWQy5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 11:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiBWQyz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 11:54:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980E234679;
        Wed, 23 Feb 2022 08:54:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3612660EE8;
        Wed, 23 Feb 2022 16:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE37C340E7;
        Wed, 23 Feb 2022 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645635266;
        bh=fRt6ngPHr4dSfvKDSZaXi7eaExmontbrmd22ISaBEd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAgGz2tFZK+WZ0b3t4Lv3NDsUf6BRrfqyjWdCyoApRuIQi70WgKJT/05vECbCgMic
         VUNKw2aq210h7lZQyt8J12CDq7V2xXEzyQsbzVrgRs6uG457MUw3oWQCHkLATHt3iI
         Q5rOljeo5RKg9P4pP5Q9sb8ztXsHlQT/V4B3kp5dv4fuvZSPG13V0uz1q5TzylFYi8
         x+J3O5UWBJGMDRbERxw/YdjT26TewWA/TgPds0NGo2aM2eWq5zy1VQxpaohwvugmxi
         fMw3Mn/ewOUU5lgGJbgB4wzQe8tZPO2K7hoXpcHqxcOhZTAf4+FLH8yKxFGYtQbug4
         JV/yzQpfC2Cug==
Date:   Wed, 23 Feb 2022 08:54:26 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/4] generic/531: Move test from 'quick' group to 'stress'
Message-ID: <20220223165426.GG8288@magnolia>
References: <20220208215232.491780-1-anna@kernel.org>
 <20220208215232.491780-3-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208215232.491780-3-anna@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 08, 2022 at 04:52:30PM -0500, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> The comment up top says this is a stress test, so at the very least it
> should be added to this group. As for removing it from the quick group,
> making this test variable on the number of CPUs means this test could
> take a very long time to finish (I'm unsure exactly how long on NFS v4.1
> because I usually kill it after a half hour or so)
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> I have thought of two alternatives to this patch that would work for me:
>   1) Could we add an _unsupported_fs function which is the opposite of
>      _supported_fs to prevent tests from running on specific filesystems?
>   2) Would it be okay to check if $FSTYP == "nfs" when setting nr_cpus,
>      and set it to 1 instead? Perhaps through a function in common/rc
>      that other tests can use if they scale work based on cpu-count?

How about we create a function to estimate fs threading scalability?
There are probably (simple) filesystems out there with a Big Filesystem
Lock that won't benefit from more CPUs pounding on it...

# Estimate how many writer threads we should start to stress test this
# type of filesystem.
_estimate_threading_factor() {
	case "$FSTYP" in
	"nfs")
		echo 1;;
	*)
		echo $((2 * $(getconf _NPROCESSORS_ONLN) ));;
	esac
}

and later:

nr_cpus=$(_estimate_threading_factor)

Once something like this is landed, we can customize for each FSTYP.  I
suspect that XFS on spinning rust might actually want "2" here, not
nr_cpus*2, given the sporadic complaints about this test taking much
longer for a few people.

> ---
>  tests/generic/531 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/531 b/tests/generic/531
> index 5e84ca977b44..62e3cac92423 100755
> --- a/tests/generic/531
> +++ b/tests/generic/531
> @@ -12,7 +12,7 @@
>  # Use every CPU possible to stress the filesystem.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick unlink
> +_begin_fstest auto stress unlink

As for this change itself,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


>  testfile=$TEST_DIR/$seq.txt
>  
>  # Import common functions.
> -- 
> 2.35.1
> 
