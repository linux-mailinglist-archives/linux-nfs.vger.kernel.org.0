Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE52AC612
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 21:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgKIUmI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 15:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIUmI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 15:42:08 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4EC0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 12:42:08 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B1E47AB6; Mon,  9 Nov 2020 15:42:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B1E47AB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1604954526;
        bh=Hb522Hebd1vL7+kirZ3/DkIauc6gVMGt5hclhBZkiLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1dPwQm5e/POXms1gtnkLd3q4UV3rW2FsQhsu35VcWq4pyqhwm8iloQmXMqhOUj7V
         E0FvJmQYa4TOkQzaaMunaIReqhS8CuRjtoznmco2EOUDxi4Db0FY+96XmkogMFeQ/u
         iY4kCDyhmtlRmxKcI14pw/9MlIu5MtqrMBLwE9p4=
Date:   Mon, 9 Nov 2020 15:42:06 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter
 server copy
Message-ID: <20201109204206.GA20261@fieldses.org>
References: <20201019034249.27990-1-dai.ngo@oracle.com>
 <20201020170114.GF1133@fieldses.org>
 <fb514565-cd47-9180-2adc-f3ba4459202b@oracle.com>
 <20201109183054.GD11144@fieldses.org>
 <eeafd9e2-5d04-848e-d330-670e2185098d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeafd9e2-5d04-848e-d330-670e2185098d@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 09, 2020 at 11:34:08AM -0800, Dai Ngo wrote:
> 
> On 11/9/20 10:30 AM, J. Bruce Fields wrote:
> >On Tue, Oct 20, 2020 at 11:34:35AM -0700, Dai Ngo wrote:
> >>On 10/20/20 10:01 AM, J. Bruce Fields wrote:
> >>>On Sun, Oct 18, 2020 at 11:42:49PM -0400, Dai Ngo wrote:
> >>>>NFS_FS=y as dependency of CONFIG_NFSD_V4_2_INTER_SSC still have
> >>>>build errors and some configs with NFSD=m to get NFS4ERR_STALE
> >>>>error when doing inter server copy.
> >>>>
> >>>>Added ops table in nfs_common for knfsd to access NFS client modules.
> >>>OK, looks reasonable to me, applying.  Does this resolve all the
> >>>problems you've seen, or is there any bad case left?
> >>Thanks Bruce.
> >>
> >>With this patch, I no longer see the NFS4ERR_STALE in any config.
> >>
> >>The problem with NFS4ERR_STALE was because of a bug in nfs42_ssc_open.
> >>When CONFIG_NFSD_V4_2_INTER_SSC is not defined, nfs42_ssc_open
> >>returns NULL which is incorrect allowing the operation to continue
> >>until nfsd4_putfh which does not have the code to handle nfserr_stale.
> >>
> >>With this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not defined the
> >>new nfs42_ssc_open returns ERR_PTR(-EIO) which causes the NFS client
> >>to switch over to the split copying (read src and write to dst).
> >That sounds reasonable, but I don't see any of the patches you've sent
> >changing that error return.  Did I overlook something, or did you mean
> >to append a patch to this message?
> 
> Since with the patch, I did not run into the condition where NFS4ERR_STALE
> is returned so I did not fix this return error code. Do you want me to
> submit another patch to change the returned error code from NFS4ERR_STALE
> to NFS4ERR_NOTSUPP if it ever runs into that condition?

That would be great, thanks.  (I mean, it is still possible to hit that
case, right?  You just didn't test with !CONFIG_NFSD_V4_2_INTER_SSC ?)

--b.
