Return-Path: <linux-nfs+bounces-1540-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B7840505
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 13:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DFA280F42
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895E605A6;
	Mon, 29 Jan 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cILILR9m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AA605A4
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531355; cv=none; b=M4Ayl8MeLNVoMo+izoiGL98YiPUW2231HGlmLi09mmqa+g1W0UL/ZhYEhgNg/a8OMrZuuY5/T37QO91lwg9ZXXADB2B2ZvnVOk4U//qoAIQOaNE/kNQOWdAlWpguRa3fagOOs0uJmNq2E3G68bBBJ5dz5fCg+VN81r0QyAt9TrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531355; c=relaxed/simple;
	bh=YUz8TX+S6FtR1n7yveZCkL+tH1blj2zq8+HUEvpaPKs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kpqAOC8JDK3IsxO8yqk2yEVP+HokZxgXIH+6nYmt3ZfHzDfx0zsLMk/fqOaG6Aj3p308mnOGlC8Hg7htHYk8z9n/7/JcFoMqUNNPPdM8U8x4x2HWNILWelieOiNdBgm8ubQfVypKUKsJeyXt6tfqhTsub5YwEVx/OaQomg5jNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cILILR9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7D6C433F1;
	Mon, 29 Jan 2024 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706531354;
	bh=YUz8TX+S6FtR1n7yveZCkL+tH1blj2zq8+HUEvpaPKs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cILILR9ml6cRnLDOVUKIKzNaBeFwTqy6KRKdnt5DKlra29MnMfs4Ld+aRVnORuhqh
	 2wY+mAvKJuyWhsEDru2zD92I6xyRpBo/1K8eRiYUxkWyy30hL0BrPcMYuBB38P6Xb7
	 GPJHedpjvOCVeDbR/0C09gau6je3Zgxwne4pq+DZ7T/l6ajZIH2m3aKzJF+nQ0Ym80
	 oJCJ+fvpWQ7bznF1xuWrtHZa70k7lSfNTDvBqyw4jIuhU9J2SSevpSEVJYlvoRHw4k
	 CluQCC8tuqP6zllyMcblBcJWBujAAA8GwN4/pBnYZIIfgigL0b8HB/BE4mkD1IauJV
	 6RSrTlw9J/r1A==
Message-ID: <ff3f590a899ea13dd7392a46d5f551f1cae6a0ce.camel@kernel.org>
Subject: Re: [PATCH 09/13] nfsd: allow admin-revoked NFSv4.0 state to be
 freed.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Christoph Hellwig
 <hch@lst.de>,  Tom Haynes <loghyr@gmail.com>
