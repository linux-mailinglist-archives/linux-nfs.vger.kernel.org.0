Return-Path: <linux-nfs+bounces-6473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BB8978EE0
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Sep 2024 09:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530D02810CA
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Sep 2024 07:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848BF18037;
	Sat, 14 Sep 2024 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZxieJwx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6961FFC
	for <linux-nfs@vger.kernel.org>; Sat, 14 Sep 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726298961; cv=none; b=EjiXko7rV2Kw8DeUg3LSv3RUInaY4Zah1P3/bySlOhgRMojac4tmFGg6S44tRQHAePMh+goqXx4R7Z7wmj9mv69iElxCpRmL69OkeN42NyTYiYKxjTvZ9gs2aUsTAlKf8H9bngNhW8C9qMvduG06e8yMdEmXXv3DNrSlan2WZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726298961; c=relaxed/simple;
	bh=68kkRvAI7Jv8UbTeDJbXlDEwJMhkMOzp0BZbE6a1GvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDXWBYiG0LiBdYvu6yCWtzTJW6CzdjnA99IVw1MB8y4Q5gPjJIUqOJuSZLQBxwKzBGDe3gNTyP5nS6fdotWM1mCghO6HEsB2Da4vLLomoXMHynAib0Q7x9207N2GUxNAaH2uJT9TwxZORVCA2ZtsRSxWfDXui4gVicpEizyUN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZxieJwx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso434115066b.3
        for <linux-nfs@vger.kernel.org>; Sat, 14 Sep 2024 00:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726298958; x=1726903758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzPQpsbj1Pe4uk6l3uujXeY8UzMTNtOaVyayCGyexng=;
        b=DZxieJwx/JIhWTUfIZKm/x6sjNM/pmi3ZW30h6i33lb2kQBsyjWynHGYCgD9QiU4Sq
         9UlRZzItequ5GZtjdpkE94DNciiNPAKUBg8m7QP+h41A0XcH9jwaInIA8NT+JMZBCMX4
         oZsEAYYBj+4nffvdiYhgNKPNfNnyKS8AVi36yj9ePVXKjn3myr9UirsyAhoBnZr+DDKX
         AID7eCpmI9xCfSKVEqLu+An/bWF9IYNLYw3rOGjKPT0Eplck4GxZ/SnoATN6RKownsTK
         7GkTbutcGAC6w5jhqVRfAk8TPHV+x+bDvgd3PtHjHR6lPdArR8ngqf/6+6a26QQiK4U5
         Vleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726298958; x=1726903758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzPQpsbj1Pe4uk6l3uujXeY8UzMTNtOaVyayCGyexng=;
        b=WLohw3jCaZZQv3nqwEMkcqKMngU9msCDcIv+skbl2sH7b/qarTGKm8xj4uokhbYi6f
         J5Q1Jp/tJn+YRjH4SAH8MffJdyyPICbPxhCEYZ3dsivJHTmGKqtBard+3rmpwcuH95U4
         gDp/iaq8ZN/JCdvx0ixFIZHTVeSoiOTLGQTklGRQ2cbYbD1/+idK0TJmsqk7xF0rVGAK
         AZyadAx7KkQn1SZ7VrbpLyfqku9GojDoc/BHE5HJ5+zPtZjiioxZuTYsvolEQw101dNo
         XvUZl9qmrPqV4C0uJAjRcMIaEN0DN15fEqaJJMkqYQbqzw+IBD7S3LbGZ7dPkYtzTFaq
         qBig==
X-Gm-Message-State: AOJu0Yx3JgPnJVla/LfDLN11uBIXdPWu3aMv0UT5GWs++AVlu3iHSqld
	yF8VhOwlpP0xKZFD+tHXCqqMflt/cxyjOZipmQWDkPFaatd+16es
