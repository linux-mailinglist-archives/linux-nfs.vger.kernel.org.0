Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E5473731
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 23:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbhLMWEy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 17:04:54 -0500
Received: from mail-eopbgr660045.outbound.protection.outlook.com ([40.107.66.45]:51952
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237196AbhLMWEx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 13 Dec 2021 17:04:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh59JOaIXCkO99MSzwncmyeRK7mF4XVqqSFSMfk/+BA1RRxJrxh3cyKKOJP2yLWrCdTgJ5UcNVA1aYSRc8FLHFgbBENIBMhI7TWmTx3wL32FDLTpAmYXbB5bHjRhE7RLJGbu8+icUkv8R8n5Om7XET3+bVYBBj1Q0v23HgI18cW2S7EAGr2Df5aOwSw3Hpu7OBf9l+WvcrO43lVENf7UwrndAfZbIQgP7byT4eIo5uTtdEkOQgD1Aiqb9FKIzAEPJiJYX1ciY7GeFiPx+D9BwZA/S96hBJsLZAJ+pmq9vGlbrbmsJ8bGqH6wxLnHwV/TR5rkGXde3PHVn4vAlqmmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtjtQ3LaGXrRwi3YACZ1dghZ14hEChcaQmgbAdMn75U=;
 b=kDXbQvD+hl6sH/kLpfJC4Kis0a9Vh73qtDVf2+85kVHW6E/9xNzf2nIVqIfwQt0IxwZ4XkOC2xXju/VXC8BeaGDG4YV0yweEnFNhLpua5p6hFC/TIYbBeH07B1yz+kTJf1lJMnuTqVDr6oKg0madveek5Agp3ASf3dyDGH/YKGPEcFQHMgaIINhDvzjrpRbBcUCtIcAbgzJyETGC1s1QZlAfycJ7zoAJHWTmCYUhNY431wvK059tSlsxE3n0AjkgCd2A0doh3rMeStOjJEiq87jskvLgw27Vsng5pkvWowNdY5p7PfJPRwVFUtuwcCFA7LPakdXQUiUAdW2SAw3Ykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtjtQ3LaGXrRwi3YACZ1dghZ14hEChcaQmgbAdMn75U=;
 b=dM19w/qiZUhTr4sRrXsud+aOmLlFivyd0CysDzOwt4yFtRQ7P3Lt09bqChe1o08PDuNPk4akNvmtSJ/AL709n/29+Go2VTyFDvHDOfw8fF883NnOniR+ntmPuh89skUjgz+EFh5l1i2y7pWMvaMaful6I3F9ykt9YRY72nUdeGMlTO4dgFgu/S49taRavDIQRSElgsfmlu9p+JcJGeK/X9B6CFB3Fu6jQzWF5Caht8OB9Sz/wX3Fk729O1ZQUVx0z0M7DmvmPf+93gXFiQp78u/xD6Un6kLihvQAWN4UUaR0Q5qozFWt5rrm0cOyfCxHwCvJlmpXxzNnP2J2MUlQBA==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by QB1PR01MB3987.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 22:04:51 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e56f:b7a2:3830:5706]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e56f:b7a2:3830:5706%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:04:51 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: knfsd server returns writeverf of all 0 bits (but was not
 rebooted)
Thread-Topic: knfsd server returns writeverf of all 0 bits (but was not
 rebooted)
Thread-Index: AQHX7VIEQoc8yG9ZVUucpKOORDcyuqww2GaAgAADj4CAAANOgIAAHKmo
Date:   Mon, 13 Dec 2021 22:04:51 +0000
Message-ID: <YQXPR0101MB096857EEACF04A6DF1FC6D9BDD749@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <YQXPR0101MB09686CB60B96426316F4252ADD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
 <E98AB758-5406-449B-96E7-C7FBD0BA98B3@oracle.com>
 <6672752c94036f159816c19756fe4d77ca9bddd8.camel@hammerspace.com>
 <CC76C3FE-1F85-412D-BD3E-13662E7721DA@oracle.com>
