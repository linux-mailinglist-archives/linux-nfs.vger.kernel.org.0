Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7022E218F
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfJWRPX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 13:15:23 -0400
Received: from fieldses.org ([173.255.197.46]:38658 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbfJWRPX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 23 Oct 2019 13:15:23 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 56014738; Wed, 23 Oct 2019 13:15:23 -0400 (EDT)
Date:   Wed, 23 Oct 2019 13:15:23 -0400
To:     Chandler <admin@genome.arizona.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: NFS hangs on one interface
Message-ID: <20191023171523.GA18802@fieldses.org>
References: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Beats me.  My first guess would be some kind of networking problem.
Maybe try running wireshark and watching to see if certain calls aren't
getting responses.

--b.

On Tue, Oct 22, 2019 at 05:34:51PM -0700, Chandler wrote:
> Hi all, I'm sure you get this alot, but I couldn't figure out any solution.  We have a client/server pair with both 1Gb and 10Gb network interfaces.  I can mount the share on the client on the 1Gb interface just fine and interact with it normally.  If I unmount and try to mount the share on the 10Gb interface, it will mount but everything after that hangs (like ls or df).  The exports entry is the same on the server, i.e.:
> 
> #1Gb interface
> /data   10.10.10.0/24(rw,no_root_squash,async)
> #10Gb interface
> /data   128.196.X.X/28(rw,no_root_squash,async)
> 
> I turned off iptables for troubleshooting and checked with the NOC here.  Using NFSv4 by default and CentOS 6.10 2.6.32 kernel.  I had some strange results if i try vers=3 or vers=2, then i can "ls /data" but if I try to "ls /data/subdir" then it hangs again.  Now it doesn't even mount if i try with vers=3 or vers=2
> 
