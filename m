Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05445342C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhKPObx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 09:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhKPObw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 09:31:52 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9FFC061570
        for <linux-nfs@vger.kernel.org>; Tue, 16 Nov 2021 06:28:54 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1DB0F37C8; Tue, 16 Nov 2021 09:28:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1DB0F37C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637072934;
        bh=a0MUmAGD3kAuzr/AOWwaVWs5blPHRTBWWI1S/7huiKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9NQTWtnfn3OfXTggpGV00+MzOBdahgg2ijyPvGv70/p4r83uREX6V/bc/5eg0y/Z
         Sh3FzfTV6XTeksoRaF7sXRR3Hr9sZOb7PL0tow4ELymdfQChPjWRH6HDp6DOiAo81g
         WAHVEWV906yMBsDsNoZYufaS1O4fTDTPXaIL+pe8=
Date:   Tue, 16 Nov 2021 09:28:54 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Volodymyr Khomenko <volodymyr@vastdata.com>
Cc:     linux-nfs@vger.kernel.org,
        Ilan Steinberg <ilan.steinberg@vastdata.com>
Subject: Re: NFS4 RPCGSS state protection (SP4_MACH_CRED) is not handled
Message-ID: <20211116142854.GB8695@fieldses.org>
References: <CANkgwevBKzrz_rDt0djguCXLsQWuTj8WwHNia0Bk+LSgDK-aQw@mail.gmail.com>
 <20211115155058.GA22737@fieldses.org>
 <CANkgwevkUHSBb7Z4BDNXqazHmVOvLd1vucrZjiWRWxiADcA05A@mail.gmail.com>
 <20211115194623.GH23884@fieldses.org>
 <CANkgwesf8pXeYzykoygLKe0nZOq+=qx9xv1ZvcZ+8_9TADAe1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANkgwesf8pXeYzykoygLKe0nZOq+=qx9xv1ZvcZ+8_9TADAe1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 16, 2021 at 10:46:27AM +0200, Volodymyr Khomenko wrote:
