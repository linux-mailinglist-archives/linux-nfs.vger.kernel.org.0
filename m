Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199083E96D8
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 19:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhHKRbA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 13:31:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59316 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhHKRa7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Aug 2021 13:30:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BHRk1N013764;
        Wed, 11 Aug 2021 17:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OCTUNCPwqB4N7PDgna1vd9cgCHYGuHnpyrzf7Fmy91s=;
 b=e5qkz5b3ltRHhdRsS32GxGX9RLiypBBPmIXkUqbKKY+V3IrS8H98W/tPN8gv9rx6WYuq
 G9ccijfQO7o4Zpd3+fG+XuNUbE2VF7/oH1Dp+2IzwcEXG5Rh7RV+EoC8ef63b31pHIXY
 5jbI0AI4Jvwcpeq/sIHowKyil50tTdohOKBFkf4zf+uFccPhf9Jr+bAV7MYpxyFAzTyh
 T+C7XD2zBFYzFRiKDcxN2B5vfQX1rgQBpjgxg/RgTO6yqOsGha6RN9w+LcARZIMFRaDG
 VqBdIyNDrsoQmhW57wCFB06H2FgFVj5x7Uuup13hMJYF/cmMyM6qa+hP1eZ/r5qXH1AQ Gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OCTUNCPwqB4N7PDgna1vd9cgCHYGuHnpyrzf7Fmy91s=;
 b=Jm+LWLIK37MYWW0nukqtEu+z7UxXyygvCUlZYKJMnddUiNPPdKvzpTBgMsMF+N3i7s8n
 4tEGAVQEYqrVNVlh3W4F4gKtK6iNAoZj8Zxkzzi5LChRURiXKbiNM18e6k5ns/8UgDR1
 BOlVHhQj3BBaNTFw0dNVWTtWWxtriaTBCrFOtdseFqJ7UTbZzqt3NgoCPZ+ZxAWQxOru
 x0xyZktZMLFJ5oEhkw1siH+Td2AkQ3CmgEGoQVjxZ8MUnVID5xdxhT2AiWEVEkm4vgtO
 NvitudBST0lGParDHYDo9dHjvJof/AmFKxUQwNIDqnP89zsFcNMV+gssXr7MhWCLspzl DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aceudrrda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 17:30:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BHQJRe159695;
        Wed, 11 Aug 2021 17:30:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3020.oracle.com with ESMTP id 3aa3xvgshv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 17:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBlT5L496jVYS2oC32cKOfshh9nBIg1jUkn3ieileeTWcMNQ07Hmp/Ir8cM0AZLnutxxr/Ig+Dh7DK960kOnEDpuyJ3fD7Kt3coNDF46LrPH5yEjdSUfCGEnGFKJmTdaEsBxGEjSGlBrqDAi+7BGIsdQCCcqXEIIBiqADHZbOo1GBAASLKbTGqeEiMWCXEQyLwk9Hb8qGEAt0DfnQOixqouZs+Q6HTI1uVPpv8HoSAOqtlkao8s4TWWguXhloU5lAFvwfaKjER+iurT+xLBth4zaJKGlBgv7jeNhz6zaDNHxthgrj4ylWNUORGprclaIqJI64Q7XNdVuvRsGCI/dqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCTUNCPwqB4N7PDgna1vd9cgCHYGuHnpyrzf7Fmy91s=;
 b=hdcSsxJ7Jrtn2tvrynQtagNH3EskmlqvkdWsnj1hMnTg7eTaAmblC9JcP/l7+5nwZa83mNCvEypJQMIR4UOjEbsNhatpRMG94r38y8/j7m67WsYuKNdq4IGIfsghA3/eM7WU1Ml6XaDQyDEP23Lbnmiw+qRyx2X5gvm0MjjgVZOkn9pCP3i7AaYrliOVddZCdHkhAB/aoqmO9pm7ALn0bMTlEKK50SA7Sq18x5givzjC7D8/v9DJFK0PZXMLBxEc/9ZkoGjhQAhcGq6gR8Vj+3fhiE4fZ0lsID6tQoQl+O0QEoHg5RAkBXZGWLNPAquHl7KaRiaJwnGRatTXtF/jUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCTUNCPwqB4N7PDgna1vd9cgCHYGuHnpyrzf7Fmy91s=;
 b=wKC7CHxlgYzAQVgQCtiDeULQD7BdpUiSEvQ3SxYVlR1gUUW0Bs1Ip/xe2rPMPLw3K3MxAFKvxh+pPFQIpSyDnJDrYOolLixRkievcJXlec+EuADVcBq+z1xwrGOPdf4KnQIkQRkM3beNWH+g1CN3cy2U5tYm02RCdfWm5PEKqbs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3464.namprd10.prod.outlook.com (2603:10b6:a03:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 17:30:23 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 17:30:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgIAASYeAgAAo1oCAAAOTXYAA6JWAgAADg4CAAANlAIAAA4eAgAAZh4CAABNpAA==
Date:   Wed, 11 Aug 2021 17:30:23 +0000
Message-ID: <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com>
 <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
 <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org>
 <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com>
 <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org>
 <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
In-Reply-To: <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c32883ab-25b1-4b16-321b-08d95cedb316
x-ms-traffictypediagnostic: BYAPR10MB3464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB34644CEDE42FD23FEA38D4BF93F89@BYAPR10MB3464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J7d6vVHt+BmS63C8HKa7ID9CAq0z7gOm2HRm72InF7iqUAhW4GOsJbYjk5xRh4l9ULp+iOLCCpZ4ghDrD+JOoilRaGfLO03eWnBsrz0NMWnDP1EG9qZepTvm9sLkfmYn/x7jsKysMjijTJG9hhNHz+1nG0AiPyhNixbQU90/F+UdnsGPoBQ70Cv03H2FvKPEYavb4RE5o/NTs3nG8Dn2vp1/QvHejgyluYWMo9hbbSZZZ/O3BN9LG5vVfSXfL7ivDWIYJH6/ysts4Ta/Qb4EvJpFtO3JXqktMC0NkxmWGLfH2BWn0O/d1HZiVoa0e4JzgV9u3mGNcB0/VcsUIITjBYmMDtuu6HKpQ8Li5YfUnb44dgKjaeRuV5fyZjXH43cZILIui9IO99D/cRMQDJmpxUKRynzvwc9HM9uo+GnE0KXA7yJh92fyjp6LveEJ6euFUPy9qPWKqnVkhQyqyRDw+ouqSdASnVQBu9vH6oEbv5JCDjN69nCwmc15+cwdH92sHK+0hy9BpHdSCwcbbvyWHWepZPzOyEUgpicIbjnuzrStGdN4EjhbLFqZtUnHxUKwp4r49ZMTJ4TuRn2bi7puXM0wwqEj66sP/Dba869BjFIDcUOizjmVXZVyK+C45v8wd3VWMMg0aPiV6wUu0IQN1nFx8ZhALYwHMCakMMzQQiBkKA7KU6TIE1ewXopLm1XHVLm5x9hqnTbq+HT3/wmaJNVlv63rpunZw1Z735Xet9OWIVRRZLVkIKG++vQdvU0v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(39860400002)(376002)(366004)(38070700005)(6486002)(6506007)(53546011)(2906002)(54906003)(76116006)(36756003)(122000001)(66556008)(8936002)(64756008)(6512007)(66946007)(4326008)(66446008)(91956017)(316002)(38100700002)(66476007)(71200400001)(8676002)(86362001)(186003)(33656002)(6916009)(26005)(478600001)(107886003)(5660300002)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?olXO1RTt/aNuLIyatgm/SvzGjPe6kLpp2AWn33BvQ59QTIcqwkuo/iEefsq0?=
 =?us-ascii?Q?b0dIXfv3UTdn4tcRtrNAv+AoGxepZl462vLYGZcfr8b3tzBj+hDBrKALA60h?=
 =?us-ascii?Q?ujJk+vF6shHtLYCFeHJ37VQME0+pUmyFuoPiKyXkoLdGVqJTZyQrqx/lBSbF?=
 =?us-ascii?Q?QWDfpUxY5Nk7/+J5pvcmd9zz3FgSRSlmjns6wZXkTcrnkJVhq8h2DI3L8Arw?=
 =?us-ascii?Q?sRHbJqlWHgO9RZ47j7zkq9ocnJtwYOCGwfY6Q1FlXiCVix8DnZPzmqn/ZgKq?=
 =?us-ascii?Q?Gm/FJR6NNenoN4sl69wXucrF9LwoFzrJ5BWoloZFUJt7apza3BNtVpQWENsP?=
 =?us-ascii?Q?42+rcAUyVhn11/wux1KJRyexZHqzSSoD7e08FFHcJ4MweXYx1ZfwC2gRB3ov?=
 =?us-ascii?Q?bmmJnBKEc8cgnU14AYvxMbvGl5wKNt+IUBXZ1DJhbS3MRw8XW5s2dhQZ9IuU?=
 =?us-ascii?Q?tQwE/Xr++AYkK7T8yQHdkVfEv6V/H0uKcBhR4YRXZbJTt8OlP66/ATrg08p+?=
 =?us-ascii?Q?NqON6O4PgWY4Q/rcyTHgJrt8CMU5onoYiYsk3pvNuZIYeO8uxq1djm625r+7?=
 =?us-ascii?Q?2O549Q+NPKifVjpKRqt6ZQyiK3Nvu54ljl2ntvqSUnrrRhlsdzWRf3GlqrOk?=
 =?us-ascii?Q?/R2VfJAswRlbyMQyMwo5MLP8Nz0Ngr3fWHgRgQH2n/yvV1DWwl29Bs9RhC0s?=
 =?us-ascii?Q?2saAYazvGxmu7IrEYEt8KVIbHfz/3nRyPC8SP0/msUZR7mpvOwG2LpPZ40ir?=
 =?us-ascii?Q?Fmbit5uBiJxaZlCu0HbVms1mEiQJzisYoR5DdhZF0i4gba0/1w4A8rapSNDb?=
 =?us-ascii?Q?aMG6MboHGfREkZCVXAAv8+s8Sqpzu6qQ1Eva3dbLhcfjDTgokeBXTOMAfDM6?=
 =?us-ascii?Q?D9Tl86JhkJHir/bSzNFqzePvOT2KhmOvkRNZrUAME3VUMCnwjJgMH9ZaDBYO?=
 =?us-ascii?Q?XkcMAIh1I9csG0/M4eKfX6DCzZuNcySCe0py6Na+NKYgjs0xIH7ptd7+lumT?=
 =?us-ascii?Q?IvXCWSaIbqOEGe+19EH1B6whca8WpNOq8uDz6FtN97zR4sWf2f1fP0axOF5k?=
 =?us-ascii?Q?FT/qDKH5DPclIZmvLoQDXjo3Ts7YhylhqI4dDdRSXo9ZdRu1aes272w23OC3?=
 =?us-ascii?Q?fnBD39KKB36LkqCSf+qsTmVBEuStpzmXpYZ4S22WMPJDyeohXI+OgwKs2f7I?=
 =?us-ascii?Q?8YrFu5ZkSszd/DkUDLbeXVMIITPc0mnSweODp2fFBn3dFuatJSNdTNiPR8Wp?=
 =?us-ascii?Q?3ZUyb0QRzRva7TOKcRrJjo2z4wO4v1Nxf2v63lN7LDzRbGEj9VP57WsUP42X?=
 =?us-ascii?Q?2zJPpvn8jhBJiTZHKiz0x8zmW8Cim3fWsjXw7cMccDw4BA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C65B302A66C3A498D6078ED106573CA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32883ab-25b1-4b16-321b-08d95cedb316
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 17:30:23.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3ODZqDX2BC5vpUsi6i09ggZCdpzGPTPTbFHMpItFshcZ/tK6l5jrlErjfD1Fj2fWYV8dF8i1rSZK8sxi7eXjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3464
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110119
X-Proofpoint-ORIG-GUID: n0Hltwoc6vInOpCzVoaUen9mtguFU0gJ
X-Proofpoint-GUID: n0Hltwoc6vInOpCzVoaUen9mtguFU0gJ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 11, 2021, at 12:20 PM, Timo Rothenpieler <timo@rothenpieler.org> w=
rote:
>=20
> resulting dmesg and trace logs of both client and server are attached.
>=20
> Test procedure:
>=20
> - start tracing on client and server
> - mount NFS on client
> - immediately run 'xfs_io -fc "copy_range testfile" testfile.copy' (which=
 succeeds)
> - wait 10~15 minutes for the backchannel to time out (still running 5.12.=
19 with the fix for that reverted)
> - run xfs_io command again, getting stuck now
> - let it sit there stuck for a minute, then cancel it
> - run the command again
> - while it's still stuck, finished recording the logs and traces

The server tries to send CB_OFFLOAD when the offloaded copy
completes, but finds the backchannel transport is not connected.

The server can't report the problem until the client sends a
SEQUENCE operation, but there's really no other traffic going
on, so it just waits.

The client eventually sends a singleton SEQUENCE to renew its
lease. The server replies with the SEQ4_STATUS_BACKCHANNEL_FAULT
flag set at that point. Client's recovery is to destroy that
session and create a new one. That appears to be successful.

But the server doesn't send another CB_OFFLOAD to let the client
know the copy is complete, so the client hangs.

This seems to be peculiar to COPY_OFFLOAD, but I wonder if the
other CB operations suffer from the same "failed to retransmit
after the CB path is restored" issue. It might not matter for
some of them, but for others like CB_RECALL, that could be
important.


--
Chuck Lever



