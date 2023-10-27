Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDEC7D8E65
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 08:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjJ0GDg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 02:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GDf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 02:03:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870F41A7;
        Thu, 26 Oct 2023 23:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NLbGPcvkczQ3j5pZtH5UcuT+QHH7Vu/3J6gRRU85itI=; b=hq39YTN1A2iFBaVtfbiotTW1Tx
        65uV8op85xWcd5AJj/UI16k6KidLDMjRqy8hmm5noz0LZS0JB2Wm58T6QVmau38L33X2csTuSeUlR
        4j4CBybj0SeMClgw2JAdcRCFke40Dz86NXDGoRhCaayjhwXHqWNlCrcGAFWRCpiSZnR5muIHAVUl8
        Hdbl+xVXc5Xcbvr5HegoGGx7e820Rl42wqH/BCL6xODX+VmQ1ge5jyGBriUNbdUnNAxM4HbeLUCP6
        JsT4ER1Pni8ieL1hFZdSJjFLIrE+X0SwRNe1ht8sWmhClvsgmARMxMIlOXIpose9qNJziCtvEtlrA
        F3NlR93g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwFwL-00FeFr-0O;
        Fri, 27 Oct 2023 06:03:25 +0000
Date:   Thu, 26 Oct 2023 23:03:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
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
Message-ID: <ZTtSrfBgioyrbWDH@infradead.org>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023180801.2953446-3-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 23, 2023 at 09:07:59PM +0300, Amir Goldstein wrote:
> export_operations ->encode_fh() no longer has a default implementation to
> encode FILEID_INO32_GEN* file handles.

This statement reads like a factual statement about the current tree.
I'd suggest rewording it to make clear that you are changing the
behavior so that the defaul goes away, and I'd also suggest to move
it after the next paragraph.
