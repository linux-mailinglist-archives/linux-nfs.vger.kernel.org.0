Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0532F20B975
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgFZTqY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZTqY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 15:46:24 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4DC03E979
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 12:46:24 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8C31487A1; Fri, 26 Jun 2020 15:46:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8C31487A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593200782;
        bh=IffYAU5ZTHtGaJmQtjs9BXCCd6NFKQPqeuqqEj2wPGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyhhrE4a3hPdouW/63iRivf3DPV1tXl7jX//5lWuwJ9XGg5Z2sj9lc0hUqR4rGDkm
         frs2pAN3aTOzgi28zCCCBG8p6bbyAZ1zKbiB9nPS5H5wGE3UqqmAweUMH9gEO5zIID
         3Y9Bu8w6Up1PdXoJWoMu86hELvCjfMCyYB37q/YU=
Date:   Fri, 26 Jun 2020 15:46:22 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Doug Nazar <nazard@nazar.ca>
Cc:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>
Subject: Re: Strange segmentation violations of rpc.gssd in Debian Buster
Message-ID: <20200626194622.GB11850@fieldses.org>
References: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
 <20200619220434.GB1594@fieldses.org>
 <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
 <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
 <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
 <c1c314fd-1855-cf04-3ec5-5f6eb35719a5@nazar.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c314fd-1855-cf04-3ec5-5f6eb35719a5@nazar.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 26, 2020 at 01:23:54PM -0400, Doug Nazar wrote:
> Ok, I think I see what's going on. The struct clnt_info is getting
> freed out from under the upcall thread. In this case it immediately
> got reused for another client which zeroed the struct and was in the
> process of looking up the info for it's client, hence the protocol &
> server fields were null in the upcall thread.
> 
> Explains why I haven't been able to recreate it. Thanks for the
> stack trace Sebastian.
> 
> Bruce, I can't see any locking/reference counting around struct
> clnt_info. It just gets destroyed when receiving the inotify. Or
> should it be deep copied when starting an upcall? Am I missing
> something?

Thanks for finding that!

Staring at that code in an attempt to catch up here....

Looks like there's one main thread that watches for upcalls and other
events, then creates a new short-lived thread for each upcall.

The main thread is the only one that really manipulates the data
structure with all the clients.  So that data structure shouldn't need
any locking.  Except, as you point out, to keep the clnt_info from
disappearing out from under them.

So, yeah, either a reference count or a deep copy is probably all that's
needed, in alloc_upcall_info() and at the end of handle_krb5_upcall().

--b.


> Doug
> 
> Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for topdir (nfsd4_cb) - ev->wd (5) ev->name (clnt50e) ev->mask (0x40000100)
> Jun 25 11:46:08 server rpc.gssd[6356]: handle_gssd_upcall: 'mech=krb5 uid=0 target=host@client.domain.tu-berlin.de service=nfs enctypes=18,17,16,23,3,1,2 ' (nfsd4_cb/clnt50e)
> Jun 25 11:46:08 server rpc.gssd[6356]: krb5_use_machine_creds: uid 0 tgtname host@client.domain.tu-berlin.de
> Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for clntdir (nfsd4_cb/clnt50e) - ev->wd (75) ev->name (krb5) ev->mask (0x00000200)
> Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for clntdir (nfsd4_cb/clnt50e) - ev->wd (75) ev->name (gssd) ev->mask (0x00000200)
> Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for clntdir (nfsd4_cb/clnt50e) - ev->wd (75) ev->name (info) ev->mask (0x00000200)
> Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for clntdir (nfsd4_cb/clnt50e) - ev->wd (75) ev->name (<?>) ev->mask (0x00008000)
> Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for topdir (nfsd4_cb) - ev->wd (5) ev->name (clnt50f) ev->mask (0x40000100)
> Jun 25 11:46:08 server rpc.gssd[6356]: Full hostname for '' is 'client.domain.tu-berlin.de'
> Jun 25 11:46:08 server rpc.gssd[6356]: Full hostname for 'server.domain.tu-berlin.de' is 'server.domain.tu-berlin.de'
> Jun 25 11:46:08 server rpc.gssd[6356]: Success getting keytab entry for 'nfs/server.domain.tu-berlin.de@TU-BERLIN.DE'
> Jun 25 11:46:08 server rpc.gssd[6356]: INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_TU-BERLIN.DE' are good until 1593101766
> Jun 25 11:46:08 server rpc.gssd[6356]: INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_TU-BERLIN.DE' are good until 1593101766
> Jun 25 11:46:08 server rpc.gssd[6356]: creating (null) client for server (null)
> Jun 25 11:46:08 all kernel: rpc.gssd[14174]: segfault at 0 ip 000056233fff038e sp 00007fb2eaeb9880 error 4 in rpc.gssd[56233ffed000+9000]
> 
> 
> Thread 1 (Thread 0x7fb2eaeba700 (LWP 14174)):
> #0  0x000056233fff038e in create_auth_rpc_client (clp=clp@entry=0x562341008fa0, tgtname=tgtname@entry=0x562341011c8f "host@client.domain.tu-berlin.de", clnt_return=clnt_return@entry=0x7fb2eaeb9de8, auth_return=auth_return@entry=0x7fb2eaeb9d50, uid=uid@entry=0, cred=cred@entry=0x0, authtype=0) at gssd_proc.c:352
> 
> Thread 2 (Thread 0x7fb2eb6d9740 (LWP 6356)):
> #12 0x000056233ffef82c in gssd_read_service_info (clp=0x562341008fa0, dirfd=11) at gssd.c:326
> 
