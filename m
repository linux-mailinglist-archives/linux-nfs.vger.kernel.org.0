Return-Path: <linux-nfs+bounces-15750-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A24BC1A1FE
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 12:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863D81890003
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D2D311C05;
	Wed, 29 Oct 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XxWvfpHV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GWqAjGqh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UEKk1LGw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EMfrvtHj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C822D47FD
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738944; cv=none; b=HT6ShiNBZj6Ik5bshVoOfZMSYt8tw7DrH385MG8z7cKIkYYFZCFQ3g9Mrld3NUnUQnuKdj2p8b8gulk0aBeOb24/F6R5UvYK4Y0LaLRXxWDhuNVsctCT0aykz0w1DwSyM6zD7B2FpGftfq0v2C6GgKJqhipJ9rbolc6oIJe0uHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738944; c=relaxed/simple;
	bh=7PAY7AHhc0XUBy7Yx1wdyyPrXvwMpOfhvEqIoFDjzsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeCoJBxG1znstfGwbltnrQgS3YuNpLUYGy3zeJ2ecwG8RHKcF6La/ZxgSS/mmFITdjeZFrdPCYFYe70pJ17uMI9jPW4ZKnZBMRhU7ssSsrJjQgyclUpB1lnV3iwhAYdL8DESVFzwxgwOA+tsbzamB+kJ3F8EiRLdIy3AI9yOyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XxWvfpHV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GWqAjGqh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UEKk1LGw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EMfrvtHj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A1BF33884;
	Wed, 29 Oct 2025 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761738940;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47BQQrlR4r2+i8Dp+RqKGC7jBCxze/FS52mdqA89oK8=;
	b=XxWvfpHVTJlQXj0e+A5ug/okUEatQdTITv75yvF8rueU1sBPR7YM8rHOlQKkCQN+44Op0p
	Uae1ar53nxKbrBVMm/zS8M3DWw/Wb1gCVJ0GFdllzm2dmKtd1Xke6nQRLiJnlZj5KMI5Ml
	QmGUMLSx0OALW0RoiIs4Wvvqy6cV0WY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761738940;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47BQQrlR4r2+i8Dp+RqKGC7jBCxze/FS52mdqA89oK8=;
	b=GWqAjGqh3tuYoXXIboFD6dPTYV88lyJPdK2t1utyRpEPZ4xhmCa1Ns81W4IJOyx8uZEyfv
	ocNFvmREi7ouNNBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761738939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47BQQrlR4r2+i8Dp+RqKGC7jBCxze/FS52mdqA89oK8=;
	b=UEKk1LGwb7l8BU0iaEADPWGffSp4E5XjxzHaq33wlfaeQr1gGuL2lz+KV3v59q6jHxNo9t
	WwgUaSmF/auMfT452ZBp2LC7DxnfODZtnch0deCN+DreHDr9WAqDdUrndnmo+At6wIaP+l
	MSe47qGAU1QkJkFDuhGERG/TH+6OUbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761738939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47BQQrlR4r2+i8Dp+RqKGC7jBCxze/FS52mdqA89oK8=;
	b=EMfrvtHj1jsQGM5jzlrXlVPVYo6o71RLrYYunljiaJE6/kNmMzaJNQcJYS4H6pXGNwsj16
	5JcwmsqIaJPgpiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62BF51396A;
	Wed, 29 Oct 2025 11:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SGgtF7sAAmlOGgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 29 Oct 2025 11:55:39 +0000
Date: Wed, 29 Oct 2025 12:55:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Cc: ltp@lists.linux.it, ailiopoulos@suse.com, steved@redhat.com,
	linux-nfs@vger.kernel.org, Martin Doucha <martin.doucha@suse.com>
Subject: Re: [PATCH] nfs: use nfs version 4.0, including the minorversion
Message-ID: <20251029115538.GA637049@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251024170342.21084-1-akumar@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024170342.21084-1-akumar@suse.de>
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Spam-Level: 

Hi all,

> If no specific minorversion is specified, it autonegotiates to highest available
> version and test end up executing on v4.2 [1]

> $ nfslock01.sh -v 4 -t tcp
> results in

> /dev/loop2 /tmp/LTP_nfslock01.8VNHIljpxG/mntpoint ext4 rw,seclabel,relatime 0 0
> 10.0.0.2:/tmp/LTP_nfslock01.8VNHIljpxG/mntpoint/4/tcp /tmp/LTP_nfslock01.8VNHIljpxG/4/0 nfs4 rw,relatime,vers=4.2,rsize=262144,wsize=262144,namlen=255,hard,fatal_neterrors=ENETDOWN:ENETUNREACH,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.0.0.1,local_lock=none,addr=10.0.0.2 0 0

