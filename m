Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E8D4515DD
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Nov 2021 21:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345063AbhKOU5C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 15:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347490AbhKOTj7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 14:39:59 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE529C061230
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 11:36:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c32so46471538lfv.4
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 11:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+EnPOs9WIlyi7q11vMx2LG2XZ0foshVWMljmch2pOk=;
        b=EZbw9lbAkRgTz+EtmqPeRzrleqStSjdqqsVaZDc7CNpzZEYRAA6fnQdlwqK8l2Sciv
         jtYKcbNrc7MmWLfUJoyLHIRJqDPaPSIH12rtOPMD2DE9Fwf1ZAvossfZkBlZaeG5cXXb
         to7MwLgq0JddBQpzaKVUa5LXmO+WH1mpnqBVUhrwvNitGA7+P4NH7/PYX1mZRiyunZ/Z
         HGEpJn0vwwjDi4WWurcPZyBlgNl0aCgTRVPM/tF0bIWFA+HLBo3Mci8Yxvx173i5pv8m
         YMf0OZD3wJXxFgAHSGk3OhppKqUbhJpkZysDT1J6OoKlwaDX7Y2/C7ySMD8MHVd+7l0A
         FPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+EnPOs9WIlyi7q11vMx2LG2XZ0foshVWMljmch2pOk=;
        b=htQuMukUPQXnsBJbD2ciqWddKr2uiNt1pEm4MCeqO93s26bCezS7W0vA9w2/YmROVP
         ykMy2H06Byi/iCKheFPoKDF3JSNDg46b6YbKss+kR5G8OFZXGbdNgeef7oh/sfBdajoD
         +N4S/qiv4mve1YrQ5syxOQKS9ucUMhpikoz1O+6oA8EKFicoX+HvFcZvisqBu7JgwYvx
         U8ahl/0n+kObG88SlF2nlAyTyjBzt/a9R6muSLmUg/puRCbpkb6S8DcJhkjjl6uMW02f
         0yJInkNxYUe30CaIAbmh8OHrzjq5mcuubsTMOPvtl4cDkfWc1Ag8+ptskwj+m1tDwQv1
         54zA==
X-Gm-Message-State: AOAM5305Mwi2GDSbx8ertbZjJzTbs2UXBgov5t/DwiZ8GL6SkvtOAEF8
        Z0plfZDIxZOfqCw9RAZKYfHvn5T92M4cDdVh9fNdGA==
X-Google-Smtp-Source: ABdhPJxKYy7yhIqNI/A+WgGdVdAz/Ybos5agCKmTYk2OMs5k+4/rRu6dmJlnya1E61Ngxjq1ao4MaMVD6KuStkj43u4=
X-Received: by 2002:a05:6512:4012:: with SMTP id br18mr1030625lfb.215.1637004962343;
 Mon, 15 Nov 2021 11:36:02 -0800 (PST)
MIME-Version: 1.0
References: <CANkgwevBKzrz_rDt0djguCXLsQWuTj8WwHNia0Bk+LSgDK-aQw@mail.gmail.com>
 <20211115155058.GA22737@fieldses.org>
In-Reply-To: <20211115155058.GA22737@fieldses.org>
From:   Volodymyr Khomenko <volodymyr@vastdata.com>
Date:   Mon, 15 Nov 2021 21:35:51 +0200
Message-ID: <CANkgwevkUHSBb7Z4BDNXqazHmVOvLd1vucrZjiWRWxiADcA05A@mail.gmail.com>
Subject: Re: NFS4 RPCGSS state protection (SP4_MACH_CRED) is not handled
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org,
        Ilan Steinberg <ilan.steinberg@vastdata.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Does the spec require that?

Unfortunately the spec is not explicit about this use-case.
However we have a detailed rationale of the 'spo_must_allow' option there.
It says that 'The client will be unable to send CLOSE without the
user's credentials' if users GSS credentials are expired.
Meaning that AUTH_UNIX credentials (with user UID/GID) is not a valid
way to solve this issue - from my understanding:


rfc5661:


   The purpose of spo_must_allow is to allow clients to solve the
   following conundrum.  Suppose the client ID is confirmed with
   EXCHGID4_FLAG_BIND_PRINC_STATEID, and it calls OPEN with the
   RPCSEC_GSS credentials of a normal user.  Now suppose the user's
   credentials expire, and cannot be renewed (e.g., a Kerberos ticket
   granting ticket expires, and the user has logged off and will not be
   acquiring a new ticket granting ticket).  The client will be unable
   to send CLOSE without the user's credentials, which is to say the
   client has to either leave the state on the server or re-send
   EXCHANGE_ID with a new verifier to clear all state, that is, unless
   the client includes CLOSE on the list of operations in spo_must_allow
   and the server agrees.

