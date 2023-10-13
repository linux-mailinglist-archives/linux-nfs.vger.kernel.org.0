Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348147C8C48
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMR2X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJMR2W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 13:28:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC10A9;
        Fri, 13 Oct 2023 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Imrv7hD55Mkc+SEoB4XVFrWjYvya+wwXsMRtGt0H5rA=; b=LfICwqNBIzNu3ioIqF7lzF8PE1
        DNNDcUO+WN6s+RP2OMkJT/qU5k3RBo3ANrYkhAsydqGKT4ioL2RtakBCc/WjI9nTOwQif69iGoPrM
        LIItLhrydjykR5FjKmttU+4/HwxH3uPMKcW4OygWjeOzbFRQPkvG/O43/t6okeN2/i09crXEZFKzi
        k8D4OvY2OQU2yIehhAKYO9ouGdyvJ4MFCcMfiy3X2M3RigM5HJi6BJl951Sd53Ypx8tChN8KFZLHk
        lxrVWGWMbWdDCC0v6yBYd6sAPv/6oLJTbIGWhm8cJL7F7vnRHhJQBHkL0w7AwREstcKxvFjdi2A5A
        So6VZ8xg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qrLwx-006d2F-Oz; Fri, 13 Oct 2023 17:27:47 +0000
Date:   Fri, 13 Oct 2023 18:27:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Steve French <smfrench@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [RFC PATCH 12/53] netfs: Provide tools to create a buffer in an
 xarray
Message-ID: <ZSl+Ezh3Av3LLyEf@casper.infradead.org>
References: <20231013160423.2218093-1-dhowells@redhat.com>
 <20231013160423.2218093-13-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013160423.2218093-13-dhowells@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 13, 2023 at 05:03:41PM +0100, David Howells wrote:
> +int netfs_xa_store_and_mark(struct xarray *xa, unsigned long index,
> +			    struct folio *folio, bool put_mark,
> +			    bool pagecache_mark, gfp_t gfp_mask);

Linus has been unhappy recently with functions that take two bools.
When you're reading the caller, you see:

	netfs_xa_store_and_mark(xa, index, true, false, GFP_FOO);

and you don't know instantly what true and false mean.  He prefers

#define NETFS_FLAG_PUT		(1 << 0)
#define NETFS_FLAG_PAGECACHE	(1 << 1)

and then the caller looks like:

	netfs_xa_store_and_mark(xa, index, NETFS_FLAG_PUT, GFP_FOO);

and you know exactly what it's doing.

