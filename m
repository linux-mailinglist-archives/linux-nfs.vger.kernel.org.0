Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025DA2043B9
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2020 00:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgFVWg3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jun 2020 18:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731004AbgFVWg3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jun 2020 18:36:29 -0400
X-Greylist: delayed 31446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Jun 2020 15:36:29 PDT
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137EBC061573
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2020 15:36:29 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 29F3447F; Mon, 22 Jun 2020 18:36:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 29F3447F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592865388;
        bh=bGrDCJqklWQa4MXb2+g3bDJUYdx/x7U5k7EaP3f+USc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4KbiOzfKTwdr77A/2Wr8VkFHw0+n1Py4yxZAO9Wp69mhX824IKI9jKA7Py5zxYW8
         w3qFuQOoQ3wYQdXAgOblGIqba/EP56b5L+sohxrXoRCksCkF6oFr2a6ZUFO1biAm6Y
         fPG5BA5R3liveER/ZSPS3bzdSb/czEg8/iCEeik0=
Date:   Mon, 22 Jun 2020 18:36:28 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: RPC Pipefs: Frequent parsing errors in client database
Message-ID: <20200622223628.GC11051@fieldses.org>
References: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
 <20200619220434.GB1594@fieldses.org>
 <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jun 20, 2020 at 09:08:55PM +0000, Kraus, Sebastian wrote:
> Hi Bruce,
> 
> >> But I think it'd be more useful to stay focused on the segfaults.
> 
> is it a clever idea to analyze core dumps? Or are there other much better debugging techniques w.r.t. RPC daemons?

If we could at least get a backtrace out of the core dump that could be
useful.

> I now do more tests while fiddling around with the time-out parameters "-T" and "-t" on the command line of rpc.gssd.
> 
> There are several things I do not really understand about the trace shown below:
> 
> 1) How can it be useful that the rpc.gssd daemon tries to parse the info file although it knows about its absence beforehand?

It doesn't know beforehand, in the scenarios I described.

> 2) Why are there two identifiers clnt36e and clnt36f being used for the same client?

This is actually happening on an NFS server, the rpc client in question
is the callback client used to do things like send delegation recalls
back to the NFS client.

I'm not sure why two different callback clients are being created here,
but there's nothing inherently weird about that.

> 3) What does the <?> in "inotify event for clntdir (nfsd4_cb/clnt36e) - ev->wd (600) ev->name (<?>) ev->mask (0x00008000)" mean?

Off the top of my head, I don't know, we'd probably need to look through
header files or inotify man pages for the definitions of those masks.

--b.

