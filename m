Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE8A6D42
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2019 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfICPuF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Sep 2019 11:50:05 -0400
Received: from mx1.math.uh.edu ([129.7.128.32]:56392 "EHLO mx1.math.uh.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbfICPuF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Sep 2019 11:50:05 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2])
        by mx1.math.uh.edu with esmtp (Exim 4.92)
        (envelope-from <tibbs@math.uh.edu>)
        id 1i5B40-00036N-4s; Tue, 03 Sep 2019 10:50:03 -0500
Received: by epithumia.math.uh.edu (Postfix, from userid 7225)
        id 159ED801554; Tue,  3 Sep 2019 10:49:48 -0500 (CDT)
From:   Jason L Tibbitts III <tibbs@math.uh.edu>
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     linux-nfs@vger.kernel.org, km@cm4all.com,
        linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
        <ufapnkxkn0x.fsf@epithumia.math.uh.edu>
        <20190828174609.GB29148@fieldses.org>
        <ufay2zduosz.fsf@epithumia.math.uh.edu>
Date:   Tue, 03 Sep 2019 10:49:48 -0500
In-Reply-To: <ufay2zduosz.fsf@epithumia.math.uh.edu> (Jason L. Tibbitts, III's
        message of "Wed, 28 Aug 2019 13:29:00 -0500")
Message-ID: <ufa5zm9s7kz.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -2.9 (--)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>>>>> "JLT" == Jason L Tibbitts <tibbs@math.uh.edu> writes:

JLT> Certainly a server reboot, or maybe even just
JLT> unmounting and remounting the filesystem or copying the data to
JLT> another filesystem would tell me that.  In any case, as soon as I
JLT> am able to mess with that server, I'll know more.

Rebooting the server did not make any difference, and now more users are
seeing the problem.  At this point I'm in a state where NFS simply isn't
reliable at all, and I'm not sure what to do.  If Centos 8 were out,
I'd work on moving to that just so that the server was a little more
modern.  (Currently the server is Centos 7.)  I guess I could try using
Fedora, or installing one of the upstream kernels, just in case this has
to do with some interaction between the client and the old RHEL7 kernel.

I do have a packet capture of a directory listing that fails with EIO,
but I'm not sure if it's safe to simply post it, and I'm not sure what
tshark options would be useful in decoding it.

I do know that I can rsync one of the problematic directories to a
different server (running the same kernel) and it doesn't have the same
problem.  What I'll try next is rsyncing to a different filesystem on
the same server, but again I'll have to wait until people log off to do
proper testing.

 - J<
