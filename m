Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F85924A87F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Aug 2020 23:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSV3c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Aug 2020 17:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHSV32 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Aug 2020 17:29:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831A2C061757
        for <linux-nfs@vger.kernel.org>; Wed, 19 Aug 2020 14:29:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 47E0BABC; Wed, 19 Aug 2020 17:29:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 47E0BABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1597872567;
        bh=noGlcyS5AanYkmVkc3pkjb5mhjeMFZbTKz7J8Fj1gaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qL0wn+4aGKT9rWmgacdBv/1D9pdbE9J12th0xETqFb0bLrMKKNubUZ1T2BP8rP9Qm
         ddXM44toI/jZ2BH615LlrPcJ+2ot1EES32/JMFEmU03Mf8iy75jazX+gG+8HB/eKQJ
         cIevnqo5A0wk9NYNjariQQqY2urmIV98QeaRcQl8=
Date:   Wed, 19 Aug 2020 17:29:27 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
Message-ID: <20200819212927.GB30476@fieldses.org>
References: <20200809202739.GA29574@fieldses.org>
 <20200809212531.GB29574@fieldses.org>
 <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
 <20200810190729.GB13266@fieldses.org>
 <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
 <20200810201001.GC13266@fieldses.org>
 <CA3288FC-8B9A-4F19-A51C-E1169726E946@oracle.com>
 <F20E4EC5-71DD-4A92-A583-41BEE177F53C@oracle.com>
 <20200817222034.GA6390@fieldses.org>
 <CD4B80B9-4F58-46B4-872C-F2F139AFB231@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD4B80B9-4F58-46B4-872C-F2F139AFB231@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 18, 2020 at 05:26:26PM -0400, Chuck Lever wrote:
> 
> > On Aug 17, 2020, at 6:20 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Sun, Aug 16, 2020 at 04:46:00PM -0400, Chuck Lever wrote:
> > 
> >> In order of application:
> >> 
> >> 5920afa3c85f ("nfsd: hook nfsd_commit up to the nfsd_file cache")
> >> 961.68user 5252.40system 20:12.30elapsed 512%CPU, 2541 DELAY errors
> >> These results are similar to v5.3.
> >> 
> >> fd4f83fd7dfb ("nfsd: convert nfs4_file->fi_fds array to use nfsd_files")
> >> Does not build
> >> 
> >> eb82dd393744 ("nfsd: convert fi_deleg_file and ls_file fields to nfsd_file")
> >> 966.92user 5425.47system 33:52.79elapsed 314%CPU, 1330 DELAY errors
> >> 
> >> Can you take a look and see if there's anything obvious?
> > 
> > Unfortunately nothing about the file cache code is very obvious to me.
> > I'm looking at it....
> > 
> > It adds some new nfserr_jukebox returns in nfsd_file_acquire.  Those
> > mostly look like kmalloc failures, the one I'm not sure about is the
> > NFSD_FILE_HASHED check.
> > 
> > Or maybe it's the lease break there.
> 
> nfsd_file_acquire() always calls fh_verify() before it invokes nfsd_open().
> Replacing nfs4_get_vfs_file's nfsd_open() call with nfsd_file_acquire() adds
> almost 10 million fh_verify() calls to my test run.

Checking out the code as of fd4f83fd7dfb....

nfsd_file_acquire() calls nfsd_open_verified().

And nfsd_open() is basically just fh_verify()+nfsd_open_verified().

So it doesn't look like the replacement of nfsd_open() by
nfsd_file_acquire() should have changed the number of fh_verify() calls.

--b.

> 
> On my server, fh_verify() is quite expensive. Most of the cost is in the
> prepare_creds() call.
> 
> --
> Chuck Lever
> 
> 
