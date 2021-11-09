Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAE644B932
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Nov 2021 00:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhKIXGZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Nov 2021 18:06:25 -0500
Received: from mail-eopbgr660044.outbound.protection.outlook.com ([40.107.66.44]:47150
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230221AbhKIXGZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Nov 2021 18:06:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUZbI0ZKZnRGgp6X/Tx2AJYxS5ERsbewSjZMN+z8r/tpERI4W1Wh81SFgHHH2ayP9UHL8OwVqHvZxL3L79B5TkTVfI24NXlAGShof66yf9f8AJPOudHnLNOUk/wwwQ9WWbTaukKJ9p65SfF2UTY+SV6f8iO4OCMlOVFRMq6lhxri1S73XHNplIuHAVIY7BkNaAj4R8U7Fbm2mZjZybpVwyEJWiagzfig7Q8BidRMUU/90QG+Ghy+GQAd8K8pML+4We3qoiQUVCyMZKJeSFeDWqkJsiJENhvDJRyUoSN7EcEA0ussED86q/WyRkNz7mO0+mZcQd6G3StwMv6pEdk6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhIg/C9eYRsLcpKdau9oW/K00JUxOmh4Q7T5rpX0RJo=;
 b=dRvtKzz6oEmvIcz/GiOWtLYQN1UEYEUierL8xPGZlofkibDuoNjKt3rLd69De+N5i84BDdfiGL90MooGGIPtyysNrZmano7BWKc1MKcn8wJbRQaBrESGaYNtP0ib9u9ccctBhzg437QJ9Otjl8n1CvkZyNh9oWe6ME08rWkElWewrlZLiFU2wOIe06OQ0i9XBvEhsM9/wtKjJgKNFMDaTK+2qD/WbM2MFKYwSdk1NcfjaJlNMP/p/vIdsiYlj/gaGp7BW15y25k2AwmBSfo+3b5TcyLPHwsGuPEZmC0ew0op8KlP+Owv/Z53UEyhzU865ujdDQxIXDj6ziEeWP1I5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhIg/C9eYRsLcpKdau9oW/K00JUxOmh4Q7T5rpX0RJo=;
 b=a3WwlDjGc0fnX56cO2e34MG/+Tq+5DXrC71RwF2nXJnQ0nG3Jt6gp0tZEeadcDzWAVr4Q4pzTq5JmWLp611ENjUbH5DP+XPQQrzFheU992i5/NuaxvqgeHpgB6WOhnUP5dtjzXwTLjYITXwnVm33QTNN1PGE4Xvzu6ez0WFqvRuiCvq+wDQssHx7VPIPnEfookB4G+rP/c+Wok1hggudp9HZ9Q8TRlNvD9P0xjMJqxfCG2yTOEPA/sWht5KSrc4NmJnA+NBV9zlN0OOJw3SjoBJkMgiPrFhRDZY+ina7vUMABczQseUQLHUDyAMzwQb75RJxHFEQIhEk0F5iLbLV2Q==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR0101MB1624.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 23:03:37 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7091:13ac:171f:1c12]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7091:13ac:171f:1c12%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 23:03:37 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Topic: NFS client pNFS handling of NFS4ERR_NOSPC
Thread-Index: AQHX02npTtMx6BHF6UKeTijQBaPp7Kv3MpsAgAG1HlyAAAWdAIAA46etgAIB+SM=
Date:   Tue, 9 Nov 2021 23:03:37 +0000
Message-ID: <YQXPR0101MB0968C509A9F6BD86E875E79ADD929@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <YQXPR0101MB09684E992DCE638E82493DA9DD8F9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
         <02a742e36c985769c95244c1340f5fc0601fd415.camel@hammerspace.com>
         <YQXPR0101MB096808F771834883F48894DEDD919@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
 <82059fc8fc33631bfba14fa2f5ec5db494667fc7.camel@hammerspace.com>
 <YQXPR0101MB09688F3BD85EEEC8975E91FEDD919@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQXPR0101MB09688F3BD85EEEC8975E91FEDD919@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: a31d027c-bcda-88bf-b258-7af2ceda980f
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none
 header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44f3206e-bcce-47e9-763c-08d9a3d529c6
