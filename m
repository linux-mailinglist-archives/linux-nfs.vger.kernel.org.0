Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0715AF049
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiIFQWg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiIFQWO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 12:22:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7E865556;
        Tue,  6 Sep 2022 08:50:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286FY78e021984;
        Tue, 6 Sep 2022 15:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Sf9IxrWq/EFeTeEyDTeXiTjrfJts7NV+eozWWOmGnHM=;
 b=0oVmT+wo6YGF7Pwym6bqDTyBOfhdGB9bQLaBhSGxICpMMg2WyKW7RMflW0TdG00Xlq/V
 +c7w0XFu1xfdYbl8waPch++/xvs7niBZo7GbMcwER4bkKCtr/KV37oPktQZIfn6wahD6
 YVbQfR8bDCpoC5N85rTPVIiZZQqBDUsS5PEB0gZT9olVJXszGkj/wag4ZueSF79NIWvW
 fcuB8tlR+RPeMZVyEj4jKI27jeQ41/2zwFYZNvpsMFdyGmloGepH7KbMg6a3VZDP4JE6
 K8aqc+S0SZFgb4LhYhwL7N19nBSdk2Asik7nTwD5j88CANamdrG8Mympa9aPHaR1iE3q Yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2ebp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 15:50:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286EwCJM037531;
        Tue, 6 Sep 2022 15:50:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc2ts42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 15:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mone3WSctuiW0MIaNrdJqY9ael73qY5jQo0LYeMpq+gt0Tzt5xI4Ri9GHoBvuth/DdnhQOjEsdEUATQqNNrizKMucVq80dOkB7S7qjMG5cATL7VqPJZiLJjToUCNN0wYszVIq2+T1gN/RRQSfMsxaspisWhEBdbujBNvexIayqCTAJhSYPyMMQBxD/4WsNqK/TXq7A2a2ZXxzuzd0Uo/1z1ZpNR6PwXTcYwGcJLQHtMKgcK4lxWEZgBB7XXXvo512X++jRVSDJ7SWwWftnsMs0t2cvE071uhU22cVSocIwH573wXrTukBlfxqR7RlZPFADPec464w678TIwuXsYWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf9IxrWq/EFeTeEyDTeXiTjrfJts7NV+eozWWOmGnHM=;
 b=Z5YxYtYYi0mwri0BgUF+IOJtJckQnI9RK8dUwyzSgy9UKLbLC51a6+dreZ0u2oEE25+AF62U6ysDeMk1sziZmTX1R4QyGC4evgtWRKlS4dXKIA0shOcm25s/C4PoeRzfYo54uJb5OCvn+uxp91M9p/MsG4/QQCt30BnGGD10Bo5fZ4UdciHKDp0/Gef7Sj2CRA5MrC4tiyS3pJB9HvWbUXWiORoLrxSFzzVZyu5yB7nH/mhua/h+pz2gCey3p6oooIedixHGUohwx+XxaSzDGg87hbhil4zAJbJPsP2xAKKK3c/eALOTK7fJgrzmwZJZY7IeEOKZtqWSYJQn4JYVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf9IxrWq/EFeTeEyDTeXiTjrfJts7NV+eozWWOmGnHM=;
 b=Y75fQJKM/bIaTUzAiwb4vD/CRllrRE86auHhZXUBTK2xb64j/IZ9P/DaCuoe2bksprZUD6yP5GxIy24WpzYZezXvsCYRbUied4vBkreuPOX3hCbX/FrhMIa0ZiRTzpg26hKqoGwYNVZCZjfP7UFUTU22DkV5nToPlBV1kxlX+U8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6255.namprd10.prod.outlook.com (2603:10b6:8:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Tue, 6 Sep
 2022 15:50:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 15:50:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "djwong@vger.kernel.org" <djwong@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: generic/650 makes v6.0-rc client unusable
Thread-Topic: generic/650 makes v6.0-rc client unusable
Thread-Index: AQHYv8UPIvgoSU1RX0u5XzLtJ9lDJ63PQWGAgAAunICAAyFTAA==
Date:   Tue, 6 Sep 2022 15:50:47 +0000
Message-ID: <EC58E371-ED4B-4C36-B45E-EF2B861CAE65@oracle.com>
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
 <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
 <0AB3B4E6-3B0F-4F04-8618-A3257D820FAA@oracle.com>
In-Reply-To: <0AB3B4E6-3B0F-4F04-8618-A3257D820FAA@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41b10499-fcb2-4741-b708-08da901f90dd
x-ms-traffictypediagnostic: DM4PR10MB6255:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPfyGcscqURceI32WJae9xmxh27JUqcUFzSbcPWxg11JhlVzoecfx1/oFH0MnojzMQhpekWYkXhB0bHiwW5RwuLQgmtUxdU39tNracL4I5Onvr2w9SQpxQnD6E0Yn12rTWjbZxCatdd6Kpu/AgKLHm/heBFT4KHBxDVFLgE5G5nupp4km/SAsNz/b1V3njIvmQhqCZWtuwvx1UZoEGqL+XxtmUUOlE20HCdVV8mnlI5X2dd1C3sKI+pZCn7linN/PRnz6cIsOz8tjBldP9QkuHlb4TTXzK4AbfhRlGYV/Gk0jY7u8xAwb1IItMbnwLAMPySDvDKlJ74HX+e1NMFUz748uDAQzefj5gIBhH4yQ+Dpgf4l7P1J+9Tj/0drW7POKjyaiQ5xtSWoPjbKD5dm/onWU1aagaHTe1vAN/QJ/YhA5yZlDXMZFSPJG/SGP5KSTcHCTy3wrYindoVGtGFLrZq1jH+WVoAS9pRerU1jf4UvqyyoyC+Z+I0Kmzm1XS/Enf6JOHAzbrZRAb4/zdzFpmNP4biSwFax+FfXpeO/T7HwBZZ230GhSaA3aJLUyzpoLibq04G8iPhBRRjfIbIM08b1wb9zt34AMOulXm+5rQ8h+1KmcFZO0gLrR985KMoH7U7dmdV7i2qiJXdKaiyq2gRQbSscu/WQN1+2pZJYToqRUDNDn3gIq7uOQlD4XwE/rUnSZQ13iMj6waDbctVFvel47raBbREGoGHTIw1+3Y0FqsnQHChWZI5LpPZ4+6FAC9t2rDwLQLPMyCxmMnC9PKoJ208iXunNxcab/4/LfNku4wjtIt84UQVfq6VG94bwOeqId6qA/VOguPupzGHElQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(396003)(376002)(346002)(53546011)(38070700005)(6486002)(83380400001)(66946007)(186003)(64756008)(4326008)(66556008)(66446008)(41300700001)(76116006)(8676002)(91956017)(66476007)(478600001)(8936002)(2616005)(5660300002)(33656002)(86362001)(6506007)(38100700002)(54906003)(6916009)(71200400001)(6512007)(36756003)(122000001)(26005)(316002)(2906002)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FdBf4egL1FO3qyA0HvbJFsedN8aMiOB07afSZoWwNWsj4lzdWXGL5MvYyK1R?=
 =?us-ascii?Q?uo5Omy3/6ycJrjZCWshjDPgD9iUE8QTd1rgW1x4rzbcwWlhG1GwLoqdb10Ng?=
 =?us-ascii?Q?Yl5J0yxuU5ov2kqDZixXQIpR1Wl4Pg3IaeIF8RzgFdF6XlWGxGUl2QAOmR3B?=
 =?us-ascii?Q?3d7nx7cxZyw3CJasY4AqDQhM9ACCrJYmMmOg1zm6c5DpkoZGpTj+Bt5eOD3w?=
 =?us-ascii?Q?3lHISaEcszlPNflpFD8iD/msg3yWzdp8w6RZH0GMO3HdrhSRUPyuEHNb/eNy?=
 =?us-ascii?Q?pk00YHlt59BZLoKEz5mcpIYe01htXm+bsFf3iZm5mDuoTvQRxRPrY4rAEMqm?=
 =?us-ascii?Q?3dXt3G8cq9DrtfD81+Igp3l+bZfm5LLLHM7/thq5BqIPO3S2T9TkKHaaFcDv?=
 =?us-ascii?Q?XNEo3NMdpnCI9ciJUN/hNaxA+yNikRi5h4FSYJcoXPLJv0D+v7DKJmEZJ3Ce?=
 =?us-ascii?Q?nC9CqadHbVwqk/Y7LqgER5F7aOjWFHfZ39bfc3FGlPFaFHmXT0xiNpo0KsAo?=
 =?us-ascii?Q?SAZQ9gluegZ05izGvd2IWyeXndQrRVXtP+uzxQ1Q46umMvY82Q+D+GmnUH3A?=
 =?us-ascii?Q?3TYvy21sDeZyCm+D6CAB+L38RH57LCZVGsbDZvgBLX5W1i4vhUHfn5yYOKbz?=
 =?us-ascii?Q?PlX67igTdI3mDQhElaGnaICJVqLQz9KLqg2JjK9vRt4M8tSDkiJlKSGt8V68?=
 =?us-ascii?Q?gcmGbtBurc2QHTHQVdxuAFOs9ntkUMwD/qoQVGPoxnacVspPfOOW21pNoKm2?=
 =?us-ascii?Q?tjI+Hkv9FB58IGzoyy9a4fFb6C61DcpbiJLDc8FgLEkHuFmYv/1+a/vLbyNk?=
 =?us-ascii?Q?1UatHLQFF2AbW1V/vESyS8raRBJUSkgsxeDHXHS3OEeTlYAHTEeecOmFoZD0?=
 =?us-ascii?Q?NmcAs4h8Dl4RIdu+2ayytO6G5vd5TVaInpJX0ZdzTY6N/97RRyqAMtXfoDqM?=
 =?us-ascii?Q?8HEU3nrLr5YQ75uLy+9Dt7eXpE31Rqup7iMXxrFqbRh362eHQNJ7rOmUnjSV?=
 =?us-ascii?Q?x0MOFKontlfcQmnJDdGzTSlBJE3rzKm1boYOWBx17X5f6jJxbR1nq1PNFdMT?=
 =?us-ascii?Q?CJ/0SFkfNc9qB0fEeDCFV1Z059zVNU4gpJ/Ay4ozPinsLfxgbOgPdIGHxfI0?=
 =?us-ascii?Q?Cp0abpq1wQPcQ1ZQ8qFfUf/w+G6etPJGNxVOC1PRkMthnTfzjZJBbCucoYVZ?=
 =?us-ascii?Q?GpzpF+Kgm4gaRM4P+s6Gn44Yl1cttOqKfU7P1jw06y3/DeqFNM5QPeyEA/3F?=
 =?us-ascii?Q?Kt2kadHMzgj1WF6ioTHDVgSJdenXCJeBZ5CElYeak9y0gtlNgtODhn+3Umj8?=
 =?us-ascii?Q?ndYYN2WJHboHnsFZs0q096pRqA0emPl3HjvrjBh/eGlJGJpiurSO5KwxzdeK?=
 =?us-ascii?Q?SXET2LhFAGr/jrYBB5t6jcgpGijj+WQIXl5gaLQd3V3EJzfM2iu5Ucm4TKUJ?=
 =?us-ascii?Q?WaiNKTNecg5w4YK5Z4depFGPdxippVfIXrSOMIid84vq1XO15tvJ8qTAK0nc?=
 =?us-ascii?Q?iioHAjnJTVqkmASL7Ka5yyueyUwQM3dIy0axIfyETimCaOJ/85Tgaal+GSvW?=
 =?us-ascii?Q?LAWYF4ZEE3pnZ1slDENzGzmrC1V4QeJUDdOW/fGvqf/Za9H5wiUImmAgIhRT?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F66F475E2CE5C24A9C6A95D024C643DE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b10499-fcb2-4741-b708-08da901f90dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 15:50:47.4556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVQo6Cufd0nFYqV0iTMfK+MK63L4jpFGr5OBkc0AcF3rPg+35mo0gKCsNi1ctJr6JGBGR/hs0X3jcKRukzRA7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060075
X-Proofpoint-GUID: e7g4yzeIBJP3OXuQQELQCR3I1IjWFzVY
X-Proofpoint-ORIG-GUID: e7g4yzeIBJP3OXuQQELQCR3I1IjWFzVY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 4, 2022, at 12:02 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
> Hi-
>=20
>> On Sep 4, 2022, at 9:15 AM, Zorro Lang <zlang@redhat.com> wrote:
>>=20
>> On Sat, Sep 03, 2022 at 06:43:29PM +0000, Chuck Lever III wrote:
>>> While investigating some of the other issues that have been
>>> reported lately, I've found that my v6.0-rc3 NFS/TCP client
>>> goes off the rails often (but not always) during generic/650.
>>>=20
>>> This is the test that runs a workload while offlining and
>>> onlining CPUs. My test client has 12 physical cores.
>>>=20
>>> The test appears to start normally, but then after a bit
>>> the NFS server workload drops to zero and the NFS mount
>>> disappears. I can't run programs (sudo, for example) on
>>> the client. Can't log in, even on the console. The console
>>> has a constant stream of "can't rotate log: Input/Output
>>> error" type messages.
>>>=20
>>> I haven't looked further into this yet. Actually I'm not
>>> quite sure where to start looking.
>>>=20
>>> I recently switched this client from a local /home to an
>>> NFS-mounted one, and that's where the xfstests are built
>>> and run from, fwiw.
>>=20
>> If most of users complain generic/650, I'd like to exclude g/650 from th=
e
>> "auto" default run group. Any more points?
>=20
> Well generic/650 was passing for me before v6.0-rc, and IMO
> it is a tough but reasonable test, considering the ubiquitous
> use of workqueues and other scheduling primitives in our
> filesystems.
>=20
> So I think I caught a real bug, but I need a couple more days
> to work it out before deciding generic/650 is throwing false
> negatives and is thus not worth running in the "auto" group.

Following up. I can't reproduce it any more. I've heard more
than one report that this failure can happen on non-NFS
configurations. I'd therefore conclude that I haven't caught
a bug in something I'm actively testing.

Carry on!


> I can't really say whether Ted's failing tests are the
> result of an interaction with the GCE platform or the test
> itself. Ie, his patch might be the right approach -- exclude
> it based on the test platform.

--
Chuck Lever



