Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA625DBB0
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 16:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgIDO32 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbgIDO30 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 10:29:26 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2742C061244
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 07:29:25 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 29A841509; Fri,  4 Sep 2020 10:29:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 29A841509
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599229763;
        bh=dACq62FidyFRq/zUdggvXMM2CjkxwYUNeCEWUJxn/Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qB37pzq63wtA7j2JxFESjsTRtZYwJzSbGXJJ0/a6GzppIZPjmWkXl6oEj9rRlpSjA
         yj7TCXLaIXkqGz4FX4b7+TzcWqYD8p11N3/yf23YyK8Lq9WE5W3s46jCLrDj7EiKgu
         j/cC9rwD62IyJP7RemRWPA83czNrfoZUqXrO7cvI=
Date:   Fri, 4 Sep 2020 10:29:23 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
Message-ID: <20200904142923.GE26706@fieldses.org>
References: <20200828212521.GA33226@pick.fieldses.org>
 <20200828215627.GB33226@pick.fieldses.org>
 <CAFX2Jfn3LN9Zc-=4mAm1mQ3k8PN6C1yF4xqh6B-yyXCxFnp7hQ@mail.gmail.com>
 <20200901164938.GC12082@fieldses.org>
 <CAFX2Jf=vmnfV_4=401=BFnmZJCOqfEWTQRPHzRHePpJrTCcb7w@mail.gmail.com>
 <20200901191854.GD12082@fieldses.org>
 <20200904135259.GB26706@fieldses.org>
 <00931C34-6C86-46A2-A3B3-9727DA5E739E@oracle.com>
 <20200904140324.GC26706@fieldses.org>
 <164C37D9-8044-4CF4-99A1-5FB722A16B8E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164C37D9-8044-4CF4-99A1-5FB722A16B8E@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 04, 2020 at 10:07:22AM -0400, Chuck Lever wrote:
> My primary concern is that the result of a file copy operation should
> look the same on NFS/TCP (with READ_PLUS) and NFS/RDMA (with SEEK_DATA/HOLE).

I'm not sure what you mean.

I don't see the spec providing any guarantee of consistency between
READ_PLUS and SEEK.  It also doesn't guarantee that the results tell you
anything about how the file is actually stored--a returned "hole" could
represent an unallocated segment, or a fully allocated segment that's
filled with zeroes, or some combination.

So, for example, if you implemented an optimized copy that used
ALLOCATE, DEALLOCATE, SEEK and/or READ_PLUS to avoid reading and writing
a lot of zeroes--there's no guarantee that the target file would end up
allocated in the same way as the source.

--b.
