Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E746B32EF66
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 16:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhCEPy3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Mar 2021 10:54:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41328 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEPyE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Mar 2021 10:54:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 125FUTix068310;
        Fri, 5 Mar 2021 15:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oZ7NZdvtvgWwKZkTUTQNkAPgXb29OjpedgW8h5Eq47o=;
 b=m+Z7hO6N6LYT4FqJ9zKYAUNJDkaEUr1yKrytk4DBrWd9lDgcdun+TJ1yjDKko/9i8mE7
 43czvhVAEvpjOgVLEo5Oj29WUcX4FMQ/BsIp7oxtFPEgCwfDTI60Lx6+l1KrpM2O59g7
 2bNAZiNaJ2FI4XMot1RheIJDxas/xJWIvnMYFQGxrHEDplCd31iSba+HN47FCwz2Twdn
 yEXdxupA7Ea2KhJO2EDLF7D1awMGVeq7ePX07nHcaf8scfrlXKPNGARoSNDP8vx7L3yt
 N2wecwU2DZNI3o0BH2O5+9IEgYUxz+jqw4n5sTbJPW89ZdotxSlKSWAzBkryNoinI/6H Qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3726v7gdtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Mar 2021 15:53:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 125FVAeX028436;
        Fri, 5 Mar 2021 15:53:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 370012d8qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Mar 2021 15:53:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzIjubQ2Gxh8+tQDwuFBkOQh7TokzfE5cRqxYgOwN/PMh+AaG+3er9sYAqUhrIl9qSjhtXCzjDWja9MTORaguH494NTjVn/Up8ZZo8oSwQw5t5RsFJYI1LO8XE70Kd4qdiYNibxNsiO54HOPYnS5LA7ecIejrEovY5yjnD/JLqulipRoWtx+ybQKroff+VzNEA/7kLtstL2+j1XccuYb3X9Y+qnLg7sIzW0EsIDZkMfCIfNlNQe4vD7hNzMLRVf3kghArNuJEkaL6zc0hVdVZW7J28ZxKWytt2/+8067nvTpgjP3uq8Dsn4MEbaPhw4EsSO8r3Hp/B/7OMzN/ysmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ7NZdvtvgWwKZkTUTQNkAPgXb29OjpedgW8h5Eq47o=;
 b=Yn3BSBO2yV7xB4Zettlq3J6LTMEGVkbc6oILpEirkNFb6wzSR9Hak91bJe2NQskoGq6KvI+8I+zmdtDM0ycZeX6D2w9VN1XbZD22Ww8JI0zkF7n9LtGaiX8vTt521Fefu26mmb/92vFMUizgV55Ha2abROiHpEoI3l8sNBaFJAY1rR0yGoNuFyMaRgSICd95vtg8fJMG5gkRW5vp4vem/Es4Ul29MuQkLCo5mDa1rL8S7hbqYxi4VCzg/D328SoC6bnlgCrCbwvccszDYDtPIvZHpIdb9UnMWbmRZnVcPXCYFB56CgPFuaYc1Z+jJBnTjn82E6sfeZvlcSD+v3L8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ7NZdvtvgWwKZkTUTQNkAPgXb29OjpedgW8h5Eq47o=;
 b=df7oZQ03n2mDO6Fm+RWpLGZu5O6JrAtiOC9mwT7CMPdE0zAWuD1MrNOWLMnmh3qmht93DVG2nTBjjM7kUWvEx3Fq6hn8FS+hp/Dggd56Nq2gM7fTSAfGVgUp4FeoudBo61xfCC82MfH2DS2VxCpsvCtlYkUEVB4qNiEJkdbszOI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 15:53:52 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.023; Fri, 5 Mar 2021
 15:53:52 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Steve Dickson <SteveD@RedHat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
