Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FFA7D8FE4
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 09:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJ0HcN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 03:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJ0HcM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 03:32:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681CB1AC;
        Fri, 27 Oct 2023 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XUhRTa+EsGph2BWAVH5/gahdxEY1XjevoZ+UMDgxahc=; b=QalpgjWKNZB5f8GyX3gE5UCa1X
        seQTj9WSb67Gq8qsg7gG0ujIzvU7i1GTBkqPjjB9u6E292tnZ1vJVAnBIvJ+bLM+T6722rNdeJb7N
        +OVtkrfrOrN0CGpw5ldaz+WNm8eGEeUAGW1782z1wFHM/ZwLIEigKLnzzQP2XNYehXMMFf3WKbQ2n
        TrEUvM99GYxY3kzar28K+dTurUYc5+6KwrsNx2axsxQHJwkqC96OfOxcGlEJZ7VvXvTsSmN8N3X65
        zFaCdEq1AU9zpEumAndvLCsqwMTCBH4jiRqzhoWBBBId65KYzQGB01dNKroYiEyQ3XMzJxYPWYylv
        sMdxOQ4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwHKB-00FnxS-1i;
        Fri, 27 Oct 2023 07:32:07 +0000
Date:   Fri, 27 Oct 2023 00:32:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] exportfs: define FILEID_INO64_GEN* file handle
 types
Message-ID: <ZTtnd6Lis8azPirM@infradead.org>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-4-amir73il@gmail.com>
 <ZTtTEw0VMJxoJFyA@infradead.org>
 <CAOQ4uxj_R1KyYJqBXykCDUYZUEdXC3x0j1vZdOXsRcSb6dKaRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj_R1KyYJqBXykCDUYZUEdXC3x0j1vZdOXsRcSb6dKaRg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 27, 2023 at 09:43:01AM +0300, Amir Goldstein wrote:
> > Presumable the same for fuse, but for that
> > I'd need to look at how it works for fuse right now and if there's not
> > some subtle differences.
> >
> 
> There are subtle differences:
> 1. fuse encodes an internal nodeid - not i_ino
> 2. fuse encodes the inode number as [low32,high32]
> 
> It cannot use the generic helper.

That's what I almost feared.  It still should use the common symbolic
name for the format just to make everyones life simpler.