volodymyr.

On Mon, Nov 15, 2021 at 5:50 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Nov 15, 2021 at 04:37:10PM +0200, Volodymyr Khomenko wrote:
> > Hello linux-nfs,
> >
> > We have the following NFS4 test (implemented using pynfs framework,
> > not regular NFS4 client):
> > 1. NFS4 client wants to use RPCGSS (Kerberos) and starts NFS4 traffic
> > with NFS4 NULL request to establish RPCGSS context of a machine
> > account.
> > 2. During EXCHANGE_ID operation (client establishment), client asks
> > for SP4_MACH_CRED state protection with
> > spo_must_enforce/spo_must_allow fields set to values that are usually
> > used by NFS4 clients (as defined by rfc5661).
> > 3. CREATE_SESSION and RECLAIM_COMPLETE operations (required for NFS4
> > session) are also done with RPCGSS and sevice=svc_gss_integrity - as
> > required by spo_must_enforce option of state protection. If
> > CREATE_SESSION is done with the wrong protection type, error is
> > returned to the client (as expected).
> > 4. However, when operations that are neither in spo_must_enforce nor
> > in spo_must_allow list are done with the wrong protection type
> > (flavor=AUTH_UNIX), NFS server accepts the request and replies by
> > unexpected result (NFS4_OK) instead of error. In our test we used
> > SEQUENCE + PUTROOTFH + GETFH compound operation with RPC credentials
> > using flavor=AUTH_UNIX instead of RPCGSS.
> >
> > As for me, it looks like a security issue: client asked for state
> > protection but man-in-the-middle can make unprotected requests for
> > state-protected client and session. Expected behaviour from my side
> > is:
> > if NFS4 operation (like GETFH) from state-protected client is neither
> > in spo_must_enforce nor in spo_must_allow lists of SP4_MACH_CRED, the
> > server must fail the request if used credentials has a different
> > flavor than RPCGSS (neither user GSS context nor machine account GSS
> > context).
>
> There are two separate questions here:
>
>         - Does the spec require that?
>         - Should the server do it anyway?
>
> I think the answer to the first question is "no".  If the requirement is
> in the language you've quoted below, I'm not seeing it.  As far as I can
> tell, GSS is required only for operations in spo_must_enforce.
>
> I haven't thought about #2 very much.  If an operation's not in
> spo_must_support, I think the server just checks the sec= option on the
> export.  If we were to require something more than that, I guess that
> would affect the values returned from SECINFO and friends too.
>
> I think the spec's meant to allow the client to use a combination of
> krb5 and sys, and that current server behavior is correct, though it's
> always possible there's some case I haven't thought through.
>
> --b.
>
> >
> > >From rfc5661 (18.35.3.  DESCRIPTION):
> >
> >    o  For SP4_MACH_CRED or SP4_SSV state protection:
> >
> >       *  The list of operations (spo_must_enforce) that MUST use the
> >          specified state protection.  This list comes from the results
> >          of EXCHANGE_ID.
> >
> >       *  The list of operations (spo_must_allow) that MAY use the
> >          specified state protection.  This list comes from the results
> >          of EXCHANGE_ID.
> >
> > ...
> >
> >    o  SP4_MACH_CRED.  If spa_how is SP4_MACH_CRED, then the client MUST
> >       send the EXCHANGE_ID request with RPCSEC_GSS as the security
> >       flavor, and with a service of RPC_GSS_SVC_INTEGRITY or
> >       RPC_GSS_SVC_PRIVACY.  If SP4_MACH_CRED is specified, then the
> >       client wants to use an RPCSEC_GSS-based machine credential to
> >       protect its state.  The server MUST note the principal the
> >       EXCHANGE_ID operation was sent with, and the GSS mechanism used.
> >       These notes collectively comprise the machine credential.
> >
> > Please see pcap file of the traffic (attached) - EXCHANGE_ID with
> > SP4_MACH_CRED is the packet #41 and problematic PUTROOTFH + GETFH
> > request is the packet #49.
> >
> > User linux NFS4 server was:
> > [centos@rnd-nfs4-srv01 ~]$ uname -a
> > Linux rnd-nfs4-srv01 3.10.0-1062.18.1.el7.x86_64 #1 SMP Tue Mar 17
> > 23:49:17 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> >
> > [centos@rnd-nfs4-srv01 ~]$ cat /etc/redhat-release
> > CentOS Linux release 7.7.1908 (Core)
>
>
