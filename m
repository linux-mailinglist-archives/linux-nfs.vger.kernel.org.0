Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0DC2DA385
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 04:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395334AbfJQCQn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 16 Oct 2019 22:16:43 -0400
Received: from mail-eopbgr660066.outbound.protection.outlook.com ([40.107.66.66]:60917
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2395192AbfJQCQm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Oct 2019 22:16:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcKnFpWyTWNXCOeeQyn3QB/lvLsZP7uB4Oajdm18NCRHZuPSWAtI3LVSQx1HPOcF9/j7B74DE2SAa+3sH6p6iKf0hMxMWE7R172caWuygBgclJvcIgFS7nf3NH5jAO6Y/7243agq9xkXJgBhMrksHxEpGhGT8mLZ70Y44wPDFWC/NrDJC8JzlNaiS/Kn4HOE4NtA+Nz7GoCsa2+mulbMWkWoorDH4SN+uv6iIJzxojNqJPOkIzwtdTaA4Vs7pPvj/W8cX9CTsTue1gkaxTTZV/SkcOFKsZucpN0bMVDHEKgOx9SW56QneBj6fz9/k4w4C1DRtMIN20uBf+7u5BQagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cqJV1uxK1XafxqTtLfz5G0w6fYwxUxZ10ek73EPUJ8=;
 b=Z2U9mZAWP9sF0I/DL2CF7eKHyKOmvfuVQ+Mr02ThQVn6y4lsK/zTPpoCUN5KeZcG8ufEWcj5/jZkB53qvEYb4RWFEBW3ajdVb/eE4Zllc/s8JYfr1jszRmFmkD9S7sGP4VT1JErOCDUD8q5jJWqZVNoPbNim6kyIvFnJ5orhzpi0/imp1/T/PGMHp6WJ1N7+R6EXZyzF7iL4bfU7NcWt8iEXkK+JmG28/LxyPeuiNam67McYxQuvTbNRNJqJPhVZt2iOUI4l/ppJORxMB15oyxlwsX3+lBXa+WXZ1LQhplKl6NiUbt5dz3Uayd1qgS5A0WXps89HjEZ4CR3V0eo2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM (52.132.66.144) by
 YQBPR0101MB2273.CANPRD01.PROD.OUTLOOK.COM (52.132.73.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 17 Oct 2019 02:16:36 +0000
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3]) by YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 02:16:36 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Thread-Topic: NFSv4.2 server replies to Copy with length == 0
Thread-Index: AQHVg8vy6XBow5lmmE6IMuCp/6tuzqdcytI+gACiuwCAAEGxgIAACqQAgABZSj8=
Date:   Thu, 17 Oct 2019 02:16:36 +0000
Message-ID: <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
 <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>,<20191016203150.GC17543@fieldses.org>
In-Reply-To: <20191016203150.GC17543@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecf7c516-7e24-49d9-3c58-08d752a80976
x-ms-traffictypediagnostic: YQBPR0101MB2273:
x-microsoft-antispam-prvs: <YQBPR0101MB2273979FDAB7E18A2DC4FE0BDD6D0@YQBPR0101MB2273.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(51444003)(199004)(189003)(6436002)(9686003)(14444005)(229853002)(55016002)(476003)(486006)(71190400001)(6246003)(25786009)(256004)(110136005)(46003)(186003)(54906003)(786003)(446003)(316002)(11346002)(14454004)(478600001)(71200400001)(74316002)(305945005)(66476007)(66446008)(81156014)(5660300002)(86362001)(66556008)(33656002)(2906002)(64756008)(102836004)(66946007)(99286004)(52536014)(8676002)(8936002)(81166006)(6506007)(76176011)(7696005)(4326008)(53546011)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:YQBPR0101MB2273;H:YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0H6YPdR7gQYXnUFN2RFzG4yogoCQb1cAhR+VZ3IDojvaf63NUz5lzrX7xVr8lqWjRQCnOeA+AjDfKJc1zWCOcLC/0SquJpEHJ/O4X80IpTZbfhs4wjo6DAU9WAc9KsukQfZxIzmjGgTLx8QRxTG0r0cMHIxlsIZNF/75l1QUs5txKZf4y08CBk0MaXPUtGYZNMUHHLJtiUH1z7VTwpH/MPbVmbadRoMpTBOvioNkfKh04+fi3wTE/sOcvCzIKSr5rfmQHzLlfY2nBE/0a1xnRy/ZldMi8M5X9mb5D+8l1baAOgyIigLpBTbJNFQDhOjXqijbXJiqv7Q6BK645comhrHvO/z7HEzeHQrZ88uvTnT+GQ+JD/TjFJ78J//hHHrbPwookc/OWxWt8yFeeLniA9Amd++HgcFy+K54dXdtBHY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf7c516-7e24-49d9-3c58-08d752a80976
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 02:16:36.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3MciAvbNzEUrBKFEK0KKzk+QI993xT0z9NSerHejKSLORRgZL7Bfj/D0xrFZRjJ0zf0xd9ZdzHcdMlqokG4Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB2273
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have added nfsv4@ietf.org to the cc list, since I think it is important that
everyone involved in NFSv4.2 be aware of this.

