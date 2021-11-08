Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF054499A3
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Nov 2021 17:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbhKHQ3N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Nov 2021 11:29:13 -0500
Received: from mail-eopbgr660083.outbound.protection.outlook.com ([40.107.66.83]:65265
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237516AbhKHQ3N (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Nov 2021 11:29:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmbbzL30ChBXtTyFxQLTLHLFZHARlErKJ5zCNwtQk2Sq/+bS4b/RNsxRxFhBtohQundSKUaQePMlkEL3CtkzkxwPhkVyEdVbGqM1m6EoG6zrGpNGt4lCuYRBypHzYOt14cd9rPgNdpwRpQjseJhHfOod7esndPuYdYD8r3h+ScJFm7xYxKzipwCeA5jZs0qRUw4iwnVddR+VUz6+gvxgq2jROJhLAo88YNtv+y+R4xm+C8NFJgbBGJeU8FzK6UFMBFtNQ/YfxZsjg6JN90Fu0w7ljUkHjIHjQlfQac2RX498kTji9EbymY34nXOdgx7/wMOA8N1IRwOBF8/dBAARbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v16Je9//IqbFa+HioCE+j1yhVPQn6W1MCC39ZhyLgAc=;
 b=d30H7PFIeJpy0phZ0AJbJGw/562ASLVSuMNeRJKJRpXJ4kbxBdY0KC+KqAEwS4eMUSnc1VHcWH3lrdaz1UmxJMETZ5TjnwyOI7wtvAVxwQ6UcOr1otzRa9cIXos3Dw7K8Nw1PkX8sTzdWcOj3BRGtOZUU6LKfT1v5EAl+1xBy/2PIKvhor9tOT7hVEnqZOdwDycSwLquqdZNwrmVR8HGG6u7Q9becKVrFr/rWgD++hJu1lQ30KtQheWKtCgZHKMpqnNgrkoF89DB0RQDbNZkUo9LXwEcRt7XAhP9wNbXZIwV8nJzrKhyxRdFWuG5lEIQoRuIgNsHbQ+2dKsLjOxT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v16Je9//IqbFa+HioCE+j1yhVPQn6W1MCC39ZhyLgAc=;
 b=Cgnjo18fhwlisXnSm75NZGwmEJ8PowFw+6r5SlA+akWitrUFCxaIXF7dJ9SC76xVreh+VWZ/JjijQPjTmhNYUsRD+qTdW2Kmf5H9XP145cSd5NrlpKbmqCbweCMqtKbQ2z1Asx0jiL06hritZu3VjxKzRakYGaFpwmFwkC2UexOEpHDrEkUFL3kujEpcdpnU6mHMhiB48d4r1trcM4u1mw7R9oJf5I093/2Srq5gu9xfS+2DEXO4XxX2EtrA37M2J+rr19ufsJDxr8z7hcCpYtNJQHwwohDXDr3vOEQlSbV8uuocWcGJ5Kfp2RN8kAH0xSBhCzm80sqVd5YNlevBjw==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQBPR0101MB1057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 16:26:26 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7091:13ac:171f:1c12]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7091:13ac:171f:1c12%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 16:26:26 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Topic: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Index: AQHX02npTtMx6BHF6UKeTijQBaPp7Kv3MpsAgAG1HlyAAAWdAIAA46et
Date:   Mon, 8 Nov 2021 16:26:26 +0000
Message-ID: <YQXPR0101MB09688F3BD85EEEC8975E91FEDD919@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <YQXPR0101MB09684E992DCE638E82493DA9DD8F9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
         <02a742e36c985769c95244c1340f5fc0601fd415.camel@hammerspace.com>
         <YQXPR0101MB096808F771834883F48894DEDD919@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
 <82059fc8fc33631bfba14fa2f5ec5db494667fc7.camel@hammerspace.com>
In-Reply-To: <82059fc8fc33631bfba14fa2f5ec5db494667fc7.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 33e8cd47-dcf4-a88e-5806-214eb186f6d6
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none
 header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ff8acd2-561f-4b94-1689-08d9a2d482d6
x-ms-traffictypediagnostic: YQBPR0101MB1057:
x-microsoft-antispam-prvs: <YQBPR0101MB1057827734E24992F3C61833DD919@YQBPR0101MB1057.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pvB/L9u66jbsPAPxvCBMia5xBWqj76Mzq8YrNVmIUnlJbD/IlbakWiy/XWtOdAhtGvRP79SAZw9gZk3tvheTN8UCv8qaU0H1igsYad6Y4ZXKhtzEPH9NULAn6acj1Vl87mJ0pIkmyBnxjj8AU3Zsz6WovQdIImS9Ho85Q/4PILMKy2FvB8a5ndp2rT3sg4US8VUMekCXJNyW2hV7jT846cWGPmIy5w/lqahR+i/AgXDXD8i/9w7EHv5KzwuqoJvZUxLzObxgaJZjzdzlEqsR/kCYAY1YQdhkSPCCtLFC9xhkvxb0tooLpZucUwrHAQuWtO7XDqeITRJAATe7cD0kO7ZHFtmi58TVrzLLDA2JyvumYYYF5zuWkYTLdQlRktcjr0TtFILCt4nCgwbRXxEWTjL4h+wITe7i/kg+NIQuPl2AtHJTa79Ak0N1EHraKL+Yzok7n0OAjWOcIWTYZ62M4FnREbLLagQxReL3KnuxzyBIV9w8kDu5RlGzBNGTNLdGpoVR/mbMujlXQECdTc7q00e70xi1H48gmyogK9wJTcPpbrO/xgnQPqSdi3BsWTtiu5IS1Q72tVTHghsulfwNC16En9wyRfbMbBzqT8iw+uaRbZhW3An4Xal+CEKbhNDOX2VMeK778Ra0QAkDe4d5Qxps0GYBKHJ2tl+S/yTI7QgCc4Y9wkHbU6EVo7p+4Z3f8Yk2j96SBtZ0ua3ynB7bPKRm5+Zxbjy6L8sqeq2bCGdRZbrZe2p4OddgpVekgwkORlYk+8hiKxGY60ZHGQ9qmR8byfih62xcFSUyq4OMydk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(38100700002)(186003)(52536014)(71200400001)(2906002)(8676002)(122000001)(76116006)(9686003)(91956017)(316002)(786003)(86362001)(66946007)(6506007)(110136005)(64756008)(8936002)(66476007)(66446008)(5660300002)(33656002)(508600001)(966005)(83380400001)(55016002)(7696005)(66556008)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s9qZgEUB3pjESvh3bjuiQaxEZCMGtCfahG7U9aj4QA77eFKhL8rrGFDw7R?=
 =?iso-8859-1?Q?hqlmxx6xZ6BDZITGdJEntBhIAA5xdZ+WhvIL9O9UbgZwVmsCfTiymdACNQ?=
 =?iso-8859-1?Q?CrcVc3faD8hza6pxnu2OPGSRTYrmkvK8RzoIdEdWmfqSmMb5ZWEP52AOmK?=
 =?iso-8859-1?Q?sFrlL+zZ4h5jd+LIpzPyHipy/Zq+znR6L/g3eEpiwPUGuBvF03MiK4pMSb?=
 =?iso-8859-1?Q?paUsWGl44JjBRNndRnl1qcwZe508RFtQgHlqAgz4o4FEXb7T2BrJjaWIbc?=
 =?iso-8859-1?Q?rsD7QpJbKyZfbaAMfAORbbCHd1Kg/GAT0pRidn6L1TR95nFm85StPKJbl9?=
 =?iso-8859-1?Q?whA1KCgAHCOySijj2uXicl6wzu2pvjCAiLdBZxvw4nKY5/y2KbxyR+4evn?=
 =?iso-8859-1?Q?qElHJoDyXh9MeqCmOWKfjTIaTbSnKbo1U46bZD9WkXuflEly393vxFbl6m?=
 =?iso-8859-1?Q?VlfvHk7kT8tkCzQVUQYYmStYIhfQEChtK5GmUb2fwoTcIin4tCPlwF3jTj?=
 =?iso-8859-1?Q?bChEl8LjJsZA1GLM2YY7b97qAAODgxczb7T50QLy4i3SAaryZbnW6nAzG1?=
 =?iso-8859-1?Q?O746lZ4GgdP+2ESjmEXGZKKm8tXaZjC5ih5bNL5PDfI2voM3To/SRS9QiB?=
 =?iso-8859-1?Q?7nohAMTed/qbvgC8jzC9NjMUChJOCNWqawrw/ozjy+CL9X/VzXZ9kgDzpC?=
 =?iso-8859-1?Q?Rjv3HYjbYmq3IKEZNhtXDqcUxl1LtM1biUPV89U/9oRGqn694pq27EmcTT?=
 =?iso-8859-1?Q?v6PHHw1LXhOgRx14eOecdrT5+0fHseOs0vCDXi0OtJxGu7YLqX8yploDMV?=
 =?iso-8859-1?Q?8L9tGdmDt8wkKrZSGOEl3QhcKnTmNx3qITMq0iHs31y9V3Q/meBvK/NEr+?=
 =?iso-8859-1?Q?FTF6jAU9ZXvThYOAzl/MJEhZtozP7he4DjL1tVWc8UlmPfhizfLCSpQipY?=
 =?iso-8859-1?Q?LDSSVGDks6reQfTSyqx2sYjacty82YSH1EUYwjg/BPMmv56xx67LQ0vCgI?=
 =?iso-8859-1?Q?v6k2S8DhK5betvrSsqdWgMZu9aJSDSUsYg9CHgIqZwAHuQFcNEH9e8SNwx?=
 =?iso-8859-1?Q?W9Vd6EnaGn2LnSr1+cLNbZw1AQNrJFQE0OPsu5hGZ8DmAJswCspo3EZWed?=
 =?iso-8859-1?Q?0cpzjk5Mmg9jUeqBUuA5hmk3dBfV1DwJFo/tbzu/SzJ8in9ZeQxoRim2Gq?=
 =?iso-8859-1?Q?QXoypFXbNIML6t3mqE01BYJLe504rUq7Jv7RXJtC8zdeEgB+W5G/N8nmup?=
 =?iso-8859-1?Q?EPrzqxZEGzi0tJ06dK67S0oEfMrDkU4iOUDVy1p/KDn1OrPVTsH7zSULk2?=
 =?iso-8859-1?Q?qS0MtiL4pb16vxTdK/C629pg3PpHSQ22KuSAXwA2oD/K6jXo5S6u17nJE2?=
 =?iso-8859-1?Q?17tk3FppAzwjr0w9JGNu30CoiFrAS78mTCs/fjGf3dTaoFgUoEj3pEtWsM?=
 =?iso-8859-1?Q?PRvCDLFwXBjk0NbeJMhVeRJF9D43URgpNxaV1Tk1A3UssHaYsWjo8L38Wg?=
 =?iso-8859-1?Q?CyNsVeak082WehcQ1pwMVg2zP1mCaDXsnsjtJdxjAFSJrOneyyvnlf2sV/?=
 =?iso-8859-1?Q?habjeS8HvssYnJ24wt4RI/1Z1blFjxkK2S/R7stG8UCYB9M1k1HuR2iUim?=
 =?iso-8859-1?Q?Du1fq7sLBO430c3VmbgqAdAgF3EEy3ONB2bKNK96q7+hqftIydx8yE7NfH?=
 =?iso-8859-1?Q?ZdMx/fd3+6+MN2FyrDcoYkKOLJJT+tARTPNg9Ud4ibPDlRqd018mjFOU8w?=
 =?iso-8859-1?Q?mW5A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff8acd2-561f-4b94-1689-08d9a2d482d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 16:26:26.0161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cm/sGaFklpmqKKm+F3MDLYpU1tkOU9VsnhuaKyRx1rmlcUjWXzhYE5ke9q3T+BsXxwROjxsTqimNsvzbkISKOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB1057
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond Myklebust wrote:=0A=
> On Mon, 2021-11-08 at 02:27 +0000, Rick Macklem wrote:=0A=
> > Trond Myklebust wrote:=0A=
> > > On Sun, 2021-11-07 at 00:03 +0000, Rick Macklem wrote:=0A=
> > > > Hi,=0A=
> > > >=0A=
> > > > I ran a simple test using a Linux 5.12 client NFSv4.2 mount=0A=
> > > > against a FreeBSD pNFS server, where the DS is out of space=0A=
> > > > (intentionally, by creating a large file on it).=0A=
> > > >=0A=
> > > > I tried to write a file on the Linux NFS client mount and the=0A=
> > > > mount point gets "stuck" (will not <ctrl>C nor "umount -f").=0A=
> > > > --> The client is attempting writes against the DS repeatedly,=0A=
> > > >        with the DS replying NFS4ERR_NOSPC. (Same byte offsets,=0A=
> > > >        over and over and over again.)=0A=
> > > > --> The client is repeatedly sending RPCs with LayoutError in=0A=
> > > >        them to the MDS, reporting the NFS4ERR_NOSPC.=0A=
> > > >=0A=
> > > > I'll leave it up to others, but failing the program trying to=0A=
> > > > write the file with ENOSPC would seem preferable to the=0A=
> > > > "stuck" mount?=0A=
> > > > --> Removing the large file from the DS so that the Writes=0A=
> > > >       can succeed does cause the client to recover.=0A=
> > > >=0A=
> > >=0A=
> > > The client expectation is that the MDS will either remedy the=0A=
> > > situation, or it will return an appropriate application-level error=
=0A=
> > > to=0A=
> > > the LAYOUTGET.=0A=
> > Thanks Trond, that worked fine for NFSv4.2. I tweaked the pNFS server=
=0A=
> > to reply NFS4ERR_NOSPC to LayoutGet and that worked fine.=0A=
> > (This is triggered by the LayoutError.)=0A=
> >=0A=
> > For NFSv4.1, things don't work as well, since there is no LayoutError=
=0A=
> > operation. The LayoutReturn has the NFS4ERR_NOSPC error in it,=0A=
> > but that doesn't happen until it finishes (which doesn't happen until=
=0A=
> > I free up space on the DS).=0A=
>=0A=
> Hmm... The ENOSPC error from the DS should in principle be marking the=0A=
> layout for return. You're saying that the return isn't happening?=0A=
Not until the end, after I have deleted the large file, so there is space o=
n the=0A=
DS for the writes. It is in the same compound as Close.=0A=
The packet capture is here, in case you are interested:=0A=
https://people.freebsd.org/~rmacklem/linux-ds-out-of-space.pcap=0A=
(Taken at the MDS, so it doesn't show the DS RPCs, but they're just=0A=
 a lot of writes that fail with NFS4ERR_NOSPC until near the end.)=0A=
=0A=
If you look, you'll see it gets a layout for the entire file first,=0A=
then it repeatedly does LayoutGets that are a little weird.=0A=
- For 4K only, but always on for an offset that is an exact multiple=0A=
   of 1Mbyte.=0A=
--> Then, once I free up space on the DS, it does the compound=0A=
      that includes both Close and LayoutReturn (which has the=0A=
      NFS4ERR_NOSPC error report in it).=0A=
=0A=
> Does a newer client fix the issue?=0A=
This was 5.12. I'll build/test a newer kernel in the next couple of=0A=
days and report back (it's an old single core i386, so it takes a while;-).=
=0A=
=0A=
rick=0A=
=0A=
> But I can live with only 4.2 working well. I can't be bothered=0A=
> endlessly=0A=
> probing the DSs to see if they are out of space.=0A=
=0A=
Agreed. Your server should be able to rely on the layout error reports=0A=
from the client (either in LAYOUTERROR or in the LAYOUTRETURN) in order=0A=
to figure out when the DS might be out of space.=0A=
=0A=
--=0A=
Trond Myklebust=0A=
Linux NFS client maintainer, Hammerspace=0A=
trond.myklebust@hammerspace.com=0A=
=0A=
=0A=
