Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1B620B166
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgFZMb5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 08:31:57 -0400
Received: from exchange.tu-berlin.de ([130.149.7.70]:3173 "EHLO
        exchange.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgFZMb4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 08:31:56 -0400
Received: from SPMA-03.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 9139D6DBFB_EF5EABAB;
        Fri, 26 Jun 2020 12:31:54 +0000 (GMT)
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by SPMA-03.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id 2E6D96D087_EF5EABAF;
        Fri, 26 Jun 2020 12:31:54 +0000 (GMT)
Received: from ex-01.tubit.win.tu-berlin.de (130.149.7.70) by
 EX-CAS-01.tubit.win.tu-berlin.de (130.149.6.141) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 26 Jun 2020 14:31:53 +0200
Received: from ex-02.tubit.win.tu-berlin.de (172.26.35.185) by
 ex-01.tubit.win.tu-berlin.de (172.26.35.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.529.5;
 Fri, 26 Jun 2020 14:31:53 +0200
Received: from ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) by
 ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) with mapi id 15.02.0529.008;
 Fri, 26 Jun 2020 14:31:53 +0200
From:   "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Doug Nazar <nazard@nazar.ca>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Strange segmentation violations of rpc.gssd in Debian Buster
Thread-Topic: Strange segmentation violations of rpc.gssd in Debian Buster
Thread-Index: AQHWSxgxwlq3b/mulkebnqBRRSeMOajpu9IAgAEVEpE=
Date:   Fri, 26 Jun 2020 12:31:53 +0000
Message-ID: <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
References: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
 <20200619220434.GB1594@fieldses.org>
 <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>,<1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
In-Reply-To: <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.149.19.173]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-PMWin-Version: 4.0.1, Antivirus-Engine: 3.77.1, Antivirus-Data: 5.76
X-PureMessage: [Scanned]
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-berlin.de; h=from:to:cc:subject:date:message-id:references:in-reply-to:content-type:content-transfer-encoding:mime-version; s=dkim-tub; bh=WfhIWKPOt2tOfv17F+0LcVjyYXCKlZmaAdNnH4qxzkE=; b=kjYi4KTjzg+NsM8WfBdic46YMW3cjrlNJx3qDtdfZyxSnL5FZnIcpVyCSDw8tV1t9bNiaYW3D0TMHag547ZYAIMQwRFsr9rNSF+qIRQauJA93hnlxlF9BFshR/2zqfVg/wQJZyEa3u2uvXplAp+qHiaQHbhkz6kbKT6/AShp5U0=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Doug, Dear Bruce,
FYI, I filed a bug with nfs-common package in Debian Buster:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D963746

Hope this helps to track down the problem further and shed some light on th=
e mysterious segfaults of rpc.gssd.=20

>> A quick google links to https://wiki.debian.org/HowToGetABacktrace.
BTW: Thanks very much for the link. This helped to find the right dbgsym pa=
ckages in order to produce a more readable and hopefully valuable backtrace=
. ;-)

I also passed by a similar and still open issue in the CentOS bug tracker:
https://bugs.centos.org/view.php?id=3D15895


Best and Thanks for your support up to now
Sebastian

___________________
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
From: Doug Nazar <nazard@nazar.ca>
Sent: Thursday, June 25, 2020 23:44
To: Kraus, Sebastian; J. Bruce Fields
Cc: linux-nfs@vger.kernel.org
Subject: Re: Strange segmentation violations of rpc.gssd in Debian Buster

On 2020-06-25 13:43, Kraus, Sebastian wrote:
> [Current thread is 1 (Thread 0x7fb2eaeba700 (LWP 14174))]
> (gdb) bt
> #0  0x000056233fff038e in ?? ()
> #1  0x000056233fff09f8 in ?? ()
> #2  0x000056233fff0b92 in ?? ()
> #3  0x000056233fff13b3 in ?? ()
> #4  0x00007fb2eb8dbfa3 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:486
> #5  0x00007fb2eb80c4cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95
> (gdb) quit
>
>
> I am not an expert in analyzing stack and backtraces. Is there anything m=
eaningful, you are able to extract from the trace?
> As far as I see, thread 14174 caused the segmentation violation just afte=
r its birth on clone.
> Please correct me, if I am in error.
> Seems Debian Buster does not ship any dedicated package with debug symbol=
s for the rpc.gssd executable.
> So far, I was not able to find such a package.
> What's your opinon about the trace?

You'll need to install the debug symbols for your distribution/package.
A quick google links to https://wiki.debian.org/HowToGetABacktrace.
Those ?? lines should then be replaced with function, file & line numbers.

I've been following this with interest since it used to happen to me a
lot. It hasn't recently, even though every so often I spend a few hours
trying to re-create it to try debug it.

Doug=
