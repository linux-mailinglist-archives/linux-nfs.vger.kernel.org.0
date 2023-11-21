Return-Path: <linux-nfs+bounces-25-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E227F3801
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 22:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B7E1C209F3
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76A3D972;
	Tue, 21 Nov 2023 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nR02JDqX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jm4CLSpi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB74D60
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 13:18:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8CEC1F747;
	Tue, 21 Nov 2023 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700601481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0p8edR0qPDNTRawtXRzCEh06LD+NG1o3gnidNXlV3I=;
	b=nR02JDqXpurBwtAoNTgode/Hf4ZN5Q9Q6y2dL/BM5xRuHVSrzgKZiyIXP0KMycKL++Gjvn
	gTRgLefSASxIONuM2/x+Kdfi0cQkSkWJSOsS4cjaamNL8cRAl+wwQsq0KtypZeCQiXdz5C
	qVt3IX+iOy2cz+OD+QhrOEzeRlowHvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700601481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0p8edR0qPDNTRawtXRzCEh06LD+NG1o3gnidNXlV3I=;
	b=jm4CLSpiTeSr87OZi8dcBAAlX73UCRTkKIZ+I8F4dVs9Obt2+AJICBVcAlDpZZophCvy0i
	J8+lQ8kIKlusL5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4270138E3;
	Tue, 21 Nov 2023 21:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ehbIGYgeXWX0MQAAMHmgww
	(envelope-from <neilb@suse.de>); Tue, 21 Nov 2023 21:18:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Ahelenia =?utf-8?q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-nfs@vger.kernel.org, "Steve Dickson" <steved@redhat.com>
Subject: Re: [PATCH nfs-utils v2 1/2] fsidd: call anonymous sockets by their
 name only, don't fill with NULs to 108 bytes
In-reply-to: =?utf-8?q?=3Cb38ecca96762d939d377c381bf34521ee5945129=2E1700601?=
 =?utf-8?q?199=2Egit=2Enabijaczleweli=40nabijaczleweli=2Exyz=3E?=
References: =?utf-8?q?=3Cb38ecca96762d939d377c381bf34521ee5945129=2E17006011?=
 =?utf-8?q?99=2Egit=2Enabijaczleweli=40nabijaczleweli=2Exyz=3E?=
Date: Wed, 22 Nov 2023 08:17:57 +1100
Message-id: <170060147759.7109.11557451478268988487@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.27
X-Spamd-Result: default: False [-4.27 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 CLAM_VIRUS_FAIL(0.00)[failed to scan and retransmits exceed];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.17)[-0.859];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, 22 Nov 2023, Ahelenia Ziemia=C5=84ska wrote:
> Since e00ab3c0616fe6d83ab0710d9e7d989c299088f7, ss -l looks like this:
>   u_seq               LISTEN                0                     5        =
                            @/run/fsid.sock@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 26989379         =
                                              * 0