Thread-Topic: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
Thread-Index: AQHXEEhZ3Ts9eT8uIU60zDgbZP+se6pyYdIAgABkPQCAAAjhgIAAA9MAgAACrACAAQagAIAAAnaAgAAoroCAAXIqgIAAFYuA
Date:   Fri, 5 Mar 2021 15:53:52 +0000
Message-ID: <8EEA9199-27A3-43D3-BE4F-CD250ED6DC99@oracle.com>
References: <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <376b6b0a-5679-4692-cfdb-b8c7919393a5@RedHat.com>
 <20210303215415.GE3949@fieldses.org>
 <d9e766cb-9af8-0c66-efb1-a3d0a291aa48@RedHat.com>
 <20210303221730.GH3949@fieldses.org>
 <80610f08-6f8d-1390-1875-068e63e744eb@RedHat.com>
 <20210304140617.GB17512@fieldses.org>
 <4204cd8e-f8c4-103e-bb69-a6bf720e65e9@RedHat.com>
 <20210305143645.GA3813@fieldses.org>
In-Reply-To: <20210305143645.GA3813@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0413b15-6561-4753-11bf-08d8dfeedfb8
x-ms-traffictypediagnostic: SJ0PR10MB4687:
x-microsoft-antispam-prvs: <SJ0PR10MB468777251148D6F8BB24AE0893969@SJ0PR10MB4687.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wLyCw7fz87b0ZALeC1Qe5O0u6sKuJFqIF7n6DwbIz6355z3COn656l5dMj1YgXS/9i7HGk42KwBkpYYTA5bJcfmR583WUF5zryGAhc+6emmaA/j+aDfzeHINuSiZA69/1ryFFTp/4a54ukJmeBsbQYDszd51GdrI7EYSYqdHz0UqxueGX+y1f+ft09JJURcAn9a2oe1xW41M3mvKkQC7904snH86/zKWxdtcUw33tIBJwpV2GeEoNne58ziziWOEH5hq0q7hCsIxomH5CLn9ySnYoGr80Kt/UfVMiJvb3CGDqHoY3XA5glJ30cqOuiL4FeC2xGgOFgKc/HXOiSWHy8apwBXpDvnh+3E7sjcjh7A1G/2ICqWnc74bQoiu/5xDLv27LR92hRvDhCpmwD3P7JosKvyZj/v89FcyQ324CkSqyKXpBNb2LEwCHKQgFugVgU9MyA9abFH7t12GXzmO9qo9mB/uSIcIGg2AN4eJNYJfhVvbbaOImZLCDXFM0dXnm/dL928ww8JhghDg/kfT+cZafIAycMRzacvUSZrrcEYo51Hl6kWRrQZUA8pKqEg/z4Xic6Fl55v15pc1SpL01A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(39860400002)(346002)(5660300002)(64756008)(8936002)(33656002)(2616005)(66476007)(66446008)(110136005)(36756003)(8676002)(44832011)(66556008)(76116006)(71200400001)(6512007)(83380400001)(316002)(91956017)(86362001)(53546011)(186003)(2906002)(6506007)(26005)(6486002)(4326008)(478600001)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Qawks22zkI5KM99+CSzMsKhxxU6QkCF4Eno0SVeJQJTUB3S1VgPJR23bG1BR?=
 =?us-ascii?Q?pcBrtiNpAWR9nT2I4KgrncWCA/88pKIH24SmMcwHxDFPlsC8Su4G3QocDAcv?=
 =?us-ascii?Q?6OWggGpdrFypUzPmurLv5/6IWWhHDC85T9aHC/O9Sj4148PxtrwiOEHOwGaK?=
 =?us-ascii?Q?ldHeGAXHGtfnyIHlAGuIxfA0izCr3SpBeQxyU8hxIAouAtPg58X3rnBwhW12?=
 =?us-ascii?Q?n5cCfr6hkI2K65mad8Qac2YdOLeoVh2DAHYjRGA+2RoXZZAUIyfr1mfATyPj?=
 =?us-ascii?Q?qTZF6hjN/Ycr8X2DmqOZ0nTtVgx88B8TfGtFPjiQMFnTyxyUH9XlBACaKdL4?=
 =?us-ascii?Q?CLJgun4ljjAgQimKdnvSeb6ylga2wljOgNhlxTgqm7/Ii97d7bWJljhqzTPs?=
 =?us-ascii?Q?qy+PgyL3PS9tsvFWIdPOi3GT3KSK9WmojHCkVzgx5TJhASRk9wT5nmIBtl0O?=
 =?us-ascii?Q?2YkboxEHedL4isHyjcsArLthrKiv5Rp9dxrEBriAewSzXfgjKuVg4BZlpIR5?=
 =?us-ascii?Q?ALow6AA5WTPJ89KgynLht5IlggUpG0W1WP5QOGEddoxgkiaHyuqrzKeLoXD+?=
 =?us-ascii?Q?eciEfvlyAFOSxszoho32ISfQKeKJAT2PJtqowSau16sEqFuV7JGW4LacC87a?=
 =?us-ascii?Q?YKOx+0amJE6g48Yulmt0xzhHUPXg11IFRITTZgDYRltWT0odGGhXaK98wM75?=
 =?us-ascii?Q?Aeh59SBd+m8eglHQluH7GzOHtpr8FklkcH+N63EfSxquuLP5NfFwrCg538F4?=
 =?us-ascii?Q?ryhwia4dqy5ONkNZwq4VNJs7tGKhuj7+QpC5nGhSfyfSBk5w648LFnO3gy5m?=
 =?us-ascii?Q?J3NmVzQ1wGNikDI7bf/igNUlSYfd6k93s59Zt+YBwpyzKMfZ0553UwxNWKQn?=
 =?us-ascii?Q?kR2XisRFuL8USkhK13Pys3F+Yd9sX2ed2a1gqpyfbaxNv6Za4Gl4k7ULR3ne?=
 =?us-ascii?Q?2D3miVrzeK99NtCGJ8WCRhRHBZ2yg6YjYnhLzDMmYt9NjHOWFFQ5+w01JT+p?=
 =?us-ascii?Q?J0OAoyK3bOiBUq6VUjbQInvIMwp73r0IzUX1IoJGbTV4Gp1CjyFHc/cB+XPA?=
 =?us-ascii?Q?ZyfmsuQo8GZBfl7YATWS2rKFQt9wfI+zCfj0dRmFerCriCfwmN+rJ4poK5Dr?=
 =?us-ascii?Q?LSCfK87ZwRhFx+OaOiC4CyGdf7tcd8qRTmvP8R0QDC6iqpZ2kZR0OBmnAlnw?=
 =?us-ascii?Q?CgUa7yRCAuaUJWGYEOKcnTnKh5lzFAEJ9FnAY+Tuq9KE4M20PUaNbYajl4Bc?=
 =?us-ascii?Q?wtDaspka6Ek5nSvf/wFMZtYhIUBZRfiGmgqGnOkM+9lYzK+puFAJ+fW0HaPC?=
 =?us-ascii?Q?iPnQdObTYzp1PROfTzqMBxRO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BC90E7EF3BAE948B21C65C365F8DC90@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0413b15-6561-4753-11bf-08d8dfeedfb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 15:53:52.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YJ35xogkXP9BwrC7XtvShOaGeQmuJOqR/ejVAaqdc2lZFU1eng5RY2qVT0dMiZ0A5KRy/RV6jb01jYwyl0nMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9914 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9914 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050079
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 5, 2021, at 9:36 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Thu, Mar 04, 2021 at 11:31:53AM -0500, Steve Dickson wrote:
>>=20
>>=20
>> On 3/4/21 9:06 AM, J. Bruce Fields wrote:
>>> On Thu, Mar 04, 2021 at 08:57:28AM -0500, Steve Dickson wrote:
>>>> Personally I see this is the first step away from V3...=20
>>>>=20
>>>> So what we don't need is all that RPC code, all the different mounting
>>>> versions... no RPC code at all,  which also means no need for libtirpc=
...=20
>>>> That is a lot of code that goes away, which I think is a good thing.
>>>=20
>>> libtirpc is a shared library, it'll still be loaded as long as anyone
>>> needs it, and I'm not convinced we'll be able to get rid of all users.
>>>=20
>>>> I never thought it was a good idea to have mountd process
>>>> the v4 upcalls... I always thought it should be a different
>>>> deamon... and now we have one.
>>>>=20
>>>> A simple daemon that only processes v4 upcalls.
>>>=20
>>> I really do get the appeal, I've always liked the idea too.
>>>=20
>>> I'm not sure it's bringing us a real practical advantage at this point,
>>> compared to rpc.mountd, which can act either as a daemon that only
>>> processes v4 upcalls or can do both, depending on how you start it.
>> Right with some configuration changes... But I do think there is=20
>> value with have a package that will work right out of the box!

