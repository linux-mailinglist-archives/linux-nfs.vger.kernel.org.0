Return-Path: <linux-nfs+bounces-2407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9F2880654
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 21:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FA2B20D88
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 20:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7F23BBEB;
	Tue, 19 Mar 2024 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvUJqSr4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D63BBC7
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881742; cv=none; b=n4nZdqIJ/04zvwoX7rAhX2w2bIeyO5LpiXvxypUiZyEMLQchG+JCruPQQo+Go59OXDjUHjgp/OwvdUNtUYrp5mKdtgqHDIygpRddRMlUnFxAPfMprxGivuQ9qzszKYtMwRA0pMGIeblnQj1aQ+wZcFRN+MeXiGxw9CZHzO5k0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881742; c=relaxed/simple;
	bh=jOAcMyypYkfSD5EjqfAys3gFibyFBWWLwzBixqt91ks=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=euz9JQWWA6YJsC+tBFyeetYl/imd6yr/1oIPtDirt2CxF+s1nKQGtTJffy30LbZTn2SYe9o6wG2YVYWeDQYd+JVh873AGvWyG0EMIbnP9V5SmhOhN2fCkvvPwXaCwRiJFdMcUGF6PdKTHSk/oXvvrH1k6NiVoTzrWhdDtQ0oci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvUJqSr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5F3C433F1;
	Tue, 19 Mar 2024 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710881742;
	bh=jOAcMyypYkfSD5EjqfAys3gFibyFBWWLwzBixqt91ks=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=VvUJqSr4yKs5of868ENaCIQT3DU1VDhoRbjns/lUjJrmhcBxWRAw2oJKL5972T/Di
	 tRs9xOIDMfxjMbiLaVxlg/8p5y2R+ZLm6GuQfc7+V8XzZS61kGEaAznkY5AxEOaA6A
	 Rs1Tp0Qducp3U8WoLwFd6NSz3byiES+L6ljz097m2RECEwuCdyjaeEcZP62yIoANe4
	 0eJkbBTH3vB9sAxm4kNfDrqPOQUYpQO06Hws/bj1G/ROgKbEcRU+dliG9ekFsuMxf6
	 sL1F+BCUeM3tjTi8x6xy9UUdymQHUW9OduoSavPhC5GG/oCd9V6Ntt+waehiaZJ9VF
	 pkFzTepbeZy7g==
Message-ID: <a713a50b2f8d913d4829d45ac4462869bce06bc7.camel@kernel.org>
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
From: Jeff Layton <jlayton@kernel.org>
To: Rik Theys <Rik.Theys@esat.kuleuven.be>, Dai Ngo <dai.ngo@oracle.com>, 
	Linux Nfs <linux-nfs@vger.kernel.org>
