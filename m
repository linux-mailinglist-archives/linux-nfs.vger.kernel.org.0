Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094E041B7B1
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Sep 2021 21:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbhI1TlG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Sep 2021 15:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbhI1TlF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Sep 2021 15:41:05 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE49C061745
        for <linux-nfs@vger.kernel.org>; Tue, 28 Sep 2021 12:39:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C804B7046; Tue, 28 Sep 2021 15:39:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C804B7046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632857965;
        bh=qQIF1+G7reyihn9iejdL9eHhe7ZJMz8UO+d5NoYRlmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmPJ1LuvoaLeo3Tcb/SZbQW6ziCXZoDYlX4OkxNFkYyyYurDREZAnN9qm8elsOkp7
         RfFu4poFvC/ECoBbxqeWtORvnCAgBG1gYM6WK9UKr2ZKEdWv9QlQWzYCF5J3Ku54Yn
         yrIY1vMZMVM43/YteSkM9nvD7s5+LzBHgdFjbh3o=
Date:   Tue, 28 Sep 2021 15:39:25 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Salvatore Bonaccorso <bonaccos@ee.ethz.ch>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: nfsd4_process_open2 failed to open newly-created file!
 status=10008 ; warning at fs/nfsd/nfs4proc.c for nfsd4_open
Message-ID: <20210928193925.GH25415@fieldses.org>
References: <20210927061025.GA20892@varda.ee.ethz.ch>
 <20210927155338.GA30593@fieldses.org>
 <cd38d56c6824ac6776df838dfd66bccd@ee.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd38d56c6824ac6776df838dfd66bccd@ee.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 28, 2021 at 07:11:41AM +0200, Salvatore Bonaccorso wrote:
> Hi Bruce,
> 
> On 27.09.2021 17:53, J. Bruce Fields wrote:
> >On Mon, Sep 27, 2021 at 08:10:31AM +0200, Salvatore Bonaccorso wrote:
> >>We recently got the following traces on a NFS server, but I'm not sure
> >>how to further debug this, any hints?
> >
> >The server creates and opens a file in two steps, though it should
> >really be a single atomic operation.
> >
> >That means there's a small possibility somebody could intervene and do
> >something like change the permissions:
> >
> >>
> >>[5746893.904448] ------------[ cut here ]------------
> >>[5746893.910050] nfsd4_process_open2 failed to open
> >>newly-created file! status=10008
> >
> >10008 is NFS4ERR_DELAY, so maybe somebody managed to get a delegation
> >before we finished opening?
> >
> >We should be able to prevent that....
> >
> >In your setup are there processes quickly opening new files created by
> >others?
> 
> This is very possible. The NFS server is used as a "scratch" place
> accessible from
> compute cluster where people can have multiple jobs simultaneously
> running through
> Slurm and accessing the data. So it is possible that user create new
> files from
> one running instance and accessing it quickly from the other nodes.
> 
> I'm so far was unable to arificially trigger the issue but is there
> anything I
> can try out to get more information useful for you?

I think the problem's pretty obvious.  I'm not sure what the fix should
be.

You can work around it for now by turning off delegations (echo 0
>/proc/sys/fs/leases_enable before starting nfsd).

--b.
