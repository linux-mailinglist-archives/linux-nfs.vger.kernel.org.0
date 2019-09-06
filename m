Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415F6ABB50
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 16:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394556AbfIFOsi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 10:48:38 -0400
Received: from fieldses.org ([173.255.197.46]:57420 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbfIFOsi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Sep 2019 10:48:38 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C0C951C9D; Fri,  6 Sep 2019 10:48:37 -0400 (EDT)
Date:   Fri, 6 Sep 2019 10:48:37 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jason L Tibbitts III <tibbs@math.uh.edu>
Cc:     Wolfgang Walter <linux@stwm.de>, linux-nfs@vger.kernel.org,
        km@cm4all.com, linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
Message-ID: <20190906144837.GD17204@fieldses.org>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de>
 <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ufad0ggrfrk.fsf@epithumia.math.uh.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 03, 2019 at 08:50:39PM -0500, Jason L Tibbitts III wrote:
> I asked the XFS folks who mentioned that the issues with 64 bit inodes
> are old, constrained to larger filesystems than what I'm using, not an
> issue with nfsv4, and not present on anything but 32bit clients with old
> userspace.
> 
> In any case, I have been experimenting a bit and somehow the issue seems
> to be related to exporting with sec=krb5i:krb5p or sec=krb5i.  If I
> export with just sec=krb5p, things magically begin to work.

That's interesting!

We've occasionally had bugs that are rare corner cases in the xdr
code--e.g. if the encoded directory data hits some limit at the same
time that we reach the end of a page, and the end of the page falls at
some offset with respect to the entry we're encoding.

Something like switching between krb5i and krb5p could affect the
offsets in a way that affected the likelihood of hitting such a case.
That's one guess, anyway.

> Anyway, I hope this helps to pinpoint the problem.  I now have a really
> easy way to reproduce this without having to kick people off of the
> server, and if the successes aren't just some kind of false positives
> then I guess I also have a workaround.  I'm still at a loss as to why a
> revert of the readdir changes makes any difference at all here.

Those readdir changes were client-side, right?  Based on that I'd been
assuming a client bug, but maybe it'd be worth getting a full packet
capture of the readdir reply to make sure it's legit.  Looking at it in
wireshark should tell us quickly whether it's corrupted somehow.

--b.
