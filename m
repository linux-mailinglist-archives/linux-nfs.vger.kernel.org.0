Return-Path: <linux-nfs+bounces-84-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055937F9FCF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 13:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E0C1C20328
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 12:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EFB1E504;
	Mon, 27 Nov 2023 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9sI64/F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D181BE
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701088937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ws6vrnKKVLGPBS6XGrIyt7ngBA3H2IfYa5vbUTehPyE=;
	b=D9sI64/FsnmdnMAzdZnOPr2TyQEzZpnFIP//+D0zFellIcFNeDOuD4fj8L7RvgBXUkawmn
	DQjYZFp3NQtbLbwT1LLo7RGHypcaT6GHnxzQ/dRPGLlOjPRp4Sz61Ik0/nH4l1vFEmKyZB
	7Atdx4PAsCWqbCK/IqvbjZmfsWxuHig=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-FzgKCPusMwWnO_1W7jmt3Q-1; Mon, 27 Nov 2023 07:42:16 -0500
X-MC-Unique: FzgKCPusMwWnO_1W7jmt3Q-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3e601436cso4409817b6e.1
        for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 04:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701088935; x=1701693735;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ws6vrnKKVLGPBS6XGrIyt7ngBA3H2IfYa5vbUTehPyE=;
        b=Lvu9iLJ+DSclv3WMLF4190NvTsNMt5v6YueT5iGUNplKvOoirIIcQdC2040rKdoqJf
         Gnj6VAip5QVxoijmjBhgtiXNFYwXMRHg+TUzJIZOWoWuR0XlgptMVM2q62t1q3jqndH2
         X2svF7CkjDeUH4DBWqt8IzE3yaS8cNP2AmsSPu/oVMCt6hlr8teoaziTkOki+x+RWJfb
         CID/uRIuBduXQbC+pTz8xXEXXbDBqsAs87ntOWoofrXMtAmm2kL1yUkEVXC7HNTnhgyW
         zsKG2xKIdyXG+9IVBm+w6ANYvNCYebfYZjnLxbHbm9wPGzduxV+jEOcsMaOHqoF6Skdh
         YLJA==
X-Gm-Message-State: AOJu0YzHIBbbCnB14Y8+FmTlryulAVrfMeKqdjh2/3yOf+OHYUZsmJ2a
	470iJS9gS6FER/sM6tTS0/GQFwE6r3bNTLv3im3nG27vaH+RRprhXSayXk2PYMi+AxTSUuPoFvR
	tWM/3D7yXSbo23O2VtUTCnNPO/VH9
X-Received: by 2002:a05:6808:199d:b0:3b8:3ba9:b14b with SMTP id bj29-20020a056808199d00b003b83ba9b14bmr15650959oib.43.1701088935022;
        Mon, 27 Nov 2023 04:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9eI6pxMr4gZUqpmuBbnmJqXsy1bdOW5SviA1MxtIvslxmdO6MNagXD/Fb16hSn2WTCmHl4w==
X-Received: by 2002:a05:6808:199d:b0:3b8:3ba9:b14b with SMTP id bj29-20020a056808199d00b003b83ba9b14bmr15650946oib.43.1701088934770;
        Mon, 27 Nov 2023 04:42:14 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id w2-20020a0c8e42000000b00679d7e76b64sm309170qvb.126.2023.11.27.04.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:42:14 -0800 (PST)
Message-ID: <fb7ad4e6dd8a8ed9e7ecf83f23030c035a1dd4d9.camel@redhat.com>
Subject: Re: [PATCH v1] NFSD: Document lack of f_pos_lock in nfsd_readdir()
From: Jeff Layton <jlayton@redhat.com>
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc: viro@zeniv.linux.org.uk
Date: Mon, 27 Nov 2023 07:42:13 -0500
In-Reply-To: <170044303100.5164.767231155248883501.stgit@bazille.1015granger.net>
References: 
	<170044303100.5164.767231155248883501.stgit@bazille.1015granger.net>