Date: Tue, 19 Mar 2024 16:55:40 -0400
In-Reply-To: <d90551d6-a48f-4c25-a2f0-8dbd2b5e5830@esat.kuleuven.be>
References: <66c98f4c-5e52-4fa3-8a2c-9379cfec2a9a@esat.kuleuven.be>
	 <44c2101e756f7c3b876fb9c58da3ebd089dc14d5.camel@kernel.org>
	 <e3ba6e04-ea06-4035-8546-639f11d6b79c@esat.kuleuven.be>
	 <41325088-aa6d-4dcf-b105-8994350168c3@esat.kuleuven.be>
	 <7d244882d769e377b06f39234bd5ee7dddb72a55.camel@kernel.org>
	 <c7dbc796-7e7d-4041-ac71-eea02a701b12@esat.kuleuven.be>
	 <50dd9475-b485-4b9b-bcbd-5f7dfabfbac5@oracle.com>
	 <d90551d6-a48f-4c25-a2f0-8dbd2b5e5830@esat.kuleuven.be>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxwn8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1WvegyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqVT2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtVYrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8snVluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQcDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQfCBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sELZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/
	r0kmR/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2BrQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRIONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZWf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQOlDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7RjiR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27XiQQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBMYXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9qLqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoac8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3FLpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx
	3bri75n1TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y+jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5dHxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBMBAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4hN9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPepnaQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQRERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8EewP8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0XzhaKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyA
	nLqRgDgR+wTQT6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7hdMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjruymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItuAXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfDFOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbosZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDvqrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51asjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qGIcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbLUO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0
	b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSUapy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5ddhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7eflPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7BAKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuac
	BOTtmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65ke5Ag0ETpXRPAEQAJkVmzCmF+IEenf9a2nZRXMluJohnfl2wCMmw5qNzyk0f+mYuTwTCpw7BE2H0yXk4ZfAuA+xdj14K0A1Dj52j/fKRuDqoNAhQe0b6ipo85Sz98G+XnmQOMeFVp5G1Z7r/QP/nus3mXvtFsu9lLSjMA0cam2NLDt7vx3l9kUYlQBhyIE7/DkKg+3fdqRg7qJoMHNcODtQY+n3hMyaVpplJ/l0DdQDbRSZi5AzDM3DWZEShhuP6/E2LN4O3xWnZukEiz688d1ppl7vBZO9wBql6Ft9Og74diZrTN6lXGGjEWRvO55h6ijMsLCLNDRAVehPhZvSlPldtUuvhZLAjdWpwmzbRIwgoQcO51aWeKthpcpj8feDdKdlVjvJO9fgFD5kqZ
	QiErRVPpB7VzA/pYV5Mdy7GMbPjmO0IpoL0tVZ8JvUzUZXB3ErS/dJflvboAAQeLpLCkQjqZiQ/DCmgJCrBJst9Xc7YsKKS379Tc3GU33HNSpaOxs2NwfzoesyjKU+P35czvXWTtj7KVVSj3SgzzFk+gLx8y2Nvt9iESdZ1Ustv8tipDsGcvIZ43MQwqU9YbLg8k4V9ch+Mo8SE+C0jyZYDCE2ZGf3OztvtSYMsTnF6/luzVyej1AFVYjKHORzNoTwdHUeC+9/07GO0bMYTPXYvJ/vxBFm3oniXyhgb5FtABEBAAGJAh8EGAECAAkFAk6V0TwCGwwACgkQAA5oQRlWghXhZRAAyycZ2DDyXh2bMYvI8uHgCbeXfL3QCvcw2XoZTH2l2umPiTzrCsDJhgwZfG9BDyOHaYhPasd5qgrUBtjjUiNKjVM+Cx1DnieR0dZWafnqGv682avPblfi70XXr2juRE/fSZoZkyZhm+nsLuIcXTnzY4D572JGrpRMTpNpGmitBdh1l/9O7Fb64uLOtA5Qj5jcHHOjL0DZpjmFWYKlSAHmURHrE8M0qRryQXvlhoQxlJR4nvQrjOPMsqWD5F9mcRyowOzr8amasLv43w92rD2nHoBK6rbFE/qC7AAjABEsZq8+TQmueN0maIXUQu7TBzejsEbV0i29z+kkrjU2NmK5pcxgAtehVxpZJ14LqmN6E0suTtzjNT1eMoqOPrMSx+6vOCIuvJ/MVYnQgHhjtPPnU86mebTY5Loy9YfJAC2EVpxtcCbx2KiwErTndEyWL+GL53LuScUD7tW8vYbGIp4RlnUgPLbqpgssq2gwYO9m75FGuKuB2+2bCGajqalid5nzeq9v7cYLLRgArJfOIBWZrHy2m0C+pFu9DSuV6SNr2dvMQUv1V58h0FaSOxHVQnJdnoHn13g/CKKvyg2EMrMt/EfcXgvDwQbnG9we4xJiWOIOcsvrWcB6C6lWBDA+In7w7SXnnok
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-19 at 20:41 +0100, Rik Theys wrote:
> Hi,
>=20
> On 3/19/24 18:09, Dai Ngo wrote:
> >=20
> > On 3/19/24 12:58 AM, Rik Theys wrote:
> > > Hi,
> > >=20
> > > On 3/18/24 22:54, Jeff Layton wrote:
> > > > On Mon, 2024-03-18 at 22:15 +0100, Rik Theys wrote:
> > > > > Hi,
> > > > >=20
> > > > > On 3/18/24 21:21, Rik Theys wrote:
> > > > > > Hi Jeff,
> > > > > >=20
> > > > > > On 3/12/24 13:47, Jeff Layton wrote:
> > > > > > > On Tue, 2024-03-12 at 13:24 +0100, Rik Theys wrote:
> > > > > > > > Hi Jeff,
> > > > > > > >=20
> > > > > > > > On 3/12/24 12:22, Jeff Layton wrote:
> > > > > > > > > On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
> > > > > > > > > > Since a few weeks our Rocky Linux 9 NFS server has peri=
odically
> > > > > > > > > > logged hung nfsd tasks. The initial effect was that som=
e clients
> > > > > > > > > > could no longer access the NFS server. This got worse a=
nd worse
> > > > > > > > > > (probably as more nfsd threads got blocked) and we had =
to restart
> > > > > > > > > > the server. Restarting the server also failed as the NF=
S server
> > > > > > > > > > service could no longer be stopped.
> > > > > > > > > >=20
> > > > > > > > > > The initial kernel we noticed this behavior on was
> > > > > > > > > > kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've i=
nstalled
> > > > > > > > > > kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The =
same issue
> > > > > > > > > > happened again on this newer kernel version:
> > > > > > > 419 is fairly up to date with nfsd changes. There are some kn=
own=20
> > > > > > > bugs
> > > > > > > around callbacks, and there is a draft MR in flight to fix it=
.
> > > > > > >=20
> > > > > > > What kernel were you on prior to 5.14.0-362.18.1.el9_3.x86_64=
 ?=20
