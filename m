Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C2E629BEA
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Nov 2022 15:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKOOVt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Nov 2022 09:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiKOOVs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Nov 2022 09:21:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E922BB01
        for <linux-nfs@vger.kernel.org>; Tue, 15 Nov 2022 06:21:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFE1wRq023847;
        Tue, 15 Nov 2022 14:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ptgEyN9UcJd8IJPdwmObnNlULzi+ToZ6GmAT7fKKp/E=;
 b=PyxbASxvzTS3+4umqwxPq1+0z0BTuBedD/ef+1pRJVK4fhITodqrWZI25ogblizQa+cv
 i4r2z7KwlGQ29Wkdjn8feURNpwd8FXI/4Tf2/gQAYFQ+p5sab46zPA1FKOpxNc6ZPnDd
 6qIv2/rSxvTCyPlDAxFFXMzjFylFY7FwEe8hsbFeeIjOvJCPmQkpX2UZK390323j/iLj
 xca3mMzlaJuH0OCiv9wlwK/WdIAOUUbBHIA4YGkuABJv6/J1Kgh4uPi6sZrNaelsVxS/
 QmOcXhS+WTsCI6Oq6aCr1+IiMLwJFHMUFvxXzqeRL2q1wJ91awoqP4WYS8KWESVg4zNo FA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3hdsafk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 14:21:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFDwoFa001399;
        Tue, 15 Nov 2022 14:21:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk1vnk6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 14:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WizTVCvI57CdRrOIhhkQCQOQLLqLBEy/8CPBvgCh2A8wQbacHGTIZ42zbx08sfuHgIApgjewVcZEj3w+iHzMkypkxPjTWDWVYvQ40i4zyALDqKbwyhr2OU4SWD6dNtRkHxdjJje/K8asFwi2K3B9Veixo8CokpNQcZuYGxEVcRlo6Cdf3W8atTyzgLaVk2PMy9iU4BiwSdjMolVtbn/bDBvDHfzpRCDAa8SpMmmQ0pEgnFhBsjs55pmf+RKS72RRGT60W0tf5CCCZeahdBcucsCyRwF+5nScUm+6t30/mPQ2/ebl+8f4B8491CN1qNL1IsYKwphz4YGnhb0m+XfN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptgEyN9UcJd8IJPdwmObnNlULzi+ToZ6GmAT7fKKp/E=;
 b=Z4d7NcQWtXI4M9GXjn6cV5a5yryh6CoVOOp+zGRSgSMHwvmQ/VPhcJK9Se6A2KywN0+h7cUj9sXn/6g4HNg+4vqo3+U9L1OFvqRixxM4A/WpYr+xBY/r6ayeX/ou4h1gcoFtN2Q20zsvXbwECRWFDBdQafBaxHxnJHTQ+4vVzI8ISG3YmvKy0CBwumuh0lMnM7/HGnw9gAhXpDqX9zzl3iVAv5B/jLRaPQrQ/Dsv8oHL7mXpp1Tgk+U5V7lqX+xz7z1POQWfNkyihhfb/D3qzUcrZDAT7XtmBCGjc6IzxvrmDsELoZtqOPbZYYQcsASvWzoiDQb/E3/uEWUK8uqZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptgEyN9UcJd8IJPdwmObnNlULzi+ToZ6GmAT7fKKp/E=;
 b=pQA9h8lVof8Y6HJcfx7JhVGFdaCDe7VCHsfq6MDl0Kvvx4B+gDCL1B28gcJM/ktY21yBO9SLBNefZVSTnRNjp+xNYvDo76+M1tFjZRacTJG0xQjcixHhXycxUzJnO2hgQH+m18+ND527Xs/MfuXtc7j5OGsl1cKvANeFTIqutc4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 14:21:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 14:21:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] NFSD: add CB_RECALL_ANY tracepoints
