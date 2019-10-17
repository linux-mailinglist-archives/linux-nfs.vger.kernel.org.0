Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8192DB915
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 23:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438059AbfJQVex convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 17 Oct 2019 17:34:53 -0400
Received: from mail-eopbgr660059.outbound.protection.outlook.com ([40.107.66.59]:2396
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438018AbfJQVex (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 17:34:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6e8olgZNDd6HsEJJq4lsLzFNDgPthfn8DNNzh5UnNKgMKrJY7wUiFYRB1xb2c8dqP5+LvxmbdCpIheZgiHlRqy7nx/yE9W9MHZ/pQooRy8afA7x8oSPYxqSpoTxDB3WY9lApkT7XgFSHbxDGqF8uggA0YA02/5pljAIJrVZNE9Sco61521MwmLTuU8CoMszSDpAscoM9F8s1KNAQsstTKiFlJRzpC0+Csq4NUT/igFMlatLP8kllFDIPDu+P4CJtuw0rvlcTS7zzhlhdRa0ghDgRG8+mGVInIIpKMA4dCgYGPhArpViTtwSNieZvk708V3tJWrLWJeSPZBYRuiXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzg/PKlRd/IPogcXPZ3hdbdgvMQ7qOTZmyjj+n8KhRU=;
 b=U45Jto91L/Lw7vH9BIArDqWP77rrYGKnh+cmVwDZgx5MltHBVvahmSh7jnwE5F28vuuGL9YAs5phOglH3JCChaU4DB5PqLEUmmsTwrdQRnjtPaijWc5qaTySRwcBrBh1ESl4EtJmxT4cj1IMdkKwtJe4zVQ+Ofd/V5nINErGJIAWP8Ejmt3dNyu9XmwZGbLgGx7RazEClMlQk5oSumH6NW5LE98qPd/4shxhihuGeknrQx9dRF7L9k1E7A9nMDxPgOukJ4flT8MvjuwXsFO60y/JcJh/8heqKSaHBLUvdctys5jsOnJMWcClhrdufYcFt3EMG+9epW9gAKG/IfqnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM (52.132.66.144) by
 YQBPR0101MB0833.CANPRD01.PROD.OUTLOOK.COM (52.132.72.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 21:34:49 +0000
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3]) by YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3%7]) with mapi id 15.20.2347.024; Thu, 17 Oct 2019
 21:34:49 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Tom Talpey <tom@talpey.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>
Subject: Re: [nfsv4] NFSv4.2 server replies to Copy with length == 0
Thread-Topic: [nfsv4] NFSv4.2 server replies to Copy with length == 0
Thread-Index: AQHVg8vy6XBow5lmmE6IMuCp/6tuzqdcytI+gACiuwCAAEGxgIAACqQAgABZSj+AAOK5gIAABIMAgAAFGTOAABXjgIAARd76
Date:   Thu, 17 Oct 2019 21:34:49 +0000
Message-ID: <YQBPR0101MB1652890C279184B0F9194251DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
 <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
 <20191016203150.GC17543@fieldses.org>
 <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191017152253.GG32141@fieldses.org>
 <6f98f9ab-bf81-3a4a-64e7-2abef60e20d4@talpey.com>
 <YQBPR0101MB16525B93EA77EC9F6937FFFADD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>,<CAN-5tyET7boQ5hTkA7caPS5aWfXq6QaLnsDFx3taWPH_WFL6qQ@mail.gmail.com>
