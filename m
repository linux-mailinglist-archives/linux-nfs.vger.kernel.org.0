Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19FE40A5
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2019 02:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfJYAh4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 24 Oct 2019 20:37:56 -0400
Received: from mail-eopbgr660073.outbound.protection.outlook.com ([40.107.66.73]:38080
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbfJYAhz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 24 Oct 2019 20:37:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJa3XZR+0Y0ZU8pwEKqZb4D5k1gIgUJoND09R6iMmEiHb6Cf8X7bYZlxS9rWUYkezJWskiSJS8Z+YCvOvMcmN8Q9ZsRMxpVi90Mi1OSVHTNp5rJ2nB6l+K+DLDVOR5Ev2sAjS620LRxdkCOSup9UdrAusLUmZKTGwSpTxMFxjaUbmTs+Aq7GT0j5AXYDHCr3Uo8dRu8v8l3DzhN/ELpaxfENB4TEMpyfmdCmi5uus/jVJtv51JCCqr/h07cAcVLpTB78idxOzMe2e6jSCUNmygvrZFQ+alDz4gHrAXUinPeF4gfAih1xxU/eyfDNmXgJNjMDyZzqWKL3varL2sseVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwMBfv2ZQTYC29yEGw9ziI+raEhhTg9NBe5gHCyyE3k=;
 b=BS3eNhuZoD03kNS9pjeFpypzFpOaLJD57hrMDYUiRRDoHqmh1YfJ5rFX3vIDsHhW6Pm/4T+47GTAfVGbdY83h+WjPmj3h2y102kUg76Q1jrYoRXTpQXTPsW62Bshb0qWcxeV5NPE7lG6Q2ksRR0bynOb0yQ4lIz+wfhKggePzhOEfVzUlsC8OTF/gUPmhM2SuM2Er8zWGBvAKrkGpfntbw6rbxbRP90sdhEVjgDDgIdL996Hc7XqtJnoPgJIp0e9XWNvm3l2IOLq6peeVW4JRa+12F63Ju5z6Gq8KfMnOoP9Y/ynagpHMFm/KtQzA+QymUMARACQdAOPLyJEVjUaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
Received: from YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM (10.255.13.156) by
 YTBPR01MB3069.CANPRD01.PROD.OUTLOOK.COM (10.255.12.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 00:37:53 +0000
Received: from YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::45c3:a411:3ee8:a12e]) by YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::45c3:a411:3ee8:a12e%5]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 00:37:52 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Chandler <admin@genome.arizona.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS hangs on one interface
Thread-Topic: NFS hangs on one interface
Thread-Index: AQHVisR67bmR/wUxBkKrKsn2Em3G3qdqgqX+
Date:   Fri, 25 Oct 2019 00:37:52 +0000
Message-ID: <YTBPR01MB2845B12E9C59F837FE35F40DDD650@YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM>
References: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
 <20191023171523.GA18802@fieldses.org>,<b6248a82-1f1a-7329-5ee0-6e026f6db697@genome.arizona.edu>
In-Reply-To: <b6248a82-1f1a-7329-5ee0-6e026f6db697@genome.arizona.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 441391aa-19f0-4f5f-046a-08d758e39226
x-ms-traffictypediagnostic: YTBPR01MB3069:
x-microsoft-antispam-prvs: <YTBPR01MB30698C0D8FDC21D25F9E7B5BDD650@YTBPR01MB3069.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(2171002)(305945005)(33656002)(11346002)(76176011)(55016002)(102836004)(316002)(476003)(6506007)(6916009)(786003)(5660300002)(186003)(66946007)(64756008)(1250700005)(66446008)(486006)(6246003)(66476007)(66556008)(99286004)(7696005)(9686003)(256004)(81156014)(76116006)(8676002)(81166006)(71190400001)(71200400001)(446003)(91956017)(74316002)(478600001)(2906002)(229853002)(8936002)(4326008)(52536014)(4744005)(86362001)(46003)(6436002)(25786009)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:YTBPR01MB3069;H:YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Krhyc7D5dgFkVsnmB/HuQeofNBiZ7dhoSmdXI5jGxEOwaqxwoKaUihXD+tHacqesLhHDV92oxO6oOkGp2YsyWlVM05+of7qsgfowfLkr8rrJ2KgV0PrXQqzd9cJ2S1H4zCHgPT9V13w5kITFw0hvTmEXWaJbonltvTLhOy6Wab+bmMo6eFxtyFSP4E79JcSowPE6Jfs2XBV0k0baNxleV224eQEv5xtv0SQ4xkFKOqLNkumyVX6tL7e3vOpexW+jmwuRr2qBfaRv3jja1eYGUdiuYlXNpXofNG/19su1YRNM/ZvVlu0dU7DZgWFRfmUv1LdIDS89vFyhOSRN5G2GLSVWakMcqx1raU9kl7JeWPpEJ93H5Szu1uL8q4D7984yfYaFgJ0lb+Rzajz2h7C5yiBjQUTUqP/GXVei+uZtGpb4G99wsI3zePI+25sT++xU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 441391aa-19f0-4f5f-046a-08d758e39226
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 00:37:52.7510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCyEU26GiRRxcJcZqEDQM7vaH2/GKaR7EllmVUM9/w2XWjF04Z0acYN8JhgQfsJxD6E5/2Q3sZhYSU+CB/bsWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB3069
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I usually use tcpdump to do a raw packet capture. Something like:
# tcpdump -s 0 -w out.pcap host <nfs-server>
(<nfs-server> is the hostname of the other machine, client or server)
<ctrl>C  <-- when you think you have enough

Then you can read out.pcap into wireshark.

rick

________________________________________
From: linux-nfs-owner@vger.kernel.org <linux-nfs-owner@vger.kernel.org> on behalf of Chandler <admin@genome.arizona.edu>
Sent: Thursday, October 24, 2019 7:40 PM
Cc: linux-nfs@vger.kernel.org
Subject: Re: NFS hangs on one interface

Thanks Bruce.
Do you (or anyone) have an idea how to use wireshark "tshark" on the command line to capture this data?  I tried to run it but it captures way too much traffic.. is there perhaps a certain port or ports I could tell it to monitor?  2049?  Thanks

