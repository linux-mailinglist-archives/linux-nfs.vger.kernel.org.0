Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE57FA0981
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 20:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfH1Sdz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 14:33:55 -0400
Received: from fieldses.org ([173.255.197.46]:49384 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfH1Sdz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 14:33:55 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id AD7341CB4; Wed, 28 Aug 2019 14:33:54 -0400 (EDT)
Date:   Wed, 28 Aug 2019 14:33:54 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jason L Tibbitts III <tibbs@math.uh.edu>
Cc:     linux-nfs@vger.kernel.org, km@cm4all.com,
        linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
Message-ID: <20190828183354.GD29148@fieldses.org>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <ufapnkxkn0x.fsf@epithumia.math.uh.edu>
 <20190828174609.GB29148@fieldses.org>
 <ufay2zduosz.fsf@epithumia.math.uh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ufay2zduosz.fsf@epithumia.math.uh.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 28, 2019 at 01:29:00PM -0500, Jason L Tibbitts III wrote:
> If I had any idea how to do that, I happily would.  I'm certainly
> willing to learn.  At least I can run strace to see where ls bombs:

Somewhat of a caveman, I might start at the code for getdents, sprinkle
printk's around until I get down to the relevant code in the NFS
layer....  There's probably a better way to do it with tracing.

> getdents64(5, 0x7fc13afaf040, 262144)   = -1 EIO (Input/output error)
> 
> bcodding on IRC mentioned that is a rather large count.  Does make me
> wonder if the server is weirding out and sending the client bogus data.
> Certainly a server reboot, or maybe even just unmounting and remounting
> the filesystem or copying the data to another filesystem would tell me
> that.  In any case, as soon as I am able to mess with that server, I'll
> know more.

Might also be worth capturing the network traffic and checking whether
wireshark thinks the server replies are valid xdr.

--b.
