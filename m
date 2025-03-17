Return-Path: <linux-nfs+bounces-10631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A63A65B67
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 18:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A260A189ACE8
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E551A5BBA;
	Mon, 17 Mar 2025 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Jmmo6FAx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908B1A4F3C
	for <linux-nfs@vger.kernel.org>; Mon, 17 Mar 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233746; cv=none; b=UmISLRpZoBWLiS3usr1DC4JP04dRp2MIOuevv3N4OU0yuM6xBfQsgwGoVOLt0WbGDMz1y5mOa+jWY1Iv2VYQhcCOY9+ais1SqOpbuqMR6jriTdSRDlOOxmJd+hmK36oaAaiff1V75uJ0I0Djxy4a1gw7KixyWAhRC6AQxEh0C50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233746; c=relaxed/simple;
	bh=QkAs+QIH2hRvdrCaUDspeyXLQlRRW0HRlNru35A0cAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbEua/K32sPvxE1Rppx05w4dTVRzO29nwn+kel704wVcYzCtLK6R+Xpvt4vnoa6bcORIXWZXBaW/I6XOH/rQNfxFeQ578PuaatBH9IpI0aINx723VnBmqGjYmRGX3nn00vv6TVU70sTTe1fgyvk0Rqc8ZMcfLfDqfW5lxKPpyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Jmmo6FAx; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30c05fd126cso45176311fa.3
        for <linux-nfs@vger.kernel.org>; Mon, 17 Mar 2025 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1742233742; x=1742838542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzq/Y7tbWrBRfu+ABND+1kMbydQwu7mVDuaQUS/4XE8=;
        b=Jmmo6FAxQrLZ64jmXI4Cn6FbVRj0pXR9cFn+YzmYhsaSeTPvtZRgxF+D1hQSbHkqrD
         ae0Vlm2xAsBGVOzJg42OysqoVvVNVejQw7lYR0fs1qGS3Vo1zBFyQ9+jGMbbdBSZ6OnP
         QKNZyhfKoCM4TJC4hU5fGpWujPWEI/5o9NCJgy80DGL8b6B2saGueNplya7iBDG1RQXf
         C/CNKdHr3co6dBGom/wSiGK4KALk8CufrcNNU3YFLy7BUz2qYxgzFbpByuZtavCgvM+I
         GTpyk20yZJPwwWu3JtEvufbQtjyMnRCxSlPpA846EPlfx/2FMwX/na4rafbnXffF/24P
         x21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233742; x=1742838542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzq/Y7tbWrBRfu+ABND+1kMbydQwu7mVDuaQUS/4XE8=;
        b=Ojp4vH4YAuVcowyBeUyaSyiLWvJJHDspEK60M+D9yTfhzdItZWRYbArzaBCeYEjYkP
         Fq9Qmg5iewsEaOpdRmS0+JTp/3eDxq/cOwmz/gXXLVp566YqC/hIpS+od9ZsLmlmGnRy
         J6rUOyXASabAP03oSQcrhK3+l5q9OYkq55EjSWDYGHAFBh6iLzweeOs3/FxpmlUHbtr/
         6skmJUZ4GxRZDPuZ9NGlD/TBLnqBp8sNIq3flYgc28FZsAsMC2kWANCe4opAJnO+OqeH
         7r0dmizC9hH0hLdhTPGsIGAS9V+cnSNow5sHVW1yk6Vuyk1i5/ic7R5kCluhgEWyMEQg
         z/xA==
X-Forwarded-Encrypted: i=1; AJvYcCW3734bEm60PdGYaAKfhjZNdJNO7GG/jnHAIIw4I55BlhYxFIWg1Kv/oND2a93Y1XaYRMjNNYYy5R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQmVvh9ATv5Y5GdSlcQ0Z34dXuaNn0zykoAO/hITWZiAJnt6L
	rCsNy2G2uJBtWnWHGKTqaQ/AEJ9XyZYs70Qc6D2Q5ntFKSziPodbV779Ay3KsouWTTwvPvMJTeZ
	LO1BVsJiE5LxkOaJebsUfu6FvHyY=
