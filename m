Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C630C2F4F17
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jan 2021 16:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbhAMPqV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 10:46:21 -0500
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:51826 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbhAMPqV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jan 2021 10:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1610552780; bh=RC/1oew/GsS+TWnTlzLKkFZv5aCeenAdY8EJ
        EiieuRE=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=BJmVJPOtzZOIB7xNRxg6lohfALUkGzF8pZphNNHLvekEC6
        Z7sIKC9U8XBAF893OUgiWjZ14aCsD4dsyhIgilyaCldGpR4FpPFl+2d9F7pP+fXP0ed
        mIbU/PGJL3gplAzCGw5lhlVZjfwI4U1r4LlqdK8OI9GjN0Exrt7Sl2KZqeEQ5iRPTeY
        hZ2Tq4mKucdSSDy0sLh5+mhLrRxUg+uKSoW5Q9H1L8ZzgOBmH/UMBihpgTB3QZLmw1h
        N/+6tX4Lg1+GLvA9hPtiESUwvq7S1Cfzj7rZCTlX00K7i9GZRD+J10H2jACSOZ+gLhq
        pujCoYE9mRgDcHes39KviRNZJagQ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=SvmQ6UdVaZEKswJG+8r8Zat8Y5k+iNoZXIA4bIrIXlPptCUCLXm9XyAT5wRg0loR77mQRr28wEA1LyGPCMvoTI2t9Vgddh1uh713WErfL2tZxG4CSFKOxj6LtuAhC1VNjK63fO/4SHqv6/EmcYhPyUggZ0T/S0l6i+9KPPGY9uBCQxlxkxZgeS23wNdpSTG/5cyBea078BEoY53fIo+duEJr3jR//A9leUYvFASv9cBdTV4fENfCuZOKKsR7bmTk2km9Lw35M2UGzG9DTz+IlbJn87vCm1bKPmflQR7ZNf+bL0IgiqWBd7m+pJ7E2+fgiWBtoC3eISyNl80+Zh2y/A==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1kziL1-0005Ci-FY; Wed, 13 Jan 2021 10:45:35 -0500
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     <hch@infradead.org>, "'Trond Myklebust'" <trondmy@hammerspace.com>
Cc:     <pgoetz@math.utexas.edu>, <wangzhibei1999@gmail.com>,
        <chuck.lever@oracle.com>, <greg@kroah.com>, <w@1wt.eu>,
        <security@kernel.org>, <bfields@fieldses.org>,
        <linux-nfs@vger.kernel.org>
References: <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com> <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com> <20210112153208.GF9248@fieldses.org> <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com> <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu> <20210112180326.GI9248@fieldses.org> <20210113081238.GA1428651@infradead.org> <0da3d3f1fee1a70eab3f78212f9282b03e21fc4d.camel@hammerspace.com> <20210113144026.GA1517953@infradead.org> <cfe4b764e6a3a58e10d95dfe660afa12c30d8008.camel@hammerspace.com> <20210113153013.GA1527598@infradead.org>
In-Reply-To: <20210113153013.GA1527598@infradead.org>
Subject: RE: nfsd vurlerability submit
Date:   Wed, 13 Jan 2021 07:45:34 -0800
Message-ID: <05d301d6e9c3$228bcc50$67a364f0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQLbBpV2WqwSH4ro3sg5DnHxNuogsAG1foYMAdPFeR8A7OUsxgJNtEcoAifwYVQBKcynSgGzjkOHAzIEykABCARvvwEuJyujp5Ps7jA=
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4dc441b88e89c558d0e8f4e45fa517a40a350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Wed, Jan 13, 2021 at 03:16:52PM +0000, Trond Myklebust wrote:
> > How would that work then? Would you just look at the project ID of the
> > directory identified by the filehandle as the export point, and then
> > match to the project ID on the target inode? That sounds like it
> > doesn't even need to encode anything special in the filehandle.
> 
> True, we would not even have to encode them.
> 
> > How do you set a project ID in XFS?
> 
> With the XFS_IOC_SETXFLAGS ioctl.
> 
> On the command line side people usually do it using the xfs_quota tool as
part
> of setting up the tree quotas, but it can also be done separately using
the chproj
> subcommand of xfs_io.

Is this also queried via the ioctl? If this is a viable way of specifying
sub-trees, nfs-ganesha could also use it, though making an ioctl call for
each file system object would add some metadata performance hit.

Frank

