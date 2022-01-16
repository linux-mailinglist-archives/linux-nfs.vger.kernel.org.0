Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E8948FF74
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jan 2022 23:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiAPWbd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jan 2022 17:31:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42252 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236281AbiAPWbd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Jan 2022 17:31:33 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20GDrIGf015429;
        Sun, 16 Jan 2022 22:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hy68FI7xeqRcXCBE9PQm30hmGhAPL9ywzP/iqjWPyVg=;
 b=aBpXa/6DsE9gBLFNS2ytKcduIxO6a+TE7k9w/lotJWNgnBceecE+Q4jG7z6fwxKlxgJr
 4jpGhZV0gUK7eTp/CVSzb+CDd9xqMgkvSRSu43Dw/LoOunvlxkiHaQRhNzV2uXBmO3gy
 DUJUbUIZzrehS74Wg6su0O9jvXyzIOx+tszAPn7ltxXAwa/dBDSmNE5mTE/kAPW5ks0l
 FBf57auib5GHkGkqRxLIzgcGNPVX7dTM9OJNdLv5ZRZzKT+M70PbdGLjcN09a72cIWRA
 DS/bb4DLihQxwRYUlDaTjfWDoSZIn5gNCa4c1m0+1fdpMQYjfSufN7iM/9NXqewzG+i8 NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dknvst3d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jan 2022 22:30:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20GMQQnr164946;
        Sun, 16 Jan 2022 22:30:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 3dkkcum78c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jan 2022 22:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sey5uy4xSmXYLfFaR09g4ozEGm9S5KhPSVQiWr7iK3vSGFIbTmBNkFGYeORGMtcrLa4PdwhOypRiJeImXskjS/l3rl2neJXpOysw9dIF7pBjO45zzHoFnWQ9FOC9cU7/OeFZiyd16GCnjCZN3wEaBTWgEHNZUEZdHz87nXiFszICe6cqU7VrvIJjE+gE+UdKIfYJ+KXinbpCcRJRi6WQFn204VQOK9zbJ5ILKowGtGAUP1D+hofhpPjGU71Xa3vQ0xF4l1TJ+m4MF+a5s0LQ5zgucd0fMXRHD6W7NIHVd1wnfUMfILJ3tJJO7WpAN21G/GGDwRQyp5Q6ZTXrjv3t5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy68FI7xeqRcXCBE9PQm30hmGhAPL9ywzP/iqjWPyVg=;
 b=DO2HOY1aqY0GfRIRo7vOr7SEFseYJYCVIXXFfi1BPVwAbD8DSaTBePqpZOTCTW5cz6CNRCmhkcFj6K3imq3xJlWGvkkgEQsk3zO4Xvl0DD7wK6daOWTdGzQh5tZttuTdtHXCsM9patSUHDXSCXLHPZ9EqDqNYLBVWvLUCq/d/7TFtnew0vGHAxiTILxWm0KYQfNBg/4E5pPSlA/vOhAYlvs3ew499yCHxf0ucdte6bFxWsGwl1+/+IrQBFHYuU+t61n7psrbdTrODwJWWzobPtVmBtnC6zaZoaetszPMWtjTQuSzC6myqZMgl/x81b7o0frnoKnbrxUNMhsxUI7rHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy68FI7xeqRcXCBE9PQm30hmGhAPL9ywzP/iqjWPyVg=;
 b=wR9Egpr9cAW8CM2wPwAiHfGViVr5iIO3YfE4AF51UCmn0rx5iyqmKUoIUdUMIeZ+nuxrERxmfg9l3pwrsVjJwDHuGkD0K1RD8oOeglqbyp3ncxlUCLR2xywSJPUYlENr1i9/MCFx0m0TEkShYKARv45j9W5uGmogX0t4DqNmdPM=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CY4PR1001MB2054.namprd10.prod.outlook.com (2603:10b6:910:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Sun, 16 Jan
 2022 22:30:43 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 22:30:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jonathan Woithe <jwoithe@just42.net>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Thread-Topic: [Bug report] Recurring oops, 5.15.x, possibly during or soon
 after client mount
Thread-Index: AQHYCTZE+ENVwkeetkGrNbALtTtuGqxioWgAgAEb9gCAAMFGgIAAGz8AgAGeTYCAAAbHAA==
Date:   Sun, 16 Jan 2022 22:30:43 +0000
Message-ID: <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
In-Reply-To: <20220116220627.GA19813@marvin.atrad.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 358a1cb2-9499-4cde-f0a3-08d9d93fd546
x-ms-traffictypediagnostic: CY4PR1001MB2054:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB20543C235424104FC20750D993569@CY4PR1001MB2054.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4nbHs8rpFo5XeC8AFG58OxuENIUvJTGB7erEQKnMzDd121/Oib1xC167QUy8ctR4Uovecz+0wNrcguAJtD8PUnBL6gSfKGjcXh8mNxX1iJVkyauTeUNmx4zzkVcMiqEHYPK3O6ul1tvk4oWMq4qdS3FxlU9uhpjeNSJpQs1ssevToDPWHu1qa6PB54McjysmauVKdjO4F/W//Xj3rwijYM2uzfqGAhrnFlFKlD7qqWDqWfFG6cPwNrbzD0klWcctF5gzFTmYy3D4yNb88fK3xVQcIQKiqBu3oBdHw2MDgAS3y2/Rhqxy4PSahhPCuU+LQNk6vhEmdc/61q72pQZKQDhEVLH6LCoaEIAY6nerB2yyy6+qDxnk4JCvxzgBHocpkEPykvVNiPnGG2S1ibVLSRDua2hueTMTwauunTDsOLwBz2Gl/7mRB+LmKTiBzZxYL4mmJYxLv122M3pO0iCLm4JcTeVemM4p/a2d6mdzTMgSZCfcImQ0PbKuMKiPM8pJ1OvbLOv3/QIzJxVba3VyNuA1a4RZMbvmzhaior1Oc4jndmIUhT06WwnJO/6q0venw3gUdltpE6Z8l1vkIY/qEOSJTsEy5z0j0sl/jgiM19T90s1jmi9R2QCT39HOe6h+GUpLEKL2uOrgOg6W0R1p25dU7x45Rvms6V8qYhuuoR/RQLA28ZSjl9lS8GXsUO4GGRVFytFC3XgaeVr2ZcrWrN+/GGNdoNjzNwZzJD4LuCPsJUGSGE/YjejBob2SZy9L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(6506007)(54906003)(2906002)(71200400001)(186003)(4326008)(33656002)(66556008)(86362001)(2616005)(66446008)(66946007)(76116006)(64756008)(66476007)(53546011)(316002)(36756003)(26005)(5660300002)(508600001)(8936002)(6512007)(6486002)(38070700005)(38100700002)(122000001)(6916009)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k81dbH8/qA/IuhgjjC8/ViZezDQVML8E5nCw0B3Sz5e6mxmhycIPt9r8KEOW?=
 =?us-ascii?Q?qSuyNwwgIfucwUsoQ4lnvocn17cGPyZgz3zBg0CZqoy0Lpi5fzE4ZJDhVY/e?=
 =?us-ascii?Q?YE/K8VD+XKQc87xkmWWN945dafB87bf6JmPDpfSuxDqq3blTL4vY7BWo3R3X?=
 =?us-ascii?Q?zB0uyuqu+5RpoL9BKaz17Isj+WDbjt6a/82neamjW5a9RY39vh93m1982VHp?=
 =?us-ascii?Q?UyC3CpF7godE5bEaGrLlb4f6erjreFAJPQg8uE2hmtpSmAXx2MwlGwuVPUeK?=
 =?us-ascii?Q?25l98Kv3JTK/R1OOmjsY95zuaMlEVHq4jLjGxmb2fysdPTfUxdB71X9y3HU4?=
 =?us-ascii?Q?tSgg6SyFYXEv93gKY9z2pKudRyQBrZxH/zC/djePQv8lCdzf5SkMYL/yLLEO?=
 =?us-ascii?Q?XjJC6pfUvaqybKh14kc+35ANoo8ytsHyq0NuvwQOeBZmXYjqM1sdIyZYJPt1?=
 =?us-ascii?Q?y1UFdQ8QbRLRhALy5/xV5qf/EXXgmiB/MLp3tUE6ez+WUFmqcfcNEeMVwKfo?=
 =?us-ascii?Q?O8My/x0T/TpnYkG/YR4mzSHwS1D4RZEZRnpqooPT6nsWgzcCIRjSFj1EvAv+?=
 =?us-ascii?Q?vCvJQK8mcFLffcq2kAYUksthVTzpRwt0gcHdXg5qpAZVGBaJcApJFtA8gWUm?=
 =?us-ascii?Q?HsT44S2mAd7uU0wjoLktu1Q8TYhjq4mcisWih7OjF2AV/xaPtBu7cXw8U20a?=
 =?us-ascii?Q?0F5AMUud3ETWrF+hIXQ7RRDlsXeS6J4iZpg4kxOncxxWxUTowmdTTBYmNVOn?=
 =?us-ascii?Q?0t7ew4wEySUYy9BKvaAh8FoJ9eH17J/eWlupJHbXGySRjhY1LSbo09nj8KCp?=
 =?us-ascii?Q?aPyRSkoBF4ZHfrx1MkZ8gyRrrlGGwQA0R454ldwvP/Fj5KY/h+ifBNFGeCWY?=
 =?us-ascii?Q?jL3SCx7icspbdlVEmBYMEZND0EHJhphWiS83FmxnTIncZQMU3ZQw07RfSgu+?=
 =?us-ascii?Q?ZdgW0dB8m4Lq8G1H1I8FLtxP/BpU3C8T2oy5NRVxWYLQ2gIyNILQRLlNKhrE?=
 =?us-ascii?Q?4G3eF7FIduaJnQ0gjKTzdfN0gqgi0PJOrCEDZQdsZdGVlOVZHKXB2B+P9Fym?=
 =?us-ascii?Q?Nihl36DSm6tn8q+yRJso8oNkT9MIi2QLDpZBVa2bg4R5vh1dCZnPuOthxamx?=
 =?us-ascii?Q?MFwywCc7aPX6JF/02yGcgydrgNZR6gc7PEJobJEOPD1GD+dCyF8mwgGA/l3B?=
 =?us-ascii?Q?w2gcXWHI4Uh+nk4zqA/27tXbDkCY3WCiHvxVDjsG4QCPw2CYNj+VWc1OSi6C?=
 =?us-ascii?Q?fdG3d93t4GWywiY5+Td88EtCv/r1ZJAV42Tr90+BRy+8lwWFm2UWT7D03FTS?=
 =?us-ascii?Q?47loW/ytr9zdTPtvSSlm8KQX95IfnckvFVaLPj0mP5ohGS5/MjhK5LgCLOYR?=
 =?us-ascii?Q?v1KvO/CMjus7lIpiTPkeaP6tA7FrYDPP+cszHm2KbRIJZ4JOjmdW5h25yfjg?=
 =?us-ascii?Q?sMR2J9tld/s8u5APDBZjMj2sRGq9sB9GcisiYIPCXk4zANtMnINDPACpiId4?=
 =?us-ascii?Q?zRMKwfAsRm3p6Tx/lfOF/2/HitKe4FUaI5BTlfX09i+Rx9A9Lds3N8zdZQcH?=
 =?us-ascii?Q?0cdSNOHJGCCI39Axj4gZiSTrCx8gs2Bz0j4YyuP5XFMVlqYO2+bHZujc/jAP?=
 =?us-ascii?Q?Oyjg+b7B/hDKd7AzmkwKX0M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE3772B80311B84DB5701F59AF0A585D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358a1cb2-9499-4cde-f0a3-08d9d93fd546
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2022 22:30:43.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9Z7FgnKUY5K7JoRucjzlk+PrRRMeBHHdOhN2ftgSqe1iaFdvXc62CphwXfaOVEvALdQ11GT13dFF2/l3Nf3hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2054
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10229 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201160147
X-Proofpoint-GUID: HIxPMseXNflE2xL8c9Y01EmCXkdDqQKL
X-Proofpoint-ORIG-GUID: HIxPMseXNflE2xL8c9Y01EmCXkdDqQKL
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jonathan-

> On Jan 16, 2022, at 5:06 PM, Jonathan Woithe <jwoithe@just42.net> wrote:
>=20
> On Sun, Jan 16, 2022 at 07:53:36AM +1030, Jonathan Woithe wrote:
>> On Sat, Jan 15, 2022 at 07:46:06PM +0000, Chuck Lever III wrote:
>>>> On Jan 15, 2022, at 3:14 AM, Jonathan Woithe <jwoithe@just42.net> wrot=
e:
>>>> On Fri, Jan 14, 2022 at 03:18:01PM +0000, Chuck Lever III wrote:
>>>>>> Recently we migrated an NFS server from a 32-bit environment running=
=20
>>>>>> kernel 4.14.128 to a 64-bit 5.15.x kernel.  The NFS configuration re=
mained
>>>>>> unchanged between the two systems.
>>>>>>=20
>>>>>> On two separate occasions since the upgrade (5 Jan under 5.15.10, 14=
 Jan
>>>>>> under 5.15.12) the kernel has oopsed at around the time that an NFS =
client
>>>>>> machine is turned on for the day.  On both occasions the call trace =
was
>>>>>> essentially identical.  The full oops sequence is at the end of this=
 email.=20
>>>>>> The oops was not observed when running the 4.14.128 kernel.
>>>>>>=20
>>>>>> Is there anything more I can provide to help track down the cause of=
 the
>>>>>> oops?
>>>>>=20
>>>>> A possible culprit is 7f024fcd5c97 ("Keep read and write fds with eac=
h
>>>>> nlm_file"), which was introduced in or around v5.15.  You could try a
>>>>> simple test and back the server down to v5.14.y to see if the problem
>>>>> persists.
>=20
> FYI I have now put the kernel.org 5.14.21 kernel on the affected system a=
nd
> booted it.  Since the oops has taken between 1 and 2 weeks to be triggere=
d
> in the past, we may have to wait a few weeks to be certain of an outcome.=
=20
> If there's anything else you need from me in the interim please ask.

If you identify a particular client that triggers the issue, it would be
helpful to know:

- The client's kernel version
- What was running on the client before it was shut down
- Whether the application and client shut down was clean


--
Chuck Lever



