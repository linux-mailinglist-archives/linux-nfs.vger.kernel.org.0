Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D8D76D6D5
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 20:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjHBSZy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjHBSZx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 14:25:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB0B19AD;
        Wed,  2 Aug 2023 11:25:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HJAYK002378;
        Wed, 2 Aug 2023 18:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IJrfvrhCAZ/5M+wq1v8oDpB/maluqSTXSf7oJULUrj8=;
 b=E6U9nW9MQxUz1vkRAQEnFfbF1LUat8bo1bNpDByeNKNwD6hEoYA4/dPXDZ5qzRSHp8pW
 OgX5DPWYLtCh9vL134quSwWuRlKtWxNuZDzInNJZi9/ISoj5tIml8xn8yX9qY7nDA0nC
 5aKecNdC8pPE7xdiH4IPXDdvT1DBLGHZkmh/BvyvB8CWhZDsX+nV2V5qWDt3FsyMnHGp
 s685YXSaaTRfsuVRDkCE8xZVb+CpS3DGqmCEnH7OjtVLlI6tpQvl5vDwU9X8JpreDuaw
 cGKhL3m27Q+ACprPZ8W5/BK6nSeKld1YnikzVoj1HOczgL+5okjp6lvmLh6Rv6f0iZ6j Lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uauyxrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 18:25:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372IMD8q003866;
        Wed, 2 Aug 2023 18:25:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7eb43a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 18:25:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnqSXYqrMsJ/htLClpDW31O4Noh70SOL9M84XrTT6CsY1TVXhvvtQii0VhPUVHlTzgfSX3IORMdUGhUGWSPMeVo9lxymezhdAF8r75BtBqV8JcvgXUe1qgHcFE8qZweE4Rfzj5y3n1IhtmJwwfqP938p6hh0xjoxTAoPNXZD47Y2gk6Oq+mxhfbi3sGh8jxN0Wc5lzswvp3cRJxSGGhFWp6rxE4T0HWeFaMNXWmzAbKX3ObIswj/IqgcCwD0XnnKtHwn4KYLsh39rfkrFFCx1VyuI9IjQIIlKeKxTOvG+J6saLrJiBfqweqb/kt13q+QesRYuij2BNb3K6bhysvvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJrfvrhCAZ/5M+wq1v8oDpB/maluqSTXSf7oJULUrj8=;
 b=KFxYjGYemaj+jBm/Ab4brD67rApUfeDozDrQFl5OZhEY2s8ZxFE1LVqYXy+4zRNKRwef//LDRFfwzM7bHuTy49OTYmJLdYdHI9sb9htbdmNdNwToJFnOa3IYIUWUtPaR3udpuPmII5QlE72hFqxFN2Ey9VogaYbL2PudQChuWnW/DRk+xTi5pT5dtiQXb6JmvhVqQgbhCmdR4RHmaeLBDp02/c876wCfJsOAxc3oO+3XRKHvojHwWGa3L07lrbTWT+Z7TfttPOrfTyvwy4s3H5mKxAiy0z2ByUDFf4DVb/JYVlQmZvuf99Ji1U6AhrJha6jDNAFb/uvNhN0y2RJctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJrfvrhCAZ/5M+wq1v8oDpB/maluqSTXSf7oJULUrj8=;
 b=IxQYWJiCw/o7ds+/2IZ4otKRiW3D5ZzigFbFbWFWjbOTi16coVIgdKHibbjtkaqaLFE7slpPZWCmvHb6Cc3aREWQVf6jLOzVJXL2htaxcs4VPOf570wM3xRJMqmskLyS6fNc9s8jIcwK4LSETFyIgxn6sT1uvGAfozX3pHvPQ/0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7226.namprd10.prod.outlook.com (2603:10b6:8:ed::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 18:25:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.019; Wed, 2 Aug 2023
 18:25:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
Thread-Topic: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
Thread-Index: AQHZxHzI5IpG8/Fxw02QA37H09j/Q6/XNBSAgAAdtICAAAKigA==
Date:   Wed, 2 Aug 2023 18:25:32 +0000
Message-ID: <00C10519-1916-4ACF-B95D-064CDC130DC4@oracle.com>
References: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
 <8c3adfce-39f0-0e60-e35a-2f1be6fb67e6@oracle.com>
 <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
In-Reply-To: <c9370f6fde62205356f4c864891a3c35ef811877.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB7226:EE_
x-ms-office365-filtering-correlation-id: 5255d85f-0e41-4cb8-a636-08db9385db34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDER9fYtMSJRyp7I7+bDY0CD6PwSohJ9rZ5X63BIZ5jDmrdBVOZU846qyaK/t67vmLgjbS01NFNrMQ8I+pmcRadTx0uLe5Psy74waH93aorCKqezNRPOt16jKbxphEXVP+/VEILl3o5Vm5eX8y42zB+KhjtIb/7cq0087xOzqdE6R1jikI/B2+UbONbNreK/2gzYCgEQZVQKGEH/W1YA+pZMd+dFsraUBOhXqKWcoArY6hORf5tcIL2amMCYEG0zsJaXptsqRbErvO7anAjvhxMcw8cZBHvELSuszixVKAqWK9r1eFXv/or4jOwj/schg3lMAGgmDYvye0HV6wqKf4bl9KBYWHncFJCIYqU9c2bBWItxyXyqpf+RXfM6kzga2qe6TzbtBh+Pk2E8EaNHqI6O3seurSz8nHuPwlnHo1xUDqnJWLqUkrh48aYbs44SIrDJP9PavNIsPzN3TtiZHg/qmU0YXwlAy+PHvV84lkdQHBzwDqPOASmaEyJiD1XdmLzov5VXzC1Jq2i0KCGelcIoPlGQcXSKsi2A2JlaQ/dfsNLGYRXE2JDj4v+Gh7PkaRGJQSxNxJoCxELXcD5Y5SRL0Q5jbP4E/cY19mBLzVe4sNGI1a0FsAcABjMSbl+NNVARXQsvJnO3ma6GZr7hfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(186003)(2616005)(966005)(36756003)(6512007)(316002)(478600001)(86362001)(122000001)(54906003)(66946007)(71200400001)(66446008)(66476007)(66556008)(76116006)(38100700002)(91956017)(64756008)(4326008)(6916009)(6486002)(33656002)(53546011)(6506007)(26005)(41300700001)(5660300002)(8676002)(8936002)(83380400001)(38070700005)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j2qhETEf949ljpqO5sSeYRd4uiHDdMANPmqS+AuRy3t4DLuxr9v6+em5xR6q?=
 =?us-ascii?Q?sU3XjYDeJjj8XPmUrv5EFLl8BeUSoOPSbOSBuxzV+FZcwBZQCp/lPtcMV5Wy?=
 =?us-ascii?Q?GHctWfeSXjajGoOjz3zf9Q2Nxz+bvfwVTGJAufzDnP+NpchaVf/aTu+bvuuq?=
 =?us-ascii?Q?ZKpym2Xf8zmjEsdz+7HkQ4TOqQb0RehriBbPrbafXvl6qmwksNBZYHqrH4Gu?=
 =?us-ascii?Q?NgX/PQUuo7smEf56AS4b1/nLCg274HdwKoYN7rpZgLPuF6EehUwungDub7f3?=
 =?us-ascii?Q?gEHfvy3QeoeqzoXgQqBc5pCEDCuDwLhflDDJo8QA9r/s7rDWpeDwjRrqDusF?=
 =?us-ascii?Q?ssrVU11xjaBg6Jk/VIoHdRG8M6aha4mrlDf34hKBxXvWrmXt3ffA1sKa8+QF?=
 =?us-ascii?Q?NtPKEd7Z2QQXNUnVq3a9vB0Dy/njeCIr3q5GKEZXvugv3uvHdoHsp8mvIRDr?=
 =?us-ascii?Q?Bus6edUyXvBQ9ITachxLmTZcqhyWjxlS0RQ/I0mWOG3OZ8x5SFx6YN+0OjwN?=
 =?us-ascii?Q?vCueeVKPEY6yxz2dTTiNzCaz689u9jFOVFiSurEe8MaSsB6q7faUCKWAWLkN?=
 =?us-ascii?Q?jAajKKdD3QqWU9t0/rnH14gmwdtLCniSOr6P/TgMNQLaW1f2WegjFLMptWgi?=
 =?us-ascii?Q?v+XWeh2hxgyBfGa51E+EXWcb30/hgxf5mL7uKiJ8uGuhQ/L4+Ni/nuUh97jY?=
 =?us-ascii?Q?z7rJnxwJA4gUOrgRHEX2XLpVlJENFDcNPmBeoUL/rJkQki/8o8a7MFz0DIoC?=
 =?us-ascii?Q?MQQIYe0YdfETL55aTy+UNMHv7HOrOH2USlVO+ANecYCGU03c2t2TgiYC2u56?=
 =?us-ascii?Q?Na2OaBSlJF4da+7Xh26Dd3n2MMQhdg/2FggEzaP2otpMdru5JFBMYHzbPPvm?=
 =?us-ascii?Q?UMAjTChWeU31x0Jv39STrElWjLvBppFdYdSILSjU3kBWVjRqjXHexJq26AD2?=
 =?us-ascii?Q?bouMEVbKIPNmeoxxfs8s/W1aR7f71mQyvnozKYfCHYua4PwAGVtZPkLlTJr4?=
 =?us-ascii?Q?6hjyPYRRUC8pd1GfwP4mLvIVzp/90k47lK12RM1qAb756P3zocHGO32OZwNA?=
 =?us-ascii?Q?mddm/gxz2ZpdHCV62/x7b3ONEw/n9bWouwQ35YcP9q/O/sMRPTZXlksKuxgQ?=
 =?us-ascii?Q?yCl1bHBcpymtaep+Kqs59yqh6TonbIug4FZklrTRXEz3uCcYR98NFGQfh68M?=
 =?us-ascii?Q?TbLU794h/XPB2yDxRIewuvJkCJa37Td58RxrUcUNhd09Q+sXUSIRQBUBRHaH?=
 =?us-ascii?Q?5F/1jk9DiEVYcB53E3TQaWNKYJH7tSEScQUzeYMC76U3Hh/HGfIH2V7R7n9l?=
 =?us-ascii?Q?nTy1aLTEj3IGh+VW+pcqB8MvhEmvRLf+sgl+ZfI6tLa/8vnExMaIlHR89GEO?=
 =?us-ascii?Q?DuJ7KYf0LvpEGfTzzC+vJp8ZRX3g8K5eUyhoH1IzBJ+SxdZ4wf/UR95fFBRl?=
 =?us-ascii?Q?SpcCyaXHLvt0HdpWMYtwCxGFBUx8SE3fzK8EU3aLROKqYKWpGlk7hqn6CDP6?=
 =?us-ascii?Q?pW1BvPfyAgmG/CttBqmhtbgcpJtjyQPDzyALetxCjhxsXr5mOKSJuyzt22ig?=
 =?us-ascii?Q?FtKyLsR4RsgbwatCzf3T6ZeXUHvUpnl/G4kH1FdVKLKdWN3qzm1wjd0VbsOU?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <721407E2461F1F459E2B44E9572ED855@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xmyjYZ+Bu3qdBxpjpt7CB4EkYY/VPB9lCMJ4SKG7igZKNYhAubcTTE7Cf4HQBFBsk0ycEntSHxfseq/249Ja3skfPJgookCFp7HXCj6rmtPE3QkALd8B7EcJ2fHBv8h54ZfhEBXaWVy8xKLYe6ZTp9E+9Wwy8lWEIgwWLuj83UnrBRHpBLGvSlj3LmZb9EtK9i9eJNywNTHniQIWHJyZuNMSj6MPjw+0UC3yVP42qM09npn4j/6rFjdErCeH9yz5HX7PDvZCFqVM53geCpWv1ufiJHAL/ka2I3IQn8oE3lgoWHNhnaLYt2qGAcCgjNtwakmLKzFHHt2YOcb+4rKEZeYI0oq5fAskD4kNoUSoNTOP4vtrVeZqAAfNlVV4g2PQmRdH1MWoWQ2yISlJsqEKVb8xRqme0fQV3rPP/vsXBf1LHhIpz9bkl7q2bq4+Vi57Hxjsc0Avo6XWFQHePo82IoJgAdTe7FBSSQxDeZnhjWvTQHBYeqGQQyAOvGdfK4bpy9I+TbL3mxrfQ52Bviru+IffISOq5Hc0qb6sbYmlugAk2i3eg1bzcYWIW5pH9JZxJzUc0vh/e5tkl5gb9UFYnG9baYIngLWBIM1CD5UNa0a9fijmylV8wPNLfUDdDWLr/sKGYeUeWKB1Y2U6MDWT39w0kdoTL13gwK4LA63UZJI2mHTD1meJKFzqfBdbN7wVuglDkuw8GqkiojljQl+vtvyKONOjG+PaoWNedTuAnP44BrWXMsKQJNmPO5IJ+UZUbv4yRwASeWsSrLT+WX1ArzTz/Z99HJxic8RFM7qOA1G69I/NUNu+dMIgNlaj3+0uHUAkQd6ljIG9EzXvLQUZbN0156CXHIG0yZ6RODBPNw7viAOBK0+10ByGYyRsYwok
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5255d85f-0e41-4cb8-a636-08db9385db34
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 18:25:32.0381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MlnSXk2V5WUQf8wmG0mhVnQFGZHq7i1eoech18HdfRBb8KMrDIjPEwX4rEEdD/0uJvfr231CwGcWZbuekJS7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_15,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020163
X-Proofpoint-ORIG-GUID: Lg3yO3VlA5X4EmOnG6PKKy1x9vEvK8jH
X-Proofpoint-GUID: Lg3yO3VlA5X4EmOnG6PKKy1x9vEvK8jH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 2, 2023, at 2:15 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2023-08-02 at 09:29 -0700, dai.ngo@oracle.com wrote:
>> On 8/1/23 6:33 AM, Jeff Layton wrote:
>>> I noticed that xfstests generic/001 was failing against linux-next nfsd=
.
>>>=20
>>> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the serve=
r
>>> would hand out a write delegation. The client would then try to use tha=
t
>>> write delegation as the source stateid in a COPY
>>=20
>> not sure why the client opens the source file of a COPY operation with
>> OPEN4_SHARE_ACCESS_WRITE?
>>=20
>=20
> It doesn't. The original open is to write the data for the file being
> copied. It then opens the file again for READ, but since it has a write
> delegation, it doesn't need to talk to the server at all -- it can just
> use that stateid for later operations.
>=20
>>>  or CLONE operation, and
>>> the server would respond with NFS4ERR_STALE.
>>=20
>> If the server does not allow client to use write delegation for the
>> READ, should the correct error return be NFS4ERR_OPENMODE?
>>=20
>=20
> The server must allow the client to use a write delegation for read
> operations. It's required by the spec, AFAIU.
>=20
> The error in this case was just bogus. The vfs copy routine would return
> -EBADF since the file didn't have FMODE_READ, and the nfs server would
> translate that into NFS4ERR_STALE.
>=20
> Probably there is a better v4 error code that we could translate EBADF
> to, but with this patch it shouldn't be a problem any longer.=20
>=20
>>>=20
>>> The problem is that the struct file associated with the delegation does
>>> not necessarily have read permissions. It's handing out a write
>>> delegation on what is effectively an O_WRONLY open. RFC 8881 states:
>>>=20
>>>  "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>>>   own, all opens."
>>>=20
>>> Given that the client didn't request any read permissions, and that nfs=
d
>>> didn't check for any, it seems wrong to give out a write delegation.
>>>=20
>>> Only hand out a write delegation if we have a O_RDWR descriptor
>>> available. If it fails to find an appropriate write descriptor, go
>>> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
>>> requested.
>>>=20
>>> This fixes xfstest generic/001.
>>>=20
>>> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D412
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> Changes in v2:
>>> - Rework the logic when finding struct file for the delegation. The
>>>   earlier patch might still have attached a O_WRONLY file to the deleg
>>>   in some cases, and could still have handed out a write delegation on
>>>   an O_WRONLY OPEN request in some cases.
>>> ---
>>>  fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
>>>  1 file changed, 18 insertions(+), 11 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index ef7118ebee00..e79d82fd05e7 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
>>>   struct nfs4_file *fp =3D stp->st_stid.sc_file;
>>>   struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
>>>   struct nfs4_delegation *dp;
>>> - struct nfsd_file *nf;
>>> + struct nfsd_file *nf =3D NULL;
>>>   struct file_lock *fl;
>>>   u32 dl_type;
>>>=20
>>> @@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, st=
ruct nfs4_ol_stateid *stp,
>>>   if (fp->fi_had_conflict)
>>>   return ERR_PTR(-EAGAIN);
>>>=20
>>> - if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>> - nf =3D find_writeable_file(fp);
>>> + /*
>>> +  * Try for a write delegation first. We need an O_RDWR file
>>> +  * since a write delegation allows the client to perform any open
>>> +  * from its cache.

Since you're sending a v3... can you cite the section of RFC 8881
that specifies this "all open" case in this commment? I'm sure we're
all going to forget this requirement.


>>> +  */
>>> + if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_SHAR=
E_ACCESS_BOTH) {
>>> + nf =3D nfsd_file_get(fp->fi_fds[O_RDWR]);
>>>   dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
>>> - } else {
>>=20
>> Does this mean OPEN4_SHARE_ACCESS_WRITE do not get a write delegation?
>> It does not seem right.
>>=20
>> -Dai
>>=20
>=20
> Why? Per RFC 8881:
>=20
> "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
> own, all opens."
>=20
> All opens. That includes read opens.
>=20
> An OPEN4_SHARE_ACCESS_WRITE open will succeed on a file to which the
> user has no read permissions. Therefore, we can't grant a write
> delegation since can't guarantee that the user is allowed to do that.
>=20
>=20
>>> + }
>>> +
>>> + /*
>>> +  * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
>>> +  * file for some reason, then try for a read deleg instead.
>>> +  */
>>> + if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>>>   nf =3D find_readable_file(fp);
>>>   dl_type =3D NFS4_OPEN_DELEGATE_READ;
>>>   }
>>> - if (!nf) {
>>> - /*
>>> -  * We probably could attempt another open and get a read
>>> -  * delegation, but for now, don't bother until the
>>> -  * client actually sends us one.
>>> -  */
>>> +
>>> + if (!nf)
>>>   return ERR_PTR(-EAGAIN);
>>> - }
>>> +
>>>   spin_lock(&state_lock);
>>>   spin_lock(&fp->fi_lock);
>>>   if (nfs4_delegation_exists(clp, fp))
>>>=20
>>> ---
>>> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
>>> change-id: 20230731-wdeleg-bbdb6b25a3c6
>>>=20
>>> Best regards,
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