> > > > > > > If we
> > > > > > > can bracket the changes around a particular version, then tha=
t might
> > > > > > > help identify the problem.
> > > > > > >=20
> > > > > > > > > > [Mon Mar 11 14:10:08 2024] =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0Not tainted=20
> > > > > > > > > > 5.14.0-419.el9.x86_64 #1
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] "echo 0 >
> > > > > > > > > > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]task:nfsd =
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state:D=
=20
> > > > > > > > > > stack:0
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pid:8865 =C2=A0ppid:2 =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0flags:0x00004000
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] Call Trac=
e:
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0<TA=
SK>
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__s=
chedule+0x21b/0x550
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0sch=
edule+0x2d/0x70
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0sch=
edule_timeout+0x11f/0x160
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? s=
elect_idle_sibling+0x28/0x430
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? w=
ake_affine+0x62/0x1f0
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__w=
ait_for_common+0x90/0x1d0
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0?=
=20
> > > > > > > > > > __pfx_schedule_timeout+0x10/0x10
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__f=
lush_workqueue+0x13a/0x3f0
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]=20
> > > > > > > > > > =C2=A0nfsd4_shutdown_callback+0x49/0x120
> > > > > > > > > > [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? n=
fsd4_cld_remove+0x54/0x1d0=20
> > > > > > > > > > [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0?
> > > > > > > > > > nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0?=
=20
> > > > > > > > > > nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__d=
estroy_client+0x1f3/0x290=20
> > > > > > > > > > [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfs=
d4_exchange_id+0x75f/0x770=20
> > > > > > > > > > [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0?=
=20
> > > > > > > > > > nfsd4_decode_opaque+0x3a/0x90 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]=20
> > > > > > > > > > =C2=A0nfsd4_proc_compound+0x44b/0x700 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfs=
d_dispatch+0x94/0x1c0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0svc=
_process_common+0x2ec/0x660
> > > > > > > > > > [sunrpc]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0?=
=20
> > > > > > > > > > __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? _=
_pfx_nfsd+0x10/0x10 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0svc=
_process+0x12d/0x170 [sunrpc]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfs=
d+0x84/0xb0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0kth=
read+0xdd/0x100
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? _=
_pfx_kthread+0x10/0x10
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0ret=
_from_fork+0x29/0x50
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0</T=
ASK>
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] INFO: tas=
k nfsd:8866 blocked for
> > > > > > > > > > more than 122 seconds.
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Not tainted
> > > > > > > > > > 5.14.0-419.el9.x86_64 #1
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] "echo 0 >
> > > > > > > > > > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]task:nfsd =
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state:D=
=20
> > > > > > > > > > stack:0
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pid:8866 =C2=A0ppid:2 =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0flags:0x00004000
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] Call Trac=
e:
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0<TA=
SK>
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__s=
chedule+0x21b/0x550
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0sch=
edule+0x2d/0x70
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0sch=
edule_timeout+0x11f/0x160
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? s=
elect_idle_sibling+0x28/0x430
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? t=
cp_recvmsg+0x196/0x210
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? w=
ake_affine+0x62/0x1f0
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__w=
ait_for_common+0x90/0x1d0
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0?=
=20
> > > > > > > > > > __pfx_schedule_timeout+0x10/0x10
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0__f=
lush_workqueue+0x13a/0x3f0
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfs=
d4_destroy_session+0x1a4/0x240
> > > > > > > > > > [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024]=20
> > > > > > > > > > =C2=A0nfsd4_proc_compound+0x44b/0x700 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfs=
d_dispatch+0x94/0x1c0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0svc=
_process_common+0x2ec/0x660
> > > > > > > > > > [sunrpc]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0?=
=20
> > > > > > > > > > __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? _=
_pfx_nfsd+0x10/0x10 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0svc=
_process+0x12d/0x170 [sunrpc]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0nfs=
d+0x84/0xb0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0kth=
read+0xdd/0x100
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0? _=
_pfx_kthread+0x10/0x10
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0ret=
_from_fork+0x29/0x50
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:10:08 2024] =C2=A0</T=
ASK>
> > > > > > > > > >=20
> > > > > > > > > The above threads are trying to flush the workqueue, so t=
hat=20
> > > > > > > > > probably
> > > > > > > > > means that they are stuck waiting on a workqueue job to f=
inish.
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0The above is repeated a few times, a=
nd then this warning is
> > > > > > > > > > also logged:
> > > > > > > > > > =C2=A0=C2=A0=C2=A0 [Mon Mar 11 14:12:04 2024] ---------=
---[ cut here=20
> > > > > > > > > > ]------------
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:04 2024] WARNING: =
CPU: 39 PID: 8844 at
> > > > > > > > > > fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x19=
0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Modules l=
inked in: nfsv4
> > > > > > > > > > dns_resolver nfs fscache netfs rpcsec_gss_krb5 rpcrdma =
rdma_cm
> > > > > > > > > > iw_cm ib_cm ib_core binfmt_misc bonding tls rfkill nft_=
counter=20
> > > > > > > > > > nft_ct
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0nf_conntrack nf_defrag_ipv6 nf_defra=
g_ipv4 nft_reject_inet
> > > > > > > > > > nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfne=
tlink vfat
> > > > > > > > > > fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bu=
fio l
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0ibcrc32c dm_service_time dm_multipat=
h intel_rapl_msr
> > > > > > > > > > intel_rapl_common intel_uncore_frequency
> > > > > > > > > > intel_uncore_frequency_common isst_if_common skx_edac n=
fit
> > > > > > > > > > libnvdimm ipmi_ssif x86_pkg_temp
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0_thermal intel_powerclamp coretemp k=
vm_intel kvm irqbypass
> > > > > > > > > > dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_shmem=
_helper
> > > > > > > > > > dell_smbios drm_kms_helper dell_wmi_descriptor wmi_bmof=
 intel_u
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0ncore syscopyarea pcspkr sysfillrect=
 mei_me sysimgblt=20
> > > > > > > > > > acpi_ipmi
> > > > > > > > > > mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_=
ich
> > > > > > > > > > ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_powe=
r_meter
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0nfsd auth_rpcgss nfs_acl drm lockd g=
race fuse sunrpc ext4
> > > > > > > > > > mbcache jbd2 sd_mod sg lpfc
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nvm=
et_fc nvmet nvme_fc=20
> > > > > > > > > > nvme_fabrics
> > > > > > > > > > crct10dif_pclmul ahci libahci crc32_pclmul nvme_core cr=
c32c_intel
> > > > > > > > > > ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0el t10_pi wdat_wdt scsi_transport_fc=
 mdio wmi dca dm_mirror
