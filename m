Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF50A4AAAA3
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Feb 2022 18:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiBERf0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Feb 2022 12:35:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29600 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380790AbiBERfY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Feb 2022 12:35:24 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215HXhN8003626;
        Sat, 5 Feb 2022 17:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=a/cUmpzb8Z9IN05DKzjEJw62Dkyivmp/8UffWoi8tow=;
 b=HdBmdqEz30LL6RM0eXpXv5A6ZCAYaLLe2I30vT7puQ5Gk1gVCXTqLgcwIq2/kHaofBVF
 boV5lJWFjKGACVPEu46zi53KLheO2t3C15j5havAyrO8AiQci+d4yA9sn5fXhO0iIhfr
 kCnn/8ehYXRF8hz301/KYorBhaL7TrS1FjcHMovZucLokn/xDJy846Ef0c5eHH3EoDve
 msTKys2COsgOIj67apz5f1hGYRYmfK3c5FTkXfwYkT4ceVW9YXAG6PYEunlGOa+fFzX9
 SjWdQcK5W8cyMhiTQ9pnioOvXl2ShsLD1bzuT0DWAjttANb6ZWeeGY2ijDQ8jiB/0nIS Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13hf31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Feb 2022 17:35:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 215HVbPN052791;
        Sat, 5 Feb 2022 17:35:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3030.oracle.com with ESMTP id 3e1ebubcju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Feb 2022 17:35:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv7a0qwXBxDbSePLDZAiZyCpa3CGjwyVnvZyR2goD8rVZWWazxYyE+xBBsIRuN5RPmWaCOC7hLKR+H3yPbZ3y2yn/x0hKJKmcSgczEq6OwYppkLeW70L8pbTyhobkhLMoLR79fShkkjOIAgtv4B/aVUyr8hnenr+ZqOCkEyNABvok8ceDTlyjvW69HBOeHz90W21zruCZ9EXDN8GffoEecU6V+7xeEl6IDrYohJlUp06SY1HsbmyxD1scZWoyMVv6V3BTJwmM0vHl/+YHF6bwJtF3JRhjZRn+s69j1iEO4atdj/vxgY77A01yWmfssxp9Mak0ks5HNDs/cj8omeVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/cUmpzb8Z9IN05DKzjEJw62Dkyivmp/8UffWoi8tow=;
 b=m19Yvl27cUe1Twz7GDq5x6rRJzZYkVKCQcgyIONJ+62KcKX0faoMuhkuS0AhuHiueUVe2xBKwCiUz/FIBxEX4Giyq65j7RfTZm0rjoeLFl4mrYV92JzPCfsvsXZWSrczhPEueRA8rlj0b5iSFlOK7EEsbm+B2lhP+nmP3Vt5pXiXJs4W5+pf4Al95bJ71/kA6VG02ZAldfCW9IIBvPNhA3vEK1CuGGKGqWufGh/1czDliLK3Bt2U0i6uY0Y7Jg4uGlHzesCpuHxhIxDR0J0p0m66FNyomhmkoQypesx5vzr7maRFLMzPf2OX2riqGX6rlJVC+/JvsWNqs6yYxmUW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/cUmpzb8Z9IN05DKzjEJw62Dkyivmp/8UffWoi8tow=;
 b=xvmIMK0OfzAdyuWrfdRSSf5XNlDAIAG8oxS3zi6jxjGc/WX7tq+RpR+d/znx0bMxpSqepfZLN3EyewNU0NGIubsjhTs5OYMVjcXMVa334gpOLCFOGOy/dBps9NmtcqafhC2N2CVphN519FUdnOfDWDe6QJHfzHMdz/mLfR49q20=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CY4PR1001MB2151.namprd10.prod.outlook.com (2603:10b6:910:42::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Sat, 5 Feb
 2022 17:35:19 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.017; Sat, 5 Feb 2022
 17:35:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Topic: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Index: AQHYGca9ZpW/pPf5rEWUIwyc/qfEDKyDgRyAgAAI8gCAADEtAIAAEIEAgAFuM4A=
Date:   Sat, 5 Feb 2022 17:35:19 +0000
Message-ID: <43ED656C-F74E-4D56-85E8-F3DF073E282A@oracle.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <87EAC6F6-C450-4642-A11A-55247C791D66@oracle.com>
 <32889B9A-1293-4050-8131-726042D1EAD9@redhat.com>
 <26803BBB-4F2C-4EFD-BC8D-A50A5C361E5C@oracle.com>
 <D4204C55-78E7-4078-852E-FECD38BD3AA9@redhat.com>
In-Reply-To: <D4204C55-78E7-4078-852E-FECD38BD3AA9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d851807-4eb4-4882-3577-08d9e8cde156
x-ms-traffictypediagnostic: CY4PR1001MB2151:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2151AE86586824D8E4252DCD932A9@CY4PR1001MB2151.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GxNaxwN5StUxRVdOEzqk52VWTixmgtFePfz+/P11YQGMr4evZ2YG/+i6tgBVwggXnnuNQ18QGc8iNWzR/HJMmZKWvKdCu17qZqBnqahghtXVXq4wvReK59heSSsnGmz58hr7rgfBIvNmKOyfPE74Lbh+GW7XIR/PcaX1rGsRApDRcVBHrJvb1TP4ZNx+NolzMyE6FoflNHYYvRMHBOOpCZ4nbUf8PeO2dnz19hf4uCwca+4E5jxyVB2fIDdNmgpnWm9DrqVkWqA0RFY1eMO0o+XPTcxdv0I+R/Hojek9+5k56XzKuJKi18N9ClPM6Cb6VwGpoxXWXne9zI6RIQSuWvAYeEmYJaLLbVn+Ob1TmllfM1OQ14letd7DSkJPnOx1nvponnaIS3mLjuKvSK7IPj+Mc0zQ06InZ0/OYFgjrjB7CCDGnVxbPidUp9FJTp7Lgw1mbzaEashhmMvee+BH7hCGZA5m/7h3G/NyJLaiP/WBqgICgYThskUWisZbc9Fmqc6lJZZsTa7Z2QyUsx0jAJgVRoCUPKYBD7eKfRnQR0XuXORskeXZhzYivSONlVjuQRjyYD1nJ3J7eRbiU9KJzzMowMMnRgFNqFbMpYz2F10B8TVtbVNX7d3YEk4vS3bhf8EjBuYrcx8Dceux8URAR/eHn6MRZkYOVaohZ263T1MMd0Whpkck2DV1uvA1D4S4tB9sk67ToJ0/pL/GPVxwr3byIqiwcvnWDzRzOQsDEb3Cm3KlHr2oxEj4YPrN2bNpvudQ6ZiqBiypgIGaok6JHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(5660300002)(2616005)(64756008)(8676002)(2906002)(83380400001)(66446008)(66476007)(6916009)(36756003)(53546011)(66556008)(54906003)(316002)(186003)(6486002)(26005)(38070700005)(76116006)(86362001)(33656002)(4326008)(508600001)(66946007)(38100700002)(122000001)(8936002)(71200400001)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TMwfdr+0PACxmVK+tXe1aJ5QbF8quNgWR08TYjTBCbM7a5hsDkZe9HznDhyD?=
 =?us-ascii?Q?iYXv3dyoD7PWfjK2Wh/9ui/Pj1vHmfBECRq1VxmkLFEIGLWzp4xGN3h/Q6T3?=
 =?us-ascii?Q?8c+FAwpVx+UujQmeLtiz4F68Rw8CRnZoeqVhdoN/ALY1+hFvpBb2+evX0rbc?=
 =?us-ascii?Q?QBPkact2YtHjldwIPe/MxGuo9Dd0AOi7HiqrFe/z5z5en6GrAaZs5+PuQO0n?=
 =?us-ascii?Q?8nIX716l8QojXfTGvkOHqaa3g8yUj7FL1SfF6usUDAbpc2w9d7fBuxssGj3t?=
 =?us-ascii?Q?o4jyhd7A992tKthC4tirBy4sB4NuQcvrnLrgPk3YApDFWX1Xly0cISs4KVq3?=
 =?us-ascii?Q?T58AAGHlrsggSZO4XU393QsDevx7RxpeZYcdwKk9MjDjPxUOpp4CBjxJMui1?=
 =?us-ascii?Q?xLcTM/ISjEk7btIdlcLbzXGIx2JuuZuUX4MbpKjjMRgSywEZnyuYJV30+clJ?=
 =?us-ascii?Q?zk/EsHbANAtuEFemEvjZ6RdrsNF3PyjDz/FAS5cKoCX6crOG14gpxkmOxr/N?=
 =?us-ascii?Q?HvLTeqLNWAz6FVWDOlEY5vx03jfJIVxcmgFpMyOTv8dhGiLyD6M+PAp0M6z+?=
 =?us-ascii?Q?YMaGxE1dBXJbL1uD/TKWHkNuLLo6OJ72b6AJndXzT/cLDDGJmaoVtImByH/O?=
 =?us-ascii?Q?3p78Sa3eEGT67U57i72EvUOKC4l6sEoeTFzW9DYmRtpGhu7EF880RcjiX1Yo?=
 =?us-ascii?Q?cT8UY5cHyrMPnILRoADN0iGDNBKQjoPMYWAwEf/E6lRUreaIEnEsIRoSc+PO?=
 =?us-ascii?Q?ycrvD631x+NpKL7r8jOlMJM/gH5G2VGtyfZXD//X5hq/Fc9nCWFMkiNnyH4S?=
 =?us-ascii?Q?Afns1htf2QbWHlA4TdpBG1HgS1sVEPB4cmuFpU4ucumFdf/rK+AO/+yrP4w2?=
 =?us-ascii?Q?4f1cPkJv+C8DNGl0IS/4yRlMtqic3jDYMk8DorsR0Ou5uv15dtXH8QjAEMy1?=
 =?us-ascii?Q?HYGAIsbfI2I9SLryo9oCBBoKIHeb1stEJud+1Aem8ceWAhu16J6QgVd9OIh/?=
 =?us-ascii?Q?8B5ozcVqlsToCjmKB0vnxPYe5XADkrgJPPkVCd2zrCiaaFoVdbGwQ71QU/M+?=
 =?us-ascii?Q?/A1EzcUAPrAqJoHeA2t6d6TzKJEOmwTc86TkMNH4kQZ01Pw3vZ3lZtOoSpWw?=
 =?us-ascii?Q?pr6vpEP+7bmHbuYzaANAemAqpY8pJo8UV5/h6bhlJJyw45+yaUhLyuhfp2oA?=
 =?us-ascii?Q?W38hVC+I+iiVYVApL2Jh7iMSC/0/JBEGVVxkGKwFbYNq6kyFVk45yxr8XIH4?=
 =?us-ascii?Q?5yRrIB5V56Mrg0L/dm2MtH6Qqmwr99PKRZEnUmkLqvXr3xIGVmnDuoXkd6cv?=
 =?us-ascii?Q?D5cL0pb+SE6kEDdLP+ZrdOxGJChibW045NLmRHVrXofmdC2ol9RZGTkO4fgJ?=
 =?us-ascii?Q?Q6dHcmSGTH2PAjtLHtFi1svrvyc34PVCzbzVJgNoY/BFLWHeTDUwYwzwnB3i?=
 =?us-ascii?Q?pJjMMRA0dpoWqNM34jzS9TZ90hZROBdSDoLOx6d8+TgzRKZam6emTOA0kCu5?=
 =?us-ascii?Q?HioXHZv7D5+cVYqYHBfY4GERLws7OKaC+guh1i4y0yXQU6OHuQoTK6pOM6IS?=
 =?us-ascii?Q?T+XpsVSGdGlt7G+xnuFODaFD3GAX9biBBo+O2EmnaGfhOI94mBMmC3m61ZkW?=
 =?us-ascii?Q?ZsJ9eBeZzcO/MrGiOYSb/00=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <065698B91BEEEB42B365891BB9C6F140@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d851807-4eb4-4882-3577-08d9e8cde156
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2022 17:35:19.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ZqpuA4DPDtZZDpNZTG7K1axGZybkI+D7U4lQnjnKf3shx3A9huRyKUZ7u5r/gXFHctNq+J+ebN3KcYzn++BiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2151
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10249 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202050117
X-Proofpoint-GUID: GmAEuXnqfJI3a8p5UMm5Cz-fWZUnzmrG
X-Proofpoint-ORIG-GUID: GmAEuXnqfJI3a8p5UMm5Cz-fWZUnzmrG
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 4, 2022, at 2:44 PM, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>=20
> On 4 Feb 2022, at 13:45, Chuck Lever III wrote:
>=20
>>> On Feb 4, 2022, at 10:49 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>>=20
>>> On 4 Feb 2022, at 10:17, Chuck Lever III wrote:
>>>=20
>>>> As discussed in earlier threads, we believe that storing multiple uniq=
ue-ids
>>>> in one file, especially without locking to prevent tearing of data in =
the
>>>> file, is problematic. Now, it might be that the objection to this was =
based
>>>> on storing these in a file that can simultaneously be edited by humans
>>>> (ie, /etc/nfs.conf). But I would prefer to see a separate file used fo=
r
>>>> each uniquifier / network namespace.
>>>=20
>>> This tool isn't trying to store uniquifiers for multiple namespaces, or
>>> describe how it ought to be used in relation to namespaces.  It only
>>> attempts to create a fairly persistent unique value that can be generat=
ed
>>> and consumed from a udev rule.
>>>=20
>>> I think the problem of how to create uniquifiers for every net namespac=
e
>>> might easily be solved by bind-mounding /etc/nfs4-id into the
>>> namespace-specific filesystem, or a number of other ways.  That would b=
e an
>>> interesting new topic.
>>=20
>> I don't think that's a new topic at all. This mechanism needs to
>> deal with containers properly from day one. That's why we are
>> using a udev rule for this purpose in the first place instead of
>> something more obvious.
>=20
> This isn't a mechanism to deal with containers, its a small helper utilit=
y
> that we'd like to use to solve an existing, non-container problem in a wa=
y
> that's future-proof for containers.

I understand that it doesn't support containers. I also understand
that the uniquifier issue is a nagging and ongoing problem that
needs to be rectified as soon as possible. I'm not pushing back
on this without (good) reason, and I will try to be as helpful
as I can to move this forward.

I don't believe the solution to this problem is complete unless
it deals with containers. I fear that the simpler non-container
solution will be merged and then we will all put our pencils
down and never deal properly with NFSv4 in containers. Or, that
we will get farther down the road and discover that the simple
solution has painted us into a corner, and significant visible
changes will be necessary to get proper container support. (This
viewpoint is based on watching other subsystems attempt to go
from single instance to container support).

I'd like to have some confidence that neither of those things
will happen, and I don't think it will take a lot more effort
to see that this is a proper and complete solution. To be
absolutely clear, I want to see this issue resolved, but
without adding more long-term to-dos or other issues hanging
over our heads.


>> The problem is that a network namespace (to which the persistent
>> uniquifier is attached) and an FS namespace (in which the persistent
>> uniquifier is stored) are created and managed independently.
>>=20
>> We need to agree on how NFSv4 clients in containers are to be
>> supported before the proposed tool can be evaluated fully.
>=20
> I disagree.  This tool is immediately useful when I have multiple NAT-ed =
NFS
> clients with the same hostnames and they end up with identical NFS client
> identifiers.  That's the problem this little utility helps to solve, and
> that's the real-world issue we've been asked to fix.

The real-world problem is linked to the container issue whether
Red Hat likes it or not. Upstream we have to think about the
larger issues.

Again, I do understand the narrower scope of your bugzilla /
enhancement request. Yes, your proposal addresses the narrowly
defined issue, but I'm concerned that it will introduce long-
term problems.


> I don't think we have to solve all the problems at once, and I think this=
 is
> headed in the right direction.

This is the best solution I've seen so far, but it needs a
little more design thinking IMHO. Like earlier proposals,
there is still a possibility that significant and visible
changes will be necessary to convert from single instance
systems to containers.

I'd really really like to avoid that, and I believe our
users would also appreciate it.


> I can commit to working on the namespace part..

I very much appreciate your effort.


> but there's a number of things that aren't clear to me there:
>=20
> - is udev namespace-aware?

I thought that it was. That was supposed to be the reason
Trond went with a udev rule mechanism. The rule is supposed
to fire when each network namespace is created.


> - can we get udev rules to trigger for a namespace (my simple tests show
>   that my "root" system-udevd doesnt see the creation or entry of process=
es
>   into a new network namespace)  Maybe we need to run udevd in every
>   network namespace?
>=20
> - can uniquifiers be network-namespace uniquified by just using informati=
on
>   available within a udev rule, or do we really need this utility to be
>   namespace aware?

I thought that was how this mechanism was supposed to work. I
believe Trond even posted an example rule at some point in the
past.


> There's a bunch of stuff to discuss and figure out (unless someone else
> already has), maybe we can start a new thread?

Since neither of us is 100% certain, can you find a container
or udev expert inside of Red Hat who can give some guidance?


--
Chuck Lever



