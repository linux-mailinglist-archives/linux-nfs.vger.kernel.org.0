Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F9B56A8D4
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiGGQ7O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiGGQ7N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 12:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CA14B86B
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657213152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZhM6Z3HA0QE6LDH1vBvW0dogYjTw34dOQ9Sa6B+w2Y=;
        b=LAmp+C15WJmWJtZU6gYr3Lcugc7E4JrQ8bbd4Ce4zGryjBu4kilE1XwSRtGmEzYMIs+7uK
        MS9X8QH5D6P1+ItqXPRNhnCyc6nohsFYi/FLutSeWLUeEjShG5A2LbvgYGn/kYNFecvrLd
        6SVJIGwozOyoVxiStWUBsaDE4OS3yTg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-s7h08ufaNJ-TAzrqwvQxmQ-1; Thu, 07 Jul 2022 12:59:11 -0400
X-MC-Unique: s7h08ufaNJ-TAzrqwvQxmQ-1
Received: by mail-qt1-f198.google.com with SMTP id c22-20020ac81116000000b0031d25923ea8so15051259qtj.17
        for <linux-nfs@vger.kernel.org>; Thu, 07 Jul 2022 09:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=iZhM6Z3HA0QE6LDH1vBvW0dogYjTw34dOQ9Sa6B+w2Y=;
        b=pzXLH5EgiGaYtH9I/fpMBhVGg/1fK0BsGYE0oW8WJTW63dI96aEAp8puakX7gZMvIP
         X10h/pFO/Nr6dm2+dI3ug0YHI9MGtfwP5qQ/20mewP1qFDH6XvyX833RSAkC2TH+c6Pf
         Y85P8T8GVT/QeDN8BvRoQQQ0jrbDtMeYwgWozE2PBqPajGspk/iEHwOgnnv1xNFZTVq6
         yN7m4aai/LkRZe0U4S31JgrAfQKrGn8HBcfBbt1Xyd6RJtMYYYtsx3yVrJsYDtfAsHN4
         njysMiojpUKJ4fJ7Vh/jQ4XjFC9SniQh5jmYtJQJR9M+itRoQwPiqToQwEipzTo0gGUp
         8Khg==
X-Gm-Message-State: AJIora//0qbRRD427sgvf9oXfShROg1h60bGufSq4zbpjQFWdZvxcNx3
        RFH9gBdwHyv1raRjpRk4hfaasPf3JZCBbjyPBXxELaIwEJ5rlxIGgEZ/4sMYwDvFT9wIAwKrb48
        C+xGfmC6iWvUnMUEdvFuK
X-Received: by 2002:ac8:59cf:0:b0:31d:396d:e58 with SMTP id f15-20020ac859cf000000b0031d396d0e58mr28038763qtf.394.1657213150573;
        Thu, 07 Jul 2022 09:59:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tpXiDIqd93cduDG/oZle40/IoW+f8HaY3j0M8w2DDDGLvOPGxyNE534y5UBLZqoy0N6NuVrQ==
X-Received: by 2002:ac8:59cf:0:b0:31d:396d:e58 with SMTP id f15-20020ac859cf000000b0031d396d0e58mr28038744qtf.394.1657213150241;
        Thu, 07 Jul 2022 09:59:10 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id f6-20020a05622a104600b0031d283f4c4dsm17875993qte.60.2022.07.07.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:59:09 -0700 (PDT)
Message-ID: <307aab1000890798345175063c24a77038a78167.camel@redhat.com>
Subject: Re: [PATCH RFC] NFSD: Bump the ref count on nf_inode
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 07 Jul 2022 12:59:09 -0400
In-Reply-To: <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
References: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
         <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
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

On Thu, 2022-07-07 at 12:55 -0400, Jeff Layton wrote:
> On Thu, 2022-07-07 at 11:58 -0400, Chuck Lever wrote:
> > The documenting comment for struct nf_file states:
> >=20
> > /*
> >  * A representation of a file that has been opened by knfsd. These are =
hashed
> >  * in the hashtable by inode pointer value. Note that this object doesn=
't
> >  * hold a reference to the inode by itself, so the nf_inode pointer sho=
uld
> >  * never be dereferenced, only used for comparison.
> >  */
> >=20
> > However, nfsd_file_mark_find_or_create() does dereference the pointer s=
tored
> > in this field.
> >=20
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/filecache.c |    3 +++
> >  fs/nfsd/filecache.h |    4 +---
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > Hi Jeff-
> >=20
> > I'm still testing this one, but I'm wondering what you think of it.
> > I did hit a KASAN splat that might be related, but it's not 100%
> > reproducible.
> >=20
>=20
> My first thought is "what the hell was I thinking, tracking an inode
> field without holding a reference to it?"
>=20
> But now that I look, the nf_inode value only gets dereferenced in one
> place -- nfs4_show_superblock, and I think that's a bug. The comments
> over struct nfsd_file say:
>=20
> "Note that this object doesn't hold a reference to the inode by itself,
> so the nf_inode pointer should never be dereferenced, only used for
> comparison."
>=20
> We should probably annotate nf_inode better. __attribute__((noderef))
> maybe? It would also be good to make nfs4_show_superblock use a
> different way to get the sb.
>=20
> In any case, this is unlikely to fix anything unless the crash happened
> in nfs4_show_superblock.
>=20
>=20

One other spot. We also dereference it in nfsd_file_mark_find_or_create,
but I think that specific instance is OK. We know that we still hold a
reference to the inode at that point since it comes from fhp->fh_dentry,
so we shouldn't need to worry about it disappearing out from under us.

What did the crash look like?

> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 9cb2d590c036..7b43bb427a53 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -180,6 +180,7 @@ nfsd_file_alloc(struct inode *inode, unsigned int m=
ay, unsigned int hashval,
> >  		nf->nf_cred =3D get_current_cred();
> >  		nf->nf_net =3D net;
> >  		nf->nf_flags =3D 0;
> > +		ihold(inode);
> >  		nf->nf_inode =3D inode;
> >  		nf->nf_hashval =3D hashval;
> >  		refcount_set(&nf->nf_ref, 1);
> > @@ -210,6 +211,7 @@ nfsd_file_free(struct nfsd_file *nf)
> >  		fput(nf->nf_file);
> >  		flush =3D true;
> >  	}
> > +	iput(nf->nf_inode);
> >  	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> >  	return flush;
> >  }
> > @@ -940,6 +942,7 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> >  	if (nf =3D=3D NULL)
> >  		goto open_file;
> >  	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
> > +	iput(new->nf_inode);
> >  	nfsd_file_slab_free(&new->nf_rcu);
> > =20
> >  wait_for_construction:
> > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > index 1da0c79a5580..01fbf6e88cce 100644
> > --- a/fs/nfsd/filecache.h
> > +++ b/fs/nfsd/filecache.h
> > @@ -24,9 +24,7 @@ struct nfsd_file_mark {
> > =20
> >  /*
> >   * A representation of a file that has been opened by knfsd. These are=
 hashed
> > - * in the hashtable by inode pointer value. Note that this object does=
n't
> > - * hold a reference to the inode by itself, so the nf_inode pointer sh=
ould
> > - * never be dereferenced, only used for comparison.
> > + * in the hashtable by inode pointer value.
> >   */
> >  struct nfsd_file {
> >  	struct hlist_node	nf_node;
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@redhat.com>

