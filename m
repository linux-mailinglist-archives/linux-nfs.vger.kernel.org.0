Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF314A673
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 15:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgA0OpU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 09:45:20 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39146 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgA0OpU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 09:45:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so7523545qtm.6;
        Mon, 27 Jan 2020 06:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rK7D2iXsN48KDxVTOSuslw0+8l6Uq1HTPLzR1oqiOhI=;
        b=vAIieNlXR8GeO/9nDXgZms4XMEAjrCTvAr4+x5+9C4zwrBCnKNHC3IEyzW+3WB7zep
         oVFODQ7IQ7PaurmB/SH9uGOCBb/6zWTDHmfOG7g3Sg4a+oJbZp+JQJ1mTdZYCp/7gk7u
         3Okqqo6DPwwy09lG8XgQu+xL59/dqj1aFFCZz1jDOj6Sx4EmgZbQIzjHQoMZ7sGmEkmf
         OJ5nF4HCxImZmscTyl2OugNdeccUmSSroWqpk7gw8RtNtQ9oGuze4jGS1QbItZDzJ/rl
         PwPtHkoWH8zbmDEUVi92CmnU+Vg68Tm6Rv9XEPuqggd3nNr/CiwtHRQ6tEuex3R3NCi6
         dRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rK7D2iXsN48KDxVTOSuslw0+8l6Uq1HTPLzR1oqiOhI=;
        b=gUlRGfl/P87Kgmg7tCFwhD/dEVLn6ehyDM8xkWdO82wYG5PixRZHgYVC1QAxhQ8KQN
         bq28XIeOJGMGGq/0ShBl3IOer94GuwXmSMHStrzHNlCNXp8yFxyy8R6QKKAXRD3jXglJ
         nl5ac3GMUlvAtsOSHRQ6t9YliPd5AJM65MJj9wlmS7jlqN6PUXRNAXrgXuYEGle/uhTD
         rRs6Z2zqnDQiQVmluipXyAmWOhZkRtxaQvAAntRBTIW1VKWMuSszWGdjgBkYX9M8za2K
         buRIAXPUVpg2zODP04mSqhRbOGj851nbOh8y5fEf1Gb4YErgfkt8MEQdASISQP3ioo+H
         gpCA==
X-Gm-Message-State: APjAAAX3LYW7n9pCtul4WgkvAmCGedEVpfxmDTJ8VEwH0GyvnqTtpZye
        CkogLpAqYDBt7QK6PqE5dLl3C77z6JpBrBBTmuc=
X-Google-Smtp-Source: APXvYqypyCTZOQcJSxxAvc6JuFimETzxpsf61lGctwQ11xYTZ0cvyiTJOGCWARnDYRykQeK04DB7a8arCyLFAeqjW4c=
X-Received: by 2002:ac8:198c:: with SMTP id u12mr13550302qtj.225.1580136318747;
 Mon, 27 Jan 2020 06:45:18 -0800 (PST)
MIME-Version: 1.0
References: <025801d5bf24$aa242100$fe6c6300$@gmail.com> <D82A1590-FAA3-47C5-B198-937ED88EF71C@oracle.com>
 <084f01d5cfba$bc5c4d10$3514e730$@gmail.com> <49e7b99bd1451a0dbb301915f655c73b3d9354df.camel@netapp.com>
 <a62e45ba968fe845fa757174efc0cab93c490d54.camel@hammerspace.com>
In-Reply-To: <a62e45ba968fe845fa757174efc0cab93c490d54.camel@hammerspace.com>
From:   Robert Milkowski <rmilkowski@gmail.com>
Date:   Mon, 27 Jan 2020 14:45:07 +0000
Message-ID: <CALbTx=GxuUmWu9Og_pv8TPbB0ZnOCA3vMqtyG4e18-4+zkY8=A@mail.gmail.com>
Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 23 Jan 2020 at 19:08, Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2020-01-22 at 19:10 +0000, Schumaker, Anna wrote:
> > Hi Robert,
> >
> > On Mon, 2020-01-20 at 17:55 +0000, Robert Milkowski wrote:
> > > > -----Original Message-----
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > Sent: 30 December 2019 15:37
> > > > To: Robert Milkowski <rmilkowski@gmail.com>
> > > > Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>; Trond
> > > > Myklebust
> > > > <trond.myklebust@hammerspace.com>; Anna Schumaker
> > > > <anna.schumaker@netapp.com>; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do
> > > > implicit
> > > > lease renewals
> > > >
> > > >
> > > >
> > > > > On Dec 30, 2019, at 10:20 AM, Robert Milkowski <
> > > > > rmilkowski@gmail.com>
> > > > wrote:
> > > > > From: Robert Milkowski <rmilkowski@gmail.com>
> > > > >
> > > > > Currently, each time nfs4_do_fsinfo() is called it will do an
> > > > > implicit
> > > > > NFS4 lease renewal, which is not compliant with the NFS4
> > > > specification.
> > > > > This can result in a lease being expired by an NFS server.
> > > > >
> > > > > Commit 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing
> > > > > leases")
> > > > > introduced implicit client lease renewal in nfs4_do_fsinfo(),
> > > > > which
> > > > > can result in the NFSv4.0 lease to expire on a server side, and
> > > > > servers returning NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.
> > > > >
> > > > > This can easily be reproduced by frequently unmounting a sub-
> > > > > mount,
> > > > > then stat'ing it to get it mounted again, which will delay or
> > > > > even
> > > > > completely prevent client from sending RENEW operations if no
> > > > > other
> > > > > NFS operations are issued. Eventually nfs server will expire
> > > > > client's
> > > > > lease and return an error on file access or next RENEW.
> > > > >
> > > > > This can also happen when a sub-mount is automatically
> > > > > unmounted due
> > > > > to inactivity (after nfs_mountpoint_expiry_timeout), then it is
> > > > > mounted again via stat(). This can result in a short window
> > > > > during
> > > > > which client's lease will expire on a server but not on a
> > > > > client.
> > > > > This specific case was observed on production systems.
> > > > >
> > > > > This patch makes an explicit lease renewal instead of an
> > > > > implicit one,
> > > > > by adding RENEW to a compound operation issued by
> > > > > nfs4_do_fsinfo(),
> > > > > similarly to NFSv4.1 which adds SEQUENCE operation.
> > > > >
> > > > > Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing
> > > > > leases")
> > > > > Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
> > > >
> > > > Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> > > >
> > > >
> > >
> > > How do we progress it further?
> >
> > Thanks for following up! I have the patch included in my linux-next
> > branch for
> > the next merge window.
>
> NACK. This is the wrong way to solve the problem. Lease renewal in
> NFSv4 does not need to be tied to fsinfo. It creates an unnecessary
> extra error condition that has absolutely nothing to do with the
> functionality of retrieving per-filesystem attributes.

