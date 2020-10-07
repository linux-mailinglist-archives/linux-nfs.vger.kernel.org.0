Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F28286BE3
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Oct 2020 01:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgJGX6I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 19:58:08 -0400
Received: from mail-eopbgr660050.outbound.protection.outlook.com ([40.107.66.50]:27456
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbgJGX6H (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 19:58:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF2xNYrt1OgJ+mW0OzDt7y9ejzZ1usRQYyQ394lZxH0Dg9iK32s4e4+oRCdd7DC1Dqf4+bV+bsB9Cn37pBqQjh4uXpHNdovylW6Z4Xw1QOk0/X3FVN+YNasRDIIKhcSjjrGzQ30bmEPTIlaY88GrWMY/iXx0Ovk6B27jNh1mtmG+Awr06Fn594x4I1veurba1I/tjbB6ZSPm83HudL5uKypCZ2nd9ByqreCSxGWXh/M4v1anssg+tyiYQ3D5oLp8J5tf/1PdYy0xfu/SWK+RQH+uVL+5I82y1WSXymJ/ZSAHbrbffyfJ4PS/2KYpG2C8hgYFkODe4rt32BnowsFO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40iHTccjmBKUPDrptGXqc8DumpZ+vg1YKfQMmCgXLVE=;
 b=C/S0TCcrxQ9iL+wLE9NESnnQO+wA0VRyCM10pQi36Mb3LtlAEgqN5jjAGnth0+Mia3iP/kY49+dPNPprdphiPUf3BdTmIpSNfG2bi2d/PlWcztXINWSx0o94rTCLnRFUeSm3BrKVU7v8N4ZS9mqDiszkOjUmA7TmDX7/gxK2f9O4Fc6shB9rd0qjfi8+BgyO5yP4GGr4thpRaJbrKxX8XdfjYIuq66D2+aajZsHCKtRtB0wo/tg8CQ/fwodH6MWGAbzbz9vNV+YX5B95yRD1CcCcb5nGXzZxfPCbQ1L9QnZ8xNxHhRJ+9F2tQEFkUi//axF8Fc5YvY2SE8ANJzrOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40iHTccjmBKUPDrptGXqc8DumpZ+vg1YKfQMmCgXLVE=;
 b=IYXxoBTsT7l3tWQHrexnEJZLKTecKxOU3hYRlwpPNG5gR9peQ/ZqHS+mz7Z9hXZGIPfdBviTDfDNy5VUH4FJX4kkMGFnhzNbLsK57lNdbIOL/EelmVX9KPJbjY0UbncFOHYlb7FK7grD8/LEmwHxFQ6Y+t6PAPV8JXqDtUyX3jfvdRzu766uhwGEtOMPLKMrViTvhESWeXrjx0uc+s+Z6lYRAuASAHXT8Oun1Nm52hmM60Py8MiYX4MH2rtlflBd2t/v149vshQEF3It1xe9HgO9m3aHUH66ZwkRm4selDr7h1G7NStBEXhSHWIdTq9p2mwdsKQXoO8tpj1+llOBZA==
Received: from YTBPR01MB3966.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:24::27)
 by YTBPR01MB3694.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:25::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 7 Oct
 2020 23:58:04 +0000
Received: from YTBPR01MB3966.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::687f:d85a:a0a3:bd20]) by YTBPR01MB3966.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::687f:d85a:a0a3:bd20%6]) with mapi id 15.20.3433.046; Wed, 7 Oct 2020
 23:58:04 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Frank Filz <ffilzlnx@mindspring.com>,
        'Chuck Lever' <chuck.lever@oracle.com>
CC:     'Bruce Fields' <bfields@fieldses.org>,
        'Kenneth Johansson' <ken@kenjo.org>,
        'Patrick Goetz' <pgoetz@math.utexas.edu>,
        'Linux NFS Mailing List' <linux-nfs@vger.kernel.org>
Subject: Re: nfs home directory and google chrome.
Thread-Topic: nfs home directory and google chrome.
Thread-Index: AQHWnJhPwrgZeWL3Q0WXswuosTP8pKmMHU6AgAAXbICAABJOAIAAKlCAgABdcDQ=
Date:   Wed, 7 Oct 2020 23:58:04 +0000
Message-ID: <YTBPR01MB396679E8135015A360ADDC79DD0A0@YTBPR01MB3966.CANPRD01.PROD.OUTLOOK.COM>
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
 <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu>
 <923003de-7fcf-abee-07a2-0691b25673d8@kenjo.org>
 <20201006181454.GB32640@fieldses.org>
 <07f3684e-482e-dc73-5c9a-b7c9329fc410@kenjo.org>
 <20201007131037.GA23452@fieldses.org>
 <031501d69cb6$f6843a10$e38cae30$@mindspring.com>
 <1FB71E67-8814-4C62-A9E0-CF7A4D10735F@oracle.com>,<033c01d69cd5$46358cd0$d2a0a670$@mindspring.com>
