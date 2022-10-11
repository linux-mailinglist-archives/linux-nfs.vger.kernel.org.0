Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ADE5FAC7D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 08:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJKGSp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJKGSa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 02:18:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3191287F9A
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 23:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SDS0smZvOqwyP3wjoXD24/KXAf+DoPR5kwswdgy+J38=; b=xpKS1EEbSbs8KcIPz3wBBm124s
        JUr5sdGgqcJSIhcUKknLW9+KccbjBQVzsJyemObB5n4xWOwJYV8qbF0WKifErWgXVuY4TXxx60nVS
        ia4bMXeKKNLl+JfInVXx4vO1BFkYvZtT0EsfwcfhSb0Xj2YF0MnzqZbNwbcyQdNiHzMO3nBQ6ZiWC
        GfWObLvRD1OpPAQkOTZptneXe3cVOPAspoxntqGm0xq5PJvmygP00CBJxm50SOEwKBSfHnVGXl7y/
        z3qFRVdoFsZlYgbes3AusqnHAXpTB8GLu5FtgQ2U915sDSkDEx0PrcIQHxIo5Nfe15PF8lUDKN6Eb
        76YTVyYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oi8ap-003OjD-Fa; Tue, 11 Oct 2022 06:18:19 +0000
Date:   Mon, 10 Oct 2022 23:18:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guillaume Nault <gnault@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH v2] sunrpc: Use GFP_NOFS to prevent use of
 current->task_frag.
Message-ID: <Y0UKq62ByUGNQpuY@infradead.org>
References: <de6d99321d1dcaa2ad456b92b3680aa77c07a747.1665401788.git.gnault@redhat.com>
 <Y0QyYV1Wyo4vof70@infradead.org>
 <20221010165650.GA3456@ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010165650.GA3456@ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 10, 2022 at 06:56:50PM +0200, Guillaume Nault wrote:
> That's what my RFC patch did. It was rejected because reading
> current->flags may incur a cache miss thus slowing down TCP fast path.
> See the discussion in the Link tag:
> https://lore.kernel.org/netdev/b4d8cb09c913d3e34f853736f3f5628abfd7f4b6.1656699567.git.gnault@redhat.com/

As GFP_NOFS/NOIO are on their way out the networking people will have to
do this anyway.
