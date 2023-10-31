Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8267DD0B0
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 16:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345045AbjJaPjq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345023AbjJaPjp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 11:39:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D6DC1
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 08:39:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VCnfNL032663;
        Tue, 31 Oct 2023 15:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JgLjQlLJf+52eyGrAffDc1wtTkCsDsfjuGEtnliLJIY=;
 b=q5Sva0XzIMj1PslAwkZMVDi+xU48BpyL/KR098/gyzLH+mLwm/Wbtb0Xvhf0ZfYdmTk+
 MTovmOs93ZtF2hNuz7ZQM5P9cfBCZ/xPESx4GM5EHucMN7y6rXHag4oGq1kxGVIqUB9H
 e3RiJFmcCJ6yFZFIdbBS8HgIYTOaACtN0NPzFNckOZs6/q3q//gGXHXqSX8ZUWKfZ09l
 uxUMosaaUK+f0OWQDO5ANYiK8yPJUfoXaoI9OgO1Tz058Tr7F1qFNPT0Hq5syzw1Tkq4
 H2Bkm8eIp1sRvrNmFHWruru3vnWbyhx4j6ve1jl4Q0Ryu6ifuxtOlsTyH8MZ31rcXO/x +Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqdwgg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 15:39:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39VESBW7020109;
        Tue, 31 Oct 2023 15:39:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrc37k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 15:39:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFi+MxtBLCycNyyrVqOHzOdEmZQyWpMg0fj+L6Bcc0yQUKq5TiGgJ+sOUuWqFlwBch1wDR1+zlZLWbWs9VBRW2xrzuqksisoGYeLUa1th9u22u/8PUpMbWSe/RAn1/3rXiF7G5U+Jj31VpqT1laCfxKJGD5L8pB9jGDKxyE0t+nieF+PSrVHywGsaCgaUNf5IPKjQC76ObxtVhu2SiD74p5piPQpMmuezVAtx0S9tj8HLitkdHZNhv3kN8iXEx+kfIDkkUMJfI/taN/kUog6t9bIqtH/sZ1g3HCfBJ9Wih2/O1SyVO6l+xMRE9L4R+JeKSnpPYb7wyP5JCX87hBtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgLjQlLJf+52eyGrAffDc1wtTkCsDsfjuGEtnliLJIY=;
 b=dxaXkPICGL8qbsT1Fo51MF6w0Yp4G0tjDMtsm23zkN5NgrFlgJVjmX+Iizp+A64wTkqrKqIyvzlOIiS3q2IIA7+pTMtSELI//eQjbuTQ1XBGyZukvIOF9UyfJauPY5glpU2GcQLSd+7q13YCNHwTo7qj4w6l/Zs2zs6fxbw2G6AuahFy55cvaz5jz3PIwyeH3bqRXfzX/sOhtuOPWSeHFngprNbGbhZs52eeEHSKOKVP//FLn65nSLwkv4GZemCxvjLTuZb4hqHwWrbfwjAWXpsBpr5O+tO4nmpKKKvRI29Hm6dGn5f3i56OneDLtkFAonoV4FA0qQ29D/MTcldstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgLjQlLJf+52eyGrAffDc1wtTkCsDsfjuGEtnliLJIY=;
 b=Hgj6cUAKKjgzdTqNg6v9KtDo1P329VrtCDF4AKbWv9r4ILo9ijoVJKR6YYUtJknOivH0WdR9sqJumr3St79zuiakh3r7w2QRAy93W9LbAyPutJlCNh4cNarMrFs2qsnc5pVHxpz1enEy5QeJrW8nVVERpTrCP6CbBB9FSfDLYUs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4537.namprd10.prod.outlook.com (2603:10b6:806:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 15:39:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 15:39:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/5] sunrpc: not refcounting svc_serv
