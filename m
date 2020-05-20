Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495AE1DB086
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 12:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgETKsN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 06:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKsM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 May 2020 06:48:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5B8C061A0E
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 03:48:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l17so2648483wrr.4
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=nUqzQL1T/LGueuPkixiA024ukHljq3AmTiA45Zbf4z8=;
        b=WqQCJyqn9mHKU55Bd8Jt4LpEiaCDzGawMnvEUUxnF5bu9Ph+ejiRmvnlC5KaJVjs6Y
         ul+1tKuZWEY0/FaXpLxOEOv/p3fUw80M5ktOR1+rdiqZ/9DzVFBqj2KL1yA45pC07STh
         EBnSIcRCsk82DhGNBw2kcAE3dPxmskBYj83cAJy65BXAHbhoMVStQE+XxJR3j6nzci/2
         jDDB0SmJqnLe+EU8+wQVEM2gKNO4Pdy4FhZN25AVby01cQSq37mQ4kGII1aAu6NBQOA9
         foTIBltF5FVbvIrnk+WLmvZKqkV7B3GNKp93d5whBSJyADETrRs8UyLway5nr7H6zP3b
         CGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=nUqzQL1T/LGueuPkixiA024ukHljq3AmTiA45Zbf4z8=;
        b=IORC7Y0yg18YWW+HmCo7FnFSDTIuVQaiy+7d1Fm3JIkRatXd5w6rVsy4TYu6djrz60
         mlND8dp9oQuFU5MLBxIShuuAlFLpC4SzLZ2lya42ImP29dwrLJbmtQX+3G9h63xJ5YRr
         csNsB54V4W3tlKH+Yt8ohl2asF/wT5BQfid3hoKPpSW5WUMJA0/ilxY4QMX2/D140VWk
         HXasa4jmFCfZa1CEZ6S4tCVKONpR85uAAT9F+4qK58931lOnL5Rzr661rWR8t9jnAX6G
         39+SaHrCgPtctbFC+zwo90K0sxuyjZBSHqW6cF+odDLQyZmt2TAEWvPFIEJcqDxFHOBY
         L5Uw==
X-Gm-Message-State: AOAM533yB6YsnZHSOiJZp7a54HVooT2b+MHM1ARh24idgbL4gAVFAdcC
        h03q0yQdu1JBuhfruVeq3t/1eG3lkHs=
X-Google-Smtp-Source: ABdhPJxMy5U6SbfKCXlAQ1lWxJ8I2CanHhB3e/8IN7Hmo0HpsmiOzLo0EkPXg8eZQT4mw/84eJzfRg==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr2791115wri.342.1589971691100;
        Wed, 20 May 2020 03:48:11 -0700 (PDT)
Received: from WINDOWSSS5SP16 (cpc96954-walt26-2-0-cust383.13-2.cable.virginm.net. [82.31.89.128])
        by smtp.gmail.com with ESMTPSA id e5sm2409449wro.3.2020.05.20.03.48.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 03:48:10 -0700 (PDT)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>, <trond.myklebust@hammerspace.com>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'Schumaker, Anna'" <Anna.Schumaker@netapp.com>,
        <trondmy@hammerspace.com>
References: <20ce01d62303$70571e80$51055b80$@gmail.com> <109301d62a2f$b88f0ae0$29ad20a0$@gmail.com>
In-Reply-To: <109301d62a2f$b88f0ae0$29ad20a0$@gmail.com>
Subject: RE: NFS v4 + kerberos: 4 minute window of slowness
Date:   Wed, 20 May 2020 11:48:08 +0100
Message-ID: <07d501d62e94$26c72070$74556150$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJApAoYzJ+3B0ZhSERbG+lQVfHW2gDn9MP3p9SggcA=
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Polite ping...

