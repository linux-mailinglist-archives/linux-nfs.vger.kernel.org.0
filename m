Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB2A096C
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 20:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfH1S3F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 14:29:05 -0400
Received: from mx1.math.uh.edu ([129.7.128.32]:53356 "EHLO mx1.math.uh.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfH1S3E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 14:29:04 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2])
        by mx1.math.uh.edu with esmtp (Exim 4.92)
        (envelope-from <tibbs@math.uh.edu>)
        id 1i32gm-0002ay-RH; Wed, 28 Aug 2019 13:29:03 -0500
Received: by epithumia.math.uh.edu (Postfix, from userid 7225)
        id BF4D6801554; Wed, 28 Aug 2019 13:29:00 -0500 (CDT)
From:   Jason L Tibbitts III <tibbs@math.uh.edu>
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     linux-nfs@vger.kernel.org, km@cm4all.com,
        linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
        <ufapnkxkn0x.fsf@epithumia.math.uh.edu>
        <20190828174609.GB29148@fieldses.org>
Date:   Wed, 28 Aug 2019 13:29:00 -0500
In-Reply-To: <20190828174609.GB29148@fieldses.org> (J. Bruce Fields's message
        of "Wed, 28 Aug 2019 13:46:09 -0400")
Message-ID: <ufay2zduosz.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -2.9 (--)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>>>>> "BF" == J Bruce Fields <bfields@fieldses.org> writes:

BF> Looks like that's db531db951f950b8 upstream.  (Do you know if it's
BF> reproduceable upstream as well?)

Yes, it's reproducible up in the 5.3.0 RCs as well.

However, while trying to do some further bisecting I ran into an odd
problem.  Now kernels which were previously working (i.e. 5.1.19 and
older) are returning errors, but at a different file count.  This only
gives me more questions.  And so, just to be absolutely sure that there
isn't some weird server issue involved, I'm going to try to schedule a
reboot of the relevant server.

BF> Maybe it depends on having names of the right length to place some
BF> bit of xdr on a boundary.  I wonder if it'd be possible to reproduce
BF> just by varying the name lengths randomly till you hit it.

I know I can't reproduce with loads of short names, and with relatively
long names as well (using sha256sum as filename generator).

BF> No clever debugging ideas off the top of my head, I'm afraid.  I
BF> might start by patching the kernel or doing some tracing to figure
BF> out exactly where that EIO is being generated?

If I had any idea how to do that, I happily would.  I'm certainly
willing to learn.  At least I can run strace to see where ls bombs:

getdents64(5, 0x7fc13afaf040, 262144)   = -1 EIO (Input/output error)

bcodding on IRC mentioned that is a rather large count.  Does make me
wonder if the server is weirding out and sending the client bogus data.
Certainly a server reboot, or maybe even just unmounting and remounting
the filesystem or copying the data to another filesystem would tell me
that.  In any case, as soon as I am able to mess with that server, I'll
know more.

 _ J<
