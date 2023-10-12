Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF957C6E67
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 14:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjJLMo6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 08:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjJLMo6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 08:44:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD891
        for <linux-nfs@vger.kernel.org>; Thu, 12 Oct 2023 05:44:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650A1C433C7;
        Thu, 12 Oct 2023 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697114695;
        bh=hYikDbKIFlA5SYALnivWpkSNVZhOw55S9ve0U/TrItM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j7v0/bwjXtfwpgUKm9dX4SrAjwUIjey2Owi7+vr8bOQmPpmr4ZDK02mxcn/P+d1KA
         9CUoKEs5pmdLNgg3AlY7dY+fcTuZ3O5bUXaM+D9+OPwhYskObZpu/LyUjEEGNU8c3B
         ln1qHBwkYMI9WPWU3Vfa/6MlCVDqtr+9INTsx9dQNN7WR0jVfT8eHhBNUj8p0+ax/m
         sTfSghSfFkv1FKSHRhK5XBtjqlGbxb+uRH9Z25Nftikwo73fUur5QnD7Z9yrGpTig9
         2zlTV8YtbpstiB2tDC0jS3NOJDgOPw8vbPtJBSdKRyI5XPyHTJWLf6qmI3QZKi7+mf
         uwqWnCHJDSbkw==
Message-ID: <00b0e6b1963cd1a620e38c493e1d14871d83e151.camel@kernel.org>
Subject: Re: [PATCH v1] NFSD: clean up alloc_init_deleg()
From:   Jeff Layton <jlayton@kernel.org>
To:     =?UTF-8?Q?=E9=BB=84=E6=80=9D=E8=81=AA?= <huangsicong@iie.ac.cn>
Cc:     chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Date:   Thu, 12 Oct 2023 08:44:53 -0400
In-Reply-To: <280c4ab8.22ed.18b230651e6.Coremail.huangsicong@iie.ac.cn>
References: <49ad6b84.57cc.18b1de7572b.Coremail.huangsicong@iie.ac.cn>
         <168b769e12553d9a5974943f523de2f8b903d61b.camel@kernel.org>
         <280c4ab8.22ed.18b230651e6.Coremail.huangsicong@iie.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-10-12 at 16:34 +0800, =E9=BB=84=E6=80=9D=E8=81=AA wrote:
> &gt; On Wed, 2023-10-11 at 16:43 +0800, =E9=BB=84=E6=80=9D=E8=81=AA wrote=
:
> &gt; &gt; Pointer dereference error may occur in "alloc_init_deleg" funct=
ion.
> &gt; &gt;=20
> &gt; &gt; The "alloc_init_deleg" function located in "fs/nfsd/nfs4state.c=
" may occur a pointer dereference error when it calls the function "nfs4_al=
loc_stid" located in the same kernel file. The "nfs4_alloc_stid" function w=
ill call the "kmem_cache_zalloc" function to allocate enough memory for sto=
ring the "stid" variable. If there are significant memory fragmentation iss=
ues, insufficient free memory blocks, or internal errors in the allocation =
function, the "kmem_cache_zalloc" function will return NULL. Then the "nfs4=
_alloc_stid" function will return NULL to the "alloc_init_deleg" function. =
Finally, the "alloc_init_deleg" function will execute the following instruc=
tions.
> &gt; &gt; dp =3D delegstateid(nfs4_alloc_stid(clp, deleg_slab, nfs4_free_=
deleg));&nbsp;&nbsp;
> &gt; &gt; if (dp =3D=3D NULL)&nbsp;&nbsp;
> &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; goto out_dec;
> &gt; &gt; dp-&gt;dl_stid.sc_stateid.si_generation =3D 1;
> &gt; &gt;=20
> &gt; &gt; The "delegstateid" function is defined as below:
> &gt; &gt; static inline struct nfs4_delegation *delegstateid(struct nfs4_=
stid *s)&nbsp;&nbsp;
> &gt; &gt; {&nbsp;&nbsp;
> &gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; return container_of(s, struct nfs4_=
delegation, dl_stid);&nbsp;&nbsp;
> &gt; &gt; }
> &gt; &gt;=20
> &gt; &gt; When the parameter "struct nfs4_stid *s" is NULL, the function =
will return a strange value which is a negative number. The value will be i=
nterpreted as a very large number. Then the variable "dp" in the "alloc_ini=
t_deleg" function will get the value, and it will pass the following "if" c=
onditional statements. In the last, the variable "dp" will be dereferenced,=
 and it will cause an error.
> &gt; &gt;=20
> &gt; &gt; My experimental kernel version is "LINUX 6.1", and this problem=
 exists in all the version from "LINUX v3.2-rc1" to "LINUX v6.6-rc5".
> &gt;=20
> &gt;=20
> &gt; (I don't think there are security implications here, so I'm cc'ing t=
he
> &gt; mailing list and making this public.)
> &gt;=20
> &gt; Well spotted! Ordinarily you'd be correct, but dl_stid is the first
> &gt; field in the struct, so the container_of will just return the same
> &gt; value that you pass in.
> &gt;=20
> &gt; Still, this is not something we ought to rely on going forward. Woul=
d
> &gt; you care to make a patch to clean this up and make that a bit less
> &gt; subtle?
> &gt;=20
> &gt; Thanks!
> &gt; --=20
> &gt; Jeff Layton <jlayton@kernel.org>
>=20
>=20
> Thank you for your feedback! Indeed, you are correct! Next time I will ch=
eck it twice before reporting a problem.
>=20
> My patch is below:
>=20
> Modify the conditional statement for null pointer check in the function
> 'alloc_init_deleg' to make this function more robust and clear. Otherwise=
,
> this function may have potential pointer dereference problem in the futur=
e,
> when modifying or expanding the nfs4_delegation structure.
>=20
> Signed-off-by: Sicong Huang <huangsicong@iie.ac.cn>
> ---
>  fs/nfsd/nfs4state.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b1118050ff52..516b8bd6cb53 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1160,6 +1160,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nf=
s4_file *fp,
>  		 struct nfs4_clnt_odstate *odstate, u32 dl_type)
>  {
>  	struct nfs4_delegation *dp;
> +	struct nfs4_stid *stid;
>  	long n;
> =20
>  	dprintk("NFSD alloc_init_deleg\n");
> @@ -1168,9 +1169,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct n=
fs4_file *fp,
>  		goto out_dec;
>  	if (delegation_blocked(&amp;fp-&gt;fi_fhandle))
>  		goto out_dec;
> -	dp =3D delegstateid(nfs4_alloc_stid(clp, deleg_slab, nfs4_free_deleg));
> -	if (dp =3D=3D NULL)
> +	stid =3D nfs4_alloc_stid(clp, deleg_slab, nfs4_free_deleg);
> +	if (stid =3D=3D NULL)
>  		goto out_dec;
> +	dp =3D delegstateid(stid);
> =20
>  	/*
>  	 * delegation seqid's are never incremented.  The 4.1 special

Reviewed-by: Jeff Layton <jlayton@kernel.org>
