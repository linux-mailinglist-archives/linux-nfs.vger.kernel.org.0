Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D097201D1E
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2020 23:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgFSVeH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Jun 2020 17:34:07 -0400
Received: from exchange.tu-berlin.de ([130.149.7.70]:25387 "EHLO
        exchange.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFSVeG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Jun 2020 17:34:06 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2020 17:34:05 EDT
Received: from SPMA-01.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 49EF17E07BD_EED2D0CB
        for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2020 21:24:28 +0000 (GMT)
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by SPMA-01.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id 177C97DB193_EED2D0CF
        for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2020 21:24:28 +0000 (GMT)
Received: from ex-02.tubit.win.tu-berlin.de (172.26.35.185) by
 ex-mbx-10.tubit.win.tu-berlin.de (172.26.35.180) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 19 Jun 2020 23:24:27 +0200
Received: from ex-02.tubit.win.tu-berlin.de (172.26.35.185) by
 ex-02.tubit.win.tu-berlin.de (172.26.35.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.529.5;
 Fri, 19 Jun 2020 23:24:27 +0200
Received: from ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) by
 ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) with mapi id 15.02.0529.008;
 Fri, 19 Jun 2020 23:24:27 +0200
From:   "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RPC Pipefs: Frequent parsing errors in client database
Thread-Topic: RPC Pipefs: Frequent parsing errors in client database
Thread-Index: AQHWRn23CLxtUY9z/kmxDmLD+JX3bA==
Date:   Fri, 19 Jun 2020 21:24:27 +0000
Message-ID: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.149.19.173]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-PMWin-Version: 4.0.1, Antivirus-Engine: 3.77.1, Antivirus-Data: 5.75
X-PureMessage: [Scanned]
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-berlin.de; h=from:to:subject:date:message-id:content-type:content-transfer-encoding:mime-version; s=dkim-tub; bh=gs1qGbHeL7uS4pE0s4JeY+BbYdLNN1dXVeJPnieZ6Xw=; b=ZPoC0mHSVpgdhJUf8JPEU8vyqoC2QPRlhptDomUoz6ATyKFCid3frg7xFt2chcw3FJgLWJqYoazF9wArS7v53WfxqjXcQy/5fiztq/8HksjiI/cVvp4CA/IPz28f1lucsuZ46w92A43TMMDUK+A0LRzVNamY1cLL8ah2PPLXP3s=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,
since several weeks, I am seeing, on a regular basis, errors like the follo=
wing in the system log of one of my NFSv4 file servers:

Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: can't open nfsd4_cb/clnt3bb/inf=
o: No such file or directory
Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: failed to parse nfsd4_cb/clnt3b=
b/info

Looks like premature closing of client connections.
The security flavor of the NFS export is set to krb5p (integrity+privacy).

Anyone a hint how to efficiently track down the problem?


Best and thanks
Sebastian


Sebastian Kraus
Team IT am Institut f=FCr Chemie
Geb=E4ude C, Stra=DFe des 17. Juni 115, Raum C7

Technische Universit=E4t Berlin
Fakult=E4t II
Institut f=FCr Chemie
Sekretariat C3
Stra=DFe des 17. Juni 135
10623 Berlin=