X-Google-Smtp-Source: AGHT+IE4GNRvCrsg6FjjquVAD3et6ifiHr3edG2EZrkUxYCzle2+XntZiW1hFii2eIIOYnpHsrl4Gg==
X-Received: by 2002:a17:907:94c3:b0:a86:9880:183 with SMTP id a640c23a62f3a-a90293b16eemr980168166b.10.1726298957067;
        Sat, 14 Sep 2024 00:29:17 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061331b7csm43460566b.225.2024.09.14.00.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 00:29:16 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E5512BE2DE0; Sat, 14 Sep 2024 09:29:15 +0200 (CEST)
Date: Sat, 14 Sep 2024 09:29:15 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sergio Gelato <sergio.gelato@astro.su.se>,
	Steve Dickson <steved@redhat.com>,
	Kevin Coffman <kwc@citi.umich.edu>, Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
Subject: Re: rpc.idmapd runs out of file descriptors
Message-ID: <ZuU7S2Gli6oAALPJ@eldamar.lan>
References: <ZmCB_zqdu2cynJ1M@astro.su.se>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZmCB_zqdu2cynJ1M@astro.su.se>

Hi all,

On Wed, Jun 05, 2024 at 05:19:27PM +0200, Sergio Gelato wrote:
> Observed on Debian 12 (nfs-utils 2.6.2):
>=20
> May 28 09:40:25 HOSTNAME rpc.idmapd[3602614]: dirscancb: scandir(/run/rpc=
_pipefs/nfs): Too many open files
> [repeated multiple times]
>=20
> Investigation with lsof on one of the affected systems shows that file de=
sciptors are not being closed:
>=20
> [...]
> rpc.idmap 675 root  126r      DIR               0,40        0      10813 =
/run/rpc_pipefs/nfs/clnt11e6 (deleted)
> rpc.idmap 675 root  127u     FIFO               0,40      0t0      10817 =
/run/rpc_pipefs/nfs/clnt11e6/idmap (deleted)
> rpc.idmap 675 root  128r      DIR               0,40        0      10834 =
/run/rpc_pipefs/nfs/clnt11ef (deleted)
> rpc.idmap 675 root  129u     FIFO               0,40      0t0      10838 =
/run/rpc_pipefs/nfs/clnt11ef/idmap (deleted)
> rpc.idmap 675 root  130r      DIR               0,40        0      10855 =
/run/rpc_pipefs/nfs/clnt11f8 (deleted)
> rpc.idmap 675 root  131u     FIFO               0,40      0t0      10859 =
/run/rpc_pipefs/nfs/clnt11f8/idmap (deleted)
>=20
> Raising the verbosity level to 3 results in no "Stale client:" lines.
> strace shows no close() calls other than for the /run/rpc_pipefs/nfs dire=
ctory.
>=20
> I believe this is because in dirscancb() the loop is exited prematurely
> the first time nfsopen() returns -1, preventing later entries in the queue
> from being reaped. I've tested the patch below, which seems indeed to cure
> the problem. The bug appears to be still unfixed in the current master br=
anch.

> From: Sergio Gelato <Sergio.Gelato@astro.su.se>
> Date: Tue, 4 Jun 2024 16:02:59 +0200
> Subject: rpc.idmapd: nfsopen() failures should not be fatal
>=20
> dirscancb() loops over all clnt* subdirectories of /run/rpc_pipefs/nfs/.
> Some of these directories contain /idmap files, others don't. nfsopen()
> returns -1 for the latter; we then want to skip the directory, not abort
> the entire scan.
> ---
>  utils/idmapd/idmapd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> index e79c124..f3c540d 100644
> --- a/utils/idmapd/idmapd.c
> +++ b/utils/idmapd/idmapd.c
> @@ -556,7 +556,7 @@ dirscancb(int fd, short UNUSED(which), void *data)
>  			if (nfsopen(ic) =3D=3D -1) {
>  				close(ic->ic_dirfd);
>  				free(ic);
> -				goto out;
> +				continue;
>  			}
> =20
>  			if (verbose > 2)

Did this felt trough the cracks? Does the patch from Sergio looks good
to you?

Regards,
Salvatore

