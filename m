Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFCD56A9A2
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 19:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiGGRal (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 13:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiGGRak (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 13:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38D0830553
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 10:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657215038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tGWYqmlLJcSgBP6hzyYQQhxnz4dcU1VE5hZAqrl66E=;
        b=Sq5sbWm8ql8OQ4Ylkd1grMpqEbDPXjaqGKusHNUKku38T5S5Pt8JOcMamxbAHwSY3RZXlc
        s7ECnP2t4wqF9EUBo4v37SEkBhTLJhWQE3mSlvXDPJOrhDoN5ikpb9G0qARvHBy/F3Gm/V
        2yWI5ssNKZz+SvsIiWzoEU7YJVjXsZQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-jkgz7ecbMx2AjmR47VlLpA-1; Thu, 07 Jul 2022 13:30:37 -0400
X-MC-Unique: jkgz7ecbMx2AjmR47VlLpA-1
Received: by mail-qk1-f197.google.com with SMTP id z9-20020a376509000000b006af1048e0caso18534423qkb.17
        for <linux-nfs@vger.kernel.org>; Thu, 07 Jul 2022 10:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=6tGWYqmlLJcSgBP6hzyYQQhxnz4dcU1VE5hZAqrl66E=;
        b=ubX68hkDbWNhZp639DpbPpjs7JpStRqAt0cK7/L8VhNQflsfP08KH97ZdqGcWozsTj
         +u4mu9cIpkuRZAgAm3bgzZnl0yP0M3ZWTNp+RtNb7cGNs0UhNIwTYnaD+Rqj/lEbA0ov
         El/7F8g416o5EHeYBeCLAuqickGXlIsC0XhOPp4xO3eK+zlYPjgscWBw+EhSfqIx3Dg4
         ou+DoOD/z4N3ZjfkvsaxZ/6M2CuLdtQMubBwQQ/5hJHPAKpQRvhdSWvn+EkxJIMcbS4a
         GaXaaRnc+I1nTYjZjMOdiXyOnM8tiKp+rSJboeI1ooqkYfKrDHVJMbeUmFTPXqEZSFTK
         KyFQ==
X-Gm-Message-State: AJIora/E/fwNAXxhJKEsIxaP+clWnrkaRRW+ob255GQGB8wPN9jKHrW+
        MZmKYhMUBw19I5w1yXuk3Zd7v+czQXUShR5HHHzuKzc/Pd7mwkik+CYWUx+np/9mt9vJu2oKD+D
        WACzxaIwtaGCi4GRVrnpF
X-Received: by 2002:a05:622a:13ce:b0:31a:b4ce:1679 with SMTP id p14-20020a05622a13ce00b0031ab4ce1679mr38986169qtk.330.1657215036652;
        Thu, 07 Jul 2022 10:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uyzIV3+rMXpExX+bmGIalN6zMDXgn7v2JMYdQcs/6FKlaOZwMfp+wAzkSzuhBC/WOlas60mQ==
X-Received: by 2002:a05:622a:13ce:b0:31a:b4ce:1679 with SMTP id p14-20020a05622a13ce00b0031ab4ce1679mr38986143qtk.330.1657215036401;
        Thu, 07 Jul 2022 10:30:36 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a280a00b006a69d7f390csm33189731qkp.103.2022.07.07.10.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:30:36 -0700 (PDT)
Message-ID: <7bc372783500c40d39c6a6a2eac1b7690f1ab3ad.camel@redhat.com>
Subject: Re: [PATCH RFC] NFSD: Bump the ref count on nf_inode
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 07 Jul 2022 13:30:35 -0400
In-Reply-To: <5B84D6D2-E9BC-4518-B52C-ABAF240DE2A1@oracle.com>
References: <165720933938.1180.14325183467695610136.stgit@klimt.1015granger.net>
         <f3dc1a01fae6759a350adabf944892417a63d529.camel@redhat.com>
         <5B84D6D2-E9BC-4518-B52C-ABAF240DE2A1@oracle.com>
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

On Thu, 2022-07-07 at 17:25 +0000, Chuck Lever III wrote:
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
>=20
> How about f->nf_file->f_inode ?
>=20
>=20

I'd probably prefer:

    file_inode(f->nf_file)

...and I don't think there is a potential crash here either.
nfs4_show_superblock is called while holding the cl_lock. I don't think
the inode can disappear out from under you with that.

--=20
Jeff Layton <jlayton@redhat.com>

