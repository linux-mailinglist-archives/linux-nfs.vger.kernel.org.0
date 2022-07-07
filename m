Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB956A928
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiGGRLP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 13:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiGGRLO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 13:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DE735A2DD
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657213873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVUwoS27ITyE5P2NoCtfEBM1uG71VxNGUUuaIPQuR+w=;
        b=AHqjuje0yqv+sYSRIywJGEtP+Nwx89fFR/zJUz6F75tuJ70bN30D1s30odlCjWLwCdwwoC
        N1iWFcyGllvh7pici2ysLHfs3qARL/qo7qaZUISlQd6fP2Gpr+y9UCmd+3hWgQEZAF+FO+
        pyVOTP06G01uGPf1ee5cTh+OtQS96Ak=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-AOCdb1FwMmmdmzV8Jddqjg-1; Thu, 07 Jul 2022 13:11:12 -0400
X-MC-Unique: AOCdb1FwMmmdmzV8Jddqjg-1
Received: by mail-qt1-f198.google.com with SMTP id w42-20020a05622a192a00b0031d3a51eac8so15849871qtc.9
        for <linux-nfs@vger.kernel.org>; Thu, 07 Jul 2022 10:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=SVUwoS27ITyE5P2NoCtfEBM1uG71VxNGUUuaIPQuR+w=;
        b=4CPdJeaFEE/2fRZe+SqUUHfcdjt1oSIg5Z0+TSWRi1WNoZ1jnwwSjFc93lEa/GZcpO
         1a0q7h7dQv2e6r4IqxmXM9MDXOEC5Q4w8UKFjMeCT9xA+qsRvs7R+a7nKbrCCxbhWlw9
         qDHj72cUWSsTS/Jc+HhC+bq+DuA8p0EEJAKWeufUjRkR4liFl7sPP06nye9OT79QGXkt
         bmHlnjqEN+iqFf1wqgHgTw2DUf+sr16PuIJfodZY447XlCTlm6CzdL3/hqN37SfiS/AE
         tTIZYXesdOkMuF9qZDY1vo6cbnyT4O0r+KrhgudY9vQqkVnIYu0QsTGOdHhQDpTktuQQ
         GZwg==
X-Gm-Message-State: AJIora/Ozz8Qa0v/LmqP6TXyyTOr1WPFuzfBCrRDjvXYMXxnedqefSMH
        bDpm1jyew1vSqMCPcobI2WUlBC5LwJwIvh3w9TeFW5tCDTTi5dd5Pyctbcz+oJafBMyQAgoRbK2
        PYsBiFbgqbTjgzYoskuG4
X-Received: by 2002:a37:2f86:0:b0:6af:4c8c:ee8b with SMTP id v128-20020a372f86000000b006af4c8cee8bmr32225576qkh.633.1657213870566;
        Thu, 07 Jul 2022 10:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uVkGbnUViz4oI3Ruln2I/IR+U0VRn3U6WXed9vZkbrGwyxBgQPXPhjKPs8wpue70NVQk4Fpg==
X-Received: by 2002:a37:2f86:0:b0:6af:4c8c:ee8b with SMTP id v128-20020a372f86000000b006af4c8cee8bmr32225545qkh.633.1657213870126;
        Thu, 07 Jul 2022 10:11:10 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id bi32-20020a05620a31a000b006af3f3b385csm27384364qkb.98.2022.07.07.10.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:11:09 -0700 (PDT)
Message-ID: <d08ac3fb68c2b0a9e8b291b634bca20eff5374e1.camel@redhat.com>
Subject: Re: [PATCH RFC] NFSD: Bump the ref count on nf_inode
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 07 Jul 2022 13:11:08 -0400
In-Reply-To: <98746C90-BB21-4FE5-9000-BCC33662F8F1@oracle.com>
References: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
         <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
         <98746C90-BB21-4FE5-9000-BCC33662F8F1@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-07-07 at 16:58 +0000, Chuck Lever III wrote:
