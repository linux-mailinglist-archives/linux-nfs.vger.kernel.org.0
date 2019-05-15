Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4281B1F9FC
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2019 20:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfEOSah (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 May 2019 14:30:37 -0400
Received: from fieldses.org ([173.255.197.46]:32782 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfEOSah (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 May 2019 14:30:37 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 490711E3A; Wed, 15 May 2019 14:30:37 -0400 (EDT)
Date:   Wed, 15 May 2019 14:30:37 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: discuss NFS xfstest failures
Message-ID: <20190515183037.GB11614@fieldses.org>
References: <CAN-5tyHGLTFmd1t9Bn4VqbLFsnvTMJYd-dBzrn9mP-Tn7g8XVg@mail.gmail.com>
 <20190416193548.GA6662@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416193548.GA6662@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 16, 2019 at 03:35:48PM -0400, bfields wrote:
> On Thu, Apr 11, 2019 at 01:01:39PM -0400, Olga Kornievskaia wrote:
> > Hi folks,
> > 
> > We have some output at the wiki --
> > https://wiki.linux-nfs.org/wiki/index.php/Xfstests -- capturing a data
> > point of failures (for 4.16 kernel). However, I see many more failures
> > with the current (5.1-rc1). Wiki output should probably be updated
> > since xfstest has now 500+ tests. I have done my best to go over the
> > failures and provide some summary and comments. I'd like to see if the
> > community has any comments. Anybody else would like to share their
> > outputs from the xfstests that show other failures?
> 
> For what it's worth, I keep a list in testd/data/xfstests-failed with
> some minimal comments:
> 
> 	git://linux-nfs.org/~bfields/testd.git
> 
> Current contents appended.  As you can see there's a lot that's known
> unsupported features, but also a lot that I just haven't looked into
> yet.

Also, I added pointers to my list and Ben's on that wiki page at:

	http://wiki.linux-nfs.org/wiki/index.php/Xfstests#Other_sources

--b.