X-Gm-Gg: ASbGncutmPGau/l9F4EdMAF4v5CwCL8bbHhDXt96dKGzMa9ppLR7rQLM0CTXHo6FKiQ
	U5tt0IkZuK/Xz0fQF+hSD2Z/ktI7KyXDjplT83jXQ2qyyW2XdkzXoyxuEtav23kbJrmjtrBqk7M
	SE0Pwgbj8IIVVnny+r9npjkTME8v+S3/+DO3wj2OBhlAhbha757wlYGGsShFjA
X-Google-Smtp-Source: AGHT+IHEbdo2ZprOYdW1BgE/lPLTM9mLh6sWy+I6SHkspuOY6lDQhE29rfuj/ePMWUeICbuPBFXbaNbdqmQrj0Ajvvk=
X-Received: by 2002:a2e:bea2:0:b0:30c:7a7:e85a with SMTP id
 38308e7fff4ca-30c4a8769f1mr83376551fa.21.1742233741568; Mon, 17 Mar 2025
 10:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyHTpHE6QEtZkU74Y__XwaNLW5U-5hRNQLe4J18TyvcC3A@mail.gmail.com>
 <174182457214.9342.16141018787964898862@noble.neil.brown.name>
In-Reply-To: <174182457214.9342.16141018787964898862@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 17 Mar 2025 13:48:48 -0400
X-Gm-Features: AQ5f1JpfzCh9nntxHrsO1sr1me9DXXGUqFRsdcbyQ5xTdxWY2aDMH1vqpR3m1DE
Message-ID: <CAN-5tyELfjOfqg+u_0CC8GFFE8rJ0xudynfHs4OLr07t+zaaRg@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 8:09=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Thu, 13 Mar 2025, Olga Kornievskaia wrote:
> > On Wed, Mar 12, 2025 at 9:22=E2=80=AFAM Olga Kornievskaia <aglo@umich.e=
du> wrote:
> > >
> > > On Tue, Mar 11, 2025 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.de> wro=
te:
> > > >
> > > > On Wed, 12 Mar 2025, Olga Kornievskaia wrote:
> > > > > On Tue, Mar 11, 2025 at 11:28=E2=80=AFAM Olga Kornievskaia <aglo@=
umich.edu> wrote:
> > > > > >
> > > > > > On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM NeilBrown <neilb@suse.d=
e> wrote:
> > > > > > >
> > > > > > >
> > > > > > > NFSD_MAY_LOCK means a few different things.
> > > > > > > - it means that GSS is not required.
> > > > > > > - it means that with NFSEXP_NOAUTHNLM, authentication is not =
required
> > > > > > > - it means that OWNER_OVERRIDE is allowed.
> > > > > > >
> > > > > > > None of these are specific to locking, they are specific to t=
he NLM
> > > > > > > protocol.
> > > > > > > So:
> > > > > > >  - rename to NFSD_MAY_NLM
> > > > > > >  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm=
_fopen()
> > > > > > >    so that NFSD_MAY_NLM doesn't need to imply these.
> > > > > > >  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission()=
 and
> > > > > > >    into fh_verify where other special-case tests on the MAY f=
lags
> > > > > > >    happen.  nfsd_permission() can be called from other places=
 than