>=20
> > On Jul 7, 2022, at 12:55 PM, Jeff Layton <jlayton@redhat.com> wrote:
> >=20
> > On Thu, 2022-07-07 at 11:58 -0400, Chuck Lever wrote:
> > > The documenting comment for struct nf_file states:
> > >=20
> > > /*
> > > * A representation of a file that has been opened by knfsd. These are=
 hashed
> > > * in the hashtable by inode pointer value. Note that this object does=
n't
> > > * hold a reference to the inode by itself, so the nf_inode pointer sh=
ould
> > > * never be dereferenced, only used for comparison.
> > > */
> > >=20
> > > However, nfsd_file_mark_find_or_create() does dereference the pointer=
 stored
> > > in this field.
> > >=20
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > > fs/nfsd/filecache.c | 3 +++
> > > fs/nfsd/filecache.h | 4 +---
> > > 2 files changed, 4 insertions(+), 3 deletions(-)
> > >=20
> > > Hi Jeff-
> > >=20
> > > I'm still testing this one, but I'm wondering what you think of it.
> > > I did hit a KASAN splat that might be related, but it's not 100%
> > > reproducible.
> > >=20
> >=20
> > My first thought is "what the hell was I thinking, tracking an inode
> > field without holding a reference to it?"
> >=20
> > But now that I look, the nf_inode value only gets dereferenced in one
> > place -- nfs4_show_superblock, and I think that's a bug. The comments
> > over struct nfsd_file say:
> >=20
> > "Note that this object doesn't hold a reference to the inode by itself,
> > so the nf_inode pointer should never be dereferenced, only used for
> > comparison."
> >=20
> > We should probably annotate nf_inode better. __attribute__((noderef))
> > maybe? It would also be good to make nfs4_show_superblock use a
> > different way to get the sb.
> >=20
> > In any case, this is unlikely to fix anything unless the crash happened
> > in nfs4_show_superblock.
>=20
> Thanks for the look. I will treat this as a clean-up, then, and see
> what can be done about nfsd_file_mark_find_or_create() and
> nfs4_show_superblock().
>=20
>=20

I don't see a real need to hold a separate inode reference in the
nfsd_file as you should have one already by virtue of the open file
itself. It probably won't hurt anything to hold one though if you decide
that's safer.

> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index 9cb2d590c036..7b43bb427a53 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -180,6 +180,7 @@ nfsd_file_alloc(struct inode *inode, unsigned int=
 may, unsigned int hashval,
> > > 		nf->nf_cred =3D get_current_cred();
> > > 		nf->nf_net =3D net;
> > > 		nf->nf_flags =3D 0;
> > > +		ihold(inode);
> > > 		nf->nf_inode =3D inode;
> > > 		nf->nf_hashval =3D hashval;
> > > 		refcount_set(&nf->nf_ref, 1);
> > > @@ -210,6 +211,7 @@ nfsd_file_free(struct nfsd_file *nf)
> > > 		fput(nf->nf_file);
> > > 		flush =3D true;
> > > 	}
> > > +	iput(nf->nf_inode);
> > > 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> > > 	return flush;
> > > }
> > > @@ -940,6 +942,7 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> > > 	if (nf =3D=3D NULL)
> > > 		goto open_file;
> > > 	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
> > > +	iput(new->nf_inode);
> > > 	nfsd_file_slab_free(&new->nf_rcu);
> > >=20
> > > wait_for_construction:
> > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > index 1da0c79a5580..01fbf6e88cce 100644
> > > --- a/fs/nfsd/filecache.h
> > > +++ b/fs/nfsd/filecache.h
> > > @@ -24,9 +24,7 @@ struct nfsd_file_mark {
> > >=20
> > > /*
> > > * A representation of a file that has been opened by knfsd. These are=
 hashed
> > > - * in the hashtable by inode pointer value. Note that this object do=
esn't
> > > - * hold a reference to the inode by itself, so the nf_inode pointer =
should
> > > - * never be dereferenced, only used for comparison.
> > > + * in the hashtable by inode pointer value.
> > > */
> > > struct nfsd_file {
> > > 	struct hlist_node	nf_node;
> > >=20
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

