Return-Path: <linux-nfs+bounces-2165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6648702C0
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 14:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0BB1F22A17
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA673DB91;
	Mon,  4 Mar 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap25I0oA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56E3D982
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559056; cv=none; b=HtV7bUFshvCENFmg+nUXjKtzUPKJhpX6EUErGz7Elrtp/YbM/PyRUtbyZMOdUXO709vLylyMBMuZUkbwwucSlq75NaZN9YreKzvFv8ZQZ433vREvGiMlMpzEYP8dgdhyPHuT3c2v+JI3TlaqhoRL6YogL/d7tREObhw3/g6Hgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559056; c=relaxed/simple;
	bh=tiWV7Ame2Dlbvz8on9as3pFb0cxkEt6Y0ueljNj49+M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ixsp4GJqKuT5cE43/j5ijfLiLTLvEPY7xmd7cZr14q2XQYzRspcaqij3lzZZl0LGNRs2J7LGY14qEnC7vnpC1GJiGp3tvJEXsiT1SOG6Uf0AbrW8boQbNiMbNKJGxwiSY6vbHlDEmSM92YEF7L/nV2XapAH6Al4S1saZbbbGUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap25I0oA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69307C43390;
	Mon,  4 Mar 2024 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559055;
	bh=tiWV7Ame2Dlbvz8on9as3pFb0cxkEt6Y0ueljNj49+M=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Ap25I0oAymtW8qeOqJ2YiIonOe2+HbN0jT913hZXdT4tNI8NGm9ZtGP2p0C7wSbHw
	 cOGAg+hjKRHR18HVRcBzbdWREBnrEoFomY7O3RwT/O/b9DCcjLK1+v3U3xtcMl+qyS
	 9khotpfl1AyU7G927pJia3VRUK0zUltQbJOhhvpiWw4eokmKNmnBRtLb+8T217w8Ye
	 PuPiNt9Ix7H3La0GuMHu2jD/gpGARVE/2RKfyUvWy899pl3rgUvLTyUPCXZTmYrBgd
	 cj56+/MlXN7TZvBddwM18t4bjuh6Lqgie+KwufijwMWuY1hPRh68RmgzI/l72gmLXi
	 G1rdhYSBSMi8Q==
Message-ID: <194ad428dedc88a5b76e14e31667244d7f99a915.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfs: fix UAF in direct writes
From: Jeff Layton <jlayton@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, trond.myklebust@hammerspace.com, 
	anna@kernel.org, linux-nfs@vger.kernel.org
