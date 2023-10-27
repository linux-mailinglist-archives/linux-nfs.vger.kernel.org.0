Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAA47D8E69
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 08:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJ0GFM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 02:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0GFL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 02:05:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8691A7;
        Thu, 26 Oct 2023 23:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oVbebL76c6pNB/fIpdsjTZraPC/lGT/ZH6e5WyTTbGc=; b=izdrcBPXER4dUIv+toGALj1awf
        G186Q6nv2yxki9Pa2jPQlfjIIQUqxFRMuaAkS64VBslZ+UXS3wUKNn4ik2WbLAIG9y94yfYB1G8mo
        GcygmEgelrnkuNmiw7sZiXpQ6KXpheSVT1AhU3SIh+ERI4AiPxg+2rZ4VgWxi3iEW/8Cbpxl8XVNY
        lREVOK8bhhcq5ZUqLrVBo9MSK0+vfVqgu1MJJ0cVUIrogbgpSz9P7v5qQPn2NUOvyC2kNm8DGPxWT
        GnjBW4rZPFZMcUSnpdRdOzhzr3fMjtIwXj0oCq0HTqTSioTqQ/Njzul+VT6etT11PyZtJ+S5WRm8H
        lijxp++Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwFxz-00FeMg-08;
        Fri, 27 Oct 2023 06:05:07 +0000
Date:   Thu, 26 Oct 2023 23:05:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] exportfs: define FILEID_INO64_GEN* file handle
 types
Message-ID: <ZTtTEw0VMJxoJFyA@infradead.org>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023180801.2953446-4-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 23, 2023 at 09:08:00PM +0300, Amir Goldstein wrote:
> Similar to the common FILEID_INO32* file handle types, define common
> FILEID_INO64* file handle types.
> 
> The type values of FILEID_INO64_GEN and FILEID_INO64_GEN_PARENT are the
> values returned by fuse and xfs for 64bit ino encoded file handle types.

Please actually switch xfs to fully use the helpers instead of
duplicating the logic.  Presumable the same for fuse, but for that
I'd need to look at how it works for fuse right now and if there's not
some subtle differences.

