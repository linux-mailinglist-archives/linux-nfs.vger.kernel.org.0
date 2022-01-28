Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55BF49EF1D
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 01:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbiA1AHu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 19:07:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26396 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238679AbiA1AHt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 19:07:49 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RKnJwv003855;
        Fri, 28 Jan 2022 00:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ItDNkIZqG7M19xPqNDEPw5ahhXfqmu4sbSq6YlKMNrQ=;
 b=Sv1jJ/b/wwznCO2zIGFIjjibMk2WJjNbn1Ay6cR6COiqvQkHFdXFdEI5T2kGR7U2bUvO
 XXuwjYIkujt7vBswRnmWXiboEyzGyShXrreWvJcRGoULQ/uu/KGbJbX5LWf6NvnZ0fFc
 JSbBWaz4mTqzHncJVplwpLgOmAsXmLX1C7mck7bb1cv6mw3Ny8RVOcTxp0OzZw3WIeZ3
 o554/CIMVj/bpXlM0EJwIYOxJ/FcoE746nn6kOT9ZRGdPJ4jYvRBJwUeXvbmFHfpIoAd
 DfxwenBWcgNVvtNhZJs3jg6qI69jUcowaBj/oDTBArHvJplvB868QMhrVyBVbYPyk2M7 AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwrxhn65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 00:07:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20S01PiS092380;
        Fri, 28 Jan 2022 00:07:45 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by aserp3030.oracle.com with ESMTP id 3dr7ymtj7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 00:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXH7/+kWBFkxjgkWyczxYwPsETGUjfv1wtasHQ2SX9xz+XJuyJ/WiY9OOkLdG6dP2XSZ1FrrN5CB6GbmRtppsRpufMsoO9bEF/l4V/fHIDTG9qaIwzZh0IoUT+z9D/slIZ2BbVlzrRYJl3hbQ7aYORjaJqrVmH27Duu1DshU9OwQsk98O0guNyLnzC6JQl2vYPLC6+kp1svgM5Fg5jJbyKtV+9KiVm3mLTopOXHZoLxc+ROzWuA5h4WZCUFKJLl6b5zTwX48xr2LFiiBUHoXMct6EVJYvXVGrNe2tAS5eltUFZGlvlqPMTes70Whf7+V1c5756dFjPpSg4a9JeXzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItDNkIZqG7M19xPqNDEPw5ahhXfqmu4sbSq6YlKMNrQ=;
 b=JbtNc2mMCEOUON1M8qXZjBXuaVNWDrG2mGj9grdbQLUs5YGuM08umnkc5nAqtZE2QYg9C+hbmjEG7GVO7IsvDMCb84eJdvg2BovFOFYWrJFyUI2oh6wMDX5+QCT58cWrm/IaYYIIK52kO/3qvrms8bBidt3NSs3De8UUeeimifJun/FdjZHC6KP66OUMyYd1JR5nzG6f3yYz6J7vjdZi67Pt0zhRp9Q89rnJRjk9aHylw46vRgs0aFJv5a0UAUU2f7j9ztwAtt3cGZ9FnEkDLAzP5+BEo/swcTEKGFMK82/mfnahAaBDrA4zj3QPGprk76x/S/W7a0AZrRX1UrPvow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItDNkIZqG7M19xPqNDEPw5ahhXfqmu4sbSq6YlKMNrQ=;
 b=ur9YdhajtiDOP1z4njNKeziVdCB+nQXt/QIuC93bbqAPtXNqiurMr490JT1wYao3EAaMkPE8OCPm5KOpCJ8RM6bmJainsQdpwkRfhRK6WrxdKKpPfsN9ALk5Y6xqQbjjNMngOuSm9/WciBY0Z3kM8DURtUOYgZsRj4j1TTvn1Ic=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM6PR10MB2938.namprd10.prod.outlook.com (2603:10b6:5:6c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 00:07:43 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 00:07:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Thread-Topic: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
Thread-Index: AQHYEzqzINafEUb13kObHCDc0cTYeKx3GDuAgABfVQCAABgdAA==
Date:   Fri, 28 Jan 2022 00:07:43 +0000
Message-ID: <A933D67A-0C1B-4700-97E7-0DBEF4458A77@oracle.com>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
 <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>
 <164332328424.5493.16812905543405189867@noble.neil.brown.name>
In-Reply-To: <164332328424.5493.16812905543405189867@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4dd6c85-c41d-4917-94d6-08d9e1f234f7
x-ms-traffictypediagnostic: DM6PR10MB2938:EE_
x-microsoft-antispam-prvs: <DM6PR10MB29389C0524FBF3C22479741A93229@DM6PR10MB2938.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKuLCe+rNW1mLxruoCnOvn4NS3X5/StrrRiBLUc+FGK0ptKnQN/MrwpnxKr8kthjDRBCgLXEFPYgZ6c8pftPupKa0f6u3x/rocT2IEdeh7Iw1RuK7CvO5DEAWV5I1/kYr8d+uNuYIYE0qPCeR53i/sEPE6lolsQLLbfEOk6dNyuKX6wHnWdMp9k1G+IVQUKm7+pxztVvrCpkFf+xFseNyK/J9ZHREo6iWxDqF0p+Tjnb3gUExIGQpSEx5hBbXPz7UPKzaaJOOyspSDUZijt1x0ZUPp4G55QUDnAmmaOG9sEgnty9k1lH3UCUIdWR4RePAlZiCsKPpC2rIIMiuP0KinFJIqAkasU8QElW6XvmqVCYuaFxZ5IrYSVfmP2KCFQF7fCMRG8buqT4WTUOgf2vt56hLOrIxD9J7PfKaFrdTh/tcnup0vUFa93VEXkPIIpBPWA54bSfGVdw7IuFpv/aEGRoQHw138bUnXrp+qQCZpT5hz4AXS58gUPaZsJu+nIpjkpIt368JdLUoaiORovFWqDBdehfSg2y8ypeHefXcpCGW+NPej57RLQMZfqAUeysqWezc288ab9ErSLLARNsssqloa965h8QAY8XSF4RdAQLC3+Y9TXdujYsmrJsmIKcqwzymc5knJujNyuispW8pf4671pZQsuRlg9d3dO4UHXQh5oQDIdByITam81c+PIH2yRmuCGn9WQYxLJEbhrTpbKuA7Uo2NyE130HWVQ0wv7fD2gQn/yI0ONALoyJQbVz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(26005)(6506007)(53546011)(64756008)(2906002)(66556008)(86362001)(36756003)(2616005)(186003)(66476007)(66446008)(6486002)(4326008)(8676002)(83380400001)(33656002)(508600001)(8936002)(316002)(38070700005)(38100700002)(76116006)(5660300002)(6512007)(66946007)(6916009)(122000001)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hJ/hjVJdGavAyfAj8tgKZUj6nedoGA6WZf9OuilwMPmYIN/5Rz4mC+1gKqEu?=
 =?us-ascii?Q?Z5Pf+kRraLMKkKdzZ8C9QAX97nMlcHHji5LqvwySlvfUCsUQBWIIzl8CFxj9?=
 =?us-ascii?Q?zUmRAULitYwjVINZDyzFMHNGggBc5Yu6jcPkOuPY1BLLNxJnsGvKW9VpCgiy?=
 =?us-ascii?Q?n9nmM3tJKl2DbQ1+d0TfZTCEe8/fUVc2/Op9E+pCrcHIjMM/XNCvL14duO6l?=
 =?us-ascii?Q?rFIkq65B2OOiMyMngvYDXE+uBK7v9bUjpSVhHjkzLIsudwOyYapL0ach5m6T?=
 =?us-ascii?Q?DTl1xcK8DR5/H1Y29fXtIuyd3odITdbJNuFjTJAQ4qtXdayJ/u+tTX3SlVbO?=
 =?us-ascii?Q?l5XNvapY0sk6so2CBfspS3DOfUOL2+O8uNs5rQ98wEgWtBf4rmKmGtncNfN+?=
 =?us-ascii?Q?2OeSLUuOex+CHkDDlFh6narGB3uRdl1g/ktKcB0cYwstcZszPPO6wnc6DuiT?=
 =?us-ascii?Q?55R96quKzIhs2MrBeLcWIV0+Z3k/7HcQGL9DZg0P7eN6nnQWA2noNvBRHCJG?=
 =?us-ascii?Q?RW63giDBDMks5J2CknZAMeNrTvfXJ6UaE3sfMNirk/sMAV6KwjIaJONjxHqx?=
 =?us-ascii?Q?FFVtP18QZEtZc2B0iF8kPPRu7p3JGF13OMAbaiMmAqQ9ruwDcObRMHvdtAmt?=
 =?us-ascii?Q?/JUTXIuJ1W82GSbFrfG23dJANKsLB4ULxeityq1t7T2+2XEioHQMSf596oBy?=
 =?us-ascii?Q?RAgda6GlmXLB4wMd8BYkglsK4/CAoAg/RM0i2A1+2so4A/IPOv7aXxcAvJFN?=
 =?us-ascii?Q?PqbC5deMfzB3Sdk6dFVrHmpyM/sMCuucw9N5LC8uLm7RghsPMVX+/wlNiFcx?=
 =?us-ascii?Q?lL4+/C+eUvpekWpogJfxCxyZojRvJt/IywVpROgjREichX9LQ0sOrlxZFQbZ?=
 =?us-ascii?Q?zdbEQ9Qu8wkO2kzKb1ZEUGS0nQwNVUW1XzAGKvvQLz0wuyZ+L+FLzbvjpVkV?=
 =?us-ascii?Q?RLWJMkjf+HqQV215QmsGj5J37jK+T+14Puog8GREWbDiEOIfnJDM+SBBiUW1?=
 =?us-ascii?Q?HsDgcpfNW+I/+Ngb9cb9dbp1h/z+IWHyJyVzAXz7Qa8Z0fQdS7YMFjOAOBF4?=
 =?us-ascii?Q?QjdQfdufV5QlXxRjKEVdz+f5skZRUz84HnFvCBi6HokFpk8zj0CpEjr1aOdf?=
 =?us-ascii?Q?CEhhcbs+v8IvLB3F6hR9XLL/ylu18u5MwVKULtmAz9/QTzGrMbv0dwHubkeg?=
 =?us-ascii?Q?wkJSgE8Wf6vdrZ0siTn7NIY9XpF7NpLD3vH5+k/GYOxsFWWjEeCdH0xDQCBR?=
 =?us-ascii?Q?ia5lxmTacnwXLUZ39hoy4MYVu6OIg9hM9lfkTSrloM+34/rX3Gp60gQN39P4?=
 =?us-ascii?Q?GTS0D0KlX5xwkZ4BWUv9jHheMHvRWaySPC1ufglYWro0p8EDmNBKsl3LzME7?=
 =?us-ascii?Q?vCLVQVSSvax9uJJRLaGQ1gDUsg9g+AOqFAbLNyJ1Ocbymc827p/YRkF5aXXJ?=
 =?us-ascii?Q?iN3auM8gQuBjNFWcPLNeg5lB4NAusVOhLFpppBH3Fa2sw4wWwIWPMT1W+Mw+?=
 =?us-ascii?Q?zf2qRSmFEEW95+9v4MyHRWgwN8KGWhaPL3fPgZphCv6UgSqZc894q71IlFad?=
 =?us-ascii?Q?le93LG7XpGx3P+vsD+htygOBj6hclKlofMmvNCJL/c43IUXHxmUQ+yLL5Ei4?=
 =?us-ascii?Q?JznpNP1V6V4bO1zxGtGeeEI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDF40A179EDE834D90129D4EF39D9AD6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4dd6c85-c41d-4917-94d6-08d9e1f234f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 00:07:43.5830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeDzMUkZcqS49j5Zk1kEQ8Jevce4q74brOQp/YKcbACnMcTB9mtTXevWYWI0aFyDz1mBGCzLz6fQ131/nQ9+Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2938
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270133
X-Proofpoint-GUID: 38LGQ9eaAvkKK58Ri52d5gKx6jhQiy6P
X-Proofpoint-ORIG-GUID: 38LGQ9eaAvkKK58Ri52d5gKx6jhQiy6P
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 27, 2022, at 5:41 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 28 Jan 2022, Chuck Lever III wrote:
>> Hi Neil-
>>=20
>>> On Jan 26, 2022, at 11:58 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> If a filesystem is exported to a client with NFSv4 and that client hold=
s
>>> a file open, the filesystem cannot be unmounted without either stopping=
 the
>>> NFS server completely, or blocking all access from that client
>>> (unexporting all filesystems) and waiting for the lease timeout.
>>>=20
>>> For NFSv3 - and particularly NLM - it is possible to revoke all state b=
y
>>> writing the path to the filesystem into /proc/fs/nfsd/unlock_filesystem=
.
>>>=20
>>> This series extends this functionality to NFSv4.  With this, to unmount
>>> an exported filesystem is it sufficient to disable export of that
>>> filesystem, and then write the path to unlock_filesystem.
>>>=20
>>> I've cursed mainly on NFSv4.1 and later for this.  I haven't tested
>>> yet with NFSv4.0 which has different mechanisms for state management.
>>>=20
>>> If this series is seen as a general acceptable approach, I'll look into
>>> the NFSv4.0 aspects properly and make sure it works there.
>>=20
>> I've browsed this series and need to think about:
>> - whether we want to enable administrative state revocation and
>> - whether NFSv4.0 can support that reasonably
>>=20
>> In particular, are there security consequences for revoking
>> state? What would applications see, and would that depend on
>> which minor version is in use? Are there data corruption risks
>> if this facility were to be misused?
>=20
> The expectation is that this would only be used after unexporting the
> filesystem.  In that case, the client wouldn't notice any difference
> from the act of writing to unlock_filesystem, as the entire filesystem
> would already be inaccessible.
>=20
> If we did unlock_filesystem a filesystem that was still exported, the
> client would see similar behaviour to a network partition that was of
> longer duration than the lease time.   Locks would be lost.
>=20
>>=20
>> Also, Dai's courteous server work is something that potentially
>> conflicts with some of this, and I'd like to see that go in
>> first.
>=20
> I'm perfectly happy to wait for the courteous server work to land before
> pursuing this.
>=20
>>=20
>> Do you have specific user requests for this feature, and if so,
>> what are the particular usage scenarios?
>=20
> It's complicated....
>=20
> The customer has an HA config with multiple filesystem resource which
> they want to be able to migrate independently.  I don't think we really
> support that,

With NFSv4, the protocol has mechanisms to indicate to clients that
a shared filesystem has migrated, and to indicate that the clients'
state has been migrated too. Clients can reclaim their state if the
servers did not migrate that state with the data. It deals with the
edge cases to prevent clients from stealing open/lock state during
the migration.

Unexporting doesn't seem like the right approach to that.


> but they seem to want to see if they can make it work (and
> it should be noted that I talk to an L2 support technician who talks to
> the customer representative, so I might be getting the full story).
>=20
> Customer reported that even after unexporting a filesystem, they cannot
> then unmount it.

My first thought is that probably clients are still pinning
resources on that shared filesystem. I guess that's what the
unlock_ interface is supposed to deal with. But that suggests
to me that unexporting first is not as risk-free as you
describe above. I think applications would notice and there
would be edge cases where other clients might be able to
grab open/lock state before the original holders could
re-establish their lease.


> Whether or not we think that independent filesystem
> resources is supportable, I do think that the customer should have a
> clear path for unmounting a filesystem without interfering with service
> provided from other filesystems.

Maybe. I guess I put that in the "last resort" category
rather than "this is something safe that I want to do as
part of daily operation" category.


> Stopping nfsd would interfere with
> that service by forcing a grace-period on all filesystems.

Yep. We have discussed implementing a per-filesystem
grace period in the past. That is probably a pre-requisite
to enabling filesystem migration.


> The RFC explicitly supports admin-revocation of state, and that would
> address this specific need, so it seemed completely appropriate to
> provide it.

Well the RFC also provides for migrating filesystems without
stopping the NFS service. If that's truly the goal, then I
think we want to encourage that direction instead of ripping
out open and lock state.

Also, it's not clear to me that clients support administrative
revocation as broadly as we might like. The Linux NFS client
does have support for NFSv4 migration, though it's a bit
fallow these days.


> As an aside ...  I'd like to be able to suggest that the customer use
> network namespaces for the different filesystem resources.  Each could
> be in its own namespace and managed independently.  However I don't
> think we have good admin infrastructure for that do we?

None that I'm aware of. SteveD is the best person to ask.


> I'd like to be able to say "set up these 2 or 3 config files and run=20
> systemctl start nfs-server@foo and the 'foo' network namespace will be
> created, configured, and have an nfs server running".
> Do we have anything approaching that?  Even a HOWTO ??

Interesting idea! But doesn't ring a bell.

--
Chuck Lever



