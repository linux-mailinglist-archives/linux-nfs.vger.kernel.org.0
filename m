Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6407B869F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 00:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391661AbfISWai (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 18:30:38 -0400
Received: from cosmos.ssec.wisc.edu ([128.104.109.114]:42590 "EHLO
        cosmos.ssec.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406248AbfISWQD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 18:16:03 -0400
Received: by cosmos.ssec.wisc.edu (Postfix, from userid 388)
        id D2C47201385; Thu, 19 Sep 2019 17:16:01 -0500 (CDT)
Date:   Thu, 19 Sep 2019 17:16:01 -0500
From:   Daniel Forrest <dforrest@wisc.edu>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "alkisg@gmail.com" <alkisg@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
Message-ID: <20190919221601.GA30751@cosmos.ssec.wisc.edu>
Reply-To: Daniel Forrest <dforrest@wisc.edu>
Mail-Followup-To: Trond Myklebust <trondmy@gmail.com>,
        "alkisg@gmail.com" <alkisg@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
 <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
 <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
 <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
 <915fa536-c992-3b77-505e-829c4d049b02@gmail.com>
 <1d5f6643330afd2c04350006ad2a60e83aebb59d.camel@hammerspace.com>
 <5601db40-ee2f-262d-7d01-5c589c9a07eb@gmail.com>
 <d7ea48b4cd665eced45783bf94d6b1ff1f211960.camel@hammerspace.com>
 <20190919211912.GA21865@cosmos.ssec.wisc.edu>
 <503c22ad34b3f3a15015b7384bcad469b2899cb4.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503c22ad34b3f3a15015b7384bcad469b2899cb4.camel@hammerspace.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 19, 2019 at 05:42:26PM -0400, Trond Myklebust wrote:
> On Thu, 2019-09-19 at 16:19 -0500, Daniel Forrest wrote:
> > On Thu, Sep 19, 2019 at 08:40:41PM +0000, Trond Myklebust wrote:
> > > On Thu, 2019-09-19 at 23:20 +0300, Alkis Georgopoulos wrote:
> > > > On 9/19/19 11:05 PM, Trond Myklebust wrote:
> > > > > There are plenty of operations that can take longer than 700 ms
> > > > > to
> > > > > complete. Synchronous writes to disk are one, but COMMIT (i.e.
> > > > > the
> > > > > NFS
> > > > > equivalent of fsync()) can often take much longer even though
> > > > > it
> > > > > has no
> > > > > payload.
> > > > > 
> > > > > So the problem is not the size of the WRITE payload. The real
> > > > > problem
> > > > > is the timeout.
> > > > > 
> > > > > The bottom line is that if you want to keep timeo=7 as a mount
> > > > > option
> > > > > for TCP, then you are on your own.
> > > > > 
> > > > 
> > > > The problem isn't timeo at all.
> > > > If I understand it correctly, when I try to launch firefox over
> > > > nfsroot, 
> > > > NFS will wait until it fills 1M before "replying" to the
> > > > application.
> > > > Thus the applications will launch a lot slower, as they get
> > > > "disk 
> > > > feedback" in larger chunks and not "snappy".
> > > > 
> > > > In numbers:
> > > > timeo=600,rsize=1M => firefox opens in 30 secs
> > > > timeo=600,rsize=32k => firefox opens in 20 secs
> > > > 
> > > 
> > > That's a different problem, and is most likely due to readahead
> > > causing
> > > your client to read more data than it needs to. It is also true
> > > that
> > > the maximum readahead size is proportional to the rsize and that
> > > maybe
> > > it shouldn't be.
> > > However the VM layer is supposed to ensure that the kernel doesn't
> > > try
> > > to read ahead more than necessary. It is bounded by the maximum we
> > > set
> > > in the NFS layer, but it isn't supposed to hit that maximum unless
> > > the
> > > readahead heuristics show that the application may need it.
> > > 
> > > -- 
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > 
> > What may be happening here is something I have noticed with glibc.
> > 
> > - statfs reports the rsize/wsize as the block size of the filesystem.
> > 
> > - glibc uses the block size as the default buffer size for
> > fread/fwrite.
> > 
> > If an application is using fread/fwrite on an NFS mounted file with
> > an rsize/wsize of 1M it will try to fill a 1MB buffer.
> > 
> > I have often changed mounts to use rsize/wsize=64K to alleviate this.
> > 
> 
> That sounds like an abuse of the filesystem block size. There is
> nothing in the POSIX definition of either fread() or fwrite() that
> requires glibc to do this: 
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/fread.html
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/fwrite.html
> 
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

It looks like this was fixed in glibc 2.25:

https://sourceware.org/bugzilla/show_bug.cgi?id=4099

But this version is not on the CentOS 6/7 systems I use.

-- 
Dan Forrest
Space Science and Engineering Center University of Wisconsin, Madison
dforrest@wisc.edu
