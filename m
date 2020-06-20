Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6B0202360
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2020 13:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgFTLgL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Jun 2020 07:36:11 -0400
Received: from exchange.tu-berlin.de ([130.149.7.70]:40440 "EHLO
        exchange.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgFTLgK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Jun 2020 07:36:10 -0400
Received: from SPMA-01.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 08EB07DE560_EEDF4A1B;
        Sat, 20 Jun 2020 11:36:01 +0000 (GMT)
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by SPMA-01.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id 610247DB485_EEDF4A0F;
        Sat, 20 Jun 2020 11:36:00 +0000 (GMT)
Received: from ex-06.tubit.win.tu-berlin.de (172.26.35.189) by
 EX-MBX-01.tubit.win.tu-berlin.de (172.26.35.171) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Sat, 20 Jun 2020 13:36:00 +0200
Received: from ex-02.tubit.win.tu-berlin.de (172.26.26.142) by
 ex-06.tubit.win.tu-berlin.de (172.26.26.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.529.5;
 Sat, 20 Jun 2020 13:35:57 +0200
Received: from ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) by
 ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) with mapi id 15.02.0529.008;
 Sat, 20 Jun 2020 13:35:57 +0200
From:   "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: RPC Pipefs: Frequent parsing errors in client database
Thread-Topic: RPC Pipefs: Frequent parsing errors in client database
Thread-Index: AQHWRn23CLxtUY9z/kmxDmLD+JX3bKjgXLgAgADETmM=
Date:   Sat, 20 Jun 2020 11:35:56 +0000
Message-ID: <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
References: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>,<20200619220434.GB1594@fieldses.org>
In-Reply-To: <20200619220434.GB1594@fieldses.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [91.66.66.182]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-PMWin-Version: 4.0.1, Antivirus-Engine: 3.77.1, Antivirus-Data: 5.75
X-PureMessage: [Scanned]
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-berlin.de; h=from:to:cc:subject:date:message-id:references:in-reply-to:content-type:content-transfer-encoding:mime-version; s=dkim-tub; bh=D+Gz/oIyLQpMFxwEAkNlYQC0GyDF01K+CPkpI2DWwu0=; b=IZztG9Uqj3fOTXgAsTjEYyIFNY9SHVp/cTlzuUHphA4gK9JZ5gKLdxHDxsYBKe0h8Z+MMzwXWk+Xjmhbyp8eU1da1vUhc4JagoL0/Thcx1RpUjJbZRxJqvk4sBj7qdfac8YlUYhRTMEzHGRN6+Cy+sr5ld+zFIX4X2yPGisfMTo=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,
OK, here the somehow longer story 8-O:

I am maintaining virtualized several NFS server instances running on VMware=
 ESXi hypervisor. The operating system is Debian Stretch/Buster.
Most of the time, the NFS servers are nearly idling and there is only moder=
ate CPU load during rush hours. So, servers far from being overloaded.

Anyway, more than a year ago, the rpc.gssd daemon started getting unstable =
in production use.
The daemon provokes segmentations violations, serveral times a day and on a=
n irregular basis. Unfortunately without any obvious reason. :-(

The observed violations look like this:
Jun 11 21:52:08 all kernel: rpc.gssd[12043]: segfault at 0 ip 000056065d50e=
38e sp 00007fde27ffe880 error 4 in rpc.gssd[56065d50b000+9000]
or that:
Mar 17 10:32:10 all kernel: rpc.gssd[25793]: segfault at ffffffffffffffc0 i=
p 00007ffa61f246e4 sp 00007ffa6145f0f8 error 5 in libc-2.24.so[7ffa61ea4000=
+195000]

In order to manage the problem in a quick and dirty way, I activated automa=
tic restart of the rpc-gssd.service unit for "on-fail" reasons.


Several monthes ago, I decided to investigate the problem further by launch=
ing rpc.svcgssd and rpc.gssd daemons with enhanced debug level from their s=
ervice units.
Sadly, this didn't help me to get any clue of the root cause of these stran=
ge segmentations violations.

Some of my colleagues urged me to migrate the server instances from Debian =
Stretch (current oldstable) to Debian Buster (current stable).=20
They argued, rpc.gssd's crashes possibly being rooted in NFS stack instabil=
ities. And about three weeks ago, I upgraded two of my server instances.
Unexpectedly, not only the problem did not disappear, but moreover frequenc=
y of the segmentation violations increased slightly.

Debian Stretch ships with nfs-common v1.3.4-2.1 and Buster with nfs-common =
v1.3.4-2.5 . So, both based the same nfs-common point release.


In consequence, about a week ago, I decided to investigate the problem in a=
 deep manner by stracing the rpc.gssd daemon while running.
Since then, the segementation violations were gone, but now lots of complai=
nts of the following type appear in the system log:

 Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: can't open nfsd4_cb/clnt3bb/in=
fo: No such file or directory
 Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: failed to parse nfsd4_cb/clnt3=
bb/info


This behaviour seems somehow strange to me.
But, one possible explanation could be: The execution speed of rpc.gssd slo=
ws down while being straced and the "true" reason for the segmentation viol=
ations pops up.
I would argue, rpc.gssd trying to parse non-existing files points anyway to=
 an insane and defective behaviour of the RPC GSS user space daemon impleme=
ntation.


Best and a nice weekend
Sebastian


Sebastian Kraus
Team IT am Institut f=FCr Chemie
Geb=E4ude C, Stra=DFe des 17. Juni 115, Raum C7

Technische Universit=E4t Berlin
Fakult=E4t II
Institut f=FCr Chemie
Sekretariat C3
Stra=DFe des 17. Juni 135
10623 Berlin

________________________________________
From: J. Bruce Fields <bfields@fieldses.org>
Sent: Saturday, June 20, 2020 00:04
To: Kraus, Sebastian
Cc: linux-nfs@vger.kernel.org
Subject: Re: RPC Pipefs: Frequent parsing errors in client database

On Fri, Jun 19, 2020 at 09:24:27PM +0000, Kraus, Sebastian wrote:
> Hi all,
> since several weeks, I am seeing, on a regular basis, errors like the fol=
lowing in the system log of one of my NFSv4 file servers:
>
> Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: can't open nfsd4_cb/clnt3bb/i=
nfo: No such file or directory
> Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: failed to parse nfsd4_cb/clnt=
3bb/info

I'm not sure what exactly is happening.

Are the log messages the only problem you're seeing, or is there some
other problem?

--b.

>
> Looks like premature closing of client connections.
> The security flavor of the NFS export is set to krb5p (integrity+privacy)=
.
>
> Anyone a hint how to efficiently track down the problem?
>
>
> Best and thanks
> Sebastian
>
>
> Sebastian Kraus
> Team IT am Institut f=FCr Chemie
> Geb=E4ude C, Stra=DFe des 17. Juni 115, Raum C7
>
> Technische Universit=E4t Berlin
> Fakult=E4t II
> Institut f=FCr Chemie
> Sekretariat C3
> Stra=DFe des 17. Juni 135
> 10623 Berlin
