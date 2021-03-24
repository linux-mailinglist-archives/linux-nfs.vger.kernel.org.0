Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4F3479F3
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 14:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhCXNvO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 09:51:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41902 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbhCXNu5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Mar 2021 09:50:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ODoSM8048907;
        Wed, 24 Mar 2021 13:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6c720XLrCr0KbJCz6bjV+GhG33Ewff5jiW6zxaqobYU=;
 b=i92ZOU7B0z+DDelO9SGJgLuPRr5F3Fmr7eMmisi7RP4PcHz4QFBqA1zR5nDoSfkqWITl
 +lqi1J+k+b2R0IcO9/cS06TTdU0o6Ajz6M9W2eiu9C7QU26E0mOhci5i+u8ZQFZ/Mfh7
 vtTyNJhLuxJWpl5bG6iOxocK4bKfPz+unFQHge6g4r3KaEzbA26EyXeTgTpOisoA3SA+
 QnULcu5bP/+OCqZt/bXOSsJw1/QmCfidBQzt7FzDlyekNdI2Muzm/G7GdjYPnNjCnzy7
 3e9atnSikvxdVoc1lO33G0HErnFrjtbX5H3Zswnm/CB23xDALvX0jexZ/LlTbCRoxknu rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37d6jbjw3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 13:50:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ODoSoR189460;
        Wed, 24 Mar 2021 13:50:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 37dty0ky6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 13:50:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHJ7N6z/ukIIO56S1xtBJ+KSaKlXtrxZUFhoIRwhR1e+MYq+6ksmnp9FBCcDr3UpBGcfXCEwvQrVnbNPc4dnGM/CSQI5SME5sTdGiV4EoWCKHXJ6WMAbAA5BYpb329kZ06Tsr001TTezLhYEl96ApZ7qMSKg8udVY2scq3wLKqZVDDoVnqQ6xnC+h0vQrDcf04O0ALBwfGGsZ0X3KgS6JNdm/SE3mBapoSX46/72HQP73Xkw+0Sx29swgu85+cZRkTv0gFF8ohUDJIX9+JnUXtXl0s1zgL5Nr+xtVIU4thG5II0+JXN0HiHeq5/WBuPjW1NUKCnZCaiO0warS2YV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c720XLrCr0KbJCz6bjV+GhG33Ewff5jiW6zxaqobYU=;
 b=mBmbEWb2mXJ4/HpgTkxVAcjDDm1nfDpNmj1qbwgQj4Qx/tiUrN2sNUMcni4JOj5DdXn4RBeBfQjm3Uatnzyf3twVKg2PzkXPVvAiVcmgDhrSP728ZsQtirQLhAqxQL+BVuusF1haADNcpc4RknHA6fMxbgstJxU86UPAH5haLTAO0XJ86TRuVyZaz5r9nQH1Q61Ke/E9+jnP+FPYIPr0rZa1e1iafNredLZDOjPm/TOU4U/fzBFWvEjRKLyZEwMWz9a2HLJFkSZNhQ7Jbq/1xLcO/x55cETDiZqbrrCkviHxtgeMKWaaUBGbYE9sassaT48/ojqluYp/jjZsLY2RSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c720XLrCr0KbJCz6bjV+GhG33Ewff5jiW6zxaqobYU=;
 b=MoGMzuVfnFPvzyau15QuPdrQTpUcHo4NeD706NOgX9t/CckGodYX5uAVpcW5dkhAdPC35TZSDpSb1ELJfMzZECWlhhM1Lra4p0TP/MxgTY0pvKrMLH3SZVAbtfUG/MvHK9MgqPCzk+rp+uA7jxS7mlVMH2FsnK1l0nbJY2eKyDo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 13:50:52 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 13:50:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Geert Jansen <gerardu@amazon.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC: return d_type for non-plus READDIR
Thread-Topic: RFC: return d_type for non-plus READDIR
Thread-Index: AQHXH4An0zoT5whq90uvEbXY1zJqrqqRsqoAgACtjwCAAMovAA==
Date:   Wed, 24 Mar 2021 13:50:52 +0000
Message-ID: <C70E02C8-DCB9-4096-B917-591A4EE21D76@oracle.com>
References: <20210323010057.GA129497@dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com>
 <689DD4DF-17C0-4776-BE53-7F10F7FFE720@oracle.com>
 <20210324014713.GA44499@gerardu>
