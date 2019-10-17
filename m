Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1DBDB22F
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 18:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbfJQQUU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 17 Oct 2019 12:20:20 -0400
Received: from mail-eopbgr670043.outbound.protection.outlook.com ([40.107.67.43]:7488
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730147AbfJQQUU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 12:20:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGjc6BPVptaFxrUrf3ux7VabkVdoh44AYMVs096C6Y1Asas7tggpJWURgb+cPxmtyWu1B6RTVj/ovzeFf28bQ6hq4YDSkaXYmd1183/2IEzAmRiB8/vLXPsX1Np/cO7yfH2x4twerwuXFCWIhxjarPVg3eZLHLjyW7R9XIoa+qCGXGGQVzwAISremQp6K3uW/Qc0gP469I6P/l93Em1geJNlkTi9jVQ5jDazMmole2EFANBWVL+dgAMpMVQ5MhPFU2/YKbYww7hLbWbTTDTrE5Q4z2ir1tIHxOOHhAwprIV38u96/p8xx0jk+Bkxcja8bpRCs6siCnlKPPNM77cGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4rR+MHSZdN9lKOdkU8+gSrKBkXq8KCUrJdW7MrEl3c=;
 b=ijHbTsVpdJqU9+3zr7VKdmo6Yavvhga2/ePVI9/BQ1yAT02GD5ItzXL9NtXbDww5ql5hd+fNOZE1R5ea+JvAmrADhZ95z0JWso0gspERo1a6x02Sz41EjLSmbnIaTg3k0G7HPwzFG4btyreIONR7v1b1XXKLE8l+/bYOH50yLrDATnJJtoSsiQMihoALvExWYo/6StEAyH0bsEe8aqK0UP3IL9A37mio+1c60vPTBXYz8tAhhnzjliamSyHr/GRn5F3wKG8kDu96Aj5jq0ZDzmvfOMTXYqsYQ/UpQFUzwn6wazIfXhZ3SjOql/wFmR6Ve4KOhbZcEZCdEg0unm0IJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM (52.132.66.144) by
 YQBPR0101MB1844.CANPRD01.PROD.OUTLOOK.COM (52.132.70.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 17 Oct 2019 16:20:17 +0000
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3]) by YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3%7]) with mapi id 15.20.2347.024; Thu, 17 Oct 2019
 16:20:17 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Tom Talpey <tom@talpey.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
CC:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Thread-Topic: NFSv4.2 server replies to Copy with length == 0
Thread-Index: AQHVg8vy6XBow5lmmE6IMuCp/6tuzqdcytI+gACiuwCAAEGxgIAACqQAgABZSj+AAOK5gIAABIMAgAAFGTM=
Date:   Thu, 17 Oct 2019 16:20:17 +0000
Message-ID: <YQBPR0101MB16525B93EA77EC9F6937FFFADD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
 <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
 <20191016203150.GC17543@fieldses.org>
 <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191017152253.GG32141@fieldses.org>,<6f98f9ab-bf81-3a4a-64e7-2abef60e20d4@talpey.com>