Well, we also do it for NFSv4.1+ with the SEQUENCE operation being
send by fsinfo, and as Chuck pointed out
it makes sense to do similarly for 4.0, which is what this patch does.

Or as per the v2 version of the patch, not do the implicit RENEW for
4.0, which was a simpler patch,
but then not in-line with 4.1+.

>
> All that needs to be done here is to move the setting of clp-
> >cl_last_renewal _out_ of nfs4_set_lease_period(), and just have
> nfs4_proc_setclientid_confirm() and nfs4_update_session() call
> do_renew_lease().
>

This would also require nfs4_setup_state_renewal() to call
do_renew_lease() I think - at least it currently calls
nfs4_set_lease_period().
Also, iirc fsinfo() not setting cl_last_renewal leads to
cl_last_renewal initialization issues under some circumstances.

Then the RFC 7530 in section 16.34.5 states:
"SETCLIENTID_CONFIRM does not establish or renew a lease.", so calling
do_renew_lease() from nfs4_setclientid_confirm() doesn't seem to be
ok.

I'm not sure if is is valid to do implicit lease renewal in
nfs4_update_session() either...


Anyway, the patch would be something like (haven't tested it yet):

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..a7af864 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5019,16 +5019,13 @@ static int nfs4_do_fsinfo(struct nfs_server
*server, struct nfs_fh *fhandle, str
        struct nfs4_exception exception = {
                .interruptible = true,
        };
-       unsigned long now = jiffies;
        int err;

        do {
                err = _nfs4_do_fsinfo(server, fhandle, fsinfo);
                trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
                if (err == 0) {
-                       nfs4_set_lease_period(server->nfs_client,
-                                       fsinfo->lease_time * HZ,
-                                       now);
+                       nfs4_set_lease_period(server->nfs_client,
fsinfo->lease_time * HZ)
                        break;
                }
                err = nfs4_handle_exception(server, err, &exception);
@@ -6146,6 +6143,10 @@ int nfs4_proc_setclientid_confirm(struct nfs_client *clp,
                clp->cl_clientid);
        status = rpc_call_sync(clp->cl_rpcclient, &msg,
                               RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN);
+       if(status == 0) {
+               unsigned long now = jiffies;
+               do_renew_lease(clp, now);
+       }
        trace_nfs4_setclientid_confirm(clp, status);
        dprintk("NFS reply setclientid_confirm: %d\n", status);
        return status;
@@ -8590,6 +8591,8 @@ static void nfs4_update_session(struct
nfs4_session *session,
        if (res->flags & SESSION4_BACK_CHAN)
                memcpy(&session->bc_attrs, &res->bc_attrs,
                                sizeof(session->bc_attrs));
+       unsigned long now = jiffies;
+       do_renew_lease(session->clp, now);
 }

 static int _nfs4_proc_create_session(struct nfs_client *clp,
diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index 6ea431b..ff876dd 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -138,15 +138,12 @@
  *
  * @clp: pointer to nfs_client
  * @lease: new value for lease period
- * @lastrenewed: time at which lease was last renewed
  */
 void nfs4_set_lease_period(struct nfs_client *clp,
-               unsigned long lease,
-               unsigned long lastrenewed)
+               unsigned long lease)
 {
        spin_lock(&clp->cl_lock);
        clp->cl_lease_time = lease;
-       clp->cl_last_renewal = lastrenewed;
        spin_unlock(&clp->cl_lock);

        /* Cap maximum reconnect timeout at 1/2 lease period */
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 3455232..d7b02fd 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -102,7 +102,8 @@ static int nfs4_setup_state_renewal(struct nfs_client *clp)
        now = jiffies;
        status = nfs4_proc_get_lease_time(clp, &fsinfo);
        if (status == 0) {
-               nfs4_set_lease_period(clp, fsinfo.lease_time * HZ, now);
+               nfs4_set_lease_period(clp, fsinfo.lease_time * HZ);
+               nfs4_do_renew_lease(clp, now);
                nfs4_schedule_state_renewal(clp);
        }



But it potentially has issues, as just pointed out, mainly with not
being compliant with rfc again.

Also see the comments above about the SEQUENCE.
Trond - ?

Chuck, Anna - which way do you prefer, the one proposed by Chuck or
the one now proposed by Trond?

Or perhaps my v2 patch which is least invasive and just stops doing
implicit renewals for 4.0 if cl_last_renewal is already set.

I personally think the way proposed by Chuck is fully compliant with
RFC and in-line with what we currently do for 4.1 via SEQUENCE,
so perhaps the best option. ?

-- 
Robert Milkowski