Thread-Topic: [PATCH v4 3/3] NFSD: add CB_RECALL_ANY tracepoints
Thread-Index: AQHY9LtZeVXT8D2f3EuoKPtp4QoFca452jEAgAWc1ICAAJqpAA==
Date:   Tue, 15 Nov 2022 14:21:39 +0000
Message-ID: <A25D721B-944B-43B5-ACFB-6EB7C983B355@oracle.com>
References: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
 <1668053831-7662-4-git-send-email-dai.ngo@oracle.com>
 <F69554A8-20BB-482E-AF8A-94F90B1081FD@oracle.com>
 <3ea87405-ea0e-1a4d-63ca-7bf89188b034@oracle.com>
In-Reply-To: <3ea87405-ea0e-1a4d-63ca-7bf89188b034@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4432:EE_
x-ms-office365-filtering-correlation-id: a48ddd7d-7d8d-41d1-d8c9-08dac714b624
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PfCk3x/UUbRxiNS+xrl2DG7ScbJNAjwI+Zq3G+oZy67/w1SuFzlBiT4vg6q2P7wDSFu2kYFDcXhwxu/4Vb5CvXKlh9BFl3OcM2zxMBjJWyz5p1m63dK+TMeOO+ZYdcsJvdqBHRd6RHfdW5yteLJ2+5NAMEqrHL22CfyT/qve44wleWeYBXCrAGFXmBnqv8dZFq2tgdaph6Vx0tnyECUYKQ+yAcH4Rik6e6Ir0v3cE7jKWhqj/PgbPnGkljjW/cqh9wD1oGiJRhceSu2m7/6+50HeuX9bO0oO7cghwe0QIznL6tpLrifpM3wFEabvr7vpoNpAheB8S5IbDGDVWCxQnnHr1W7AEiqrOgWICPky/IuQeGR7unDB5oGw3WPi4khYQsiRMlLGaTtQK7SOvPVjHjgDGzjf6JgeoEeWMBt96+LK38Sb3cIjFDbyJIedQFhR2yJK/Fs5A/wZ2Y8U+5Rkv/aZk3/CGQlUVrSixzr3m7J3jzds3R21kQaBQLpUnU46zFWHCl5sDb/fAO0L5AX/D5a3uVDqbAzMdJUo/bQijx5CZMC1E4dOulgPngluiZ9I7D/U4UXQdHloKwl6thdUUktJseHRqBRCYsB73p1DzS/cPrjcmET9tjhojNstHhkGRtwA9FuLn0bww0tACj5pIJmitoQWQvGc1aByPRcwAshETnle5M3Nk7o7Xurg/Dp+if5OQZ/paYRmdjuhf+8Y/x4mjJW3BXD+FuoQv7CjoO2P+I8CqzdNN+5pzdqxtCLZfqQZLL6CO/y0U+uzxl4MnxRZc+RalC9iAjI920ExcV8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(83380400001)(86362001)(122000001)(38100700002)(38070700005)(2906002)(41300700001)(5660300002)(8936002)(6862004)(6506007)(478600001)(4326008)(2616005)(53546011)(6512007)(26005)(186003)(91956017)(66476007)(64756008)(66446008)(8676002)(66946007)(66556008)(76116006)(316002)(6486002)(71200400001)(54906003)(37006003)(6636002)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HXW+rGoPkTQ+cg8UpIoSqwOA7tEd/o6IMFv/euuc0Cdo71MIChiFVcASyHKt?=
 =?us-ascii?Q?NTnD58PEDOjcxSbuazVRt1eecmPDR670YzdGs3jKHhK7+HB7LyVjVUYGDk7O?=
 =?us-ascii?Q?D7Qi4wrQpYWAw2niYdcYzTZR5yqqXbeWJ7qycvMQOfezi7AIHycY/NjCbjlt?=
 =?us-ascii?Q?5Zceiq6rt1Zxf6rFz/dIP3FH6cJ23z1gnf6A0LPeCuRI9+BYHfA9LW+qJLTT?=
 =?us-ascii?Q?qL5PDcVW2ysVRWXt45wspUwoQiIW0SU07kzlT6ELZpSdFdXUq3ju55UNoY1s?=
 =?us-ascii?Q?66jZ4HTr5CpfqwT9wKfY3EqzsZPQZcbKYx6wcdbKnobq4+c5M2MGCmtZjJLN?=
 =?us-ascii?Q?9f4H2A4JC42cXcCz0kfkAgDH7PRJqYyWGuaq2LuSdbz7AkQMegOEdLS6Hk3Z?=
 =?us-ascii?Q?MSrG6xuKPFO6cNk2yl9Ol2slTCNvYi1vZvriwPKI7HrpBQdP7GL6oXMgpnka?=
 =?us-ascii?Q?ZvlDsgsIXgjGf7E7ommN4AnxeTr5/xzIHQQsEtPCRClhZmHcVzLxL+nWhkVP?=
 =?us-ascii?Q?BLokwJL25oaDT42d0E/FZmzwJeL9ESvS3oghi1PKtykelBjpyiJK8NUc5vtb?=
 =?us-ascii?Q?OCXKIsm1dZnsJDx/fMgTTKcSdZcpDT2C0bg4yBG6FdPLXeE8y61mkELSYwIs?=
 =?us-ascii?Q?Dayyg5Q6EeQg+rp1cdtWAk3WsVwpNg14W2el3IiBUgUZkaD690G6MaeEDIBD?=
 =?us-ascii?Q?+KiIgw0ZY3qt0XMgPrIlIS/xx6C84pqA+iNEBtuYYiV6JBIAKg3rkZcPvPPv?=
 =?us-ascii?Q?cN54X73qm5kJH5A/WBnVhJIruzcJHNUaUTtjhDO6Z8lPPG21l5NvqwiQu8cy?=
 =?us-ascii?Q?AJZD+Ls1MpA7lcF3gjtLGt0ZyVRumcBTfkOkPHIfkxPWOiC87NpOW6MnjkrR?=
 =?us-ascii?Q?Em/O9azLobmvqx+YNDejb8IL/FTi97/2vIm0mGI6IX4o99im6nKR24frLtbk?=
 =?us-ascii?Q?Y6LQGyW1Fnn1CADWqlHhh/o/zX37d2QrSRdzNrnNK+lgDPzkvbV/k3rQMvQd?=
 =?us-ascii?Q?ojG6H8AgQo0UVmwlVezwJDOuYY7GbM4HNRZFBG/nLuJyee3hn9oxbh+8gKbq?=
 =?us-ascii?Q?2pheibGkPeNxxAWLDsona4fk7Kt/ff9gRfNoLg7Rqlane/AQmIV+A+vw5rjt?=
 =?us-ascii?Q?t/cjLPRBQSwq1gQjZV1pLrq69ToiWna2jDjlJXX/vIX0nkdF2LEfP01AZwfv?=
 =?us-ascii?Q?ziuehc9qfVPflDPFymgFubJHx3hfz4RbihdxU9F3qJLk2B6a0c2wn/PTAv2l?=
 =?us-ascii?Q?e5uJhuIxLVub21XfrY2e/KwOu5MsR5veqllPEYY1NCm1TYw66kbdmx3uxYG9?=
 =?us-ascii?Q?d3K+eUp892Ol1x71osGBiHDMcrc5iiV0j2frmClzwGnTubUPDMD+pmQxmYdf?=
 =?us-ascii?Q?2xNtKMrU3QAb+rW1A67GxKK7hD1p1TN9ue4TdSXeDSopCD9WEEMulLdAGFt3?=
 =?us-ascii?Q?Lll9U0wuRXnnJALDlGL+mQN+uAe09t3aZY8daB7ixSILFGbjmL3wd1A5SE4C?=
 =?us-ascii?Q?wWoFIVMQiYXoAHR1H4ipLe1TfepQ507xP+D8tSydJ+oANIGIiWwgFhdNCGHX?=
 =?us-ascii?Q?jH9Nu5sohwKLfgBBK7CGHhajQ9BsTIDRkz+IRpHjNyUEimPYE39iF+xoKP7m?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5E0897BF3344F4BAFC8CB840BBCE24B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eQgJqq5478sfIbhMAzwYAfo03WD9p9SjIClplZDKTRyX5dBU69QjWqWakUUsDIxeAxENTWnNj53+1bp8AFAefmUV1eKkDq1TgZ0z3fiLyrPqnW4hEqgF8zej4WHRhixbwWSWnrVEMGnjZC0B4+NlqDwXWItYn0sIjqUvLblSDedZT0vH8Ozv3tZF1kXmfmBMAYA8pm3SHTay+TEPrejHf7VHseVhFQnlGgSHq5/PHKoaUzLKgYf6BXoKO31fXSFPFr4KBJ6isSmFi3AOOvMfX32J4lmSt5VM2yroxLd1jbBNDOnp5NYRYKqlQKfPsn9/fQP4Q1djwM47eJIuts0M1fwvyxizBJ21VbKhvs58gUku33B9lrFgp2/IpDrXg0AxvN7RWRryV+O/tfA4lj13vI4ExofyMqirVI5AXop285BUwOU3uYdkVzr65KUqyZwya2R8wht5M09YCxGu4hjrzWsFEgg5jAU1YQPndinFfrSigkXIeJmp236IKK4a1q6JMNCGvRuhtjKAmzA+Aw/x/+oiUDc63LPcfshNbxPk5TxnHzHiDv2F/RplnZvcESRRQTF/C59/ZQ03KAvSxpvvn1+d1oUfzfqFhoLJLwd6ggOWQTPCSpTbadYJSx6fOIlmZvElqIZQiqOZcgc2vY3VHTXd4aOIR/k3ZIEaa3g4hTlbo+3dSB92C8xbElOdF/odyBekh8u5Q+cDUe0554d5AHJdWN9ILN9znmLTfcbigelfuQBldqws6uLeI1Ba6FktM1N+TAzF52eOPegVCSzRm9zkmjtivi7XxZuJit2GXrk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48ddd7d-7d8d-41d1-d8c9-08dac714b624
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 14:21:39.5019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4k4BdCwCOi7D/NqmNq5VdRCAmf/SJdHvspbMdT0AVSmXLLMngCkSekX4/Wb+mF4twSqRqwrfpgS/wd6ref5s2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150096
X-Proofpoint-ORIG-GUID: KeYwJkcjwLji8ikz090o0aA2KvftzErP
X-Proofpoint-GUID: KeYwJkcjwLji8ikz090o0aA2KvftzErP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 15, 2022, at 12:08 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 11/11/22 7:25 AM, Chuck Lever III wrote:
>>=20
>>> On Nov 9, 2022, at 11:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Add tracepoints to trace start and end of CB_RECALL_ANY operation.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c |  2 ++
>>> fs/nfsd/trace.h     | 53 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>> 2 files changed, 55 insertions(+)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 813cdb67b370..eac7212c9218 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -2859,6 +2859,7 @@ static int
>>> nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
>>> 				struct rpc_task *task)
>>> {
>>> +	trace_nfsd_cb_recall_any_done(cb, task);
>>> 	switch (task->tk_status) {
>>> 	case -NFS4ERR_DELAY:
>>> 		rpc_delay(task, 2 * HZ);
>>> @@ -6242,6 +6243,7 @@ deleg_reaper(struct work_struct *deleg_work)
>>> 		clp->cl_ra->ra_keep =3D 0;
>>> 		clp->cl_ra->ra_bmval[0] =3D BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>>> 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
>>> +		trace_nfsd_cb_recall_any(clp->cl_ra);
>>> 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
>>> 	}
>>>=20
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index 06a96e955bd0..efc69c96bcbd 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -9,9 +9,11 @@
>>> #define _NFSD_TRACE_H
>>>=20
>>> #include <linux/tracepoint.h>
>>> +#include <linux/sunrpc/xprt.h>
>>>=20
>>> #include "export.h"
>>> #include "nfsfh.h"
>>> +#include "xdr4.h"
>>>=20
>>> #define NFSD_TRACE_PROC_RES_FIELDS \
>>> 		__field(unsigned int, netns_ino) \
>>> @@ -1510,6 +1512,57 @@ DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_notify_lock_do=
ne);
>>> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_layout_done);
>>> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_offload_done);
>>>=20
>>> +TRACE_EVENT(nfsd_cb_recall_any,
>>> +	TP_PROTO(
>>> +		const struct nfsd4_cb_recall_any *ra
>>> +	),
>>> +	TP_ARGS(ra),
>>> +	TP_STRUCT__entry(
>>> +		__field(u32, cl_boot)
>>> +		__field(u32, cl_id)
>>> +		__field(u32, ra_keep)
>>> +		__field(u32, ra_bmval)
>>> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->cl_boot =3D ra->ra_cb.cb_clp->cl_clientid.cl_boot;
>>> +		__entry->cl_id =3D ra->ra_cb.cb_clp->cl_clientid.cl_id;
>>> +		__entry->ra_keep =3D ra->ra_keep;
>>> +		__entry->ra_bmval =3D ra->ra_bmval[0];
>>> +		memcpy(__entry->addr, &ra->ra_cb.cb_clp->cl_addr,
>>> +			sizeof(struct sockaddr_in6));
>>> +	),
>>> +	TP_printk("client %08x:%08x addr=3D%pISpc ra_keep=3D%d ra_bmval=3D0x%=
x",
>>> +		__entry->cl_boot, __entry->cl_id,
>>> +		__entry->addr, __entry->ra_keep, __entry->ra_bmval
>>> +	)
>>> +);
>> This one should go earlier in the file, after "TRACE_EVENT(nfsd_cb_offlo=
ad,"
>>=20
>> And let's use __sockaddr() and friends like the other nfsd_cb_ tracepoin=
ts.
>>=20
>>=20
>>> +
>>> +TRACE_EVENT(nfsd_cb_recall_any_done,
>>> +	TP_PROTO(
>>> +		const struct nfsd4_callback *cb,
>>> +		const struct rpc_task *task
>>> +	),
>>> +	TP_ARGS(cb, task),
>>> +	TP_STRUCT__entry(
>>> +		__field(u32, cl_boot)
>>> +		__field(u32, cl_id)
>>> +		__field(int, status)
>>> +		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->status =3D task->tk_status;
>>> +		__entry->cl_boot =3D cb->cb_clp->cl_clientid.cl_boot;
>>> +		__entry->cl_id =3D cb->cb_clp->cl_clientid.cl_id;
>>> +		memcpy(__entry->addr, &cb->cb_clp->cl_addr,
>>> +			sizeof(struct sockaddr_in6));
>>> +	),
>>> +	TP_printk("client %08x:%08x addr=3D%pISpc status=3D%d",
>>> +		__entry->cl_boot, __entry->cl_id,
>>> +		__entry->addr, __entry->status
>>> +	)
>>> +);
>> I'd like you to change this to
>>=20
>> DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_recall_any_done);
>=20
> TP_PRORO of DEFINE_NFSD_CB_DONE_EVENT requires a stateid_t which
> CB_RECALL_ANY does not have. Can we can create a dummy stateid_t
> for nfsd_cb_recall_any_done?

Ah, I didn't remember that a state ID was recorded. OK, then a
separate TRACE_EVENT is appropriate for nfsd_cb_recall_any_done.


> Note that nfsd_cb_done_class does not print the server IP address
> which is more useful for tracing. Should I modify nfsd_cb_recall_any_done
> class to print the IP address from rpc_xprt?

The IP address is recorded by the Call side tracepoints. I'm OK
leaving the IP address out of the Reply side tracepoints.


> -Dai
>=20
>>=20
>>=20
>>> +
>>> #endif /* _NFSD_TRACE_H */
>>>=20
>>> #undef TRACE_INCLUDE_PATH
>>> --=20
>>> 2.9.5
>>>=20
>> --
>> Chuck Lever

--
Chuck Lever