In-Reply-To: <033c01d69cd5$46358cd0$d2a0a670$@mindspring.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mindspring.com; dkim=none (message not signed)
 header.d=none;mindspring.com; dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a58cf9e-abc8-400b-ec9e-08d86b1cd4c1
x-ms-traffictypediagnostic: YTBPR01MB3694:
x-microsoft-antispam-prvs: <YTBPR01MB3694C0E5D1BE27BEBF84D15BDD0A0@YTBPR01MB3694.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vlJgp/vHbfWqsmGb/+BFPt85ouiDhahd8cfK4vO1t8g4+sxUnG88YAoxpZQANIX1JarjkH6EyiEfunMQ01pwR/dnQIWnjw56h4Gd/HVjfVoG/ov/Jm3i1hW+lkdNilR0W7h9hPEMJwhXnyIxLkTGAgvQLzsSWJk3w25p/5qRtDbsARitnTeJGsc8IAAUoFUvcAPs56YkPF8vcLcZ7ndBUfzjFnhivoSoTkJWcGjDYiA+P+HGoZxEUqm1yu4Ms+90Qolfn/g0nqws8lJZhqJW3PCdj6N0LCQTVweJJ1vLqeH75uQZkbLs0kp82K0hDPQAObvVB6rKaChD8C6MDo+YsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3966.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(396003)(366004)(4326008)(53546011)(76116006)(66446008)(66476007)(64756008)(6506007)(66556008)(9686003)(86362001)(66946007)(186003)(71200400001)(33656002)(83380400001)(8676002)(7696005)(478600001)(786003)(55016002)(316002)(54906003)(2906002)(5660300002)(8936002)(52536014)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jAwibvozUlq/eChx4sgXTuWI2hBWeoqXUsE1nNxl8QFPD1s4oli+TIDOeVSBodaGR9aG/sT2+79jutiQZCb557ROIKY0YgHvRD3g8zY34JqkOF6xmF0YzFhZxQyPLSKbSsi40iN0OtP58/tBlyBRZpyOakykFn17up3feGyri+W2Eu+ms9QI6jBL8gEi245wyVBs20XDLzIfngZwbRe5kiey84sqrVOgWlCYeZeWkSwKcaUHi3c5g9yNqDgRKZO+b6aTy8doegkEel5jLgtBRJUNFQWezxmrj1DK8gHHNeiLz/Jrd6l8xrzZzldUNjFUYn6kD1jMt/zfV0LiDP2P/0LVR1wz+WcQq4+vtkDwFWuPrQfoM8VVJB0ulz5Ge0XGQMolrtpTI/vJOCXdp//l8/odLA1Yzdo6ifJY9KmVBW8UBmMc4XGfTLD3ywpIgXd+Q85J2GPBDGU+Bd0N+18r/9VHAUun9Bx+B8wE48ynDHOH2JV3/McogkC4DuUT8ErDlUOOKB53dXUOFXyx7DViwHRevVVxzQMLs2jUm9ErmCq77skrFdyx0h/RqlqfRShfozhuE0AjHnckcFI7yMbIHrp4hoxgrgIunOzCim3ywTP7EgOVJoDWu6z6YiksTao8AcM7AZIorLnchAokSe2uB6wX5VVz5sB0+LguWONZbCB82NMqv9RAYFKzTNKpBbdvp9XvkyUsiaN2VtvD//5w8Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3966.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a58cf9e-abc8-400b-ec9e-08d86b1cd4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 23:58:04.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/6qbKHg0Ux3Khc8RX1wT0k1oS/Xc8OeQfuuTwQwPmO46yXDJ2TVuTm4DbXNrw6rRBTP+6vl4gQwlRR/XO5+5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB3694
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Frank Filz wrote:=0A=
>> -----Original Message-----=0A=
>> From: Chuck Lever [mailto:chuck.lever@oracle.com]=0A=
>> Sent: Wednesday, October 7, 2020 8:40 AM=0A=
>> To: Frank Filz <ffilzlnx@mindspring.com>=0A=
>> Cc: Bruce Fields <bfields@fieldses.org>; Kenneth Johansson=0A=
<ken@kenjo.org>;=0A=
>> Patrick Goetz <pgoetz@math.utexas.edu>; Linux NFS Mailing List <linux-=
=0A=
>> nfs@vger.kernel.org>=0A=
>> Subject: Re: nfs home directory and google chrome.=0A=
>>=0A=
>>=0A=
>>=0A=
>> > On Oct 7, 2020, at 10:34 AM, Frank Filz <ffilzlnx@mindspring.com> wrot=
e:=0A=
>> >=0A=
>> >> -----Original Message-----=0A=
>> >> From: J. Bruce Fields [mailto:bfields@fieldses.org] Maybe I=0A=
>> >> overlooked the obvious: if Chrome holds a lock on that file when you=
=0A=
>> >> suspend, and if you stay in suspend for longer than the NFSv4 lease=
=0A=
>> >> time (default=0A=
>> >> 90 seconds), then the client will lose its lease, hence any file=0A=
>> >> locks.  I think these days the client then returns EIO on any further=
=0A=
IO to that=0A=
>> file descriptor.=0A=
>> >>=0A=
>> >> Maybe there's some way to turn off that locking as a workaround.=0A=
>> >>=0A=
>> >> The simplest thing we can do to help might be implementing "courteous=
=0A=
>> server"=0A=
>> >> behavior: instead of automatically removing locks after a client's=0A=
>> >> lease expires, it can wait until there's an actual lock conflict.=0A=
>> >> That might be enough for your case.=0A=
>> >>=0A=
>> >> There's been a little planning done and it's not a big project, but I=
=0A=
>> >> don't think it's actually at the top of anyone's todo list right now,=
=0A=
>> >> so I'm not sure when that will get done.=0A=
>> >=0A=
>> > I've had courtesy locks on my back burner for Ganesha though I hadn't=
=0A=
thought=0A=
>> about that there might actually be an important practical issue.=0A=
>>=0A=
>> We've found that instantly bringing the hammer down on NFSv4 leases has=
=0A=
>> negative operational consequences in environments where minutes-long=0A=
>> network partitions are part of life.=0A=
>>=0A=
>> Extending the lease period impacts the length an NFS server is in grace=
=0A=
after a=0A=
>> reboot, so it's not always a good solution.=0A=
>>=0A=
>>=0A=
>> > Does any other server implement them? If we suggest this as a solution=
=0A=
to the=0A=
>> Chrome suspend issue, it might be good to assure that the major server=
=0A=
vendors=0A=
>> implement this.=0A=
>>=0A=
>> We think OnTAP does, at least.=0A=
>>=0A=
>>=0A=
>> > There is a problem with the courtesy locks for this solution though...=
=0A=
The=0A=
>> clientid is still going to be expired, and the locks are associated with=
=0A=
the clientid,=0A=
>> so unless we allow courtesy re-instatement of expired clientids, courtes=
y=0A=
locks=0A=
>> don't actually solve the problem...=0A=
>>=0A=
>> An NFSv4 server is not required to expire a lease after the lease period=
=0A=
expires.=0A=
The way the FreeBSD server is implemented is that does not expire a clientI=
D=0A=
(and all associated open/byte range lock state) when a lease expires.=0A=
However, a conflicting Open/Lock request results in the ClientID and all=0A=
associated opens/byte range locks being expired at that point in time.=0A=
=0A=
I was never sure if a NFSv4 client would expect NFS4ERR_EXPIRED to be=0A=
returned for some lock, but not all state related operations. so I chose=0A=
to expire ClientID + all Opens and Locks at the same time.=0A=
--> However, this is only triggered by a conflicting Open/Lock request or=
=0A=
      server resource depletion and not simply a client failing to renew a =
lease.=0A=
=0A=
rick=0A=
ps: It has been like this for almost 20years and I have not heard of it=0A=
      causing problems.=0A=
=0A=
>=0A=
> A courteous server would simply allow a conflicting lock request to take=
=0A=
an=0A=
> expired lock after a client's lease expired. If no conflicting lock=0A=
operations occur,=0A=
> then the missing client could come back and find its lease state intact=
=0A=
(unless of=0A=
> course the server has restarted or purged the lease for other reasons).=
=0A=
>=0A=
> Oracle has an open design document that can be posted here for more=0A=
> comment and review. We agree that this is much better server behavior and=
=0A=
> would like more server implementations to adopt it.=0A=
=0A=
Ah that document would be helpful. Does the document discuss conditions=0A=
where a server might abandon a courtesy hold on a client id and expire it=
=0A=
out anyway? For example, to conserve resources.=0A=
=0A=
Thanks=0A=
=0A=
Frank=0A=
=0A=
=0A=
