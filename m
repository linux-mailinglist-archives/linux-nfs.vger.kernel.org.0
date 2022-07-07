Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8371756A8B1
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 18:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiGGQzG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGGQzF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 12:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF9A226AD7
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657212903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XY+z/2FyOr6Ze4fciQVJI/kRoq54Ke2/9HrcRePGeg=;
        b=UgQ+2eNMSF9q2dwHjOKLFVeTJRjngijpc3ulVe3VS9QLxUFo7u0M6bTBSCKabmbyO1x5sf
        0fP3JTEp3C6VSOjRWSJkpz8JbCKs8AI0qzvpFiQY5Cd53suN5LiMo/uL7M8KMuQEAfCx4f
        BQkIgnCyXbb+avp6w1vIdPF0bqRSodQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-HOKFcEOrPyWrx2loTFX0vg-1; Thu, 07 Jul 2022 12:55:02 -0400
X-MC-Unique: HOKFcEOrPyWrx2loTFX0vg-1
Received: by mail-qk1-f199.google.com with SMTP id ay43-20020a05620a17ab00b006b25a9bef3dso17382209qkb.7
        for <linux-nfs@vger.kernel.org>; Thu, 07 Jul 2022 09:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=2XY+z/2FyOr6Ze4fciQVJI/kRoq54Ke2/9HrcRePGeg=;
        b=QoWEfLu7rsPwzK4WIEwiOaQ5lKlM1OFI/quAFU2zGXV4sfRFjKKaEC2QvFMqkJzchy
         Drul+IR5y7q9QqR43zVAyRvjck2DnnRTi1Qkt3hQcOsm62DBr+mByWhfIz2hszQTNDye
         8VUX2RwHFMgwbVTwglNnTGQjaunnW5wD6239lJiO8SL9SgWe1V9z9lLBEAgrTP1Dcmzj
         0oIm5aRk0B9W50xOkzjcXBgZCulAq2x/PpUxX43S/NNKd5JqxxR/a2noRT8lxzmgcM+i
         gKZ/7jvRZdhlqjvqsozHx5nB0kCSOoMHc5wA9OxAJZPH5AnCS7kvrKT6RJjqdeRiujg0
         KZ6A==
X-Gm-Message-State: AJIora/FxeTt15slKkJpuvUuVGOxTe/Z3hGsHupYHSr3CSA/dq7pmrNb
        Gw/VdzOaMl8tL/wBXt0ARz6uYb/Sct6OjClUQDLnLL4NvPeitmTH6+XHBzSdPp7R0BFy/6fT3ii
        gd28pIAuHpnMTO+kLXZBd
X-Received: by 2002:a05:6214:d05:b0:473:1e31:ca76 with SMTP id 5-20020a0562140d0500b004731e31ca76mr7730197qvh.60.1657212901564;
        Thu, 07 Jul 2022 09:55:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v+FkANcesi5w3HJSnntOBeK3MnUjBUYkr9MONu2V9G+wRFD+bPh1LaRSc0LJy8YQF839gkYA==
X-Received: by 2002:a05:6214:d05:b0:473:1e31:ca76 with SMTP id 5-20020a0562140d0500b004731e31ca76mr7730182qvh.60.1657212901324;
        Thu, 07 Jul 2022 09:55:01 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id g19-20020ac87d13000000b00307aed25fc7sm28167067qtb.31.2022.07.07.09.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:55:01 -0700 (PDT)
Message-ID: <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
Subject: Re: [PATCH RFC] NFSD: Bump the ref count on nf_inode
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 07 Jul 2022 12:55:00 -0400
In-Reply-To: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
References: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
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

On Thu, 2022-07-07 at 11:58 -0400, Chuck Lever wrote:
> The documenting comment for struct nf_file states:
>=20
> /*
>  * A representation of a file that has been opened by knfsd. These are ha=
shed
>  * in the hashtable by inode pointer value. Note that this object doesn't
>  * hold a reference to the inode by itself, so the nf_inode pointer shoul=
d
>  * never be dereferenced, only used for comparison.
>  */
>=20
> However, nfsd_file_mark_find_or_create() does dereference the pointer sto=
red
> in this field.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |    3 +++
>  fs/nfsd/filecache.h |    4 +---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> Hi Jeff-
>=20
> I'm still testing this one, but I'm wondering what you think of it.
> I did hit a KASAN splat that might be related, but it's not 100%
> reproducible.
>=20

My first thought is "what the hell was I thinking, tracking an inode
field without holding a reference to it?"

But now that I look, the nf_inode value only gets dereferenced in one
place -- nfs4_show_superblock, and I think that's a bug. The comments
over struct nfsd_file say:

"Note that this object doesn't hold a reference to the inode by itself,
so the nf_inode pointer should never be dereferenced, only used for
comparison."

We should probably annotate nf_inode better. __attribute__((noderef))
maybe? It would also be good to make nfs4_show_superblock use a
different way to get the sb.

In any case, this is unlikely to fix anything unless the crash happened
in nfs4_show_superblock.


>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 9cb2d590c036..7b43bb427a53 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -180,6 +180,7 @@ nfsd_file_alloc(struct inode *inode, unsigned int may=
, unsigned int hashval,
>  		nf->nf_cred =3D get_current_cred();
>  		nf->nf_net =3D net;
>  		nf->nf_flags =3D 0;
> +		ihold(inode);
>  		nf->nf_inode =3D inode;
>  		nf->nf_hashval =3D hashval;
>  		refcount_set(&nf->nf_ref, 1);
> @@ -210,6 +211,7 @@ nfsd_file_free(struct nfsd_file *nf)
>  		fput(nf->nf_file);
>  		flush =3D true;
>  	}
> +	iput(nf->nf_inode);
>  	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>  	return flush;
>  }
> @@ -940,6 +942,7 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  	if (nf =3D=3D NULL)
>  		goto open_file;
>  	spin_unlock(&nfsd_file_hashtbl[hashval].nfb_lock);
> +	iput(new->nf_inode);
>  	nfsd_file_slab_free(&new->nf_rcu);
> =20
>  wait_for_construction:
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 1da0c79a5580..01fbf6e88cce 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -24,9 +24,7 @@ struct nfsd_file_mark {
> =20
>  /*
>   * A representation of a file that has been opened by knfsd. These are h=
ashed
> - * in the hashtable by inode pointer value. Note that this object doesn'=
t
> - * hold a reference to the inode by itself, so the nf_inode pointer shou=
ld
> - * never be dereferenced, only used for comparison.
> + * in the hashtable by inode pointer value.
>   */
>  struct nfsd_file {
>  	struct hlist_node	nf_node;
>=20
>=20

--=20
Jeff Layton <jlayton@redhat.com>

