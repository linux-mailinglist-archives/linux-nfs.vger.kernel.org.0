Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 335FB165F0E
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2020 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgBTNqA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Feb 2020 08:46:00 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54557 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbgBTNqA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Feb 2020 08:46:00 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 77C1321C46;
        Thu, 20 Feb 2020 08:45:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 20 Feb 2020 08:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=4XnS4EAQ3sbBoCGCYF1OCwZdf4F
        XBLDD26zZZTHvikg=; b=bFYqusIA8OAiERg/Ito3e0rjCdr1sap53q7P9ItbkKd
        de09b6NF3puOAY0ixNM/gPFmffpF8Kwij9oxKWbkk2cfXMTwn3L25iReDpE1bzlh
        kKmwODY6NxrDJqGykDfm9nT2DR0PhTMj55+W1OdZPbgPvwMuKIbO1EaRFF2G59UG
        AXRCQ0fwTAn/9PJEznNVxxW1NKJFZCetHaKFW6myoztrn4OS6i/l1f5BqCaL2Px6
        7K3F5VX426TyR0z+aa0DRgOzI7XprLvnch/MdlQ5JVoL4hp+KIXgyygmuUrDGge7
        JiEvL+Y2AwZXdS77f08gHesktOM6zZw/s3ofhwa/w1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4XnS4E
        AQ3sbBoCGCYF1OCwZdf4FXBLDD26zZZTHvikg=; b=0w7ST2VR8wUOIkuPdpQcQs
        jujtfokgk4xNaEdMkJbX3ujDzaJiPGOAy9MbM++aHEMPzPfz1x7oQV31sAR0v1os
        Bd43JzUADvSyzDLplFRN/VzjQJo8LSoBVB0nBMA+zqPBVuU3xfr+xWuL5ppfmHz8
        2j7HNM5VFOvL8oWSUZcNy2FiVOIUDs5Fg4380qpDnruuJDsbMCVWMP4h5fapD70P
        g2a6aUAB35Rkhz9Vd9LiavulyHHfMvcNPuShSdamkyrGO48zxM4+/UfDz5FLxJpx
        W1owi+lsJBb54b3bCcP7kncOvDPUGGyKkPFBSXf1VmZmW7jrMOROijkzHEhsnBbA
        ==
X-ME-Sender: <xms:lY1OXqm1WsDJZu23-BFAQGifNzoVE6_w26pSAfcONXFbq0_f3VQ8iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecukfhppeejkedrheehrd
    dvvddrudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:lY1OXiJdfqaHZNk_-JDJPFi5-pAfDdvapNYKG8V_FyB0EOlAhfhjLg>
    <xmx:lY1OXgQXXcB7Esi0PQZSSwQ0HULMpPp9ESJ4r9uuUaH0QhC7p2s-Vg>
    <xmx:lY1OXpMWMgQo5ichFwd1KbHz2pvGG5xHJZMZ7PLxNbSpDReKEzmwrA>
    <xmx:lo1OXs3YfSXuu_M_Qfb0N9X9vQhhTMtmohGsAf515VzZ6zAZiyNEmA>
Received: from vm-mail (x4e371611.dyn.telefonica.de [78.55.22.17])
        by mail.messagingengine.com (Postfix) with ESMTPA id 327C73280066;
        Thu, 20 Feb 2020 08:45:57 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id ecb766c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Feb 2020 13:45:54 +0000 (UTC)
Date:   Thu, 20 Feb 2020 14:46:24 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        dhowells@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Don't hard-code the fs_type when submounting
Message-ID: <20200220134618.GA4641@ncase>
References: <20200220130620.3547817-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20200220130620.3547817-1-smayhew@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 08:06:20AM -0500, Scott Mayhew wrote:
> Hard-coding the fstype causes "nfs4" mounts to appear as "nfs",
> which breaks scripts that do "umount -at nfs4".
>=20
> Reported-by: Patrick Steinhardt <ps@pks.im>
> Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfs/namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index ad6077404947..f3ece8ed3203 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -153,7 +153,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
>  	/* Open a new filesystem context, transferring parameters from the
>  	 * parent superblock, including the network namespace.
>  	 */
> -	fc =3D fs_context_for_submount(&nfs_fs_type, path->dentry);
> +	fc =3D fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
>  	if (IS_ERR(fc))
>  		return ERR_CAST(fc);

Thanks for your fix! While this fixes the fstype with mount.nfs4(8),
it still doesn't work when using mount(8):

     $ sudo mount server:/mnt /mnt && findmnt -n -ofstype /mnt
     nfs
     $ sudo umount /mnt
     $ sudo mount.nfs4 server:/mnt /mnt && findmnt -n -ofstype /mnt
     nfs4

I guess the issue is that the kernel doesn't yet know which NFS version
the server provides at the point where `fs_context_for_submount()` is
called.

Patrick

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAl5OjbAACgkQEXxntp6r
8Sy4Pg//T70Hg2dkRl6cy4DP5tUvuLGO8rhDRAH3b4A7z6YDvXYfVQ9oV4oYynxP
cgrTMIhjsl0W9egrKx+BCa0OmM5rjl9inp4xkwygAsuVNv7lsc+etke8zLxCslCS
kEhMQmOBFMInOyzcKvJQqJIzidokrK7HYQUu4Q/5wi03p98FgQwVa2TBVLWNBJh3
N4TLlEjw4dv45NuLSotyznxkw9QR6HL9Ro+C20T5p87Zk5T6qiCB5hV75bg0DFGY
Pwa4qCR22qba9lrgKUCQcO4EJ2vaDfulvpuD6kJ/nNCamEFnQemBZ3XrdB8x9/yd
EMELWIjvOLsu+Zj/KTzIvMfX8nLmBJbSR4ob9kSHLqmbccg39wXdJhvaHXmQVmHQ
VNxSLfhW4HDa3ADXOuuuaOBI8y2B4WtG8dHVdu+cSSGtDk0rDvNsT5Z/z/gVuMJh
75OK4dkC3+vy6trKF8NQqDa3r9xpZGfjageGq6wHuM5mwrciY4aE7f7tVcLY5BmI
eJ8QtgxFNJk3QC0kd3zaBsnkhXt2qazf0WyOwgsvNedfMA3UY3ucbKcoLOfiNdAE
t3dHIHn4S7umJZZmSyA7RtOH8PX101bNJAcnuLFTtEY/qn5MIeLbmpYo1UvqrYCO
2HKLah1oaGcFNBb2LzI8uRsz0adziaEyO6uHG0HrNzC5q3lb5ik=
=+INL
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
