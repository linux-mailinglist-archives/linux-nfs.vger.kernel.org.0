Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD057C5368
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjJKMQy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 08:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbjJKMQp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 08:16:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927AF10D7
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 05:16:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCF8C433C8;
        Wed, 11 Oct 2023 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697026575;
        bh=RzNSqCEuaeOn6Dvqmt4J4L5ID0izFHkzQq1EZo3v+1E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bmoaVN+IH7vm2xXVcEXwEyLYO3f+Jl308dfMTpjX2MAdndGA4kCEInfqXwfW4NeqP
         FliulufFDzk+gVXn2xrdt7bAfCICPRlkF+oUPDzOHOJlXFwz5A6fpHNqzNppPBg+I1
         vTa/3sDf4jMcPCfu8MwOc1vudoVtF//ycvUMBC7ad3n3TssH4SQxhBdBXVrxOZOal4
         XolpSRtvM7TySoPf/78qQXh2B+XJdPL1F4S6hAg68fwzC5YumwjW175KHO9375Ezv/
         mLjCVp0/6kJ7lORgPBYEN+Rse4VP4jvarQbR3DL+zi+Yrw/pVVow8U6A4Sy0IsDCwW
         Vf+TXjNt5k7jw==
Message-ID: <168b769e12553d9a5974943f523de2f8b903d61b.camel@kernel.org>
Subject: Re: PROBLEM: Pointer dereference error may occur in
 "alloc_init_deleg" function
From:   Jeff Layton <jlayton@kernel.org>
To:     =?UTF-8?Q?=E9=BB=84=E6=80=9D=E8=81=AA?= <huangsicong@iie.ac.cn>,
        chuck.lever@oracle.com
Cc:     neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org
Date:   Wed, 11 Oct 2023 08:16:14 -0400
In-Reply-To: <49ad6b84.57cc.18b1de7572b.Coremail.huangsicong@iie.ac.cn>
References: <49ad6b84.57cc.18b1de7572b.Coremail.huangsicong@iie.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-10-11 at 16:43 +0800, =E9=BB=84=E6=80=9D=E8=81=AA wrote:
> Pointer dereference error may occur in "alloc_init_deleg" function.
>=20
> The "alloc_init_deleg" function located in "fs/nfsd/nfs4state.c" may occu=
r a pointer dereference error when it calls the function "nfs4_alloc_stid" =
located in the same kernel file. The "nfs4_alloc_stid" function will call t=
he "kmem_cache_zalloc" function to allocate enough memory for storing the "=
stid" variable. If there are significant memory fragmentation issues, insuf=
ficient free memory blocks, or internal errors in the allocation function, =
the "kmem_cache_zalloc" function will return NULL. Then the "nfs4_alloc_sti=
d" function will return NULL to the "alloc_init_deleg" function. Finally, t=
he "alloc_init_deleg" function will execute the following instructions.
> dp =3D delegstateid(nfs4_alloc_stid(clp, deleg_slab, nfs4_free_deleg));=
=C2=A0=C2=A0
> if (dp =3D=3D NULL)=C2=A0=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_dec;
> dp->dl_stid.sc_stateid.si_generation =3D 1;
>=20
> The "delegstateid" function is defined as below:
> static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)=
=C2=A0=C2=A0
> {=C2=A0=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return container_of(s, struct nfs4_delegation=
, dl_stid);=C2=A0=C2=A0
> }
>=20
> When the parameter "struct nfs4_stid *s" is NULL, the function will retur=
n a strange value which is a negative number. The value will be interpreted=
 as a very large number. Then the variable "dp" in the "alloc_init_deleg" f=
unction will get the value, and it will pass the following "if" conditional=
 statements. In the last, the variable "dp" will be dereferenced, and it wi=
ll cause an error.
>=20
> My experimental kernel version is "LINUX 6.1", and this problem exists in=
 all the version from "LINUX v3.2-rc1" to "LINUX v6.6-rc5".


(I don't think there are security implications here, so I'm cc'ing the
mailing list and making this public.)

Well spotted! Ordinarily you'd be correct, but dl_stid is the first
field in the struct, so the container_of will just return the same
value that you pass in.

Still, this is not something we ought to rely on going forward. Would
you care to make a patch to clean this up and make that a bit less
subtle?

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
