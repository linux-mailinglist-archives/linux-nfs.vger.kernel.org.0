Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2EC56A92A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiGGRMy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiGGRMy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 13:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1616D5A2DD
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657213971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/TPw2gv0MYt5gBjtr1oYhGaSEYP9yUBbSh0PUzKXhZk=;
        b=QGu0Lsu6N+7Wm6PeF9YknwwVuZa9OBzA515CCLWnKM6tQ31jmGIpjlxBHghjl4BQwKGz6r
        B8GM5P83Qu5yliYSdKXulqxm1tlEwRHiXyP9t1G3lDYrbf+xLg+CVM0ClX5tt19FPKa+fS
        b4V3Tri1A7oaWHajauuFOX8Fczzpeis=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-j9QuuAO1OZOI8oE6e_-OdA-1; Thu, 07 Jul 2022 13:12:50 -0400
X-MC-Unique: j9QuuAO1OZOI8oE6e_-OdA-1
Received: by mail-qt1-f199.google.com with SMTP id m6-20020ac866c6000000b002f52f9fb4edso16049124qtp.19
        for <linux-nfs@vger.kernel.org>; Thu, 07 Jul 2022 10:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=/TPw2gv0MYt5gBjtr1oYhGaSEYP9yUBbSh0PUzKXhZk=;
        b=r4zTXKfb7n2I5UbYp/Pn2AKTVatwBJ6XJq4/DSgl/mxNYzwDfy6/ElfVj4YCP38t5j
         inN6R91VTQr8ESOCG+fSZN2mLo/Gg6LjGzBfLQcw3NJKFyt38yQh4PQRq1MlgIqEGYFR
         7fZtOH0yw0Hqr9IrhLx+ihUHhJi4Q5PNM9sJ74xhTq8PNNq41BKH9uOwhs0sM06L3f4O
         9cMsxODQaZP+PXs5WIiFo0k1B6hLWtCiCnPa9kfLJBNO95M97YQtxV78oa9GybHvnqEi
         GJjBPVrqaAGkrPUk1dv0+7HO+PA1T/IhHx6sWP6VrJ3f+2nYNxo4nF5vFA3P1KoAYJjw
         qYIA==
X-Gm-Message-State: AJIora8Qj3YM7VOEY618rWiaDptF4rH5elJ20/ykftqYQ99+SXytw9ss
        swr0Z397ReNWasFxmuNkhOviL0M3pZ3rtsbQ7ShoRnrc56p9JfNaovMlvW0vQj0GQyLrFwu1aEV
        HwkzrODLsXjExe24HSJel
X-Received: by 2002:a05:620a:41e:b0:6b2:757f:2303 with SMTP id 30-20020a05620a041e00b006b2757f2303mr19349840qkp.583.1657213966079;
        Thu, 07 Jul 2022 10:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sxfC6fA9uGp8rCq6r9+2UAXMfZw4GJ/IaQKjGuRBu76Ftdvps5lJvYKXlcsESnJfV3rfinEg==
X-Received: by 2002:a05:620a:41e:b0:6b2:757f:2303 with SMTP id 30-20020a05620a041e00b006b2757f2303mr19349816qkp.583.1657213965719;
        Thu, 07 Jul 2022 10:12:45 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id g6-20020a05620a40c600b006a6bb044740sm25897883qko.66.2022.07.07.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:12:45 -0700 (PDT)
Message-ID: <81b43bd844e7cbae885d094cc7ae5026cee24d15.camel@redhat.com>
Subject: Re: [PATCH RFC] NFSD: Bump the ref count on nf_inode
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 07 Jul 2022 13:12:45 -0400
In-Reply-To: <3A439D76-F78E-4449-923D-7E71A47FE36E@oracle.com>
References: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
         <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
         <307aab1000890798345175063c24a77038a78167.camel@redhat.com>
         <3A439D76-F78E-4449-923D-7E71A47FE36E@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-07-07 at 17:01 +0000, Chuck Lever III wrote:
>=20
> > On Jul 7, 2022, at 12:59 PM, Jeff Layton <jlayton@redhat.com> wrote:
> >=20
> > On Thu, 2022-07-07 at 12:55 -0400, Jeff Layton wrote:
> > > On Thu, 2022-07-07 at 11:58 -0400, Chuck Lever wrote:
> > > > The documenting comment for struct nf_file states:
> > > >=20
> > > > /*
> > > > * A representation of a file that has been opened by knfsd. These a=
re hashed
> > > > * in the hashtable by inode pointer value. Note that this object do=
esn't
> > > > * hold a reference to the inode by itself, so the nf_inode pointer =
should
> > > > * never be dereferenced, only used for comparison.
> > > > */
> > > >=20
> > > > However, nfsd_file_mark_find_or_create() does dereference the point=
er stored
> > > > in this field.
> > > >=20
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > ---
> > > > fs/nfsd/filecache.c | 3 +++
> > > > fs/nfsd/filecache.h | 4 +---
> > > > 2 files changed, 4 insertions(+), 3 deletions(-)
> > > >=20
> > > > Hi Jeff-
> > > >=20
> > > > I'm still testing this one, but I'm wondering what you think of it.
> > > > I did hit a KASAN splat that might be related, but it's not 100%
> > > > reproducible.
> > > >=20
> > >=20
> > > My first thought is "what the hell was I thinking, tracking an inode
> > > field without holding a reference to it?"
> > >=20
> > > But now that I look, the nf_inode value only gets dereferenced in one
> > > place -- nfs4_show_superblock, and I think that's a bug. The comments
> > > over struct nfsd_file say:
> > >=20
> > > "Note that this object doesn't hold a reference to the inode by itsel=
f,
> > > so the nf_inode pointer should never be dereferenced, only used for
> > > comparison."
> > >=20
> > > We should probably annotate nf_inode better. __attribute__((noderef))
> > > maybe? It would also be good to make nfs4_show_superblock use a
> > > different way to get the sb.
> > >=20
> > > In any case, this is unlikely to fix anything unless the crash happen=
ed
> > > in nfs4_show_superblock.
> > >=20
> > >=20
> >=20
> > One other spot. We also dereference it in nfsd_file_mark_find_or_create=
,
> > but I think that specific instance is OK. We know that we still hold a
> > reference to the inode at that point since it comes from fhp->fh_dentry=
,
> > so we shouldn't need to worry about it disappearing out from under us.
>=20
> Needs some annotation. I would prefer not to get that pointer from
> nf_inode, then. As your comment says: compare only, never deref.
>=20
>=20