Autocrypt: addr=jlayton@redhat.com; prefer-encrypt=mutual; keydata=mQGiBEeEuHURBADM5bedfHs07kPNIlt2i9/U8I6Ce/zez8JBhIB/7fv+E86Wn2FMmwsmMnczIKW1+CC3mfSYXk1I7S8oHBkqQiWuyl72lBEHXV3M+am5MaSqawPJBkMNeib4JfSYsuw7FqMQg5WbXL7DVkX7023ZoPGmGwUtpV1yztPrWFWT+c4UJwCg+0al2uGgTmG1XNRuD2oNdw16mC8EALlocvaK1kVPmOM+tfWoZ+qtS3p79X2KHYckONy+rgVfPGk1jlKmUOSb5kL/E8I20xZHGaXP3gfUPIgUUn4YEjzmoYMcGD9XraCFcS1dkIjiHZMIlTPt5w2gva5ylTc0DBjunj8mzDuV1NXxGimhS3nV08NBFP8zwv+5b1tbEQ1bBACTIbhbNXTsATGqKbeHMn2mJqJEy6/gyf4S4ZrX0XU1qMDBnbhpqCteoILoKLY7ieJ7QlOBE9OIMp5ljiXRBYuHEkyjcLnphSDWJtBNHpH8YSLM/V6V6EsfCm1zg6uKXIhXgnJhCxcxGQZ38ouo1zxKPV3P7UO6e3QJcMNtimULLIhJBCARAgAJBQJOldMZAh0BAAoJEKIx+D8ySXxlAQwAoJn2ozxaaDlh/5WuHpI4fvRwHjzcAKC+6biYj4YxicaQuAUXxmblo+3wEbQgSmVmZiBMYXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6IYAQTEQIAIAUCR4S4dQIbIwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAAAoJEKIx+D8ySXxlZa0AoNlfDmiLCSAWS4MUUINT3C8xdc9DAJ9UmeJg5B9/Vdj7YQOQ+SY1yyIqyLkEDQRHhLh1EBAAx0WopXX0lIX/mv4GsaBX52q+tTlPGzCiDIZo7M6cDfJ1meVm8snHrtIagdNDD6ilq2IDEcEg+JUJTPX
 uv3egfDmcA/HfDLR7OjZrTuAYYWxHmi1KSQCrUF7Z9iyysxeF8kNHsn5Ot hXvY6BUv9gKC4iZm1q1jv4jXSA44UAA8+eyVRdLVIpK2aDaHsxZVO+pdj8uvt6/En+QyZOdkxXZ6aJ9fW2thlPkRTVkODlKjrxQFsTihJ1VG28S1b1dsGG+T2RnFUDkzpoygwmsZH9QA4ec67j8Ikt5mJUwXKpGleuEiGBNeFjEvmNuzWG3w7BJFLBf+xb39sED9g1NUmAmWW0dvcLpP1xVubd1oEAUArTemO5sIowUudNopxiGPHKEhq219y1beYymHULAz5S4MCT9lzmY9nnlqTh4ohCmgrFu+owtK1TlbvDHwqm/3kKgtUOdKozfl1vt5DszNaqTfauPTlool5q80rHHoIPSFwRqB7IJ2A8KiCSnXv8EjUfQnuVWNHNA1CnznI8AUeQYxJvl68BDyaFBapkrYv5bgPWxJNbGARyHtnejCBECvHpfg7d6ZI494nUK/ubUXoXj7XCgKxYkWiFN6FznZMjDM3gW1EdqoqZa/aM/TgBlayv2BEKbxuDUoHMFlPGkMXvNrqjUvONA+qcnx1AH1XFM+/MAAwYP/39QASHQFIJwMFTspXlk1+kh0QGwYc1t58np9/Fyqdpr/t0pApU0SiZ7OhVgqQwS5rhQjZHikjhStxBvw92PjtKM+FCjd6GJbDqt971jTDWU+5COKUwbn2Kt602fECsxuBcgSbzzwMYoLMXzsfNBMBn+tLbApTeHOOJH2KMfiy//cULl1ElzZEOBtVj2+qV5M6qo2NcwMXi2Pte61506NCFP/WIFgcy2CBd7z8dChzvoxz/qBKL07YZO6LodKs+CgFfGvuaIJnB7vlscmQkP3YQTKTFoDk6jXd4mEiXjfdko/pRx9LNbwIe+uYXFtMYIoSRZUco+1zhcEizONwaAr0T6GXP+Kt5fK05zdeXn6W9UrzTF0uggXYxk1o1wOuxN7sO
 nw+8Og3WVrGaLCSqZ9sy0ffrQa7ndom9b94WX7YIdhlW8f+CaFHO9xxHWzC geZLlHVnZLwgzDrIiamHZtLK/UrurVKFLbSDCD8XA1I6uDo2oT0JTmUZHdtCLxJ1wOrxb52BlrJMdVV+RzOGssbpXMMoy3XM8dkJEQrr02tYYkYhS6rlfu6ASpL8XisWgCJj8POnM6+tBY6CKM5+j6Q/asnFbWPfXYotDn+acOFIH7yjqb+Teht4o/96ld5RNO3Zu8I8P3jx7YtXz5P9hk4bZ2eaIhpDbVy7VLI0EJUI2XiEkEGBECAAkFAkeEuHUCGwwACgkQojH4PzJJfGVP+wCaA1Wj2IE5jPLolqjxHZB5fyrayGgAoLKSJ/oe6gBTxcdr6YpvY78cHijCmQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxwn8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1WvegyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqVT2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtVYrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8snVluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQcDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24
 +RrK+seQfCBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRB R46g/jf8KnPRwXs509yAqDB6sELZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/r0kmR/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2BrQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRIONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZWf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQOlDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7RjiR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27XiQQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBMYXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwk
 IBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWO d7SlPFzIYy2/fjvKlfB/Xs4YdNcf9qLqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoac8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3FLpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx3bri75n1TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y+jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5dHxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBMBAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4hN9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPepnaQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub
 0T/8Kwo1qGPdu1hx2BQRERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmB TgUWKN969HPRkxiojLQziHVyM/weR5Reu6FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8EewP8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0XzhaKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyAnLqRgDgR+wTQT6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7hdMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjruymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItuAXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfDFOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJv
 wi6NmQ9P9UAuLG93S2MdNNbosZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVX hJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDvqrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51asjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qGIcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbLUO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSUapy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5ddhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7eflPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/
 JNk8dtwmvWnqCwRqElMLVisAbJmC0BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJO JYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7BAKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65ke5Ag0
 ETpXRPAEQAJkVmzCmF+IEenf9a2nZRXMluJohnfl2wCMmw5qNzyk0f+mYuTwTCpw7 BE2H0yXk4ZfAuA+xdj14K0A1Dj52j/fKRuDqoNAhQe0b6ipo85Sz98G+XnmQOMeFVp5G1Z7r/QP/nus3mXvtFsu9lLSjMA0cam2NLDt7vx3l9kUYlQBhyIE7/DkKg+3fdqRg7qJoMHNcODtQY+n3hMyaVpplJ/l0DdQDbRSZi5AzDM3DWZEShhuP6/E2LN4O3xWnZukEiz688d1ppl7vBZO9wBql6Ft9Og74diZrTN6lXGGjEWRvO55h6ijMsLCLNDRAVehPhZvSlPldtUuvhZLAjdWpwmzbRIwgoQcO51aWeKthpcpj8feDdKdlVjvJO9fgFD5kqZQiErRVPpB7VzA/pYV5Mdy7GMbPjmO0IpoL0tVZ8JvUzUZXB3ErS/dJflvboAAQeLpLCkQjqZiQ/DCmgJCrBJst9Xc7YsKKS379Tc3GU33HNSpaOxs2NwfzoesyjKU+P35czvXWTtj7KVVSj3SgzzFk+gLx8y2Nvt9iESdZ1Ustv8tipDsGcvIZ43MQwqU9YbLg8k4V9ch+Mo8SE+C0jyZYDCE2ZGf3OztvtSYMsTnF6/luzVyej1AFVYjKHORzNoTwdHUeC+9/07GO0bMYTPXYvJ/vxBFm3oniXyhgb5FtABEBAAGJAh8EGAECAAkFAk6V0TwCGwwACgkQAA5oQRlWghXhZRAAyycZ2DDyXh2bMYvI8uHgCbeXfL3QCvcw2XoZTH2l2umPiTzrCsDJhgwZfG9BDyOHaYhPasd5qgrUBtjjUiNKjVM+Cx1DnieR0dZWafnqGv682avPblfi70XXr2juRE/fSZoZkyZhm+nsLuIcXTnzY4D572JGrpRMTpNpGmitBdh1l/9O7Fb64uLOtA5Qj5jcHHOjL0DZpjmFWYKlSAHmURHrE8M0qRryQXvlhoQxlJR4nvQrjOPMsqWD5F9
 mcRyowOzr8amasLv43w92rD2nHoBK6rbFE/qC7AAjABEsZq8+TQmueN0maIXUQu7TB zejsEbV0i29z+kkrjU2NmK5pcxgAtehVxpZJ14LqmN6E0suTtzjNT1eMoqOPrMSx+6vOCIuvJ/MVYnQgHhjtPPnU86mebTY5Loy9YfJAC2EVpxtcCbx2KiwErTndEyWL+GL53LuScUD7tW8vYbGIp4RlnUgPLbqpgssq2gwYO9m75FGuKuB2+2bCGajqalid5nzeq9v7cYLLRgArJfOIBWZrHy2m0C+pFu9DSuV6SNr2dvMQUv1V58h0FaSOxHVQnJdnoHn13g/CKKvyg2EMrMt/EfcXgvDwQbnG9we4xJiWOIOcsvrWcB6C6lWBDA+In7w7SXnnokkZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-11-19 at 20:17 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Al Viro notes that normal system calls hold f_pos_lock when calling