> Well, I tend to agree with you that probably
> EXCHGID4_FLAG_BIND_PRINC_STATEID is the root-cause of this particular
> corner-case described by RFC.
> However I still feel that using the same NFS4 session (established by
> EXCHANGE_ID from RPCGSS) from an unprotected state is NOT something we
> want to allow.
> 
> I understand that the guarantee of protection can happen only when NFS
> export allows only RPCGSS flavor (sec=krb5* on export definition and
> not 'sys/none'),
> so clients are not allowed to use AUTH_UNIX at all (in terms of
> security protection).
> 
> Bottom line - I still can't find/reproduce some scenario where I can
> show this security issue due to missing spo_must_allow support:
> 1. NFS4 export is allowed only for sec=krb5i:krb5p (i.e. safe
> protection for clients' traffic).
> 2. Client1 makes NFS4.1 requests with gss_service_integrity (krb5i) to
> establish client+session and does some operation with a file (stateid
> is created). Client2 is able to monitor all this traffic (because the
> traffic is not encoded).
> 3. Client2 can send some NFS4 request with AUTH_UNIX (or with
> gss_service_none=krb5 request - leaving RPC header from a packet
> caught from client1 but replacing NFS4 body)
> to make a harm/additional information disclosure for client1
> (offensive action): like close the stateid from the scope of the
> session by client1, write corrupted data to the same stateid, corrupt
> the session/client, etc.
> 
> In this scenario AUTH_UNIX requests on step3 may be replied by
> WRONGSEC error from the server if client2 uses put filehandle, lookup
> or open with a name operation (only in this case server is allowed to
> use this error).
> Otherwise, all other operations cannot return WRONGSEC so AUTH_UNIX
> packet must be accepted and processed. But indeed - it's too hard to
> find some intrusive/offensive operation without putfh/lookup/open.
> 
> Probably I need more time to try it and think a bit more...

You may be able to get the slot sequence numbers out of sync,
effectively a DoS--though perhaps that's not any worse than you could
already do at the TCP level.

I don't know, maybe there's something here.

If so, this would be discussion for the ietf working group list, I think
(nfsv4@ietf.org).  And if we were tighten requirements, we'd also need
to check that we aren't breaking interoperability with existing clients.

--b.

> 
> volodymyr.
> 
> > On Mon, Nov 15, 2021 at 9:46 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Nov 15, 2021 at 09:35:51PM +0200, Volodymyr Khomenko wrote:
> > > > Does the spec require that?
> > >
> > > Unfortunately the spec is not explicit about this use-case.
> > > However we have a detailed rationale of the 'spo_must_allow' option there.
> > > It says that 'The client will be unable to send CLOSE without the
> > > user's credentials' if users GSS credentials are expired.
> > > Meaning that AUTH_UNIX credentials (with user UID/GID) is not a valid
> > > way to solve this issue - from my understanding:
> >
> > See the discussion of EXCHGID4_FLAG_BIND_PRINC_STATEID:
> >
> >         https://datatracker.ietf.org/doc/html/rfc5661#page-502
> >
> >         When EXCHGID4_FLAG_BIND_PRINC_STATEID is set, the client
> >         indicates that it wants the server to bind the stateid to the
> >         principal.  This means that when a principal creates a stateid,
> >         it has to be the one to use the stateid.
> >
> > So that's what's forcing the use of GSS in this case.  The OPEN that
> > created the used a certain GSS principal, so the CLOSE would normally
> > have to as well; spo_must_allow gives the client an out in this case.
> >
> > It's not meant to imply that GSS must be used for all operations
> > whenever state protection is used.
> >
> > --b.
> >
> > >
> > >
> > > rfc5661:
> > >
> > >
> > >    The purpose of spo_must_allow is to allow clients to solve the
> > >    following conundrum.  Suppose the client ID is confirmed with
> > >    EXCHGID4_FLAG_BIND_PRINC_STATEID, and it calls OPEN with the
> > >    RPCSEC_GSS credentials of a normal user.  Now suppose the user's
> > >    credentials expire, and cannot be renewed (e.g., a Kerberos ticket
> > >    granting ticket expires, and the user has logged off and will not be
> > >    acquiring a new ticket granting ticket).  The client will be unable
> > >    to send CLOSE without the user's credentials, which is to say the
> > >    client has to either leave the state on the server or re-send
> > >    EXCHANGE_ID with a new verifier to clear all state, that is, unless
> > >    the client includes CLOSE on the list of operations in spo_must_allow
> > >    and the server agrees.
> > >
> > > volodymyr.
> > >
> > > On Mon, Nov 15, 2021 at 5:50 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > > >
> > > > On Mon, Nov 15, 2021 at 04:37:10PM +0200, Volodymyr Khomenko wrote:
> > > > > Hello linux-nfs,
> > > > >
> > > > > We have the following NFS4 test (implemented using pynfs framework,
> > > > > not regular NFS4 client):
> > > > > 1. NFS4 client wants to use RPCGSS (Kerberos) and starts NFS4 traffic
> > > > > with NFS4 NULL request to establish RPCGSS context of a machine
> > > > > account.
> > > > > 2. During EXCHANGE_ID operation (client establishment), client asks
> > > > > for SP4_MACH_CRED state protection with
> > > > > spo_must_enforce/spo_must_allow fields set to values that are usually
> > > > > used by NFS4 clients (as defined by rfc5661).
> > > > > 3. CREATE_SESSION and RECLAIM_COMPLETE operations (required for NFS4
> > > > > session) are also done with RPCGSS and sevice=svc_gss_integrity - as
> > > > > required by spo_must_enforce option of state protection. If
> > > > > CREATE_SESSION is done with the wrong protection type, error is
> > > > > returned to the client (as expected).
> > > > > 4. However, when operations that are neither in spo_must_enforce nor
> > > > > in spo_must_allow list are done with the wrong protection type
> > > > > (flavor=AUTH_UNIX), NFS server accepts the request and replies by
> > > > > unexpected result (NFS4_OK) instead of error. In our test we used
> > > > > SEQUENCE + PUTROOTFH + GETFH compound operation with RPC credentials
> > > > > using flavor=AUTH_UNIX instead of RPCGSS.
> > > > >
> > > > > As for me, it looks like a security issue: client asked for state
> > > > > protection but man-in-the-middle can make unprotected requests for
> > > > > state-protected client and session. Expected behaviour from my side
> > > > > is:
> > > > > if NFS4 operation (like GETFH) from state-protected client is neither
> > > > > in spo_must_enforce nor in spo_must_allow lists of SP4_MACH_CRED, the
> > > > > server must fail the request if used credentials has a different
> > > > > flavor than RPCGSS (neither user GSS context nor machine account GSS
> > > > > context).
> > > >
> > > > There are two separate questions here:
> > > >
> > > >         - Does the spec require that?
> > > >         - Should the server do it anyway?
> > > >
> > > > I think the answer to the first question is "no".  If the requirement is
> > > > in the language you've quoted below, I'm not seeing it.  As far as I can
> > > > tell, GSS is required only for operations in spo_must_enforce.
> > > >
> > > > I haven't thought about #2 very much.  If an operation's not in
> > > > spo_must_support, I think the server just checks the sec= option on the
> > > > export.  If we were to require something more than that, I guess that
> > > > would affect the values returned from SECINFO and friends too.
> > > >
> > > > I think the spec's meant to allow the client to use a combination of
> > > > krb5 and sys, and that current server behavior is correct, though it's
> > > > always possible there's some case I haven't thought through.
> > > >
> > > > --b.
> > > >
> > > > >
> > > > > >From rfc5661 (18.35.3.  DESCRIPTION):
> > > > >
> > > > >    o  For SP4_MACH_CRED or SP4_SSV state protection:
> > > > >
> > > > >       *  The list of operations (spo_must_enforce) that MUST use the
> > > > >          specified state protection.  This list comes from the results
> > > > >          of EXCHANGE_ID.
> > > > >
> > > > >       *  The list of operations (spo_must_allow) that MAY use the
> > > > >          specified state protection.  This list comes from the results
> > > > >          of EXCHANGE_ID.
> > > > >
> > > > > ...
> > > > >
> > > > >    o  SP4_MACH_CRED.  If spa_how is SP4_MACH_CRED, then the client MUST
> > > > >       send the EXCHANGE_ID request with RPCSEC_GSS as the security
> > > > >       flavor, and with a service of RPC_GSS_SVC_INTEGRITY or
> > > > >       RPC_GSS_SVC_PRIVACY.  If SP4_MACH_CRED is specified, then the
> > > > >       client wants to use an RPCSEC_GSS-based machine credential to
> > > > >       protect its state.  The server MUST note the principal the
> > > > >       EXCHANGE_ID operation was sent with, and the GSS mechanism used.
> > > > >       These notes collectively comprise the machine credential.
> > > > >
> > > > > Please see pcap file of the traffic (attached) - EXCHANGE_ID with
> > > > > SP4_MACH_CRED is the packet #41 and problematic PUTROOTFH + GETFH
> > > > > request is the packet #49.
> > > > >
> > > > > User linux NFS4 server was:
> > > > > [centos@rnd-nfs4-srv01 ~]$ uname -a
> > > > > Linux rnd-nfs4-srv01 3.10.0-1062.18.1.el7.x86_64 #1 SMP Tue Mar 17
> > > > > 23:49:17 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> > > > >
> > > > > [centos@rnd-nfs4-srv01 ~]$ cat /etc/redhat-release
> > > > > CentOS Linux release 7.7.1908 (Core)
> > > >
> > > >
