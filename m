Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D2A353648
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Apr 2021 05:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbhDDDVq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Apr 2021 23:21:46 -0400
Received: from mail-eopbgr670045.outbound.protection.outlook.com ([40.107.67.45]:7248
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236641AbhDDDVp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 3 Apr 2021 23:21:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjVz/wXZoIUDn5j/oGwTPYz69H0v6gHDSVmYWpohMtaPXuhSwW6gxrddienRFbrsuETBzGYqBh6lJm8vp+bX3s52V+OsRDaVYy4EtVQIq/oMFcIcytcDfc0Kad/5BYYQCsJRBt+deRelXnsMqonJfizGe5XZsozC8NS4qJwnQBBVdfHo43VPrJBiCnp8HDq07umCgN1/BhJrpb/ds9nkPoni1nvQRqVeklLINpAC6ho+89FvBb4bFZE1CpaiR+bCOFBpwgNiUOeyDQwxQCASo5eW1ou8zp802rw3HfFt2Y+FDIYh5IVABSgRePYW1z7WLP921bpOhBMnnujXgaZ0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC0MGqpWK/KgYCLOBb0BcABSr/hGZwE9CotY7SrPhjw=;
 b=OztBu/IBWIZanHbIBhNKmsms3VeTl+Fh+U+GAqh0GaFIxfknE2HTjBJUujBRULp4U6uE2PWPyAenFSF71WBpzTr3qUIZ/1wY7EqgekCeNFD21eQ14ONTA6Eqr2OyK8wIlcJpmhiBCIFmkemuMFrUud8IjhIs7I7M0r8rd1VufmPjPt/nzNGas0aYEptJTVycIJhdtaqBZnXUtqlmJr6kxY0Ls5YkhFSGfofSHf51C6fClyLaJnxYhIdL723T64kUpcg9qCFQkTbVWg9RYBRpedt4ZVaSEiO1HZA6Nu2vNACaoLyVUC7+kbq3G/t/iQJmkmxxVVvXZL00h8N+revnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC0MGqpWK/KgYCLOBb0BcABSr/hGZwE9CotY7SrPhjw=;
 b=Sffp+3zII247WPjR4XqIbD7a3NmEUJRdLkW6NSaMOjQjKuFkxnfrk9FhJJ4NGKlYeFzp/e6elQRfApm3PokUQc9XHWN6R0tlFFGTiEP4i4fn/GsJX87JMa+LFkWFJoh/Oy/EKb9Ksklo+ZnlMucNQO2MjunaUTdIWw0b/OvsKUEmxRfO5FtBlY4UBZJTyxtLhSvvnk0JpWS/GmgtfFb/0E6vm0Vwqfl6HdtK+WQBdvG58abVT8J3RiSu83wO4xQ7hPMIWQQMVUnpN+pS79jFeZS9Ok+XHoR7AH/RjWMEwUGPH2Pnks3uSYim4VN9wEgWcLsz0WWFGRoysWiHPHD9+A==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR01MB2741.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:42::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Sun, 4 Apr
 2021 03:21:40 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e%4]) with mapi id 15.20.3977.038; Sun, 4 Apr 2021
 03:21:34 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "nfsv4@ietf.org" <nfsv4@ietf.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: what defines a TCP connection as new, requiring
 BindConnectionToSession?
Thread-Topic: what defines a TCP connection as new, requiring
 BindConnectionToSession?
Thread-Index: AQHXKP7Q4rhEGbdjHEe2XuIHzRQSNg==
Date:   Sun, 4 Apr 2021 03:21:34 +0000
Message-ID: <YQXPR0101MB0968DDE7E5E916B2397FBFCBDD789@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ietf.org; dkim=none (message not signed)
 header.d=none;ietf.org; dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b708ca9-3cc4-489c-1b40-08d8f718bfcf