> > > > > > >    fh_verify(), but none of these will have NFSD_MAY_NLM.
> > > > > >
> > > > > > This patch breaks NLM when used in combination with TLS.
> > > > >
> > > > > I was too quick to link this to TLS. It's presence of security po=
licy
> > > > > so sec=3Dkrb* causes the same problems.
> > > > >
> > > > > >  If exports
> > > > > > have xprtsec=3Dtls:mtls and mount is done with tls/mtls, the se=
rver
> > > > > > won't give any locks and client will get "no locks available" e=
rror.
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > > ---
> > > > > > >
> > > > > > > No change from previous patch - the corruption in the email h=
as been
> > > > > > > avoided (I hope).
> > > > > > >
> > > > > > >
> > > > > > >  fs/nfsd/lockd.c | 13 +++++++++++--
> > > > > > >  fs/nfsd/nfsfh.c | 12 ++++--------
> > > > > > >  fs/nfsd/trace.h |  2 +-
> > > > > > >  fs/nfsd/vfs.c   | 12 +-----------
> > > > > > >  fs/nfsd/vfs.h   |  2 +-
> > > > > > >  5 files changed, 18 insertions(+), 23 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > > > > > > index 46a7f9b813e5..edc9f75dc75c 100644
> > > > > > > --- a/fs/nfsd/lockd.c
> > > > > > > +++ b/fs/nfsd/lockd.c
> > > > > > > @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct =
nfs_fh *f, struct file **filp,
> > > > > > >         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
> > > > > > >         fh.fh_export =3D NULL;
> > > > > > >
> > > > > > > +       /*
> > > > > > > +        * Allow BYPASS_GSS as some client implementations us=
e AUTH_SYS
> > > > > > > +        * for NLM even when GSS is used for NFS.
> > > > > > > +        * Allow OWNER_OVERRIDE as permission might have been=
 changed
> > > > > > > +        * after the file was opened.
> > > > > > > +        * Pass MAY_NLM so that authentication can be complet=
ely bypassed
> > > > > > > +        * if NFSEXP_NOAUTHNLM is set.  Some older clients us=
e AUTH_NULL
> > > > > > > +        * for NLM requests.
> > > > > > > +        */
> > > > > > >         access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : =
NFSD_MAY_READ;
> > > > > > > -       access |=3D NFSD_MAY_LOCK;
> > > > > > > +       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | =
NFSD_MAY_BYPASS_GSS;
> > > > > > >         nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, fil=
p);
> > > > > > >         fh_put(&fh);
> > > > > > > -       /* We return nlm error codes as nlm doesn't know
> > > > > > > +       /* We return nlm error codes as nlm doesn't know
> > > > > > >          * about nfsd, but nfsd does know about nlm..
> > > > > > >          */
> > > > > > >         switch (nfserr) {
> > > > > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > > > > index 40533f7c7297..6a831cb242df 100644
> > > > > > > --- a/fs/nfsd/nfsfh.c
> > > > > > > +++ b/fs/nfsd/nfsfh.c
> > > > > > > @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > > >         if (error)
> > > > > > >                 goto out;
> > > > > > >
> > > > > > > -       /*
> > > > > > > -        * pseudoflavor restrictions are not enforced on NLM,
> > > > > > > -        * which clients virtually always use auth_sys for,
> > > > > > > -        * even while using RPCSEC_GSS for NFS.
> > > > > > > -        */
> > > > > > > -       if (access & NFSD_MAY_LOCK)
> > > > > > > -               goto skip_pseudoflavor_check;
> > > > > > > +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEX=
P_NOAUTHNLM))
> > > > >
> > > > > I think this should either be an OR or the fact that "nlm but onl=
y
> > > > > with insecurelock export option and not other" is the only way to
> > > > > bypass checking is wrong. I think it's just a check for NLM that
> > > > > stays.
> > > >
> > > > I don't think that NLM gets a complete bypass unless no_auth_nlm is=
 set.
> > > > For the case you are describing, I think NFSD_MAY_BYPASS_GSS is sup=
posed
> > > > to make it work.
> > > >
> > > > I assume the NLM request is arriving with AUTH_SYS authentication?
> > >
> > > It does.
> > >
> > > Just to give you a practical example. exports have
> > > (rw,...,sec=3Dkrb5:krb5i:krb5p). Client does mount with sec=3Dkrb5. T=
hen
> > > does an flock() on the file. What's more I have just now hit Kasan's
> > > out-of-bounds warning on that. I'll have to see if that exists on 6.1=
4
> > > (as I'm debugging the matter on the commit of the patch itself and
> > > thus on 6.12-rc now).
> > >
> > > I will layout more reasoning but what allowed NLM to work was this
> > > -       /*
> > > -        * pseudoflavor restrictions are not enforced on NLM,
> > > -        * which clients virtually always use auth_sys for,
> > > -        * even while using RPCSEC_GSS for NFS.
> > > -        */
> > > -       if (access & NFSD_MAY_LOCK)
> > > -               goto skip_pseudoflavor_check;
> > >
> > > but I don't know why the replacement doesn't work.
> >
> > As I mentioned the patch removed the skip_pseudoflavor check (that for
> > NLM) would have bypassed calling check_nfsd_access(). Instead, the
> > problem is that even though may_bypass_gss is set to true it call into
> > nfsd4_spo_must_allow(rqstp) which now wrongly assumes there is
> > compound state (struct nfsd4_compound_state *cstate =3D &resp->cstate;)
> > ... (but this is NLM). So it proceed to deference it if
> > (!cstate->minorversion) causing the KASAN to do the out-of-bound error
> > that I mentioned. It most of the time now cause a crash. But on the
> > off non-deterministic times when it completes it fails.
> >
> > I really don't think calling into check_nfsd_access() is appropriate fo=
r NLM.
>
> Why not?  What is there is inherently inappropriate for NLM?

