Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C3C7DB808
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 11:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjJ3K0u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjJ3K0t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 06:26:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77379E9
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 03:26:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24C1C433C9;
        Mon, 30 Oct 2023 10:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698661606;
        bh=rte+A2K+jSbcRVbrS+ysowBb49Lei6vykxyi/1K95rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2M5rcvD98Btw6RcRgLl0pn8fNDURzyD9pustad0LTQHhVplKi9UqZH+5CtnaKt/1
         eQtpJFfeXw4NqmBANWsgkHBmpZBSt6DRgCoHmVJVE7HEsZPkeIXzGzNuJAww0EO0PP
         oGrGa1x4sNnWtUuNAvGYCWJyRxwvWCrCifCSkE2alV5thrHTHUkOMbMcda/rh6Q8we
         t72Yk+TJ4LnAtpkt3QZQ6qctOEG9xGp55vKgJezXzraKJvBIj2MAOK5Yb1F7xHIcya
         GPdKC7dAyESPHqWEGAkK8XvKew1VhgdE7NYJMOUpCRl68ALMATl6jJvOnWWkQ+5fSD
         DTE2/IeyMmcPQ==
Date:   Mon, 30 Oct 2023 11:26:37 +0100
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
Message-ID: <20231030-zuhalten-faktor-e22dccde22cf@brauner>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-3-amir73il@gmail.com>
 <ZTtSrfBgioyrbWDH@infradead.org>
 <CAOQ4uxj_T9+0yTN1nFX+yzFUyLqeeO5n2mpKORf_NKf3Da8j-Q@mail.gmail.com>
 <CAOQ4uxgeCAi77biCVLQR6iHQT1TAWjWAhJv5_y6i=nWVbdhAWA@mail.gmail.com>
 <20231028-zonen-gasbetrieben-47ed8e61adb0@brauner>
 <CAOQ4uxh3y1s90d9=Ap2s1BknVpHig7tVX58-=zn=1Ui8WcPqDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh3y1s90d9=Ap2s1BknVpHig7tVX58-=zn=1Ui8WcPqDw@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> > Done, please check in vfs.f_fsid and yell if something is wrong.
> 
> I see no changes.
> Maybe you have forgotten to push the branch??

I fixed it all up on Saturday but then didn't push until this morning.