>J. Bruce Fields wrote:
>On Wed, Oct 16, 2019 at 07:53:45PM +0000, Kornievskaia, Olga wrote:
>> On 10/16/19, 11:58 AM, "J. Bruce Fields" <bfields@fieldses.org> wrote:
>>     On Wed, Oct 16, 2019 at 06:22:42AM +0000, Rick Macklem wrote:
>>     > It seems that the Copy reply with wr_count == 0 occurs when the
>>     > client sends a Copy request with ca_src_offset beyond EOF in the
>>     > input file.  (It happened because I was testing an old/broken
>>     > version of my client, but I can reproduce it, if you need a
>>     > bugfix to be tested. I don't know if the case of
>>     > ca_src_offset+ca_count beyond EOF behaves the same?) --> The RFC
>>     > seems to require a reply of NFS4ERR_INVAL for this case.
>>
>>     I've never understood that INVAL requirement.  But I know it's
>>     been discussed before, maybe there was some justification for it
>>     that I've forgotten.
No longer overly relevant, since the RFC is now a published spec.
(It may have just been consistent with the old copy_file_range(2) semantics?)

>>
>> Sigh, well, I don’t know if we should consider adding the check to the
>> NFS server to be NFS spec compliant. VFS layer didn't want the check
>> and instead the preference has been to keep read() semantics of
>> returning a short read (when the len was beyond the end of the file or
>> if the source) to something beyond the end of the file.
>
>I'm inclined to think the spec's just wrong.
The RFC is not wrong, although it might not be your preferred semantic.
(It would only be wrong if it was unimplementable.)

As for patching the server, I am not sure if that is a good idea now or not?
- I would like to see the Linux NFSv4.2 server conform to the RFC, however
   it has already shipped in its current form.
--> I think that all extant clients need to handle both reply semantics and,
       once that is the case, patching the server to conform to the RFC would
       be nice.

I have now found two cases where the Linux NFSv4.2 server does not conform
to RFC-7862. One is as above and the other is a reply to Seek of NFS4ERR_NXIO
when the sa_offset argument == file_size (instead of replying NFS_OK along
with sr_eof == true).

Since I now know about these two cases, I can code the client to handle
both of them. Of course, I do worry about others that I have not found yet.

>And how else could a client possibly interpret a 0 return?
The FreeBSD client looped, because it does a Copy in a loop until all bytes
were copied and, with a reply length == 0, it didn't make progress or
recognize an error.

Fortunately, this client is still under development (not yet released), so I can
add code to handle wr_count == 0 in the same way as NFS4ERR_INVAL.

>> On the client if VFS did read of len=0 then VFS itself we return 0,
>> thus this doesn't protect against other clients sending an NFS copy
>> with len=0.  And in NFS, receiving copy with len=0 means copy to the
>> end of the file. It's not implemented for any "intra" or "inter" code.
Are you saying that an NFSv4.2 Copy request with a ca_count == 0
will not work for the Linux NFSv4.2 server?
(I guess I'd better test this one, too.)

>A call with len=0 sounds like a different case.
>
>--b.

rick

