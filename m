Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76014515DF
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Nov 2021 21:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhKOU5L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 15:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347465AbhKOUJV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 15:09:21 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784CEC061227
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 11:46:25 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A51416F4B; Mon, 15 Nov 2021 14:46:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A51416F4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637005583;
        bh=FeN6v9h5OhzpAuKfYuaiY8GOkJvwtW7YDOoNFcwVNYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cA7dk2w3hj1IgtCOpcbWSNFDjQFr3/z07khKLYX9ObBMcTLsMK6oRGqzL/97HWjuD
         LS/+P+OTug6ckiD8Ts3OUJg1x+4nE8K0OvSLtDfH2dBbRoH+wPhlFGnmnO82MbP9d4
         yGBud/NJaQ8ILPtbb5OsIQ5TOnJW4z7QMYMb35hU=
Date:   Mon, 15 Nov 2021 14:46:23 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Volodymyr Khomenko <volodymyr@vastdata.com>
Cc:     linux-nfs@vger.kernel.org,
        Ilan Steinberg <ilan.steinberg@vastdata.com>
Subject: Re: NFS4 RPCGSS state protection (SP4_MACH_CRED) is not handled
Message-ID: <20211115194623.GH23884@fieldses.org>
References: <CANkgwevBKzrz_rDt0djguCXLsQWuTj8WwHNia0Bk+LSgDK-aQw@mail.gmail.com>
 <20211115155058.GA22737@fieldses.org>
 <CANkgwevkUHSBb7Z4BDNXqazHmVOvLd1vucrZjiWRWxiADcA05A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANkgwevkUHSBb7Z4BDNXqazHmVOvLd1vucrZjiWRWxiADcA05A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 15, 2021 at 09:35:51PM +0200, Volodymyr Khomenko wrote:
> > Does the spec require that?
> 
> Unfortunately the spec is not explicit about this use-case.
> However we have a detailed rationale of the 'spo_must_allow' option there.
> It says that 'The client will be unable to send CLOSE without the
> user's credentials' if users GSS credentials are expired.
> Meaning that AUTH_UNIX credentials (with user UID/GID) is not a valid
> way to solve this issue - from my understanding:

See the discussion of EXCHGID4_FLAG_BIND_PRINC_STATEID:

	https://datatracker.ietf.org/doc/html/rfc5661#page-502

	When EXCHGID4_FLAG_BIND_PRINC_STATEID is set, the client
	indicates that it wants the server to bind the stateid to the
	principal.  This means that when a principal creates a stateid,
	it has to be the one to use the stateid.

So that's what's forcing the use of GSS in this case.  The OPEN that
created the used a certain GSS principal, so the CLOSE would normally
have to as well; spo_must_allow gives the client an out in this case.

It's not meant to imply that GSS must be used for all operations
whenever state protection is used.

--b.

