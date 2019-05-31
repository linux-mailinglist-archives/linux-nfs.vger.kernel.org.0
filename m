Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB66305BF
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 02:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfEaAYa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 20:24:30 -0400
Received: from fieldses.org ([173.255.197.46]:41378 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfEaAYa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 20:24:30 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 47BED1C18; Thu, 30 May 2019 20:24:30 -0400 (EDT)
Date:   Thu, 30 May 2019 20:24:30 -0400
To:     NeilBrown <neilb@suse.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
Message-ID: <20190531002430.GC24802@fieldses.org>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155917564898.3988.6096672032831115016.stgit@noble.brown>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 30, 2019 at 10:41:28AM +1000, NeilBrown wrote:
> This patch set is based on the patches in the multipath_tcp branch of
>  git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
> 
> I'd like to add my voice to those supporting this work and wanting to
> see it land.
> We have had customers/partners wanting this sort of functionality for
> years.  In SLES releases prior to SLE15, we've provide a
> "nosharetransport" mount option, so that several filesystem could be
> mounted from the same server and each would get its own TCP
> connection.
> In SLE15 we are using this 'nconnect' feature, which is much nicer.

For what it's worth, we've also gotten at least one complaint of a
performance regression on 4.0->4.1 upgrade because a user was depending
on the fact that a 4.0 client would use multiple TCP connections to a
server with multiple IP addresses.  (Whereas in the 4.1 case the client
will recognize that the addresses point to the same server and share any
preexisting session.)

--b.
