Return-Path: <linux-nfs+bounces-20-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAFC7F36FD
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 20:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB57C282610
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68F042040;
	Tue, 21 Nov 2023 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W95RzzQB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A3919B
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 11:58:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40842752c6eso28935425e9.1
        for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 11:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700596727; x=1701201527; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5O6IyjwQ6tDFoUe9ncZX5gyGu7dxoekurLBVZVo18M=;
        b=W95RzzQBoEU9Ri9lrpaeAsJayOIVSB46U2epGCljHQExATwYydWrxUVPXEZ1WubE9r
         GqPyOVWlQ+wy5K5KrHGjCfiFLueKGr2EGbvwvD4R3LKZUicHN7qR8o2nVQX7/b5RN7DG
         eIbKaX8BAwZU2dG21ZY/KXks7bLjuYHt7psWLa6Vg5y3OnpZyWu4YULBckYE27zkYODt
         KD0d1FMeeOu7kfX9mcNPhlyd/5DzCxzJa4AimGQBr5AuSRgoiWVbjsWThPXAiSl1urtX
         1b7tfsTodn23iF9Cg71hunDg71orQF6DBBmF/ZeOmyRgjmYOtqb5+ozt2QIZHEMm9+NS
         hxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596727; x=1701201527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5O6IyjwQ6tDFoUe9ncZX5gyGu7dxoekurLBVZVo18M=;
        b=qZNbeq5DN2VQYN7YAkPOzQhdwKXvR2vsiUOP4tE3s/Ge9S018EwJn/Rr1biXjqJoXe
         PQqMK1PKT8L2jEW5dwNbDWu+NF4tedW6OftB8rvqn6NyUToHoReatZMkM4UJ01q69bd0
         +BFMzF+mxkkbJ5jX/Jco2UPPUPgvN7EXLjoHLsWdAz7fSm+Ja06Y7ogw0P/o6SMB7zHJ
         lgIu+bvw7hnDO08ZzGSncX6Q58oAqZEMdRJ6YjpsI53rpQ/olL7q1GicEdrDky5kZSfn
         P/k8ClkqyWNTAyz7AwTWr8lRuZllCbot8W9Ziasr6veB2Bh/3m+/+dgOqFCjzlAFM1IK
         mKXw==
X-Gm-Message-State: AOJu0YxooAS2Ln/5r4ljuo5fEuRLkkj5MlT0GBp4w77K1Euj+0ZLJRk+
	GkFCKjhjr9Scz/KCVUnB2IoJyXNhSr3C7g==
X-Google-Smtp-Source: AGHT+IHsF9saWQ4v4iggMAHs2K14vr3abFn+WoeEmdCwWItzTbvRa8nxYBjwsyLxJY9v1hY84EZRcw==
X-Received: by 2002:adf:fe88:0:b0:332:d152:5e63 with SMTP id l8-20020adffe88000000b00332d1525e63mr39891wrr.21.1700596726993;
        Tue, 21 Nov 2023 11:58:46 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d49c8000000b0031984b370f2sm15270365wrs.47.2023.11.21.11.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 11:58:46 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 969F6BE2DE0; Tue, 21 Nov 2023 20:58:45 +0100 (CET)
Date: Tue, 21 Nov 2023 20:58:45 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: NeilBrown <neilb@suse.de>, Richard Weinberger <richard@nod.at>,
	Steve Dickson <steved@redhat.com>
Cc: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH nfs-utils 1/2] fsidd: call anonymous sockets by their
 name only, don't fill with NULs to 108 bytes
Message-ID: <ZV0L9Y5bRxfWPRus@eldamar.lan>
References: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczleweli@nabijaczleweli.xyz>

Hi,

Explicitly CC'ing people involved for the e00ab3c0616f ("fsidd:
provide better default socket name.") change:

