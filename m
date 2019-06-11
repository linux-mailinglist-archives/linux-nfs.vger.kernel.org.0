Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3BD418D3
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 01:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405301AbfFKXWI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 19:22:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:34064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404851AbfFKXWI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 19:22:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0ADA9AD14;
        Tue, 11 Jun 2019 23:22:07 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Tom Talpey <tom@talpey.com>, Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 12 Jun 2019 09:21:59 +1000
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <ac631f3c-af1a-6877-08b6-21ddf71edff2@talpey.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com> <87muj3tuuk.fsf@notabene.neil.brown.name> <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com> <87lfy9vsgf.fsf@notabene.neil.brown.name> <3B887552-91FB-493A-8FDF-411562811B36@oracle.com> <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com> <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com> <CAN-5tyHQz4kyGqAea3hTW0GKRBtkkB5UeE6THz-7uMmadJygyg@mail.gmail.com> <ac631f3c-af1a-6877-08b6-21ddf71edff2@talpey.com>
Message-ID: <87a7enwvvs.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Jun 11 2019, Tom Talpey wrote:
>
> I really hope nconnect is not just a workaround for some undiscovered
> performance issue. All that does is kick the can down the road.

This is one of my fears too.

My current perspective is to ask
  "What do hardware designers optimise for".
because the speeds we are looking at really require various bits of
hardware to be working together harmoniously.

In context, that question becomes "Do they optimise for single
connection throughput, or multiple connection throughput".

Given the amount of money in web-services, I think multiple connection
throughput is most likely to provide dollars.
I also think that is would be a lot easier to parallelise than single
connection.

So if we NFS developers want to work with the strengths of the hardware,
I think multiple connections and increased parallelism is a sensible
long-term strategy.

So while I cannot rule out any undiscovered performance issue, I don't
think this is just kicking the can down the road.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl0AN5gACgkQOeye3VZi
gbmWnA/+Oj1vdihJl6YaNH71dxfe8XGD9I3gAEgBdJvkIyc5+7N1aRk+2CVegCBw
JQ+w8vApq6eEM0Wu4SUAir+jHEjL4ogtth97rSn7KyXeKl1AyhYjv3WqndW46cyI
jcPNlpjaZuxp8z6AGhjvkfu9ndUMO/Q2zQZDsQsrBKyH1GIs6FBjpgfdBXodJKl+
dRHVAhIvEWdpRuzi/FpHmRTuX/B9MtDdxBBXMa6DWve7hGIshshO3FIdvm6G2Jui
u84fjxBF2w99CzPndSD8FEZguL8ZBHMIGyF1DHKpBgq+s7u11IqWPqeHaSk5h5Dg
/wc58oj3lCKmAR2hzyFIq3tavwAGPjKVh9oV/pJR4SagGrFk3btdnPm9ORz78nMi
64BCZQYq+UMdPDqSjzf3aA+vlTPweCc28ZQLZ+rGf70UN5Ag00GtRtPXZzWyVdFm
w0MmP2Yrq+eKEs4frmWzcTeyufSwKHiWkveiAKTsO0HTDonXKv5glcj3Q/vuIhE2
UExOV11R/ePVe0jJXxaLuti7254s8DgQimITc0D8MMp6h8kktzD+76Q6ZZZ++ysM
bkv28yQyVoCkjyvHLHFVV2rSR9hzD57HRSUALSbMTMKk5myxHUCbVu7KLUA4Y2Pj
tVoWuVV85O3Wa5aGO1CZucpGlBKGYGrxbnWoyggFreYZvqrvzKA=
=Q143
-----END PGP SIGNATURE-----
--=-=-=--