In-Reply-To: <CC76C3FE-1F85-412D-BD3E-13662E7721DA@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 30c5bf11-026f-72a9-7943-14f726708e52
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 079fd176-4fc0-4de4-6d66-08d9be84965a
x-ms-traffictypediagnostic: QB1PR01MB3987:EE_
x-microsoft-antispam-prvs: <QB1PR01MB39870B1630DC785C38FE7BBBDD749@QB1PR01MB3987.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3g1UOGysWmdkAJrsfhf6u7+VbUKAIe6BlebLbBwbMRfgZ86YRiDKxncFlSOIvr+bmg7sIwkJBu7RNkVpBAtJ2EUTDS+2xJgMvEjzYjqgCKvPtE8BDHNVWwXIqPh5JNcrPH1MQeGBMMf2dgX/DdRCYsfTBfN5Azy92TP3YO2B6bLJ0OXmWGRHmn2cHfTbAexMRbgLKQtLQRog9xoRd8ScdAFlQfdBrX4eBxb5JcWQe8lsj29bS+f9T+epdL0n1PpDyz8h4ski3FnZ5eC5y2SgB/cJm8/YIagx0CWrZr63yrFEmfgHFKiM+5PRsRnsObuboOziZByqAnEz7KLvDtA43l/lAoEQ6mgmBMSG3JlKqcx5BII8umPtow1/NxmTLyqym9sXjbGyUxjfzj5/7Z2N2MsWHpTRgRzceEMRc5lHx5liKaVZsZxqsJ5C+OEBIO1G823zrxoAWxghlk/4yCkmLO85ufVQB4+Fgpbi2APHDav5K+MnN0YF2rPJLnsm3FRr3AMO+FPXGhoVCDE2Gbm/hPQNKF7kcVk6CkKIrkjo+KEr4sL22/o2z8IHbEahJMiS3SYrDzkyqxugPaFLa+z5Q5W2QIgMv/oBVA4J/OV1XysW1x1AeUgqh15wWqF+5TBLfIXyDbhnRAORGZb3i/FQJDY9o546oFwMGFv0AMmPufXDWlDF/yLEcmYvkFxppjiB7ircIHs9FRqvxHaPmvOGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8676002)(53546011)(33656002)(8936002)(76116006)(4326008)(122000001)(91956017)(83380400001)(6506007)(9686003)(38070700005)(55016003)(66946007)(508600001)(66446008)(66476007)(7696005)(66556008)(86362001)(64756008)(38100700002)(186003)(5660300002)(4001150100001)(110136005)(2906002)(52536014)(786003)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Em6NFx5NrUYuGF+1fT4U+aJ+J9rkOIb8H9h0WHC9gv2qWskO7LTN8snPhq?=
 =?iso-8859-1?Q?QJdgrmx7x0NxEFVBeaRnk/AX8d1FnQf+TP9THA09lpAdR0wjX+02m+qgSL?=
 =?iso-8859-1?Q?2plDi3eivpoffrCg+HGoeE1iUR0+hEHhq9PaQ3ftGrr4LQTCmz2JgjgM8s?=
 =?iso-8859-1?Q?6JfmTkZtJdbJV4O6krzZcAiCA7FAzdAUds/GTAdgDEi9eM4+6SJiHxGy+I?=
 =?iso-8859-1?Q?AUJz95Dpkj5xfA8tYFihwL1FD3lI+DlgQnvoFoT/qnZHv+fJ3tgpk6IMrs?=
 =?iso-8859-1?Q?yErbE0KdKtV9eXcSkU2UFIG3JgLzusnRqje06U43Pl4WhBelQA7R4CHVBJ?=
 =?iso-8859-1?Q?a8+20FKwwlayKargmquSOEZlttWHLUGCiWRxiE9jf0h0tMgUh1q/6491CZ?=
 =?iso-8859-1?Q?1HoY8sDwduKV6q4z0nUvewkO0bn9o8Gb0fO7h04HxIIMH3gT4/yWPG+74D?=
 =?iso-8859-1?Q?V5Dc0nriN4nLCtsPNj+dhf4VB2/bM/RhvCIhLxXcLaNA7jpUHxqzaddnWY?=
 =?iso-8859-1?Q?Z4kOGLtwe3i/D3E/QqPpoRDfLqIVJ7H4h23PRNit7KenBQpfxYZVLZZpyG?=
 =?iso-8859-1?Q?9ioOAawda1oQVNTjaf9Xnv6cUXQj+e9YbJn3HX/iOjCTCR72+VhylIscW7?=
 =?iso-8859-1?Q?MBtksf8N5lUlvAk1B38epeLO4q4D3zhbbzFgk3Gl+BgltcmVcUpS/BRYks?=
 =?iso-8859-1?Q?X80bueRy9tDi6/NoLSgpisFY3ysvK0W3u9ZXSrFaM7o17466p7djm7lX+e?=
 =?iso-8859-1?Q?AN/SAfGKCxWhms3DpbunkqcJueVcTUzABiwHoEawx1dy5u8kcw4DEaooLJ?=
 =?iso-8859-1?Q?5T5/iUazjcQ9BoyhVVqKxK/2+/10r2Mn1UaMhhFt78GMg8FrPEhD6OW80C?=
 =?iso-8859-1?Q?Tt3H3B4hK99HYW3JaWh6ap6yiQBcY8Gi+Np4cHZ6h2WuM/oJIqRPSrVwQb?=
 =?iso-8859-1?Q?XkENI9Ou70jF8qJxiTY6EpvzN65V7jY2AFxMNkGT6AvG6anNUFs/BlDIBE?=
 =?iso-8859-1?Q?99DIejoLcxdp+m9Ny9ovauduiVEsG4ZAegX+LelTsel9Wfa7JK5CJ7jKkW?=
 =?iso-8859-1?Q?wJiCFMsBky4J3lOhHCltqHbLeOhIo6HDp8wIWsggyJSRhaqV6tk5KQ1toE?=
 =?iso-8859-1?Q?pFfOTcC1nBqYujO/7lA1pGO3e2OCIqXDxRcmTBxW7fUInyGFVSVyRFm9XB?=
 =?iso-8859-1?Q?jXFBbqAriZHO0Wf437oAxsi//bfUtBopRsgUgMS+wzKuVIHcUxsz7HSORC?=
 =?iso-8859-1?Q?PCU024X4FdP3PovkBNCCx1o2BWTCrUiCTtc+7oj42nY//hpXtzDuCgZpew?=
 =?iso-8859-1?Q?bsGxlmStKuJ3PhLpgdyter1kB1j2L3eMdusTZnu0nYX2we4vJAWUfjpVB0?=
 =?iso-8859-1?Q?4K/4Q9yFqOUp939fRN9jcwkSEY8+fjr3oQRbS9kZfvzhHYeYEh1TvFhBWy?=
 =?iso-8859-1?Q?f6rYTLmP3o90gNbNEmCl0AzHQP8RtFOvG78akG8U0kNhsrMEpaFhK//6Pw?=
 =?iso-8859-1?Q?2diKyCBjdAl6oakcPcLyU3FhPp6ftfkoDpmt9yrF7et9XakPQJEiQwWfU/?=
 =?iso-8859-1?Q?CaPYUToASHKwPBsExzbVxChNx+8mmSf8iF2vuNEjyQSGGDDj6GDkzHYm1q?=
 =?iso-8859-1?Q?yKcdMV+QVAyTiFa1MZofiTLQZ/ZqhfaHQWwbHsF8RVrX3QgpsAymdLaKVV?=
 =?iso-8859-1?Q?ljgOWC7SuCE1ULXu5f6RksRy/BGOWzwdGOUAzqKdlYjjAJcOw/AWFD14wc?=
 =?iso-8859-1?Q?UhiQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 079fd176-4fc0-4de4-6d66-08d9be84965a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:04:51.6525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ke8GN1OZ0JKD0kxOli+Qj3yzhCAKZJwKzAkxBFccMraR5umqvQGYVEKDw+2Wm5X6C/bLFMsf7L5VxkuLL7CjPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3987
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck Lever III wrote:=0A=
>> On Dec 13, 2021, at 2:54 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:=0A=
>>=0A=
>> On Mon, 2021-12-13 at 19:42 +0000, Chuck Lever III wrote:=0A=
>>> Hi Rick-=0A=
>>>=0A=
>>>> On Dec 9, 2021, at 6:15 PM, Rick Macklem <rmacklem@uoguelph.ca>=0A=
>>>> wrote:=0A=
>>>>=0A=
>>>> Hi,=0A=
>>>>=0A=
>>>> When testing against the knfsd in a Linux 5.15.1 kernel, I received=0A=
>>>> a=0A=
>>>> write reply with FILE_SYNC and a writeverf of all 0 bytes.=0A=
>>>> (Previous write verifiers were not all 0 bytes.)=0A=
>>>>=0A=
>>>> The server seemed to be functioning normally and had not rebooted.=0A=
>>>>=0A=
>>>> Is this intended behaviour?=0A=
>>>>=0A=
>>>> Normally I would not expect the writeverf in a Write operation=0A=
>>>> reply=0A=
>>>> to change unless the server had rebooted, but I can see there might=0A=
>>>> be circumstances where the knfsd server wants all non-FILE_SYNC=0A=
>>>> writes to be redone by the client and would choose to change the=0A=
>>>> writeverf.=0A=
>>>> However, changing it to all 0 bytes seems particularly odd?=0A=
>>>=0A=
>>> I don't immediately see a code path for WRITE or COMMIT that would=0A=
>>> set the verifier to zeroes. When Linux NFSD resets its write=0A=
>>> verifier,=0A=
>>> it sets it to the current time.=0A=
>>>=0A=
>>> Do you have a reproducer you can share?=0A=
>>>=0A=
>>=0A=
>> Rick is using FILE_SYNC, whereas nfsd_vfs_write() only actually sets=0A=
>> the boot verifier if the write is unstable or DATA_SYNC.=0A=
>=0A=
>It wasn't clear from Rick's note that the verifier change he=0A=
>observed was not permanent.=0A=
>=0A=
>So then the answer to "Is this intended behavior?" is "Yes,=0A=
>Linux NFSD returns an all-zero verifier for FILE_SYNC writes,=0A=
>since the client does not use the verifier in this case. The=0A=
>boot verifier for subsequent non-FILE_SYNC writes is not=0A=
>altered."=0A=
Yes, that is what I observed.=0A=
=0A=
The good news is that the FreeBSD client can easily ignore=0A=
the writeverf reply for FILESYNC writes (ones where the=0A=
write request specifies FILESYNC and the reply is expected=0A=
to be FILESYNC). I have already patched the client for this case.=0A=
=0A=
Although I agree that a write reply that is FILESYNC does not=0A=
need to be redone, no matter what happens to writeverf, I=0A=
do not see anything in RFC8881 that suggests it should be=0A=
ignored in this case or that the value of all 0 bytes is special.=0A=
=0A=
My interpretation of RFC8881 is that the writeverf is global=0A=
for the server and any change would indicate all writes that=0A=
did not reply FILESYNC and have not been committed, must=0A=
be redone.=0A=
--> There is the weird case w.r.t. File Layout pNFS when=0A=
      "commit through MDS" is indicated, where the writeverf=0A=
      appears to be "per file" and not "per server". And I'll admit=0A=
      I don't really understand this, despite having read it.=0A=
=0A=
Does this need to be discussed on nfsv4@ietf.org?=0A=
=0A=
In any case, the FreeBSD client never does FILESYNC writes=0A=
by default and is now fixed to ignore the writeverf reply in=0A=
this case.=0A=
=0A=
And what about the case where the client does a write=0A=
with UNSTABLE, but the server chooses to reply FILESYNC?=0A=
--> Is the writeverf ever going to be zero for that case?=0A=
=0A=
Thanks, rick=0A=
=0A=
=0A=
--=0A=
Chuck Lever=0A=
=0A=
=0A=
=0A=
=0A=