I spoke too soon. It's not about calling into check_nfsd_acces()
(though it's a problem for v3 because there isn't a compound state!).
The real problem is "access" content that's being passed into the
nfsd_permission() function.

I don't fully understand the logic. But before this patch, "access"
(acc) was (re)set to "NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE" before
calling into inode_permission():
@@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, struct
svc_export *exp,
        if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
                return nfserr_perm;

-       if (acc & NFSD_MAY_LOCK) {
-               /* If we cannot rely on authentication in NLM requests,
-                * just allow locks, otherwise require read permission, or
-                * ownership
-                */
-               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
-                       return 0;
-               else
-                       acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
-       }
        /*
         * The file owner always gets access permission for accesses that
         * would normally be checked at open time. This is to make

now it's doesn't get "reset" and passes all of what was set in nlm_fopen()

       access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
-       access |=3D NFSD_MAY_LOCK;
+       access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_BYPAS=
S_GSS;

which ends up being "write" instead of a read and inode_permission returned=
 -13.

Here's my proposed fix for one the problems in the patch.

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4021b047eb18..eb139962ac4c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2600,6 +2600,9 @@ nfsd_permission(struct svc_cred *cred, struct
svc_export *exp,
            uid_eq(inode->i_uid, current_fsuid()))
                return 0;

+       if (acc & NFSD_MAY_NLM)
+               acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
+
        /* This assumes  NFSD_MAY_{READ,WRITE,EXEC} =3D=3D MAY_{READ,WRITE,=
EXEC} */
        err =3D inode_permission(&nop_mnt_idmap, inode,
                               acc & (MAY_READ | MAY_WRITE | MAY_EXEC));