> > > > > > > > > > dm_region_hash dm_log dm_mod
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] CPU: 39 P=
ID: 8844 Comm: nfsd Not
> > > > > > > > > > tainted 5.14.0-419.el9.x86_64 #1
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Hardware =
name: Dell Inc. PowerEdge
> > > > > > > > > > R740/00WGD1, BIOS 2.20.1 09/13/2023
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RIP:
> > > > > > > > > > 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Code: a6 =
95 c5 f3 e9 ff fe ff=20
> > > > > > > > > > ff 48
> > > > > > > > > > 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 0=
0 e8 c8 f9
> > > > > > > > > > 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
> > > > > > > > > > =C2=A0=C2=A0 =C2=A002 00 00 00 48 89 df e8 0c b5 13 f4 =
e9 01
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RSP: 0018=
:ffff9929e0bb7b80 EFLAGS:
> > > > > > > > > > 00010246
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RAX: 0000=
000000000000 RBX:
> > > > > > > > > > ffff8ada51930900 RCX: 0000000000000024
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RDX: ffff=
8ada519309c8 RSI:
> > > > > > > > > > ffff8ad582933c00 RDI: 0000000000002000
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] RBP: ffff=
8ad46bf21574 R08:
> > > > > > > > > > ffff9929e0bb7b48 R09: 0000000000000000
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] R10: ffff=
8aec859a2948 R11:
> > > > > > > > > > 0000000000000000 R12: ffff8ad6f497c360
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] R13: ffff=
8ad46bf21560 R14:
> > > > > > > > > > ffff8ae5942e0b10 R15: ffff8ad6f497c360
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] FS: =C2=
=A00000000000000000(0000)
> > > > > > > > > > GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] CS: =C2=
=A00010 DS: 0000 ES: 0000 CR0:
> > > > > > > > > > 0000000080050033
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] CR2: 0000=
7fafe2060744 CR3:
> > > > > > > > > > 00000018e58de006 CR4: 00000000007706e0
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] DR0: 0000=
000000000000 DR1:
> > > > > > > > > > 0000000000000000 DR2: 0000000000000000
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] DR3: 0000=
000000000000 DR6:
> > > > > > > > > > 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] PKRU: 555=
55554
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] Call Trac=
e:
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0<TA=
SK>
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? s=
how_trace_log_lvl+0x1c4/0x2df
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? s=
how_trace_log_lvl+0x1c4/0x2df
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? _=
_break_lease+0x16f/0x5f0
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? n=
fsd_break_deleg_cb+0x170/0x190
> > > > > > > > > > [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? _=
_warn+0x81/0x110
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? n=
fsd_break_deleg_cb+0x170/0x190
> > > > > > > > > > [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? r=
eport_bug+0x10a/0x140
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? h=
andle_bug+0x3c/0x70
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? e=
xc_invalid_op+0x14/0x70
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? a=
sm_exc_invalid_op+0x16/0x20
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? n=
fsd_break_deleg_cb+0x170/0x190
> > > > > > > > > > [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0__b=
reak_lease+0x16f/0x5f0
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0?
> > > > > > > > > > nfsd_file_lookup_locked+0x117/0x160 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? l=
ist_lru_del+0x101/0x150
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfs=
d_file_do_acquire+0x790/0x830
> > > > > > > > > > [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfs=
4_get_vfs_file+0x315/0x3a0=20
> > > > > > > > > > [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024]=20
> > > > > > > > > > =C2=A0nfsd4_process_open2+0x430/0xa30 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? f=
h_verify+0x297/0x2f0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfs=
d4_open+0x3ce/0x4b0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024]=20
> > > > > > > > > > =C2=A0nfsd4_proc_compound+0x44b/0x700 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfs=
d_dispatch+0x94/0x1c0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0svc=
_process_common+0x2ec/0x660
> > > > > > > > > > [sunrpc]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0?=
=20
> > > > > > > > > > __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? _=
_pfx_nfsd+0x10/0x10 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0svc=
_process+0x12d/0x170 [sunrpc]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0nfs=
d+0x84/0xb0 [nfsd]
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0kth=
read+0xdd/0x100
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0? _=
_pfx_kthread+0x10/0x10
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0ret=
_from_fork+0x29/0x50
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] =C2=A0</T=
ASK>
> > > > > > > > > > =C2=A0=C2=A0 =C2=A0[Mon Mar 11 14:12:05 2024] ---[ end =
trace 7a039e17443dc651=20
> > > > > > > > > > ]---
> > > > > > > > > This is probably this WARN in nfsd_break_one_deleg:
> > > > > > > > >=20
> > > > > > > > > WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
> > > > > > > > >=20
> > > > > > > > > It means that a delegation break callback to the client=
=20
> > > > > > > > > couldn't be
> > > > > > > > > queued to the workqueue, and so it didn't run.
> > > > > > > > >=20
> > > > > > > > > > Could this be the same issue as described
> > > > > > > > > > here:https://urldefense.com/v3/__https://lore.kernel.or=
g/linux-nfs/af0ec881-5ebf-4feb-98ae-3ed2a77f86f1@oracle.com/__;!!ACWV5N9M2R=
V99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56=
CMpDWhkjjwSkdBV9En7$=20
> > > > > > > > > > ?
> > > > > > > > > Yes, most likely the same problem.
> > > > > > > > If I read that thread correctly, this issue was introduced =
between
> > > > > > > > 6.1.63 and 6.6.3? Is it possible the EL9 5.14.0-362.18.1.el=
9_3
> > > > > > > > backported these changes, or were we hitting some other bug=
 with=20
> > > > > > > > that
> > > > > > > > version? It seems the 6.1.x kernel is not affected? If so, =
that
> > > > > > > > would be
> > > > > > > > the recommended kernel to run?
> > > > > > > Anything is possible. We have to identify the problem first.
> > > > > > > > > > As described in that thread, I've tried to obtain the r=
equested
> > > > > > > > > > information.
> > > > > > > > > >=20
> > > > > > > > > > Is it possible this is the issue that was fixed by the =
patches
> > > > > > > > > > described
> > > > > > > > > > here?https://urldefense.com/v3/__https://lore.kernel.or=
g/linux-nfs/2024022054-cause-suffering-eae8@gregkh/__;!!ACWV5N9M2RV99hQ!LV3=
yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjj=
wSkedtUP09$=20
> > > > > > > > > >=20
> > > > > > > > > Doubtful. Those are targeted toward a different set of is=
sues.
> > > > > > > > >=20
> > > > > > > > > If you're willing, I do have some patches queued up for C=
entOS=20
> > > > > > > > > here
> > > > > > > > > that
> > > > > > > > > fix some backchannel problems that could be related. I'm =
mainly
> > > > > > > > > waiting
> > > > > > > > > on Chuck to send these to Linus and then we'll likely mer=
ge=20
> > > > > > > > > them into
> > > > > > > > > CentOS soon afterward:
> > > > > > > > >=20
> > > > > > > > > https://urldefense.com/v3/__https://gitlab.com/redhat/cen=
tos-stream/src/kernel/centos-stream-9/-/merge_requests/3689__;!!ACWV5N9M2RV=
99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56C=
MpDWhkjjwSkdvDn8y7$=20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > If you can send me a patch file, I can rebuild the C9S kern=
el=20
> > > > > > > > with that
> > > > > > > > patch and run it. It can take a while for the bug to trigge=
r as I
> > > > > > > > believe it seems to be very workload dependent (we were run=
ning=20
> > > > > > > > very
> > > > > > > > stable for months and now hit this bug every other week).
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > It's probably simpler to just pull down the build artifacts f=
or=20
> > > > > > > that MR.
> > > > > > > You have to drill down through the CI for it, but they are he=
re:
> > > > > > >=20
> > > > > > > https://urldefense.com/v3/__https://s3.amazonaws.com/arr-cki-=
prod-trusted-artifacts/index.html?prefix=3Dtrusted-artifacts*1194300175*pub=
lish_x86_64*6278921877*artifacts*__;Ly8vLy8!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkR=
HkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkaP5eW8V$=
=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > There's even a repo file you can install on the box to pull t=
hem=20
> > > > > > > down.
> > > > > > We installed this kernel on the server 3 days ago. Today, a use=
r
> > > > > > informed us that their screen was black after logging in. Simil=
ar to
> > > > > > other occurrences of this issue, the mount command on the clien=
t was
> > > > > > hung. But in contrast to the other times, there were no message=
s in
> > > > > > the logs kernel logs on the server. Even restarting the client =
does
> > > > > > not resolve the issue.
> > > >=20
> > > > Ok, so you rebooted the client and it's still unable to mount? That
> > > > sounds like a server problem if so.
> > > >=20
> > > > Are both client and server running the same kernel?
> > > No, the server runs 5.14.0-427.3689_1194299994.el9 and the client=20
> > > 5.14.0-362.18.1.el9_3.
> > > >=20
> > > > > > Something still seems to be wrong on the server though. When I=
=20
> > > > > > look at
> > > > > > the directories under /proc/fs/nfsd/clients, there's still a=
=20
> > > > > > directory
> > > > > > for the specific client, even though it's no longer running:
> > > > > >=20
> > > > > > # cat 155/info
> > > > > > clientid: 0xc8edb7f65f4a9ad
> > > > > > address: "10.87.31.152:819"
> > > > > > status: confirmed
> > > > > > seconds from last renew: 33163
> > > > > > name: "Linux NFSv4.2 bersalis.esat.kuleuven.be"
> > > > > > minor version: 2
> > > > > > Implementation domain: "kernel.org"
> > > > > > Implementation name: "Linux 5.14.0-362.18.1.el9_3.0.1.x86_64 #1=
 SMP
> > > > > > PREEMPT_DYNAMIC Sun Feb 11 13:49:23 UTC 2024 x86_64"
> > > > > > Implementation time: [0, 0]
> > > > > > callback state: DOWN
> > > > > > callback address: 10.87.31.152:0
> > > > > >=20
> > > > If you just shut down the client, the server won't immediately purg=
e=20
> > > > its
> > > > record. In fact, assuming you're running the same kernel on the ser=
ver,
> > > > it won't purge the client record until there is a conflicting reque=
st
> > > > for its state.
> > > Is there a way to force such a conflicting request (to get the client=
=20
> > > record to purge)?
> >=20
> > Try:
> >=20
> > # echo "expire" > /proc/fs/nfsd/clients/155/ctl
>=20
> I've tried that. The command hangs and can not be interrupted with ctrl-c=
.
>=20

I'd wager that's the wait_event() in force_expire_client. It seems like
that sleep should be killable.

> I've now also noticed in the dmesg output that the kernel issued the=20
> following WARNING a few hours ago. It wasn't directly triggered by the=
=20
> echo command above, but seems to have been triggered a few hours ago=20
> (probably when another client started to have the same problem as more=
=20
> clients are experiencing issues now).
>=20
> [Tue Mar 19 14:53:44 2024] ------------[ cut here ]------------
> [Tue Mar 19 14:53:44 2024] WARNING: CPU: 44 PID: 5843 at=20
> fs/nfsd/nfs4state.c:4920 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> [Tue Mar 19 14:53:44 2024] Modules linked in: nf_conntrack_netlink nfsv4=
=20
> dns_resolver nfs fscache netfs binfmt_misc xsk_diag rpcsec_gss_krb5=20
> rpcrdma rdma_cm iw_cm ib_cm ib_core bonding tls rfkill nft_counter=20
> nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet=20
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat fat=20
> dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio libcrc32c=20
> dm_service_time dm_multipath intel_rapl_msr intel_rapl_common=20
> intel_uncore_frequency intel_uncore_frequency_common isst_if_common=20
> skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp=
=20
> kvm_intel kvm dcdbas irqbypass ipmi_ssif rapl intel_cstate mgag200=20
> i2c_algo_bit drm_shmem_helper drm_kms_helper dell_smbios syscopyarea=20
> intel_uncore sysfillrect wmi_bmof dell_wmi_descriptor pcspkr sysimgblt=
=20
> fb_sys_fops mei_me i2c_i801 mei intel_pch_thermal acpi_ipmi i2c_smbus=20
> lpc_ich ipmi_si ipmi_devintf ipmi_msghandler joydev acpi_power_meter=20
> nfsd nfs_acl lockd auth_rpcgss grace drm fuse sunrpc ext4
> [Tue Mar 19 14:53:44 2024]=C2=A0 mbcache jbd2 sd_mod sg lpfc nvmet_fc nvm=
et=20
> nvme_fc nvme_fabrics crct10dif_pclmul crc32_pclmul nvme_core ixgbe=20
> crc32c_intel ahci libahci nvme_common megaraid_sas t10_pi=20
> ghash_clmulni_intel wdat_wdt libata scsi_transport_fc mdio dca wmi=20
> dm_mirror dm_region_hash dm_log dm_mod
> [Tue Mar 19 14:53:44 2024] CPU: 44 PID: 5843 Comm: nfsd Not tainted=20
> 5.14.0-427.3689_1194299994.el9.x86_64 #1
> [Tue Mar 19 14:53:44 2024] Hardware name: Dell Inc. PowerEdge=20
> R740/00WGD1, BIOS 2.20.1 09/13/2023
> [Tue Mar 19 14:53:44 2024] RIP: 0010:nfsd_break_deleg_cb+0x170/0x190 [nfs=
d]
> [Tue Mar 19 14:53:44 2024] Code: 76 76 cd de e9 ff fe ff ff 48 89 df be=
=20
> 01 00 00 00 e8 34 a1 1b df 48 8d bb 98 00 00 00 e8 a8 fe 00 00 84 c0 0f=
=20
> 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be 02 00 00 00 48 89 df e8 0c a1=
=20
> 1b df e9 01
> [Tue Mar 19 14:53:44 2024] RSP: 0018:ffffb2878f2cfc38 EFLAGS: 00010246
> [Tue Mar 19 14:53:44 2024] RAX: 0000000000000000 RBX: ffff88d5171067b8=
=20
> RCX: 0000000000000000
> [Tue Mar 19 14:53:44 2024] RDX: ffff88d517106880 RSI: ffff88bdceec8600=
=20
> RDI: 0000000000002000
> [Tue Mar 19 14:53:44 2024] RBP: ffff88d68a38a284 R08: ffffb2878f2cfc00=
=20
> R09: 0000000000000000
> [Tue Mar 19 14:53:44 2024] R10: ffff88bf57dd7878 R11: 0000000000000000=
=20
> R12: ffff88d5b79c4798
> [Tue Mar 19 14:53:44 2024] R13: ffff88d68a38a270 R14: ffff88cab06ad0c8=
=20
> R15: ffff88d5b79c4798
> [Tue Mar 19 14:53:44 2024] FS:=C2=A0 0000000000000000(0000)=20
> GS:ffff88d4a1180000(0000) knlGS:0000000000000000
> [Tue Mar 19 14:53:44 2024] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> [Tue Mar 19 14:53:44 2024] CR2: 00007fe46ef90000 CR3: 000000019d010004=
=20
> CR4: 00000000007706e0
> [Tue Mar 19 14:53:44 2024] DR0: 0000000000000000 DR1: 0000000000000000=
=20
> DR2: 0000000000000000
> [Tue Mar 19 14:53:44 2024] DR3: 0000000000000000 DR6: 00000000fffe0ff0=
=20
> DR7: 0000000000000400
> [Tue Mar 19 14:53:44 2024] PKRU: 55555554
> [Tue Mar 19 14:53:44 2024] Call Trace:
> [Tue Mar 19 14:53:44 2024]=C2=A0 <TASK>
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? show_trace_log_lvl+0x1c4/0x2df
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? show_trace_log_lvl+0x1c4/0x2df
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? __break_lease+0x16f/0x5f0
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? __warn+0x81/0x110
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? report_bug+0x10a/0x140
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? handle_bug+0x3c/0x70
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? exc_invalid_op+0x14/0x70
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? asm_exc_invalid_op+0x16/0x20
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? nfsd_break_deleg_cb+0x96/0x190 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 __break_lease+0x16f/0x5f0
> [Tue Mar 19 14:53:44 2024]=C2=A0 nfs4_get_vfs_file+0x164/0x3a0 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 nfsd4_process_open2+0x430/0xa30 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? fh_verify+0x297/0x2f0 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 nfsd4_open+0x3ce/0x4b0 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 nfsd4_proc_compound+0x44b/0x700 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 nfsd_dispatch+0x94/0x1c0 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 svc_process_common+0x2ec/0x660 [sunrpc]
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? __pfx_nfsd+0x10/0x10 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 svc_process+0x12d/0x170 [sunrpc]
> [Tue Mar 19 14:53:44 2024]=C2=A0 nfsd+0x84/0xb0 [nfsd]
> [Tue Mar 19 14:53:44 2024]=C2=A0 kthread+0xdd/0x100
> [Tue Mar 19 14:53:44 2024]=C2=A0 ? __pfx_kthread+0x10/0x10
> [Tue Mar 19 14:53:44 2024]=C2=A0 ret_from_fork+0x29/0x50
> [Tue Mar 19 14:53:44 2024]=C2=A0 </TASK>
> [Tue Mar 19 14:53:44 2024] ---[ end trace ed0b2b3f135c637d ]---
>=20
> It again seems to have been triggered in nfsd_break_deleg_cb?
>=20

Same problem as before. It tried to submit the workqueue job, but it was
already queued, so the submission failed.

> I also had the following perf command running a tmux on the server:
>=20
> perf trace -e nfsd:nfsd_cb_recall_any
>=20
> This has spewed a lot of messages. I'm including a short list here:
>=20
> ...
>=20
> 33464866.721 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688785, bmval0: 1, addr: 0x7f331bb116c8)
> 33464866.724 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688827, bmval0: 1, addr: 0x7f331bb11738)
> 33464866.729 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688767, bmval0: 1, addr: 0x7f331bb117a8)
> 33464866.732 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210718132, bmval0: 1, addr: 0x7f331bb11818)
> 33464866.737 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688952, bmval0: 1, addr: 0x7f331bb11888)
> 33464866.741 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210702355, bmval0: 1, addr: 0x7f331bb118f8)
> 33868414.001 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688751, bmval0: 1, addr: 0x7f331be68620)
> 33868414.014 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210718536, bmval0: 1, addr: 0x7f331be68690)
> 33868414.018 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210719074, bmval0: 1, addr: 0x7f331be68700)
> 33868414.022 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688916, bmval0: 1, addr: 0x7f331be68770)
> 33868414.026 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688941, bmval0: 1, addr: 0x7f331be687e0)
> ...
>=20
> 33868414.924 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688744, bmval0: 1, addr: 0x7f331be6d7f0)
> 33868414.929 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210717223, bmval0: 1, addr: 0x7f331be6d860)
> 33868414.934 kthreadd/1597068 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210716137, bmval0: 1, addr: 0x7f331be6d8d0)
> 34021240.903 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688941, bmval0: 1, addr: 0x7f331c207de8)
> 34021240.917 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210718750, bmval0: 1, addr: 0x7f331c207e58)
> 34021240.922 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688955, bmval0: 1, addr: 0x7f331c207ec8)
> 34021240.925 kworker/u98:5/1591466 nfsd:nfsd_cb_recall_any(cl_boot:=20
> 1710533037, cl_id: 210688975, bmval0: 1, addr: 0x7f331c207f38)
> ...
>=20
> I assume the cl_id is the client id? How can I map this to a client from=
=20
> /proc/fs/nfsd/clients?
>=20
> If I understand it correctly, the recall_any should be called when=20
> either the system starts to experience memory pressure, or it reaches=20
> the delegation limits? I doubt the system is actually running out of=20
> memory here as there are no other indications. Shouldn't I get those=20
> "page allocation failure" messages if it does? How can I check the=20
> number of delegations/leases currently issued, what the current maximum=
=20
> is and how to increase it?

