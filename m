Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4421052B
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 09:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgGAHjW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 03:39:22 -0400
Received: from exchange.tu-berlin.de ([130.149.7.70]:12603 "EHLO
        exchange.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgGAHjW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 03:39:22 -0400
Received: from SPMA-01.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id D97DD7DEC68_EFC3DA5B;
        Wed,  1 Jul 2020 07:39:17 +0000 (GMT)
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by SPMA-01.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id 6F9AF7DEC63_EFC3DA5F;
        Wed,  1 Jul 2020 07:39:17 +0000 (GMT)
Received: from ex-01.tubit.win.tu-berlin.de (172.26.35.184) by
 ex-mbx-10.tubit.win.tu-berlin.de (172.26.35.180) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Wed, 1 Jul 2020 09:39:17 +0200
Received: from ex-02.tubit.win.tu-berlin.de (172.26.35.185) by
 ex-01.tubit.win.tu-berlin.de (172.26.35.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.529.5;
 Wed, 1 Jul 2020 09:39:15 +0200
Received: from ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) by
 ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) with mapi id 15.02.0529.008;
 Wed, 1 Jul 2020 09:39:14 +0200
From:   "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
To:     Doug Nazar <nazard@nazar.ca>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in
 Debian Buster
Thread-Topic: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in
 Debian Buster
Thread-Index: AQHWSxgxwlq3b/mulkebnqBRRSeMOajpu9IAgAEVEpGAADSGAIAAJ84AgAAINwCAAA0egIAAB7GAgAPJdTGAAHJrgIAC0LGM
Date:   Wed, 1 Jul 2020 07:39:14 +0000
Message-ID: <94422f073b7e4b979931e6d8d3a0c044@tu-berlin.de>
References: <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
 <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
 <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
 <c1c314fd-1855-cf04-3ec5-5f6eb35719a5@nazar.ca>
 <20200626194622.GB11850@fieldses.org>
 <3eb80b1f-e4d3-e87c-aacd-34dc28637948@nazar.ca>
 <20200626210243.GD11850@fieldses.org>
 <bebca60d-09e4-f118-c195-c6245e6496fb@nazar.ca>
 <6cf63c80f285495d8328c5c8b55fc9d6@tu-berlin.de>,<41614030-a616-1ad0-280c-7e24342cd455@nazar.ca>
In-Reply-To: <41614030-a616-1ad0-280c-7e24342cd455@nazar.ca>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [91.64.112.104]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-PMWin-Version: 4.0.1, Antivirus-Engine: 3.77.1, Antivirus-Data: 5.76
X-PureMessage: [Scanned]
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-berlin.de; h=from:to:cc:subject:date:message-id:references:in-reply-to:content-type:content-transfer-encoding:mime-version; s=dkim-tub; bh=M4q1JzEyb50Ult3ew/mYoyxqvYEvxt4mmMxD1ky6r4M=; b=f0cR+J2Xjt1VrwU/t90fas1GZyxKGP7/X/s9hDDsqZ9N+C3uTJVWNeEtB5SCPN/Rj2FJwlc+VZJIfUjRAds14DbsCtsYQ1sybBr77Y+vBNn8w6i3qr/BZ8JSAtTRu4BObIxlwSM5rzH99BLC4QvFGlGqhM5QFKuWgp9ZTAnhfl4=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Doug,

>> Yes, I'm working against upstream. I did check briefly that the code had=
n't changed too much since 1.3.4 in that area.
OK, thanks for the info. I wondered, because your patch did not show up as =
a commit within upstream.=20
Your patch seems to do a good job - no more segfaults since a period of fou=
r days. :-)

>> I've found one other place that has insufficient locking but the race to=
 hit it is fairly small. It's in the Kerberos machine principal cache when =
it refreshes the machine credentials.=20
These type of patches are always welcome. :-)
In the recent past, some of our scientific staff exprienced strange problem=
s with Kerberos authentication against our NFSv4 file servers.=20
Maybe, the outages were in connection with this type of race condition. But=
, I do not know for sure as the authentication errors did happen on a rathe=
r sporadic basis.

>> I have a patch for that, but it's pretty invasive due to some other chan=
ges I'm currently working on. Let me know if you hit it, and I can work on =
a simple version to backport.
NFSv4+Kerberos is not for the faint-hearted. I do not fear of invasive patc=
hes - as long as they are not missing technical correctness. ;-)

A question far apart from this:
How is it about the spread of NFSv4+Kerberos setups within academic communi=
ty and commerical environments?=20
Are there, up to your knowledge, any bigger on-premise or cloud setups out =
there?
And are there any companies running dedicated NFSv4+Kerberos setups?


Best and keep well and fit
Sebastian

_________________
Sebastian Kraus
Team IT am Institut f=FCr Chemie
Geb=E4ude C, Stra=DFe des 17. Juni 115, Raum C7

Technische Universit=E4t Berlin
Fakult=E4t II
Institut f=FCr Chemie
Sekretariat C3
Stra=DFe des 17. Juni 135
10623 Berlin


Tel.: +49 30 314 22263
Fax: +49 30 314 29309
Email: sebastian.kraus@tu-berlin.de

________________________________________
From: Doug Nazar <nazard@nazar.ca>
Sent: Monday, June 29, 2020 16:09
To: Kraus, Sebastian
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in =
Debian Buster

On 2020-06-29 01:39, Kraus, Sebastian wrote:
> Hi Doug,
> thanks very much for your patch and efforts.
> I manually backported the patch to nfs-utils 1.3.4-2.5 source in Debian B=
uster.
> I am now testing the modified build on one of my NFSv4 file servers. Look=
s promising.
>
> One additional question: Which nfs-utils branch are your working on - ste=
ved/nfs-utils.git ?

Yes, I'm working against upstream. I did check briefly that the code
hadn't changed too much since 1.3.4 in that area.

I've found one other place that has insufficient locking but the race to
hit it is fairly small. It's in the Kerberos machine principal cache
when it refreshes the machine credentials. I have a patch for that, but
it's pretty invasive due to some other changes I'm currently working on.
Let me know if you hit it, and I can work on a simple version to backport.

Doug