Date: Mon, 29 Jan 2024 07:29:13 -0500
In-Reply-To: <20240129033637.2133-10-neilb@suse.de>
References: <20240129033637.2133-1-neilb@suse.de>
	 <20240129033637.2133-10-neilb@suse.de>
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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 14:29 +1100, NeilBrown wrote:
> For NFSv4.1 and later the client easily discovers if there is any
> admin-revoked state and will then find and explicitly free it.
>=20
> For NFSv4.0 there is no such mechanism.  The client can only find that
> state is admin-revoked if it tries to use that state, and there is no
> way for it to explicitly free the state.  So the server must hold on to
> the stateid (at least) for an indefinite amount of time.  A
> RELEASE_LOCKOWNER request might justify forgetting some of these
> stateids, as would the whole clients lease lapsing, but these are not
> reliable.
>=20
> This patch takes two approaches.
>=20
> Whenever a client uses an revoked stateid, that stateid is then
> discarded and will not be recognised again.  This might confuse a client
> which expect to get NFS4ERR_ADMIN_REVOKED consistently once it get it at
> all, but should mostly work.  Hopefully one error will lead to other
> resources being closed (e.g.  process exits), which will result in more
> stateid being freed when a CLOSE attempt gets NFS4ERR_ADMIN_REVOKED.
>=20
> Also, any admin-revoked stateids that have been that way for more than
> one lease time are periodically revoke.
>=20
> No actual freeing of state happens in this patch.  That will come in
> future patches which handle the different sorts of revoked state.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/netns.h     |  4 ++
>  fs/nfsd/nfs4state.c | 98 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 101 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 74b4360779a1..b35bdd5c10de 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -192,6 +192,10 @@ struct nfsd_net {
>  	atomic_t		nfsd_courtesy_clients;
>  	struct shrinker		*nfsd_client_shrinker;
>  	struct work_struct	nfsd_shrinker_work;
> +
> +	/* last time an admin-revoke happened for NFSv4.0 */
> +	time64_t		nfs40_last_revoke;
> +
>  };
> =20
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index e1492ca7c75c..900d295bd570 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1733,6 +1733,14 @@ void nfsd4_revoke_states(struct net *net, struct s=
uper_block *sb)
>  				}
>  				nfs4_put_stid(stid);
>  				spin_lock(&nn->client_lock);
> +				if (clp->cl_minorversion =3D=3D 0)
> +					/* Allow cleanup after a lease period.
> +					 * store_release ensures cleanup will
> +					 * see any newly revoked states if it
> +					 * sees the time updated.
> +					 */
> +					nn->nfs40_last_revoke =3D
> +						ktime_get_boottime_seconds();
>  				goto retry;
>  			}
>  		}
> @@ -4617,6 +4625,40 @@ nfsd4_find_existing_open(struct nfs4_file *fp, str=
uct nfsd4_open *open)
>  	return ret;
>  }
> =20
> +static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
> +	__releases(&s->sc_client->cl_lock)
> +{
> +	struct nfs4_client *cl =3D s->sc_client;
> +
> +	switch (s->sc_type) {
> +	default:
> +		spin_unlock(&cl->cl_lock);
> +	}
> +}
> +
> +static void nfsd40_drop_revoked_stid(struct nfs4_client *cl,
> +				    stateid_t *stid)
> +{
> +	/* NFSv4.0 has no way for the client to tell the server
> +	 * that it can forget an admin-revoked stateid.
> +	 * So we keep it around until the first time that the
> +	 * client uses it, and drop it the first time
> +	 * nfserr_admin_revoked is returned.
> +	 * For v4.1 and later we wait until explicitly told
> +	 * to free the stateid.
> +	 */
> +	if (cl->cl_minorversion =3D=3D 0) {
> +		struct nfs4_stid *st;
> +
> +		spin_lock(&cl->cl_lock);
> +		st =3D find_stateid_locked(cl, stid);
> +		if (st)
> +			nfsd4_drop_revoked_stid(st);
> +		else
> +			spin_unlock(&cl->cl_lock);
> +	}
> +}
> +
>  static __be32
>  nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
> @@ -4639,6 +4681,10 @@ nfsd4_lock_ol_stateid(struct nfs4_ol_stateid *stp)
> =20
>  	mutex_lock_nested(&stp->st_mutex, LOCK_STATEID_MUTEX);
>  	ret =3D nfsd4_verify_open_stid(&stp->st_stid);
> +	if (ret =3D=3D nfserr_admin_revoked)
> +		nfsd40_drop_revoked_stid(stp->st_stid.sc_client,
> +					&stp->st_stid.sc_stateid);
> +
>  	if (ret !=3D nfs_ok)
>  		mutex_unlock(&stp->st_mutex);
>  	return ret;
> @@ -5222,6 +5268,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfs=
d4_open *open,
>  	}
>  	if (deleg->dl_stid.sc_status & SC_STATUS_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
> +		nfsd40_drop_revoked_stid(cl, &open->op_delegate_stateid);
>  		status =3D nfserr_deleg_revoked;
>  		goto out;
>  	}
> @@ -6206,6 +6253,43 @@ nfs4_process_client_reaplist(struct list_head *rea=
plist)
>  	}
>  }
> =20
> +static void nfs40_clean_admin_revoked(struct nfsd_net *nn,
> +				      struct laundry_time *lt)
> +{
> +	struct nfs4_client *clp;
> +
> +	spin_lock(&nn->client_lock);
> +	if (nn->nfs40_last_revoke =3D=3D 0 ||
> +	    nn->nfs40_last_revoke > lt->cutoff) {
> +		spin_unlock(&nn->client_lock);
> +		return;
> +	}
> +	nn->nfs40_last_revoke =3D 0;
> +
> +retry:
> +	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> +		unsigned long id, tmp;
> +		struct nfs4_stid *stid;
> +
> +		if (atomic_read(&clp->cl_admin_revoked) =3D=3D 0)
> +			continue;
> +
> +		spin_lock(&clp->cl_lock);
> +		idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> +			if (stid->sc_status & SC_STATUS_ADMIN_REVOKED) {
> +				refcount_inc(&stid->sc_count);
> +				spin_unlock(&nn->client_lock);
> +				/* this function drops ->cl_lock */
> +				nfsd4_drop_revoked_stid(stid);
> +				nfs4_put_stid(stid);
> +				spin_lock(&nn->client_lock);
> +				goto retry;
> +			}
> +		spin_unlock(&clp->cl_lock);
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> +
>  static time64_t
>  nfs4_laundromat(struct nfsd_net *nn)
>  {
> @@ -6239,6 +6323,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>  	nfs4_process_client_reaplist(&reaplist);
> =20
> +	nfs40_clean_admin_revoked(nn, &lt);
> +
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> @@ -6457,6 +6543,9 @@ static __be32 nfsd4_stid_check_stateid_generation(s=
tateid_t *in, struct nfs4_sti
>  	if (ret =3D=3D nfs_ok)
>  		ret =3D check_stateid_generation(in, &s->sc_stateid, has_session);
>  	spin_unlock(&s->sc_lock);
> +	if (ret =3D=3D nfserr_admin_revoked)
> +		nfsd40_drop_revoked_stid(s->sc_client,
> +					&s->sc_stateid);
>  	return ret;
>  }
> =20
> @@ -6501,6 +6590,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_cl=
ient *cl, stateid_t *stateid)
>  	}
>  out_unlock:
>  	spin_unlock(&cl->cl_lock);
> +	if (status =3D=3D nfserr_admin_revoked)
> +		nfsd40_drop_revoked_stid(cl, stateid);
>  	return status;
>  }
> =20
> @@ -6547,6 +6638,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *c=
state,
>  		return nfserr_deleg_revoked;
>  	}
>  	if (stid->sc_status & SC_STATUS_ADMIN_REVOKED) {
> +		nfsd40_drop_revoked_stid(cstate->clp, stateid);
>  		nfs4_put_stid(stid);
>  		return nfserr_admin_revoked;
>  	}
> @@ -6839,6 +6931,11 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
>  	s =3D find_stateid_locked(cl, stateid);
>  	if (!s || s->sc_status & SC_STATUS_CLOSED)
>  		goto out_unlock;
> +	if (s->sc_status & SC_STATUS_ADMIN_REVOKED) {
> +		nfsd4_drop_revoked_stid(s);
> +		ret =3D nfs_ok;
> +		goto out;
> +	}
>  	spin_lock(&s->sc_lock);
>  	switch (s->sc_type) {
>  	case SC_TYPE_DELEG:
> @@ -6865,7 +6962,6 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
>  		spin_unlock(&cl->cl_lock);
>  		ret =3D nfsd4_free_lock_stateid(stateid, s);
>  		goto out;
> -	/* Default falls through and returns nfserr_bad_stateid */
>  	}
>  	spin_unlock(&s->sc_lock);
>  out_unlock:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