In-Reply-To: <CAN-5tyET7boQ5hTkA7caPS5aWfXq6QaLnsDFx3taWPH_WFL6qQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d45c21e9-ecb9-4f8c-0450-08d75349d6d2
x-ms-traffictypediagnostic: YQBPR0101MB0833:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <YQBPR0101MB0833AC4CDF7E7E8D9E5D021EDD6D0@YQBPR0101MB0833.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(45074003)(199004)(189003)(51444003)(33656002)(8936002)(9686003)(81166006)(8676002)(81156014)(55016002)(25786009)(6306002)(229853002)(74316002)(305945005)(2906002)(6436002)(256004)(102836004)(186003)(71200400001)(6246003)(4326008)(6506007)(476003)(11346002)(54906003)(71190400001)(7696005)(2171002)(76176011)(966005)(478600001)(446003)(786003)(66946007)(86362001)(99286004)(316002)(64756008)(66556008)(66476007)(91956017)(66446008)(76116006)(46003)(5660300002)(6916009)(486006)(14454004)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:YQBPR0101MB0833;H:YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HHzqA1oxTEASPohaIK2IrbKBKQUVjdfD+OrT9a7ac8K2+edNtluUBGqBm0e1AMiiEhEqFjcS1Wkwuf5fZ/2zaNAMFzuYvbtMpfdQbRYCuDIMbhrosDK6+WXYHD3Z7riFc1R0l3wMhezpIqOsaHyaHzZDA6DW3hfvTVV0G7qOvMpDn8zrMcPCyGLIHrKv9v0F/x5ZLyF2Tl9yc8qh3YXeZFHzdzp3uO8XwAacik1J6THL2VGidOvnad4ikHovn4DnnnsGGghWUiwigaCw0N2Nd7snd1fkWVGYX+uTZpkAWz4xQI+C7KP/pXK2SckwZGMJYvn+qI3+k0UodUCnDLN4VJ+dxOCEhF2pSD6bQeJNP4K7doqDxwT3fbwSW+V9Y8eD1vYTBrC/G/fD8ny5I3Ae2x8Mix/MfF+xfR94CEITzPEIqgir2wwjg+4uG5UH4FGosjG1R8fZUUWaKgwpnNwxDw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: d45c21e9-ecb9-4f8c-0450-08d75349d6d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 21:34:49.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWdSQiEHvsdeoZtl55hriAOKDP6ro5uUjJO3THa3t6OlO7fD/mIt5B6civE/TnMc9DZfTw6rPXI2PzCzDQR9Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB0833
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Olga Kornievskaia wrote:
>On Thu, Oct 17, 2019 at 12:20 PM Rick Macklem <rmacklem@uoguelph.ca> >wrote:
>>
>> Tom Talpey wrote:
>> >On 10/17/2019 11:22 AM, J. Bruce Fields wrote:
>> >> On Thu, Oct 17, 2019 at 02:16:36AM +0000, Rick Macklem wrote:
>> >>> I have now found two cases where the Linux NFSv4.2 server does not
>> >>> conform to RFC-7862. One is as above and the other is a reply to Seek
>> >>> of NFS4ERR_NXIO when the sa_offset argument == file_size (instead of
>> >>> replying NFS_OK along with sr_eof == true).
>> >>
>> >> Huh.  Looks like that's documented behavior of Linux's seek.  (See the
>> >> ERRORS section of the lseek(2) man page.)  Looks like Solaris also
>> >> returns -ENXIO in this case:
>> >>
>> >>       https://docs.oracle.com/cd/E26502_01/html/E29032/lseek-2.html
>> >>
>> >> And freebsd too:
>> >>
>> >>       https://www.freebsd.org/cgi/man.cgi?query=lseek&sektion=2
>> >>
>> >> I wonder where that spec language came from?
>> >
>> >Those manpages look like ENXIO comes back only on sparse files. Perhaps
>> >this is boilerplate from v4.0 before this kind of thing was common.
>> As far as I know, a non-sparse file (no holes) behaves the same as a file with
>> holes in it. (I'm not sure if the POSIX draft is clear for the case where the
>> file system does not support holes, but I think most implementations handle
>> that the same way as a file with no holes on a file system that supports holes.)
>>
>> >This should at least be discussed on nfsv4@ietf.org...
>> I think there needs to be a discussion on how to best deal with cases where
>> implementations have shipped to users with these glitches in them.
>>
>> I think it might be better to document them, so that client coders can
>> implement work arounds (I am doing so for the three cases I've found)
>> instead of the server being patched to change its behaviour, causing
>> potentially more interoperability issues.
>> (That's why I re-posted this to nfsv4@ietf.org.)
>>
>> >> Our NFS server could translate an -ENXIO return into 0 and sr_eof ==
>> >> true easily enough, assuming -ENXIO is really only ever returned in that
>> >> case.
>> >>
>> >> I haven't tested, but from a quick check of the Linux client code I
>> >> think that would require a matching fix on the client side to translate
>> >> sr_eof == 0 *back* to ENXIO.
>> >>
>> >> I don't know if it's worth it.
>> >
>> >What Bad Thing would happen for the difference?
>> Well, for a POSIX draft style client, the only effect is that a client may be
>> broken (not handle the sr_eof == true reply correctly) without the
>> implementors knowing that, since they tested against the Linux server.
>> (I believe this is the current status of the Linux client.)
>>
>> For a server implementor (I get to wear both hats;-), the server can only
>> generate one reply or the other. I've implemented both with a tunable
>> that can be used to flip between them. I default to the NFS4ERR_NXIO
>> reply, since that is what the Linux client expects.
>>
>> As for the Copy issues, the client can easily handle them, but the client
>> coder needs to know about them.
>> At this time the FreeBSD server code only implements what is in the RFC.
>> This seems sufficient for the testing I've done sofar.
>> The case that I think will break would be Linux code that does a
>> copy_file_range(infd, NULL, outfd, NULL, INT_MAX, 0) to copy an entire
>> file. I'll test this case to-day, but I'm think it will just get a NFS4ERR_INVAL
>> reply from the FreeBSD server.
>
>this might be problematic for the linux client because though there
>isn't an official use of it but the libc cp might implement this doing
>exactly what you say here copy_file_range(infd, NULL, outfd, NULL,
>INT_MAX, 0). It doesn't try to determine the size of the file before
>the copy and
>just copy max bytes assuming that it'll get a short read at some point.
I just tested this and the Linux client does send a Copy with a
ca_count == INT_MAX.

Truth be told, it worked fine, because my server code neglected to do the
required ca_src_offset + ca_count > file_size --> NFS4ERR_INVAL.
I'm now adding the check, but it will only be enabled by a tunable not
set by default.

I am going to post on nfsv4@ietf.org, to see if we can just "clarify" the RFC
to do what Linux already does.

rick

> (I can make this work for the Linux client, but it will take another "cheat"
>  enabled via a tunable.)
> --> Part of the confusion here comes from the fact that the Linux syscall
>        semantics for copy_file_range() has changed. (I also where the
>        copy_file_range(2) hat for FreeBSD, so I've got some work to do there, too.)
>
> In summary, I think that, since Linux has been shipping this for some time,
> documenting workarounds is a practical approach.
>
> rick
>
> _______________________________________________
> nfsv4 mailing list
> nfsv4@ietf.org
> https://www.ietf.org/mailman/listinfo/nfsv4
