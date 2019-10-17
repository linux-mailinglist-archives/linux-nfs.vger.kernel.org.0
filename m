Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63457DB19A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394356AbfJQPzb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 17 Oct 2019 11:55:31 -0400
Received: from mail-eopbgr670077.outbound.protection.outlook.com ([40.107.67.77]:39172
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbfJQPzb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 11:55:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inAs0tW/eMA7SuujUUt+cVtI/j05scyq0K/HJcNPsQc92DtzGf9hV4w4ClBMa1LQUwSn5G/TNA5H9J+D9lWfCChG0fdr/xnOIj7fTZDUhyKnzbYthphhVw3Gzs+9tDiuj/6UiIy4kUTTPOrTgVxL9CCt4LardZiQdGXgUZoyYGJKCLjuB4FV9FhIGgX+54Ea7k73kfUxuLj8ROdIUMiFk2ItYVS4KCNJ/pN5Paz4RffrTbL9xNzc7VGOLvNwEfmrg4iv/N/+Rrfnd1Ubru1Xr2+jdV353gn0TXhmfbmBCGsHg6U3aXbMImHFCRR39XqDn9yGYnbORlACYQC6vmITyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cqKt39kKjLvl8wXl0oF5odWkxEK9V/mByAEtZcXZEM=;
 b=cWZEobz0bp69x+CV05n2YwUUQqc4OdRhG1h+jzO0aRkZR0/l/f7i7DsVvQVkE2xc3TZim0KdxyZxk+YxF80O/uOgOhi0TLFKRWm7QizH3Vol65KZVPsEg7S9tH3hXKJFWBVV22JkcPEehic5AAjneqbJIXVSnRe2YYestV/8hKlSjVV2H/kynUvWhJUrG+JMYGXCBxJyxWAkQw+Sg1tH9UVsB8I8D6qrUcIU4HzVl/wDyqEt4Bry+CC32YaxyhMX98G28+c2KP1JW6uRIiV49V5tvi9V82fSaCm0Th4GlF9eVE1EE2bDVHcKhmm7Ba6t2X1OVPYx0iq2xjVe9DwmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM (52.132.66.144) by
 YQBPR0101MB0929.CANPRD01.PROD.OUTLOOK.COM (52.132.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 15:55:28 +0000
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3]) by YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3%7]) with mapi id 15.20.2347.024; Thu, 17 Oct 2019
 15:55:28 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Thread-Topic: NFSv4.2 server replies to Copy with length == 0
Thread-Index: AQHVg8vy6XBow5lmmE6IMuCp/6tuzqdcytI+gACiuwCAAEGxgIAACqQAgABZSj+AAOK5gIAAA5rj
Date:   Thu, 17 Oct 2019 15:55:28 +0000
Message-ID: <YQBPR0101MB16529BDA6C8D0949B3555C03DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
 <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
 <20191016203150.GC17543@fieldses.org>
 <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>,<20191017152253.GG32141@fieldses.org>
In-Reply-To: <20191017152253.GG32141@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b3b9e81-2527-4eae-4936-08d7531a6e97
x-ms-traffictypediagnostic: YQBPR0101MB0929:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <YQBPR0101MB0929F18F9E5B056AEC0E1AB4DD6D0@YQBPR0101MB0929.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(189003)(316002)(64756008)(66556008)(81156014)(81166006)(8936002)(786003)(25786009)(102836004)(66476007)(6506007)(305945005)(6246003)(66446008)(8676002)(91956017)(478600001)(2906002)(71200400001)(52536014)(71190400001)(86362001)(99286004)(74316002)(7696005)(5660300002)(54906003)(256004)(76176011)(4326008)(33656002)(966005)(229853002)(14444005)(6306002)(486006)(76116006)(476003)(6916009)(46003)(66946007)(9686003)(186003)(55016002)(6436002)(14454004)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:YQBPR0101MB0929;H:YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8OEHi/vzMS3hPa2sHMZCKUeVwW4vOhUAb0KyGFoxvhtrq0S9lEwSJQYAbWK4FLhQjykSYWXSBw8Db4019/ih7T66SCTKCstzaCp+80rwPJCCn9y7qU/ddSWsQtX6QhUpIQKlgjUwWqt0bFtmjU5C4gzDpMPJU4Ky9V1oDb3J+EWCHSVM+lVft01xoFa2YZpaHuE2E5Z4SJnO5Rz24tgR5Brr+/29xAe7Z0cONgu7Ak2C4JFSB0uGX0f5DGBTAzdd1RazVdpvmPhEeKWFrRYyRwCe69RYb4T97CauI6x4YrVeE6PHJbYV9wwE4NtjFvpvELuS0Si0bkYJD6jAmuAdJaNEOpM1tbt0QD+OHbgrwQjpOrG7kl8sGDantL46LrKh5u7N71G4VvsqKf3ntCUMHjpUK9vCB7MS4Vo1DnxvaOvkRDTdfxAjz9axBaP5+w3D/HdhU/XwclsvHI47XzUOtQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3b9e81-2527-4eae-4936-08d7531a6e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 15:55:28.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7ZbcYOeSDzlqD6z1dsHaheTZo/e9Bt4G24ABgpVs0bPR5wZPkj4XbN1qRUiPyDZ7wM27XS5VTtN2Xot9kQplQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB0929
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

>J. Bruce Fields wrote:
>On Thu, Oct 17, 2019 at 02:16:36AM +0000, Rick Macklem wrote:
>> I have now found two cases where the Linux NFSv4.2 server does not
>> conform to RFC-7862. One is as above and the other is a reply to Seek
>> of NFS4ERR_NXIO when the sa_offset argument == file_size (instead of
>> replying NFS_OK along with sr_eof == true).
>
>Huh.  Looks like that's documented behavior of Linux's seek.  (See the
>ERRORS section of the lseek(2) man page.)  Looks like Solaris also
>returns -ENXIO in this case:
>
>        https://docs.oracle.com/cd/E26502_01/html/E29032/lseek-2.html
>
>And freebsd too:
>
>       https://www.freebsd.org/cgi/man.cgi?query=lseek&sektion=2
>
>I wonder where that spec language came from?
Agreed that it is the POSIX draft behaviour.
And, yes, I don't know why the RFC specifies it differently, but when I discussed
it on nfsv4@ietf.org, the concensus was that the RFC indicated a reply
of:
  NFS_OK, sr_eof == true, sr_offset == file_size
for a request of:
  sa_offset == file_size, sa_what == NFS4_CONTENT_DATA
(In the nfsv4@ietf.org archive dated around 2019-08-12.)

>Our NFS server could translate an -ENXIO return into 0 and sr_eof ==
>true easily enough, assuming -ENXIO is really only ever returned in that
>case.
>
>I haven't tested, but from a quick check of the Linux client code I
>think that would require a matching fix on the client side to translate
>sr_eof == 0 *back* to ENXIO.
>
>I don't know if it's worth it.
Yep, agreed. All the FreeBSD client does is what you stated above, mapping
sr_eof == true -> ENXIO for the NFS4_CONTENT_DATA case.

rick
ps: When I re-read it, the comment I made related to Bruce's "wrong" was
      blunt (or maybe rude). I apologize for the tone. All I had intended to
      say was "although it might not be our preferred semantic, it appears
      to clear and implementable, so I do not think it can be "clarified" to
      be the way the Linux server does it". I actually prefer the way the Linux
      server does it, but it is too late now, imho.

--b.
