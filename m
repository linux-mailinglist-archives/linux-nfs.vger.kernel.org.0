Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FE17DA784
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Oct 2023 16:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjJ1ORB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Oct 2023 10:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJ1ORA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 Oct 2023 10:17:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCF9C1
        for <linux-nfs@vger.kernel.org>; Sat, 28 Oct 2023 07:16:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B24C433C7;
        Sat, 28 Oct 2023 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698502618;
        bh=LMluMM37x5/WCOZzNMoon8iPuNJBI0Msy/UMZwDezlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLxKN153rAa33+bumUre1oWn7p7aVbr5X+6QVmF8Z9hIiIbvgm7ww6QzuZpFYSfdo
         ZTfjFp8OHp3bVrlXdo2sW6pV1JllNmAPVzVA3lO3LWZPwrI2kkWkgWUTAf/cyaO53m
         TPMKBhFFGopV/S0l8QbP3mS57zK4chJVkEHm5OeVo7xxYFq+8DSciz/x9lTkkmNvxs
         7SSzOopVqDDPdrUQhfCnfuyojuVesgUD3RRx87z3EuDRPFhyXpk3J6NJ8hF/Yp70p7
         uFBzLNXSqBV+uR1msGkotV2MBiyq8sk0ltyrmhsVYTN1GGETpnJ9oSm2zamMSe1OxS
         iOa5P5xZezyjA==
Date:   Sat, 28 Oct 2023 16:16:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Steve French <sfrench@samba.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Evgeniy Dushistov <dushistov@mail.ru>
Subject: Re: [PATCH v2 2/4] exportfs: make ->encode_fh() a mandatory method
 for NFS export
Message-ID: <20231028-zonen-gasbetrieben-47ed8e61adb0@brauner>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-3-amir73il@gmail.com>
 <ZTtSrfBgioyrbWDH@infradead.org>
 <CAOQ4uxj_T9+0yTN1nFX+yzFUyLqeeO5n2mpKORf_NKf3Da8j-Q@mail.gmail.com>
 <CAOQ4uxgeCAi77biCVLQR6iHQT1TAWjWAhJv5_y6i=nWVbdhAWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgeCAi77biCVLQR6iHQT1TAWjWAhJv5_y6i=nWVbdhAWA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Actually, Christian, since you already picked up the build fix and
> MAINTAINERS patch, cloud I bother you to fixup the commit
> message of this patch according to Christoph's request:
> 
>     exportfs: make ->encode_fh() a mandatory method for NFS export
> 
>     Rename the default helper for encoding FILEID_INO32_GEN* file handles
>     to generic_encode_ino32_fh() and convert the filesystems that used the
>     default implementation to use the generic helper explicitly.
> 
>     After this change, exportfs_encode_inode_fh() no longer has a default
>     implementation to encode FILEID_INO32_GEN* file handles.
> 
>     This is a step towards allowing filesystems to encode non-decodeable file
>     handles for fanotify without having to implement any export_operations.
> 
> 
> Might as well add hch RVB on patch #1 while at it.

Done, please check in vfs.f_fsid and yell if something is wrong.