> 
> 
> rfc5661:
> 
> 
>    The purpose of spo_must_allow is to allow clients to solve the
>    following conundrum.  Suppose the client ID is confirmed with
>    EXCHGID4_FLAG_BIND_PRINC_STATEID, and it calls OPEN with the
>    RPCSEC_GSS credentials of a normal user.  Now suppose the user's
>    credentials expire, and cannot be renewed (e.g., a Kerberos ticket
>    granting ticket expires, and the user has logged off and will not be
>    acquiring a new ticket granting ticket).  The client will be unable
>    to send CLOSE without the user's credentials, which is to say the
>    client has to either leave the state on the server or re-send
>    EXCHANGE_ID with a new verifier to clear all state, that is, unless
>    the client includes CLOSE on the list of operations in spo_must_allow
>    and the server agrees.
> 
> volodymyr.
> 
> On Mon, Nov 15, 2021 at 5:50 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Nov 15, 2021 at 04:37:10PM +0200, Volodymyr Khomenko wrote:
> > > Hello linux-nfs,
> > >
> > > We have the following NFS4 test (implemented using pynfs framework,
> > > not regular NFS4 client):
> > > 1. NFS4 client wants to use RPCGSS (Kerberos) and starts NFS4 traffic
> > > with NFS4 NULL request to establish RPCGSS context of a machine
> > > account.
> > > 2. During EXCHANGE_ID operation (client establishment), client asks
> > > for SP4_MACH_CRED state protection with
> > > spo_must_enforce/spo_must_allow fields set to values that are usually
> > > used by NFS4 clients (as defined by rfc5661).
> > > 3. CREATE_SESSION and RECLAIM_COMPLETE operations (required for NFS4
> > > session) are also done with RPCGSS and sevice=svc_gss_integrity - as
> > > required by spo_must_enforce option of state protection. If
> > > CREATE_SESSION is done with the wrong protection type, error is
> > > returned to the client (as expected).
> > > 4. However, when operations that are neither in spo_must_enforce nor
> > > in spo_must_allow list are done with the wrong protection type
> > > (flavor=AUTH_UNIX), NFS server accepts the request and replies by
> > > unexpected result (NFS4_OK) instead of error. In our test we used
> > > SEQUENCE + PUTROOTFH + GETFH compound operation with RPC credentials
> > > using flavor=AUTH_UNIX instead of RPCGSS.
> > >
> > > As for me, it looks like a security issue: client asked for state
> > > protection but man-in-the-middle can make unprotected requests for
> > > state-protected client and session. Expected behaviour from my side
> > > is:
> > > if NFS4 operation (like GETFH) from state-protected client is neither
> > > in spo_must_enforce nor in spo_must_allow lists of SP4_MACH_CRED, the
> > > server must fail the request if used credentials has a different
> > > flavor than RPCGSS (neither user GSS context nor machine account GSS
> > > context).
> >
> > There are two separate questions here:
> >
> >         - Does the spec require that?
> >         - Should the server do it anyway?
> >
> > I think the answer to the first question is "no".  If the requirement is
> > in the language you've quoted below, I'm not seeing it.  As far as I can
> > tell, GSS is required only for operations in spo_must_enforce.
> >
> > I haven't thought about #2 very much.  If an operation's not in
> > spo_must_support, I think the server just checks the sec= option on the
> > export.  If we were to require something more than that, I guess that
> > would affect the values returned from SECINFO and friends too.
> >
> > I think the spec's meant to allow the client to use a combination of
> > krb5 and sys, and that current server behavior is correct, though it's
> > always possible there's some case I haven't thought through.
> >
> > --b.
> >
> > >
> > > >From rfc5661 (18.35.3.  DESCRIPTION):
> > >
> > >    o  For SP4_MACH_CRED or SP4_SSV state protection:
> > >
> > >       *  The list of operations (spo_must_enforce) that MUST use the
> > >          specified state protection.  This list comes from the results
> > >          of EXCHANGE_ID.
> > >
> > >       *  The list of operations (spo_must_allow) that MAY use the
> > >          specified state protection.  This list comes from the results
> > >          of EXCHANGE_ID.
> > >
> > > ...
> > >
> > >    o  SP4_MACH_CRED.  If spa_how is SP4_MACH_CRED, then the client MUST
> > >       send the EXCHANGE_ID request with RPCSEC_GSS as the security
> > >       flavor, and with a service of RPC_GSS_SVC_INTEGRITY or
> > >       RPC_GSS_SVC_PRIVACY.  If SP4_MACH_CRED is specified, then the
> > >       client wants to use an RPCSEC_GSS-based machine credential to
> > >       protect its state.  The server MUST note the principal the
> > >       EXCHANGE_ID operation was sent with, and the GSS mechanism used.
> > >       These notes collectively comprise the machine credential.
> > >
> > > Please see pcap file of the traffic (attached) - EXCHANGE_ID with
> > > SP4_MACH_CRED is the packet #41 and problematic PUTROOTFH + GETFH
> > > request is the packet #49.
> > >
> > > User linux NFS4 server was:
> > > [centos@rnd-nfs4-srv01 ~]$ uname -a
> > > Linux rnd-nfs4-srv01 3.10.0-1062.18.1.el7.x86_64 #1 SMP Tue Mar 17
> > > 23:49:17 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> > >
> > > [centos@rnd-nfs4-srv01 ~]$ cat /etc/redhat-release
> > > CentOS Linux release 7.7.1908 (Core)
> >
> >
