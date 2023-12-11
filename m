Return-Path: <linux-nfs+bounces-500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B9780DF42
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Dec 2023 00:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F69F1C21429
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 23:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B19F56465;
	Mon, 11 Dec 2023 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSKaJ51o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D40F9F0
	for <linux-nfs@vger.kernel.org>; Mon, 11 Dec 2023 23:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0081C433C8;
	Mon, 11 Dec 2023 23:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702336266;
	bh=3N7K+bl3nw61+mzU16eaoEW0ZzR64PqvIAvnM3XqrMM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cSKaJ51o+oc/5TwlcsTR6wofnuzWooR0FiEqQft7J64Cui2k1uSLTY947maPDG4Id
	 NyZu9U/byVYd978BAmqsqpsJtjDgjzXNlphd5qzWvnHyQ15wDO9IDgjMtEeBF+avRc
	 zWwz3ulIzz8neT0bApPArM4Kg2TQAIfyM05ZgUE6okZGrxInORkbMTn9m3HmL3PPkQ
	 6SZY3UeJFKhThZzEGea3zbeXb2/02Rm29EfZp6VT9HF+NAqnxXovsbJU2SkMZEAwbn
	 aaQR0IqLQ1iMNQ4Ln6qEFRf62Fe6SVfU4G2P6e9BIss4kF/FpWwDUmB2LjrYsjW+kL
	 Fn8vtdDKlKp2w==
Message-ID: <a2b59634a697ae07a315d6f663afaff5cd5bf375.camel@kernel.org>
Subject: Re: [PATCH] nfsd: properly tear down server when write_ports fails
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia
 <kolga@netapp.com>,  Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, linux-nfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
 Zhi Li <yieli@redhat.com>