> with fsidd pushing all the addresses to 108 bytes wide, which is deeply
> egregious if you don't filter it out and recolumnate.
>=20
> This is because, naturally (unix(7)), "Null bytes in the name have
> no special significance": abstract addresses are binary blobs, but
> paths automatically terminate at the first NUL byte, since paths
> can't contain those.
>=20
> So just specify the correct address length when we're using the abstract do=
main:
> unix(7) recommends "offsetof(struct sockaddr_un, sun_path) + strlen(sun_pat=
h) + 1"
> for paths, but we don't want to include the terminating NUL, so it's just
> "offsetof(struct sockaddr_un, sun_path) + strlen(sun_path)".
> This brings the width back to order:
> -- >8 --
> $ ss -la | grep @
> u_str ESTAB     0      0      @45208536ec96909a/bus/systemd-timesyn/bus-api=
-timesync 18500238                            * 18501249
> u_str ESTAB     0      0       @fecc9657d2315eb7/bus/systemd-network/bus-ap=
i-network 18495452                            * 18494406
> u_seq LISTEN    0      5                                             @/run/=
fsid.sock 27168796                            * 0
> u_str ESTAB     0      0                 @ac308f35f50797a2/bus/systemd-logi=
nd/system 19406                               * 15153
> u_str ESTAB     0      0                @b6606e0dfacbae75/bus/systemd/bus-a=
pi-system 18494353                            * 18495334
> u_str ESTAB     0      0                    @5880653d215718a7/bus/systemd/b=
us-system 26930876                            * 26930003
> -- >8 --
>=20
> Fixes: e00ab3c0616fe6d83ab0710d9e7d989c299088f7 ("fsidd: provide
>  better default socket name.")
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> v1: <04f3fe71defa757d518468f04f08334a5d0dfbb9.1693754442.git.nabijaczleweli=
@nabijaczleweli.xyz>
> v2 NFC, addr_len declared at top of function
>=20
>  support/reexport/fsidd.c    | 9 ++++++---
>  support/reexport/reexport.c | 8 ++++++--
>  2 files changed, 12 insertions(+), 5 deletions(-)


Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


>=20
> diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
> index 3e62b3fc..8a70b78f 100644
> --- a/support/reexport/fsidd.c
> +++ b/support/reexport/fsidd.c
> @@ -147,6 +147,7 @@ int main(void)
>  {
>  	struct event *srv_ev;
>  	struct sockaddr_un addr;
> +	socklen_t addr_len;
>  	char *sock_file;
>  	int srv;
> =20
> @@ -161,10 +162,12 @@ int main(void)
>  	memset(&addr, 0, sizeof(struct sockaddr_un));
>  	addr.sun_family =3D AF_UNIX;
>  	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
> -	if (addr.sun_path[0] =3D=3D '@')
> +	addr_len =3D sizeof(struct sockaddr_un);
> +	if (addr.sun_path[0] =3D=3D '@') {
>  		/* "abstract" socket namespace */
> +		addr_len =3D offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_pa=
th);
>  		addr.sun_path[0] =3D 0;
> -	else
> +	} else
>  		unlink(sock_file);
> =20
>  	srv =3D socket(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0);
> @@ -173,7 +176,7 @@ int main(void)
>  		return 1;
>  	}
> =20
> -	if (bind(srv, (const struct sockaddr *)&addr, sizeof(struct sockaddr_un))=
 =3D=3D -1) {
> +	if (bind(srv, (const struct sockaddr *)&addr, addr_len) =3D=3D -1) {
>  		xlog(L_WARNING, "Unable to bind %s: %m\n", sock_file);
>  		return 1;
>  	}
> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
> index 78516586..0fb49a46 100644
> --- a/support/reexport/reexport.c
> +++ b/support/reexport/reexport.c
> @@ -21,6 +21,7 @@ static int fsidd_srv =3D -1;
>  static bool connect_fsid_service(void)
>  {
>  	struct sockaddr_un addr;
> +	socklen_t addr_len;
>  	char *sock_file;
>  	int ret;
>  	int s;
> @@ -33,9 +34,12 @@ static bool connect_fsid_service(void)
>  	memset(&addr, 0, sizeof(struct sockaddr_un));
>  	addr.sun_family =3D AF_UNIX;
>  	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
> -	if (addr.sun_path[0] =3D=3D '@')
> +	addr_len =3D sizeof(struct sockaddr_un);
> +	if (addr.sun_path[0] =3D=3D '@') {
>  		/* "abstract" socket namespace */
> +		addr_len =3D offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_pa=
th);
>  		addr.sun_path[0] =3D 0;
> +	}
> =20
>  	s =3D socket(AF_UNIX, SOCK_SEQPACKET, 0);
>  	if (s =3D=3D -1) {
> @@ -43,7 +47,7 @@ static bool connect_fsid_service(void)
>  		return false;
>  	}
> =20
> -	ret =3D connect(s, (const struct sockaddr *)&addr, sizeof(struct sockaddr=
_un));
> +	ret =3D connect(s, (const struct sockaddr *)&addr, addr_len);
>  	if (ret =3D=3D -1) {
>  		xlog(L_WARNING, "Unable to connect %s: %m, is fsidd running?\n", sock_fi=
le);
>  		return false;
> --=20
> 2.39.2
>=20
>=20


