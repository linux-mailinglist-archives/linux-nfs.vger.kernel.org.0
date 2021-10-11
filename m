Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03155429273
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Oct 2021 16:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhJKOr6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Oct 2021 10:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbhJKOrz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Oct 2021 10:47:55 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09172C061570
        for <linux-nfs@vger.kernel.org>; Mon, 11 Oct 2021 07:45:54 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A51AB703E; Mon, 11 Oct 2021 10:45:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A51AB703E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633963552;
        bh=htgOq0e32jiu+CI65mDx7/E1Aqnl3/nKwOO4azvtHxI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=MT3phNi9Z1RUzBFLEtYxGs4Eav3GouO+Y5Io21I1Wpg6CCtVR1/Gf0UfdaPpNA+pH
         lxprCYrxIzusJpDCQuXW0aqksKmWVI+MLQndjaKbCSuvMizY9k5CkLpNm8rgVBroFv
         QU73KtOlIaOMJYlEHPffJ/oziOqWIUMvTCfN5OIY=
Date:   Mon, 11 Oct 2021 10:45:52 -0400
To:     Charles Hedrick <hedrick@cs.rutgers.edu>
Cc:     Charles Hedrick <hedrick@rutgers.edu>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: more problems with NFS. sort of repeatable problem with vmplayer
Message-ID: <20211011144552.GD22387@fieldses.org>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
 <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>
 <1EA88CB0-7639-479C-AB1D-CAF5C67AA5C5@redhat.com>
 <22DE8966-253D-49A7-936D-F0A0B5246BE6@rutgers.edu>
 <08DD4F45-E1CB-4FCB-BA0C-A6B8BD86FEDE@redhat.com>
 <5F282359-128D-4F72-B393-B87956DFE458@oracle.com>
 <EE014097-EDF8-484B-81DF-9E7012122BB9@rutgers.edu>
 <70E12E3F-2DFB-4557-9541-67276E5A195C@rutgers.edu>
 <2C0DB856-23E5-41A2-A9F5-6E64F5A9FCB6@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2C0DB856-23E5-41A2-A9F5-6E64F5A9FCB6@cs.rutgers.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 05, 2021 at 03:46:21PM -0400, Charles Hedrick wrote:
> We just found a nearly repeatable problem. If you run vmplayer (a desktop VM system from VMware). with its vm storage on NFS, the system eventually locks up. Some of the time. It happens consistently for one user, and I just saw it.

Could you explain what you mean by "locks up"?  Is one application
hanging, or is the whole machine unresponsive until rebooted?

> When we told the user for which it is consistent to move his vm’s to local storage, the problem went away.
> 
> It tried running vmplayer. Shortly after starting to create a new VM, vmplayer hung. I had another window with a shell. I went into the directory with the vm files and did “ls -ltrc”. It didn’t quite hang, but look about a minute to finish I also saw log entries from VMware complaining that disk operations took several seconds.

Any kernel messages in the log around that time?

> We saw this problem last semester consistentl, though I didn’t realize
> a connection with vmplayer (if it existed). We fixed it by forcing
> mounts to use NFS 4.0. Since delegations are now disabled on our
> server, I’m assuming that the problem is locking. We don’t normally
> use locking a lot, but I believe that VMware uses it extensively. 

So you're normally using NFSv4.2?

--b.

> 
> The problem occurs on Ubuntu 20.04 with both the normal (5.4) and HWE
> (5.11) kernels.
> 
> Any thoughts? At the moment I’m tempted to force 4.0, but I’d like to
> be able to use 4.2 at some point. Since it still happens with 5.11 it
> doesn’t look good. I’m willing to try a more recent kernel if it’s
> likely to help.
> 
> We’re probably an unusual installation. We’re a CS department, with
> researchers and also a large time-sharing environment for students
> (spread across many machines, with a graphical interface using Xrdb,
> etc). Our people use every piece of software under the sun.
> 
> Client and server are both Ubuntu 20.04. Server is on ZFS with NVMe
> storage.