On Sun, Sep 03, 2023 at 05:21:52PM +0200, Ahelenia Ziemiańska wrote:
> Since e00ab3c0616fe6d83ab0710d9e7d989c299088f7, ss -l looks like this:
>   u_seq               LISTEN                0                     5                                    @/run/fsid.sock@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 26989379                                                       * 0
> with fsidd pushing all the addresses to 108 bytes wide, which is deeply
> egregious if you don't filter it out and recolumnate.
> 
> This is because, naturally (unix(7)), "Null bytes in the name have
> no special significance": abstract addresses are binary blobs, but
> paths automatically terminate at the first NUL byte, since paths
> can't contain those.
> 
> So just specify the correct address length when we're using the abstract domain:
> unix(7) recommends "offsetof(struct sockaddr_un, sun_path) + strlen(sun_path) + 1"
> for paths, but we don't want to include the terminating NUL, so it's just
> "offsetof(struct sockaddr_un, sun_path) + strlen(sun_path)".
> This brings the width back to order:
> -- >8 --
> $ ss -la | grep @
> u_str ESTAB     0      0      @45208536ec96909a/bus/systemd-timesyn/bus-api-timesync 18500238                            * 18501249
> u_str ESTAB     0      0       @fecc9657d2315eb7/bus/systemd-network/bus-api-network 18495452                            * 18494406
> u_seq LISTEN    0      5                                             @/run/fsid.sock 27168796                            * 0
> u_str ESTAB     0      0                 @ac308f35f50797a2/bus/systemd-logind/system 19406                               * 15153
> u_str ESTAB     0      0                @b6606e0dfacbae75/bus/systemd/bus-api-system 18494353                            * 18495334
> u_str ESTAB     0      0                    @5880653d215718a7/bus/systemd/bus-system 26930876                            * 26930003
> -- >8 --
> 
> Fixes: e00ab3c0616fe6d83ab0710d9e7d989c299088f7 ("fsidd: provide
>  better default socket name.")
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
>  support/reexport/fsidd.c    | 8 +++++---
>  support/reexport/reexport.c | 7 +++++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
> index d4b245e8..4c377415 100644
> --- a/support/reexport/fsidd.c
> +++ b/support/reexport/fsidd.c
> @@ -171,10 +171,12 @@ int main(void)
>  	memset(&addr, 0, sizeof(struct sockaddr_un));
>  	addr.sun_family = AF_UNIX;
>  	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
> -	if (addr.sun_path[0] == '@')
> +	socklen_t addr_len = sizeof(struct sockaddr_un);
> +	if (addr.sun_path[0] == '@') {
>  		/* "abstract" socket namespace */
> +		addr_len = offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_path);
>  		addr.sun_path[0] = 0;
> -	else
> +	} else
>  		unlink(sock_file);
>  
>  	srv = socket(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0);
> @@ -183,7 +185,7 @@ int main(void)
>  		return 1;
>  	}
>  
> -	if (bind(srv, (const struct sockaddr *)&addr, sizeof(struct sockaddr_un)) == -1) {
> +	if (bind(srv, (const struct sockaddr *)&addr, addr_len) == -1) {
>  		xlog(L_WARNING, "Unable to bind %s: %m\n", sock_file);
>  		return 1;
>  	}
> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
> index d9a700af..b7ee6f46 100644
> --- a/support/reexport/reexport.c
> +++ b/support/reexport/reexport.c
> @@ -40,9 +40,12 @@ static bool connect_fsid_service(void)
>  	memset(&addr, 0, sizeof(struct sockaddr_un));
>  	addr.sun_family = AF_UNIX;
>  	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
> -	if (addr.sun_path[0] == '@')
> +	socklen_t addr_len = sizeof(struct sockaddr_un);
> +	if (addr.sun_path[0] == '@') {
>  		/* "abstract" socket namespace */
> +		addr_len = offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_path);
>  		addr.sun_path[0] = 0;
> +	}
>  
>  	s = socket(AF_UNIX, SOCK_SEQPACKET, 0);
>  	if (s == -1) {
> @@ -50,7 +53,7 @@ static bool connect_fsid_service(void)
>  		return false;
>  	}
>  
> -	ret = connect(s, (const struct sockaddr *)&addr, sizeof(struct sockaddr_un));
> +	ret = connect(s, (const struct sockaddr *)&addr, addr_len);
>  	if (ret == -1) {
>  		xlog(L_WARNING, "Unable to connect %s: %m, is fsidd running?\n", sock_file);
>  		return false;
> -- 
> 2.40.1

Did this one felt trough the cracks?

Regards,
Salvatore