Date: Mon, 11 Dec 2023 18:11:04 -0500
In-Reply-To: <170233558429.12910.17902271117186364002@noble.neil.brown.name>
References: <20231211-nfsd-fixes-v1-1-c87a802f4977@kernel.org>
	 <170233558429.12910.17902271117186364002@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxwn8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1WvegyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqVT2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtVYrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8snVluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQcDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQfCBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sELZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/
	r0kmR/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2BrQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRIONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZWf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQOlDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7RjiR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27XiQQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBMYXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9qLqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoac8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3FLpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx
	3bri75n1TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y+jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5dHxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBMBAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4hN9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPepnaQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQRERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8EewP8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0XzhaKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyA
	nLqRgDgR+wTQT6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7hdMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjruymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItuAXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfDFOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbosZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDvqrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51asjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qGIcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbLUO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0
	b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSUapy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5ddhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7eflPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7BAKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuac
	BOTtmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65ke5Ag0ETpXRPAEQAJkVmzCmF+IEenf9a2nZRXMluJohnfl2wCMmw5qNzyk0f+mYuTwTCpw7BE2H0yXk4ZfAuA+xdj14K0A1Dj52j/fKRuDqoNAhQe0b6ipo85Sz98G+XnmQOMeFVp5G1Z7r/QP/nus3mXvtFsu9lLSjMA0cam2NLDt7vx3l9kUYlQBhyIE7/DkKg+3fdqRg7qJoMHNcODtQY+n3hMyaVpplJ/l0DdQDbRSZi5AzDM3DWZEShhuP6/E2LN4O3xWnZukEiz688d1ppl7vBZO9wBql6Ft9Og74diZrTN6lXGGjEWRvO55h6ijMsLCLNDRAVehPhZvSlPldtUuvhZLAjdWpwmzbRIwgoQcO51aWeKthpcpj8feDdKdlVjvJO9fgFD5kqZ
	QiErRVPpB7VzA/pYV5Mdy7GMbPjmO0IpoL0tVZ8JvUzUZXB3ErS/dJflvboAAQeLpLCkQjqZiQ/DCmgJCrBJst9Xc7YsKKS379Tc3GU33HNSpaOxs2NwfzoesyjKU+P35czvXWTtj7KVVSj3SgzzFk+gLx8y2Nvt9iESdZ1Ustv8tipDsGcvIZ43MQwqU9YbLg8k4V9ch+Mo8SE+C0jyZYDCE2ZGf3OztvtSYMsTnF6/luzVyej1AFVYjKHORzNoTwdHUeC+9/07GO0bMYTPXYvJ/vxBFm3oniXyhgb5FtABEBAAGJAh8EGAECAAkFAk6V0TwCGwwACgkQAA5oQRlWghXhZRAAyycZ2DDyXh2bMYvI8uHgCbeXfL3QCvcw2XoZTH2l2umPiTzrCsDJhgwZfG9BDyOHaYhPasd5qgrUBtjjUiNKjVM+Cx1DnieR0dZWafnqGv682avPblfi70XXr2juRE/fSZoZkyZhm+nsLuIcXTnzY4D572JGrpRMTpNpGmitBdh1l/9O7Fb64uLOtA5Qj5jcHHOjL0DZpjmFWYKlSAHmURHrE8M0qRryQXvlhoQxlJR4nvQrjOPMsqWD5F9mcRyowOzr8amasLv43w92rD2nHoBK6rbFE/qC7AAjABEsZq8+TQmueN0maIXUQu7TBzejsEbV0i29z+kkrjU2NmK5pcxgAtehVxpZJ14LqmN6E0suTtzjNT1eMoqOPrMSx+6vOCIuvJ/MVYnQgHhjtPPnU86mebTY5Loy9YfJAC2EVpxtcCbx2KiwErTndEyWL+GL53LuScUD7tW8vYbGIp4RlnUgPLbqpgssq2gwYO9m75FGuKuB2+2bCGajqalid5nzeq9v7cYLLRgArJfOIBWZrHy2m0C+pFu9DSuV6SNr2dvMQUv1V58h0FaSOxHVQnJdnoHn13g/CKKvyg2EMrMt/EfcXgvDwQbnG9we4xJiWOIOcsvrWcB6C6lWBDA+In7w7SXnnok
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-12 at 09:59 +1100, NeilBrown wrote:
> On Tue, 12 Dec 2023, Jeff Layton wrote:
> > When the initial write to the "portlist" file fails, we'll currently pu=
t
> > the reference to the nn->nfsd_serv, but leave the pointer intact. This
> > leads to a UAF if someone tries to write to "portlist" again.
> >=20
> > Simple reproducer, from a host with nfsd shut down:
> >=20
> >     # echo "foo 2049" > /proc/fs/nfsd/portlist
> >     # echo "foo 2049" > /proc/fs/nfsd/portlist
> >=20
> > The kernel will oops on the second one when it trips over the dangling
> > nn->nfsd_serv pointer. There is a similar bug in __write_ports_addfd.
> >=20
> > This patch fixes it by adding some extra logic to nfsd_put to ensure
> > that nfsd_last_thread is called prior to putting the reference when the
> > conditions are right.
> >=20
> > Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()=
")
> > Closes: https://issues.redhat.com/browse/RHEL-19081
> > Reported-by: Zhi Li <yieli@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > This should probably go to stable, but we'll need to backport for v6.6
> > since older kernels don't have nfsd_nl_rpc_status_get_done. We should
> > just be able to drop that hunk though.
> > ---
> >  fs/nfsd/nfsctl.c | 32 ++++++++++++++++++++++++++++----
> >  fs/nfsd/nfsd.h   |  8 +-------
> >  fs/nfsd/nfssvc.c |  2 +-
> >  3 files changed, 30 insertions(+), 12 deletions(-)
>=20
> This is much the same as
>=20
> https://lore.kernel.org/linux-nfs/20231030011247.9794-2-neilb@suse.de/
>=20
> It seems that didn't land.  Maybe I dropped the ball...
>=20
>=20

Indeed it is. I thought the problem seemed familiar. Your set is
considerably more comprehensive. Looks like I even sent some Reviewed-
bys when you sent it.

Chuck, can we get these in or was there a problem with them?

