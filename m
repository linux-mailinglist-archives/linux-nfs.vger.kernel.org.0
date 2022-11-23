Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A454F636714
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Nov 2022 18:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiKWR37 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Nov 2022 12:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiKWR3j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Nov 2022 12:29:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B28CFE3;
        Wed, 23 Nov 2022 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YevBAAtpcyC4KopXo8P+2Pmmv9IPImzfWIr+liZ80yE=; b=RXC1jgdcCJXoq+vGLY4+2wL2UC
        GjFpuDlW6ur89/+FLok/2SD5UQh8MccEKtEbkdrAe6h+7Uf54ifnfPfx5b2Lnk4HAR+JlcB8DvQYk
        Islk6CQZRGw54vQlKkKBzjTl6MkoCizS+9lFgRbm9QibAIdgH25/PTAbPshF6q/j3WwJCBhSM7ejV
        Y8nbja0W3WFmf3TAfZypIfVYkhRH4WkFshJlhcEbgAZXgh7M4GWklfQqxCYYK26xetT5by4LqoLJL
        gjcdC4dYYmk0bEZoQG4xGRX0r3PVOp8kg5+QMi4L2xoMh3emOZc6kueUeqI8ya0i5vOZebIcaFgiD
        33Z+ZccA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oxtYl-006FZ3-2Q;
        Wed, 23 Nov 2022 17:29:19 +0000
Date:   Wed, 23 Nov 2022 17:29:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Anders Blomdell <anders.blomdell@control.lth.se>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: Kernel 6.0.5 breaks virtual machines that boot from nfs mounted
 qcow2 images
Message-ID: <Y35YbwZP7w4xEf4Z@ZenIV>
References: <65115206-ec17-443e-8495-91661a2fd9be@control.lth.se>
 <0abaa41e-79e1-3c0c-6d1b-47d4e21f2296@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0abaa41e-79e1-3c0c-6d1b-47d4e21f2296@control.lth.se>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 23, 2022 at 11:08:42AM +0100, Anders Blomdell wrote:
> Our problems turned out to be a fallout of Al Viros's splice rework, where nfsd reads with non-zero offsets and not ending
> on a page boundary failed to remap the last page. I belive that this is a decent fix for that problem (tested on v6.1-rc6,
> 6.0.7 and 6.0.9)
> 
> ---- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -873,7 +873,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
>         unsigned offset = buf->offset;
>         page += offset / PAGE_SIZE;
> -       for (int i = sd->len; i > 0; i -= PAGE_SIZE)
> +       for (int i = sd->len + offset % PAGE_SIZE; i > 0; i -= PAGE_SIZE)
>                 svc_rqst_replace_page(rqstp, page++);

Hmm...  A minor nit:
	last_page = page + (offset + sd->len - 1) / PAGE_SIZE;
	for (page += offset / PAGE_SIZE; page <= last_page; page++)
		svc_rqst_replace_page(rqstp, page);
might be easier to follow.  Matter of taste, though...
