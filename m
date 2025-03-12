Return-Path: <linux-nfs+bounces-10565-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61AA5DF1A
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 15:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2398D189F516
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097FF23A563;
	Wed, 12 Mar 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+vJZKAz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D320624337B;
	Wed, 12 Mar 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790244; cv=none; b=TSHaz4CY6YLXCbrNwPkaKkahp5zDlthnDMhsumpVa6slrH2lMuQ2enWDddBKiTJb07lXpA8VtPQM7S7ULHHfiXMMu21v1AcdJkFvUHymgg10DqHMg+hwSkEgOGqSyjOuKvF0uaXdEdYfWOKpEaDO9VyJTNaf8CcStI0Wo/wQ01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790244; c=relaxed/simple;
	bh=34WGHJjHDWSWmmj+x+L96ai2LNag9daJ1fzZnAmNoP0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQQJa483STMXo9uyTjVOVRH0BoDSq++HehET6BErAJ5DNonh8NAanxn13YgHaKhQoHacCWPfO1FX0gKB9zJhWhaKCW3OXVqMjmC8IT8QYFpiBT+OfYocgBe2t9sn2xkEM61kCmdkp1fllovVwVTPL/sfMciQPfJolkmyMzu8BxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+vJZKAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A18C4CEDD;
	Wed, 12 Mar 2025 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741790244;
	bh=34WGHJjHDWSWmmj+x+L96ai2LNag9daJ1fzZnAmNoP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=f+vJZKAzJ2oVhLpdz21hR0eKxFc0wu/EzRaQjjhCVOhP8s5uKumdTX42Fi19Tf4TF
	 gmLEVIjNMALDEn1aBlUFbpozdWhC77B8dWDREN3WsgbTYeUd4h8zJ2uJhi0mG4CMYN
	 2VLAXzFYzu0L/xUEcMzoxP29WT3dYiycZc1Ep0sIf6p+NcPJjDKuvQonK5rEjzl28h
	 c9fBg0Ad0lZrWQqKVi/tHhSBrwi4IxG6xZ/EGgOF5qTLs1d3eLcLIvVkfsbqiDWLpF
	 sWaFgD1cGQQPBmShbRE1nL/ZfyF4P7LdU5V68jNbJorwMe7v93Nc0QL3GbbPNOAUs6
	 Bn426XraQOx+Q==
Message-ID: <997f992f951bd235953c5f0e2959da6351a65adb.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: add a rpc_clnt shutdown control in debugfs
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Mar 2025 10:37:22 -0400
In-Reply-To: <7906109F-91D2-4ECF-B868-5519B56D2CEE@redhat.com>
References: <20250312-rpc-shutdown-v1-1-cc90d79a71c2@kernel.org>
	 <7906109F-91D2-4ECF-B868-5519B56D2CEE@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BB
 MBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4
 gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI
 7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/r0km
 R/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2B
 rQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRI
 ONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZ
 Wf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQO
 lDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7Rj
 iR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27Xi
 QQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBM
 YXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKC
 wQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9q
 LqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC
 3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoa
 c8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3F
 LpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx3bri75n1
 TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw
 87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2
 xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y
 +jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5d
 Hxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBM
 BAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4h
 N9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPep
 naQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQ
 RERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6
 FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR
 685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8Eew
 P8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0Xzh
 aKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyAnLqRgDgR+wTQ
 T6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7h
 dMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b
 24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAg
 kKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjr
 uymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItu
 AXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfD
 FOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce
 6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbo
 sZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDv
 qrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51a
 sjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qG
 IcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbL
 UO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRh
 dGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOa
 EEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSU
 apy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50
 M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5d
 dhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn
 0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0
 jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7e
 flPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0
 BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7B
 AKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc
 8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQg
 HAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD
 2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozz
 uxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9J
 DfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRD
 CHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1g
 Yy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVV
 AaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJO
 aEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhp
 f8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+m
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-12 at 09:52 -0400, Benjamin Coddington wrote:
> On 12 Mar 2025, at 9:36, Jeff Layton wrote:
>=20
> > There have been confirmed reports where a container with an NFS mount
> > inside it dies abruptly, along with all of its processes, but the NFS
> > client sticks around and keeps trying to send RPCs after the networking
> > is gone.
> >=20
> > We have a reproducer where if we SIGKILL a container with an NFS mount,
> > the RPC clients will stick around indefinitely. The orchestrator
> > does a MNT_DETACH unmount on the NFS mount, and then tears down the
> > networking while there are still RPCs in flight.
> >=20
> > Recently new controls were added[1] that allow shutting down an NFS
> > mount. That doesn't help here since the mount namespace is detached fro=
m
> > any tasks at this point.
>=20
> That's interesting - seems like the orchestrator could just reorder its
> request to shutdown before detaching the mount namespace.  Not an objecti=
on,
> just wondering why the MNT_DETACH must come first.
>=20

