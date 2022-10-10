Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF91D5FA0B3
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Oct 2022 16:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJJO4s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Oct 2022 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJJO43 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Oct 2022 10:56:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A8074CD5
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tWNv+XnhPuQn1XgzzrVulGQFEtbR6OyT4JppMuYKiQw=; b=eZBc+HpmcXRD111FNIdfAWNvju
        46p9gu/QtXygXPlcqIdmVLL2d4uyUhRBhBH3UsKFtRs1ATyX7rBL5xvrUniGPZDXcb7SMo70eHHeM
        BZ8HYA24fkAaNACq6sGJremKkQ1xqVimLXyr0aYf0H2YHUktzDUnJs0N1Kl8LrhWFtG3T1VG4xKHj
        KUOCbtqk6hIvJ3vQ3RjKhk/ruGSXWe1UtQFSS2lgp/fqCuPqi0ovqvMXeeOkZerl7gzBA4Me/oIQe
        mftil8RYHLlBACagMOpCXp+XgzV9VdPa2OEc+Oh6+7ElDmK2VWIFgK9VtPOVSfQD1rdlhBJEcWdpQ
        REFxA0Ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohuBl-001Gre-PS; Mon, 10 Oct 2022 14:55:29 +0000
Date:   Mon, 10 Oct 2022 07:55:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guillaume Nault <gnault@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH v2] sunrpc: Use GFP_NOFS to prevent use of
 current->task_frag.
Message-ID: <Y0QyYV1Wyo4vof70@infradead.org>
References: <de6d99321d1dcaa2ad456b92b3680aa77c07a747.1665401788.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6d99321d1dcaa2ad456b92b3680aa77c07a747.1665401788.git.gnault@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 10, 2022 at 01:41:57PM +0200, Guillaume Nault wrote:
> However, ->sk_allocation isn't used just by the memory allocator.
> In particular, sk_page_frag() uses it to figure out if it can return
> the page_frag from current or if it has to use the socket one.

Well, that just means sk_page_frag really needs to look at
PF_MEMALLOC_* as well.  So instead of reverting the proper change
please fix that.  A helper that looks at sk_allocation and
current->flags is probably the right way to deal with that.