> 
> 
> Jun 18 18:55:07 server  rpcbind[30464]: connect from 130.149.XXX.YYY to null()
> Jun 18 18:55:07 server  rpcbind[30465]: connect from 130.149.XXX.YYY to getport/addr(nfs)
> Jun 18 18:55:07 server  rpcbind[30466]: connect from 130.149.XXX.YYY to null()
> Jun 18 18:55:07 server  rpcbind[30467]: connect from 130.149.XXX.YYY to getport/addr(nfs)
> Jun 18 18:55:07 server  rpcbind[30468]: connect from 130.149.XXX.YYY to null()
> Jun 18 18:55:07 server  rpcbind[30469]: connect from 130.149.XXX.YYY to getport/addr(nfs)
> Jun 18 18:55:07 server  rpcbind[30470]: connect from 130.149.XXX.YYY to null()
> Jun 18 18:55:07 server  rpcbind[30471]: connect from 130.149.XXX.YYY to getport/addr(nfs)
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: leaving poll
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: handling null request
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: svcgssd_limit_krb5_enctypes: Calling gss_set_allowable_enctypes with 7 enctypes from the kernel
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: sname = host/client.domain.tu-berlin.de@TU-BERLIN.DE
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: calling nsswitch->princ_to_ids
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: nss_getpwnam: name 'host/client.domain.tu-berlin.de@TU-BERLIN.DE' domain '(null)': resulting localname 'host/test0815.chem.tu-berlin.de'
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: nss_ldap: reconnecting to LDAP server...
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: nss_ldap: reconnected to LDAP server  ldaps://ldap-server.tu-berlin.de after 1 attempt
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: nsswitch->princ_to_ids returned -2
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: final return value is -2
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: DEBUG: serialize_krb5_ctx: lucid version!
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: prepare_krb5_rfc4121_buffer: protocol 1
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: prepare_krb5_rfc4121_buffer: serializing key with enctype 18 and size 32
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: doing downcall
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: mech: krb5, hndl len: 4, ctx len 52, timeout: 1592510348 (11041 from now), clnt: host@client.domain.tu-berlin.de, uid: -1, gid: -1, num aux grps: 0:
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: sending null reply
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: writing message: \x \x608202cf06092a864886f71201020201006e8202be308202baa003020105a10302010ea20703050020000000a3820194618201903082018ca003020105a10e1b0c54552d4245524c494e2e4445a2273025a003020103a11e301c1b036e66731b15616c6c2e6368656d2e74752d6265726c696e2e6465a382014a30820146a003
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: finished handling null request
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: entering poll
> 
> Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for topdir (nfsd4_cb) - ev->wd (5) ev->name (clnt36e) ev->mask (0x40000100)
> Jun 18 18:55:07 server  rpc.gssd[23620]: ERROR: can't open nfsd4_cb/clnt36e/info: No such file or directory
> Jun 18 18:55:07 server  rpc.gssd[23620]: ERROR: failed to parse nfsd4_cb/clnt36e/info
> 
> Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for clntdir (nfsd4_cb/clnt36e) - ev->wd (600) ev->name (krb5) ev->mask (0x00000200)
> Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for clntdir (nfsd4_cb/clnt36e) - ev->wd (600) ev->name (gssd) ev->mask (0x00000200)
> Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for clntdir (nfsd4_cb/clnt36e) - ev->wd (600) ev->name (info) ev->mask (0x00000200)
> Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for topdir (nfsd4_cb) - ev->wd (5) ev->name (clnt36f) ev->mask (0x40000100)
> Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for clntdir (nfsd4_cb/clnt36e) - ev->wd (600) ev->name (<?>) ev->mask (0x00008000)
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: leaving poll
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: handling null request
> Jun 18 18:55:07 server  rpc.gssd[23620]: 
>                                      handle_gssd_upcall: 'mech=krb5 uid=0 target=host@client.domain.tu-berlin.de service=nfs enctypes=18,17,16,23,3,1,2 ' (nfsd4_cb/clnt36f)
> Jun 18 18:55:07 server  rpc.gssd[23620]: krb5_use_machine_creds: uid 0 tgtname host@client.domain.tu-berlin.de
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: svcgssd_limit_krb5_enctypes: Calling gss_set_allowable_enctypes with 7 enctypes from the kernel
> Jun 18 18:55:07 server  rpc.gssd[23620]: Full hostname for 'client.domain.tu-berlin.de' is 'client.domain.tu-berlin.de'
> Jun 18 18:55:07 server  rpc.gssd[23620]: Full hostname for 'server.domain.tu-berlin.de' is 'server.domain.tu-berlin.de'
> Jun 18 18:55:07 server  rpc.gssd[23620]: Success getting keytab entry for 'nfs/server.domain.tu-berlin.de@TU-BERLIN.DE'
> Jun 18 18:55:07 server  rpc.gssd[23620]: INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_TU-BERLIN.DE' are good until 1592526348
> Jun 18 18:55:07 server  rpc.gssd[23620]: INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_TU-BERLIN.DE' are good until 1592526348
> Jun 18 18:55:07 server  rpc.gssd[23620]: creating tcp client for server  client.domain.tu-berlin.de
> Jun 18 18:55:07 server  rpc.gssd[23620]: DEBUG: port already set to 39495
> Jun 18 18:55:07 server  rpc.gssd[23620]: creating context with server  host@client.domain.tu-berlin.de
> Jun 18 18:55:07 server  rpc.gssd[23620]: in authgss_create_default()
> Jun 18 18:55:07 server  rpc.gssd[23620]: in authgss_create()
> Jun 18 18:55:07 server  rpc.gssd[23620]: authgss_create: name is 0x7fa5ac011970
> Jun 18 18:55:07 server  rpc.gssd[23620]: authgss_create: gd->name is 0x7fa5ac005770
> Jun 18 18:55:07 server  rpc.gssd[23620]: in authgss_refresh()
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: sname = host/client.domain.tu-berlin.de@TU-BERLIN.DE
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: calling nsswitch->princ_to_ids
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: nss_getpwnam: name 'host/client.domain.tu-berlin.de@TU-BERLIN.DE' domain '(null)': resulting localname 'host/client.domain.tu-berlin.de'
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: nsswitch->princ_to_ids returned -2
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: final return value is -2
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: DEBUG: serialize_krb5_ctx: lucid version!
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: prepare_krb5_rfc4121_buffer: protocol 1
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: prepare_krb5_rfc4121_buffer: serializing key with enctype 18 and size 32
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: doing downcall
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: mech: krb5, hndl len: 4, ctx len 52, timeout: 1592510348 (11041 from now), clnt: host@client.domain.tu-berlin.de, uid: -1, gid: -1, num aux grps: 0:
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: sending null reply
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: writing message: \x \x608202cf06092a864886f71201020201006e8202be308202baa003020105a10302010ea20703050020000000a3820194618201903082018ca003020105a10e1b0c54552d4245524c494e2e4445a2273025a003020103a11e301c1b036e66731b15616c6c2e6368656d2e74752d6265726c696e2e6465a382014a30820146a003
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: finished handling null request
> Jun 18 18:55:07 server  rpc.svcgssd[20418]: entering poll
> 
> 
> 
> Best and keep well
> Sebastian
> 
> 
> Sebastian Kraus
> Team IT am Institut für Chemie
> Gebäude C, Straße des 17. Juni 115, Raum C7
> 
> Technische Universität Berlin
> Fakultät II
> Institut für Chemie
> Sekretariat C3
> Straße des 17. Juni 135
> 10623 Berlin
> 
> ________________________________________
> From: J. Bruce Fields <bfields@fieldses.org>
> Sent: Saturday, June 20, 2020 19:03
> To: Kraus, Sebastian
> Cc: linux-nfs@vger.kernel.org
> Subject: Re: RPC Pipefs: Frequent parsing errors in client database
> 
> On Sat, Jun 20, 2020 at 11:35:56AM +0000, Kraus, Sebastian wrote:
> > In consequence, about a week ago, I decided to investigate the problem
> > in a deep manner by stracing the rpc.gssd daemon while running.  Since
> > then, the segementation violations were gone, but now lots of
> > complaints of the following type appear in the system log:
> >
> >  Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: can't open
> >  nfsd4_cb/clnt3bb/info: No such file or directory Jun 19 11:14:00 all
> >  rpc.gssd[23620]: ERROR: failed to parse nfsd4_cb/clnt3bb/info
> >
> >
> > This behaviour seems somehow strange to me.  But, one possible
> > explanation could be: The execution speed of rpc.gssd slows down while
> > being straced and the "true" reason for the segmentation violations
> > pops up.  I would argue, rpc.gssd trying to parse non-existing files
> > points anyway to an insane and defective behaviour of the RPC GSS user
> > space daemon implementation.
> 
> Those files under rpc_pipefs come and go.  rpc.gssd monitors directories
> under rpc_pipefs to learn about changes, and then tries to parse the
> files under any new directories.
> 
> The thing is, if rpc.gssd is a little fast, I think it's possible that
> it could get the notification about clnt3bb/ being created, and try to
> look up "info", before "info" itself is actually created.
> 
> Or alternatively, if clnt3bb/ is short-lived, it might not look up
> "info" until the directory's already been deleted again.
> 
> Neither problem should be fatal--rpc.gssd will get another update and
> adjust to the new situation soon enough.
> 
> So it may be that the reall error here is an unconditional log message
> in a case that's expected, not actually an error.
> 
> Or I could be wrong and maybe something else is happening.
> 
> But I think it'd be more useful to stay focused on the segfaults.
> 
> --b.
