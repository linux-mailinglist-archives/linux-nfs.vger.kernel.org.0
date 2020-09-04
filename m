Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7025DFC3
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIDQ0S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIDQ0S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 12:26:18 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3E4C061244
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 09:26:17 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 504DC5FF1; Fri,  4 Sep 2020 12:26:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 504DC5FF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599236776;
        bh=JmgpJNw0ml8XLo3w54o/4NPZc5CBdILaLAkLo2y4K10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0ajR51hX5WnrzIjtWK81BnbZ7a/h/9Ia/SWSHZb1vPQEgTXfUAX86eRf2czzh3PT
         m2TYw8GwXAJXr/iEkhUx8mpqLwKl1DF3ce38ErViHUW25pp3Ws8HEM9Mh2LLSQPUta
         F5uTZBNL4jql0s51H7pE08N5VSS9pmm2QAth9d8A=
Date:   Fri, 4 Sep 2020 12:26:16 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
Message-ID: <20200904162616.GB2158@fieldses.org>
References: <20200904135259.GB26706@fieldses.org>
 <00931C34-6C86-46A2-A3B3-9727DA5E739E@oracle.com>
 <20200904140324.GC26706@fieldses.org>
 <164C37D9-8044-4CF4-99A1-5FB722A16B8E@oracle.com>
 <20200904142923.GE26706@fieldses.org>
 <C73640A5-E374-46D7-9F35-EF34B17E4F3C@oracle.com>
 <20200904144932.GA349848@pick.fieldses.org>
 <45DCF35D-A919-4A99-9B6D-0952ED0A78E5@oracle.com>
 <20200904152429.GA1738@fieldses.org>
 <A11FE08B-0AF7-42BB-9456-2D8ECC1D5B71@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A11FE08B-0AF7-42BB-9456-2D8ECC1D5B71@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 04, 2020 at 12:17:29PM -0400, Chuck Lever wrote:
> 
> 
> > On Sep 4, 2020, at 11:24 AM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > I'm not seeing the RDMA connection, by the way.  SEEK and READ_PLUS
> > should work the same over TCP and RDMA.
> 
> The READ_PLUS result is not DDP-eligible because there's no way for
> the client to predict in advance whether there will be data (which
> can be moved by RDMA), holes or patterns (which cannot), nor how
> many of each there might be.
> 
> Therefore I've asked Anna to leave READ_PLUS disabled on RDMA mounts.

Oh, of course, makes sense.

I think we should leave ourselves the options of handling some of these
unlikely corner cases differently in the two cases, but I wouldn't
expect that to cause a noticeable difference in any normal use.

--b.
