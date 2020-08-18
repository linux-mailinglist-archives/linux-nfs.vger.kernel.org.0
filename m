Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08E024905A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Aug 2020 23:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHRVtw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Aug 2020 17:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgHRVtv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Aug 2020 17:49:51 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0899C061389
        for <linux-nfs@vger.kernel.org>; Tue, 18 Aug 2020 14:49:51 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 00267ABC; Tue, 18 Aug 2020 17:49:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 00267ABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1597787391;
        bh=OB5LPVt3vi+RxFuPItReycY9sUW0Zx3WhIpYim4eJEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgFxzDf9DYI/bRbF9WZVFvuhc6nmXNyqJ6jBQTlblL0wWGSiXu2xgJPQx41q5H9Cm
         YDTiDAd9tcj7f19uhVIHR4d/8Hl0q90LoG1hKmiZd1d9JSeXAC7dHgTcl+JArJOg/F
         EGsy8hFOSMX9RAK2Ao4GHeQJWD6p0x46LWr9s9gg=
Date:   Tue, 18 Aug 2020 17:49:50 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
Message-ID: <20200818214950.GA8811@fieldses.org>
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
> 
> On my server, fh_verify() is quite expensive. Most of the cost is in the
> prepare_creds() call.

Huh, interesting.

So you no longer think there's a difference in NFS4ERR_DELAY returns
before and after?


--b.
