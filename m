Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E15041E357
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Sep 2021 23:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbhI3V0u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Sep 2021 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344670AbhI3V0u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Sep 2021 17:26:50 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2AAC06176A
        for <linux-nfs@vger.kernel.org>; Thu, 30 Sep 2021 14:25:06 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 06F5D703E; Thu, 30 Sep 2021 17:25:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 06F5D703E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633037106;
        bh=PwgG3nAH3LSMg0GY5PStihFB7z3v6AsnXQU7wtFBEC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnDilpW51BBEILtkCI0M6FQ4tmrOejoUuHP+g+AGBA9obh4zTikUaJuTiKe3oPL5p
         bPx+n/knaZQFenA0iLSt+ZCkgYMjJifZc92FtCCBUOFvOU82ffbpFBHEDJl71jb01N
         DvvTp891LRUzmYT6pomlcH1HP8Sai0TEqkF3Jf1c=
Date:   Thu, 30 Sep 2021 17:25:06 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Volodymyr Khomenko <volodymyr@vastdata.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: GSSAPI fix for pynfs nfs4.1 client code
Message-ID: <20210930212506.GB16927@fieldses.org>
References: <CANkgwetkTUjj-bMrM4XTvk0vhGiJt3wNKPpRvzgTk-u7ZfrdXg@mail.gmail.com>
 <20210930211123.GA16927@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930211123.GA16927@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 30, 2021 at 05:11:23PM -0400, J. Bruce Fields wrote:
> On Thu, Sep 30, 2021 at 06:22:09PM +0300, Volodymyr Khomenko wrote:
> > commit b77dc49c775756f08bdd0c6ebbe67a96f0ffe41f
> > Author: Volodymyr Khomenko <volodymyr@vastdata.com>
> > Date:   Thu Sep 30 17:53:04 2021 +0300
> > 
> >     Fixed GSSContext to start sequence numbering from 1
> >     
> >     GSS sequence number 0 is usually used by NFS4 NULL request
> >     during GSS context establishment (but ignored by server).
> >     Client should never reuse GSS sequence number, so using
> >     0 for the next real operation (EXCHANGE_ID) is possible but
> >     looks suspicious. Fixed the code so numbering for operations
> >     is done from 1 to avoid confusion.
> 
> So, I can verify that --security=krb5 works after this patch but not
> before, good.  But why is that?  As you say, the server is supposed to
> ignore the sequence number on context creation requests.  And 0 is valid
> sequence number as far as I know.

Looking at the network--my server's not responding to the first data
message.

I think the Linux server just has a bug.  I'll make a patch....

--b.