I didn't understand this claim. Don't we already have that?
If not, why not?


>> Boom! Install the package and you have a working v4 server
>> with no configure changes... I do think there is value there.
>=20
> Installing rpms and enabling systemd units is also a form of
> configuration.

Don't understand this argument either. What does "with no
configuration changes" mean exactly? Installing and enabling
is, as Bruce says, about the same administrative hassle as
editing /etc/nfs.conf. What's being avoided here?


> So maybe it comes down to whether we'd rather configure a v4-only server
> with:
>=20
> 	dnf install nfsv4-only-server
> 	systemctl enable nfsv4-server
>=20
> vs.
>=20
> 	edit some stuff in /etc/nfs.conf
>=20
> My preference is for the second, but it's just a feeling, I don't really
> have an objective argument either way.  Anyone else?

Now, I'm making these comments in good faith. I don't want
Steve to roll his eyes and think "what a pain in the ass".
Please read and digest. Maybe have a Scotch and get a good
night's sleep before replying. I really really don't want
an argument, especially not right before a weekend. (And
note please that I've given some alternatives here, so I'm
not just trying to knock down the ideas).


I feel strongly that the first approach is wrong, but it's
Steve's ballgame so I'm not going to go as far as a NAK.

We've spent a decade trying to fix the mistake of having an
"nfs" and "nfs4" filesystem type on the client. Now we want
to do the same thing on the server, and in the end, if and
when NFSv3 goes away, we will be stuck with nfsv4-only-server.
All I'm saying is we should proceed very carefully so we
don't paint ourselves into a corner in the long run. This
game is ultimately about lowering long-term maintenance cost.

First, if only NFSv4 is configured in /etc/nfs.conf, then
just don't start rpcbind. We already do this for statd when
NFSv2 or NFSv3 is mounted on an NFS client. Let's automate
and hide as much complexity as possible.

Second, "dnf install nfsv4-only-server" by itself makes sense
if you want to remove rpcbind and a few other components that
are not ever going to be used, and you want to prevent dnf
from ever installing them again during an update.

But instead of nfsv4-only-server I might consider splitting
the RPM generated by nfs-utils.src: one called nfs4-utils
that installs the nfsv4-only stuff, and nfs-utils, which
depends on nfs4-utils and installs the non-v4 stuff too. No
changes to systemd units, please! And "dnf install nfs-utils"
as before still provides the whole user space suite.

Folks who just want an NFSv4 server can uninstall nfs-utils
and install nfs4-utils (or if nothing is on the system, just
install nfs4-utils). The configuration steps, and this is
critical, are otherwise exactly the same in both cases.

Third, as for exportd... if we're not changing the upcall
mechanism, then just having mountd not start network listeners
seems entirely adequate. I don't see the sense in replacing
it.

If you want smaller binaries, then let's focus on putting
the whole nfs-utils package on a diet. Everyone wins that
way.

--
Chuck Lever