Thread-Topic: [PATCH 0/5] sunrpc: not refcounting svc_serv
Thread-Index: AQHaCs5Bx30Sst3AQkeWzWCFyIpqgLBkCzaA
Date:   Tue, 31 Oct 2023 15:39:29 +0000
Message-ID: <9BA28F70-A3FC-4EC4-A638-A27C1867F221@oracle.com>
References: <20231030011247.9794-1-neilb@suse.de>
In-Reply-To: <20231030011247.9794-1-neilb@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4537:EE_
x-ms-office365-filtering-correlation-id: 6c32688d-d384-4fdc-f036-08dbda279272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYCU6e9/lpETyf44/lb90bHwwgX8P8mBECO+rEb+vNNkUBegFledWPoj3uYy3h9eaJz4c3DY8puMKeRRZzbyAxrBVFy0lpKrsgEXAi75f79MrwX2lOBM7dGeY7KwDCHTgqFxSCvn7UtRU/AAe4Wh3KmmdZ/NxzYjOLih776+hO0yGPl3nB1UJuZPORjagWjYB36KM3lbkObHv8yubS4ScbK3i9HyZlJgBZS9Km8HH9kXoEh2IjqQ/tzptP2X85FgUhbsY4k9oF51VN/8CmYw0S4iondyf7YEzZcZrrtBnQpIj9GJ0CHUUs/EeJcoTbQpK3YBHd3i9F6iBZgkLZETn+noPStVNLNHaM9S0T+AMX+wHhpVeUGkXYfKwh2eEdNUCMrgvKA349ocCsxRags8Vrxvmu7Yf5Ai1/vyLFoJK3bGooxxnBNS6WOZLlFYmQU2WIFsZJxhWPb+viWV5fY9b+pZWGB8tQkCedrxfTDTgGE2Kv3YxWJQ+zHptfDkgroeNcB0gVnx1J1lEjXMdPWCFMb5vtIlJceVo/yFc/49+AN5L2cSdqyFRP8rqap1HXg+KWxLmS1ObViJcoHLZcn8ow7p01MnUfSK2qkLCJpJjCJNFucazvdOWmpHRwhtnSFusCz5uCp5e2KQpb95fSZ6ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(38070700009)(6512007)(26005)(38100700002)(33656002)(86362001)(36756003)(122000001)(6486002)(83380400001)(8936002)(6506007)(53546011)(478600001)(71200400001)(8676002)(64756008)(66446008)(66476007)(2616005)(6916009)(316002)(4326008)(54906003)(5660300002)(41300700001)(66556008)(91956017)(76116006)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lQvKBKQTsfq/L3Q2HNzzRqx9ns2VIUj7Y2VgJNLDBAEYuJLNEtlC4uKudJO7?=
 =?us-ascii?Q?ID6RIMlgLKnKXaGtMSxzFn9gNNnqVjRWDtt4k9DBANU8sbc2Mq+ACj2515My?=
 =?us-ascii?Q?l5HYOMxHgGL4M4cQHk/KaQ7uT/KOalebmTSMJQVEj31LDhzvv17NfdEB1uVw?=
 =?us-ascii?Q?NytM6BpxZSVJiI58QW4M8bNVR0cGLbIingnPBsQoLTSI3UMhIwwQpYk1HWDP?=
 =?us-ascii?Q?TudzS+hwl4s34Lqv81lLkboN65E1zIgOTmQIOr2vHpfxcT6mppQeVegYV4dp?=
 =?us-ascii?Q?tYzrb/jKUaoBB5mbioZlhbh4lopn5dXJhbL1X4sgPX8jsZ20FTThYGDIYgME?=
 =?us-ascii?Q?sSJINrixCY1QZaxdEasUnwCSl2h0EQG/1GBruaX8ZyRzX7ZGb5wapbMXX1Bt?=
 =?us-ascii?Q?+idyhivckJZEhdylE2HZAooFGt8LaNlALROZlsxmCPibYBIJuYYypZSEDBYN?=
 =?us-ascii?Q?DyOko01lv3nqSYNddODFyUttvb3pDyDz/scV7Qrq5wCS9crkPIV9/E82luCC?=
 =?us-ascii?Q?PX+aT+z9b8IqCHcvv9QHCAA2ynXxskhPeuocjJyrCUwaOmTHnYbb7thSRHNc?=
 =?us-ascii?Q?dzX3q6KNjev17aYani3yxtLNnxKLREbB+jbwHsgb95L7bS2xN1BWj5kvckCa?=
 =?us-ascii?Q?3ynltDOek3D1wTKgNEDIJhmXlVfSq0sew4hgD/kg6k9GxoBKH11sIoBh1DIi?=
 =?us-ascii?Q?lvNgPi4Jnwn+UjIdZgQkCc/iv8JmJbW18PNsogqP4ywVX8BpaQb4aCDmMZC0?=
 =?us-ascii?Q?+qwXXSMwBLoPU08l10M2INi0R80eDlVXm9L8BQMXqpI3j4E9R6d1rU2ThgEO?=
 =?us-ascii?Q?12NRg66ESXf9KCdMFXk2zcxVehssMClifGx/KQ+5znlvqhHluP3cNJSIeKP0?=
 =?us-ascii?Q?XQo7LV8zB9GCThrfFnqro6JENcEt3rsdg3jpEu7mj5dP6S6DPnp/QGoR95Bw?=
 =?us-ascii?Q?BTCPLnQ1nvNvgeCULttcaHYOd7uA50PxDpIITVykznGrYUi2uW5OoBdEa150?=
 =?us-ascii?Q?oCwu9ume4+PTqpWSZCnkLCtNLUk/EekX4y2eoBpCn2o639cT/41p003tUcVo?=
 =?us-ascii?Q?Y1qrf/qIH+Xb0RErDjWVe5hLRNL+OFFcmeh9PVC5SpUqz0cDqZmtDjInXYNj?=
 =?us-ascii?Q?mlofkpkBm12w1yQfjx5J4oGzyus1QFcxRJIhqkWwhzcOGZzlGJRCasJhruwA?=
 =?us-ascii?Q?aiGHEnpHgtdwytXJKLoTTeQKWIWQmkKzEiWXcucGMHWx17DFsPsWc22MVMBd?=
 =?us-ascii?Q?ShOf9yZoET54Wj219HP0NrLb2caxuHoPXz5nYqpA5MJyWQr9NlVCOaB+uQgL?=
 =?us-ascii?Q?O8m3hh9qOl3MomhyYq1EjDzFeGRb1DNGx7cFFIBZHlcIatgmzH4zRENLpX9u?=
 =?us-ascii?Q?81h2/AsQLAWcoMR1O0rNpXJN4K/aDgjuNrTvzKvRe+23wsRSm9d2Xs/z1f4o?=
 =?us-ascii?Q?A1s4/W4vwdc+EbnxO0Fxzx9GspABTXsc1RrsJPRKBaADFORXQzpZ6I0OhSSk?=
 =?us-ascii?Q?FruSSHjyl/1CRm5ULeI/yy/fHgvMZVoDsoLv8UgsUOOrQP418F3ang5sB3A9?=
 =?us-ascii?Q?zKlOjqLc0rwWbHPbizEKjmnJ1p9m3VvuTMd8oOd6XoVmkQTfXZIgaGpCFahs?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A290DC4E2D6E7439E4C62F32172F645@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y9Sr7nbJTTL6w59DXPVlbzDGHgaBGb48rXQje+S6SKWl2dG+X1bbcrMbCsAlenqt60PAiKlSUtggZL9FUMNxHsKQdJxnxCakPL75/5zwZo/Pajt6JUNZEMipvF1WE8iihnQWwimcse9Z1HvHvXHyVGBC5jGeR6CRugk2JvD37DO8HBPqbRM4zf6WedFl0CsnlSUV2fZCvLG7ktsPBd4TfVRptYHwzQHJn2b5fN8mwDWgP2t2yBlsYtP5vYRM+stpkGwRITYL27vH2UUi65kSOcCq0C6+v4nNzURPoU0LRWkwdJ2V2lIiRhzi9Vl4ZP2n1sKNh5uIHURysjchUksyd6pki07jpigMSX28Qzbs/IDV5ERda8yGsenOxdtRUrnSkuxyhTiFc9p3NEpH9YQC1B5QmzQIWhJ7nJ0uxKRf+/cNUFH77Rn9Cqo+FmCjD2X7gViZ7SaaT3031N6DAtcMZuQR0EXleQ5rpEtnHp/DvGL0pXGyundDLW3h5HV+I1PS4oJ33K9eESQ1xP5Fst+pAw8iIUsncxvVccKpNKvUS5gTPfRoKQ1stkHLVXkvqv0B/huigCAtMCAjPtt1qw5YfUzUIPDNTUaEabvlLPulBuuOupXf/bw8gk9Shy9v6Oo5n0V6+0E2Eoty9HLAo56jdLRKEvkUX5VmUPLWbGBpYHZqmfHJF9yl3gUuLVyTuFNcUKxohfDcW4oMa8YcL4TiM3swCK+3AVK5WKYJS+sghqrr2TNuQOaJ45wR+iMTtrexX2leve/yhYt+3BVx6XA40HM6K1Z2cI/21uqs/1mMJqs6goICh4tOE2HuU+uhuAFEx321miM7F+8e8OsHEW9zUzU83CKbcRAlKvwzwtFpFEhDrvYGqN11lwGsu04lC6fu
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c32688d-d384-4fdc-f036-08dbda279272
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 15:39:29.7481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmvjFtuKZX857bTdWH7eHAGWZMSpa2NP1Mo6HTnQ0p1sTmuhZRMFjlhXkIhvh27v3oNcbFKE49s+I/GUZXG9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_02,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=676 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310310124
X-Proofpoint-ORIG-GUID: HQOXnYH120ClYAHqtUnSlP2J0RLEjZHG
X-Proofpoint-GUID: HQOXnYH120ClYAHqtUnSlP2J0RLEjZHG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 29, 2023, at 6:08 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> This patch set continues earlier work of improving how threads and
> services are managed.  Specifically it drop the refcount.
>=20
> The refcount is always changed under the mutex, and almost always is
> exactly equal to the number of threads.  Those few cases where it is
> more than the number of threads can usefully be handled other ways as
> see in the patches.
>=20
> The first patches fixes a potential use-after-free when adding a socket
> fails.  This might be the UAF that Jeff mentioned recently.
>=20
> The second patch which removes the use of a refcount in pool_stats
> handling is more complex than I would have liked, but I think it is
> worth if for the result seen in 4/5 of substantial simplification.

So I need a v2 of this series, then...

 - Move 4/5 to the beginning of the series (patch 1 or 2, doesn't matter)

 - Add R-b, Fixes, and Cc: stable tags to those two patches

 - Address Jeff's other comments

AFAICT the 0-day bot reports were for the admin-revoked state series,
not this one.


--
Chuck Lever


