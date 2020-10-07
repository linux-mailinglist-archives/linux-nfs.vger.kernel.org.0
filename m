Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEFB285FD2
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 15:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgJGNKi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGNKi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 09:10:38 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90460C061755
        for <linux-nfs@vger.kernel.org>; Wed,  7 Oct 2020 06:10:38 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6D5874F3B; Wed,  7 Oct 2020 09:10:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6D5874F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602076237;
        bh=uS9Lz/cEr5pBvZBR+mF0/7pdxZQEF3hGSDwUaWU3M9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJByCkYFhyrrJC0E25QPqVUj1uUyAuZyQ7PJNHEeivOcpQjB4S19BxkGpGot+xEKa
         g5wToK1UoGn8eEtbYW79rRnJZyyuOfJW6IgyMT6g2Ops9okOLrkstjPKHYcQs+Lg/Y
         n5GyKiGqBb5sf2AMTwkhScaW9G4o1XJWIW6+SMr8=
Date:   Wed, 7 Oct 2020 09:10:37 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Kenneth Johansson <ken@kenjo.org>
Cc:     Patrick Goetz <pgoetz@math.utexas.edu>, linux-nfs@vger.kernel.org
Subject: Re: nfs home directory and google chrome.
Message-ID: <20201007131037.GA23452@fieldses.org>
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
 <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu>
 <923003de-7fcf-abee-07a2-0691b25673d8@kenjo.org>
 <20201006181454.GB32640@fieldses.org>
 <07f3684e-482e-dc73-5c9a-b7c9329fc410@kenjo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07f3684e-482e-dc73-5c9a-b7c9329fc410@kenjo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 07, 2020 at 12:54:50PM +0200, Kenneth Johansson wrote:
> On 2020-10-06 20:14, J. Bruce Fields wrote:
> >On Mon, Oct 05, 2020 at 10:07:56PM +0200, Kenneth Johansson wrote:
> >>On 2020-10-05 18:46, Patrick Goetz wrote:
> >>>We had a similar problem with Firefox, most notably with Mac OSX
> >>>users who have NFS-mounted home directories. There's an
> >>>about:config solution for Firefox; namely set
> >>>
> >>>    storage.nfs_filesystem: true
> >>>
> >>>This forces a specific network file locking mechanism which makes
> >>>sqlite behave better. I'm guessing google chrome has something
> >>>similar.
> >>>
> >>Since I have used chrome for years without any problems my guess it
> >>that its something that changed with nfs in my setup.
> >>
> >>I did a strace and the first -EIO I get look like this
> >>
> >>fdatasync(94</home/kenjo/.config/google-chrome/Default/Login Data>)
> >>= -1 EIO (Input/output error)
> >>
> >>then the same thing happens for other files like
> >>
> >>fdatasync(83</home/kenjo/.config/google-chrome/Default/Web Data>) =
> >>-1 EIO (Input/output error)
> >>
> >>fdatasync(74</home/kenjo/.config/google-chrome/Default/History>) =
> >>-1 EIO (Input/output error)
> >Are you using soft mounts?
> >
> >(What are your mount options?)
> 
> auto.home /home autofs rw,relatime,fd=18,pgrp=2682,timeout=300,minproto=5,maxproto=5,indirect,pipe_ino=67621
> 0 0
> 
> /home/kenjo nfs4 rw,noatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,acregmin=120,acregmax=120,acdirmin=120,acdirmax=120,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=172.16.2.16,fsc,local_lock=none,addr=172.16.2.6
> 0 0
> 
> what I actualy set manually in auto.home is
> 
> -tcp,fsc,noatime,ac,actimeo=120

OK, that looks fine.

Maybe I overlooked the obvious: if Chrome holds a lock on that file when
you suspend, and if you stay in suspend for longer than the NFSv4 lease
time (default 90 seconds), then the client will lose its lease, hence
any file locks.  I think these days the client then returns EIO on any
further IO to that file descriptor.

Maybe there's some way to turn off that locking as a workaround.

The simplest thing we can do to help might be implementing "courteous
server" behavior: instead of automatically removing locks after a
client's lease expires, it can wait until there's an actual lock
conflict.  That might be enough for your case.

There's been a little planning done and it's not a big project, but I
don't think it's actually at the top of anyone's todo list right now, so
I'm not sure when that will get done.

--b.

> 
> 
> >--b.
> >
> >>
> >>
> >>
> >>>On 10/4/20 6:53 AM, Kenneth Johansson wrote:
> >>>>So I have had for a long time problems with google chrome and
> >>>>suspend resume causing it to mangle its sqlite database.
> >>>>
> >>>>it looks to only happen if I use nfs mounted home directory. I'm
> >>>>not sure exactly what is happening but lets first see if this
> >>>>happens to anybody else.
> >>>>
> >>>>How to get the error.
> >>>>
> >>>>1. start google from a terminal with "google-chrome"
> >>>>
> >>>>2. suspend the computer
> >>>>
> >>>>3. wait a while. There is some type of minimum time here I do
> >>>>not know what its is but I basically get the error every time of
> >>>>I suspend in evening and resume in morning
> >>>>
> >>>>4. look for printout that looks like something like this
> >>>>
> >>>>[16789:18181:1004/125852.529750:ERROR:database.cc(1692)]
> >>>>Passwords sqlite error 1034, errno 5: disk I/O error, sql:
> >>>>COMMIT
> >>>>[16789:16829:1004/125852.529744:ERROR:database.cc(1692)] Web
> >>>>sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
> >>>>[16789:16829:1004/125852.530261:ERROR:database.cc(1692)] Web
> >>>>sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR
> >>>>REPLACE INTO autofill_model_type_state (model_type, value)
> >>>>VALUES(?,?)
> >>>>[16789:16789:1004/125852.563571:ERROR:sync_metadata_store_change_list.cc(34)]
> >>>>Autofill datatype error was encountered: Failed to update
> >>>>ModelTypeState.
> >>>>[16789:19002:1004/125902.534103:ERROR:database.cc(1692)] History
> >>>>sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
> >>>>[16789:19002:1004/125902.536903:ERROR:database.cc(1692)]
> >>>>Thumbnail sqlite error 778, errno 5: disk I/O error, sql: COMMIT
> >>>>
> >>>>
> >>>>[16789:19002:1004/130044.120379:ERROR:database.cc(1692)]
> >>>>Passwords sqlite error 1034, errno 5: disk I/O error, sql:
> >>>>INSERT OR REPLACE INTO sync_model_metadata (id, model_metadata)
> >>>>VALUES(1, ?)
> >>>>[16789:16829:1004/130044.120388:ERROR:database.cc(1692)] Web
> >>>>sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR
> >>>>REPLACE INTO autofill_model_type_state (model_type, value)
> >>>>VALUES(?,?)
> >>>>
> >>>>
> >>>>and so on.  if you use google sync you can also check
> >>>>"chrome://sync-internals" to see if something is wrong with the
> >>>>database.
> >>>>
> >>>>
> >>>>
> >>>>>>This message is from an external sender. Learn more about why this <<
> >>>>>>matters at https://links.utexas.edu/rtyclf. <<
> 
