Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C5655B307
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jun 2022 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiFZREz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Jun 2022 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZREy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Jun 2022 13:04:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE6B1CE;
        Sun, 26 Jun 2022 10:04:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25QCN3LY026042;
        Sun, 26 Jun 2022 17:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qUlzOaqc4hQj2pKcdFZZaSoeewU5wN+ZHD2b6/QPeQg=;
 b=zUrDpvXdEtny/jmGscnmwAPR07fXyaKrUf0gcloLsDirKR9hCL5mG2BiqI/xom5xC6jA
 CO9bUgE47zaZ74Pg7VjQH5DD1K9n0EjuU9qv0o5MtHuflnhB0fO6kPVs3VIkP+m4TRUM
 BPa46wl+uk3d26PxfaC6t+4gtoPOlyGUD0ylk+SS/ffUuvxW1Rkyvn3/oLzc2hMTHutt
 q5qHsXmDcKLmo7uMCk02US3RRITylRme/IPaUZu6wgFy4OpVeuwLKVODTlDgFO1aPUTs
 o8qZjoaZX4LqVS5FM9Kjg7DczxOroJo0gmNZMpZMW+dhSjOI9q/yrAZfroHdB570Ixms 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwu1meh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 17:04:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25QH1LZf019418;
        Sun, 26 Jun 2022 17:04:40 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt6qrq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 17:04:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdn4mKxPak1furSRUaIjfKmip3KEI8xfd5Von+CePGLkLCRiOw71zHOj1gKb6CL9miJC5QTZk57Ra+NA1KUwwBdS7yVY6ha347F84t/gJMzdl2CMKV1yZbs60JeaHCRy9cZZjxprkRdaZFu+sGbPvS2xfTAY0yjv9sQ1owYB9b8hhFpW1twZPZAL/TOP6d3cX28W8JrFqFWCuk9h49pVuFu0SsH96IWEnkYgAMklvCRpB22qbARN3vFKPyZSUXd/QeU9KxAdMor2C7n0m59WrEYxitqmWHpkXBGBRL22Fvm+pVLRv8gTmt2QPTHSiJKvj/28v7fWiV2xEvJRVaMv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUlzOaqc4hQj2pKcdFZZaSoeewU5wN+ZHD2b6/QPeQg=;
 b=R+IjrIbrcB2FkFFPtUyZzz+VumbvGInXR743azTDgVm81Akp44Vir4aCizh+88d9RWmBSeXLwb3JOEahb1N0gmM9eUTGNbmYreZ6X3KQpdJgYEeLMfSjLpUB5hoYhjLmnFSmOy67/dNtndyJUvzFN4rZ45I7AVpHv/4Z/zq+HfChxb4XyDuOdiyo5vj0iNz6A0ExV3ykVqpsQI4vlwPIBO3t9iJr5aROzPzlGl1b9PphTAiAdzo14+W8seTEeeXYtvHkvWfJGk9LJqPsd4Fzbf8IfnyubuCEoRcrsQm7wQZ+eV1UCl/BZSTzHpQlaH/kbpcT61S43mW1mNT+fpJwng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUlzOaqc4hQj2pKcdFZZaSoeewU5wN+ZHD2b6/QPeQg=;
 b=TYD6vF1FPcTWcs6nTLvRY9u1XvpEjbCVMyM/sNHH4zHxh2WSZQyKRggx+HpDxTtuOGFPjTNxlIcF6HyzHyUGr0+Ibzy2K+wSaYhfiwY/Bmv304+ex0LYNSxxdw5HqYjLfuiqJvCqbET7Xx1Qv/tSFY1xvnbS4WmeMFL/keINT3c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5111.namprd10.prod.outlook.com (2603:10b6:408:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Sun, 26 Jun
 2022 17:04:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 17:04:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zorro Lang <zlang@kernel.org>, Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [Bug report] fstests g/465 panic on NFS over XFS (linux
 v5.19-rc2+)
Thread-Topic: [Bug report] fstests g/465 panic on NFS over XFS (linux
 v5.19-rc2+)
Thread-Index: AQHYhG4JYbZcrG+l4kS/ExuikN1XJ61hk0WAgABhgIA=
Date:   Sun, 26 Jun 2022 17:04:37 +0000
Message-ID: <9E31ED95-2F72-4FCB-B7EE-4C3F69F6472F@oracle.com>
References: <20220620062114.ixfkp7sr6rjd4ush@zlang-mailbox>
 <20220626111539.svanuahguaeqsvve@zlang-mailbox>
In-Reply-To: <20220626111539.svanuahguaeqsvve@zlang-mailbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f631f20-9d3a-451d-4054-08da5795f3d7
x-ms-traffictypediagnostic: BN0PR10MB5111:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +vtCBwJdl8TrSH+mxq9cwiWbbmpfpbZx2Bt8OynlRjYJ1ozbTjCPJyepa8XHasIHNFRhbpk8S7Ofm3lBGZkp2AMkHlrH8kG/CZppMnSb7c+gXofmAr+9H/04vJtga/uWqptnxeC/WAs+ibmq20UGGzmD1h14ucDiQAvOeC/erEkoHtEn7FpfTUfvnGn5H/oowpE/yYEhSMCb2QNYuHvWXQaEDVIW4WhmG+aastDc6577lrPbc7YhDllrPAbU1/y9DAQo+qSDp0dDZX5qT0G58w9UtOVNnVb3wj26HMg+bMRQeyh6jclZvufLa444OmhpZQ4maNFkI2gUYxlFV4sZjGxeZ0p94EWTcH/RDuX+yRXJeJGmXwC7I37ihvOE+gfd7JzihxcuRiifpestITodLNI2596BlEQtHch9WS7MhfsWVRtVY22uiHShWaFhT2pl9MIhFfsgfESIug6u2PEvbzQnbsSzMy1PNVU+tRysiMgyPX27wr6Rts0LI2yZjp4eYOdfD0XuN8zDuJScVK4AZ48ZJbqtVPqHoOchFoyC0djnLVsMcfKybgxj0/C0530fWj9pXvzrPkMTRL+lH+CM6A2LDl+3WQNEQvNEDbl52ckipqu+b65mOdqKZUBda0LlJ25em0HigLqlxJ5AoHTWkUSv3eSBQNVGRxKuEC/3UpfUJT0NYcCv9B5DgtyjaO7HAuPgPt8hZvRXk/QzljsZ9ay/DSbmbV7MWhYkNfJOoOEW/VCW/qvu85dj/NXpAKHxIR/f6Dw/jGy/84xyxatAASs6gD1gB5LLulSATUQ7jaqIYSmvtn+QbnMCtmrnqCJqck3tIeEMssWEeIVYOKx5Wkf+PglGMxPaMtBO4ar9oZLjjC5BmXCxeU6MWkWfN6SVjU0kXiUUsJ5XmGRjAeRxSGbgSCNLInsGDks3nteou//jVpfFq4OWTdwzviG3dpIA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(396003)(136003)(376002)(41300700001)(2616005)(38100700002)(30864003)(53546011)(122000001)(5660300002)(33656002)(26005)(6512007)(86362001)(83380400001)(71200400001)(2906002)(36756003)(38070700005)(8676002)(186003)(91956017)(45080400002)(4326008)(478600001)(76116006)(8936002)(64756008)(54906003)(66556008)(66476007)(66446008)(6506007)(6486002)(316002)(966005)(110136005)(66946007)(45980500001)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VsMY4GnHlkYomR9bPd7Hkv4T9z84uiW2/Wpj8kVmNUC/mfBxoX0glCCotAcl?=
 =?us-ascii?Q?JfirlXi30nmh4UFIx7mnxz+4d4ZqJ4DjeIDjbRshq4jfnWZuCxUgrTwHghbc?=
 =?us-ascii?Q?ixj83fGxUTcm+3UFf/EBXFWb0/NURk8SoEONDRGgvw38hAX8LLZuEG5ARMqJ?=
 =?us-ascii?Q?ld1puM3AVDjQz7yAELMi98z7iwUaKjchg898voo+G+DCzeD7K5UtbOgiBE4S?=
 =?us-ascii?Q?2ir2pIyuuljfWdlwcf/ntK8Iayrnx14c4y4N208gDnIIqdt3XYPxvQbmKlRA?=
 =?us-ascii?Q?JNDx03c60eiY1hr21EPRRCPX6qZF9I6XXPb/S+GYnLZYz1iu2aMO2tOi5VPk?=
 =?us-ascii?Q?+N9zXhjAUonyx0vAl3yhShvahVlS0RzsSBVoND4qw9GlLtYjLaTmgPrOMD9+?=
 =?us-ascii?Q?UE6IOQBdsH7hhp8taB5SH2EX3nQORAYBYai5Xn0yZkA5AzA4xzuCawudSdpD?=
 =?us-ascii?Q?hpNYpdybTdiQYQTHWpgrr6GcowpmaHThPHU/Mhf5R77bmlmpH3L2IBUxgnTA?=
 =?us-ascii?Q?iU+Ve+N9voJPf58Yk1448B7pR2IbiCCLbr+UMyywizJZZtDt6qLtCabE84QP?=
 =?us-ascii?Q?imNNRZ2HYz4AoDwDx9eJyTf2CFGPPObvJqfZRBR+txb5FQGCL2hyEHvlE4q6?=
 =?us-ascii?Q?JYKfjatgOLyGC34Ro19RevMAzhDRcwGnYNPM2p8GmDWi5ReHaBZ8g/RuyNng?=
 =?us-ascii?Q?A+4SLfd9HuNrkSE/7uujeuwBcW6ZovV8V2AwTsw/5URPK/KnQBwZVUTI6aJp?=
 =?us-ascii?Q?CxW4K+4TNwlms+4JyEDFndfwoLE4eAWqAPl8Gqc70pFFjaY05IGATii5vWnp?=
 =?us-ascii?Q?O8n31BneUR4tTV39pCqcSxx4ysheNQkKqrt/y4ld5AoVoio20cEqh3/tBVYR?=
 =?us-ascii?Q?xJ4DNFxXwPSrgvvtWVpNo9SjOBXf9/2u0emfLP3zwdj1mmm1qxJQG0pDVuiS?=
 =?us-ascii?Q?FDHUuU24Y6hRZqJR/srtPqyOqaC5Ulon105idtlPsB5ki13CI/MOFFtJf5Wa?=
 =?us-ascii?Q?Hw+yTrOWG5CFB6txlW5qmJKqyEU5LDvMCEJRhETz9Wz/hL7McXoKPmaBAkEF?=
 =?us-ascii?Q?Ea6W61Xf8jNV6CbThEfEcF27TMo4/CkM2o8vRUnMVkRPyEojvkCH/5ihPrLV?=
 =?us-ascii?Q?ysiGAsXdWDUr6yC5kuiQdOpNmvsonQh8WjWO4yBMGQLfeSvRcrFF6Eby4Vcw?=
 =?us-ascii?Q?zuMqDV5W68lrbkN3STrggvpFLlahA2Sge7qC5SOd1lzCLtN9yQ/kyefScOjz?=
 =?us-ascii?Q?/6wGWYf81fX9l0A+CYyahK38+jxtzNIXcR8ocwTqUuajrnpZWUwl8gbX15R5?=
 =?us-ascii?Q?4KDxXu4W6A3FrgMQ4G4bEVRSnGWCjSAj0EOa+MKnvxAwbl3SmcoqB2BwKfTA?=
 =?us-ascii?Q?DuRVS7YSauWf6ON+Tsy1PWoPQOYNwM/7n23CY/2YAsOq6gMKYx1RzfnK0xYF?=
 =?us-ascii?Q?rKAqX53wZjEKsQ3pb3yIiU0TwBLnAD1cf3l8DRsbE9Th8hEqtveKtAKFCOfK?=
 =?us-ascii?Q?HuZ5z09RJ5cqtXsWnKZkrSe70PIvZ6tVqcvotJJCnSFq7p/zdGJH9PlmfRsw?=
 =?us-ascii?Q?+4IxhvI/aP+GweadXGaeefqZoUrAOw+CFhMmhYq+z2vx3qYaev1rSn1mk3+i?=
 =?us-ascii?Q?zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD2EA991F8B4A7469248A7017DB18A9C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f631f20-9d3a-451d-4054-08da5795f3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2022 17:04:37.8591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iIa6Kitk0Bajrzcnxte7Fe+6FazUvFSHJ0hCFTmu7DYVTgmBFSqz2VybufURBBa8xl02ySDMU2tKEDUBauMhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5111
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-26_05:2022-06-24,2022-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=800
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206260069
X-Proofpoint-ORIG-GUID: 0leLuqWKsq4-IkgbK4gmlO7vcVfXh5W1
X-Proofpoint-GUID: 0leLuqWKsq4-IkgbK4gmlO7vcVfXh5W1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 26, 2022, at 7:15 AM, Zorro Lang <zlang@kernel.org> wrote:
>=20
> On Mon, Jun 20, 2022 at 02:21:14PM +0800, Zorro Lang wrote:
>> Hi,
>>=20
>> I hit kernel panic and KASAN BUG [1] on NFS over XFS, I've left more det=
ails in
>> bugzilla, refer to:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D216151
>>=20
>> The kernel commit HEAD is 05c6ca8512f2722f57743d653bb68cf2a273a55a, whic=
h
>> contains xfs-5.19-fixes-1.
>>=20
>> Not sure if it's NFS or XFS issue, so cc both mail list.
>=20
> It's still reproducible on my regression test of this week, on linux
> 5.19.0-rc3+ (HEAD=3D92f20ff72066d8d7e2ffb655c2236259ac9d1c5d).
>=20
> And the feedback from Dave (XFS side) said it doesn't like a XFS issue:
>  https://bugzilla.kernel.org/show_bug.cgi?id=3D216151#c3
>=20
> Can NFS devel help to take a look?

Anna's looking at this issue right now.


> Thanks,
> Zorro
>=20
>>=20
>> Thanks,
>> Zorro
>>=20
>>=20
>>=20
>> [1]
>> [26844.323108] run fstests generic/465 at 2022-06-20 00:24:32=20
>> [26847.872804] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>> [26847.872854] BUG: KASAN: use-after-free in _copy_to_iter+0x694/0xd0c=20
>> [26847.872992] Write of size 16 at addr ffff2fb1d4013000 by task nfsd/45=
920=20
>> [26847.872999] =20
>> [26847.873083] CPU: 0 PID: 45920 Comm: nfsd Kdump: loaded Not tainted 5.=
19.0-rc2+ #1=20
>> [26847.873090] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06=
/2015=20
>> [26847.873094] Call trace:=20
>> [26847.873174]  dump_backtrace+0x1e0/0x26c=20
>> [26847.873198]  show_stack+0x1c/0x70=20
>> [26847.873203]  dump_stack_lvl+0x98/0xd0=20
>> [26847.873262]  print_address_description.constprop.0+0x74/0x420=20
>> [26847.873285]  print_report+0xc8/0x234=20
>> [26847.873290]  kasan_report+0xb0/0xf0=20
>> [26847.873294]  kasan_check_range+0xf4/0x1a0=20
>> [26847.873298]  memcpy+0xdc/0x100=20
>> [26847.873303]  _copy_to_iter+0x694/0xd0c=20
>> [26847.873307]  copy_page_to_iter+0x3f0/0xb30=20
>> [26847.873311]  filemap_read+0x3e8/0x7e0=20
>> [26847.873319]  generic_file_read_iter+0x2b0/0x404=20
>> [26847.873324]  xfs_file_buffered_read+0x18c/0x4e0 [xfs]=20
>> [26847.873854]  xfs_file_read_iter+0x260/0x514 [xfs]=20
>> [26847.874168]  do_iter_readv_writev+0x338/0x4b0=20
>> [26847.874176]  do_iter_read+0x120/0x374=20
>> [26847.874180]  vfs_iter_read+0x5c/0xa0=20
>> [26847.874185]  nfsd_readv+0x1a0/0x9ac [nfsd]=20
>> [26847.874308]  nfsd4_encode_read_plus_data+0x2f0/0x690 [nfsd]=20
>> [26847.874387]  nfsd4_encode_read_plus+0x344/0x924 [nfsd]=20
>> [26847.874468]  nfsd4_encode_operation+0x1fc/0x800 [nfsd]=20
>> [26847.874544]  nfsd4_proc_compound+0x9c4/0x2364 [nfsd]=20
>> [26847.874620]  nfsd_dispatch+0x3a4/0x67c [nfsd]=20
>> [26847.874697]  svc_process_common+0xd54/0x1be0 [sunrpc]=20
>> [26847.874921]  svc_process+0x298/0x484 [sunrpc]=20
>> [26847.875063]  nfsd+0x2b0/0x580 [nfsd]=20
>> [26847.875143]  kthread+0x230/0x294=20
>> [26847.875170]  ret_from_fork+0x10/0x20=20
>> [26847.875178] =20
>> [26847.875180] Allocated by task 602477:=20
>> [26847.875185]  kasan_save_stack+0x28/0x50=20
>> [26847.875191]  __kasan_slab_alloc+0x68/0x90=20
>> [26847.875195]  kmem_cache_alloc+0x180/0x394=20
>> [26847.875199]  security_inode_alloc+0x30/0x120=20
>> [26847.875221]  inode_init_always+0x49c/0xb1c=20
>> [26847.875228]  alloc_inode+0x70/0x1c0=20
>> [26847.875232]  new_inode+0x20/0x230=20
>> [26847.875236]  debugfs_create_dir+0x74/0x48c=20
>> [26847.875243]  rpc_clnt_debugfs_register+0xd0/0x174 [sunrpc]=20
>> [26847.875384]  rpc_client_register+0x90/0x4c4 [sunrpc]=20
>> [26847.875526]  rpc_new_client+0x6e0/0x1260 [sunrpc]=20
>> [26847.875666]  __rpc_clone_client+0x158/0x7d4 [sunrpc]=20
>> [26847.875831]  rpc_clone_client+0x168/0x1dc [sunrpc]=20
>> [26847.875972]  nfs4_proc_lookup_mountpoint+0x180/0x1f0 [nfsv4]=20
>> [26847.876149]  nfs4_submount+0xcc/0x6cc [nfsv4]=20
>> [26847.876251]  nfs_d_automount+0x4b4/0x7bc [nfs]=20
>> [26847.876389]  __traverse_mounts+0x180/0x4a0=20
>> [26847.876396]  step_into+0x510/0x940=20
>> [26847.876400]  walk_component+0xf0/0x510=20
>> [26847.876405]  link_path_walk.part.0.constprop.0+0x4c0/0xa3c=20
>> [26847.876410]  path_lookupat+0x6c/0x57c=20
>> [26847.876436]  filename_lookup+0x13c/0x400=20
>> [26847.876440]  vfs_path_lookup+0xa0/0xec=20
>> [26847.876445]  mount_subtree+0x1c4/0x380=20
>> [26847.876451]  do_nfs4_mount+0x3c0/0x770 [nfsv4]=20
>> [26847.876554]  nfs4_try_get_tree+0xc0/0x24c [nfsv4]=20
>> [26847.876653]  nfs_get_tree+0xc0/0x110 [nfs]=20
>> [26847.876742]  vfs_get_tree+0x78/0x2a0=20
>> [26847.876748]  do_new_mount+0x228/0x4fc=20
>> [26847.876753]  path_mount+0x268/0x16d4=20
>> [26847.876757]  __arm64_sys_mount+0x1dc/0x240=20
>> [26847.876762]  invoke_syscall.constprop.0+0xd8/0x1d0=20
>> [26847.876769]  el0_svc_common.constprop.0+0x224/0x2bc=20
>> [26847.876774]  do_el0_svc+0x4c/0x90=20
>> [26847.876778]  el0_svc+0x5c/0x140=20
>> [26847.876785]  el0t_64_sync_handler+0xb4/0x130=20
>> [26847.876789]  el0t_64_sync+0x174/0x178=20
>> [26847.876793] =20
>> [26847.876794] Last potentially related work creation:=20
>> [26847.876797]  kasan_save_stack+0x28/0x50=20
>> [26847.876802]  __kasan_record_aux_stack+0x9c/0xc0=20
>> [26847.876806]  kasan_record_aux_stack_noalloc+0x10/0x20=20
>> [26847.876811]  call_rcu+0xf8/0x6c0=20
>> [26847.876818]  security_inode_free+0x94/0xc0=20
>> [26847.876823]  __destroy_inode+0xb0/0x420=20
>> [26847.876828]  destroy_inode+0x80/0x170=20
>> [26847.876832]  evict+0x334/0x4c0=20
>> [26847.876836]  iput_final+0x138/0x364=20
>> [26847.876841]  iput.part.0+0x330/0x47c=20
>> [26847.876845]  iput+0x44/0x60=20
>> [26847.876849]  dentry_unlink_inode+0x200/0x43c=20
>> [26847.876853]  __dentry_kill+0x29c/0x56c=20
>> [26847.876857]  dput+0x41c/0x870=20
>> [26847.876860]  simple_recursive_removal+0x4ac/0x630=20
>> [26847.876865]  debugfs_remove+0x5c/0x80=20
>> [26847.876870]  rpc_clnt_debugfs_unregister+0x3c/0x7c [sunrpc]=20
>> [26847.877011]  rpc_free_client_work+0xdc/0x480 [sunrpc]=20
>> [26847.877154]  process_one_work+0x794/0x184c=20
>> [26847.877161]  worker_thread+0x3d4/0xc40=20
>> [26847.877165]  kthread+0x230/0x294=20
>> [26847.877168]  ret_from_fork+0x10/0x20=20
>> [26847.877172] =20
>> [26847.877174] Second to last potentially related work creation:=20
>> [26847.877177]  kasan_save_stack+0x28/0x50=20
>> [26847.877181]  __kasan_record_aux_stack+0x9c/0xc0=20
>> [26847.877185]  kasan_record_aux_stack_noalloc+0x10/0x20=20
>> [26847.877190]  call_rcu+0xf8/0x6c0=20
>> [26847.877195]  security_inode_free+0x94/0xc0=20
>> [26847.877200]  __destroy_inode+0xb0/0x420=20
>> [26847.877205]  destroy_inode+0x80/0x170=20
>> [26847.877209]  evict+0x334/0x4c0=20
>> [26847.877213]  iput_final+0x138/0x364=20
>> [26847.877217]  iput.part.0+0x330/0x47c=20
>> [26847.877221]  iput+0x44/0x60=20
>> [26847.877226]  dentry_unlink_inode+0x200/0x43c=20
>> [26847.877229]  __dentry_kill+0x29c/0x56c=20
>> [26847.877233]  dput+0x44c/0x870=20
>> [26847.877237]  __fput+0x244/0x730=20
>> [26847.877241]  ____fput+0x14/0x20=20
>> [26847.877245]  task_work_run+0xd0/0x240=20
>> [26847.877250]  do_exit+0x3a0/0xaac=20
>> [26847.877256]  do_group_exit+0xac/0x244=20
>> [26847.877260]  __arm64_sys_exit_group+0x40/0x4c=20
>> [26847.877264]  invoke_syscall.constprop.0+0xd8/0x1d0=20
>> [26847.877270]  el0_svc_common.constprop.0+0x224/0x2bc=20
>> [26847.877275]  do_el0_svc+0x4c/0x90=20
>> [26847.877280]  el0_svc+0x5c/0x140=20
>> [26847.877284]  el0t_64_sync_handler+0xb4/0x130=20
>> [26847.877288]  el0t_64_sync+0x174/0x178=20
>> [26847.877292] =20
>> [26847.877293] The buggy address belongs to the object at ffff2fb1d40130=
00=20
>> [26847.877293]  which belongs to the cache lsm_inode_cache of size 128=20
>> [26847.877298] The buggy address is located 0 bytes inside of=20
>> [26847.877298]  128-byte region [ffff2fb1d4013000, ffff2fb1d4013080)=20
>> [26847.877302] =20
>> [26847.877304] The buggy address belongs to the physical page:=20
>> [26847.877308] page:000000007bc4a504 refcount:1 mapcount:0 mapping:00000=
00000000000 index:0xffff2fb1d4013000 pfn:0x154013=20
>> [26847.877363] flags: 0x17ffff800000200(slab|node=3D0|zone=3D2|lastcpupi=
d=3D0xfffff)=20
>> [26847.877375] raw: 017ffff800000200 fffffcbec6646688 fffffcbec750d708 f=
fff2fb1808dfe00=20
>> [26847.877379] raw: ffff2fb1d4013000 0000000000150010 00000001ffffffff 0=
000000000000000=20
>> [26847.877382] page dumped because: kasan: bad access detected=20
>> [26847.877384] =20
>> [26847.877385] Memory state around the buggy address:=20
>> [26847.877389]  ffff2fb1d4012f00: 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00=20
>> [26847.877392]  ffff2fb1d4012f80: 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00=20
>> [26847.877395] >ffff2fb1d4013000: fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb=20
>> [26847.877397]                    ^=20
>> [26847.877400]  ffff2fb1d4013080: fc fc fc fc fc fc fc fc fa fb fb fb fb=
 fb fb fb=20
>> [26847.877402]  ffff2fb1d4013100: fb fb fb fb fb fb fb fb fc fc fc fc fc=
 fc fc fc=20
>> [26847.877405] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>> [26847.877570] Disabling lock debugging due to kernel taint=20
>> [26848.391268] Unable to handle kernel write to read-only memory at virt=
ual address ffff2fb197f76000=20
>> [26848.393628] KASAN: maybe wild-memory-access in range [0xfffd7d8cbfbb0=
000-0xfffd7d8cbfbb0007]=20
>> [26848.395572] Mem abort info:=20
>> [26848.396408]   ESR =3D 0x000000009600004f=20
>> [26848.397314]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits=20
>> [26848.398520]   SET =3D 0, FnV =3D 0=20
>> [26848.506889]   EA =3D 0, S1PTW =3D 0=20
>> [26848.507633]   FSC =3D 0x0f: level 3 permission fault=20
>> [26848.508802] Data abort info:=20
>> [26848.509480]   ISV =3D 0, ISS =3D 0x0000004f=20
>> [26848.510347]   CM =3D 0, WnR =3D 1=20
>> [26848.511032] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000b22=
dd000=20
>> [26848.512543] [ffff2fb197f76000] pgd=3D18000001bfff8003, p4d=3D18000001=
bfff8003, pud=3D18000001bfa08003, pmd=3D18000001bf948003, pte=3D0060000117f=
76f87=20
>> [26848.515600] Internal error: Oops: 9600004f [#1] SMP=20
>> [26848.516870] Modules linked in: loop dm_mod tls rpcsec_gss_krb5 nfsv4 =
dns_resolver nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd aut=
h_rpcgss nfs_acl lockd grace rfkill sunrpc vfat fat drm fuse xfs libcrc32c =
crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_blk virtio_net vi=
rtio_console net_failover failover virtio_mmio ipmi_devintf ipmi_msghandler=
=20
>> [26848.525472] CPU: 1 PID: 45919 Comm: nfsd Kdump: loaded Tainted: G    =
B             5.19.0-rc2+ #1=20
>> [26848.527934] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06=
/2015=20
>> [26848.529819] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTY=
PE=3D--)=20
>> [26848.531625] pc : __memcpy+0x2c/0x230=20
>> [26848.532583] lr : memcpy+0xa8/0x100=20
>> [26848.533497] sp : ffff80000bbb6f00=20
>> [26848.534444] x29: ffff80000bbb6f00 x28: 0000000000000000 x27: ffff2fb1=
8a4bd5b8=20
>> [26848.536435] x26: 0000000000000000 x25: ffff80000bbb7740 x24: ffff2fb1=
8a4bd5b0=20
>> [26848.538283] x23: ffff2fb1ee80bff0 x22: ffffa83e4692e000 x21: ffffa83e=
434ae3e8=20
>> [26848.540181] x20: ffff2fb197f76000 x19: 0000000000000010 x18: ffff2fb1=
d3c34530=20
>> [26848.542071] x17: 0000000000000000 x16: ffffa83e42d01a30 x15: 61616161=
61616161=20
>> [26848.543840] x14: 6161616161616161 x13: 6161616161616161 x12: 61616161=
61616161=20
>> [26848.545614] x11: 1fffe5f632feec01 x10: ffff65f632feec01 x9 : dfff8000=
00000000=20
>> [26848.547387] x8 : ffff2fb197f7600f x7 : 6161616161616161 x6 : 61616161=
61616161=20
>> [26848.549156] x5 : ffff2fb197f76010 x4 : ffff2fb1ee80c000 x3 : ffffa83e=
434ae3e8=20
>> [26848.550924] x2 : 0000000000000010 x1 : ffff2fb1ee80bff0 x0 : ffff2fb1=
97f76000=20
>> [26848.552694] Call trace:=20
>> [26848.553314]  __memcpy+0x2c/0x230=20
>> [26848.554123]  _copy_to_iter+0x694/0xd0c=20
>> [26848.555084]  copy_page_to_iter+0x3f0/0xb30=20
>> [26848.556104]  filemap_read+0x3e8/0x7e0=20
>> [26848.557020]  generic_file_read_iter+0x2b0/0x404=20
>> [26848.558152]  xfs_file_buffered_read+0x18c/0x4e0 [xfs]=20
>> [26848.559795]  xfs_file_read_iter+0x260/0x514 [xfs]=20
>> [26848.561265]  do_iter_readv_writev+0x338/0x4b0=20
>> [26848.562346]  do_iter_read+0x120/0x374=20
>> [26848.563263]  vfs_iter_read+0x5c/0xa0=20
>> [26848.564162]  nfsd_readv+0x1a0/0x9ac [nfsd]=20
>> [26848.565415]  nfsd4_encode_read_plus_data+0x2f0/0x690 [nfsd]=20
>> [26848.566869]  nfsd4_encode_read_plus+0x344/0x924 [nfsd]=20
>> [26848.568231]  nfsd4_encode_operation+0x1fc/0x800 [nfsd]=20
>> [26848.569596]  nfsd4_proc_compound+0x9c4/0x2364 [nfsd]=20
>> [26848.570908]  nfsd_dispatch+0x3a4/0x67c [nfsd]=20
>> [26848.572067]  svc_process_common+0xd54/0x1be0 [sunrpc]=20
>> [26848.573508]  svc_process+0x298/0x484 [sunrpc]=20
>> [26848.574743]  nfsd+0x2b0/0x580 [nfsd]=20
>> [26848.575718]  kthread+0x230/0x294=20
>> [26848.576528]  ret_from_fork+0x10/0x20=20
>> [26848.577421] Code: f100405f 540000c3 a9401c26 a97f348c (a9001c06) =20
>> [26848.578934] SMP: stopping secondary CPUs=20
>> [26848.582664] Starting crashdump kernel...=20
>> [26848.583602] Bye!
>>=20

--
Chuck Lever