x-ms-traffictypediagnostic: YQXPR0101MB1624:
x-microsoft-antispam-prvs: <YQXPR0101MB1624220F21DD9261529CC8DEDD929@YQXPR0101MB1624.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUcySoP7FV/rbeB+t3r7O9czKskYqgYL7AXr+Qpr0eY0vzH2iBrbBl+I+w9dQSNKvrUs24g3+QZCDVNk2grXL/7sZRo66SFEmqtYJyu5g8ujeZKKO13c0Mmzz37wXJEZzY59PBDUWjJCvv0CsaEDaeqtzQSBlzhFzjp02/9i6UaLtYo9u+hw7EK8eiRtuPuo8JWDOB9isgooykR9wwt7YvbwlLzzINb5Mjfu9H2/bX2WNscDFUG82lefWUAr9njZY6TUeCywgE1B/UNdQcS0/zAdTyr+TXSw9cH2IRoUP5AVmgaWvprhPgNtkH9PUT22EqV7rK3l9v7dpGLsXYQzsyoqf8SX0KvMlQgW9ZewGpJwU8g+9RLY64n1uVpvDp/0xcYYQbi5KoO+lMgy95jxBElhpo1rJfELNXTj2nlPXmrBiU0WWqCwvFQZZpC5ssWp5fKZu+WouTv8T6GU7ZdXEXqadAkwFMjNVNv/qKMB9MBXRF/3XcLN/4LY+iVt+0kIAt801YymJ5PhWBZfBw/PnTrX+QBgJAMAPIUtEOvnrm4vqTj9XtOKT38P5WFR9pBQwGhfTQYRRcaDzozHOEQ4gXZpiV4sf7FlG4er4dzfemga8YSCw15s8/b4dMSKsl6xZUYoNu6b1b6/7eSOjwZEKM/9/K/rOgCPy35GGsXctvIqsOCWbQXAWRXehhGyoNbdyGXo7XmhJKftM5nJlgTlIzrvMQInljcaYAUtEKT7OuerfNhNnSlqzvyER/Da/ui7qxb7QbJR8H9ExmUSXjO84nhIjTqYueAzwvh1Aonq3ws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(122000001)(186003)(966005)(66446008)(38070700005)(7696005)(66476007)(66946007)(64756008)(66556008)(6506007)(110136005)(786003)(316002)(38100700002)(86362001)(83380400001)(2906002)(508600001)(8936002)(71200400001)(8676002)(52536014)(9686003)(33656002)(76116006)(55016002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nLp+wIFG1j7V3jCn8ezHiFgo6BwzwiFsS/lZhxvEBCg8TnpQVN3Tkt/wJe?=
 =?iso-8859-1?Q?9M2/SZpESiKWaRVs1l0ryIJqpzoqdQ2EpUPSePRAcVQZHoC4NhOURxCS84?=
 =?iso-8859-1?Q?tIAwy9tEV0S5nYnat2Rl6QhE0iZuGgDtc7Msdzl7JtKxchYQ1sH1Ui+KQJ?=
 =?iso-8859-1?Q?hYL/SGe1qmqZoxtVgX5IjipSNUxGd1YWdci8nZaF4H1O3OGJee3rdoOECI?=
 =?iso-8859-1?Q?l9NzkX9ktCpIWYXBaP1ICsbKsqwXxs+qP5nlqqA1bwUHoF+/e2nlIamgyI?=
 =?iso-8859-1?Q?ghbvQWP6YQBW2RJd6ZTP9Ah3+VzDqxroUv2wIWDh3p2llPrzjxqrs/i+E5?=
 =?iso-8859-1?Q?/9orYlmCqcurrNNKc416eFVD67yNNKn85zWpWjhQAc7AjhyT0DHnfvjXf0?=
 =?iso-8859-1?Q?iOjR79RdMZy//N03BJ5TDXefxYRv2w6rCO0ZirpknP+ZeusCBZDMD0+P4+?=
 =?iso-8859-1?Q?8Q43q1WV/JZ0b/r4zh60GG7PZnrMyj8l10XKWpd2ltec+rPihsyOjWw5Fl?=
 =?iso-8859-1?Q?ZMeDW47hOWqzddpLhdVMYCusC7rMRf3HZXm+Dw5P1t9YcssXW3Ue4UX2sc?=
 =?iso-8859-1?Q?wlAiL7st/MWSsBTYKvsqJTuSKE+kI0TduWqxE5SioCRLERGnEDSHeTJSnq?=
 =?iso-8859-1?Q?O+j2JdD3NKr/bS5E+9cI3bXQNEfZxZHwC8MAldoYpBtpSiCaSVMdxGXdaD?=
 =?iso-8859-1?Q?3j2WpTgpCwN1zSCS4HsKgP2/kANzUZx4X3b3YJ8yQu8n6z0zJvlp0dBZnv?=
 =?iso-8859-1?Q?mSeATGHCXwjFLaV/O/Myd+LgNvw0A1OE5xQ5t/hLAvpn8HSnV0+Yy7Hf7O?=
 =?iso-8859-1?Q?nedkf3Ch8t5g0cffQ4tMKVtrqNx20wUIa+OWn4ozrKFgWagqsw5EN2vqds?=
 =?iso-8859-1?Q?0KJn4IkFNe5O90uQ/xaZ+Mtg5llGycNm4CLnGx61Ea1/obMvwZDg83Vxoq?=
 =?iso-8859-1?Q?kIVAl/ZmbFmQSGJKGx57aZ73zmp5AVkxcDyIDHdTCjqAetddV6ng+PAdyu?=
 =?iso-8859-1?Q?hWgA7bBP5JCpPRiyN0oLbTcapCsoMWJrQTvonNj8KTYoTcgN8WqADmozlO?=
 =?iso-8859-1?Q?MtMzhHz7fW+yjEnBi/ylHgXTO4z8VYz7sLfZniYQYbthuZcVN5KiCFB1Cl?=
 =?iso-8859-1?Q?cp+lT0JQMBSuYBq68DsTvq73MVVG4a3/z7leq7SSBtcog54gfxDUDj04Ci?=
 =?iso-8859-1?Q?vhySu5/KDGprlT/CFJKKHczm0sCb00rqHyqolY4kNVQrmCKhSWYkh9KHSl?=
 =?iso-8859-1?Q?0RVmmtz4pt+APl69f2U3GUtQIcymu2oFtGC+K2YGLCviplMyN3mf4KzgHa?=
 =?iso-8859-1?Q?g3bXhP5gx/ob/EJjhKrTcQvWy1O5bc3VmvGBLA/HvWh4CEL/5JSkXbr7ES?=
 =?iso-8859-1?Q?Aa3Su/LbnwFssbXipo9TW7ZEYciVOyiNC/igZcQhyAa99I9KJ0glI+Sdbs?=
 =?iso-8859-1?Q?VuRj+fa3bRnOQodyA6g5WuRHG7GphLABN++YFt1O8BXDKyZrU0G2DK/9dM?=
 =?iso-8859-1?Q?vESx731CTe/qHsX4ys5KgT4WZUkiGyMpDNlTeHInPkltrni9FMuIZ9K3Xb?=
 =?iso-8859-1?Q?UA4E+3gssooYc9y+am/LHu71BYtrCfU8ZClaMvcNdIi+fwOudQiJtm3ijF?=
 =?iso-8859-1?Q?Y9j1XajYvTlXQciOMb4YClPWcI3UcM92RbMIzl43tFQdvromhUZK9HbKfI?=
 =?iso-8859-1?Q?i3B93SK+usyAHj5GSl9pkre1vS6pa7dw/lofPGd3jMF9+feE1aB9sQMp0A?=
 =?iso-8859-1?Q?cv6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f3206e-bcce-47e9-763c-08d9a3d529c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 23:03:37.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjykcT0PNV6S2+8GFNshorqgs44ocXQMJC63iS+XWxu9jFjrdoPrWHhF+YlRXv4cnyxxLySJkWhMQ/s77UkABA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1624
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rick Macklem wrote:=0A=
> Trond Myklebust wrote:=0A=
> > On Mon, 2021-11-08 at 02:27 +0000, Rick Macklem wrote:=0A=
> > > Trond Myklebust wrote:=0A=
> > > > On Sun, 2021-11-07 at 00:03 +0000, Rick Macklem wrote:=0A=
> > > > > Hi,=0A=
> > > > >=0A=
> > > > > I ran a simple test using a Linux 5.12 client NFSv4.2 mount=0A=
> > > > > against a FreeBSD pNFS server, where the DS is out of space=0A=
> > > > > (intentionally, by creating a large file on it).=0A=
> > > > >=0A=
> > > > > I tried to write a file on the Linux NFS client mount and the=0A=
> > > > > mount point gets "stuck" (will not <ctrl>C nor "umount -f").=0A=
> > > > > --> The client is attempting writes against the DS repeatedly,=0A=
> > > > >        with the DS replying NFS4ERR_NOSPC. (Same byte offsets,=0A=
> > > > >        over and over and over again.)=0A=
> > > > > --> The client is repeatedly sending RPCs with LayoutError in=0A=
> > > > >        them to the MDS, reporting the NFS4ERR_NOSPC.=0A=
> > > > >=0A=
> > > > > I'll leave it up to others, but failing the program trying to=0A=
> > > > > write the file with ENOSPC would seem preferable to the=0A=
> > > > > "stuck" mount?=0A=
> > > > > --> Removing the large file from the DS so that the Writes=0A=
> > > > >       can succeed does cause the client to recover.=0A=
> > > > >=0A=
> > > >=0A=
> > > > The client expectation is that the MDS will either remedy the=0A=
> > > > situation, or it will return an appropriate application-level error=
=0A=
> > > > to=0A=
> > > > the LAYOUTGET.=0A=
> > > Thanks Trond, that worked fine for NFSv4.2. I tweaked the pNFS server=
=0A=
> > > to reply NFS4ERR_NOSPC to LayoutGet and that worked fine.=0A=
> > > (This is triggered by the LayoutError.)=0A=
> > >=0A=
> > > For NFSv4.1, things don't work as well, since there is no LayoutError=
=0A=
> > > operation. The LayoutReturn has the NFS4ERR_NOSPC error in it,=0A=
> > > but that doesn't happen until it finishes (which doesn't happen until=
=0A=
> > > I free up space on the DS).=0A=
> >=0A=
> > Hmm... The ENOSPC error from the DS should in principle be marking the=
=0A=
> > layout for return. You're saying that the return isn't happening?=0A=
> Not until the end, after I have deleted the large file, so there is space=
 on the=0A=