You probably log messages or anything for that. recall_any is hooked up
to a shrinker AFAIU, so we start sending those when the VM politely asks
us to release memory, not when it's an emergency.

The leases are (usually) shown in /proc/locks for most local
filesystems.

>=20
> Regarding the recall any call: from what I've read on kernelnewbies,=20
> this feature was introduced in the 6.2 kernel? When I look at the tree=
=20
> for 6.1.x, it was backported in 6.1.81? Is there a way to disable this=
=20
> support somehow?
>=20

Not currently. You can disable kernel leases altogether which will
disable delegations. You may want to start there if you're having
stability issues with them enabled.

That said, with a problem like this, it's easy to get lost in peripheral
details. I'm not clear on root cause of this problem yet.

You have a client that is unable to reestablish a session with the
server because the server is returning NFS4ERR_DELAY repeatedly. If
you're able, my suggestion would be to start by trying to determine the
cause of that problem, rather than guessing about different patches, or
turning off server functionality.

Note too that the kernel you're running on the server is a build
artifact from a merge request. Once you're ready to reboot, you may want
to update to the latest centos9 stream kernel, since those patches have
now been merged into it (along with some other NFS fixes).


> > > > > The nfsdclnts command for this client shows the following delegat=
ions:
> > > > >=20
> > > > > # nfsdclnts -f 155/states -t all
> > > > > Inode number | Type=C2=A0=C2=A0 | Access | Deny | ip address | Fi=
lename
> > > > > 169346743=C2=A0=C2=A0=C2=A0 | open=C2=A0=C2=A0 | r-=C2=A0=C2=A0=
=C2=A0=C2=A0 | --=C2=A0=C2=A0 | 10.87.31.152:819 |
> > > > > disconnected dentry
> > > > > 169346743=C2=A0=C2=A0=C2=A0 | deleg=C2=A0 | r=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10.87.31.152:819 |
> > > > > disconnected dentry
> > > > > 169346746=C2=A0=C2=A0=C2=A0 | open=C2=A0=C2=A0 | r-=C2=A0=C2=A0=
=C2=A0=C2=A0 | --=C2=A0=C2=A0 | 10.87.31.152:819 |
> > > > > disconnected dentry
> > > > > 169346746=C2=A0=C2=A0=C2=A0 | deleg=C2=A0 | r=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10.87.31.152:819 |
> > > > > disconnected dentry
> > > > >=20
> > > > > I see a lot of recent patches regarding directory delegations. Co=
uld
> > > > > this be related to this?
> > > > >=20
> > > > > Will a 5.14.0-362.18.1.el9_3.0.1 kernel try to use a directory=
=20
> > > > > delegation?
> > > > >=20
> > > > >=20
> > > > No. Directory delegations are a new feature that's still under
> > > > development. They use some of the same machinery as file delegation=
s,
> > > > but they wouldn't be a factor here.
> > > >=20
> > > > > > The system seems to have identified that the client is no longe=
r
> > > > > > reachable, but the client entry does not go away. When a mount =
was
> > > > > > hanging on the client, there would be two directories in client=
s for
> > > > > > the same client. Killing the mount command clears up the second=
=20
> > > > > > entry.
> > > > > >=20
> > > > > > Even after running conntrack -D on the server to remove the tcp
> > > > > > connection from the conntrack table, the entry doesn't go away =
and=20
> > > > > > the
> > > > > > client still can not mount anything from the server.
> > > > > >=20
> > > > > > A tcpdump on the client while a mount was running logged the=
=20
> > > > > > following
> > > > > > messages over and over again:
> > > > > >=20
> > > > > > request:
> > > > > >=20
> > > > > > Frame 1: 378 bytes on wire (3024 bits), 378 bytes captured (302=
4=20
> > > > > > bits)
> > > > > > Ethernet II, Src: HP_19:7d:4b (e0:73:e7:19:7d:4b), Dst:
> > > > > > ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00)
> > > > > > Internet Protocol Version 4, Src: 10.87.31.152, Dst: 10.86.18.1=
4
> > > > > > Transmission Control Protocol, Src Port: 932, Dst Port: 2049, S=
eq: 1,
> > > > > > Ack: 1, Len: 312
> > > > > > Remote Procedure Call, Type:Call XID:0x1d3220c4
> > > > > > Network File System
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 GSS Data, Ops(1): CREATE_SESSION
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Length: 152
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Sequence N=
umber: 76
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minorversion: =
2
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Operations (co=
unt: 1): CREATE_SESSION
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Main Opcode: =
CREATE_SESSION (43)]
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 GSS Checksum:
> > > > > > 00000028040404ffffffffff000000002c19055f1f8d442d594c13849628aff=
c2797cbb2=E2=80=A6=20
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Token Leng=
th: 40
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS-API Generi=
c Security Service Application Program=20
> > > > > > Interface
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 krb5_blob:
> > > > > > 040404ffffffffff000000002c19055f1f8d442d594c13849628affc2797cbb=
23fa080b0=E2=80=A6=20
> > > > > >=20
> > > > > >=20
> > > > > > response:
> > > > > >=20
> > > > > > Frame 2: 206 bytes on wire (1648 bits), 206 bytes captured (164=
8=20
> > > > > > bits)
> > > > > > Ethernet II, Src: ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00), Dst:
> > > > > > HP_19:7d:4b (e0:73:e7:19:7d:4b)
> > > > > > Internet Protocol Version 4, Src: 10.86.18.14, Dst: 10.87.31.15=
2
> > > > > > Transmission Control Protocol, Src Port: 2049, Dst Port: 932, S=
eq: 1,
> > > > > > Ack: 313, Len: 140
> > > > > > Remote Procedure Call, Type:Reply XID:0x1d3220c4
> > > > > > Network File System
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 [Program Version: 4]
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 [V4 Procedure: COMPOUND (1)]
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 GSS Data, Ops(1): CREATE_SESSION(NFS4E=
RR_DELAY)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Length: 24
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Sequence N=
umber: 76
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: NFS4ER=
R_DELAY (10008)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tag: <EMPTY>
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Operations (co=
unt: 1)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Main Opcode: =
CREATE_SESSION (43)]
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 GSS Checksum:
> > > > > > 00000028040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf=
4f6274222=E2=80=A6=20
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS Token Leng=
th: 40
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSS-API Generi=
c Security Service Application Program=20
> > > > > > Interface
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 krb5_blob:
> > > > > > 040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf4f627422=
226d74923=E2=80=A6=20
> > > > > >=20
> > > > > >=20
> > > > > > I was hoping that giving the client a different IP address woul=
d
> > > > > > resolve the issue for this client, but it didn't. Even though t=
he
> > > > > > client had a new IP address (hostname was kept the same), it=
=20
> > > > > > failed to
> > > > > > mount anything from the server.
> > > > > >=20
> > > > Changing the IP address won't help. The client is probably using th=
e
> > > > same long-form client id as before, so the server still identifies =
the
> > > > client even with the address change.
> > > How is the client id determined? Will changing the hostname of the=
=20
> > > client trigger a change of the client id?
> > > >=20
> > > > Unfortunately, the cause of an NFS4ERR_DELAY error is tough to gues=
s.
> > > > The client is expected to back off and retry, so if the server keep=
s
> > > > returning that repeatedly, then a hung mount command is expected.
> > > >=20
> > > > The question is why the server would keep returning DELAY. A lot of
> > > > different problems ranging from memory allocation issues to protoco=
l
> > > > problems can result in that error. You may want to check the NFS se=
rver
> > > > and see if anything was logged there.
> > > There are no messages in the system logs that indicate any sort of=
=20
> > > memory issue. We also increased the min_kbytes_free sysctl to 2G on=
=20
> > > the server before we restarted it with the newer kernel.
> > > >=20
> > > > This is on a CREATE_SESSION call, so I wonder if the record held by=
 the
