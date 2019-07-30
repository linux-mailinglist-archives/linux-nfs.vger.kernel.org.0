Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8B7B550
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 23:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfG3Vy3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 17:54:29 -0400
Received: from fieldses.org ([173.255.197.46]:41846 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387860AbfG3Vy3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Jul 2019 17:54:29 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id BA921ABE; Tue, 30 Jul 2019 17:54:28 -0400 (EDT)
Date:   Tue, 30 Jul 2019 17:54:28 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] nfsd: add principal to the data being tracked by
 nfsdcld
Message-ID: <20190730215428.GB3544@fieldses.org>
References: <20190730210847.9804-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730210847.9804-1-smayhew@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 30, 2019 at 05:08:45PM -0400, Scott Mayhew wrote:
> At the spring bakeathon, Chuck suggested that we should store the
> kerberos principal in addition to the client id string in nfsdcld.  The
> idea is to prevent an illegitimate client from reclaiming another
> client's opens by supplying that client's id string.  This is an initial
> attempt at doing that.

Great to see this, thanks!

> Initially I had played with the idea of hanging a version number off
> either the cld_net or nfsd_net structure, exposing that via a proc file,
> and having the userspace daemon write the desired version number to the
> proc file prior to opening the rpc_pipefs file.  That was potentially
> problematic if nfsd was already trying to queue an upcall using a
> version that nfscld didn't support... so I like the GetVersion upcall
> idea better.

Sounds OK to me.

It queries the version once on nfsd startup and sticks with that
version.  We allow rpc.mountd to be restarted while nfsd is running.  So
the one case I think it wouldn't handle is the case where somebody
downgrades mountd while nfsd is running.

My feeling is that handling that case would be way too much trouble, so
actually I'm going to consider that a plus.  But it might be worth
documenting (if only in a patch changelog).

> The second patch actually adds the v2 message, which adds the principal
> (actually just the first 1024 bytes) to the Cld_Create upcall and to the 
> Cld_GraceStart downcall (which is what loads the data in the
> reclaim_str_hashtbl). I couldn't really figure out what the maximum length
> of a kerberos principal actually is (looking at krb5.h the length field in
> the struct krb5_data is an unsigned int, so I guess it can be pretty big).
> I don't think the principal will be that large in practice, and even if
> it is the first 1024 bytes should be sufficient for our purposes.

How does it fail when principals are longer?  Does it error out, or
treat two principals as equal if they agree in the first 1024 bytes?

--b.
