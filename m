Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859CF212BE1
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2020 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgGBSEQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jul 2020 14:04:16 -0400
Received: from exchange.tu-berlin.de ([130.149.7.70]:32211 "EHLO
        exchange.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGBSEP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jul 2020 14:04:15 -0400
Received: from SPMA-03.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id CB0BD6E66E_EFE219CB;
        Thu,  2 Jul 2020 18:04:12 +0000 (GMT)
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by SPMA-03.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id 9D0B77E9C4_EFE219CF;
        Thu,  2 Jul 2020 18:04:12 +0000 (GMT)
Received: from ex-02.tubit.win.tu-berlin.de (172.26.35.185) by
 EX-MBX-03.tubit.win.tu-berlin.de (172.26.35.173) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 2 Jul 2020 20:04:12 +0200
Received: from ex-02.tubit.win.tu-berlin.de (172.26.35.185) by
 ex-02.tubit.win.tu-berlin.de (172.26.35.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.529.5;
 Thu, 2 Jul 2020 20:04:12 +0200
Received: from ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) by
 ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) with mapi id 15.02.0529.008;
 Thu, 2 Jul 2020 20:04:12 +0200
From:   "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
To:     "samba@lists.samba.org" <samba@lists.samba.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Multiprotocol File Sharing via NFSv4 and Samba
Thread-Topic: Multiprotocol File Sharing via NFSv4 and Samba
Thread-Index: AQHWUJsljlHHqtxhtk+U8aXSrARwfw==
Date:   Thu, 2 Jul 2020 18:04:12 +0000
Message-ID: <3c399c3523674ec7b650b647179d7c96@tu-berlin.de>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-berlin.de; h=from:to:cc:subject:date:message-id:content-type:content-transfer-encoding:mime-version; s=dkim-tub; bh=IPN9FKJUZhqBpoJj3l3kU06nRPkFErUnkVV7/+5Mt4U=; b=YBJBmoRM5xGGIpmk/NzORcW+D49PCkNcjiH9dB1r4PCEYarqbOaHzMMNl5mQU5AIlt+Y2uMcN7RPT28u0cnu3hJwlGfoilfMX26P1s4vWt0G8an734XaTuSv6AfKwOI4ra1F01yBETyJ1POXQsYz4QD4EKl251y35LjugikTSGo=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,
are there any non-commercial solutions (apart from solutions like Dell EMC,=
 IBM and NetApp) around that allow to simultaneously access the same file s=
ystem via NFSv4 and Samba exports in a (nearly) non-conflicting manner, esp=
ecially w.r.t. to NFSv4/Windows ACL incompatibilities?

Best
Sebatian

____________________
Sebastian Kraus
Team IT am Institut f=FCr Chemie
Geb=E4ude C, Stra=DFe des 17. Juni 115, Raum C7

Technische Universit=E4t Berlin
Fakult=E4t II
Institut f=FCr Chemie
Sekretariat C3
Stra=DFe des 17. Juni 135
10623 Berlin

Email: sebastian.kraus@tu-berlin.de=