Thanks,

>=20
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 3e15b72f421d..1ceccf804e44 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -61,6 +61,30 @@ enum {
> >  	NFSD_MaxReserved
> >  };
> > =20
> > +/**
> > + * nfsd_put - put the reference to the nfsd_serv for given net
> > + * @net: the net namespace for the serv
> > + * @err: current error for the op
> > + *
> > + * When putting a reference to the nfsd_serv from a control operation
> > + * we must first call nfsd_last_thread if all of these are true:
> > + *
> > + * - the configuration operation is going fail
> > + * - there are no running threads
> > + * - there are no successfully configured ports
> > + *
> > + * Otherwise, just put the serv reference.
> > + */
> > +static inline void nfsd_put(struct net *net, int err)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	struct svc_serv *serv =3D nn->nfsd_serv;
> > +
> > +	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> > +		nfsd_last_thread(net);
> > +	svc_put(serv);
> > +}
> > +
> >  /*
> >   * write() for these nodes.
> >   */
> > @@ -709,7 +733,7 @@ static ssize_t __write_ports_addfd(char *buf, struc=
t net *net, const struct cred
> >  	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> >  		svc_get(nn->nfsd_serv);
> > =20
> > -	nfsd_put(net);
> > +	nfsd_put(net, err);
> >  	return err;
> >  }
> > =20
> > @@ -748,7 +772,7 @@ static ssize_t __write_ports_addxprt(char *buf, str=
uct net *net, const struct cr
> >  	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> >  		svc_get(nn->nfsd_serv);
> > =20
> > -	nfsd_put(net);
> > +	nfsd_put(net, 0);
> >  	return 0;
> >  out_close:
> >  	xprt =3D svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
> > @@ -757,7 +781,7 @@ static ssize_t __write_ports_addxprt(char *buf, str=
uct net *net, const struct cr
> >  		svc_xprt_put(xprt);
> >  	}
> >  out_err:
> > -	nfsd_put(net);
> > +	nfsd_put(net, err);
> >  	return err;
> >  }
> > =20
> > @@ -1687,7 +1711,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff =
*skb,
> >  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
> >  {
> >  	mutex_lock(&nfsd_mutex);
> > -	nfsd_put(sock_net(cb->skb->sk));
> > +	nfsd_put(sock_net(cb->skb->sk), 0);
> >  	mutex_unlock(&nfsd_mutex);
> > =20
> >  	return 0;
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index f5ff42f41ee7..3aa8cd2c19ac 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -113,13 +113,6 @@ int		nfsd_pool_stats_open(struct inode *, struct f=
ile *);
> >  int		nfsd_pool_stats_release(struct inode *, struct file *);
> >  void		nfsd_shutdown_threads(struct net *net);
> > =20
> > -static inline void nfsd_put(struct net *net)
> > -{
> > -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > -
> > -	svc_put(nn->nfsd_serv);
> > -}
> > -
> >  bool		i_am_nfsd(void);
> > =20
> >  struct nfsdfs_client {
> > @@ -153,6 +146,7 @@ struct nfsd_net;
> >  enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
> >  int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
> >  int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers=
_op change);
> > +void nfsd_last_thread(struct net *net);
> >  void nfsd_reset_versions(struct nfsd_net *nn);
> >  int nfsd_create_serv(struct net *net);
> > =20
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index fe61d9bbcc1f..d6939e23ffcf 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -542,7 +542,7 @@ static struct notifier_block nfsd_inet6addr_notifie=
r =3D {
> >  /* Only used under nfsd_mutex, so this atomic may be overkill: */
> >  static atomic_t nfsd_notifier_refcount =3D ATOMIC_INIT(0);
> > =20
> > -static void nfsd_last_thread(struct net *net)
> > +void nfsd_last_thread(struct net *net)
> >  {
> >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >  	struct svc_serv *serv =3D nn->nfsd_serv;
> >=20
> > ---
> > base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> > change-id: 20231211-nfsd-fixes-d9f21d5c12d7
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

