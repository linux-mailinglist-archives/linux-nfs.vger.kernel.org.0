Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1796F1D24
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346229AbjD1RDr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346436AbjD1RDf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 13:03:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A24A4EE2
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 10:03:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34F6921F99;
        Fri, 28 Apr 2023 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682701400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=duqkXDQT6vCgcBPcLRSqqPs8Y5m0pBlhoyWC7x8UENQ=;
        b=PPD1/2wsbqe2WOXLPqodXtsQ3+rGpluLREqRU7LxBgFYgvifQB2u6/UVG8TVjCJQiJvaSB
        EexdCtXzQmlMFhfEy7P/1Fg5c+M9uJTlRGb+UTRXX7ADuaSYnDd/p5UuR4txLgFHqHWMMd
        c5xryRHJyUXXs8F+/IZdTtJOM4QIyr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682701400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=duqkXDQT6vCgcBPcLRSqqPs8Y5m0pBlhoyWC7x8UENQ=;
        b=g9pZ1q0c8/tj+19OyO5P6H0GIAU1kVCx6C24KtgPmdAozNf2UGdQgFruBOHR1euuJglpan
        j8lokVjIBYzGgqBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E20AF1390E;
        Fri, 28 Apr 2023 17:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TuGqNFf8S2THDAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 28 Apr 2023 17:03:19 +0000
Date:   Fri, 28 Apr 2023 19:03:30 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     NeilBrown <neilb@suse.de>, Cyril Hrubis <chrubis@suse.cz>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/4] nfs05.sh: Lower down the default values
Message-ID: <20230428170330.GA3536627@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230428160038.3534905-1-pvorel@suse.cz>
 <20230428160038.3534905-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428160038.3534905-4-pvorel@suse.cz>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

> nfs05_make_tree.c runs make which needs on Btrfs quite a lot of
> temporary space. This is a preparation for the next commit which
> start using all filesystems via TST_ALL_FILESYSTEMS=1. Currently we use
> 300 MB, which was not enough for Btrfs:

Also, based on this detection we could add support for tst_device acquire SIZE
into tst_test.sh to support more than the default 300 MB (as we see the actual
use is obviously less for some filesystems). This would need to check size with
tst_fs_has_free.

Even we don't add this feature, it'd be more friendly to check for space
before creating the loop device:

if ! tst_fs_has_free $TST_TMPDIR 300MB; then
	tst_brkm TCONF "Insufficient disk space to create a backing file for loop device"
fi

To be honest, I'd like to merge this patchset first, the rest can wait after the
release.

Kind regards,
Petr

> Filesystem     Type      Size  Used Avail Use% Mounted on
> /dev/loop0     btrfs     300M   62M   20K 100% /tmp/LTP_nfs05.Vau10kcszO/mntpoint

> After lowering the default values 96% (58M) is being used.

> Proper solution would be to detect available size in nfs05_make_tree.c
> and lower down values based on free space.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v4.

>  testcases/network/nfs/nfs_stress/nfs05.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/testcases/network/nfs/nfs_stress/nfs05.sh b/testcases/network/nfs/nfs_stress/nfs05.sh
> index c18ef1ab4..34151b67a 100755
> --- a/testcases/network/nfs/nfs_stress/nfs05.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs05.sh
> @@ -8,8 +8,8 @@

>  # Created by: Robbie Williamson (robbiew@us.ibm.com)

> -DIR_NUM=${DIR_NUM:-"10"}
> -FILE_NUM=${FILE_NUM:-"30"}
> +DIR_NUM=${DIR_NUM:-"8"}
> +FILE_NUM=${FILE_NUM:-"28"}
>  THREAD_NUM=${THREAD_NUM:-"8"}
>  TST_NEEDS_CMDS="make gcc"
>  TST_TESTFUNC="do_test"
