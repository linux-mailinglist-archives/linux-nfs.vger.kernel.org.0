Return-Path: <linux-nfs+bounces-26-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418E7F3803
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1885C281096
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 21:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C154645;
	Tue, 21 Nov 2023 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M8Dkj4zR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9C6qz9Ga"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62D519E
	for <linux-nfs@vger.kernel.org>; Tue, 21 Nov 2023 13:19:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 322611F8BF;
	Tue, 21 Nov 2023 21:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700601574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2IfnbMbvU7FAZSdMw3Lmxzj3HEFRHrEUjna2yzdR90=;
	b=M8Dkj4zRvPQqD3iw6bEJ55LJD9K9tjJekoRQBu0PIZ+6zaZt/w61gb1xxdqjEPdD694x1v
	CdLV2IG1K9mIuFfx404KknR21nK0rzLXDjGryI5CoxxQxqwqcgjds/D9wiCdf4UIx7jFz2
	GsV3RPwXJ3WXSEWYI12u3NF26JQar9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700601574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2IfnbMbvU7FAZSdMw3Lmxzj3HEFRHrEUjna2yzdR90=;
	b=9C6qz9GadCiUW/wsxSdOg676hVjk5ezb0YAmJo/gh0FDPVbKosuSvJEOveDxXwbL4dJ6wD
	MEV1R6UTL5m9nYBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7752138E3;
	Tue, 21 Nov 2023 21:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xp3MJeQeXWWWMgAAMHmgww
	(envelope-from <neilb@suse.de>); Tue, 21 Nov 2023 21:19:32 +0000
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
Subject:
 Re: [PATCH nfs-utils v2 2/2] testlk: format off_t as llong instead of ssize_t
In-reply-to: =?utf-8?q?=3C9d2b8bdc146a1fb48b391ae1adda0b6249ba9c5b=2E1700601?=
 =?utf-8?q?199=2Egit=2Enabijaczleweli=40nabijaczleweli=2Exyz=3E?=
References: =?utf-8?q?=3Cb38ecca96762d939d377c381bf34521ee5945129=2E17006011?=
 =?utf-8?q?99=2Egit=2Enabijaczleweli=40nabijaczleweli=2Exyz=3E=2C_=3C9d2b8bd?=
 =?utf-8?q?c146a1fb48b391ae1adda0b6249ba9c5b=2E1700601199=2Egit=2Enabijaczle?=
 =?utf-8?q?weli=40nabijaczleweli=2Exyz=3E?=
Date: Wed, 22 Nov 2023 08:19:29 +1100
Message-id: <170060156974.7109.13325935820432597117@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.26
X-Spamd-Result: default: False [-4.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.16)[-0.816];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, 22 Nov 2023, Ahelenia Ziemia=C5=84ska wrote:
> This, naturally, produces a warning on x32 (and other ILP32 platforms
> with 64-bit off_t, presumably, but you need to ask for it explicitly
> there usually):
> gcc -DHAVE_CONFIG_H -I. -I../../support/include  -D_GNU_SOURCE -Wdate-time =
-D_FORTIFY_SOURCE=3D2 -D_GNU_SOURCE -g -O2 -ffile-prefix-map=3D/tmp/nfs-utils=
-2.6.3=3D. -specs=3D/usr/share/dpkg/pie-compile.specs -fstack-protector-stron=
g -Wformat -Werror=3Dformat-security -g -O2 -ffile-prefix-map=3D/tmp/nfs-util=
s-2.6.3=3D. -specs=3D/usr/share/dpkg/pie-compile.specs -fstack-protector-stro=
ng -Wformat -Werror=3Dformat-security -c -o testlk-testlk.o `test -f 'testlk.=
c' || echo './'`testlk.c
> testlk.c: In function =E2=80=98main=E2=80=99:
> testlk.c:84:66: warning: format =E2=80=98%zd=E2=80=99 expects argument of t=
ype =E2=80=98signed size_t=E2=80=99, but argument 4 has type =E2=80=98__off_t=
=E2=80=99 {aka =E2=80=98long long int=E2=80=99} [-Wformat=3D]
>    84 |                         printf("%s: conflicting lock by %d on (%zd;=
%zd)\n",
>       |                                                                ~~^
>       |                                                                  |
>       |                                                                  int
>       |                                                                %lld
>    85 |                                 fname, fl.l_pid, fl.l_start, fl.l_l=
en);
>       |                                                  ~~~~~~~~~~
>       |                                                    |
>       |                                                    __off_t {aka lon=
g long int}
> testlk.c:84:70: warning: format =E2=80=98%zd=E2=80=99 expects argument of t=
ype =E2=80=98signed size_t=E2=80=99, but argument 5 has type =E2=80=98__off_t=
=E2=80=99 {aka =E2=80=98long long int=E2=80=99} [-Wformat=3D]
>    84 |                         printf("%s: conflicting lock by %d on (%zd;=
%zd)\n",
>       |                                                                    =
~~^
>       |                                                                    =
  |
>       |                                                                    =
  int
>       |                                                                    =
%lld
>    85 |                                 fname, fl.l_pid, fl.l_start, fl.l_l=
en);
>       |                                                              ~~~~~~=
~~
>       |                                                                |
>       |                                                                __of=
f_t {aka long long int}
>=20
> Upcast to long long, doesn't really matter.
>=20
> It does, of course, raise the question of whether other bits of
> nfs-utils do something equally broken that just isn't caught by the
> format validator.
>=20
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> Same as v1: <44adec629186e220ee5d8fd936980ac4a33dc510.1693754442.git.nabija=
czleweli@nabijaczleweli.xyz>
>=20
>  tools/locktest/testlk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/locktest/testlk.c b/tools/locktest/testlk.c
> index ea51f788..c9bd6bac 100644
> --- a/tools/locktest/testlk.c
> +++ b/tools/locktest/testlk.c
> @@ -81,8 +81,8 @@ main(int argc, char **argv)
>  		if (fl.l_type =3D=3D F_UNLCK) {
>  			printf("%s: no conflicting lock\n", fname);
>  		} else {
> -			printf("%s: conflicting lock by %d on (%zd;%zd)\n",
> -				fname, fl.l_pid, fl.l_start, fl.l_len);
> +			printf("%s: conflicting lock by %d on (%lld;%lld)\n",
> +				fname, fl.l_pid, (long long)fl.l_start, (long long)fl.l_len);
>  		}
>  		return 0;
>  	}
> --=20
> 2.39.2
>=20

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