Date: Mon, 04 Mar 2024 08:30:54 -0500
In-Reply-To: <d4a26214294fb967a6d828b8d750215f7a6e4897.1709311699.git.josef@toxicpanda.com>
References: <cover.1709311699.git.josef@toxicpanda.com>
	 <d4a26214294fb967a6d828b8d750215f7a6e4897.1709311699.git.josef@toxicpanda.com>
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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-01 at 11:49 -0500, Josef Bacik wrote:
> In production we have been hitting the following warning consistently
>=20
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 17 PID: 1800359 at lib/refcount.c:28 refcount_warn_saturate=
+0x9c/0xe0
> Workqueue: nfsiod nfs_direct_write_schedule_work [nfs]
> RIP: 0010:refcount_warn_saturate+0x9c/0xe0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __warn+0x9f/0x130
>  ? refcount_warn_saturate+0x9c/0xe0
>  ? report_bug+0xcc/0x150
>  ? handle_bug+0x3d/0x70
>  ? exc_invalid_op+0x16/0x40
>  ? asm_exc_invalid_op+0x16/0x20
>  ? refcount_warn_saturate+0x9c/0xe0
>  nfs_direct_write_schedule_work+0x237/0x250 [nfs]
>  process_one_work+0x12f/0x4a0
>  worker_thread+0x14e/0x3b0
>  ? ZSTD_getCParams_internal+0x220/0x220
>  kthread+0xdc/0x120
>  ? __btf_name_valid+0xa0/0xa0
>  ret_from_fork+0x1f/0x30
>=20
> This is because we're completing the nfs_direct_request twice in a row.
>=20
> The source of this is when we have our commit requests to submit, we
> process them and send them off, and then in the completion path for the
> commit requests we have
>=20
> if (nfs_commit_end(cinfo.mds))
> 	nfs_direct_write_complete(dreq);
>=20
> However since we're submitting asynchronous requests we sometimes have
> one that completes before we submit the next one, so we end up calling
> complete on the nfs_direct_request twice.
>=20
> The only other place we use nfs_generic_commit_list() is in
> __nfs_commit_inode, which wraps this call in a
>=20
> nfs_commit_begin();
> nfs_commit_end();
>=20
> Which is a common pattern for this style of completion handling, one
> that is also repeated in the direct code with get_dreq()/put_dreq()
> calls around where we process events as well as in the completion paths.
>=20
> Fix this by using the same pattern for the commit requests.
>=20
> Before with my 200 node rocksdb stress running this warning would pop
> every 10ish minutes.  With my patch the stress test has been running for
> several hours without popping.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/nfs/direct.c        | 11 +++++++++--
>  fs/nfs/write.c         |  2 +-
>  include/linux/nfs_fs.h |  1 +
>  3 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index befcc167e25f..6b8798d01e3a 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -672,10 +672,17 @@ static void nfs_direct_commit_schedule(struct nfs_d=
irect_req *dreq)
>  	LIST_HEAD(mds_list);
> =20
>  	nfs_init_cinfo_from_dreq(&cinfo, dreq);
> +	nfs_commit_begin(cinfo.mds);
>  	nfs_scan_commit(dreq->inode, &mds_list, &cinfo);
>  	res =3D nfs_generic_commit_list(dreq->inode, &mds_list, 0, &cinfo);
> -	if (res < 0) /* res =3D=3D -ENOMEM */
> -		nfs_direct_write_reschedule(dreq);
> +	if (res < 0) { /* res =3D=3D -ENOMEM */
> +		spin_lock(&dreq->lock);
> +		if (dreq->flags =3D=3D 0)
> +			dreq->flags =3D NFS_ODIRECT_RESCHED_WRITES;
> +		spin_unlock(&dreq->lock);
> +	}
> +	if (nfs_commit_end(cinfo.mds))
> +		nfs_direct_write_complete(dreq);


Before, it was calling nfs_direct_write_reschedule directly, but with
the above change it's now just setting NFS_ODIRECT_RESCHED_WRITES and
then queueing the completion workqueue job if it's the last reference
(which should then go and reschedule the job, I think).

That may be a reasonable change to make, but I think it merits some
justification and mention in the changelog. Was that change necessary
for some reason? If so, why?


>  }
> =20
>  static void nfs_direct_write_clear_reqs(struct nfs_direct_req *dreq)
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index bb79d3a886ae..5d9dc6c05325 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1650,7 +1650,7 @@ static int wait_on_commit(struct nfs_mds_commit_inf=
o *cinfo)
>  				       !atomic_read(&cinfo->rpcs_out));
>  }
> =20
> -static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
> +void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
>  {
>  	atomic_inc(&cinfo->rpcs_out);
>  }
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index f5ce7b101146..d59116ac8209 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -611,6 +611,7 @@ int nfs_wb_folio_cancel(struct inode *inode, struct f=
olio *folio);
>  extern int  nfs_commit_inode(struct inode *, int);
>  extern struct nfs_commit_data *nfs_commitdata_alloc(void);
>  extern void nfs_commit_free(struct nfs_commit_data *data);
> +void nfs_commit_begin(struct nfs_mds_commit_info *cinfo);
>  bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
> =20
>  static inline bool nfs_have_writebacks(const struct inode *inode)

--=20
Jeff Layton <jlayton@kernel.org>