> [1] https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=blob;f=utils/mount/stropts.c;h=23f0a8c0e6f277440bae51f9c7b62900d9bdc76c;hb=HEAD#l127

I suppose the original change in f3dc132b14 ("network/nfs_lib.sh: add options,
socket type and NFS ver") [2] really intended "4" to be "v4.0" instead of the
latest NFS v4 version.

LGTM, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

[2] https://github.com/linux-test-project/ltp/commit/f3dc132b142cf761213a5e26a1ed4bc9ae1e1128

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  runtest/net.nfs | 50 ++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)

> diff --git a/runtest/net.nfs b/runtest/net.nfs
> index fef993da8..5d6adaa70 100644
> --- a/runtest/net.nfs
> +++ b/runtest/net.nfs
> @@ -4,126 +4,126 @@

>  nfs01_v30_ip4u nfs01.sh -v 3 -t udp
>  nfs01_v30_ip4t nfs01.sh -v 3 -t tcp
> -nfs01_v40_ip4t nfs01.sh -v 4 -t tcp
> +nfs01_v40_ip4t nfs01.sh -v 4.0 -t tcp
>  nfs01_v41_ip4t nfs01.sh -v 4.1 -t tcp
>  nfs01_v42_ip4t nfs01.sh -v 4.2 -t tcp
>  nfs01_v30_ip6u nfs01.sh -6 -v 3 -t udp
>  nfs01_v30_ip6t nfs01.sh -6 -v 3 -t tcp
> -nfs01_v40_ip6t nfs01.sh -6 -v 4 -t tcp
> +nfs01_v40_ip6t nfs01.sh -6 -v 4.0 -t tcp
>  nfs01_v41_ip6t nfs01.sh -6 -v 4.1 -t tcp
>  nfs01_v42_ip6t nfs01.sh -6 -v 4.2 -t tcp

>  nfs02_v30_ip4u nfs02.sh -v 3 -t udp
>  nfs02_v30_ip4t nfs02.sh -v 3 -t tcp
> -nfs02_v40_ip4t nfs02.sh -v 4 -t tcp
> +nfs02_v40_ip4t nfs02.sh -v 4.0 -t tcp
>  nfs02_v41_ip4t nfs02.sh -v 4.1 -t tcp
>  nfs02_v42_ip4t nfs02.sh -v 4.2 -t tcp
>  nfs02_v30_ip6u nfs02.sh -6 -v 3 -t udp
>  nfs02_v30_ip6t nfs02.sh -6 -v 3 -t tcp
> -nfs02_v40_ip6t nfs02.sh -6 -v 4 -t tcp
> +nfs02_v40_ip6t nfs02.sh -6 -v 4.0 -t tcp
>  nfs02_v41_ip6t nfs02.sh -6 -v 4.1 -t tcp
>  nfs02_v42_ip6t nfs02.sh -6 -v 4.2 -t tcp

>  nfs03_v30_ip4u nfs03.sh -v 3 -t udp
>  nfs03_v30_ip4t nfs03.sh -v 3 -t tcp
> -nfs03_v40_ip4t nfs03.sh -v 4 -t tcp
> +nfs03_v40_ip4t nfs03.sh -v 4.0 -t tcp
>  nfs03_v41_ip4t nfs03.sh -v 4.1 -t tcp
>  nfs03_v42_ip4t nfs03.sh -v 4.2 -t tcp
>  nfs03_v30_ip6u nfs03.sh -6 -v 3 -t udp
>  nfs03_v30_ip6t nfs03.sh -6 -v 3 -t tcp
> -nfs03_v40_ip6t nfs03.sh -6 -v 4 -t tcp
> +nfs03_v40_ip6t nfs03.sh -6 -v 4.0 -t tcp
>  nfs03_v41_ip6t nfs03.sh -6 -v 4.1 -t tcp
>  nfs03_v42_ip6t nfs03.sh -6 -v 4.2 -t tcp

>  nfs04_v30_ip4u nfs04.sh -v 3 -t udp
>  nfs04_v30_ip4t nfs04.sh -v 3 -t tcp
> -nfs04_v40_ip4t nfs04.sh -v 4 -t tcp
> +nfs04_v40_ip4t nfs04.sh -v 4.0 -t tcp
>  nfs04_v41_ip4t nfs04.sh -v 4.1 -t tcp
>  nfs04_v42_ip4t nfs04.sh -v 4.2 -t tcp
>  nfs04_v30_ip6u nfs04.sh -6 -v 3 -t udp
>  nfs04_v30_ip6t nfs04.sh -6 -v 3 -t tcp
> -nfs04_v40_ip6t nfs04.sh -6 -v 4 -t tcp
> +nfs04_v40_ip6t nfs04.sh -6 -v 4.0 -t tcp
>  nfs04_v41_ip6t nfs04.sh -6 -v 4.1 -t tcp
>  nfs04_v42_ip6t nfs04.sh -6 -v 4.2 -t tcp

