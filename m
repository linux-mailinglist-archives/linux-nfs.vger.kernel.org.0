Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA0FAC199
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 22:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfIFUrc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 16:47:32 -0400
Received: from mx2.math.uh.edu ([129.7.128.33]:47092 "EHLO mx2.math.uh.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfIFUrc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Sep 2019 16:47:32 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2])
        by mx2.math.uh.edu with esmtp (Exim 4.92)
        (envelope-from <tibbs@math.uh.edu>)
        id 1i6L8e-0007bV-Em; Fri, 06 Sep 2019 15:47:26 -0500
Received: by epithumia.math.uh.edu (Postfix, from userid 7225)
        id 619B08014CF; Fri,  6 Sep 2019 15:47:24 -0500 (CDT)
From:   Jason L Tibbitts III <tibbs@math.uh.edu>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Wolfgang Walter <linux@stwm.de>, linux-nfs@vger.kernel.org,
        km@cm4all.com, linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
        <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
        <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
        <ufad0ggrfrk.fsf@epithumia.math.uh.edu>
        <20190906144837.GD17204@fieldses.org>
Date:   Fri, 06 Sep 2019 15:47:24 -0500
In-Reply-To: <20190906144837.GD17204@fieldses.org> (J. Bruce Fields's message
        of "Fri, 6 Sep 2019 10:48:37 -0400")
Message-ID: <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -2.9 (--)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>>>>> "JBF" == J Bruce Fields <bfields@fieldses.org> writes:

JBF> Those readdir changes were client-side, right?  Based on that I'd
JBF> been assuming a client bug, but maybe it'd be worth getting a full
JBF> packet capture of the readdir reply to make sure it's legit.

I have been working with bcodding on IRC for the past couple of days on
this.  Fortunately I was able to come up with way to fill up a directory
in such a way that it will fail with certainty and as a bonus doesn't
include any user data so I can feel OK about sharing packet captures.  I
have a capture alongside a kernel trace of the problematic operation in
https://www.math.uh.edu/~tibbs/nfs/.  Not that I can particularly tell
anything useful from that, but bcodding says that it seems to point to
some issue in sunrpc.

And because I can easily reproduce this and I was able to do a bisect:

2c94b8eca1a26cd46010d6e73a23da5f2e93a19d is the first bad commit
commit 2c94b8eca1a26cd46010d6e73a23da5f2e93a19d
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Mon Feb 11 11:25:41 2019 -0500

    SUNRPC: Use au_rslack when computing reply buffer size

    au_rslack is significantly smaller than (au_cslack << 2). Using
    that value results in smaller receive buffers. In some cases this
    eliminates an extra segment in Reply chunks (RPC/RDMA).

    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

:040000 040000 d4d1ce2fbe0035c5bd9df976b8c448df85dcb505 7011a792dfe72ff9cd70d66e45d353f3d7817e3e M      net

But of course, I can't say whether this is the actual bad commit or
whether it just introduced a behavior change which alters the conditions
under which the problem appears.

And just to make sure that the blame doesn't lie with the old RHEL7
kernel, I rsynced over the problematic directory to a machine running
something slightly more modern (5.1.11, which I know I need to update,
but it's already set up to do kerberised NFS) and the same problem
exists, though the directory listing does fail at a different place.

 - J<