In-Reply-To: <20210324014713.GA44499@gerardu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6501397-e583-4136-2c88-08d8eecbd71b
x-ms-traffictypediagnostic: SJ0PR10MB4544:
x-microsoft-antispam-prvs: <SJ0PR10MB4544F996B8ADC70D8E89B98093639@SJ0PR10MB4544.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3mWdrR8mpm/SDTcqZ9D7Qhf6/JFsOGa5wRVHM/Nel3btDyU5XX2uDxe5vcPXUEKk40rPEKRLprBBlIWyq7EFGUNYLXc7qI/gPL9km3/D6Q5X6NDFZw2BQhNfUW4wKaQHo+WFur+R8TLnZfRlB76N1Z3bMbs58g3n3ehcTOdbHh7GS2pNe52zl1Zi1mjsFwyZDiIme8TC/6VLMOxIEYVT3H5n+BuOOE920vT9b5QAHnt02msqaY9YSLzDSsrkAHmu4YAWVuORyE+/bNefPtpmWrv555IcV/+b77VMU+YbKVMp44oN16wazVyB0eBysqjkiLq+xj8cOFUTGWHKqNvUSzkvKXu66c79mZBKL91b9VhxU1Rr33bAXjYIM9smOuzWLBushzjWDxPkVl3x5msGjtrPUz6K35v3f7cmVb7liEtO76A5oQH6pV/MSbV0AfcA3gfU6cl6wG4luZjKVhAsFGzLP6d0oP3OpUf+PsCLl7Or2tIBWs5a1f8XN+XxSKtVPCD0Og8RIOKj82apNLcZ2p3XFxtwJLeZ37hEpl8yvm5eLLOzCQUXel6LzJd5sVCVbyxp0O0eU/fCznpuCtgvEGeddAPxRPRhlR72klF/NIGgP1jmB4TFAh3IArx8I/KJM6ey/W92/WnHXyoXOvZTJEMWx1rNxFOnbvF3AP0HNUYyCgL3hu9PjdgV4oFgeON
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(376002)(136003)(36756003)(6916009)(186003)(8936002)(38100700001)(6512007)(8676002)(5660300002)(86362001)(53546011)(76116006)(33656002)(26005)(2616005)(66946007)(6506007)(66446008)(478600001)(4326008)(71200400001)(66556008)(66476007)(6486002)(83380400001)(2906002)(64756008)(91956017)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?I2XUXHH2FsDeAnpCO9mfBcii9aZa18jBigxA94Cexsbn1KF7boJYGsmg9wOO?=
 =?us-ascii?Q?ROSkEwAMaNPAQlomBOMaoU6+yiD6eUmxrWhOFOr/mJlmOwGXu577qrHUn//N?=
 =?us-ascii?Q?7cDs4jBpGaCawbpkUb9T98kLrEYK1Pcp2nn+HlyWwHfEUCXtyMgk+g71ztvX?=
 =?us-ascii?Q?ctHQ5jJCEc79PijVicH96BzuI+gg2aTGOzbL8z6H5S+s4gb8bULfil4heWV3?=
 =?us-ascii?Q?Dqj+WW4Wvedr3L+1PRnoKvpXwhzmmUaEeAsfqeNSHGvCeVTtDl0KhHGXhKpJ?=
 =?us-ascii?Q?YGBwTdZse3ssNPzpv3mqRS1MhmOfVEh6qu/OG+QFoML5tNrNBnbttBRrj8cf?=
 =?us-ascii?Q?42VFPi+l2nCPfp9Jl6pxfBnGy6UqibpKjno4ogIKah44hZwHthlvQceFVKvL?=
 =?us-ascii?Q?5LdC90iC8EbK9fgmgjBImDUjfxpEDBU6GtXvxgqVZQ3zMEZX0wilvG9mrABQ?=
 =?us-ascii?Q?Z5NMJx+X+gnXBXdO/MWtLS2Lub8KHeXqwNPJw7jm1yVC9xpFsc4y3w8oIuqJ?=
 =?us-ascii?Q?d3fL3lq6ika8HUB4JeeWDIhwgzqbLPqSAaNBvryafnKUYymOKvQekWOYk5+s?=
 =?us-ascii?Q?HZZdrh+bo9JLOEbVTcSo72i9M4rR7duTZhzJihdz6IykDr/TqqlscAZkTHn5?=
 =?us-ascii?Q?jCequHunkwl+x7oY7Sw1pf8Bok5fTwYbCm9fw7Jk8Vxfap2xhH10TZjojOiU?=
 =?us-ascii?Q?PPzKEzyFgPRo+egULDdlDYoli8pLBaS0mCfzq4qIlwl0cewhNXV2r172TNS2?=
 =?us-ascii?Q?uWCokBysPHzCUkVftQie0qo4ney6AfLeGJGh9MZqD2FtMrFVlukpQAt9NIjq?=
 =?us-ascii?Q?Tccg7Zx58Da9XMedUhHpDQ7Ub2o3i7bLpKN5Pw6xOd37w/Xu/BFgdHGRLlJB?=
 =?us-ascii?Q?WPE3JUW8xmntEu6ancYhbrrf+oJ4ED0bFbZIL1pB3A2oGGMVf9ELJff1H5ZL?=
 =?us-ascii?Q?ZfbJ5C9b2QKJxCYwYeuj+WGJg2G9jdeq+7KEr3AGzvgYUKv4zJorBqpl7EnT?=
 =?us-ascii?Q?9KrNViyYwNS0Ao32NQhznToohx3DWxukyD7KpJwAzEauFqkX6cMDj0S5F0us?=
 =?us-ascii?Q?CN9h4HWzcqCWIX4rqE0ZmVcTtH6OmWpECiabnScnTl2KdVI/isx8f17zeU1a?=
 =?us-ascii?Q?V4Nk1ZjDTYzVHVwMfjeICgdZy5/sf0BbE1QLC5Xb7V2hNsTp9QMgV9o5+dxV?=
 =?us-ascii?Q?SoecZ2IIqML+RDCc7mIPOeLgQAia66S8JoJxDqNsRkFC4mXSzZB/HK4GrM/2?=
 =?us-ascii?Q?GNAvyxC7v+veHYrg9alysAc3+/mnp0cFWUd7plIe99QIDS3atFF6Xy8sja+o?=
 =?us-ascii?Q?17h77ZcKNbFA7su+3yBoqo2Y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4805D3F4644DB241BE90A7752E5A41A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6501397-e583-4136-2c88-08d8eecbd71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 13:50:52.6065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqWYc2jtQzJfjYe0M7R29jcGCod3G1LIg4rjdBoGpDNAi9IO/BFOjnPj+BZjYsmOjMsyXrYM9WTif8O6/tN06g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=911
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240105
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Geert -