In-Reply-To: <6f98f9ab-bf81-3a4a-64e7-2abef60e20d4@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0339d5e8-338a-465e-f585-08d7531de624
x-ms-traffictypediagnostic: YQBPR0101MB1844:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <YQBPR0101MB1844960E3C640A4C73717C10DD6D0@YQBPR0101MB1844.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(45074003)(51444003)(189003)(199004)(71190400001)(76176011)(7696005)(486006)(102836004)(54906003)(476003)(316002)(86362001)(11346002)(446003)(25786009)(14454004)(71200400001)(52536014)(229853002)(99286004)(6506007)(8676002)(186003)(81166006)(81156014)(46003)(8936002)(6436002)(966005)(305945005)(76116006)(66946007)(5660300002)(66446008)(64756008)(66556008)(55016002)(74316002)(91956017)(66476007)(6306002)(9686003)(786003)(256004)(478600001)(33656002)(6246003)(2906002)(4326008)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:YQBPR0101MB1844;H:YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2C825KGn894u9oK6DurN2RFP5QlL390ZxBZ4IL8T/jTr55gt4uWcc41DR24sKvhR1GU1o0LU44uJpKX5hAhF7q8zZZbU3yO7I4RtblPpBlyZ6H/3H2xjL8ApbEvwpVjgLUSMhqOE2fjod+7g4+Ye1kSUhbKCZXYHfJCTPV9G3OBdXdSlaiW6zn0soEURAWazraCGi987VcfPSMIn9U/7D6YLizi8kVRdiLgAUq4p4Hi2SWePZrMOw6lXpceLNqp7DlKh16Muw3WuO3EuaAn+o6THYO3chKeV1esD0/NiKrcy0XBrupaPJa+b9TzpLD4zDe++2KPBHxClg8oFEdtMh9kLpegrhY1jTiKKx54+jWFbr4srZE75mGfehKap+XfPnj1omnzSfQehv1hrMfo6IxMZaNnZLKzbdrRyqn9JU7JNs+Tw7O1n/SbeujUDJyiA0/wXuYcn5+IczuYTSVBNyQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 0339d5e8-338a-465e-f585-08d7531de624
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 16:20:17.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ooQMjlyceQmsZFxZCCWKmx8wh0dXDEpUxA5agrcrFSNcg0AcSPZoiOOk6zXdMqLX+nquYt1UbvlR2UqdjrWFfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB1844
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Tom Talpey wrote:
>On 10/17/2019 11:22 AM, J. Bruce Fields wrote:
>> On Thu, Oct 17, 2019 at 02:16:36AM +0000, Rick Macklem wrote:
>>> I have now found two cases where the Linux NFSv4.2 server does not
>>> conform to RFC-7862. One is as above and the other is a reply to Seek
>>> of NFS4ERR_NXIO when the sa_offset argument == file_size (instead of
>>> replying NFS_OK along with sr_eof == true).
>>
>> Huh.  Looks like that's documented behavior of Linux's seek.  (See the
>> ERRORS section of the lseek(2) man page.)  Looks like Solaris also
>> returns -ENXIO in this case:
>>
>>       https://docs.oracle.com/cd/E26502_01/html/E29032/lseek-2.html
>>
>> And freebsd too:
>>
>>       https://www.freebsd.org/cgi/man.cgi?query=lseek&sektion=2
>>
>> I wonder where that spec language came from?
>
>Those manpages look like ENXIO comes back only on sparse files. Perhaps
>this is boilerplate from v4.0 before this kind of thing was common.
As far as I know, a non-sparse file (no holes) behaves the same as a file with
holes in it. (I'm not sure if the POSIX draft is clear for the case where the
file system does not support holes, but I think most implementations handle
that the same way as a file with no holes on a file system that supports holes.)

>This should at least be discussed on nfsv4@ietf.org...
I think there needs to be a discussion on how to best deal with cases where
implementations have shipped to users with these glitches in them.

I think it might be better to document them, so that client coders can
implement work arounds (I am doing so for the three cases I've found)
instead of the server being patched to change its behaviour, causing
potentially more interoperability issues.
(That's why I re-posted this to nfsv4@ietf.org.)

>> Our NFS server could translate an -ENXIO return into 0 and sr_eof ==
>> true easily enough, assuming -ENXIO is really only ever returned in that
>> case.
>>
>> I haven't tested, but from a quick check of the Linux client code I
>> think that would require a matching fix on the client side to translate
>> sr_eof == 0 *back* to ENXIO.
>>
>> I don't know if it's worth it.
>
>What Bad Thing would happen for the difference?
Well, for a POSIX draft style client, the only effect is that a client may be
broken (not handle the sr_eof == true reply correctly) without the
implementors knowing that, since they tested against the Linux server.
(I believe this is the current status of the Linux client.)

For a server implementor (I get to wear both hats;-), the server can only
generate one reply or the other. I've implemented both with a tunable
that can be used to flip between them. I default to the NFS4ERR_NXIO
reply, since that is what the Linux client expects.

As for the Copy issues, the client can easily handle them, but the client
coder needs to know about them.
At this time the FreeBSD server code only implements what is in the RFC.
This seems sufficient for the testing I've done sofar.
The case that I think will break would be Linux code that does a
copy_file_range(infd, NULL, outfd, NULL, INT_MAX, 0) to copy an entire
file. I'll test this case to-day, but I'm think it will just get a NFS4ERR_INVAL
reply from the FreeBSD server.
(I can make this work for the Linux client, but it will take another "cheat"
 enabled via a tunable.)
--> Part of the confusion here comes from the fact that the Linux syscall
       semantics for copy_file_range() has changed. (I also where the
       copy_file_range(2) hat for FreeBSD, so I've got some work to do there, too.)

In summary, I think that, since Linux has been shipping this for some time,
documenting workarounds is a practical approach.

rick
