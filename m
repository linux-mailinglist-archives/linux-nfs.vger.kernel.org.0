Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AEF1D3F0A
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2020 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENUjN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 May 2020 16:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgENUjN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 May 2020 16:39:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FFAC061A0C
        for <linux-nfs@vger.kernel.org>; Thu, 14 May 2020 13:39:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v12so367030wrp.12
        for <linux-nfs@vger.kernel.org>; Thu, 14 May 2020 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=zh5Qh5jHOd7pIo3YBAT7ID32G/+SCyUYqQq+1O783+s=;
        b=kKqtbK81wZ3ongiUNe5K4Tf4PVO+jkocQF+GhB5+05YFc07vE+xu3gWbq3XmgN7Hb2
         EEegnO9DnktPT+DCgwdQirx4dVvV4rrsHMCrUFhyWdmEMgByzYb1jGtIUn80sA7LcfqX
         lVtHSfSg5tQSOpVYPW2B6lBg45XG3+blk/CDVzhymRkP/GwYywMlwUILwhqqWV/uArXy
         1i2R+dXyfptVeOjQDCL7XzpkzaQse8fcuuy5kDPCNs6S4p0jKz5cDyQ/zSUGRMJYT6oh
         ExQPPvXFdUzcfzPP4dyWuVwIZAu6kEnAnrPo+qPJmbbiWBIcmP7HgsO4oGLibm5IlALW
         dJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=zh5Qh5jHOd7pIo3YBAT7ID32G/+SCyUYqQq+1O783+s=;
        b=dHFwmhnvX6/pIgTWeGru8dcQbR1V4xBqNNuLM2IWv5waTGaLBets8zBZZHQowQv5Y1
         tgX+TY6m6Ssj5ubsuFH3blHL5cPz/gCcZvKhvH/4J4MyXWWBur5xgIH/cXXY2xtO2baN
         zzK9DA0FFhQ2pjFyQEP+w2J3rH/wnsuiGCLiksqMPcXpywHkVBzJiYutmZxA0fCsCnBh
         mOYsAklAUeKVliMni/FWu4BosFyDpenDVYc0uSciZ8a6VobH81TYyMxPkBqd1Qj9QuLX
         qgiM3eJ0yPask/XGU9Xu8JWDQVVSeX93c0cFtaZ5y5xySiAr/+id4f+0oCLgcnB12UZt
         F2Ww==
X-Gm-Message-State: AOAM531uE99pGfrnN/+Wk7ZE1lmdmq7fD4e6LNmpOxU4VQuDry1u9cOC
        FYwXcuxcle0mMN1N1g+dzPl1+t6SU2U=
X-Google-Smtp-Source: ABdhPJyEN6pltB9HT8t+CZFSrK4spn3AX+JpYxjptUQX1mc94UKlI9TmExwtUYou9tuR4A5lq1Kt+w==
X-Received: by 2002:adf:8287:: with SMTP id 7mr263042wrc.396.1589488750590;
        Thu, 14 May 2020 13:39:10 -0700 (PDT)
Received: from WINDOWSSS5SP16 (cpc96954-walt26-2-0-cust383.13-2.cable.virginm.net. [82.31.89.128])
        by smtp.gmail.com with ESMTPSA id c19sm136370wrb.89.2020.05.14.13.39.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 13:39:10 -0700 (PDT)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>, <trond.myklebust@hammerspace.com>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'Schumaker, Anna'" <Anna.Schumaker@netapp.com>
References: <20ce01d62303$70571e80$51055b80$@gmail.com>
In-Reply-To: <20ce01d62303$70571e80$51055b80$@gmail.com>
Subject: RE: NFS v4 + kerberos: 4 minute window of slowness
Date:   Thu, 14 May 2020 21:39:09 +0100
Message-ID: <109301d62a2f$b88f0ae0$29ad20a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJApAoYzJ+3B0ZhSERbG+lQVfHW2qfTFqQg
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

+Trond, Chuck, Anna


Ping...