> > > > (courteous) server is somehow blocking the attempt to reestablish t=
he
> > > > session?
> > > >=20
> > > > Do you have a way to reproduce this? Since this is a centos kernel,=
 you
> > > > could follow the page here to open a bug:
> > >=20
> > > Unfortunately we haven't found a reliable way to reproduce it. But we=
=20
> > > do seem to trigger it more and more lately.
> > >=20
> > > Regards,
> > >=20
> > > Rik
> > >=20
> > > >=20
> > > > https://urldefense.com/v3/__https://wiki.centos.org/ReportBugs.html=
__;!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4=
nv6oZsqLwP4kW56CMpDWhkjjwSkWIqsboq$=20
> > > >=20
> > > >=20
> > > > > > I created another dump of the workqueues and worker pools on th=
e=20
> > > > > > server:
> > > > > >=20
> > > > > > [Mon Mar 18 14:59:33 2024] Showing busy workqueues and worker p=
ools:
> > > > > > [Mon Mar 18 14:59:33 2024] workqueue events: flags=3D0x0
> > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 54: cpus=3D27 node=
=3D1 flags=3D0x0 nice=3D0
> > > > > > active=3D1/256 refcnt=3D2
> > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending: drm=
_fb_helper_damage_work
> > > > > > [drm_kms_helper]
> > > > > > [Mon Mar 18 14:59:33 2024] workqueue events_power_efficient:=
=20
> > > > > > flags=3D0x80
> > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 54: cpus=3D27 node=
=3D1 flags=3D0x0 nice=3D0
> > > > > > active=3D1/256 refcnt=3D2
> > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending: fb_=
flashcursor
> > > > > > [Mon Mar 18 14:59:33 2024] workqueue mm_percpu_wq: flags=3D0x8
> > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 54: cpus=3D27 node=
=3D1 flags=3D0x0 nice=3D0
> > > > > > active=3D1/256 refcnt=3D3
> > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending: lru=
_add_drain_per_cpu=20
> > > > > > BAR(362)
> > > > > > [Mon Mar 18 14:59:33 2024] workqueue kblockd: flags=3D0x18
> > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0pwq 55: cpus=3D27 node=
=3D1 flags=3D0x0=20
> > > > > > nice=3D-20
> > > > > > active=3D1/256 refcnt=3D2
> > > > > > [Mon Mar 18 14:59:33 2024] =C2=A0=C2=A0=C2=A0=C2=A0pending: blk=
_mq_timeout_work
> > > > > >=20
> > > > > >=20
> > > > > > In contrast to last time, it doesn't show anything regarding nf=
s this
> > > > > > time.
> > > > > >=20
> > > > > > I also tried the suggestion from Dai Ngo (echo 3 >
> > > > > > /proc/sys/vm/drop_caches), but that didn't seem to make any=20
> > > > > > difference.
> > > > > >=20
> > > > > > We haven't restarted the server yet as it seems the impact seem=
s to
> > > > > > affect fewer clients that before. Is there anything we can run =
on the
> > > > > > server to further debug this?
> > > > > >=20
> > > > > > In the past, the issue seemed to deteriorate rapidly and result=
ed in
> > > > > > issues for almost all clients after about 20 minutes. This time=
 the
> > > > > > impact seems to be less, but it's not gone.
> > > > > >=20
> > > > > > How can we force the NFS server to forget about a specific clie=
nt? I
> > > > > > haven't tried to restart the nfs service yet as I'm afraid it w=
ill
> > > > > > fail to stop as before.
> > > > > >=20
> > > > Not with that kernel. There are some new administrative interfaces =
that
> > > > might allow that in the future, but they were just merged upstream =
and
> > > > aren't in that kernel.
> > > >=20
> > > > --=20
> > > > Jeff Layton <jlayton@kernel.org>
> > >=20

--=20
Jeff Layton <jlayton@kernel.org>

