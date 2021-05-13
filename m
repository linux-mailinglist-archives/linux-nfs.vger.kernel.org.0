Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB4C37F1D6
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 06:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhEMEId convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 13 May 2021 00:08:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:33524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhEMEId (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 May 2021 00:08:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC80BAFCC;
        Thu, 13 May 2021 04:07:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Petr Vorel" <pvorel@suse.cz>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, "Steve Dickson" <steved@redhat.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>
Subject: Re: Re: [PATCH/RFC nfs-utils] Fix NFSv4 export of tmpfs filesystems.
In-reply-to: <YJURMBWOxqGK7rh1@pevik>
References: <20210422191803.31511-1-pvorel@suse.cz>,
 <20210422202334.GB25415@fieldses.org>, <YILQip3nAxhpXP9+@pevik>,
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>,
 <YJURMBWOxqGK7rh1@pevik>
Date:   Thu, 13 May 2021 14:07:21 +1000
Message-id: <162087884172.5576.348023037121213464@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 07 May 2021, Petr Vorel wrote:
> Hi Neil,
> 
> > [[This is a proposed fix.  It seems to work.  I'd like
> >   some review comments before it is committed.
> >   Petr: it would be great if you could test it to confirm
> >   it actually works in your case.
> > ]]
> Thanks for a quick fix. It runs nicely in newer kernels (5.11.12-1-default
> openSUSE and 5.10.0-6-amd64 Debian). But it somehow fails on older ones
> (SLES 5.3.18-54-default heavily patched and 4.9.0-11-amd64).
> 
> I have some problem on Debian with 4.9.0-11-amd64 fails on both tmpfs and ext4,
> others work fine (testing tmpfs, btrfs and ext4). But maybe I did something
> wrong during testing. I did:
> cp ./utils/mountd/mountd /usr/sbin/rpc.mountd
> systemctl restart nfs-mountd.service

That is the correct procedure.  It should work...

> 
> Failure is regardless I use new mount.nfs (master) or the original from
> Debian (1.3.3).

What error message do you get on failure? It might help to add "-v" to
the mount command to see more messages.


> 
> strace looks nearly the same on tmpfs and ext4:

This shows mount.nfs connecting to rpcbind, sending a request, getting a
reply, and maybe looping around and trying again?

There doesn't seem to be anything kernel related that would affect
anything there so I cannot think why on older kernel would make a
difference.  Or an older rpcbind...

Maybe I'll experiment on a SLE12 kernel.

NeilBrown