> DS for the writes. It is in the same compound as Close.=0A=
> The packet capture is here, in case you are interested:=0A=
> https://people.freebsd.org/~rmacklem/linux-ds-out-of-space.pcap=0A=
> (Taken at the MDS, so it doesn't show the DS RPCs, but they're just=0A=
>  a lot of writes that fail with NFS4ERR_NOSPC until near the end.)=0A=
> =0A=
> If you look, you'll see it gets a layout for the entire file first,=0A=
> then it repeatedly does LayoutGets that are a little weird.=0A=
> - For 4K only, but always on for an offset that is an exact multiple=0A=
>    of 1Mbyte.=0A=
> --> Then, once I free up space on the DS, it does the compound=0A=
>       that includes both Close and LayoutReturn (which has the=0A=
>       NFS4ERR_NOSPC error report in it).=0A=
>=0A=
> > Does a newer client fix the issue?=0A=
> This was 5.12. I'll build/test a newer kernel in the next couple of=0A=
> days and report back (it's an old single core i386, so it takes a while;-=
).=0A=
5.15.1 exhibits the same behaviour. The only difference is that LayoutRetur=
n=0A=
was in a separate RPC from Close, but still didn't happen until the=0A=
end, after I free'd up space on the DS and the writes to the DS=0A=
succeeded. (This time I had delegations enabled, which might be why=0A=
the LayoutReturn wasn't in the same compound RPC as Close?)=0A=
=0A=
rick=0A=
=0A=
> rick=0A=
>=0A=
> > > But I can live with only 4.2 working well. I can't be bothered=0A=
> > > endlessly=0A=
> > > probing the DSs to see if they are out of space.=0A=
>=0A=
> > Agreed. Your server should be able to rely on the layout error reports=
=0A=
> > from the client (either in LAYOUTERROR or in the LAYOUTRETURN) in order=
=0A=
> > to figure out when the DS might be out of space.=0A=
=0A=
--=0A=
Trond Myklebust=0A=
Linux NFS client maintainer, Hammerspace=0A=
trond.myklebust@hammerspace.com=0A=
=0A=
=0A=