The reproducer we have is to systemd-nspawn a container, mount up an
NFS mount inside it, start some I/O on it with fio and then kill -9 the
systemd running inside the container. There isn't much the orchestrator
(root-level systemd) can do to at that point other than clean up what's
left.

I'm still working on a way to reliably detect when this has happened.
For now, we just have to notice that some clients aren't dying.

> > Transplant shutdown_client() to the sunrpc module, and give it a more
> > distinct name. Add a new debugfs sunrpc/rpc_clnt/*/shutdown knob that
> > allows the same functionality as the one in /sys/fs/nfs, but at the
> > rpc_clnt level.
> >=20
> > [1]: commit d9615d166c7e ("NFS: add sysfs shutdown knob").
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> I have a TODO to patch Documentation/ for this knob mostly to write warni=
ngs
> because there are some potential "gotchas" here - for example you can hav=
e
> shared RPC clients and shutting down one of those can cause problems for =
a
> different mount (this is true today with the /sys/fs/nfs/[bdi]/shutdown
> knob).  Shutting down aribitrary clients will definitely break things in
> weird ways, its not a safe place to explore.
>=20

Yes, you really do need to know what you're doing. 0200 permissions are
essential for this file, IOW. Thanks for the R-b!

> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>=20
> Ben
>=20
> > ---
> >  fs/nfs/sysfs.c               | 19 ++++---------------
> >  include/linux/sunrpc/sched.h |  1 +
> >  net/sunrpc/clnt.c            | 12 ++++++++++++
> >  net/sunrpc/debugfs.c         | 15 +++++++++++++++
> >  4 files changed, 32 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> > index 7b59a40d40c061a41b0fbde91aa006314f02c1fb..c29c5fd639554461bdcd9ff=
612726194910d85b5 100644
> > --- a/fs/nfs/sysfs.c
> > +++ b/fs/nfs/sysfs.c
> > @@ -217,17 +217,6 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns=
)
> >  	}
> >  }
> >=20
> > -static bool shutdown_match_client(const struct rpc_task *task, const v=
oid *data)
> > -{
> > -	return true;
> > -}
> > -
> > -static void shutdown_client(struct rpc_clnt *clnt)
> > -{
> > -	clnt->cl_shutdown =3D 1;
> > -	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
> > -}
> > -
> >  static ssize_t
> >  shutdown_show(struct kobject *kobj, struct kobj_attribute *attr,
> >  				char *buf)
> > @@ -258,14 +247,14 @@ shutdown_store(struct kobject *kobj, struct kobj_=
attribute *attr,
> >  		goto out;
> >=20
> >  	server->flags |=3D NFS_MOUNT_SHUTDOWN;
> > -	shutdown_client(server->client);
> > -	shutdown_client(server->nfs_client->cl_rpcclient);
> > +	rpc_clnt_shutdown(server->client);
> > +	rpc_clnt_shutdown(server->nfs_client->cl_rpcclient);
> >=20
> >  	if (!IS_ERR(server->client_acl))
> > -		shutdown_client(server->client_acl);
> > +		rpc_clnt_shutdown(server->client_acl);
> >=20
> >  	if (server->nlm_host)
> > -		shutdown_client(server->nlm_host->h_rpcclnt);
> > +		rpc_clnt_shutdown(server->nlm_host->h_rpcclnt);
> >  out:
> >  	return count;
> >  }
> > diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.=
h
> > index eac57914dcf3200c1a6ed39ab030e3fe8b4da3e1..fe7c39a17ce44ec68c0cf05=
7133d0f8e7f0ae797 100644
> > --- a/include/linux/sunrpc/sched.h
> > +++ b/include/linux/sunrpc/sched.h
> > @@ -232,6 +232,7 @@ unsigned long	rpc_cancel_tasks(struct rpc_clnt *cln=
t, int error,
> >  				 bool (*fnmatch)(const struct rpc_task *,
> >  						 const void *),
> >  				 const void *data);
> > +void		rpc_clnt_shutdown(struct rpc_clnt *clnt);
> >  void		rpc_execute(struct rpc_task *);
> >  void		rpc_init_priority_wait_queue(struct rpc_wait_queue *, const char=
 *);
> >  void		rpc_init_wait_queue(struct rpc_wait_queue *, const char *);
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index 2fe88ea79a70c134e58abfb03fca230883eddf1f..0028858b12d97e7b45f4c24=
cfbd761ba2a734b32 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -934,6 +934,18 @@ unsigned long rpc_cancel_tasks(struct rpc_clnt *cl=
nt, int error,
> >  }
> >  EXPORT_SYMBOL_GPL(rpc_cancel_tasks);
> >=20
> > +static bool shutdown_match_client(const struct rpc_task *task, const v=
oid *data)
> > +{
> > +	return true;
> > +}
> > +
> > +void rpc_clnt_shutdown(struct rpc_clnt *clnt)
> > +{
> > +	clnt->cl_shutdown =3D 1;
> > +	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
> > +}
> > +EXPORT_SYMBOL_GPL(rpc_clnt_shutdown);
> > +
> >  static int rpc_clnt_disconnect_xprt(struct rpc_clnt *clnt,
> >  				    struct rpc_xprt *xprt, void *dummy)
> >  {
> > diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
> > index 32417db340de3775c533d0ad683b5b37800d7fe5..4df31dcca2d747db6767c12=
ddfa29963ed7be204 100644
> > --- a/net/sunrpc/debugfs.c
> > +++ b/net/sunrpc/debugfs.c
> > @@ -145,6 +145,17 @@ static int do_xprt_debugfs(struct rpc_clnt *clnt, =
struct rpc_xprt *xprt, void *n
> >  	return 0;
> >  }
> >=20
> > +static int
> > +clnt_shutdown(void *data, u64 value)
> > +{
> > +	struct rpc_clnt *clnt =3D data;
> > +
> > +	rpc_clnt_shutdown(clnt);
> > +	return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(shutdown_fops, NULL, clnt_shutdown, "%llu\n")=
;
> > +
> >  void
> >  rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
> >  {
> > @@ -163,6 +174,10 @@ rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
> >  	debugfs_create_file("tasks", S_IFREG | 0400, clnt->cl_debugfs, clnt,
> >  			    &tasks_fops);
> >=20
> > +	/* make shutdown file */
> > +	debugfs_create_file("shutdown", S_IFREG | 0200, clnt->cl_debugfs, cln=
t,
> > +			    &shutdown_fops);
> > +
> >  	rpc_clnt_iterate_for_each_xprt(clnt, do_xprt_debugfs, &xprtnum);
> >  }
> >=20
> >=20
> > ---
> > base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> > change-id: 20250312-rpc-shutdown-ce9b6d3599da
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20

--=20
Jeff Layton <jlayton@kernel.org>