Yeah, maybe we should pass in the inode as a separate parameter to that
function?

> > What did the crash look like?
>=20
> Jul 06 11:19:32 klimt.1015granger.net kernel: BUG: KASAN: use-after-free =
in nfsd_file_obj_cmpfn+0x26b/0x49a [nfsd]
> Jul 06 11:19:32 klimt.1015granger.net kernel: Read of size 4 at addr ffff=
888180623e1c by task nfsd/1003
> Jul 06 11:19:32 klimt.1015granger.net kernel:=20
> Jul 06 11:19:32 klimt.1015granger.net kernel: CPU: 3 PID: 1003 Comm: nfsd=
 Not tainted 5.19.0-rc5-00037-g17ba024b204f #3522
> Jul 06 11:19:32 klimt.1015granger.net kernel: Hardware name: Supermicro S=
uper Server/X10SRL-F, BIOS 3.3 10/28/2020
> Jul 06 11:19:32 klimt.1015granger.net kernel: Call Trace:
> Jul 06 11:19:32 klimt.1015granger.net kernel:  <TASK>
> Jul 06 11:19:32 klimt.1015granger.net kernel:  dump_stack_lvl+0x56/0x7c
> Jul 06 11:19:32 klimt.1015granger.net kernel:  print_report+0x101/0x4bb
> Jul 06 11:19:32 klimt.1015granger.net kernel:  kasan_report+0x9f/0xbf
> Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd_file_obj_cmpfn+0x26b/=
0x49a [nfsd]
> Jul 06 11:19:32 klimt.1015granger.net kernel:  rhashtable_lookup.constpro=
p.0+0x143/0x1ca [nfsd]
> Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd_file_do_acquire+0x20b=
/0x1189 [nfsd]
> Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd_write+0x138/0x255 [nf=
sd]
> Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd3_proc_write+0x37e/0x3=
fc [nfsd]
> Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd_dispatch+0x5ed/0x7d0 =
[nfsd]
> Jul 06 11:19:32 klimt.1015granger.net kernel:  svc_process_common+0x8e9/0=
xefe [sunrpc]
> Jul 06 11:19:32 klimt.1015granger.net kernel:  svc_process+0x34d/0x378 [s=
unrpc]
> Jul 06 11:19:32 klimt.1015granger.net kernel:  nfsd+0x26b/0x34c [nfsd]
> Jul 06 11:19:32 klimt.1015granger.net kernel:  kthread+0x249/0x258
> Jul 06 11:19:32 klimt.1015granger.net kernel:  ret_from_fork+0x22/0x30
> Jul 06 11:19:32 klimt.1015granger.net kernel:  </TASK>
>=20
> The freed object was actually not an inode, so it's a red herring.
> Still chasing it.
>=20

ACK

>=20
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index 9cb2d590c036..7b43bb427a53 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -180,6 +180,7 @@ nfsd_file_alloc(struct inode *inode, unsigned i=
nt may, unsigned int hashval,
> > > > 		nf->nf_cred =3D get_current_cred();
> > > > 		nf->nf_net =3D net;
> > > > 		nf->nf_flags =3D 0;
> > > > +		ihold(inode);
> > > > 		nf->nf_inode =3D inode;
> > > > 		nf->nf_hashval =3D hashval;
> > > > 		refcount_set(&nf->nf_ref, 1);
> > > > @@ -210,6 +211,7 @@ nfsd_file_free(struct nfsd_file *nf)
> > > > 		fput(nf->nf_file);
> > > > 		flush =3D true;
> > > > 	}
> > > > +	iput(nf->nf_inode);
> > > > 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> > > > 	return flush;
> > > > }
> > > > @@ -940,6 +942,7 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > > > 	if (nf =3D=3D NULL)
> > > > 		goto open_file;
> > > > 	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
> > > > +	iput(new->nf_inode);
> > > > 	nfsd_file_slab_free(&new->nf_rcu);
> > > >=20
> > > > wait_for_construction:
> > > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > > index 1da0c79a5580..01fbf6e88cce 100644
> > > > --- a/fs/nfsd/filecache.h
> > > > +++ b/fs/nfsd/filecache.h
> > > > @@ -24,9 +24,7 @@ struct nfsd_file_mark {
> > > >=20
> > > > /*
> > > > * A representation of a file that has been opened by knfsd. These a=
re hashed
> > > > - * in the hashtable by inode pointer value. Note that this object =
doesn't
> > > > - * hold a reference to the inode by itself, so the nf_inode pointe=
r should
> > > > - * never be dereferenced, only used for comparison.
> > > > + * in the hashtable by inode pointer value.
> > > > */
> > > > struct nfsd_file {
> > > > 	struct hlist_node	nf_node;
> > > >=20
> > > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@redhat.com>
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@redhat.com>

