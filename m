Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB2B669B11
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 15:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjAMO4W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 09:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjAMOzv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 09:55:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2802DBD
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 06:41:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DEVp31020326;
        Fri, 13 Jan 2023 14:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5mZzUXpidlWeVBsHaQq6aTe6hZsarxAqUd7mCkVFTiM=;
 b=OKGwp5muQ9O43FWgLQsMhrzyrOqVP1AfLSH0Mu3KqJUgPrZX1IQLa/1viENW//hDSSeL
 e4VaK7A27y/NHPjFbKoGrETYYHNhgsFRUpEJu11xKpZz61epzsXg6N4DUDvmFGEdHJMU
 uKHLOOo5heHMkkTWIVpFT7bUCAmPvnLr6K2i+FsXzu9AYVuFn6l74IszOTS2xkjANSat
 7jaAdwPucLsMoEYisBg4p6BrXBmiLqgQG4z5kN+ngo6vLTTKT6gusSBUFpjW3pO/KfW/
 YbiPoX9ZffiRTZKKHBj1TqcVej/fVxXk6245T24sP7pf2odt+Z+z5gILxKmCj4sBl3ZS 7Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n395280rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 14:41:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DDpftj011596;
        Fri, 13 Jan 2023 14:41:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4grhj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 14:41:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mshkentII9yukfNavZFUIKSUA19hcUcFV4rdnzWmNDATr4lpbxKoOMl2e+lMnA+7soHEj4ord3ykKEHBITnJ6GuZZruRGgLgxCgFQxwzrr97OzQpfx9E0WPZoD2zAUYyx5/CfBOUkIQcKEE2vEguoBZhELzJcK+unY/21L4gADJT+IcGiIbSypRgMODLX0H0sw8ic4apRH6t0eNKDX8DYUFtLmfUBjMwaiO9wMhVF66R4era7tu6P4qsoOIWfAVyEwZc+34Q4kLy25gJA76OXTrSVOkfnqJ5njEBGKhxfjBM15xGrnooULX3+d0lIIqeH6UVJrYUXeJUkyddJt/s1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mZzUXpidlWeVBsHaQq6aTe6hZsarxAqUd7mCkVFTiM=;
 b=mEfVFZ0hms5Q1jfbkLXbWc0xLEpv0qltnWqq0Hbty0PO8vXje/0CN+BJhVVpCEHzOJBfpW22UE99oqtXv1V5BQE99sh3eee5uIYSd/xaem5mYxPBQQwiFOFHe9M8I7vMSeF+qd86PQT1stgbc9407ycqYQNPWiIo0KJAAt2wzPa0kgH2lsLphWKcZEmyJXCEgbkj7UkAre8Ecz+85e3G4fGihPvjXa43ilHPmdl02I8xGTOfrPgEkwTRXBmjmcq3evEPE745hP+vKWJEilBYEG5zxkp144oPr2Me0ttHTyf5ScLUMmRqzXXQAjuwWHtrsvAYylbZmR9sh0vYDZnayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mZzUXpidlWeVBsHaQq6aTe6hZsarxAqUd7mCkVFTiM=;
 b=zA9WpfL5s0xkXDKg1mlCgMORTQXe+oWCDDW6Y0RBtZDR+rA/LpVOiHbg8aCCX0wPzg1T1rcgWDOWm5V9w9/vzRl6aSL3lnCiJ3BpjAu69+mAn337cdZ/Vd4+/Eg0ip2su5hzerJH7ER/cMMcySpZ0OWSHgSfqqaLwNL4QrzTOIQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7273.namprd10.prod.outlook.com (2603:10b6:208:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 14:41:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 14:41:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: a dead lock of 'umount.nfs4 /nfs/scratch -l'
Thread-Topic: a dead lock of 'umount.nfs4 /nfs/scratch -l'
Thread-Index: AQHZJZtceQwIxRwSHkuVtnXVMyL6FK6Y9OQAgAGQ/4CAAekjAA==
Date:   Fri, 13 Jan 2023 14:41:28 +0000
Message-ID: <5B9215E4-99FF-4C52-901F-8D909DD165BD@oracle.com>
References: <20230111165945.7605.409509F4@e16-tech.com>
 <20230111173534.82A7.409509F4@e16-tech.com>
 <20230112173046.82E4.409509F4@e16-tech.com>
In-Reply-To: <20230112173046.82E4.409509F4@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7273:EE_
x-ms-office365-filtering-correlation-id: c6f3b76f-0846-4915-0cde-08daf5744171
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OD2ABKvtHdvRSjcxdC2vidJ/uJE3rxZoDoAH83JZKXJHRzzXjYJq93qNlBTTvQQQ75qXuMJ3Ddc8Md7XPlZM1ZcTQL64itOqF8RjbKSjvjO9lA71MNTkJW+2Nd13NPFeAHhpB0AoBqVeZXB2yVnXDYnTkSLn5M94V3ar5Ig4GhqcFHZvfbu0NbCCrQp+6gpbDb3SaV1T1iFlVZK6i98rNOXdyZ8EU7FHASEaB4N8P1IwYMy00/Y0goMO9gKmlmUtJBj1UGw6ILO5X2LOfd3hcKyIp2pu3Twxn6d7K9Mpy8S380g09Fx1OJpntsMa4AAaHQJxOwTrJ533dI6jc2F+wkQyjjo9nmaKTW6PWE7un7zqMGpK+tMrBrJlGZmZEhpbYVkKN0NaOV+rudcwO5kxd7xnm2u86sFLH9+c4skeiL991qxXedMvyEJUiLQlreruoattB1KHfkVpeW+JhKpS5N8wxmZ52De01ucB/zgVTB0oN3FMEjNDxSN/jhCGJcrdgxEsBBlebM+WVR5SG5xXOuI+vgWO/3Qk3RpNvDobDt876sbrl7D9HxOZwqnqZXLFDZoWjH5gyjXLRhUhgKA1oGyC3Sg/KPn7BR5c9R/29pgnRPsfgwUHxDqZ1QFQbI+Ba1vaJmkbKzlS9yvlkDPnRhMsTcR2EfSS4VinUf7wu0GWwFvfivIHkvviaUyTVaA2BvyjZES7L+aiD1H7bNXTnAJl1oh1GRoYzjG3NcnCrw0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(2906002)(38100700002)(122000001)(5660300002)(33656002)(41300700001)(66556008)(4326008)(6916009)(76116006)(66476007)(66446008)(64756008)(66946007)(8676002)(36756003)(8936002)(91956017)(86362001)(71200400001)(186003)(83380400001)(38070700005)(6486002)(2616005)(478600001)(53546011)(316002)(6512007)(26005)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qbxj23ShH7vk3o49Nnp+n6T3yx8zOgPd2dVv0CYE4Kf7fRvDHnzpiHSlAOmf?=
 =?us-ascii?Q?vDy0Mn+M+WmExNmarYICCJZRLIDmFr0LcVAl4GzEf1blZ0ibizLJHveUOA0V?=
 =?us-ascii?Q?z3ewDw+RIKtl+eYrczmTHY6DFy1UH3DtB6cWStrYcisH2GXS/TdRvBOOMtfJ?=
 =?us-ascii?Q?YA/OMLRuXjf4CZuqS5GeDAnPJ5SKLxxjqKxZEhnelOZkYjoTe/Q2t2u0OU3Z?=
 =?us-ascii?Q?/J46UEBbFWzwWxveJFu0tKRwfIxbhwmwZ9vnFttiUgWtT+rLAySnRrk6g87K?=
 =?us-ascii?Q?HofzPNxUCbSNaCv7FjAiw5dfC+NexgyVTvxO+uRfbmZmeE+4yT/AH0OmpA7R?=
 =?us-ascii?Q?b+hw7z1sM+MrDvF1hJ8WBWDF+L5umGHK50bAjmeAAJSxSihzDfaUAAzJRDwE?=
 =?us-ascii?Q?9oIhqR2g1IcGOjKWFPJY4wTVfFC6SluqYooeS6dBs6vxh99aJBd7tTwYK0Vd?=
 =?us-ascii?Q?9bDy5TyyQFliIkIQgHUDL8cHdV5OCK/IL3Q6xcutqRtQ5NfLjoHwmS68xdH3?=
 =?us-ascii?Q?SYBPMeQLRaWicR45CpkSaYSERenAKF8lyHNj7RJdcTd07S9bNItHLOiEaRjZ?=
 =?us-ascii?Q?yGgSRx++XN2xOMtuiZb1lZmvGyE2UMlaUF+ynyDdSM6dyWHfJTa+qEINEy7e?=
 =?us-ascii?Q?52y1GELeaPxqDotigfXQxZkvM2QoJ+qf7OCaNonrpdk/whwRS0UXvywy2qtu?=
 =?us-ascii?Q?aFh0851n+kh4rZDb/WPXrZlgJ7665Y4XgBu+r8Jraz+Qof8bwWwKAKU8edY9?=
 =?us-ascii?Q?5GYm3/zxCasW4cI4W443zUy5yzXp7HbYaNZdZG9b7ycjRhrBXmA67EYgRSpb?=
 =?us-ascii?Q?EGKA51559NfvpyH0DqO26RP6Ua1FvDNTvM6ir+RgHMkOAOCqBAdBcixNR4I8?=
 =?us-ascii?Q?k3D9cethdTvP/HyU/GilPEmVA/ARWgJeuJW1Y8E/70eYE6r1tT+UXE04j3Wh?=
 =?us-ascii?Q?q9RhmRtB/JnUHK23sN3H0aY0Q51QdYLGIRqfMQACUhut7YdHjDn7/KNtgfZa?=
 =?us-ascii?Q?xuWy+sLaUmrdDA3zHKYRFRAFqazx8MsqiwD68/3rXujoCEZfSEKepGA9mnD5?=
 =?us-ascii?Q?vOi/klRz5kkbZD7rEvk2zgvDiphsLESLDcRiy8i2PJvW83uYFnzIUfdnGnsA?=
 =?us-ascii?Q?02nZQQ8D9B5Bqo+DhWFRbI61Did9d1lLKZzfh70cR0l2e5Wl2aUvK0TYURq0?=
 =?us-ascii?Q?7/LcitQkje3NYYZp6Zwc7fdq3z2NR7brtPVdc35JZUe6OmX+LmOWVin3NfMm?=
 =?us-ascii?Q?Av9h1yPzgaBIx352ImAaO3Dsu5hyPT5Ti14d9g2nIU4J2QrQDx14wkfTEULc?=
 =?us-ascii?Q?LZmZZwm7mvGgYa1naG8Z9S2qXm/lHRkNTc+WAX5EckwDGnp5/w/IT/TXEDZu?=
 =?us-ascii?Q?ans35UXSquQenTPqdKckXfrZe/y3JhIRty7FeqVHxwRTKn0nIqj5Rsi5J2FT?=
 =?us-ascii?Q?Lspd8CGRLy86I54AfyAI6Wy9s3mxo89nrAbxksb9+0bXBXO2z5IPnE2YLkBT?=
 =?us-ascii?Q?h/C7K0QP+BXVz33AsqNaPvUzwXMRPm7rQ6OPxheuMOMPp7MPLk123/xsBlj+?=
 =?us-ascii?Q?Do3JRu2v11+7izeCEEtfgQK5q0s2AARfPjSJ+tNNazl+3aoB6JlJJPgjNlZY?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2CF60F3AF0879D4DADDEED32E466EEBA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wzh8FHJoLpdokNspfKmnTShmKpYVVgActyVXKXqJWnlaxRdxFHgEE0qwMy0jtdZH2wkoFLBa0BduGURy8tltLEh2K+qUj4N/UfMj7n9bxgxD8raJK3cR0vXMPYAimK4Cpp7UiV+eiGxs4T7l/ismKneMXRd98O71ZmSwYq/MlUo9PaXobrWos/Skb//PMdMqL4hW5fL3sa/pTbfr5Q22cRH4rQZTou8tu+++6l5ZTe0c0DO8JifjnRqP0I+gp8OcwQu3lxoHyDPGiFoWCPDvV3l659Lmy3Qjt+WAUDiNsqB1GsHWGfVc7v37GVrmrlXjzAJNroSSBBr3wljVaG1/Qf9dKD6ORMmJXjid/f+QLNaPmsAaM0MR21XHOcgtOgpDQSIqt66GppUAjOExVmTGXA58o1BwVaAQ+9jf45QqzwVynlpfWxA0/nR6RrSxyOwcOadKhlDjPHBSt+4wOMWP8vlVZJFbJSdyjva0btRds01FmBUJXfARm/gz7MZNWhINjA4T+Vf/T/PlNrBop9Z0s3OlQI5xKBgFv2LDPOiBcGGVZ96keGuvHfQ5B/FujCHwcZ4k80U7fX95JQd3HNhnC+6PB/pAhfn+juuZ+1LedoMctYR91Lxu3wagsjYZINJMfBATxtzJfL3twvOhR4q9dG1q6BMJnAAEjFodOLgdD0nPLEc0f6bDo7IQYrb4q3viXF5WN1HO4LQzo2PeQGWEG7L/TP40MrlKLAYM5owI3SXVo541TZ9ggaLwd8NHUk6CI1hbV9effL9dMZbKmzQiGCVbppvDYa3whEaU8zz4tWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f3b76f-0846-4915-0cde-08daf5744171
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 14:41:28.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QS1TbzV0T6HIZMpvTg2jCOeLIj37FzAh59ZkqwURwasHH7jjeXY0uMx022xzNyxrL3vhq/ltVAlwpJVOmzQH+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130096
X-Proofpoint-GUID: ULGhnzGlKJLxLsCiHwydtq0EbBw4n2Uv
X-Proofpoint-ORIG-GUID: ULGhnzGlKJLxLsCiHwydtq0EbBw4n2Uv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 12, 2023, at 4:30 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>=20
> Hi,
>=20
>> Hi,
>>=20
>>> Hi,
>>>=20
>>> We noticed a dead lock of 'umount.nfs4 /nfs/scratch -l'
>>=20
>> reproducer:
>>=20
>> mount /dev/sda1 /mnt/test/
>> mount /dev/sda2 /mnt/scratch/
>> systemctl restart nfs-server.service
>> mount.nfs4 127.0.0.1:/mnt/test/ /nfs/test/
>> mount.nfs4 127.0.0.1:/mnt/scratch/ /nfs/scratch/
>> systemctl stop nfs-server.service
>> umount -l /nfs/scratch #OK
>> umount -l /nfs/test #dead lock
>>=20
>> Best Regards
>> Wang Yugui (wangyugui@e16-tech.com)
>> 2023/01/11
>>=20
>>> kernel: 6.1.5-rc1
>=20
> This problem happen on kernel 6.2.0-rc3+(upstream) too.

Can you clarify:

- By "deadlock" do you mean the system becomes unresponsive, or that
  just the mount is stuck?

- Can you reproduce in a non-loopback scenario: a separate client and
  server?


> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/01/12
>=20
>>>=20
>>> The dmesg output of 'sysrq w'
>>>=20
>>> [13493.955032] sysrq: Show Blocked State
>>> [13493.959997] task:umount.nfs4     state:D stack:0     pid:3542745 ppi=
d:3542744 flags:0x00004000
>>> [13493.969628] Call Trace:
>>> [13493.973003]  <TASK>
>>> [13493.976018]  __schedule+0x2cb/0x880
>>> [13493.980426]  ? __bpf_trace_svc_stats_latency+0x10/0x10 [sunrpc]
>>> [13493.987342]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>> [13493.993637]  schedule+0x50/0xc0
>>> [13493.997697]  rpc_wait_bit_killable+0xd/0x60 [sunrpc]
>>> [13494.003671]  __wait_on_bit+0x75/0x90
>>> [13494.008168]  out_of_line_wait_on_bit+0x91/0xb0
>>> [13494.013547]  ? sched_core_clone_cookie+0x90/0x90
>>> [13494.019101]  __rpc_execute+0x14b/0x490 [sunrpc]
>>> [13494.024603]  ? kmem_cache_alloc+0x41/0x530
>>> [13494.029610]  rpc_execute+0xc5/0x100 [sunrpc]
>>> [13494.034835]  rpc_run_task+0x14b/0x1b0 [sunrpc]
>>> [13494.040252]  rpc_call_sync+0x50/0xa0 [sunrpc]
>>> [13494.045566]  nfs4_proc_destroy_session+0x80/0x100 [nfsv4]
>>> [13494.051926]  nfs4_destroy_session+0x24/0x90 [nfsv4]
>>> [13494.057767]  nfs41_shutdown_client+0xfd/0x120 [nfsv4]
>>> [13494.063774]  nfs4_free_client+0x21/0xb0 [nfsv4]
>>> [13494.069240]  nfs_free_server+0x44/0xb0 [nfs]
>>> [13494.074418]  nfs_kill_super+0x2b/0x40 [nfs]
>>> [13494.079490]  deactivate_locked_super+0x2c/0x70
>>> [13494.084811]  cleanup_mnt+0xb8/0x140
>>> [13494.089147]  task_work_run+0x6a/0xb0
>>> [13494.093587]  exit_to_user_mode_prepare+0x1b9/0x1c0
>>> [13494.099232]  syscall_exit_to_user_mode+0x12/0x30
>>> [13494.104717]  do_syscall_64+0x67/0x80
>>> [13494.109125]  ? syscall_exit_to_user_mode+0x12/0x30
>>> [13494.114799]  ? do_syscall_64+0x67/0x80
>>> [13494.119426]  ? do_syscall_64+0x67/0x80
>>> [13494.124042]  ? do_syscall_64+0x67/0x80
>>> [13494.128649]  ? exc_page_fault+0x64/0x140
>>> [13494.133400]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> [13494.139306] RIP: 0033:0x7fc32f839e9b
>>> [13494.143726] RSP: 002b:00007ffe670f6018 EFLAGS: 00000202 ORIG_RAX: 00=
000000000000a6
>>> [13494.152183] RAX: 0000000000000000 RBX: 000055f4aad71920 RCX: 00007fc=
32f839e9b
>>> [13494.160218] RDX: 0000000000000003 RSI: 0000000000000002 RDI: 000055f=
4aad72600
>>> [13494.168237] RBP: 0000000000000002 R08: 0000000000000007 R09: 000055f=
4aad71010
>>> [13494.176277] R10: 00007fc32fbc0bc0 R11: 0000000000000202 R12: 000055f=
4aad72600
>>> [13494.184313] R13: 00007fc33025f244 R14: 000055f4aad71a30 R15: 000055f=
4aad71b50
>>> [13494.192334]  </TASK>
>>>=20
>>> Best Regards
>>> Wang Yugui (wangyugui@e16-tech.com)
>>> 2023/01/11

--
Chuck Lever



