Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA203A0BDF
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 07:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbhFIFdE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 01:33:04 -0400
Received: from mail-dm3nam07on2089.outbound.protection.outlook.com ([40.107.95.89]:31073
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231206AbhFIFdD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Jun 2021 01:33:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulj73uVqY05Y+htLrnvH4yEGEf4hzEs+HRnwMMtvTRO80pmOiRAV6I4MPTNE25+nysbhDCryDFEwmpI8sH55O4zA8NwwRgkK398lC3HcvFYEazr81mtO8Bk4ipPwZbNAweqE+PP/yQ0HvH1uzVtNU251F2SwHuCkK+JLv0kPPo6+w8vNymX3u2QnOLMpPlzmUKvVvNeFbxpgAySc/G5/HCUHAcVwgeqVddZSW94MdgwvvGZ+zfMIR2abKzGeyBgH5aKCBmg+3HzHqWN90VJTCDEJRAFHozt5EOb/BFujNWkZK3uuzgBYZEOPjcFwh9UAUTybJCLHwmW6YPBa3IyVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOjp97oLikMaKJ0OsQ/iC9EPh+RP6x8GueL2hyEaNiE=;
 b=KgykQxhbd9jYYfPpkbTs9UYR5Ogl+t/VIeHX3pH7Zi/UbzZoGj8iEbsodLnyjsL78aTH4rGHzaqBW14c29GRlmzWGgDgrViAkjMmafZR62WlSzSa6nB0QZ8cNBFGOy/D1XWw1LS1txAX44z5XI6IWZJCMnu+puoKfkrCwVBjGIwN6gt7hDRFA2X/7WpTsl4r/4ht80izcLygE5D4CzF+sPUkAQYyNVw7eNYAR+Vs7PwvuqNaxCI3zNXHD85vSby0JMu3O3jPWCS0EnzgCH5LEMOV9FDu7xd4eBSLaVEpsKu6kAuRq0g/XDgsFKaHP2vD81wlYfHMoKX/eNZ9cJurNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOjp97oLikMaKJ0OsQ/iC9EPh+RP6x8GueL2hyEaNiE=;
 b=phI21RzCbh78EeWrht/WKlzEwaFxqFm9NLseV8uvsrOwuZn9grB+Y2QaJMeGoHPthGskl3wj3p0ueUcVhmbRvZHyZGvEuC+iwyZGwrwOC/sA2vpeqmZQJZ2GBXvw0XUkbdZwwBGvedmcom7WUCUbdMKcgSVsjjnLbnM8eTpp6M0=
Received: from CO1PR05MB8101.namprd05.prod.outlook.com (2603:10b6:303:fa::14)
 by MWHPR05MB2895.namprd05.prod.outlook.com (2603:10b6:300:5f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9; Wed, 9 Jun
 2021 05:31:08 +0000
Received: from CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002]) by CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002%7]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 05:31:08 +0000
From:   Michael Wakabayashi <mwakabayashi@vmware.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgAGJKICAAZPoloAADT6AgAAH7wqAABF6AIAAETsAgAAJXACAG0yW/4AAkD6AgADZOSM=
Date:   Wed, 9 Jun 2021 05:31:08 +0000
Message-ID: <CO1PR05MB81011A1297BCA22C772AF836B7369@CO1PR05MB8101.namprd05.prod.outlook.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com>
 <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
 <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
 <43b719c36652cdaf110a50c84154fca54498e772.camel@hammerspace.com>
 <CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com>
 <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>,<CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
