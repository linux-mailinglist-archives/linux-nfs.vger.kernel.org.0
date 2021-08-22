Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B22C3F3D51
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Aug 2021 05:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhHVDmo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Aug 2021 23:42:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59018 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhHVDmo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Aug 2021 23:42:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA68621DD8;
        Sun, 22 Aug 2021 03:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629603722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XG2AyPNGwJV8RZ9n0yQcVUs4JWGQYETAGhS3HKtdOIA=;
        b=VQ3XeiI8ETuUdcTRz7Xa/JWzyG+D9XS3M4KnP1YMjBe0MIjsHHg4xh86IfGaLR+mBwEbb3
        GijGBUmIUvTF+A3S4GU0+vI8Lu8WA4H2c+hlP0xMByq8MAsIcRjWxE+LC4QQqCaZlm+Uax
        jEbdu9pmvPJpRK5kq9r0XuRgmezAGU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629603722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XG2AyPNGwJV8RZ9n0yQcVUs4JWGQYETAGhS3HKtdOIA=;
        b=kKNgVzF4qXK1QB7vfx4RVh7yA3JvmPOE3s198FeWce1zRPqnHnE6724gDsojU23/l1ZTpQ
        dpfRNZbxRoGoOeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8A7013B02;
        Sun, 22 Aug 2021 03:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2iMnHYnHIWF6LwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 22 Aug 2021 03:42:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>,
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>,
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>,
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>,
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>,
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>,
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>,
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>,
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>,
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>,
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com>,
 <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>,
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>,
 <162941948235.9892.6790956894845282568@noble.neil.brown.name>,
 <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>,
 <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>
Date:   Sun, 22 Aug 2021 13:41:58 +1000
Message-id: <162960371884.9892.13803244995043191094@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 22 Aug 2021, Mike Javorski wrote:
> OK, so new/fresh captures, reading the same set of files via NFS in
> roughly the same timing/sequence (client unchanged between runs)
>=20
> 5.12.15-arch1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 0.042320 124082
> 0.042594 45837
> 0.043176 19598
> 0.044092 63667
> 0.044613 28192
> 0.045045 131268
> 0.045982 116572
> 0.058507 162444
> 0.369620 153520
> 0.825167 164682
>=20
> 5.13.12-arch1: (no freezes)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 0.040766 12679
> 0.041565 64532
> 0.041799 55440
> 0.042091 159640
> 0.042105 75075
> 0.042134 177776
> 0.042706 40
> 0.043334 35322
> 0.045480 183618
> 0.204246 83997
>=20
> Since I didn't get any freezes, I waited a bit, tried again and got a
> capture with several freezes...
>=20
> 5.13.12-arch1: (with freezes)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 0.042143 55425
> 0.042252 64787
> 0.042411 57362
> 0.042441 34461
> 0.042503 67041
> 0.042553 64812
> 0.042592 55179
> 0.042715 67002
> 0.042835 66977
> 0.043308 64849
>=20
> Not sure what to make of this, but to my (admittedly untrainted) eye,
> the two 5.13.12 sets are very similar to each other as well as to the
> 5.12.15 sample, I am not sure if this is giving any indication to what
> is causing the freezes.

In the trace that I have, most times (242 of 245) were 0.000360 or less.
Only 3 were greater.
As your traces are much bigger you naturally have more that are great -
all of the last 10 and probably more.

I has hoping that 5.12 wouldn't show any large delays, but clearly it
does.  However it is still possible that there are substantially fewer.

Rather than using tail, please pipe the list of times into

 awk '$1 < 0.001 { fast +=3D1 } $1 >=3D 0.001 {slow +=3D 1} END { print fast,=
 slow, slow / (fast + slow) }'

and report the results.  If the final number (the fraction) is reliably
significantly smaller for 5.12 than for 5.13 (whether it freezes or
not), then this metric may still be useful.

By the way, disabling the various offload options didn't appear to make
a different for the other person who has reported this problem.

Thanks,
NeilBrown