x-ms-traffictypediagnostic: YQXPR01MB2741:
x-microsoft-antispam-prvs: <YQXPR01MB2741D77F3D0EB3364504BD4FDD789@YQXPR01MB2741.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gcXOpUVIqDlJJQl5IoEbp+Lw5LTOj6iGfncavOcO2sZI+B779TAm+kiebKkkG0CRiprbiN8csczmA13jDVfJRN7tOQHVLILRngXhZRl9JcBArZa1cikUW5+qmvtbtPVI54k4JT54CjnDF1DD0/AX102UXemFkY6UeZyqMUC3cPKgkJ6uymnVm+FEpulcm+8Pfw/JndX2yDZyXLscp3Wrks1lR+1WFV6hWU3+vpDdPzr3qbiTVrzKjJ23g//Z5Dzdzo4GEYY7zUZwjnXW7Fwp/fy989pGDwGt7gwqQkMQ+Hjhxndqhjpmw18Zbwo5E8T2rmR5Rvmql8YDFxIS1FXDHlchz4IwXoA+sskUlqSLuslnPUD9rXW+YPaIJcBdwYr1qVZ4GYNY3Io5CVU5K2eXW1CNEJGSxRUED9a4kbbEqfVQcFe6M/r9JNZ2hi+GNVebcXPgQGPrbCcQTdxcG5BSh94yDi9ru00ShJ0Hi1+iGZZDQ6RLXF+TsIAaLgS4I3OMV2ii3BOAyNHyEk2ZYZhWKwp4PsnbqV6eE0wB3GnMlxbvDJEBMolIUSVQ4Fg75AkBvueQ4eZu+eTjWoM4TU6Am3vz9J29IRsVDNOonMxK9hNwgspTYAUu7Uo9KMr8MglxvGLmEbGBY9m2PkxGKHDExw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(346002)(366004)(39860400002)(376002)(136003)(396003)(66446008)(64756008)(38100700001)(478600001)(55016002)(8676002)(76116006)(91956017)(786003)(66556008)(66476007)(316002)(4326008)(6506007)(2906002)(9686003)(6916009)(8936002)(5660300002)(7696005)(33656002)(186003)(86362001)(66946007)(52536014)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?peZAVb7S5X4JwVOoyQdF9fpyOV0ml5XofSmrdnF1lFHK6PpK00CGg6vvp2?=
 =?iso-8859-1?Q?p7o9z/ctjQsRIdQpN1pd40h/stDj7QSqChnYCzMufOut702EszO3ley59k?=
 =?iso-8859-1?Q?6u4pEfeeYRCfnHmvZSEaD/7Ty5FYJN+egVp2GclDHlNXBlVUwpv+hCQSua?=
 =?iso-8859-1?Q?xydu1maFtZ3IcJfJ0gIRWRSY7k9BwBWjQEqXjXWoK1TZggf31/2wApMmA6?=
 =?iso-8859-1?Q?FZwXjAUh3Vbb1Nhu+o2OZGVelZEeVDkEh8tbjaMAUsHCe47A/Lv9W5y559?=
 =?iso-8859-1?Q?VcyjlgyntevJoDnC0pPEEjYVvS2NT0YCPgNLatg8zcXxklBhTppVZaKbsC?=
 =?iso-8859-1?Q?Y/a5ynmLZogzxuu3SHWAL+JQhYtHsLbHCdccCRlsGudwNIOs/eBM8IA52s?=
 =?iso-8859-1?Q?OSqVfU8uTN0+ktW7zY2uLJu+XkTV3eBcFml19YBNsXE7edJ4QMvrTpoEfJ?=
 =?iso-8859-1?Q?K0B46eJvQU0M/OuhSqMsvuK6bJyFtPxImfw7w/1nO/iakGOZ9UJEkrpr14?=
 =?iso-8859-1?Q?qjVRdLLHWVP8V/mD65qD1Ci5gr31kb/YdBv9ZFOTEWs6uGc35vkf4C0v/5?=
 =?iso-8859-1?Q?sJGRwJhhTGplyy/pKjrJueiVxgRYJ5x489NjdGb1IdCYrwA3LWIOG9DQYg?=
 =?iso-8859-1?Q?J14qwWKmsvd5auxeYFpePmh5g1WxPP2tRF9fc7sZcktlpUnuPTMARkfLuP?=
 =?iso-8859-1?Q?K1aNmJS+TV9ZfEmczmzcKGK2dUzJUNOXVkplM9V5N2BzGX5XSBxd1Esu2T?=
 =?iso-8859-1?Q?pnLzQ3U1VPjvohqz7czdJNyoIFw7wVjK0pBeUEMlXG4Xqydy54imT9tSPd?=
 =?iso-8859-1?Q?W4IB19BCK8Oi17b/MlmhLL7enwCaA3/WBy23H1L2yKRIQ6+o0MPjNIcrVS?=
 =?iso-8859-1?Q?dm9jepCm/ch22Uyqm70WVBRjiPn/SkkXluGymRsxlsR9HBKZ/55t+phx0a?=
 =?iso-8859-1?Q?eqpaZXApFSFWin6NaUUQ6if33LLbCVhvnpqEQerNfnn5+fMjL7BGKZQInq?=
 =?iso-8859-1?Q?AOESvaXQlCPlC+K+LkhpmznTI84kojt9ZEWuq4rhT7nH3m44DNRV2ecU5v?=
 =?iso-8859-1?Q?uGtgzfAF8Rb6ESJAEgq/hvWpWG9NbGFPF55/iVROl+A1VQbL1LIymtdCRs?=
 =?iso-8859-1?Q?w7O+o2XYSX4qDIUYh9OSvvrFk9DGtkpkvAGhcbanjDJOIYuS+MblhRjllH?=
 =?iso-8859-1?Q?SzrNiYoafJ9VB82xY+x/lvJVku99nWBTduvaiCx2VeI0sXXcI4fsZEXmla?=
 =?iso-8859-1?Q?7kRVhostF2P7YuXccXjgw8esZPEhdXCX3JIJlvpADI8m260fHTVodqH8OK?=
 =?iso-8859-1?Q?17mFiw7oqF3ezcLTjxf/CdVBgiShG3DenLCxEBCtBPlUVxpM4SBRS6UUT8?=
 =?iso-8859-1?Q?aToKd9gRmhLD+2dIGPXALFzOd8LsJqeldR4bH+KP0uUjG6hOvZjUg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b708ca9-3cc4-489c-1b40-08d8f718bfcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2021 03:21:34.1572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZpAC7ISDOmYQpBI3ZV5trWfqUYYQB9GbBm9x4Q1TAzZIBGQ4lH96oZcY36HIm8+6VxcT4r50Iwd6753fuVMIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB2741
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,=0A=
=0A=
I have been doing testing of network partitioning between a=0A=
Linux client (5.2.10) and a FreeBSD server and have observed=0A=
the following:=0A=
- If I unplug a net cable for a few minutes and the plug it=0A=
   back in, the Linux client does a TCP "SYN", expects "SYN, ACK"=0A=
   and then continues on, using the same port# as before the=0A=
   network partitioning.=0A=
--> I had assumed the above created a "new connection" that=0A=
       will only be bound to the backchannel if a=0A=
       BindConnectionToSession is done on it.=0A=
Now I am not sure if this is considered a "new connection" or=0A=
the same connection (same port#) still bound to the back channel?=0A=
=0A=
I am also wondering about this para. in RFC5661 pg. 493:=0A=
   Invoking BIND_CONN_TO_SESSION on a connection already associated with=0A=
   the specified session has no effect, and the server MUST respond with=0A=
   NFS4_OK, unless the client is demanding changes to the set of=0A=
   channels the connection is associated with.  If so, the server MUST=0A=
   return NFS4ERR_INVAL.=0A=
Since a "new connection" is bound to a session's fore channel by=0A=
sending an RPC with Sequence in it, does this imply that a=0A=
BindConnectionToSession done on a connection to bind a back channel=0A=
after an RPC with Sequence in it has been done on the connection,=0A=
must fail with NFS4ERR_INVAL?=0A=
=0A=
As you can see, knowing what constitutes a new TCP connection matters.=0A=
=0A=
Thanks in advance for any help with this, rick=0A=