> ->iterate_shared and ->llseek; however nfsd_readdir() does not take
> that mutex when calling these methods.
>=20
> It should be safe however because the struct file acquired by
> nfsd_readdir() is not visible to other threads.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c |   20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index fbbea7498f02..87a5953c6bf0 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2109,9 +2109,23 @@ static __be32 nfsd_buffered_readdir(struct file *f=
ile, struct svc_fh *fhp,
>  	return cdp->err;
>  }
> =20
> -/*
> - * Read entries from a directory.
> - * The  NFSv3/4 verifier we ignore for now.
> +/**
> + * nfsd_readdir - Read entries from a directory
> + * @rqstp: RPC transaction context
> + * @fhp: NFS file handle of directory to be read
> + * @offsetp: OUT: seek offset of final entry that was read
> + * @cdp: OUT: an eof error value
> + * @func: entry filler actor
> + *
> + * This implementation ignores the NFSv3/4 verifier cookie.
> + *
> + * NB: normal system calls hold file->f_pos_lock when calling
> + * ->iterate_shared and ->llseek, but nfsd_readdir() does not.
> + * Because the struct file acquired here is not visible to other
> + * threads, it's internal state does not need mutex protection.
> + *
> + * Returns nfs_ok on success, otherwise an nfsstat code is
> + * returned.
>   */
>  __be32
>  nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp=
,=20
>=20
>=20
Good thing to document

Reviewed-by: Jeff Layton <jlayton@redhat.com>