Now the 2nd problem. You mentioned checking for version before calling
nfsd4_spo_must_allow for v3. So something like this perhaps but not
sure if that's right?

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 0363720280d4..0106da76da89 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1148,8 +1148,9 @@ __be32 check_nfsd_access(struct svc_export *exp,
struct svc_rqst *rqstp,
         * don't support it
         */

-       if (nfsd4_spo_must_allow(rqstp))
-               return nfs_ok;
+       if (rqstp->rq_prog =3D=3D 100003)
+               if (nfsd4_spo_must_allow(rqstp))
+                       return nfs_ok;

        /* Some calls may be processed without authentication
         * on GSS exports. For example NFS2/3 calls on root


In the end, I question, why not revert the original patch instead?

> I agree that calling nfsd4_spo_must_allow(rqstp) isn't appropriate for
> NLM, but it isn't appropriate for v2 or v3 either.  We should add
> version checks either before it is called or before the minorversion
> check that it already has.
>
> NeilBrown
>
>
> >
> > >
> > > > So check_nfsd_access() is being called with may_bypass_gss and this=
:
> > > >
> > > >         if (may_bypass_gss && (
> > > >              rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_NULL ||
> > > >              rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_UNIX)) {
> > > >                 for (f =3D exp->ex_flavors; f < end; f++) {
> > > >                         if (f->pseudoflavor >=3D RPC_AUTH_DES)
> > > >                                 return 0;
> > > >                 }
> > > >         }
> > > >
> > > > in check_nfsd_access() should succeed.
> > > > Can you add some tracing and see what is happening in here?
> > > > Maybe the "goto denied" earlier in the function is being reached.  =
I
> > > > don't fully understand the TLS code yet - maybe it needs some test =
on
> > > > may_bypass_gss.
> > > >
> > > > Thanks,
> > > > NeilBrown
> > > >
> > > >
> > > > >
> > > > > > > +               /* NLM is allowed to fully bypass authenticat=
ion */
> > > > > > > +               goto out;
> > > > > > > +
> > > > > > >         if (access & NFSD_MAY_BYPASS_GSS)
> > > > > > >                 may_bypass_gss =3D true;
> > > > > > >         /*
> > > > > > > @@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > > >         if (error)
> > > > > > >                 goto out;
> > > > > > >
> > > > > > > -skip_pseudoflavor_check:
> > > > > > >         /* Finally, check access permissions. */
> > > > > > >         error =3D nfsd_permission(cred, exp, dentry, access);
> > > > > > >  out:
> > > > > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > > > > index b8470d4cbe99..3448e444d410 100644
> > > > > > > --- a/fs/nfsd/trace.h
> > > > > > > +++ b/fs/nfsd/trace.h
> > > > > > > @@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> > > > > > >                 { NFSD_MAY_READ,                "READ" },    =
           \
> > > > > > >                 { NFSD_MAY_SATTR,               "SATTR" },   =
           \
> > > > > > >                 { NFSD_MAY_TRUNC,               "TRUNC" },   =
           \
> > > > > > > -               { NFSD_MAY_LOCK,                "LOCK" },    =
           \
> > > > > > > +               { NFSD_MAY_NLM,                 "NLM" },     =
           \
> > > > > > >                 { NFSD_MAY_OWNER_OVERRIDE,      "OWNER_OVERRI=
DE" },     \
> > > > > > >                 { NFSD_MAY_LOCAL_ACCESS,        "LOCAL_ACCESS=
" },       \
> > > > > > >                 { NFSD_MAY_BYPASS_GSS_ON_ROOT,  "BYPASS_GSS_O=
N_ROOT" }, \
> > > > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > > > index 51f5a0b181f9..2610638f4301 100644
> > > > > > > --- a/fs/nfsd/vfs.c
> > > > > > > +++ b/fs/nfsd/vfs.c
> > > > > > > @@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, =
struct svc_export *exp,
> > > > > > >                 (acc & NFSD_MAY_EXEC)?  " exec"  : "",
> > > > > > >                 (acc & NFSD_MAY_SATTR)? " sattr" : "",
> > > > > > >                 (acc & NFSD_MAY_TRUNC)? " trunc" : "",
> > > > > > > -               (acc & NFSD_MAY_LOCK)?  " lock"  : "",
> > > > > > > +               (acc & NFSD_MAY_NLM)?   " nlm"  : "",
> > > > > > >                 (acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverr=
ide" : "",
> > > > > > >                 inode->i_mode,
> > > > > > >                 IS_IMMUTABLE(inode)?    " immut" : "",
> > > > > > > @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred,=
 struct svc_export *exp,
> > > > > > >         if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> > > > > > >                 return nfserr_perm;
> > > > > > >
> > > > > > > -       if (acc & NFSD_MAY_LOCK) {
> > > > > > > -               /* If we cannot rely on authentication in NLM=
 requests,
> > > > > > > -                * just allow locks, otherwise require read p=
ermission, or
> > > > > > > -                * ownership
> > > > > > > -                */
> > > > > > > -               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> > > > > > > -                       return 0;
> > > > > > > -               else
> > > > > > > -                       acc =3D NFSD_MAY_READ | NFSD_MAY_OWNE=
R_OVERRIDE;
> > > > > > > -       }
> > > > > > >         /*
> > > > > > >          * The file owner always gets access permission for a=
ccesses that
> > > > > > >          * would normally be checked at open time. This is to=
 make
> > > > > > > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > > > > > > index 854fb95dfdca..f9b09b842856 100644
> > > > > > > --- a/fs/nfsd/vfs.h
> > > > > > > +++ b/fs/nfsd/vfs.h
> > > > > > > @@ -20,7 +20,7 @@
> > > > > > >  #define NFSD_MAY_READ                  0x004 /* =3D=3D MAY_R=
EAD */
> > > > > > >  #define NFSD_MAY_SATTR                 0x008
> > > > > > >  #define NFSD_MAY_TRUNC                 0x010
> > > > > > > -#define NFSD_MAY_LOCK                  0x020
> > > > > > > +#define NFSD_MAY_NLM                   0x020 /* request is f=
rom lockd */
> > > > > > >  #define NFSD_MAY_MASK                  0x03f
> > > > > > >
> > > > > > >  /* extra hints to permission and open routines: */
> > > > > > >
> > > > > > > base-commit: c4e418a53fe30d8e1da68f5aabca352b682fd331
> > > > > > > --
> > > > > > > 2.46.0
> > > > > > >
> > > > > > >
> > > > >
> >
>

