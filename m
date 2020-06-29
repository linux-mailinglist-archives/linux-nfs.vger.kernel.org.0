Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472ED20D1EF
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 20:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgF2SpL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 14:45:11 -0400
Received: from exchange.tu-berlin.de ([130.149.7.70]:61311 "EHLO
        exchange.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgF2So4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 14:44:56 -0400
Received: from SPMA-02.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 0268535BF1_EF97E7DB;
        Mon, 29 Jun 2020 05:39:09 +0000 (GMT)
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by SPMA-02.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id B5F3132F9A_EF97E7CF;
        Mon, 29 Jun 2020 05:39:08 +0000 (GMT)
Received: from ex-06.tubit.win.tu-berlin.de (172.26.35.189) by
 EX-MBX06.tubit.win.tu-berlin.de (172.26.35.176) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 29 Jun 2020 07:39:08 +0200
Received: from ex-02.tubit.win.tu-berlin.de (172.26.35.185) by
 ex-06.tubit.win.tu-berlin.de (172.26.35.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.529.5;
 Mon, 29 Jun 2020 07:39:08 +0200
Received: from ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) by
 ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) with mapi id 15.02.0529.008;
 Mon, 29 Jun 2020 07:39:08 +0200
From:   "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
To:     Doug Nazar <nazard@nazar.ca>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in
 Debian Buster
Thread-Topic: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in
 Debian Buster
Thread-Index: AQHWSxgxwlq3b/mulkebnqBRRSeMOajpu9IAgAEVEpGAADSGAIAAJ84AgAAINwCAAA0egIAAB7GAgAPJdTE=
Date:   Mon, 29 Jun 2020 05:39:08 +0000
Message-ID: <6cf63c80f285495d8328c5c8b55fc9d6@tu-berlin.de>
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
 <20200626210243.GD11850@fieldses.org>,<bebca60d-09e4-f118-c195-c6245e6496fb@nazar.ca>
In-Reply-To: <bebca60d-09e4-f118-c195-c6245e6496fb@nazar.ca>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-berlin.de; h=from:to:cc:subject:date:message-id:references:in-reply-to:content-type:content-transfer-encoding:mime-version; s=dkim-tub; bh=GVMiFtejPA79Hmicr5O0oY1wKdVcVg6X7g2fCsSE0cY=; b=EUtOG8UrhUi54milgWojWniEBkSo9s/93JT0jXAmrjQwdNq5oCiE+F7qEOfo4dyNc4KQUlbtGMro8OmvVdB1CJ3U2mRDGq2knlvbduBFYKJzAo/B7h7WRHqTZekndM5uPrx9M8lyPe93mb3KqtD/tIuT1Tccr3GIKC7s/hB4fjI=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Doug,
thanks very much for your patch and efforts.
I manually backported the patch to nfs-utils 1.3.4-2.5 source in Debian Bus=
ter.
I am now testing the modified build on one of my NFSv4 file servers. Looks =
promising.

One additional question: Which nfs-utils branch are your working on - steve=
d/nfs-utils.git ?

Best Sebastian

__________________
Sebastian Kraus
Team IT am Institut f=FCr Chemie
Geb=E4ude C, Stra=DFe des 17. Juni 115, Raum C7

Technische Universit=E4t Berlin
Fakult=E4t II
Institut f=FCr Chemie
Sekretariat C3
Stra=DFe des 17. Juni 135
10623 Berlin

Email: sebastian.kraus@tu-berlin.de

________________________________________
From: linux-nfs-owner@vger.kernel.org <linux-nfs-owner@vger.kernel.org> on =
behalf of Doug Nazar <nazard@nazar.ca>
Sent: Friday, June 26, 2020 23:30
To: J. Bruce Fields
Cc: Kraus, Sebastian; linux-nfs@vger.kernel.org; Steve Dickson; Olga Kornie=
vskaia
Subject: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in Debi=
an Buster

On 2020-06-26 17:02, J. Bruce Fields wrote:
> Unless I'm missing something--an upcall thread could still be using this
> file descriptor.
>
> If we're particularly unlucky, we could do a new open in a moment and
> reuse this file descriptor number, and then then writes in do_downcall()
> could end up going to some other random file.
>
> I think we want these closes done by gssd_free_client() in the !refcnt
> case?

Makes sense. I was thinking more that it was an abort situation and we
shouldn't be sending any data to the kernel but re-use is definitely a
concern.

I've split it so that we are removed from the event loop in destroy()
but the close happens in free().

Doug=
