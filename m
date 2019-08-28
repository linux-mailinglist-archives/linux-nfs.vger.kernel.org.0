Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAB9A03AA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 15:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfH1Nsj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 09:48:39 -0400
Received: from fieldses.org ([173.255.197.46]:48940 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfH1Nsj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 09:48:39 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 53BED7CC; Wed, 28 Aug 2019 09:48:39 -0400 (EDT)
Date:   Wed, 28 Aug 2019 09:48:39 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jlayton@poochiereds.net" <jlayton@poochiereds.net>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Message-ID: <20190828134839.GA26492@fieldses.org>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
 <20190826205156.GA27834@fieldses.org>
 <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
 <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
 <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
 <20190827145819.GB9804@fieldses.org>
 <20190827145912.GC9804@fieldses.org>
 <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 27, 2019 at 03:15:35PM +0000, Trond Myklebust wrote:
> I'm open to other suggestions, but I'm having trouble finding one that
> can scale correctly (i.e. not require per-client tracking), prevent
> silent corruption (by causing clients to miss errors), while not
> relying on optional features that may not be implemented by all NFSv3
> clients (e.g. per-file write verifiers are not implemented by *BSD).
> 
> That said, it seems to me that to do nothing should not be an option,
> as that would imply tolerating silent corruption of file data.

So should we increment the boot verifier every time we discover an error
on an asynchronous write?

--b.
