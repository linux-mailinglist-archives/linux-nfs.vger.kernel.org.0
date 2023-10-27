Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A65E7D8E75
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 08:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJ0GJD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 02:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0GJC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 02:09:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1B9D;
        Thu, 26 Oct 2023 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9BtbDR3n54FvA+75JkgaZTEYqfXfxJPeXWsx0MsF3sk=; b=oMkSPEHQHa2n/JzmZo8lLDQg4e
        5FtnsmIdMbM6VfM3OSSAtvKAnk+hmFapfymQnYBJVU9P4ZMO13TZcHOGvUP+K8Olp3qWzHzP5UVXX
        ef7mHFQbGN14pQKhIL+fSSG1FzRLLksc549xsYPjPGmAfK/I9Ve5NYVR/lmmkwd3OFnyoMlAr64Wq
        JI/eBy25n/HqcOgP07r33VKtk2miK5NOzTI6zgEzk7hvJ0apuwgY7zNYn0HMU/aK1v/SdMtHPJ4T6
        GFCpFDMr0GelgjHD6H4qVA0J7sREaiDUuTc81DowQKEVzZSGRfNl/p9WWGmARoTzSZoVl809zLuzB
        SM1CVotQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwG1j-00FefK-1A;
        Fri, 27 Oct 2023 06:08:59 +0000
Date:   Thu, 26 Oct 2023 23:08:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: create an entry for exportfs
Message-ID: <ZTtT+8Hudc7HTSQt@infradead.org>
References: <20231026205553.143556-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026205553.143556-1-amir73il@gmail.com>
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

On Thu, Oct 26, 2023 at 11:55:53PM +0300, Amir Goldstein wrote:
> Split the exportfs entry from the nfsd entry and add myself as reviewer.

I think exportfs is by now very much VFS code.

