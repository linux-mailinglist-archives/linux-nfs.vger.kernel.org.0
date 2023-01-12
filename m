Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C9D66690B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jan 2023 03:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjALCsU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 21:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjALCsS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 21:48:18 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF28F6550;
        Wed, 11 Jan 2023 18:48:16 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s5so11050158qtx.6;
        Wed, 11 Jan 2023 18:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dunIhFV/SA7BhxFy5GSpP60/k/c9vYVgtVCy3fTfkpE=;
        b=Mu+5oiPMmg0EMg+2EL1MpVyJLyK0lHEacRpHo6wYm0d01t2ceMvenfSYHaNny8yani
         RNMaj2elxDQi9nT4BqS/sKMqPNRSdswrc1znYB9mEgK7SNhdUWCrgX6jBRebqxOfP+i/
         cot/1/5I7IWOaC2Sv3hrds4qHiAifNaE85LhvjLhveYl1Q6IVNOjKu/9YPub39S7wbcQ
         PCOi6FyUkfalE7EAtpY7nDDcmxMqaeUq9N5EUQOCJqHR9PMRUy+kVgQe79wdbYRR/3Gm
         m6b1evBTkyrGIYr7Sin/IERKQ9xMw/v8ETVZjx89GQweUzGR/+GexujcDC4hUUHOMAnf
         NfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dunIhFV/SA7BhxFy5GSpP60/k/c9vYVgtVCy3fTfkpE=;
        b=7ifzma6svZzCepuKnr7uht75aV5+DBwnwYQzdsbygkG1QTf0j6zVQtte5E+trFnEOa
         PHfnyw5v6zYgE0iGpT6yKfoQP9RLwVAkeu4apspUPpw/nHZnu1QtfkTaRfenFG30cQEv
         THbvP8bJLPm9gVyiZDbcTy6mgz5qI5nQRVwE1M8kk8xcGaDOPJkWPo53IlzlZgwPfAR0
         lRDZ4TiKl1RwJzoQ2oetrJ4zpmfL8SYk3ajFnRkecUtPJz+rtzE/pmFOMJVat2xB71zQ
         cSBRAnnFUrERK68IYW/Tiz4WCE81OmXGpdGevu6+TrEvdEPzh2B6RZ4NY4FElOC5i/d3
         Y+qQ==
X-Gm-Message-State: AFqh2kpdTmwmZs+L5JN207AssuV2OEdu1Pz3nLCFETJrFGivM+6FHi7u
        T2Hs1rkhSKFvVWSNk6/mdg==
X-Google-Smtp-Source: AMrXdXu4VOcXo/yG2W4IiOm1zJMsJuKSJCY4P7eUaVF771F++AKl/a7eK0LwrhpoOgMYKFtUgx8hJg==
X-Received: by 2002:a05:622a:1b22:b0:3ac:342:c686 with SMTP id bb34-20020a05622a1b2200b003ac0342c686mr22858109qtb.46.1673491695696;
        Wed, 11 Jan 2023 18:48:15 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id bb30-20020a05622a1b1e00b003aba8e9efdasm8437619qtb.4.2023.01.11.18.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:48:15 -0800 (PST)
Message-ID: <dc5d464d14d45f7df932c1b53d95c84b4f5bbcc3.camel@gmail.com>
Subject: Re: [PATCH] NFS: Judge the file access cache's timestamp in rcu path
From:   Trond Myklebust <trondmy@gmail.com>
To:     Chengen Du <chengen.du@canonical.com>,
        trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Jan 2023 21:48:13 -0500
In-Reply-To: <CAPza5qc03KLCWJ5u=yFZ3wtKBDHBNvSM44xOTt2AGd9PoRs0Ow@mail.gmail.com>
References: <20221230030432.38908-1-chengen.du@canonical.com>
         <CAPza5qc03KLCWJ5u=yFZ3wtKBDHBNvSM44xOTt2AGd9PoRs0Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-01-12 at 09:26 +0800, Chengen Du wrote:
> Hi,
>=20
> The patch follows the commit 0eb43812c027 but handles the stale cache
> in rcu path.
> The stale cache will remain in the list's tail if no other users
> operate on that inode.
> May I ask if this patch has any other concerns or drawbacks that need
> to be considered?
>=20
> Best regards,
> Chengen Du

No complaints. The patch has already been merged into 6.2-rc3.

Thanks!
  Trond

>=20
> On Fri, Dec 30, 2022 at 11:05 AM Chengen Du
> <chengen.du@canonical.com> wrote:
> >=20
> > If the user's login time is newer than the cache's timestamp,
> > we expect the cache may be stale and need to clear.
> > The stale cache will remain in the list's tail if no other
> > users operate on that inode.
> > Once the user accesses the inode, the stale cache will be
> > returned in rcu path.
> >=20
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > ---
> > =C2=A0fs/nfs/dir.c | 3 +++
> > =C2=A01 file changed, 3 insertions(+)
> >=20
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index ea1ceffa1d3a..d490d64a9ebd 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -3023,6 +3023,7 @@ static int nfs_access_get_cached_rcu(struct
> > inode *inode, const struct cred *cre
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * but do it without lo=
cking.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_inode *nfsi =3D N=
FS_I(inode);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 login_time =3D nfs_access_log=
in_time(current, cred);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_access_entry *cac=
he;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err =3D -ECHILD;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *lh;
> > @@ -3037,6 +3038,8 @@ static int nfs_access_get_cached_rcu(struct
> > inode *inode, const struct cred *cre
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cache =3D NULL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache =3D=3D NULL)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((s64)(login_time - cache->tim=
estamp) > 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nfs_check_cache_invalid(=
inode, NFS_INO_INVALID_ACCESS))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *mask =3D cache->mask;
> > --
> > 2.37.2
> >=20

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