> On Mar 23, 2021, at 9:47 PM, Geert Jansen <gerardu@amazon.com> wrote:
>=20
> On Tue, Mar 23, 2021 at 03:26:02PM +0000, Chuck Lever III wrote:
>=20
>>> Since not all file servers may be able to produce the directory entry t=
ype
>>> efficiently, this could be implemented as a mount option that defaults =
off.
>>=20
>> Can you say more about the impact of requesting this attribute
>> from servers that cannot efficiently provide it? Which servers
>> and filesystems find it a problem, and how much of a problem is
>> it?
>=20
> The ability to satisfy a non-plus READDIR by reading just the directory
> pages, instead of having to read all dirent inodes as well, can be worth =
it
> for certain use cases (especially those with large directories). If a fil=
e
> system does not store d_type in the directory, and the client would alway=
s
> request the type attribute even for non-plus READDIR, then you lose the
> ability to make this optimization.
>=20
> From a review of the man pages, most local file systems appear to be able=
 to
> store d_type within the directory, including ext4, xfs and zfs. Both ext4
> and xfs have options to turn this behavior off. If you'd export such a fi=
le
> system using nfsd, then this would cause additional IO on the file system=
 if
> we would always request the type attribute.
>=20
> I do not know how other commercial servers handle this.

"How much of a problem is it" -- I guess what I really want to
see is some quantification of the problem, in numbers.

- Exactly which workloads benefit from having the DT information?
- How much do they improve?
- Which workloads are negatively impacted, and how much?
- How are workloads impacted if the client requests DT
information from servers that cannot support it efficiently?

Seems to me there will be some caching effects -- there are at
least two caches between the server's persistent storage and the
application. So I expect this will be a complex situation, at
best.

I totally agree that directory operations are a performance
and scalability sore spot for NFS, so I personally am interested
in hearing any and all suggestions in this area. In this case,
the proposed mechanism is intriguing and sensible, but I would
suggest that without measurement data, the proposal seems
incomplete so far.


>> I'd rather avoid adding another administrative knob unless it is
>> absolutely necessary... are there other options for controlling
>> whether the client requests this attribute?
>>=20
>> For example, is there a way for a server to decide not to provide
>> it if it would be burdensome to do so? ie, the client always asks,
>> but it would be up to the server to provide it if it can do so.
>=20
> I looked in the RFCs but I am not sure if there is a way today? Both 4.0 =
and
> 4.1 define "type" as a required attribute that needs to be returned if th=
e
> client asks for it. There also does not appear to be an enum value
> corresponding to DT_UNKNOWN. Were you thinking about something specifical=
ly?

I wasn't thinking of a particular protocol mechanism, though that
is certainly a possibility. I'm more interested in seeing if there
are ways to enable the proposed improvement without adding more
administrative complexity. Yet one more thing that can be set
incorrectly and has to be maintained in perpetuity.

So, alternatives might be:
- Always requesting the DT information
- Leveraging an existing mount option, like lookupcache=3D
- A sysfs setting or a module parameter
- A heuristic to guess when requesting the information is harmful
- Enabling the request based on directory size or some other static
feature of the directory
- If this information is of truly great benefit, approaching server
vendors to support it efficiently, and then have it always enabled
on clients

Adding an administrative knob means we don't have a good understanding
of how this setting is going to work. As an experimental feature, this
is a great way to go, but for a permanent, long-term thing, let's keep
in mind that client administration is a resource that has to scale
well to cohorts of 100s of thousands of systems. The simpler and more
automatic we can make it, the better off it will be for everyone.


> If there's no way to do this today, then I guess a per-file system attrib=
ute
> that indicates support for "can produce file type efficient when reading =
a
> directory" would would be a relatively clean solution. I presume it would
> require an RFC to define this attribute. Would you have a recommendation =
given
> your your experience with the RFC process?

My recommendation is to look for other alternatives first ;-)

It can't hurt to ask for advice from the nfsv4 working group, but
I would go in armed with some performance numbers.

--
Chuck Lever



