Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2F61F5EF
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 15:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiKGO1w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 09:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiKGO12 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 09:27:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFDC1DF3A
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 06:21:53 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7DKrxm024090;
        Mon, 7 Nov 2022 14:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wLpkqO6C2xUUBeLBsbp5VezyybzzqwfJ/aB8ZDvzJ8Q=;
 b=FIH/ef6E4UDwQScbnRFVWjx0DSE/2QlACIyLOQMccuxKHwVQuxdH6bbBB6TQHvBD3inm
 U/yy2QpXquiRNg5Mc1asO24BGS44rwClm5UES/PNkNR+/3Zkyc89IOGsQoN090pmH5v8
 BQn9y5RX7RuK8XwQHuwR4NIKr8Iu/ZmpYZa0FYqZUNLxS1Yl3IUfZkCNuen1Vsizxm9M
 ynueo4xZPARA4cF1yjAKhbZsbrHJfmWdtC/nUxlicdddD+XU0cKZ2qlA0fGQD2lCRbKV
 sRJWVQCTR2U/cKU++KZbPhqzNadnKUe4Vd0n6JgI+ORLRKH8V4ok5JRchc4AAtcLMD0K bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngk6c21g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 14:21:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7DQFYs006706;
        Mon, 7 Nov 2022 14:21:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctb2wmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 14:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqROO7/S9yIzTBEvZZhncMd/EFi8X/w83dEHU8a8GQlIXLP7NzVgapmWlc/jr5PX2yoyrD3yYoYv2wFQdgpUcR1KuRZ7jTV/hAbQ1Ial/hZZ+WiEC1uYNEtYISa/zZvem+sTJBac7c6ZZP0sbCu+ZjfVPlySSYBR1Qw7+2WL5fTuO0TKrKUVeoBeIuqVyhTg/jw1JvjL8IHHdSv8baIw1OIt791ZLktzBxXEuVHpCZlXb7u2oEB8gKXMREEfmukJ8sE2MD/yAb4UItqKEgnODLUdOp22ij8rDGbTRnvsMrGaAOlCkZUYiitAzLQoOHv/x9kZT+yEafLRhSFe3Q26MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLpkqO6C2xUUBeLBsbp5VezyybzzqwfJ/aB8ZDvzJ8Q=;
 b=XzAbIwfMhVydEtKIaDamlXJJS9ns6tjAa8qnHVvd6J6lYH60RtPeIMtmMbfkM97YFdqHxsOEzG+vv8sr62j/7vSvgEMqDBp+lGLuSxqXQJSZpkhxjlxMF93uvrlAzfUQhtW2TzwtcH2jajnp+dvGaU1o/Geyh21rLNhCMIq5FlQFY9MN2YUw4vRpmCKauM2uEwb/NpMei4UD2SYPdmD5MpcPj9nzKBCIpa+MvoADWmXWGP66+Hhmo2oBVqMm/CYnRnPIsqHp5zHEJWUvTF1j3u6PfA2V7HUfuMQwqtwaidHiBfml4wGmuRrhnOGJGv3QosWA8NVAsvWx7XP3m2E5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLpkqO6C2xUUBeLBsbp5VezyybzzqwfJ/aB8ZDvzJ8Q=;
 b=E/bbxdRn/StpBMzufZdgrvgZUFBt8KrpoYO6m0tFdeHs2WOdxHmpTLHlcFZi9oEUL2i2z3OSlJWjMxJc3fvsYJuxq/mCkBzYmmNQfW570Ni3adTmaDC7pTrWA8jAl4J1ukU+sBAJlU/rkypXc1VDZ4NL0t0kyq4GWUdJ87DQ4rc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4458.namprd10.prod.outlook.com (2603:10b6:806:f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:21:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:21:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>, Yongcheng Yang <yoyang@redhat.com>
Subject: Re: [PATCH] nfsd: return error if nfs4_setacl fails
Thread-Topic: [PATCH] nfsd: return error if nfs4_setacl fails
Thread-Index: AQHY8qBNetvl8sasZkCTSpe8OKZOT64zg0AA
Date:   Mon, 7 Nov 2022 14:21:40 +0000
Message-ID: <E4578066-9B1F-4CF2-BD22-958A649900EA@oracle.com>
References: <20221107115841.26380-1-jlayton@kernel.org>
In-Reply-To: <20221107115841.26380-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4458:EE_
x-ms-office365-filtering-correlation-id: 82264880-8335-4f77-e10f-08dac0cb63bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5pVM3e9bXmtI3zoqZOT1yCn/NLx9wBDk513TbiQP787Csahvsp7syFpSnZwemuQCclVxK/0HkpI0yXE7gHdR2Fli3f/0rGsGigxDl1bruGfWewE3sn8RUjZVl1n1S2AA72g1mllg1wfzh+JMC7GVXVl7KEa8TjKt16RxFvSaiqH1Gmr1a1dq8FGRceu14YeIEjImwUhSgjoakg7hRVtqG0K/lQx43uOxQkicN8xSUyr22jY7TtoJ/79H3W1do5ZAzxKdKSUa8JniuswO+LOFJ0Eg58sCQ/xa1sBIddgwgxtlB2vcm6HHpVDbuXD2UWjS2L10Ipy+vMlatzVzZFu0MZw6O6Shkvpsm/gb5iearhyY6NtwDpx8yeyLp41xCobDdDIxueFs0s4YqFSM9K4tItW6dsUwHnuJQhkoMLW5TX1q0AeVeP22+OXM5nwoC0BnQsfsInVlZa7BBPwpnFIyzHNvh+mDTexdyiDy4UYkinFc6UB1XDo7tzpkUU1v0xGHfkcSTivOjrBUmV7izL+hUUKadDA8S0tV7dy6/43W3x08PHwiIrGApgYxdqmu9IALthzuM5qQQH7p4g+OhLCigTyqWugNwWWhxUQ8gTnHe5ajIa+IuuPSxCwQ4RtmCFyDdPEukmQfdzkD0RU9VkcvsD7IxntKTr0s0I3f+MrGvbAYGFtelChv/+6+AYac7iXnWqJDXu5ecx/Ph3UUWnu4RSNam4EIz14ibkQiupgZ9aQtUllq1HUYipl1P1rDlfH9B6PnAiFvdJgpiC3jwTZqYtVMsLBEwc8dfgVQ9pEfba8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(4744005)(8936002)(5660300002)(2906002)(186003)(33656002)(91956017)(66946007)(76116006)(316002)(6916009)(86362001)(36756003)(478600001)(38100700002)(6486002)(122000001)(66556008)(38070700005)(64756008)(4326008)(71200400001)(66476007)(66446008)(8676002)(41300700001)(2616005)(26005)(6512007)(6506007)(54906003)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vWFyciaI82C/JLUGSkSvB6R8E0mm4bb+N65SHLPZpSJO58X7CR9cPz1EmeBZ?=
 =?us-ascii?Q?xaAfrHo4Y6sOY8Ju+72uXYCd0gQdhvgD4KkfZU+/r2CJsv83+wZuxWabtOAi?=
 =?us-ascii?Q?SAJRJJTV394L9ObQ5DbEKIMMW/IUQVhZYygPommIr5n0heX2h2EF9hM8Ngmt?=
 =?us-ascii?Q?37/8UjaqIVrJzdW7TbDpf2VmIb30PersEkoZL90LaeIFd39ymhZm07VD+HFZ?=
 =?us-ascii?Q?i1EEOe/mLsI3OzXMCLmS3lbSAzRQlPxSdP2EY3TKFjWbXBswgFqJwMDgCxNC?=
 =?us-ascii?Q?jGmJceopQcIYeKRr7obKyNmq/681VBIQ3jtDbM8AZ5mh7MtlksbO5dTpZop3?=
 =?us-ascii?Q?EI3FiyGtqVgAZY90++FS/H5gcnAU2QTJ0Q3TP7TjXFXp0nfNtSUyMxrZrSqA?=
 =?us-ascii?Q?VXSeSuvIP7Gp8k4mriqk+L7PxVF+Or5bCxYrgBXEiL8AoHzqPpUrJYAPbpVm?=
 =?us-ascii?Q?kzQSWc+eTjR4Y7q6GfjKFci+DW/MEpU6Ao3xoZd91mdWVSiLjbLZkZZCWi4F?=
 =?us-ascii?Q?fuze4+G94Wsxzy57Jt5Qo07nILgYIcAfBLhuRbsmLd8BdYJbMkgtKKUa1aAg?=
 =?us-ascii?Q?t+P45rprnSNQL6ci/V9Kw+VyLnd2q6BhVLBKztZV4+yr6Ae3hcXiurvyHehX?=
 =?us-ascii?Q?CCSSYRgWeVIjlI2Us49OxFY6OToiMiH0xeY+KStFCCp7jXRECviCYT55DneM?=
 =?us-ascii?Q?BzZGozqATrMoTe8xSxFrt5I7iZGpe6Ua5LbHqQeSd0nxT72T8sSvRG3q3yUo?=
 =?us-ascii?Q?8du0hlOOdJfLMt/8LCP41zRlX4dW6GBMP0gx4FOyHytLacP0Dc4mud9z+a7s?=
 =?us-ascii?Q?QloMcywiGXgGjWIKM9XUsxlK2KWLldB6/VHzC5B4C62TIgyQLyRDS8YGmHY9?=
 =?us-ascii?Q?6I9SRn+qZFKslLzm/fs52JoT823+NFf1C4Q09cMXZQ5zaXY+xMXSBHeoJU6I?=
 =?us-ascii?Q?DLSVkl+O+ZtHZJE0r2MLGb1anbMWqk+GyY8Esx2OkqWUyEag57RRA66Yk6vu?=
 =?us-ascii?Q?9qJbr2Nu9dOitsbbG0a7b7keo5m3E3cPPPSEiniBZRYBymO1GpXh8rAS4DYy?=
 =?us-ascii?Q?pvZ3KgM7s1dwsWofMHNTQl34/suPboL9TB59b/qNs/glRiuUqkCk0bYH+BIH?=
 =?us-ascii?Q?EY/i35bhZ0u0Tb+7fQ4VKkcseSI41/rT967+qSVtWZh2+clSB9/nM0cQ5hZX?=
 =?us-ascii?Q?AzKZjTltbdAmxX2yBMfxErijAX/pOqMq2hFiiOebPOGCjiO1nrN8baZSEH3i?=
 =?us-ascii?Q?51Cbm3SQgbVPhSEfZaC/xoX6/The8h8LXT64D96HCKYpaIVQ3PZnHKJoxiAj?=
 =?us-ascii?Q?EHeKsEbFHYAg+xixoRX0v0d/xNooix4IVzMLkxAcjs8+y7CZXDI48i4dBlUg?=
 =?us-ascii?Q?TXtAzByHRz38LEgtac8/HEjNKy+AZFNyrJCABtVty3UwDnaWqA8KCTDX8JJu?=
 =?us-ascii?Q?b1IIQTsejFnU9drReImvtr045+9r8FnNO578LKPWRns7DNprnnyrW2uUT6AX?=
 =?us-ascii?Q?IQKPeVXYoCTNpiXFdM8pTnsJmtYwHUt8V1vcFiJ8fydyrcmHbE6ZsJno0emZ?=
 =?us-ascii?Q?LF3K1XgcT3aOPj4uGiJmMSSVMc5yN2rz5jcg0EUtEhNGSIBgSAOOD2ibyfzQ?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BBEE5BF7C2227439A193B0B975C45DA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82264880-8335-4f77-e10f-08dac0cb63bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 14:21:41.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0f3AgN5H29BNJ6+3jRPUPDs6zwiQ+pru0ixr7HyegBPwjDN9cz6YsWwtTzIxlX6VXXLziGpjDy21/Kt1Xgnnhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_06,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070115
X-Proofpoint-ORIG-GUID: UA8IlZquoTcyDG62gguXhnvkWS0Jkr86
X-Proofpoint-GUID: UA8IlZquoTcyDG62gguXhnvkWS0Jkr86
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 7, 2022, at 6:58 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> With the addition of POSIX ACLs to struct nfsd_attrs, we no longer
> return an error if setting the ACL fails. Ensure we return the na_aclerr
> error on SETATTR if there is one.
>=20
> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> Cc: Neil Brown <neilb@suse.de>
> Reported-by: Yongcheng Yang <yoyang@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Applied to nfsd's for-next tree (6.2). Thanks!


> ---
> fs/nfsd/nfs4proc.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 6f7e0c5e62d2..a6173677b766 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1135,6 +1135,8 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> 				0, (time64_t)0);
> 	if (!status)
> 		status =3D nfserrno(attrs.na_labelerr);
> +	if (!status)
> +		status =3D nfserrno(attrs.na_aclerr);
> out:
> 	nfsd_attrs_free(&attrs);
> 	fh_drop_write(&cstate->current_fh);
> --=20
> 2.38.1
>=20

--
Chuck Lever



