Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97BA305B1
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 02:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfEaAP0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 20:15:26 -0400
Received: from fieldses.org ([173.255.197.46]:41360 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfEaAP0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 20:15:26 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 209C32011; Thu, 30 May 2019 20:15:26 -0400 (EDT)
Date:   Thu, 30 May 2019 20:15:26 -0400
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     Olga Kornievskaia <aglo@umich.edu>, Tom Talpey <tom@talpey.com>,
        NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
Message-ID: <20190531001526.GB24802@fieldses.org>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com>
 <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com>
 <QB1PR01MB2643963C3A7EDE1D92C57221DD180@QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QB1PR01MB2643963C3A7EDE1D92C57221DD180@QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 30, 2019 at 11:53:19PM +0000, Rick Macklem wrote:
> The FreeBSD DRC code for NFS over TCP expects the retry to be from a
> different port# (due to a new connection re: the above) for NFSv4.0.
> For NFSv3, my best recollection is that it doesn't care what the
> source port# is. (It basically uses a hash on the RPC request
> excluding TCP/IP header to recognize possible duplicates.)
> 
> I don't know what other NFS servers choose to do w.r.t. the DRC for
> NFS over TCP, however for some reason I thought that the Linux knfsd
> only used a DRC for UDP?  (Someone please clarify this.)

The knfsd DRC is used for TCP as well as UDP.  It does take into account
the source port.  I don't think we do any TCP-specific optimizations
though I agree that they sound like a good idea.

--b.