In-Reply-To: <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [67.161.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faabf0fc-9e56-49f2-d51a-08d92b07c8aa
x-ms-traffictypediagnostic: MWHPR05MB2895:
x-microsoft-antispam-prvs: <MWHPR05MB28955E246487101278337FC9B7369@MWHPR05MB2895.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x+dZDfl3m916jo9MvW1W3VEMahSBAW5ZmvZW7MPEZ+ImrrunkZN1a4gYwrK8fsMZm0lzPIfIm5MoKiRJ3Cw9E+ahDOA+oVxNNp/pZWwJE43uEAMjMS+rgix+9McMyHUD7pjsXzgyy6PmYvkblBQkZcPtnkGXCoruuMr9CzSR2gbHL6WHjhIO2GugA05x61a7Q/ydzzdvyprtbvGrgBgaFebDm4cS0PbMII1l8wxsrxPwAqmu/NaYF2ZMMlgPGNnKasFg0DBt0VkLFGZ9QlR3yU2BhCyv/8fYhYEKtG9B/iokz7D6lH4PlpH2TAh3MXsfLGRyuaTdqtcwexL0zApMkCHnLc10uKBJKDYeP6h+RvhrW408SaYzxPsbUI3hUZdMguYc8UZpKSy2JApUstybZMx7azBJ6VmoGbm3aIvX+N1+9A07bV+zmoknIya2m0XJJtuKPQrmboYIfMUvWpZShiDw+S8fEttXefriH5Zrdpcc9pjh8fjgSM+ydmYtfJaa5hqBMg2pmeYPr6j88aj77wkGbMTOzpxFQItIQtqNfoVQK0BxMH4Wj1i/csYUWRslVfMbQcmVg0EfDvX0pK53O0xo/jCpubgVh9Fomb10jUQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8101.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(8676002)(86362001)(55016002)(316002)(9686003)(4326008)(33656002)(91956017)(66476007)(66946007)(76116006)(66556008)(64756008)(66446008)(71200400001)(54906003)(7696005)(6506007)(5660300002)(478600001)(2906002)(52536014)(8936002)(186003)(122000001)(6916009)(38100700002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UGO3PvmxrADkXPs9X6daNnpPJW8pPVCni3SYcH71olj8qvlOQvKu7tKoYp?=
 =?iso-8859-1?Q?mcyfhLHpXJtXHi5ZxAAndFqNqQbN/N+GriwW73ptC0zGot/gN+/hD5Kybs?=
 =?iso-8859-1?Q?taBVIb95Y0llD7PLT5BR+dp3sDdnvEUIhRkV5E7Ypk+QLNAlRV5tfkRImh?=
 =?iso-8859-1?Q?t5YjoXtlTaTyseNPV8rgNwmggy6R39/iLUU0jcCM1RmoyDvA0w4ADoMASM?=
 =?iso-8859-1?Q?6evl95pnX48eII1IwGRKutDN1kupG5Fi782uRyK3dkA3CQaKiqnZtFBn7P?=
 =?iso-8859-1?Q?WxJG/cy+pDKA2L/H/NfNWNtBf0qnRdB9upzk5xDhTZjKkOlSzQMWGxYLEq?=
 =?iso-8859-1?Q?pgm7FmYcQMzwSc8DswqJj/S6X5dOS0eew1fJwYT0ri6f6rQMbXRtnXt4LL?=
 =?iso-8859-1?Q?Z6l9Y8vFUkguZXPhKD+Xa4mB8xYj4joXVZ6fG/0VEiDARj+3D307WNCOr6?=
 =?iso-8859-1?Q?jy+YZtY7+3z8c54ZqW2aPpQYGeV85wPvbMAyGgjKgR0cn8m43+oKeehS8R?=
 =?iso-8859-1?Q?ZudZu8ekX6HGW/RGTBDCxkU5F10ck63u7XxjUBu3mG2u+tcn/oeF/vvJJ0?=
 =?iso-8859-1?Q?u1RuXCEYn/NaLD3/Qi9lpfjSZR4sB5GvBfH5wDCP02vh0YWKfeGmRogcEW?=
 =?iso-8859-1?Q?Pymy9uWNWLGWl8U7kgQBu1+lgd9vuvuzQVmxZ4PI7Wbkm7PSSTogOVO/GU?=
 =?iso-8859-1?Q?tBK+T4A2QKeZWtQYI2qj+RSZoat6epg8mjE6cPY9zNaCl0JqUxEDPmsyHG?=
 =?iso-8859-1?Q?aiPjgQv2TyKlLCopOBBzTdO5KUUBcHOdcm0heYd6qRvzD4KN0Y57JJL2ub?=
 =?iso-8859-1?Q?tfAc25IX0yfZCh8SWtrCHLSjIw+6tI8bUiGs9l9psSvLjBleJ/V6Hsqdki?=
 =?iso-8859-1?Q?cqnDEU/3/nbxNUklQj/SGiX2omwe/ljbxRBWY0Uj9c6tU2ennoEmsTelrJ?=
 =?iso-8859-1?Q?SyEMNzIMth6/WTRUyi8sjn4ZaRmfGhZVtRDePmSz7ET6qt+p7GaBgWkq70?=
 =?iso-8859-1?Q?MWVZhtmkjSyUSK6aQH50GEO4e3wLWT7/qdSTDOfonkwJNa90CfOZW8u4Up?=
 =?iso-8859-1?Q?YxTBSZQAr93Rwan9GaEyd+KjH4gRlmylBrg4+LeXWNQjtvw0iYA1Hy+CzZ?=
 =?iso-8859-1?Q?zHp/YkTCx3dXqDG3tdJ4AmUr3vCtdNfMnv60L3i52sahVLlrbi6ql4gwGz?=
 =?iso-8859-1?Q?r7iq1/WcuIPdib/Xj9EP479xf3+5F7qiCSKoJlpj5YZyGlmlIBqKz1162l?=
 =?iso-8859-1?Q?Yabetv8mWWRF1BbOyVT9gs6g8Saut5tJgSO3YAtYTg89+XFZj1+cMUfR++?=
 =?iso-8859-1?Q?GlmMHllqXFEvE7+Ea6eH56L/ICXZ/muu9rwa8QALtKDi+tQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faabf0fc-9e56-49f2-d51a-08d92b07c8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 05:31:08.0781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNLYT/p4Ly8OWe8xFoUFtMjRsAodPbNvq+nfR6qda1PtM77PzOPTnrxPJY/lVYK6fIbyYW6WFxWyY1nVxhtF0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB2895
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,=0A=
=0A=
There seems to be a discrepancy between what you're seeing and what we're s=
eeing.=0A=
=0A=
So we were wondering if you can you please run these commands in your Linux=
 environment and paste the output of the mount command below?=0A=
    $ sudo mkdir -p /tmp/mnt.dead=0A=
    $ time sudo mount -o vers=3D4 -vvv 2.2.2.2:/fake_path /tmp/mnt.dead=0A=
=0A=
We'd like the mount command to specifically use "2.2.2.2:/fake_path" since =
we know it is unreachable and outside your subnet.=0A=
We're hoping by mounting "2.2.2.2:/fake_path" you'll be able to reproduce t=
he same behavior that we're seeing.=0A=
=0A=
Also, if possible, a packet trace would be helpful:=0A=
    $ sudo tcpdump -s 0 -w /tmp/nfsv4.pcap port 2049=0A=
=0A=
On my Ubuntu VirtualMachine, I see this output:=0A=
    ubuntu@mikes-ubuntu-21-04:~$ time sudo mount -o vers=3D4 -vvv 2.2.2.2:/=
fake_path /tmp/mnt.dead=0A=
    mount.nfs: timeout set for Wed Jun  9 05:12:15 2021=0A=
    mount.nfs: trying text-based options 'vers=3D4,addr=3D2.2.2.2,clientadd=
r=3D10.162.132.231'=0A=
    mount.nfs: mount(2): Connection timed out=0A=
    mount.nfs: Connection timed out=0A=
    real  3m1.257s=0A=
    user  0m0.006s=0A=
    sys 0m0.007s=0A=
=0A=
Thanks, Mike=