>  nfs05_v30_ip4u nfs05.sh -v 3 -t udp
>  nfs05_v30_ip4t nfs05.sh -v 3 -t tcp
> -nfs05_v40_ip4t nfs05.sh -v 4 -t tcp
> +nfs05_v40_ip4t nfs05.sh -v 4.0 -t tcp
>  nfs05_v41_ip4t nfs05.sh -v 4.1 -t tcp
>  nfs05_v42_ip4t nfs05.sh -v 4.2 -t tcp
>  nfs05_v30_ip6u nfs05.sh -6 -v 3 -t udp
>  nfs05_v30_ip6t nfs05.sh -6 -v 3 -t tcp
> -nfs05_v40_ip6t nfs05.sh -6 -v 4 -t tcp
> +nfs05_v40_ip6t nfs05.sh -6 -v 4.0 -t tcp
>  nfs05_v41_ip6t nfs05.sh -6 -v 4.1 -t tcp
>  nfs05_v42_ip6t nfs05.sh -6 -v 4.2 -t tcp

> -nfs06_v30_v40_ip4  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
> +nfs06_v30_v40_ip4  nfs06.sh -v "3,3,3,4.0,4.0,4.0" -t "udp,udp,tcp,tcp,tcp,tcp"
>  nfs06_vall_ip4t nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
>  nfs06_v4x_ip6t nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"

>  nfs07_v30_ip4u nfs07.sh -v 3 -t udp
>  nfs07_v30_ip4t nfs07.sh -v 3 -t tcp
> -nfs07_v40_ip4t nfs07.sh -v 4 -t tcp
> +nfs07_v40_ip4t nfs07.sh -v 4.0 -t tcp
>  nfs07_v41_ip4t nfs07.sh -v 4.1 -t tcp
>  nfs07_v42_ip4t nfs07.sh -v 4.2 -t tcp
>  nfs07_v30_ip6u nfs07.sh -6 -v 3 -t udp
>  nfs07_v30_ip6t nfs07.sh -6 -v 3 -t tcp
> -nfs07_v40_ip6t nfs07.sh -6 -v 4 -t tcp
> +nfs07_v40_ip6t nfs07.sh -6 -v 4.0 -t tcp
>  nfs07_v41_ip6t nfs07.sh -6 -v 4.1 -t tcp
>  nfs07_v42_ip6t nfs07.sh -6 -v 4.2 -t tcp

>  nfs08_v30_ip4u nfs08.sh -v 3 -t udp
>  nfs08_v30_ip4t nfs08.sh -v 3 -t tcp
> -nfs08_v40_ip4t nfs08.sh -v 4 -t tcp
> +nfs08_v40_ip4t nfs08.sh -v 4.0 -t tcp
>  nfs08_v41_ip4t nfs08.sh -v 4.1 -t tcp
>  nfs08_v42_ip4t nfs08.sh -v 4.2 -t tcp
>  nfs08_v30_ip6u nfs08.sh -6 -v 3 -t udp
>  nfs08_v30_ip6t nfs08.sh -6 -v 3 -t tcp
> -nfs08_v40_ip6t nfs08.sh -6 -v 4 -t tcp
> +nfs08_v40_ip6t nfs08.sh -6 -v 4.0 -t tcp
>  nfs08_v41_ip6t nfs08.sh -6 -v 4.1 -t tcp
>  nfs08_v42_ip6t nfs08.sh -6 -v 4.2 -t tcp

>  nfs09_v30_ip4u nfs09.sh -v 3 -t udp
>  nfs09_v30_ip4t nfs09.sh -v 3 -t tcp
> -nfs09_v40_ip4t nfs09.sh -v 4 -t tcp
> +nfs09_v40_ip4t nfs09.sh -v 4.0 -t tcp
>  nfs09_v41_ip4t nfs09.sh -v 4.1 -t tcp
>  nfs09_v42_ip4t nfs09.sh -v 4.2 -t tcp
>  nfs09_v30_ip6u nfs09.sh -6 -v 3 -t udp
>  nfs09_v30_ip6t nfs09.sh -6 -v 3 -t tcp
> -nfs09_v40_ip6t nfs09.sh -6 -v 4 -t tcp
> +nfs09_v40_ip6t nfs09.sh -6 -v 4.0 -t tcp
>  nfs09_v41_ip6t nfs09.sh -6 -v 4.1 -t tcp
>  nfs09_v42_ip6t nfs09.sh -6 -v 4.2 -t tcp