> -----Original Message-----
> From: Robert Milkowski <rmilkowski@gmail.com>
> Sent: 14 May 2020 21:39
> To: linux-nfs@vger.kernel.org; trond.myklebust@hammerspace.com; 'Chuck
> Lever' <chuck.lever@oracle.com>; 'Schumaker, Anna'
> <Anna.Schumaker@netapp.com>
> Subject: RE: NFS v4 + kerberos: 4 minute window of slowness
>=20
> +Trond, Chuck, Anna
>=20
>=20
> Ping...
>=20
> > -----Original Message-----
> > From: Robert Milkowski <rmilkowski@gmail.com>
> > Sent: 05 May 2020 18:35
> > To: linux-nfs@vger.kernel.org
> > Subject: NFS v4 + kerberos: 4 minute window of slowness
> >
> > Hi,
> >
> > Currently the last 4 minutes before kernel gss context expires, all
> > writes to NFSv4 are synchronous and all dirty pages associated with
> > the file being written to are being destaged.
> > This will continue for the 4 minutes until the context expires, at
> > which point it gets refreshed and everything gets back to normal.
> >
> > The rpc.gssd by default sets the timeout to match the Kerberos =
service
> > ticket, but this can be lowered by using -t option.
> > In fact many sites set it to lower value, like for example 30 =
minutes.
> > This means that every 30 minutes, the last 4 minutes results in
> > severely slower writes (assuming these are buffered - no O_DSYNC,
> etc.).
> >
> > In extreme case, when one sets the timeout to 5 minutes, during the =
4
> > minutes out of the minutes, there will be the slowness observed.
> >
> >
> > I understand the idea behind this mechanism - I guess it tries to
> > avoid situation when a gss context can't be refreshed (due to error =
or
> > account disabled, etc.), and it expires suddenly nfs client wouldn't
> > be able to destage all the buffered writes. The way it is currently
> > implemented though is rather crude.
> > In my opinion, instead of making everything slow for the whole 4
> > minutes, it should first try to refresh the context immediately and =
if
> > successful things go back to normal, if it can't refresh the context
> > then it should continue with the previous one and revert to the
> > current behaviour. I implemented a na=EFve quick fix which does =
exactly
> > that (attached at the end of this email).
> >
> >
> > How to re-produce.
> >
> >
> > $ uname -r
> > 5.7.0-rc4+
> >
> > $ grep -- -t /etc/sysconfig/nfs
> > RPCGSSDARGS=3D"-t 300"
> >
> > I'm setting it to 5 minutes so I can quickly see the behaviour =
without
> > having to wait for too long.
> >
> >
> > Now, let's generate a small write every 10s to a file on
> > nfsv4,sec=3Dkrb5 filesystem and record how long each write takes.
> > Since these are buffered writes it should be very quick most of the
> > time.
> >
> > $ while [ 1 ]; do strace -qq -tT -v -e trace=3Dwrite /bin/echo aa =
>f1;
> > rm f1; sleep 10; done
> >
> > 15:22:41 write(1, "aa\n", 3)            =3D 3 <0.000108>
> > 15:22:51 write(1, "aa\n", 3)            =3D 3 <0.000113>
> > 15:23:01 write(1, "aa\n", 3)            =3D 3 <0.000111>
> > 15:23:11 write(1, "aa\n", 3)            =3D 3 <0.000112>
> > 15:23:21 write(1, "aa\n", 3)            =3D 3 <0.001510>     <<<<<<
> > becomes
> > slow
> > 15:23:31 write(1, "aa\n", 3)            =3D 3 <0.001622>
> > 15:23:41 write(1, "aa\n", 3)            =3D 3 <0.001553>
> > 15:23:51 write(1, "aa\n", 3)            =3D 3 <0.001495>
> > ...
> > 15:27:01 write(1, "aa\n", 3)            =3D 3 <0.001528>
> > 15:27:12 write(1, "aa\n", 3)            =3D 3 <0.001553>
> > 15:27:22 write(1, "aa\n", 3)            =3D 3 <0.000104>     <<<<<<
> > becomes
> > fast again
> > 15:27:32 write(1, "aa\n", 3)            =3D 3 <0.000125>
> > 15:27:42 write(1, "aa\n", 3)            =3D 3 <0.000129>
> > 15:27:52 write(1, "aa\n", 3)            =3D 3 <0.000113>
> > 15:28:02 write(1, "aa\n", 3)            =3D 3 <0.000112>
> > 15:28:12 write(1, "aa\n", 3)            =3D 3 <0.000112>
> > 15:28:22 write(1, "aa\n", 3)            =3D 3 <0.001510>     <<<<<< =
slow
> > ...
> > 15:32:02 write(1, "aa\n", 3)            =3D 3 <0.001501>
> > 15:32:12 write(1, "aa\n", 3)            =3D 3 <0.001440>
> > 15:32:22 write(1, "aa\n", 3)            =3D 3 <0.000136>     <<<<<< =
fast
> > 15:32:32 write(1, "aa\n", 3)            =3D 3 <0.000109>
> > 15:32:42 write(1, "aa\n", 3)            =3D 3 <0.000110>
> > 15:32:52 write(1, "aa\n", 3)            =3D 3 <0.000112>
> > 15:33:02 write(1, "aa\n", 3)            =3D 3 <0.000103>
> > 15:33:12 write(1, "aa\n", 3)            =3D 3 <0.000112>
> > 15:33:22 write(1, "aa\n", 3)            =3D 3 <0.001405>     <<<<<< =
slow
> > 15:33:32 write(1, "aa\n", 3)            =3D 3 <0.001393>
> > 15:33:42 write(1, "aa\n", 3)            =3D 3 <0.001479>
> > ...
> >
> >
> >
> > So we have 4 minute long windows of slowness followed by 1 minute
> > window when writes are fast.
> >
> > 	15:23:21  -  15:27:22        slow
> > 	15:27:22  -  15:28:22        fast
> > 	15:28:22  -  15:32:22        slow
> > 	15:32:22  -  15:33:22        fast
> >
> >
> >
> > After some tracing with systemtap and looking at the source code, I
> > found where the issue is coming from.
> > The nfs_file_write() function ends up calling =
nfs_ctx_key_to_expire()
> > on each write, which in turn calls gss_key_timeout() which has
> > hard-coded value of 240s =
(GSS_KEY_EXPIRE_TIMEO/gss_key_expire_timeo).
> >
> >
> > nfs_file_write()
> > ...
> >         result =3D nfs_key_timeout_notify(file, inode);
> >         if (result)
> >                 return result;
> > ...
> >         if (nfs_need_check_write(file, inode)) {
> >                 int err =3D nfs_wb_all(inode); ...
> >
> >
> > /*
> >  * Avoid buffered writes when a open context credential's key would
> >  * expire soon.
> >  *
> >  * Returns -EACCES if the key will expire within =
RPC_KEY_EXPIRE_FAIL.
> >  *
> >  * Return 0 and set a credential flag which triggers the inode to
> > flush
> >  * and performs  NFS_FILE_SYNC writes if the key will expired within
> >  * RPC_KEY_EXPIRE_TIMEO.
> >  */
> > int
> > nfs_key_timeout_notify(struct file *filp, struct inode *inode) {
> >         struct nfs_open_context *ctx =3D =
nfs_file_open_context(filp);
> >
> >         if (nfs_ctx_key_to_expire(ctx, inode) &&
> >             !ctx->ll_cred)
> >                 /* Already expired! */
> >                 return -EACCES;
> >         return 0;
> > }
> >
> >
> > nfs_need_check_write()
> > ...
> >         if (nfs_ctx_key_to_expire(ctx, inode))
> >                 return 1;
> >         return 0;
> >
> >
> >
> > nfs_write_end()
> > ...
> >         if (nfs_ctx_key_to_expire(ctx, mapping->host)) {
> >                 status =3D nfs_wb_all(mapping->host); ...
> >
> >
> >
> > /*
> >  * Test if the open context credential key is marked to expire soon.
> >  */
> > bool nfs_ctx_key_to_expire(struct nfs_open_context *ctx, struct =
inode
> > *inode)
> > {
> >         struct rpc_auth *auth =3D =
NFS_SERVER(inode)->client->cl_auth;
> >         struct rpc_cred *cred =3D ctx->ll_cred;
> >         struct auth_cred acred =3D {
> >                 .cred =3D ctx->cred,
> >         };
> >
> >         if (cred && !cred->cr_ops->crmatch(&acred, cred, 0)) {
> >                 put_rpccred(cred);
> >                 ctx->ll_cred =3D NULL;
> >                 cred =3D NULL;
> >         }
> >         if (!cred)
> >                 cred =3D auth->au_ops->lookup_cred(auth, &acred, 0);
> >         if (!cred || IS_ERR(cred))
> >                 return true;
> >         ctx->ll_cred =3D cred;
> >         return !!(cred->cr_ops->crkey_timeout &&
> >                   cred->cr_ops->crkey_timeout(cred));
> > }
> >
> >
> >
> > net/sunrpc/auth_gss/auth_gss.c: .crkey_timeout          =3D
> > gss_key_timeout,
> >
> >
> > /*
> >  * Returns -EACCES if GSS context is NULL or will expire within the
> >  * timeout (miliseconds)
> >  */
> > static int
> > gss_key_timeout(struct rpc_cred *rc)
> > {
> >         struct gss_cred *gss_cred =3D container_of(rc, struct =
gss_cred,
> > gc_base);
> >         struct gss_cl_ctx *ctx;
> >         unsigned long timeout =3D jiffies + (gss_key_expire_timeo * =
HZ);
> >         int ret =3D 0;
> >
> >         rcu_read_lock();
> >         ctx =3D rcu_dereference(gss_cred->gc_ctx);
> >         if (!ctx || time_after(timeout, ctx->gc_expiry))
> >                 ret =3D -EACCES;
> >         rcu_read_unlock();
> >
> >         return ret;
> > }
> >
> >
> >
> >
> > #define GSS_KEY_EXPIRE_TIMEO 240
> > static unsigned int gss_key_expire_timeo =3D GSS_KEY_EXPIRE_TIMEO;
> >
> >
> >
> >
> >
> > A na=EFve attempt at a fix:
> >
> >
> > diff --git a/net/sunrpc/auth_gss/auth_gss.c
> > b/net/sunrpc/auth_gss/auth_gss.c index 25fbd8d9de74..864661bdfdf3
> > 100644
> > --- a/net/sunrpc/auth_gss/auth_gss.c
> > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > @@ -1477,6 +1477,8 @@ gss_key_timeout(struct rpc_cred *rc)
> >
> >         rcu_read_lock();
> >         ctx =3D rcu_dereference(gss_cred->gc_ctx);
> > +        if (ctx && time_after(timeout + (60 * HZ), ctx->gc_expiry))
> > +               clear_bit(RPCAUTH_CRED_UPTODATE, &rc->cr_flags);
> >         if (!ctx || time_after(timeout, ctx->gc_expiry))
> >                 ret =3D -EACCES;
> >         rcu_read_unlock();
> >
> >
> >
> >
> > With the above patch, if there is a write within 300s before a =
context
> > is to expire (use RPCGSSDARGS=3D"-t 400" or any value larger than =
300 to
> > test), it will now try to refresh the context and if successful then
> > writes will be fast again (assuming -t option is >300s and/or krb
> > ticket is valid for more than 300s).
> >
> > What I haven't tested nor analysed code is what would happen if it =
now
> > fails to refresh the context, but after a quick glance at
> > gss_refresh() it does seem it would continue using the previous
> cred...
> >
> > Is this the correct approach to fix the issue, or can you suggest =
some
> > other approach?
> >
> >
> >
> > --
> > Robert Milkowski
>=20