> -----Original Message-----
> From: Robert Milkowski <rmilkowski@gmail.com>
> Sent: 05 May 2020 18:35
> To: linux-nfs@vger.kernel.org
> Subject: NFS v4 + kerberos: 4 minute window of slowness
>=20
> Hi,
>=20
> Currently the last 4 minutes before kernel gss context expires, all
> writes to NFSv4 are synchronous and all dirty pages associated with =
the
> file being written to are being destaged.
> This will continue for the 4 minutes until the context expires, at =
which
> point it gets refreshed and everything gets back to normal.
>=20
> The rpc.gssd by default sets the timeout to match the Kerberos service
> ticket, but this can be lowered by using -t option.
> In fact many sites set it to lower value, like for example 30 minutes.
> This means that every 30 minutes, the last 4 minutes results in =
severely
> slower writes (assuming these are buffered - no O_DSYNC, etc.).
>=20
> In extreme case, when one sets the timeout to 5 minutes, during the 4
> minutes out of the minutes, there will be the slowness observed.
>=20
>=20
> I understand the idea behind this mechanism - I guess it tries to =
avoid
> situation when a gss context can't be refreshed (due to error or =
account
> disabled, etc.), and it expires suddenly nfs client wouldn't be able =
to
> destage all the buffered writes. The way it is currently implemented
> though is rather crude.
> In my opinion, instead of making everything slow for the whole 4
> minutes, it should first try to refresh the context immediately and if
> successful things go back to normal, if it can't refresh the context
> then it should continue with the previous one and revert to the =
current
> behaviour. I implemented a na=EFve quick fix which does exactly that
> (attached at the end of this email).
>=20
>=20
> How to re-produce.
>=20
>=20
> $ uname -r
> 5.7.0-rc4+
>=20
> $ grep -- -t /etc/sysconfig/nfs
> RPCGSSDARGS=3D"-t 300"
>=20
> I'm setting it to 5 minutes so I can quickly see the behaviour without
> having to wait for too long.
>=20
>=20
> Now, let's generate a small write every 10s to a file on =
nfsv4,sec=3Dkrb5
> filesystem and record how long each write takes.
> Since these are buffered writes it should be very quick most of the
> time.
>=20
> $ while [ 1 ]; do strace -qq -tT -v -e trace=3Dwrite /bin/echo aa >f1; =
rm
> f1; sleep 10; done
>=20
> 15:22:41 write(1, "aa\n", 3)            =3D 3 <0.000108>
> 15:22:51 write(1, "aa\n", 3)            =3D 3 <0.000113>
> 15:23:01 write(1, "aa\n", 3)            =3D 3 <0.000111>
> 15:23:11 write(1, "aa\n", 3)            =3D 3 <0.000112>
> 15:23:21 write(1, "aa\n", 3)            =3D 3 <0.001510>     <<<<<<
> becomes
> slow
> 15:23:31 write(1, "aa\n", 3)            =3D 3 <0.001622>
> 15:23:41 write(1, "aa\n", 3)            =3D 3 <0.001553>
> 15:23:51 write(1, "aa\n", 3)            =3D 3 <0.001495>
> ...
> 15:27:01 write(1, "aa\n", 3)            =3D 3 <0.001528>
> 15:27:12 write(1, "aa\n", 3)            =3D 3 <0.001553>
> 15:27:22 write(1, "aa\n", 3)            =3D 3 <0.000104>     <<<<<<
> becomes
> fast again
> 15:27:32 write(1, "aa\n", 3)            =3D 3 <0.000125>
> 15:27:42 write(1, "aa\n", 3)            =3D 3 <0.000129>
> 15:27:52 write(1, "aa\n", 3)            =3D 3 <0.000113>
> 15:28:02 write(1, "aa\n", 3)            =3D 3 <0.000112>
> 15:28:12 write(1, "aa\n", 3)            =3D 3 <0.000112>
> 15:28:22 write(1, "aa\n", 3)            =3D 3 <0.001510>     <<<<<< =
slow
> ...
> 15:32:02 write(1, "aa\n", 3)            =3D 3 <0.001501>
> 15:32:12 write(1, "aa\n", 3)            =3D 3 <0.001440>
> 15:32:22 write(1, "aa\n", 3)            =3D 3 <0.000136>     <<<<<< =
fast
> 15:32:32 write(1, "aa\n", 3)            =3D 3 <0.000109>
> 15:32:42 write(1, "aa\n", 3)            =3D 3 <0.000110>
> 15:32:52 write(1, "aa\n", 3)            =3D 3 <0.000112>
> 15:33:02 write(1, "aa\n", 3)            =3D 3 <0.000103>
> 15:33:12 write(1, "aa\n", 3)            =3D 3 <0.000112>
> 15:33:22 write(1, "aa\n", 3)            =3D 3 <0.001405>     <<<<<< =
slow
> 15:33:32 write(1, "aa\n", 3)            =3D 3 <0.001393>
> 15:33:42 write(1, "aa\n", 3)            =3D 3 <0.001479>
> ...
>=20
>=20
>=20
> So we have 4 minute long windows of slowness followed by 1 minute =
window
> when writes are fast.
>=20
> 	15:23:21  -  15:27:22        slow
> 	15:27:22  -  15:28:22        fast
> 	15:28:22  -  15:32:22        slow
> 	15:32:22  -  15:33:22        fast
>=20
>=20
>=20
> After some tracing with systemtap and looking at the source code, I
> found where the issue is coming from.
> The nfs_file_write() function ends up calling nfs_ctx_key_to_expire() =
on
> each write, which in turn calls gss_key_timeout() which has hard-coded
> value of 240s (GSS_KEY_EXPIRE_TIMEO/gss_key_expire_timeo).
>=20
>=20
> nfs_file_write()
> ...
>         result =3D nfs_key_timeout_notify(file, inode);
>         if (result)
>                 return result;
> ...
>         if (nfs_need_check_write(file, inode)) {
>                 int err =3D nfs_wb_all(inode); ...
>=20
>=20
> /*
>  * Avoid buffered writes when a open context credential's key would
>  * expire soon.
>  *
>  * Returns -EACCES if the key will expire within RPC_KEY_EXPIRE_FAIL.
>  *
>  * Return 0 and set a credential flag which triggers the inode to =
flush
>  * and performs  NFS_FILE_SYNC writes if the key will expired within
>  * RPC_KEY_EXPIRE_TIMEO.
>  */
> int
> nfs_key_timeout_notify(struct file *filp, struct inode *inode) {
>         struct nfs_open_context *ctx =3D nfs_file_open_context(filp);
>=20
>         if (nfs_ctx_key_to_expire(ctx, inode) &&
>             !ctx->ll_cred)
>                 /* Already expired! */
>                 return -EACCES;
>         return 0;
> }
>=20
>=20
> nfs_need_check_write()
> ...
>         if (nfs_ctx_key_to_expire(ctx, inode))
>                 return 1;
>         return 0;
>=20
>=20
>=20
> nfs_write_end()
> ...
>         if (nfs_ctx_key_to_expire(ctx, mapping->host)) {
>                 status =3D nfs_wb_all(mapping->host); ...
>=20
>=20
>=20
> /*
>  * Test if the open context credential key is marked to expire soon.
>  */
> bool nfs_ctx_key_to_expire(struct nfs_open_context *ctx, struct inode
> *inode)
> {
>         struct rpc_auth *auth =3D NFS_SERVER(inode)->client->cl_auth;
>         struct rpc_cred *cred =3D ctx->ll_cred;
>         struct auth_cred acred =3D {
>                 .cred =3D ctx->cred,
>         };
>=20
>         if (cred && !cred->cr_ops->crmatch(&acred, cred, 0)) {
>                 put_rpccred(cred);
>                 ctx->ll_cred =3D NULL;
>                 cred =3D NULL;
>         }
>         if (!cred)
>                 cred =3D auth->au_ops->lookup_cred(auth, &acred, 0);
>         if (!cred || IS_ERR(cred))
>                 return true;
>         ctx->ll_cred =3D cred;
>         return !!(cred->cr_ops->crkey_timeout &&
>                   cred->cr_ops->crkey_timeout(cred));
> }
>=20
>=20
>=20
> net/sunrpc/auth_gss/auth_gss.c: .crkey_timeout          =3D
> gss_key_timeout,
>=20
>=20
> /*
>  * Returns -EACCES if GSS context is NULL or will expire within the
>  * timeout (miliseconds)
>  */
> static int
> gss_key_timeout(struct rpc_cred *rc)
> {
>         struct gss_cred *gss_cred =3D container_of(rc, struct =
gss_cred,
> gc_base);
>         struct gss_cl_ctx *ctx;
>         unsigned long timeout =3D jiffies + (gss_key_expire_timeo * =
HZ);
>         int ret =3D 0;
>=20
>         rcu_read_lock();
>         ctx =3D rcu_dereference(gss_cred->gc_ctx);
>         if (!ctx || time_after(timeout, ctx->gc_expiry))
>                 ret =3D -EACCES;
>         rcu_read_unlock();
>=20
>         return ret;
> }
>=20
>=20
>=20
>=20
> #define GSS_KEY_EXPIRE_TIMEO 240
> static unsigned int gss_key_expire_timeo =3D GSS_KEY_EXPIRE_TIMEO;
>=20
>=20
>=20
>=20
>=20
> A na=EFve attempt at a fix:
>=20
>=20
> diff --git a/net/sunrpc/auth_gss/auth_gss.c
> b/net/sunrpc/auth_gss/auth_gss.c index 25fbd8d9de74..864661bdfdf3 =
100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -1477,6 +1477,8 @@ gss_key_timeout(struct rpc_cred *rc)
>=20
>         rcu_read_lock();
>         ctx =3D rcu_dereference(gss_cred->gc_ctx);
> +        if (ctx && time_after(timeout + (60 * HZ), ctx->gc_expiry))
> +               clear_bit(RPCAUTH_CRED_UPTODATE, &rc->cr_flags);
>         if (!ctx || time_after(timeout, ctx->gc_expiry))
>                 ret =3D -EACCES;
>         rcu_read_unlock();
>=20
>=20
>=20
>=20
> With the above patch, if there is a write within 300s before a context
> is to expire (use RPCGSSDARGS=3D"-t 400" or any value larger than 300 =
to
> test), it will now try to refresh the context and if successful then
> writes will be fast again (assuming -t option is >300s and/or krb =
ticket
> is valid for more than 300s).
>=20
> What I haven't tested nor analysed code is what would happen if it now
> fails to refresh the context, but after a quick glance at =
gss_refresh()
> it does seem it would continue using the previous cred...
>=20
> Is this the correct approach to fix the issue, or can you suggest some
> other approach?
>=20
>=20
>=20
> --
> Robert Milkowski