>  nfs10_v30_ip4u nfs10.sh -v 3 -t udp
>  nfs10_v30_ip4t nfs10.sh -v 3 -t tcp
> -nfs10_v40_ip4t nfs10.sh -v 4 -t tcp
> +nfs10_v40_ip4t nfs10.sh -v 4.0 -t tcp
>  nfs10_v41_ip4t nfs10.sh -v 4.1 -t tcp
>  nfs10_v42_ip4t nfs10.sh -v 4.2 -t tcp
>  nfs10_v30_ip6u nfs10.sh -6 -v 3 -t udp
>  nfs10_v30_ip6t nfs10.sh -6 -v 3 -t tcp
> -nfs10_v40_ip6t nfs10.sh -6 -v 4 -t tcp
> +nfs10_v40_ip6t nfs10.sh -6 -v 4.0 -t tcp
>  nfs10_v41_ip6t nfs10.sh -6 -v 4.1 -t tcp
>  nfs10_v42_ip6t nfs10.sh -6 -v 4.2 -t tcp

>  nfslock01_v30_ip4u nfslock01.sh -v 3 -t udp
>  nfslock01_v30_ip4t nfslock01.sh -v 3 -t tcp
> -nfslock01_v40_ip4t nfslock01.sh -v 4 -t tcp
> +nfslock01_v40_ip4t nfslock01.sh -v 4.0 -t tcp
>  nfslock01_v41_ip4t nfslock01.sh -v 4.1 -t tcp
>  nfslock01_v42_ip4t nfslock01.sh -v 4.2 -t tcp
>  nfslock01_v30_ip6u nfslock01.sh -6 -v 3 -t udp
>  nfslock01_v30_ip6t nfslock01.sh -6 -v 3 -t tcp
> -nfslock01_v40_ip6t nfslock01.sh -6 -v 4 -t tcp
> +nfslock01_v40_ip6t nfslock01.sh -6 -v 4.0 -t tcp
>  nfslock01_v41_ip6t nfslock01.sh -6 -v 4.1 -t tcp
>  nfslock01_v42_ip6t nfslock01.sh -6 -v 4.2 -t tcp

>  nfsstat01_v30_ip4u nfsstat01.sh -v 3 -t udp
>  nfsstat01_v30_ip4t nfsstat01.sh -v 3 -t tcp
> -nfsstat01_v40_ip4t nfsstat01.sh -v 4 -t tcp
> +nfsstat01_v40_ip4t nfsstat01.sh -v 4.0 -t tcp
>  nfsstat01_v41_ip4t nfsstat01.sh -v 4.1 -t tcp
>  nfsstat01_v42_ip4t nfsstat01.sh -v 4.2 -t tcp
>  nfsstat01_v30_ip6u nfsstat01.sh -6 -v 3 -t udp
>  nfsstat01_v30_ip6t nfsstat01.sh -6 -v 3 -t tcp
> -nfsstat01_v40_ip6t nfsstat01.sh -6 -v 4 -t tcp
> +nfsstat01_v40_ip6t nfsstat01.sh -6 -v 4.0 -t tcp
>  nfsstat01_v41_ip6t nfsstat01.sh -6 -v 4.1 -t tcp
>  nfsstat01_v42_ip6t nfsstat01.sh -6 -v 4.2 -t tcp

> @@ -131,11 +131,11 @@ nfsstat02 nfsstat02.sh

>  fsx_v30_ip4u fsx.sh -v 3 -t udp
>  fsx_v30_ip4t fsx.sh -v 3 -t tcp
> -fsx_v40_ip4t fsx.sh -v 4 -t tcp
> +fsx_v40_ip4t fsx.sh -v 4.0 -t tcp
>  fsx_v41_ip4t fsx.sh -v 4.1 -t tcp
>  fsx_v42_ip4t fsx.sh -v 4.2 -t tcp
>  fsx_v30_ip6u fsx.sh -6 -v 3 -t udp
>  fsx_v30_ip6t fsx.sh -6 -v 3 -t tcp
> -fsx_v40_ip6t fsx.sh -6 -v 4 -t tcp
> +fsx_v40_ip6t fsx.sh -6 -v 4.0 -t tcp
>  fsx_v41_ip6t fsx.sh -6 -v 4.1 -t tcp
>  fsx_v42_ip6t fsx.sh -6 -v 4.2 -t tcp

